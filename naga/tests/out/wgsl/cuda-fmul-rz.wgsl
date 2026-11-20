@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_fmul_rz(left_bits: u32, right_bits: u32) -> u32 {
    let _e8 = (left_bits & 2147483647u);
    let _e9 = (right_bits & 2147483647u);
    let _e11 = ((left_bits ^ right_bits) & 2147483648u);
    if ((_e8 > 2139095040u) || (_e9 > 2139095040u)) {
        return 2143289344u;
    }
    let _e17 = ((_e8 == 2139095040u) || (_e9 == 2139095040u));
    let _e20 = ((_e8 == 0u) || (_e9 == 0u));
    if (_e17 && _e20) {
        return 2143289344u;
    }
    if _e17 {
        return (_e11 | 2139095040u);
    }
    if _e20 {
        return _e11;
    }
    let _e26 = (_e8 >> 23u);
    let _e27 = (_e9 >> 23u);
    let _e28 = (_e26 != 0u);
    let _e29 = (_e27 != 0u);
    let _e34 = ((_e8 & 8388607u) | select(0u, 8388608u, _e28));
    let _e35 = ((_e9 & 8388607u) | select(0u, 8388608u, _e29));
    let _e38 = (_e34 & 4095u);
    let _e39 = (_e35 & 4095u);
    let _e40 = (_e34 >> 12u);
    let _e41 = (_e35 >> 12u);
    let _e42 = (_e38 * _e39);
    let _e47 = (((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u));
    let _e50 = ((_e40 * _e41) + (_e47 >> 12u));
    let _e54 = ((_e42 & 4095u) | ((_e47 & 4095u) << 12u));
    let _e64 = i32(select((31u - countLeadingZeros((_e54 | 1u))), (55u - countLeadingZeros(_e50)), (_e50 != 0u)));
    let _e69 = (i32(select(1u, _e26, _e28)) + i32(select(1u, _e27, _e29)));
    let _e72 = ((_e64 + _e69) - 173i);
    let _e79 = (max((_e64 - 23i), (151i - _e69)) - 3i);
    let _e103 = (u32(min(max(_e79, 0i), 31i)) & 31u);
    let _e131 = (u32(min(max((_e79 - 24i), 0i), 31i)) & 31u);
    let _e153 = (select(select(select(select(u32(((_e50 | _e54) != 0u)), ((_e50 >> _e131) | u32((((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u)))), (_e79 < 48i)), (_e50 | u32((_e54 != 0u))), (_e79 == 24i)), (((_e50 << (u32(min(max((24i - _e79), 0i), 31i)) & 31u)) | (_e54 >> _e103)) | u32(((_e54 & ((1u << _e103) - 1u)) != 0u))), (_e79 < 24i)), (((_e50 << 24u) | _e54) << (u32(min(max((0i - _e79), 0i), 31i)) & 31u)), (_e79 <= 0i)) >> 3u);
    if (_e72 >= 255i) {
        return (_e11 | 2139095039u);
    }
    return (_e11 | ((select(0u, u32(max(_e72, 1i)), (_e153 >= 8388608u)) << 23u) | (_e153 & 8388607u)));
}

fn truncate_product(first: f32, second: f32) -> f32 {
    let _e4 = gen__naga_fmul_rz(bitcast<u32>(first), bitcast<u32>(second));
    return bitcast<f32>(_e4);
}

fn _fmul_rz(first_1: bool, second_1: bool) -> i32 {
    var local_45: i32;

    if first_1 {
        local_45 = 7i;
    } else {
        local_45 = 9i;
    }
    let _e6 = local_45;
    return _e6;
}

fn gen__naga_fabsf(input_bits: u32) -> u32 {
    let _e2 = (input_bits & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

fn gen__naga_fmul_rn(left_bits_1: u32, right_bits_1: u32) -> u32 {
    let _e8 = (left_bits_1 & 2147483647u);
    let _e9 = (right_bits_1 & 2147483647u);
    let _e11 = ((left_bits_1 ^ right_bits_1) & 2147483648u);
    if ((_e8 > 2139095040u) || (_e9 > 2139095040u)) {
        return 2143289344u;
    }
    let _e17 = ((_e8 == 2139095040u) || (_e9 == 2139095040u));
    let _e20 = ((_e8 == 0u) || (_e9 == 0u));
    if (_e17 && _e20) {
        return 2143289344u;
    }
    let _e22 = (_e11 | 2139095040u);
    if _e17 {
        return _e22;
    }
    if _e20 {
        return _e11;
    }
    let _e26 = (_e8 >> 23u);
    let _e27 = (_e9 >> 23u);
    let _e28 = (_e26 != 0u);
    let _e29 = (_e27 != 0u);
    let _e34 = ((_e8 & 8388607u) | select(0u, 8388608u, _e28));
    let _e35 = ((_e9 & 8388607u) | select(0u, 8388608u, _e29));
    let _e38 = (_e34 & 4095u);
    let _e39 = (_e35 & 4095u);
    let _e40 = (_e34 >> 12u);
    let _e41 = (_e35 >> 12u);
    let _e42 = (_e38 * _e39);
    let _e47 = (((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u));
    let _e50 = ((_e40 * _e41) + (_e47 >> 12u));
    let _e54 = ((_e42 & 4095u) | ((_e47 & 4095u) << 12u));
    let _e64 = i32(select((31u - countLeadingZeros((_e54 | 1u))), (55u - countLeadingZeros(_e50)), (_e50 != 0u)));
    let _e69 = (i32(select(1u, _e26, _e28)) + i32(select(1u, _e27, _e29)));
    let _e79 = (max((_e64 - 23i), (151i - _e69)) - 3i);
    let _e103 = (u32(min(max(_e79, 0i), 31i)) & 31u);
    let _e131 = (u32(min(max((_e79 - 24i), 0i), 31i)) & 31u);
    let _e151 = select(select(select(select(u32(((_e50 | _e54) != 0u)), ((_e50 >> _e131) | u32((((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u)))), (_e79 < 48i)), (_e50 | u32((_e54 != 0u))), (_e79 == 24i)), (((_e50 << (u32(min(max((24i - _e79), 0i), 31i)) & 31u)) | (_e54 >> _e103)) | u32(((_e54 & ((1u << _e103) - 1u)) != 0u))), (_e79 < 24i)), (((_e50 << 24u) | _e54) << (u32(min(max((0i - _e79), 0i), 31i)) & 31u)), (_e79 <= 0i));
    let _e155 = (_e151 & 7u);
    let _e156 = (_e151 >> 3u);
    let _e164 = (_e156 + u32(((_e155 > 4u) || ((_e155 == 4u) && ((_e156 & 1u) != 0u)))));
    let _e166 = (_e164 >= 16777216u);
    let _e168 = select(_e164, (_e164 >> 1u), _e166);
    let _e170 = (((_e64 + _e69) - 173i) + i32(_e166));
    if (_e170 >= 255i) {
        return _e22;
    }
    return (_e11 | ((select(0u, u32(max(_e170, 1i)), (_e168 >= 8388608u)) << 23u) | (_e168 & 8388607u)));
}

fn gen__naga_fmul_rd(left_bits_2: u32, right_bits_2: u32) -> u32 {
    let _e8 = (left_bits_2 & 2147483647u);
    let _e9 = (right_bits_2 & 2147483647u);
    let _e11 = ((left_bits_2 ^ right_bits_2) & 2147483648u);
    if ((_e8 > 2139095040u) || (_e9 > 2139095040u)) {
        return 2143289344u;
    }
    let _e17 = ((_e8 == 2139095040u) || (_e9 == 2139095040u));
    let _e20 = ((_e8 == 0u) || (_e9 == 0u));
    if (_e17 && _e20) {
        return 2143289344u;
    }
    let _e22 = (_e11 | 2139095040u);
    if _e17 {
        return _e22;
    }
    if _e20 {
        return _e11;
    }
    let _e26 = (_e8 >> 23u);
    let _e27 = (_e9 >> 23u);
    let _e28 = (_e26 != 0u);
    let _e29 = (_e27 != 0u);
    let _e34 = ((_e8 & 8388607u) | select(0u, 8388608u, _e28));
    let _e35 = ((_e9 & 8388607u) | select(0u, 8388608u, _e29));
    let _e38 = (_e34 & 4095u);
    let _e39 = (_e35 & 4095u);
    let _e40 = (_e34 >> 12u);
    let _e41 = (_e35 >> 12u);
    let _e42 = (_e38 * _e39);
    let _e47 = (((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u));
    let _e50 = ((_e40 * _e41) + (_e47 >> 12u));
    let _e54 = ((_e42 & 4095u) | ((_e47 & 4095u) << 12u));
    let _e64 = i32(select((31u - countLeadingZeros((_e54 | 1u))), (55u - countLeadingZeros(_e50)), (_e50 != 0u)));
    let _e69 = (i32(select(1u, _e26, _e28)) + i32(select(1u, _e27, _e29)));
    let _e79 = (max((_e64 - 23i), (151i - _e69)) - 3i);
    let _e103 = (u32(min(max(_e79, 0i), 31i)) & 31u);
    let _e131 = (u32(min(max((_e79 - 24i), 0i), 31i)) & 31u);
    let _e151 = select(select(select(select(u32(((_e50 | _e54) != 0u)), ((_e50 >> _e131) | u32((((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u)))), (_e79 < 48i)), (_e50 | u32((_e54 != 0u))), (_e79 == 24i)), (((_e50 << (u32(min(max((24i - _e79), 0i), 31i)) & 31u)) | (_e54 >> _e103)) | u32(((_e54 & ((1u << _e103) - 1u)) != 0u))), (_e79 < 24i)), (((_e50 << 24u) | _e54) << (u32(min(max((0i - _e79), 0i), 31i)) & 31u)), (_e79 <= 0i));
    let _e152 = (_e11 != 0u);
    let _e160 = ((_e151 >> 3u) + u32((_e152 && ((_e151 & 7u) > 0u))));
    let _e162 = (_e160 >= 16777216u);
    let _e164 = select(_e160, (_e160 >> 1u), _e162);
    let _e166 = (((_e64 + _e69) - 173i) + i32(_e162));
    if (_e166 >= 255i) {
        return select((_e11 | 2139095039u), _e22, _e152);
    }
    return (_e11 | ((select(0u, u32(max(_e166, 1i)), (_e164 >= 8388608u)) << 23u) | (_e164 & 8388607u)));
}

fn gen__naga_fmul_ru(left_bits_3: u32, right_bits_3: u32) -> u32 {
    let _e8 = (left_bits_3 & 2147483647u);
    let _e9 = (right_bits_3 & 2147483647u);
    let _e11 = ((left_bits_3 ^ right_bits_3) & 2147483648u);
    if ((_e8 > 2139095040u) || (_e9 > 2139095040u)) {
        return 2143289344u;
    }
    let _e17 = ((_e8 == 2139095040u) || (_e9 == 2139095040u));
    let _e20 = ((_e8 == 0u) || (_e9 == 0u));
    if (_e17 && _e20) {
        return 2143289344u;
    }
    let _e22 = (_e11 | 2139095040u);
    if _e17 {
        return _e22;
    }
    if _e20 {
        return _e11;
    }
    let _e26 = (_e8 >> 23u);
    let _e27 = (_e9 >> 23u);
    let _e28 = (_e26 != 0u);
    let _e29 = (_e27 != 0u);
    let _e34 = ((_e8 & 8388607u) | select(0u, 8388608u, _e28));
    let _e35 = ((_e9 & 8388607u) | select(0u, 8388608u, _e29));
    let _e38 = (_e34 & 4095u);
    let _e39 = (_e35 & 4095u);
    let _e40 = (_e34 >> 12u);
    let _e41 = (_e35 >> 12u);
    let _e42 = (_e38 * _e39);
    let _e47 = (((_e38 * _e41) + (_e40 * _e39)) + (_e42 >> 12u));
    let _e50 = ((_e40 * _e41) + (_e47 >> 12u));
    let _e54 = ((_e42 & 4095u) | ((_e47 & 4095u) << 12u));
    let _e64 = i32(select((31u - countLeadingZeros((_e54 | 1u))), (55u - countLeadingZeros(_e50)), (_e50 != 0u)));
    let _e69 = (i32(select(1u, _e26, _e28)) + i32(select(1u, _e27, _e29)));
    let _e79 = (max((_e64 - 23i), (151i - _e69)) - 3i);
    let _e103 = (u32(min(max(_e79, 0i), 31i)) & 31u);
    let _e131 = (u32(min(max((_e79 - 24i), 0i), 31i)) & 31u);
    let _e151 = select(select(select(select(u32(((_e50 | _e54) != 0u)), ((_e50 >> _e131) | u32((((_e50 & ((1u << _e131) - 1u)) != 0u) || (_e54 != 0u)))), (_e79 < 48i)), (_e50 | u32((_e54 != 0u))), (_e79 == 24i)), (((_e50 << (u32(min(max((24i - _e79), 0i), 31i)) & 31u)) | (_e54 >> _e103)) | u32(((_e54 & ((1u << _e103) - 1u)) != 0u))), (_e79 < 24i)), (((_e50 << 24u) | _e54) << (u32(min(max((0i - _e79), 0i), 31i)) & 31u)), (_e79 <= 0i));
    let _e152 = (_e11 == 0u);
    let _e160 = ((_e151 >> 3u) + u32((_e152 && ((_e151 & 7u) > 0u))));
    let _e162 = (_e160 >= 16777216u);
    let _e164 = select(_e160, (_e160 >> 1u), _e162);
    let _e166 = (((_e64 + _e69) - 173i) + i32(_e162));
    if (_e166 >= 255i) {
        return select((_e11 | 2139095039u), _e22, _e152);
    }
    return (_e11 | ((select(0u, u32(max(_e166, 1i)), (_e164 >= 8388608u)) << 23u) | (_e164 & 8388607u)));
}

@compute @workgroup_size(32, 1, 1)
fn multiply_round_zero(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
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
    var local_14: u32;
    var directed_cursor: i32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var pair_first: vec2<f32>;
    var local_23: u32;
    var pair_second: vec2<f32>;
    var local_24: u32;
    var pair_rn: vec2<f32>;
    var local_25: vec2<f32>;
    var local_26: vec2<f32>;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var pair_rz: vec2<f32>;
    var local_30: vec2<f32>;
    var local_31: vec2<f32>;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var pair_rd: vec2<f32>;
    var local_35: vec2<f32>;
    var local_36: vec2<f32>;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;
    var pair_ru: vec2<f32>;
    var local_40: vec2<f32>;
    var local_41: vec2<f32>;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
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
    let base = (4u + (index * 26u));
    local = u32((index * 2u));
    let _e17 = local;
    let _e20 = input[_e17];
    let first_2 = bitcast<f32>(_e20);
    local_1 = u32(((index * 2u) + 1u));
    let _e28 = local_1;
    let _e30 = input[_e28];
    let second_2 = bitcast<f32>(_e30);
    let _e34 = gen__naga_fmul_rz(bitcast<u32>(first_2), bitcast<u32>(second_2));
    output[base] = bitcast<u32>(bitcast<f32>(_e34));
    let _e39 = truncate_product(first_2, second_2);
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
    let _e75 = truncate_product(bitcast<f32>(_e60), bitcast<f32>(_e73));
    local_3 = u32((base + 2u));
    let _e81 = local_3;
    output[_e81] = bitcast<u32>(_e75);
    local_6 = false;
    if false {
        let _e85 = cursor;
        cursor = (_e85 + 1i);
        let _e91 = gen__naga_fmul_rz(bitcast<u32>(f32(_e85)), bitcast<u32>(first_2));
        let _e94 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e91)));
        local_6 = (_e94 != 0u);
    }
    local_7 = true;
    if true {
    } else {
        let _e99 = cursor;
        cursor = (_e99 + 1i);
        let _e105 = gen__naga_fmul_rz(bitcast<u32>(first_2), bitcast<u32>(f32(_e99)));
        let _e108 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e105)));
        local_7 = (_e108 != 0u);
    }
    let _e111 = cursor;
    local_8 = u32((base + 3u));
    let _e117 = local_8;
    output[_e117] = u32(_e111);
    let _e125 = gen__naga_fmul_rz(bitcast<u32>(-(0f)), bitcast<u32>(-(0f)));
    local_9 = u32((base + 4u));
    let _e132 = local_9;
    output[_e132] = bitcast<u32>(bitcast<f32>(_e125));
    let _e139 = gen__naga_fmul_rz(bitcast<u32>(-(0f)), bitcast<u32>(0f));
    local_10 = u32((base + 5u));
    let _e146 = local_10;
    output[_e146] = bitcast<u32>(bitcast<f32>(_e139));
    let _e152 = truncate_product(f32(2i), f32(3u));
    local_11 = u32((base + 6u));
    let _e158 = local_11;
    output[_e158] = bitcast<u32>(_e152);
    let _e162 = _fmul_rz(true, false);
    local_12 = u32((base + 7u));
    let _e168 = local_12;
    output[_e168] = u32(_e162);
    let _e172 = gen__naga_fmul_rz(bitcast<u32>(second_2), bitcast<u32>(first_2));
    local_13 = u32((base + 8u));
    let _e179 = local_13;
    output[_e179] = bitcast<u32>(bitcast<f32>(_e172));
    let _e183 = gen__naga_fmul_rn(bitcast<u32>(first_2), bitcast<u32>(second_2));
    local_14 = u32((base + 9u));
    let _e190 = local_14;
    output[_e190] = bitcast<u32>(bitcast<f32>(_e183));
    directed_cursor = 0i;
    let _e196 = directed_cursor;
    directed_cursor = (_e196 + 1i);
    local_16 = u32(((index * 2u) + u32(_e196)));
    let _e203 = local_16;
    let _e205 = input[_e203];
    let _e209 = directed_cursor;
    directed_cursor = (_e209 + 1i);
    local_17 = u32(((index * 2u) + u32(_e209)));
    let _e216 = local_17;
    let _e218 = input[_e216];
    let _e222 = gen__naga_fmul_rd(bitcast<u32>(bitcast<f32>(_e205)), bitcast<u32>(bitcast<f32>(_e218)));
    local_15 = u32((base + 10u));
    let _e229 = local_15;
    output[_e229] = bitcast<u32>(bitcast<f32>(_e222));
    let _e231 = directed_cursor;
    local_18 = u32((base + 11u));
    let _e237 = local_18;
    output[_e237] = u32(_e231);
    directed_cursor = 0i;
    let _e242 = directed_cursor;
    directed_cursor = (_e242 + 1i);
    local_20 = u32(((index * 2u) + u32(_e242)));
    let _e249 = local_20;
    let _e251 = input[_e249];
    let _e255 = directed_cursor;
    directed_cursor = (_e255 + 1i);
    local_21 = u32(((index * 2u) + u32(_e255)));
    let _e262 = local_21;
    let _e264 = input[_e262];
    let _e268 = gen__naga_fmul_ru(bitcast<u32>(bitcast<f32>(_e251)), bitcast<u32>(bitcast<f32>(_e264)));
    local_19 = u32((base + 12u));
    let _e275 = local_19;
    output[_e275] = bitcast<u32>(bitcast<f32>(_e268));
    let _e277 = directed_cursor;
    local_22 = u32((base + 13u));
    let _e283 = local_22;
    output[_e283] = u32(_e277);
    let other = (index ^ 1u);
    local_23 = u32((other * 2u));
    let _e291 = local_23;
    let _e293 = input[_e291];
    pair_first = vec2<f32>(first_2, bitcast<f32>(_e293));
    local_24 = u32(((other * 2u) + 1u));
    let _e303 = local_24;
    let _e305 = input[_e303];
    pair_second = vec2<f32>(second_2, bitcast<f32>(_e305));
    directed_cursor = 0i;
    let _e310 = pair_first;
    value = vec2<f32>();
    value = _e310;
    let _e314 = directed_cursor;
    directed_cursor = (_e314 + 1i);
    let _e317 = value;
    local_25 = _e317;
    let _e319 = local_25;
    let _e320 = pair_second;
    value_1 = vec2<f32>();
    value_1 = _e320;
    let _e324 = directed_cursor;
    directed_cursor = (_e324 + 1i);
    let _e327 = value_1;
    local_26 = _e327;
    let _e329 = local_26;
    let _e334 = gen__naga_fmul_rn(bitcast<u32>(_e319.x), bitcast<u32>(_e329.x));
    let _e340 = gen__naga_fmul_rn(bitcast<u32>(_e319.y), bitcast<u32>(_e329.y));
    pair_rn = vec2<f32>(bitcast<f32>(_e334), bitcast<f32>(_e340));
    let _e345 = pair_rn.x;
    local_27 = u32((base + 14u));
    let _e351 = local_27;
    output[_e351] = bitcast<u32>(_e345);
    let _e354 = pair_rn.y;
    local_28 = u32((base + 15u));
    let _e360 = local_28;
    output[_e360] = bitcast<u32>(_e354);
    let _e362 = directed_cursor;
    local_29 = u32((base + 16u));
    let _e368 = local_29;
    output[_e368] = u32(_e362);
    directed_cursor = 0i;
    let _e371 = pair_first;
    value_2 = vec2<f32>();
    value_2 = _e371;
    let _e375 = directed_cursor;
    directed_cursor = (_e375 + 1i);
    let _e378 = value_2;
    local_30 = _e378;
    let _e380 = local_30;
    let _e381 = pair_second;
    value_3 = vec2<f32>();
    value_3 = _e381;
    let _e385 = directed_cursor;
    directed_cursor = (_e385 + 1i);
    let _e388 = value_3;
    local_31 = _e388;
    let _e390 = local_31;
    let _e395 = gen__naga_fmul_rz(bitcast<u32>(_e380.x), bitcast<u32>(_e390.x));
    let _e401 = gen__naga_fmul_rz(bitcast<u32>(_e380.y), bitcast<u32>(_e390.y));
    pair_rz = vec2<f32>(bitcast<f32>(_e395), bitcast<f32>(_e401));
    let _e406 = pair_rz.x;
    local_32 = u32((base + 17u));
    let _e412 = local_32;
    output[_e412] = bitcast<u32>(_e406);
    let _e415 = pair_rz.y;
    local_33 = u32((base + 18u));
    let _e421 = local_33;
    output[_e421] = bitcast<u32>(_e415);
    let _e423 = directed_cursor;
    local_34 = u32((base + 19u));
    let _e429 = local_34;
    output[_e429] = u32(_e423);
    directed_cursor = 0i;
    let _e432 = pair_first;
    value_4 = vec2<f32>();
    value_4 = _e432;
    let _e436 = directed_cursor;
    directed_cursor = (_e436 + 1i);
    let _e439 = value_4;
    local_35 = _e439;
    let _e441 = local_35;
    let _e442 = pair_second;
    value_5 = vec2<f32>();
    value_5 = _e442;
    let _e446 = directed_cursor;
    directed_cursor = (_e446 + 1i);
    let _e449 = value_5;
    local_36 = _e449;
    let _e451 = local_36;
    let _e456 = gen__naga_fmul_rd(bitcast<u32>(_e441.x), bitcast<u32>(_e451.x));
    let _e462 = gen__naga_fmul_rd(bitcast<u32>(_e441.y), bitcast<u32>(_e451.y));
    pair_rd = vec2<f32>(bitcast<f32>(_e456), bitcast<f32>(_e462));
    let _e467 = pair_rd.x;
    local_37 = u32((base + 20u));
    let _e473 = local_37;
    output[_e473] = bitcast<u32>(_e467);
    let _e476 = pair_rd.y;
    local_38 = u32((base + 21u));
    let _e482 = local_38;
    output[_e482] = bitcast<u32>(_e476);
    let _e484 = directed_cursor;
    local_39 = u32((base + 22u));
    let _e490 = local_39;
    output[_e490] = u32(_e484);
    directed_cursor = 0i;
    let _e493 = pair_first;
    value_6 = vec2<f32>();
    value_6 = _e493;
    let _e497 = directed_cursor;
    directed_cursor = (_e497 + 1i);
    let _e500 = value_6;
    local_40 = _e500;
    let _e502 = local_40;
    let _e503 = pair_second;
    value_7 = vec2<f32>();
    value_7 = _e503;
    let _e507 = directed_cursor;
    directed_cursor = (_e507 + 1i);
    let _e510 = value_7;
    local_41 = _e510;
    let _e512 = local_41;
    let _e517 = gen__naga_fmul_ru(bitcast<u32>(_e502.x), bitcast<u32>(_e512.x));
    let _e523 = gen__naga_fmul_ru(bitcast<u32>(_e502.y), bitcast<u32>(_e512.y));
    pair_ru = vec2<f32>(bitcast<f32>(_e517), bitcast<f32>(_e523));
    let _e528 = pair_ru.x;
    local_42 = u32((base + 23u));
    let _e534 = local_42;
    output[_e534] = bitcast<u32>(_e528);
    let _e537 = pair_ru.y;
    local_43 = u32((base + 24u));
    let _e543 = local_43;
    output[_e543] = bitcast<u32>(_e537);
    let _e545 = directed_cursor;
    local_44 = u32((base + 25u));
    let _e551 = local_44;
    output[_e551] = u32(_e545);
}
