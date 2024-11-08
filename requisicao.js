const cpf = args[0];
const placa = args[1];
const renavam = args[2];

const apiResponse = await Functions.makeHttpRequest({
  url: `https://api.ricardoguimaraes.dev/v1/veiculos/proprietario/cpf/${cpf}/placa/${placa}/renavam/${renavam}`
})

if (apiResponse.error) 
  return Functions.encodeUint256(500);

const { data } = apiResponse;

console.log('API response data:', JSON.stringify(data, null, 2));

return Functions.encodeUint256(data.renavam !== null ? 200 : 204);