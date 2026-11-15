@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_fadd_rn(left_bits: u32, right_bits: u32) -> u32 {
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

fn subtract_value(first: f32, second: f32) -> f32 {
    let _e6 = gen__naga_fadd_rn(bitcast<u32>(first), (bitcast<u32>(second) ^ 2147483648u));
    return bitcast<f32>(_e6);
}

fn _fsub_rn(first_1: bool, second_1: bool) -> i32 {
    var local_17: i32;

    if first_1 {
        local_17 = 7i;
    } else {
        local_17 = 9i;
    }
    let _e6 = local_17;
    return _e6;
}

fn gen__naga_fabsf(input_bits: u32) -> u32 {
    let _e2 = (input_bits & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

@compute @workgroup_size(32, 1, 1)
fn subtract_round_nearest(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
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
    var local_15: u32;
    var local_16: u32;

    let index = (threadIdx.x + (blockIdx.x * 32u));
    if (index >= 4096u) {
        return;
    }
    let base = (4u + (index * 10u));
    local = u32((index * 2u));
    let _e17 = local;
    let _e20 = input[_e17];
    let first_2 = bitcast<f32>(_e20);
    local_1 = u32(((index * 2u) + 1u));
    let _e28 = local_1;
    let _e30 = input[_e28];
    let second_2 = bitcast<f32>(_e30);
    let _e36 = gen__naga_fadd_rn(bitcast<u32>(first_2), (bitcast<u32>(second_2) ^ 2147483648u));
    output[base] = bitcast<u32>(bitcast<f32>(_e36));
    let _e41 = subtract_value(first_2, second_2);
    local_2 = u32((base + 1u));
    let _e47 = local_2;
    output[_e47] = bitcast<u32>(_e41);
    cursor = 0i;
    let _e53 = cursor;
    cursor = (_e53 + 1i);
    local_4 = u32(((index * 2u) + u32(_e53)));
    let _e60 = local_4;
    let _e62 = input[_e60];
    let _e66 = cursor;
    cursor = (_e66 + 1i);
    local_5 = u32(((index * 2u) + u32(_e66)));
    let _e73 = local_5;
    let _e75 = input[_e73];
    let _e77 = subtract_value(bitcast<f32>(_e62), bitcast<f32>(_e75));
    local_3 = u32((base + 2u));
    let _e83 = local_3;
    output[_e83] = bitcast<u32>(_e77);
    local_6 = false;
    if false {
        let _e87 = cursor;
        cursor = (_e87 + 1i);
        let _e95 = gen__naga_fadd_rn(bitcast<u32>(f32(_e87)), (bitcast<u32>(first_2) ^ 2147483648u));
        let _e98 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e95)));
        local_6 = (_e98 != 0u);
    }
    local_7 = true;
    if true {
    } else {
        let _e103 = cursor;
        cursor = (_e103 + 1i);
        let _e111 = gen__naga_fadd_rn(bitcast<u32>(first_2), (bitcast<u32>(f32(_e103)) ^ 2147483648u));
        let _e114 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e111)));
        local_7 = (_e114 != 0u);
    }
    let _e117 = cursor;
    local_8 = u32((base + 3u));
    let _e123 = local_8;
    output[_e123] = u32(_e117);
    let _e133 = gen__naga_fadd_rn(bitcast<u32>(-(0f)), (bitcast<u32>(-(0f)) ^ 2147483648u));
    local_9 = u32((base + 4u));
    let _e140 = local_9;
    output[_e140] = bitcast<u32>(bitcast<f32>(_e133));
    let _e149 = gen__naga_fadd_rn(bitcast<u32>(-(0f)), (bitcast<u32>(0f) ^ 2147483648u));
    local_10 = u32((base + 5u));
    let _e156 = local_10;
    output[_e156] = bitcast<u32>(bitcast<f32>(_e149));
    let _e162 = subtract_value(f32(1i), f32(2u));
    local_11 = u32((base + 6u));
    let _e168 = local_11;
    output[_e168] = bitcast<u32>(_e162);
    let _e172 = _fsub_rn(true, false);
    local_12 = u32((base + 7u));
    let _e178 = local_12;
    output[_e178] = u32(_e172);
    let _e184 = gen__naga_fadd_rn(bitcast<u32>(second_2), (bitcast<u32>(first_2) ^ 2147483648u));
    local_13 = u32((base + 8u));
    let _e191 = local_13;
    output[_e191] = bitcast<u32>(bitcast<f32>(_e184));
    local_15 = 1065353217u;
    let _e195 = local_15;
    local_16 = 1065353214u;
    let _e199 = local_16;
    let _e207 = gen__naga_fadd_rn(bitcast<u32>((bitcast<f32>(_e195) * bitcast<f32>(_e199))), (bitcast<u32>(1f) ^ 2147483648u));
    local_14 = u32((base + 9u));
    let _e214 = local_14;
    output[_e214] = bitcast<u32>(bitcast<f32>(_e207));
}
