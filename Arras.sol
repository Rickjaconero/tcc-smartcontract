// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {FunctionsClient} from "@chainlink/contracts@1.2.0/src/v0.8/functions/v1_0_0/FunctionsClient.sol";
import {FunctionsRequest} from "@chainlink/contracts@1.2.0/src/v0.8/functions/v1_0_0/libraries/FunctionsRequest.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Arras is FunctionsClient{
    using FunctionsRequest for FunctionsRequest.Request;

    struct ContratoArras{
        uint16 renavam;
        string placa;
        address carteiraComprador;
        address carteiraVendedor;
        string cpfComprador;
        string cpfVendedor;
    	uint valorArras;
        uint valorTotal;
        uint dataInicial;
        uint prazoDias;
        bool pago;
    }

    address public owner;
    address router = 0xb83E47C2bC239B3bf370bc41e1459A34b41238D0;
    bytes32 donID = 0x66756e2d657468657265756d2d7365706f6c69612d3100000000000000000000;
    uint32 gasLimit = 300000;
    uint64 subscriptionId;

    ContratoArras[] public contratosArras;

    string requisicaoDenatran =
        "const cpf = args[0];"
        "const placa = args[1];"
        "const renavam = args[2];"
        "const apiResponse = await Functions.makeHttpRequest({"
        "  url: `https://api.ricardoguimaraes.dev/v1/veiculos/proprietario/cpf/${cpf}/placa/${placa}/renavam/${renavam}`"
        "})"
        "if (apiResponse.error) "
        "  return Functions.encodeUint256(500);"
        "const { data } = apiResponse;"
        "return Functions.encodeUint256(data.renavam !== null ? 200 : 204);";

    constructor(uint64 _subscriptionId) FunctionsClient(router){
        owner = msg.sender;
        subscriptionId = _subscriptionId;
    }

    function iniciarCompra(uint16 _renavam,
        string memory _placa,
        string memory _cpfComprador,
        string memory _cpfVendedor,
        uint _valorTotal,
        uint8 _prazoDias) public payable {
        
        require(validaCpf(_cpfComprador));
        require(validaCpf(_cpfVendedor));

        ContratoArras memory contrato;
        contrato.renavam = _renavam;
        contrato.placa = _placa;
        contrato.carteiraVendedor = msg.sender;
        contrato.cpfComprador = _cpfComprador;
        contrato.cpfVendedor = _cpfVendedor;
        contrato.valorArras = msg.value;
        contrato.valorTotal = _valorTotal;
        contrato.pago = false;
        contrato.prazoDias = block.timestamp + _prazoDias *24*60*60;
        contrato.dataInicial = block.timestamp;

        contratosArras.push(contrato);
    }

    function enviarArrasComprador(uint16 _renavam,
        string memory _placa) public payable {
        
        uint i = encontraContrato(_renavam, _placa);
        
        contratosArras[i].carteiraComprador = msg.sender;
    }

    function pagarValorTotalComprador(uint16 _renavam,
        string memory _placa) public payable {
        
        uint i = encontraContrato(_renavam, _placa);

        require(contratosArras[i].carteiraComprador == msg.sender);
        require(contratosArras[i].valorTotal == msg.value);

        contratosArras[i].pago = true;
    }

    function verificaContrato(uint16 _renavam,
        string memory _placa) public {
        
        uint i = encontraContrato(_renavam, _placa);

        if(contratosArras[i].carteiraComprador != 0x0000000000000000000000000000000000000000 &&
           contratosArras[i].dataInicial + 24*60*60 < block.timestamp ){
            
            (bool sent, bytes memory data) = contratosArras[i].carteiraComprador.call{value: contratosArras[i].valorArras}("");
            require(sent, "Failed to send Ether");

            removeContrato(i);

            return;
        }

        if(contratosArras[i].prazoDias < block.timestamp && !contratosArras[i].pago){
            
            uint valorReembolso = contratosArras[i].valorArras * 2;

            (bool sent, bytes memory data) = contratosArras[i].carteiraVendedor.call{value: valorReembolso}("");
            require(sent, "Failed to send Ether");
            
            removeContrato(i);
        }
    }

    function cancelaContratoVendedor(uint16 _renavam,
        string memory _placa) public payable {
        
        uint i = encontraContrato(_renavam, _placa);

        require(contratosArras[i].carteiraVendedor == msg.sender);
        require(contratosArras[i].carteiraComprador != 0x0000000000000000000000000000000000000000);

        uint valorReembolso = contratosArras[i].valorArras * 2;

        (bool sent, bytes memory data) = contratosArras[i].carteiraComprador.call{value: valorReembolso}("");
        require(sent, "Failed to send Ether");

        removeContrato(i);
    }

    function cancelaContratoComprador(uint16 _renavam,
        string memory _placa) public payable {
        
        uint i = encontraContrato(_renavam, _placa);

        require(contratosArras[i].carteiraComprador == msg.sender);

        uint valorReembolso = contratosArras[i].valorArras * 2;

        (bool sent, bytes memory data) = contratosArras[i].carteiraVendedor.call{value: valorReembolso}("");
        require(sent, "Failed to send Ether");
        
        removeContrato(i);
    }

    function transfer(address _to, uint256 amount) public payable {
        require(msg.sender==owner);

        (bool sent, bytes memory data) = _to.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    function encontraContrato(uint16 _renavam,
        string memory _placa) internal view returns (uint){
        
        bool contratoEncontrado = false;

        for (uint i = 0; i < contratosArras.length; i++) 
        {
            if (contratosArras[i].renavam == _renavam &&
               keccak256(bytes(contratosArras[i].placa)) == keccak256(bytes(_placa))){
                return i;
            }
        }

        require(contratoEncontrado);
        return 0;
    }

    function removeContrato(uint _index) public {
        
        require(_index < contratosArras.length);

        for (uint i = _index; i < contratosArras.length - 1; i++) {
            contratosArras[i] = contratosArras[i + 1];
        }

        contratosArras.pop();
    }

    function validaCpf(string memory cpf) internal pure returns (bool) {
        
        bytes memory cpfBytes = bytes(cpf);
        
        if (cpfBytes.length != 11)
            return false;

        for (uint8 i = 0; i < 10; i++) {
            string memory aux = Strings.toString(i);

            bytes memory cpfValorRepetido = abi.encodePacked(aux,aux,aux,aux,aux,aux,aux,aux,aux,aux,aux);

            if(keccak256(cpfBytes) == keccak256(cpfValorRepetido))
                return false;
        }

        uint soma = 0;
        uint8 j = 10;

        for (uint8 i = 0; i < 9; i++)
            soma += (uint8(cpfBytes[i]) - 48) * j--;

        uint resto = soma % 11;
        
        resto = resto < 2 ? 0 : 11 - resto;
        
        if (uint8(cpfBytes[9]) - 48 != resto)
            return false;

        soma = 0;
        j = 11;

        for (uint8 i = 0; i < 10; i++)
            soma += (uint8(cpfBytes[i]) - 48) * j--;

        resto = soma % 11;
        
        resto = resto < 2 ? 0 : 11 - resto;

        return uint8(cpfBytes[10]) - 48 == resto;
    }

    function fulfillRequest(
        bytes32 requestId,
        bytes memory response,
        bytes memory err
    ) internal override {
        
    }
}