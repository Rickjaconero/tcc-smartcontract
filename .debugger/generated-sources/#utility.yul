{

    function allocate_unbounded() -> memPtr {
        memPtr := mload(64)
    }

    function revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() {
        revert(0, 0)
    }

    function revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() {
        revert(0, 0)
    }

    function revert_error_1b9f4a0a5773e33b91aa01db23bf8c55fce1411167c872835e7fa00a4f17d46d() {
        revert(0, 0)
    }

    function revert_error_987264b3b1d58a9c7f8255e93e81c77d86d6299019c33110a076957a3e06e2ae() {
        revert(0, 0)
    }

    function round_up_to_mul_of_32(value) -> result {
        result := and(add(value, 31), not(31))
    }

    function panic_error_0x41() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x41)
        revert(0, 0x24)
    }

    function finalize_allocation(memPtr, size) {
        let newFreePtr := add(memPtr, round_up_to_mul_of_32(size))
        // protect against overflow
        if or(gt(newFreePtr, 0xffffffffffffffff), lt(newFreePtr, memPtr)) { panic_error_0x41() }
        mstore(64, newFreePtr)
    }

    function allocate_memory(size) -> memPtr {
        memPtr := allocate_unbounded()
        finalize_allocation(memPtr, size)
    }

    function array_allocation_size_t_string_memory_ptr(length) -> size {
        // Make sure we can allocate memory without overflow
        if gt(length, 0xffffffffffffffff) { panic_error_0x41() }

        size := round_up_to_mul_of_32(length)

        // add length slot
        size := add(size, 0x20)

    }

    function copy_calldata_to_memory_with_cleanup(src, dst, length) {

        calldatacopy(dst, src, length)
        mstore(add(dst, length), 0)

    }

    function abi_decode_available_length_t_string_memory_ptr(src, length, end) -> array {
        array := allocate_memory(array_allocation_size_t_string_memory_ptr(length))
        mstore(array, length)
        let dst := add(array, 0x20)
        if gt(add(src, length), end) { revert_error_987264b3b1d58a9c7f8255e93e81c77d86d6299019c33110a076957a3e06e2ae() }
        copy_calldata_to_memory_with_cleanup(src, dst, length)
    }

    // string
    function abi_decode_t_string_memory_ptr(offset, end) -> array {
        if iszero(slt(add(offset, 0x1f), end)) { revert_error_1b9f4a0a5773e33b91aa01db23bf8c55fce1411167c872835e7fa00a4f17d46d() }
        let length := calldataload(offset)
        array := abi_decode_available_length_t_string_memory_ptr(add(offset, 0x20), length, end)
    }

    function abi_decode_tuple_t_string_memory_ptrt_string_memory_ptr(headStart, dataEnd) -> value0, value1 {
        if slt(sub(dataEnd, headStart), 64) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := calldataload(add(headStart, 0))
            if gt(offset, 0xffffffffffffffff) { revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() }

            value0 := abi_decode_t_string_memory_ptr(add(headStart, offset), dataEnd)
        }

        {

            let offset := calldataload(add(headStart, 32))
            if gt(offset, 0xffffffffffffffff) { revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() }

            value1 := abi_decode_t_string_memory_ptr(add(headStart, offset), dataEnd)
        }

    }

    function cleanup_t_bytes32(value) -> cleaned {
        cleaned := value
    }

    function validator_revert_t_bytes32(value) {
        if iszero(eq(value, cleanup_t_bytes32(value))) { revert(0, 0) }
    }

    function abi_decode_t_bytes32(offset, end) -> value {
        value := calldataload(offset)
        validator_revert_t_bytes32(value)
    }

    function array_allocation_size_t_bytes_memory_ptr(length) -> size {
        // Make sure we can allocate memory without overflow
        if gt(length, 0xffffffffffffffff) { panic_error_0x41() }

        size := round_up_to_mul_of_32(length)

        // add length slot
        size := add(size, 0x20)

    }

    function abi_decode_available_length_t_bytes_memory_ptr(src, length, end) -> array {
        array := allocate_memory(array_allocation_size_t_bytes_memory_ptr(length))
        mstore(array, length)
        let dst := add(array, 0x20)
        if gt(add(src, length), end) { revert_error_987264b3b1d58a9c7f8255e93e81c77d86d6299019c33110a076957a3e06e2ae() }
        copy_calldata_to_memory_with_cleanup(src, dst, length)
    }

    // bytes
    function abi_decode_t_bytes_memory_ptr(offset, end) -> array {
        if iszero(slt(add(offset, 0x1f), end)) { revert_error_1b9f4a0a5773e33b91aa01db23bf8c55fce1411167c872835e7fa00a4f17d46d() }
        let length := calldataload(offset)
        array := abi_decode_available_length_t_bytes_memory_ptr(add(offset, 0x20), length, end)
    }

    function abi_decode_tuple_t_bytes32t_bytes_memory_ptrt_bytes_memory_ptr(headStart, dataEnd) -> value0, value1, value2 {
        if slt(sub(dataEnd, headStart), 96) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := 0

            value0 := abi_decode_t_bytes32(add(headStart, offset), dataEnd)
        }

        {

            let offset := calldataload(add(headStart, 32))
            if gt(offset, 0xffffffffffffffff) { revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() }

            value1 := abi_decode_t_bytes_memory_ptr(add(headStart, offset), dataEnd)
        }

        {

            let offset := calldataload(add(headStart, 64))
            if gt(offset, 0xffffffffffffffff) { revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() }

            value2 := abi_decode_t_bytes_memory_ptr(add(headStart, offset), dataEnd)
        }

    }

    function cleanup_t_uint256(value) -> cleaned {
        cleaned := value
    }

    function validator_revert_t_uint256(value) {
        if iszero(eq(value, cleanup_t_uint256(value))) { revert(0, 0) }
    }

    function abi_decode_t_uint256(offset, end) -> value {
        value := calldataload(offset)
        validator_revert_t_uint256(value)
    }

    function abi_decode_tuple_t_uint256(headStart, dataEnd) -> value0 {
        if slt(sub(dataEnd, headStart), 32) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := 0

            value0 := abi_decode_t_uint256(add(headStart, offset), dataEnd)
        }

    }

    function cleanup_t_uint160(value) -> cleaned {
        cleaned := and(value, 0xffffffffffffffffffffffffffffffffffffffff)
    }

    function cleanup_t_address(value) -> cleaned {
        cleaned := cleanup_t_uint160(value)
    }

    function abi_encode_t_address_to_t_address_fromStack(value, pos) {
        mstore(pos, cleanup_t_address(value))
    }

    function abi_encode_tuple_t_address__to_t_address__fromStack_reversed(headStart , value0) -> tail {
        tail := add(headStart, 32)

        abi_encode_t_address_to_t_address_fromStack(value0,  add(headStart, 0))

    }

    function validator_revert_t_address(value) {
        if iszero(eq(value, cleanup_t_address(value))) { revert(0, 0) }
    }

    function abi_decode_t_address(offset, end) -> value {
        value := calldataload(offset)
        validator_revert_t_address(value)
    }

    function abi_decode_tuple_t_addresst_uint256(headStart, dataEnd) -> value0, value1 {
        if slt(sub(dataEnd, headStart), 64) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := 0

            value0 := abi_decode_t_address(add(headStart, offset), dataEnd)
        }

        {

            let offset := 32

            value1 := abi_decode_t_uint256(add(headStart, offset), dataEnd)
        }

    }

    function array_length_t_string_memory_ptr(value) -> length {

        length := mload(value)

    }

    function array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, length) -> updated_pos {
        mstore(pos, length)
        updated_pos := add(pos, 0x20)
    }

    function copy_memory_to_memory_with_cleanup(src, dst, length) {

        mcopy(dst, src, length)
        mstore(add(dst, length), 0)

    }

    function abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value, pos) -> end {
        let length := array_length_t_string_memory_ptr(value)
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, length)
        copy_memory_to_memory_with_cleanup(add(value, 0x20), pos, length)
        end := add(pos, round_up_to_mul_of_32(length))
    }

    function abi_encode_t_uint256_to_t_uint256_fromStack(value, pos) {
        mstore(pos, cleanup_t_uint256(value))
    }

    function cleanup_t_bool(value) -> cleaned {
        cleaned := iszero(iszero(value))
    }

    function abi_encode_t_bool_to_t_bool_fromStack(value, pos) {
        mstore(pos, cleanup_t_bool(value))
    }

    function abi_encode_tuple_t_string_memory_ptr_t_string_memory_ptr_t_address_t_address_t_string_memory_ptr_t_string_memory_ptr_t_uint256_t_uint256_t_uint256_t_uint256_t_bool__to_t_string_memory_ptr_t_string_memory_ptr_t_address_t_address_t_string_memory_ptr_t_string_memory_ptr_t_uint256_t_uint256_t_uint256_t_uint256_t_bool__fromStack_reversed(headStart , value10, value9, value8, value7, value6, value5, value4, value3, value2, value1, value0) -> tail {
        tail := add(headStart, 352)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value0,  tail)

        mstore(add(headStart, 32), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value1,  tail)

        abi_encode_t_address_to_t_address_fromStack(value2,  add(headStart, 64))

        abi_encode_t_address_to_t_address_fromStack(value3,  add(headStart, 96))

        mstore(add(headStart, 128), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value4,  tail)

        mstore(add(headStart, 160), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value5,  tail)

        abi_encode_t_uint256_to_t_uint256_fromStack(value6,  add(headStart, 192))

        abi_encode_t_uint256_to_t_uint256_fromStack(value7,  add(headStart, 224))

        abi_encode_t_uint256_to_t_uint256_fromStack(value8,  add(headStart, 256))

        abi_encode_t_uint256_to_t_uint256_fromStack(value9,  add(headStart, 288))

        abi_encode_t_bool_to_t_bool_fromStack(value10,  add(headStart, 320))

    }

    function cleanup_t_uint8(value) -> cleaned {
        cleaned := and(value, 0xff)
    }

    function validator_revert_t_uint8(value) {
        if iszero(eq(value, cleanup_t_uint8(value))) { revert(0, 0) }
    }

    function abi_decode_t_uint8(offset, end) -> value {
        value := calldataload(offset)
        validator_revert_t_uint8(value)
    }

    function abi_decode_tuple_t_string_memory_ptrt_string_memory_ptrt_string_memory_ptrt_string_memory_ptrt_uint256t_uint8(headStart, dataEnd) -> value0, value1, value2, value3, value4, value5 {
        if slt(sub(dataEnd, headStart), 192) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := calldataload(add(headStart, 0))
            if gt(offset, 0xffffffffffffffff) { revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() }

            value0 := abi_decode_t_string_memory_ptr(add(headStart, offset), dataEnd)
        }

        {

            let offset := calldataload(add(headStart, 32))
            if gt(offset, 0xffffffffffffffff) { revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() }

            value1 := abi_decode_t_string_memory_ptr(add(headStart, offset), dataEnd)
        }

        {

            let offset := calldataload(add(headStart, 64))
            if gt(offset, 0xffffffffffffffff) { revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() }

            value2 := abi_decode_t_string_memory_ptr(add(headStart, offset), dataEnd)
        }

        {

            let offset := calldataload(add(headStart, 96))
            if gt(offset, 0xffffffffffffffff) { revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() }

            value3 := abi_decode_t_string_memory_ptr(add(headStart, offset), dataEnd)
        }

        {

            let offset := 128

            value4 := abi_decode_t_uint256(add(headStart, offset), dataEnd)
        }

        {

            let offset := 160

            value5 := abi_decode_t_uint8(add(headStart, offset), dataEnd)
        }

    }

    function panic_error_0x32() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x32)
        revert(0, 0x24)
    }

    function panic_error_0x11() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x11)
        revert(0, 0x24)
    }

    function checked_add_t_uint256(x, y) -> sum {
        x := cleanup_t_uint256(x)
        y := cleanup_t_uint256(y)
        sum := add(x, y)

        if gt(x, sum) { panic_error_0x11() }

    }

    function array_storeLengthForEncoding_t_bytes_memory_ptr_nonPadded_inplace_fromStack(pos, length) -> updated_pos {
        updated_pos := pos
    }

    function store_literal_in_memory_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470(memPtr) {

    }

    function abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_bytes_memory_ptr_nonPadded_inplace_fromStack(pos, 0)
        store_literal_in_memory_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470(pos)
        end := add(pos, 0)
    }

    function abi_encode_tuple_packed_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470__to_t_bytes_memory_ptr__nonPadded_inplace_fromStack_reversed(pos ) -> end {

        pos := abi_encode_t_stringliteral_c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack( pos)

        end := pos
    }

    function store_literal_in_memory_445140255c9d889994129d349e64078d6f76b4b37ec896948f7e858f9b8a0dcb(memPtr) {

        mstore(add(memPtr, 0), "Failed to send Ether")

    }

    function abi_encode_t_stringliteral_445140255c9d889994129d349e64078d6f76b4b37ec896948f7e858f9b8a0dcb_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 20)
        store_literal_in_memory_445140255c9d889994129d349e64078d6f76b4b37ec896948f7e858f9b8a0dcb(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_445140255c9d889994129d349e64078d6f76b4b37ec896948f7e858f9b8a0dcb__to_t_string_memory_ptr__fromStack_reversed(headStart ) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_445140255c9d889994129d349e64078d6f76b4b37ec896948f7e858f9b8a0dcb_to_t_string_memory_ptr_fromStack( tail)

    }

    function checked_mul_t_uint256(x, y) -> product {
        x := cleanup_t_uint256(x)
        y := cleanup_t_uint256(y)
        let product_raw := mul(x, y)
        product := cleanup_t_uint256(product_raw)

        // overflow, if x != 0 and y != product/x
        if iszero(
            or(
                iszero(x),
                eq(y, div(product, x))
            )
        ) { panic_error_0x11() }

    }

    function panic_error_0x22() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x22)
        revert(0, 0x24)
    }

    function extract_byte_array_length(data) -> length {
        length := div(data, 2)
        let outOfPlaceEncoding := and(data, 1)
        if iszero(outOfPlaceEncoding) {
            length := and(length, 0x7f)
        }

        if eq(outOfPlaceEncoding, lt(length, 32)) {
            panic_error_0x22()
        }
    }

    function checked_sub_t_uint256(x, y) -> diff {
        x := cleanup_t_uint256(x)
        y := cleanup_t_uint256(y)
        diff := sub(x, y)

        if gt(diff, x) { panic_error_0x11() }

    }

    function array_length_t_string_storage(value) -> length {

        length := sload(value)

        length := extract_byte_array_length(length)

    }

    function array_dataslot_t_string_storage(ptr) -> data {
        data := ptr

        mstore(0, ptr)
        data := keccak256(0, 0x20)

    }

    function divide_by_32_ceil(value) -> result {
        result := div(add(value, 31), 32)
    }

    function shift_left_dynamic(bits, value) -> newValue {
        newValue :=

        shl(bits, value)

    }

    function update_byte_slice_dynamic32(value, shiftBytes, toInsert) -> result {
        let shiftBits := mul(shiftBytes, 8)
        let mask := shift_left_dynamic(shiftBits, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
        toInsert := shift_left_dynamic(shiftBits, toInsert)
        value := and(value, not(mask))
        result := or(value, and(toInsert, mask))
    }

    function identity(value) -> ret {
        ret := value
    }

    function convert_t_uint256_to_t_uint256(value) -> converted {
        converted := cleanup_t_uint256(identity(cleanup_t_uint256(value)))
    }

    function prepare_store_t_uint256(value) -> ret {
        ret := value
    }

    function update_storage_value_t_uint256_to_t_uint256(slot, offset, value_0) {
        let convertedValue_0 := convert_t_uint256_to_t_uint256(value_0)
        sstore(slot, update_byte_slice_dynamic32(sload(slot), offset, prepare_store_t_uint256(convertedValue_0)))
    }

    function zero_value_for_split_t_uint256() -> ret {
        ret := 0
    }

    function storage_set_to_zero_t_uint256(slot, offset) {
        let zero_0 := zero_value_for_split_t_uint256()
        update_storage_value_t_uint256_to_t_uint256(slot, offset, zero_0)
    }

    function clear_storage_range_t_bytes1(start, end) {
        for {} lt(start, end) { start := add(start, 1) }
        {
            storage_set_to_zero_t_uint256(start, 0)
        }
    }

    function clean_up_bytearray_end_slots_t_string_storage(array, len, startIndex) {

        if gt(len, 31) {
            let dataArea := array_dataslot_t_string_storage(array)
            let deleteStart := add(dataArea, divide_by_32_ceil(startIndex))
            // If we are clearing array to be short byte array, we want to clear only data starting from array data area.
            if lt(startIndex, 32) { deleteStart := dataArea }
            clear_storage_range_t_bytes1(deleteStart, add(dataArea, divide_by_32_ceil(len)))
        }

    }

    function shift_right_unsigned_dynamic(bits, value) -> newValue {
        newValue :=

        shr(bits, value)

    }

    function mask_bytes_dynamic(data, bytes) -> result {
        let mask := not(shift_right_unsigned_dynamic(mul(8, bytes), not(0)))
        result := and(data, mask)
    }
    function extract_used_part_and_set_length_of_short_byte_array(data, len) -> used {
        // we want to save only elements that are part of the array after resizing
        // others should be set to zero
        data := mask_bytes_dynamic(data, len)
        used := or(data, mul(2, len))
    }
    function copy_byte_array_to_storage_from_t_string_storage_to_t_string_storage(slot, src) {
        if eq(slot, src) { leave }

        let newLen := array_length_t_string_storage(src)
        // Make sure array length is sane
        if gt(newLen, 0xffffffffffffffff) { panic_error_0x41() }

        let oldLen := extract_byte_array_length(sload(slot))

        // potentially truncate data
        clean_up_bytearray_end_slots_t_string_storage(slot, oldLen, newLen)

        let srcOffset := 0

        switch gt(newLen, 31)
        case 1 {
            let loopEnd := and(newLen, not(0x1f))
            src := array_dataslot_t_string_storage(src)
            let dstPtr := array_dataslot_t_string_storage(slot)
            let i := 0
            for { } lt(i, loopEnd) { i := add(i, 0x20) } {
                sstore(dstPtr, sload(add(src, srcOffset)))
                dstPtr := add(dstPtr, 1)
                srcOffset := add(srcOffset, 1)
            }
            if lt(loopEnd, newLen) {
                let lastValue := sload(add(src, srcOffset))
                sstore(dstPtr, mask_bytes_dynamic(lastValue, and(newLen, 0x1f)))
            }
            sstore(slot, add(mul(newLen, 2), 1))
        }
        default {
            let value := 0
            if newLen {
                value := sload(add(src, srcOffset))
            }
            sstore(slot, extract_used_part_and_set_length_of_short_byte_array(value, newLen))
        }
    }

    function panic_error_0x31() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x31)
        revert(0, 0x24)
    }

    function checked_mul_t_uint8(x, y) -> product {
        x := cleanup_t_uint8(x)
        y := cleanup_t_uint8(y)
        let product_raw := mul(x, y)
        product := cleanup_t_uint8(product_raw)

        if iszero(eq(product, product_raw)) { panic_error_0x11() }

    }

    function copy_byte_array_to_storage_from_t_string_memory_ptr_to_t_string_storage(slot, src) {

        let newLen := array_length_t_string_memory_ptr(src)
        // Make sure array length is sane
        if gt(newLen, 0xffffffffffffffff) { panic_error_0x41() }

        let oldLen := extract_byte_array_length(sload(slot))

        // potentially truncate data
        clean_up_bytearray_end_slots_t_string_storage(slot, oldLen, newLen)

        let srcOffset := 0

        srcOffset := 0x20

        switch gt(newLen, 31)
        case 1 {
            let loopEnd := and(newLen, not(0x1f))

            let dstPtr := array_dataslot_t_string_storage(slot)
            let i := 0
            for { } lt(i, loopEnd) { i := add(i, 0x20) } {
                sstore(dstPtr, mload(add(src, srcOffset)))
                dstPtr := add(dstPtr, 1)
                srcOffset := add(srcOffset, 32)
            }
            if lt(loopEnd, newLen) {
                let lastValue := mload(add(src, srcOffset))
                sstore(dstPtr, mask_bytes_dynamic(lastValue, and(newLen, 0x1f)))
            }
            sstore(slot, add(mul(newLen, 2), 1))
        }
        default {
            let value := 0
            if newLen {
                value := mload(add(src, srcOffset))
            }
            sstore(slot, extract_used_part_and_set_length_of_short_byte_array(value, newLen))
        }
    }

    function abi_encode_tuple_t_string_memory_ptr_t_uint256_t_string_memory_ptr__to_t_string_memory_ptr_t_uint256_t_string_memory_ptr__fromStack_reversed(headStart , value2, value1, value0) -> tail {
        tail := add(headStart, 96)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value0,  tail)

        abi_encode_t_uint256_to_t_uint256_fromStack(value1,  add(headStart, 32))

        mstore(add(headStart, 64), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value2,  tail)

    }

    function array_dataslot_t_bytes_storage_ptr(ptr) -> data {
        data := ptr

        mstore(0, ptr)
        data := keccak256(0, 0x20)

    }

    // bytes -> bytes
    function abi_encode_t_bytes_storage_ptr_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack(value, pos) -> ret {
        let slotValue := sload(value)
        let length := extract_byte_array_length(slotValue)
        pos := array_storeLengthForEncoding_t_bytes_memory_ptr_nonPadded_inplace_fromStack(pos, length)
        switch and(slotValue, 1)
        case 0 {
            // short byte array
            mstore(pos, and(slotValue, not(0xff)))
            ret := add(pos, mul(length, iszero(iszero(length))))
        }
        case 1 {
            // long byte array
            let dataPos := array_dataslot_t_bytes_storage_ptr(value)
            let i := 0
            for { } lt(i, length) { i := add(i, 0x20) } {
                mstore(add(pos, i), sload(dataPos))
                dataPos := add(dataPos, 1)
            }
            ret := add(pos, length)
        }
    }

    function abi_encode_tuple_packed_t_bytes_storage_ptr__to_t_bytes_memory_ptr__nonPadded_inplace_fromStack_reversed(pos , value0) -> end {

        pos := abi_encode_t_bytes_storage_ptr_to_t_bytes_memory_ptr_nonPadded_inplace_fromStack(value0,  pos)

        end := pos
    }

    function array_length_t_bytes_memory_ptr(value) -> length {

        length := mload(value)

    }

    function array_dataslot_t_bytes_memory_ptr(ptr) -> data {
        data := ptr

        data := add(ptr, 0x20)

    }

    function read_from_memoryt_bytes32(ptr) -> returnValue {

        let value := cleanup_t_bytes32(mload(ptr))

        returnValue :=

        value

    }

    function convert_bytes_to_fixedbytes_from_t_bytes_memory_ptr_to_t_bytes32(array) -> value {

        let length := array_length_t_bytes_memory_ptr(array)
        let dataArea := array

        dataArea := array_dataslot_t_bytes_memory_ptr(array)

        value := read_from_memoryt_bytes32(dataArea)

        if lt(length, 32) {
            value := and(
                value,
                shift_left_dynamic(
                    mul(8, sub(32, length)),
                    0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
                )
            )
        }

    }

    function panic_error_0x21() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x21)
        revert(0, 0x24)
    }

    function cleanup_t_uint64(value) -> cleaned {
        cleaned := and(value, 0xffffffffffffffff)
    }

    function abi_encode_t_uint64_to_t_uint64_fromStack(value, pos) {
        mstore(pos, cleanup_t_uint64(value))
    }

    function array_storeLengthForEncoding_t_bytes_memory_ptr_fromStack(pos, length) -> updated_pos {
        mstore(pos, length)
        updated_pos := add(pos, 0x20)
    }

    function abi_encode_t_bytes_memory_ptr_to_t_bytes_memory_ptr_fromStack(value, pos) -> end {
        let length := array_length_t_bytes_memory_ptr(value)
        pos := array_storeLengthForEncoding_t_bytes_memory_ptr_fromStack(pos, length)
        copy_memory_to_memory_with_cleanup(add(value, 0x20), pos, length)
        end := add(pos, round_up_to_mul_of_32(length))
    }

    function cleanup_t_uint16(value) -> cleaned {
        cleaned := and(value, 0xffff)
    }

    function abi_encode_t_uint16_to_t_uint16_fromStack(value, pos) {
        mstore(pos, cleanup_t_uint16(value))
    }

    function cleanup_t_uint32(value) -> cleaned {
        cleaned := and(value, 0xffffffff)
    }

    function abi_encode_t_uint32_to_t_uint32_fromStack(value, pos) {
        mstore(pos, cleanup_t_uint32(value))
    }

    function abi_encode_t_bytes32_to_t_bytes32_fromStack(value, pos) {
        mstore(pos, cleanup_t_bytes32(value))
    }

    function abi_encode_tuple_t_uint64_t_bytes_memory_ptr_t_uint16_t_uint32_t_bytes32__to_t_uint64_t_bytes_memory_ptr_t_uint16_t_uint32_t_bytes32__fromStack_reversed(headStart , value4, value3, value2, value1, value0) -> tail {
        tail := add(headStart, 160)

        abi_encode_t_uint64_to_t_uint64_fromStack(value0,  add(headStart, 0))

        mstore(add(headStart, 32), sub(tail, headStart))
        tail := abi_encode_t_bytes_memory_ptr_to_t_bytes_memory_ptr_fromStack(value1,  tail)

        abi_encode_t_uint16_to_t_uint16_fromStack(value2,  add(headStart, 64))

        abi_encode_t_uint32_to_t_uint32_fromStack(value3,  add(headStart, 96))

        abi_encode_t_bytes32_to_t_bytes32_fromStack(value4,  add(headStart, 128))

    }

    function abi_decode_t_bytes32_fromMemory(offset, end) -> value {
        value := mload(offset)
        validator_revert_t_bytes32(value)
    }

    function abi_decode_tuple_t_bytes32_fromMemory(headStart, dataEnd) -> value0 {
        if slt(sub(dataEnd, headStart), 32) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := 0

            value0 := abi_decode_t_bytes32_fromMemory(add(headStart, offset), dataEnd)
        }

    }

    function array_storeLengthForEncoding_t_string_memory_ptr_nonPadded_inplace_fromStack(pos, length) -> updated_pos {
        updated_pos := pos
    }

    function abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value, pos) -> end {
        let length := array_length_t_string_memory_ptr(value)
        pos := array_storeLengthForEncoding_t_string_memory_ptr_nonPadded_inplace_fromStack(pos, length)
        copy_memory_to_memory_with_cleanup(add(value, 0x20), pos, length)
        end := add(pos, length)
    }

    function abi_encode_tuple_packed_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr__to_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr__nonPadded_inplace_fromStack_reversed(pos , value10, value9, value8, value7, value6, value5, value4, value3, value2, value1, value0) -> end {

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value0,  pos)

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value1,  pos)

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value2,  pos)

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value3,  pos)

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value4,  pos)

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value5,  pos)

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value6,  pos)

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value7,  pos)

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value8,  pos)

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value9,  pos)

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value10,  pos)

        end := pos
    }

    function decrement_t_uint8(value) -> ret {
        value := cleanup_t_uint8(value)
        if eq(value, 0x00) { panic_error_0x11() }
        ret := sub(value, 1)
    }

    function checked_sub_t_uint8(x, y) -> diff {
        x := cleanup_t_uint8(x)
        y := cleanup_t_uint8(y)
        diff := sub(x, y)

        if gt(diff, 0xff) { panic_error_0x11() }

    }

    function panic_error_0x12() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x12)
        revert(0, 0x24)
    }

    function mod_t_uint256(x, y) -> r {
        x := cleanup_t_uint256(x)
        y := cleanup_t_uint256(y)
        if iszero(y) { panic_error_0x12() }
        r := mod(x, y)
    }

    function abi_encode_tuple_t_uint256__to_t_uint256__fromStack_reversed(headStart , value0) -> tail {
        tail := add(headStart, 32)

        abi_encode_t_uint256_to_t_uint256_fromStack(value0,  add(headStart, 0))

    }

    function shift_right_1_unsigned(value) -> newValue {
        newValue :=

        shr(1, value)

    }

    function checked_exp_helper(_power, _base, exponent, max) -> power, base {
        power := _power
        base  := _base
        for { } gt(exponent, 1) {}
        {
            // overflow check for base * base
            if gt(base, div(max, base)) { panic_error_0x11() }
            if and(exponent, 1)
            {
                // No checks for power := mul(power, base) needed, because the check
                // for base * base above is sufficient, since:
                // |power| <= base (proof by induction) and thus:
                // |power * base| <= base * base <= max <= |min| (for signed)
                // (this is equally true for signed and unsigned exp)
                power := mul(power, base)
            }
            base := mul(base, base)
            exponent := shift_right_1_unsigned(exponent)
        }
    }

    function checked_exp_unsigned(base, exponent, max) -> power {
        // This function currently cannot be inlined because of the
        // "leave" statements. We have to improve the optimizer.

        // Note that 0**0 == 1
        if iszero(exponent) { power := 1 leave }
        if iszero(base) { power := 0 leave }

        // Specializations for small bases
        switch base
        // 0 is handled above
        case 1 { power := 1 leave }
        case 2
        {
            if gt(exponent, 255) { panic_error_0x11() }
            power := exp(2, exponent)
            if gt(power, max) { panic_error_0x11() }
            leave
        }
        if or(
            and(lt(base, 11), lt(exponent, 78)),
            and(lt(base, 307), lt(exponent, 32))
        )
        {
            power := exp(base, exponent)
            if gt(power, max) { panic_error_0x11() }
            leave
        }

        power, base := checked_exp_helper(1, base, exponent, max)

        if gt(power, div(max, base)) { panic_error_0x11() }
        power := mul(power, base)
    }

    function checked_exp_t_uint256_t_uint256(base, exponent) -> power {
        base := cleanup_t_uint256(base)
        exponent := cleanup_t_uint256(exponent)

        power := checked_exp_unsigned(base, exponent, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)

    }

}
