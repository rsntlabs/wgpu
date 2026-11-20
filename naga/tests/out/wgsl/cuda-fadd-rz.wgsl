@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_fadd_rz(left_bits: u32, right_bits: u32) -> u32 {
    let _e9 = (left_bits & 2147483647u);
    let _e10 = (right_bits & 2147483647u);
    let _e11 = (left_bits & 2147483648u);
    let _e12 = (right_bits & 2147483648u);
    if ((_e9 > 2139095040u) || (_e10 > 2139095040u)) {
        return 2143289344u;
    }
    let _e16 = (_e9 == 2139095040u);
    let _e17 = (_e10 == 2139095040u);
    if ((_e16 && _e17) && (_e11 != _e12)) {
        return 2143289344u;
    }
    if _e16 {
        return left_bits;
    }
    if _e17 {
        return right_bits;
    }
    let _e22 = (_e9 >= _e10);
    let _e23 = select(_e10, _e9, _e22);
    let _e24 = select(_e9, _e10, _e22);
    let _e25 = select(_e12, _e11, _e22);
    let _e29 = (_e23 >> 23u);
    let _e30 = (_e24 >> 23u);
    let _e31 = (_e29 != 0u);
    let _e32 = (_e30 != 0u);
    let _e39 = (((_e23 & 8388607u) | select(0u, 8388608u, _e31)) << 3u);
    let _e40 = (((_e24 & 8388607u) | select(0u, 8388608u, _e32)) << 3u);
    let _e41 = select(1u, _e29, _e31);
    let _e43 = (_e41 - select(1u, _e30, _e32));
    let _e48 = (_e43 & 31u);
    let _e59 = select(u32((_e40 != 0u)), ((_e40 >> _e48) | u32(((_e40 & ((1u << _e48) - 1u)) != 0u))), (_e43 < 32u));
    let _e62 = select((_e39 - _e59), (_e39 + _e59), (_e11 == _e12));
    if (_e62 == 0u) {
        return (_e11 & _e12);
    }
    let _e66 = (_e62 >= 134217728u);
    let _e71 = (1u & 31u);
    let _e83 = select(_e62, select(u32((_e62 != 0u)), ((_e62 >> _e71) | u32(((_e62 & ((1u << _e71) - 1u)) != 0u))), (1u < 32u)), _e66);
    let _e85 = (_e41 + u32(_e66));
    let _e90 = min((countLeadingZeros(_e83) - 5u), (_e85 - 1u));
    let _e92 = (_e85 - _e90);
    let _e93 = ((_e83 << _e90) >> 3u);
    if (_e92 >= 255u) {
        return (_e25 | 2139095039u);
    }
    return (_e25 | ((select(0u, _e92, (_e93 >= 8388608u)) << 23u) | (_e93 & 8388607u)));
}

fn truncate_value(first: f32, second: f32) -> f32 {
    let _e4 = gen__naga_fadd_rz(bitcast<u32>(first), bitcast<u32>(second));
    return bitcast<f32>(_e4);
}

fn _fadd_rz(first_1: bool, second_1: bool) -> i32 {
    var local_54: i32;

    if first_1 {
        local_54 = 7i;
    } else {
        local_54 = 9i;
    }
    let _e6 = local_54;
    return _e6;
}

fn gen__naga_fabsf(input_bits: u32) -> u32 {
    let _e2 = (input_bits & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

fn gen__naga_fadd_rn(left_bits_1: u32, right_bits_1: u32) -> u32 {
    let _e9 = (left_bits_1 & 2147483647u);
    let _e10 = (right_bits_1 & 2147483647u);
    let _e11 = (left_bits_1 & 2147483648u);
    let _e12 = (right_bits_1 & 2147483648u);
    if ((_e9 > 2139095040u) || (_e10 > 2139095040u)) {
        return 2143289344u;
    }
    let _e16 = (_e9 == 2139095040u);
    let _e17 = (_e10 == 2139095040u);
    if ((_e16 && _e17) && (_e11 != _e12)) {
        return 2143289344u;
    }
    if _e16 {
        return left_bits_1;
    }
    if _e17 {
        return right_bits_1;
    }
    let _e22 = (_e9 >= _e10);
    let _e23 = select(_e10, _e9, _e22);
    let _e24 = select(_e9, _e10, _e22);
    let _e25 = select(_e12, _e11, _e22);
    let _e29 = (_e23 >> 23u);
    let _e30 = (_e24 >> 23u);
    let _e31 = (_e29 != 0u);
    let _e32 = (_e30 != 0u);
    let _e39 = (((_e23 & 8388607u) | select(0u, 8388608u, _e31)) << 3u);
    let _e40 = (((_e24 & 8388607u) | select(0u, 8388608u, _e32)) << 3u);
    let _e41 = select(1u, _e29, _e31);
    let _e43 = (_e41 - select(1u, _e30, _e32));
    let _e48 = (_e43 & 31u);
    let _e59 = select(u32((_e40 != 0u)), ((_e40 >> _e48) | u32(((_e40 & ((1u << _e48) - 1u)) != 0u))), (_e43 < 32u));
    let _e62 = select((_e39 - _e59), (_e39 + _e59), (_e11 == _e12));
    if (_e62 == 0u) {
        return (_e11 & _e12);
    }
    let _e66 = (_e62 >= 134217728u);
    let _e71 = (1u & 31u);
    let _e83 = select(_e62, select(u32((_e62 != 0u)), ((_e62 >> _e71) | u32(((_e62 & ((1u << _e71) - 1u)) != 0u))), (1u < 32u)), _e66);
    let _e85 = (_e41 + u32(_e66));
    let _e90 = min((countLeadingZeros(_e83) - 5u), (_e85 - 1u));
    let _e91 = (_e83 << _e90);
    let _e95 = (_e91 & 7u);
    let _e96 = (_e91 >> 3u);
    let _e104 = (_e96 + u32(((_e95 > 4u) || ((_e95 == 4u) && ((_e96 & 1u) != 0u)))));
    let _e106 = (_e104 >= 16777216u);
    let _e108 = select(_e104, (_e104 >> 1u), _e106);
    let _e110 = ((_e85 - _e90) + u32(_e106));
    if (_e110 >= 255u) {
        return (_e25 | 2139095040u);
    }
    return (_e25 | ((select(0u, _e110, (_e108 >= 8388608u)) << 23u) | (_e108 & 8388607u)));
}

fn gen__naga_fadd_rd(left_bits_2: u32, right_bits_2: u32) -> u32 {
    let _e9 = (left_bits_2 & 2147483647u);
    let _e10 = (right_bits_2 & 2147483647u);
    let _e11 = (left_bits_2 & 2147483648u);
    let _e12 = (right_bits_2 & 2147483648u);
    if ((_e9 > 2139095040u) || (_e10 > 2139095040u)) {
        return 2143289344u;
    }
    let _e16 = (_e9 == 2139095040u);
    let _e17 = (_e10 == 2139095040u);
    if ((_e16 && _e17) && (_e11 != _e12)) {
        return 2143289344u;
    }
    if _e16 {
        return left_bits_2;
    }
    if _e17 {
        return right_bits_2;
    }
    let _e22 = (_e9 >= _e10);
    let _e23 = select(_e10, _e9, _e22);
    let _e24 = select(_e9, _e10, _e22);
    let _e25 = select(_e12, _e11, _e22);
    let _e29 = (_e23 >> 23u);
    let _e30 = (_e24 >> 23u);
    let _e31 = (_e29 != 0u);
    let _e32 = (_e30 != 0u);
    let _e39 = (((_e23 & 8388607u) | select(0u, 8388608u, _e31)) << 3u);
    let _e40 = (((_e24 & 8388607u) | select(0u, 8388608u, _e32)) << 3u);
    let _e41 = select(1u, _e29, _e31);
    let _e43 = (_e41 - select(1u, _e30, _e32));
    let _e48 = (_e43 & 31u);
    let _e59 = select(u32((_e40 != 0u)), ((_e40 >> _e48) | u32(((_e40 & ((1u << _e48) - 1u)) != 0u))), (_e43 < 32u));
    let _e62 = select((_e39 - _e59), (_e39 + _e59), (_e11 == _e12));
    if (_e62 == 0u) {
        return (_e11 | _e12);
    }
    let _e66 = (_e62 >= 134217728u);
    let _e71 = (1u & 31u);
    let _e83 = select(_e62, select(u32((_e62 != 0u)), ((_e62 >> _e71) | u32(((_e62 & ((1u << _e71) - 1u)) != 0u))), (1u < 32u)), _e66);
    let _e85 = (_e41 + u32(_e66));
    let _e90 = min((countLeadingZeros(_e83) - 5u), (_e85 - 1u));
    let _e91 = (_e83 << _e90);
    let _e93 = (_e25 != 0u);
    let _e100 = ((_e91 >> 3u) + u32((_e93 && ((_e91 & 7u) > 0u))));
    let _e102 = (_e100 >= 16777216u);
    let _e104 = select(_e100, (_e100 >> 1u), _e102);
    let _e106 = ((_e85 - _e90) + u32(_e102));
    if (_e106 >= 255u) {
        return (_e25 | select(2139095039u, 2139095040u, _e93));
    }
    return (_e25 | ((select(0u, _e106, (_e104 >= 8388608u)) << 23u) | (_e104 & 8388607u)));
}

fn gen__naga_fadd_ru(left_bits_3: u32, right_bits_3: u32) -> u32 {
    let _e9 = (left_bits_3 & 2147483647u);
    let _e10 = (right_bits_3 & 2147483647u);
    let _e11 = (left_bits_3 & 2147483648u);
    let _e12 = (right_bits_3 & 2147483648u);
    if ((_e9 > 2139095040u) || (_e10 > 2139095040u)) {
        return 2143289344u;
    }
    let _e16 = (_e9 == 2139095040u);
    let _e17 = (_e10 == 2139095040u);
    if ((_e16 && _e17) && (_e11 != _e12)) {
        return 2143289344u;
    }
    if _e16 {
        return left_bits_3;
    }
    if _e17 {
        return right_bits_3;
    }
    let _e22 = (_e9 >= _e10);
    let _e23 = select(_e10, _e9, _e22);
    let _e24 = select(_e9, _e10, _e22);
    let _e25 = select(_e12, _e11, _e22);
    let _e29 = (_e23 >> 23u);
    let _e30 = (_e24 >> 23u);
    let _e31 = (_e29 != 0u);
    let _e32 = (_e30 != 0u);
    let _e39 = (((_e23 & 8388607u) | select(0u, 8388608u, _e31)) << 3u);
    let _e40 = (((_e24 & 8388607u) | select(0u, 8388608u, _e32)) << 3u);
    let _e41 = select(1u, _e29, _e31);
    let _e43 = (_e41 - select(1u, _e30, _e32));
    let _e48 = (_e43 & 31u);
    let _e59 = select(u32((_e40 != 0u)), ((_e40 >> _e48) | u32(((_e40 & ((1u << _e48) - 1u)) != 0u))), (_e43 < 32u));
    let _e62 = select((_e39 - _e59), (_e39 + _e59), (_e11 == _e12));
    if (_e62 == 0u) {
        return (_e11 & _e12);
    }
    let _e66 = (_e62 >= 134217728u);
    let _e71 = (1u & 31u);
    let _e83 = select(_e62, select(u32((_e62 != 0u)), ((_e62 >> _e71) | u32(((_e62 & ((1u << _e71) - 1u)) != 0u))), (1u < 32u)), _e66);
    let _e85 = (_e41 + u32(_e66));
    let _e90 = min((countLeadingZeros(_e83) - 5u), (_e85 - 1u));
    let _e91 = (_e83 << _e90);
    let _e93 = (_e25 == 0u);
    let _e100 = ((_e91 >> 3u) + u32((_e93 && ((_e91 & 7u) > 0u))));
    let _e102 = (_e100 >= 16777216u);
    let _e104 = select(_e100, (_e100 >> 1u), _e102);
    let _e106 = ((_e85 - _e90) + u32(_e102));
    if (_e106 >= 255u) {
        return (_e25 | select(2139095039u, 2139095040u, _e93));
    }
    return (_e25 | ((select(0u, _e106, (_e104 >= 8388608u)) << 23u) | (_e104 & 8388607u)));
}

@compute @workgroup_size(32, 1, 1)
fn add_round_zero(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var cursor: i32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: bool;
    var local_7: bool;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: f32;
    var local_15: u32;
    var directed_cursor: i32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var pair_first: vec2<f32>;
    var local_32: u32;
    var pair_second: vec2<f32>;
    var local_33: u32;
    var pair_rn: vec2<f32>;
    var local_34: vec2<f32>;
    var local_35: vec2<f32>;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var pair_rz: vec2<f32>;
    var local_39: vec2<f32>;
    var local_40: vec2<f32>;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;
    var pair_rd: vec2<f32>;
    var local_44: vec2<f32>;
    var local_45: vec2<f32>;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var pair_ru: vec2<f32>;
    var local_49: vec2<f32>;
    var local_50: vec2<f32>;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var value: vec2<f32>;
    var value_1: vec2<f32>;
    var value_2: vec2<f32>;
    var value_3: vec2<f32>;
    var value_4: vec2<f32>;
    var value_5: vec2<f32>;
    var value_6: vec2<f32>;
    var value_7: vec2<f32>;

    let index = (threadIdx.x + (blockIdx.x * 32u));
    if (index >= 4096u) {
        return;
    }
    let base = (4u + (index * 30u));
    local = u32((index * 2u));
    let _e17 = local;
    let _e20 = input[_e17];
    let first_2 = bitcast<f32>(_e20);
    local_1 = u32(((index * 2u) + 1u));
    let _e28 = local_1;
    let _e30 = input[_e28];
    let second_2 = bitcast<f32>(_e30);
    let _e34 = gen__naga_fadd_rz(bitcast<u32>(first_2), bitcast<u32>(second_2));
    output[base] = bitcast<u32>(bitcast<f32>(_e34));
    let _e39 = truncate_value(first_2, second_2);
    local_2 = u32((base + 1u));
    let _e45 = local_2;
    output[_e45] = bitcast<u32>(_e39);
    cursor = 0i;
    let _e51 = cursor;
    cursor = (_e51 + 1i);
    local_4 = u32(((index * 2u) + u32(_e51)));
    let _e58 = local_4;
    let _e60 = input[_e58];
    let _e64 = cursor;
    cursor = (_e64 + 1i);
    local_5 = u32(((index * 2u) + u32(_e64)));
    let _e71 = local_5;
    let _e73 = input[_e71];
    let _e75 = truncate_value(bitcast<f32>(_e60), bitcast<f32>(_e73));
    local_3 = u32((base + 2u));
    let _e81 = local_3;
    output[_e81] = bitcast<u32>(_e75);
    local_6 = false;
    if false {
        let _e85 = cursor;
        cursor = (_e85 + 1i);
        let _e91 = gen__naga_fadd_rz(bitcast<u32>(f32(_e85)), bitcast<u32>(first_2));
        let _e94 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e91)));
        local_6 = (_e94 != 0u);
    }
    local_7 = true;
    if true {
    } else {
        let _e99 = cursor;
        cursor = (_e99 + 1i);
        let _e105 = gen__naga_fadd_rz(bitcast<u32>(first_2), bitcast<u32>(f32(_e99)));
        let _e108 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e105)));
        local_7 = (_e108 != 0u);
    }
    let _e111 = cursor;
    local_8 = u32((base + 3u));
    let _e117 = local_8;
    output[_e117] = u32(_e111);
    let _e125 = gen__naga_fadd_rz(bitcast<u32>(-(0f)), bitcast<u32>(-(0f)));
    local_9 = u32((base + 4u));
    let _e132 = local_9;
    output[_e132] = bitcast<u32>(bitcast<f32>(_e125));
    let _e139 = gen__naga_fadd_rz(bitcast<u32>(-(0f)), bitcast<u32>(0f));
    local_10 = u32((base + 5u));
    let _e146 = local_10;
    output[_e146] = bitcast<u32>(bitcast<f32>(_e139));
    let _e152 = truncate_value(f32(1i), f32(2u));
    local_11 = u32((base + 6u));
    let _e158 = local_11;
    output[_e158] = bitcast<u32>(_e152);
    let _e162 = _fadd_rz(true, false);
    local_12 = u32((base + 7u));
    let _e168 = local_12;
    output[_e168] = u32(_e162);
    if true {
        let _e173 = gen__naga_fadd_rz(bitcast<u32>(first_2), bitcast<u32>(second_2));
        local_14 = bitcast<f32>(_e173);
    } else {
        let _e176 = cursor;
        cursor = (_e176 + 1i);
        let _e182 = gen__naga_fadd_rz(bitcast<u32>(f32(_e176)), bitcast<u32>(first_2));
        local_14 = bitcast<f32>(_e182);
    }
    let _e186 = local_14;
    local_13 = u32((base + 8u));
    let _e192 = local_13;
    output[_e192] = bitcast<u32>(_e186);
    let _e196 = gen__naga_fadd_rn(bitcast<u32>(first_2), bitcast<u32>(second_2));
    local_15 = u32((base + 9u));
    let _e203 = local_15;
    output[_e203] = bitcast<u32>(bitcast<f32>(_e196));
    directed_cursor = 0i;
    let _e209 = directed_cursor;
    directed_cursor = (_e209 + 1i);
    local_17 = u32(((index * 2u) + u32(_e209)));
    let _e216 = local_17;
    let _e218 = input[_e216];
    let _e222 = directed_cursor;
    directed_cursor = (_e222 + 1i);
    local_18 = u32(((index * 2u) + u32(_e222)));
    let _e229 = local_18;
    let _e231 = input[_e229];
    let _e235 = gen__naga_fadd_rd(bitcast<u32>(bitcast<f32>(_e218)), bitcast<u32>(bitcast<f32>(_e231)));
    local_16 = u32((base + 10u));
    let _e242 = local_16;
    output[_e242] = bitcast<u32>(bitcast<f32>(_e235));
    let _e244 = directed_cursor;
    local_19 = u32((base + 11u));
    let _e250 = local_19;
    output[_e250] = u32(_e244);
    directed_cursor = 0i;
    let _e255 = directed_cursor;
    directed_cursor = (_e255 + 1i);
    local_21 = u32(((index * 2u) + u32(_e255)));
    let _e262 = local_21;
    let _e264 = input[_e262];
    let _e268 = directed_cursor;
    directed_cursor = (_e268 + 1i);
    local_22 = u32(((index * 2u) + u32(_e268)));
    let _e275 = local_22;
    let _e277 = input[_e275];
    let _e281 = gen__naga_fadd_ru(bitcast<u32>(bitcast<f32>(_e264)), bitcast<u32>(bitcast<f32>(_e277)));
    local_20 = u32((base + 12u));
    let _e288 = local_20;
    output[_e288] = bitcast<u32>(bitcast<f32>(_e281));
    let _e290 = directed_cursor;
    local_23 = u32((base + 13u));
    let _e296 = local_23;
    output[_e296] = u32(_e290);
    directed_cursor = 0i;
    let _e301 = directed_cursor;
    directed_cursor = (_e301 + 1i);
    local_25 = u32(((index * 2u) + u32(_e301)));
    let _e308 = local_25;
    let _e310 = input[_e308];
    let _e314 = directed_cursor;
    directed_cursor = (_e314 + 1i);
    local_26 = u32(((index * 2u) + u32(_e314)));
    let _e321 = local_26;
    let _e323 = input[_e321];
    let _e329 = gen__naga_fadd_rd(bitcast<u32>(bitcast<f32>(_e310)), (bitcast<u32>(bitcast<f32>(_e323)) ^ 2147483648u));
    local_24 = u32((base + 14u));
    let _e336 = local_24;
    output[_e336] = bitcast<u32>(bitcast<f32>(_e329));
    let _e338 = directed_cursor;
    local_27 = u32((base + 15u));
    let _e344 = local_27;
    output[_e344] = u32(_e338);
    directed_cursor = 0i;
    let _e349 = directed_cursor;
    directed_cursor = (_e349 + 1i);
    local_29 = u32(((index * 2u) + u32(_e349)));
    let _e356 = local_29;
    let _e358 = input[_e356];
    let _e362 = directed_cursor;
    directed_cursor = (_e362 + 1i);
    local_30 = u32(((index * 2u) + u32(_e362)));
    let _e369 = local_30;
    let _e371 = input[_e369];
    let _e377 = gen__naga_fadd_ru(bitcast<u32>(bitcast<f32>(_e358)), (bitcast<u32>(bitcast<f32>(_e371)) ^ 2147483648u));
    local_28 = u32((base + 16u));
    let _e384 = local_28;
    output[_e384] = bitcast<u32>(bitcast<f32>(_e377));
    let _e386 = directed_cursor;
    local_31 = u32((base + 17u));
    let _e392 = local_31;
    output[_e392] = u32(_e386);
    let other = (index ^ 1u);
    local_32 = u32((other * 2u));
    let _e400 = local_32;
    let _e402 = input[_e400];
    pair_first = vec2<f32>(first_2, bitcast<f32>(_e402));
    local_33 = u32(((other * 2u) + 1u));
    let _e412 = local_33;
    let _e414 = input[_e412];
    pair_second = vec2<f32>(second_2, bitcast<f32>(_e414));
    directed_cursor = 0i;
    let _e419 = pair_first;
    value = vec2<f32>();
    value = _e419;
    let _e423 = directed_cursor;
    directed_cursor = (_e423 + 1i);
    let _e426 = value;
    local_34 = _e426;
    let _e428 = local_34;
    let _e429 = pair_second;
    value_1 = vec2<f32>();
    value_1 = _e429;
    let _e433 = directed_cursor;
    directed_cursor = (_e433 + 1i);
    let _e436 = value_1;
    local_35 = _e436;
    let _e438 = local_35;
    let _e443 = gen__naga_fadd_rn(bitcast<u32>(_e428.x), bitcast<u32>(_e438.x));
    let _e449 = gen__naga_fadd_rn(bitcast<u32>(_e428.y), bitcast<u32>(_e438.y));
    pair_rn = vec2<f32>(bitcast<f32>(_e443), bitcast<f32>(_e449));
    let _e454 = pair_rn.x;
    local_36 = u32((base + 18u));
    let _e460 = local_36;
    output[_e460] = bitcast<u32>(_e454);
    let _e463 = pair_rn.y;
    local_37 = u32((base + 19u));
    let _e469 = local_37;
    output[_e469] = bitcast<u32>(_e463);
    let _e471 = directed_cursor;
    local_38 = u32((base + 20u));
    let _e477 = local_38;
    output[_e477] = u32(_e471);
    directed_cursor = 0i;
    let _e480 = pair_first;
    value_2 = vec2<f32>();
    value_2 = _e480;
    let _e484 = directed_cursor;
    directed_cursor = (_e484 + 1i);
    let _e487 = value_2;
    local_39 = _e487;
    let _e489 = local_39;
    let _e490 = pair_second;
    value_3 = vec2<f32>();
    value_3 = _e490;
    let _e494 = directed_cursor;
    directed_cursor = (_e494 + 1i);
    let _e497 = value_3;
    local_40 = _e497;
    let _e499 = local_40;
    let _e504 = gen__naga_fadd_rz(bitcast<u32>(_e489.x), bitcast<u32>(_e499.x));
    let _e510 = gen__naga_fadd_rz(bitcast<u32>(_e489.y), bitcast<u32>(_e499.y));
    pair_rz = vec2<f32>(bitcast<f32>(_e504), bitcast<f32>(_e510));
    let _e515 = pair_rz.x;
    local_41 = u32((base + 21u));
    let _e521 = local_41;
    output[_e521] = bitcast<u32>(_e515);
    let _e524 = pair_rz.y;
    local_42 = u32((base + 22u));
    let _e530 = local_42;
    output[_e530] = bitcast<u32>(_e524);
    let _e532 = directed_cursor;
    local_43 = u32((base + 23u));
    let _e538 = local_43;
    output[_e538] = u32(_e532);
    directed_cursor = 0i;
    let _e541 = pair_first;
    value_4 = vec2<f32>();
    value_4 = _e541;
    let _e545 = directed_cursor;
    directed_cursor = (_e545 + 1i);
    let _e548 = value_4;
    local_44 = _e548;
    let _e550 = local_44;
    let _e551 = pair_second;
    value_5 = vec2<f32>();
    value_5 = _e551;
    let _e555 = directed_cursor;
    directed_cursor = (_e555 + 1i);
    let _e558 = value_5;
    local_45 = _e558;
    let _e560 = local_45;
    let _e565 = gen__naga_fadd_rd(bitcast<u32>(_e550.x), bitcast<u32>(_e560.x));
    let _e571 = gen__naga_fadd_rd(bitcast<u32>(_e550.y), bitcast<u32>(_e560.y));
    pair_rd = vec2<f32>(bitcast<f32>(_e565), bitcast<f32>(_e571));
    let _e576 = pair_rd.x;
    local_46 = u32((base + 24u));
    let _e582 = local_46;
    output[_e582] = bitcast<u32>(_e576);
    let _e585 = pair_rd.y;
    local_47 = u32((base + 25u));
    let _e591 = local_47;
    output[_e591] = bitcast<u32>(_e585);
    let _e593 = directed_cursor;
    local_48 = u32((base + 26u));
    let _e599 = local_48;
    output[_e599] = u32(_e593);
    directed_cursor = 0i;
    let _e602 = pair_first;
    value_6 = vec2<f32>();
    value_6 = _e602;
    let _e606 = directed_cursor;
    directed_cursor = (_e606 + 1i);
    let _e609 = value_6;
    local_49 = _e609;
    let _e611 = local_49;
    let _e612 = pair_second;
    value_7 = vec2<f32>();
    value_7 = _e612;
    let _e616 = directed_cursor;
    directed_cursor = (_e616 + 1i);
    let _e619 = value_7;
    local_50 = _e619;
    let _e621 = local_50;
    let _e626 = gen__naga_fadd_ru(bitcast<u32>(_e611.x), bitcast<u32>(_e621.x));
    let _e632 = gen__naga_fadd_ru(bitcast<u32>(_e611.y), bitcast<u32>(_e621.y));
    pair_ru = vec2<f32>(bitcast<f32>(_e626), bitcast<f32>(_e632));
    let _e637 = pair_ru.x;
    local_51 = u32((base + 27u));
    let _e643 = local_51;
    output[_e643] = bitcast<u32>(_e637);
    let _e646 = pair_ru.y;
    local_52 = u32((base + 28u));
    let _e652 = local_52;
    output[_e652] = bitcast<u32>(_e646);
    let _e654 = directed_cursor;
    local_53 = u32((base + 29u));
    let _e660 = local_53;
    output[_e660] = u32(_e654);
}
