@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_sqrtf_rz(input_bits: u32) -> u32 {
    var significand: u32;
    var adjusted_exponent: u32;
    var upper_word: u32;
    var lower_word: u32;
    var root: u32;
    var remainder: u32;
    var iteration: u32;

    let _e5 = (input_bits & 2147483647u);
    if ((_e5 == 0u) || (input_bits == 2139095040u)) {
        return input_bits;
    }
    if (((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u)) {
        return 2143289344u;
    }
    let _e19 = (input_bits & 8388607u);
    let _e20 = (_e5 >> 23u);
    significand = (_e19 | 8388608u);
    adjusted_exponent = (_e20 + 127u);
    if (_e20 == 0u) {
        let _e28 = (countLeadingZeros(_e19) - 8u);
        significand = (_e19 << _e28);
        adjusted_exponent = (128u - _e28);
    }
    let _e32 = significand;
    let _e33 = adjusted_exponent;
    let _e34 = (_e33 & 1u);
    upper_word = (_e32 >> (9u - _e34));
    lower_word = (_e32 << (23u + _e34));
    root = 0u;
    remainder = 0u;
    iteration = 0u;
    loop {
        let _e50 = iteration;
        if (_e50 >= 24u) {
            break;
        }
        let _e52 = upper_word;
        let _e53 = lower_word;
        let _e54 = root;
        let _e55 = remainder;
        let _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        let _e65 = ((_e54 << 2u) | 1u);
        let _e66 = (_e63 >= _e65);
        let _e69 = (_e54 << 1u);
        upper_word = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word = (_e53 << 2u);
        remainder = select(_e63, (_e63 - _e65), _e66);
        root = select(_e69, (_e69 | 1u), _e66);
        continuing {
            let _e72 = iteration;
            iteration = (_e72 + 1u);
        }
    }
    let _e74 = root;
    return (((_e33 >> 1u) << 23u) | (_e74 & 8388607u));
}

fn truncated_sqrt(value: f32) -> f32 {
    let _e2 = gen__naga_sqrtf_rz(bitcast<u32>(value));
    return bitcast<f32>(_e2);
}

fn _fsqrt_rz(value_1: bool) -> i32 {
    var local_20: i32;

    if value_1 {
        local_20 = 7i;
    } else {
        local_20 = 9i;
    }
    let _e6 = local_20;
    return _e6;
}

fn gen__naga_fabsf(input_bits_1: u32) -> u32 {
    let _e2 = (input_bits_1 & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

fn gen__naga_sqrtf(input_bits_2: u32) -> u32 {
    var significand_1: u32;
    var adjusted_exponent_1: u32;
    var upper_word_1: u32;
    var lower_word_1: u32;
    var root_1: u32;
    var remainder_1: u32;
    var iteration_1: u32;

    let _e5 = (input_bits_2 & 2147483647u);
    if ((_e5 == 0u) || (input_bits_2 == 2139095040u)) {
        return input_bits_2;
    }
    if (((input_bits_2 & 2147483648u) != 0u) || (_e5 > 2139095040u)) {
        return 2143289344u;
    }
    let _e19 = (input_bits_2 & 8388607u);
    let _e20 = (_e5 >> 23u);
    significand_1 = (_e19 | 8388608u);
    adjusted_exponent_1 = (_e20 + 127u);
    if (_e20 == 0u) {
        let _e28 = (countLeadingZeros(_e19) - 8u);
        significand_1 = (_e19 << _e28);
        adjusted_exponent_1 = (128u - _e28);
    }
    let _e32 = significand_1;
    let _e33 = adjusted_exponent_1;
    let _e34 = (_e33 & 1u);
    upper_word_1 = (_e32 >> (9u - _e34));
    lower_word_1 = (_e32 << (23u + _e34));
    root_1 = 0u;
    remainder_1 = 0u;
    iteration_1 = 0u;
    loop {
        let _e50 = iteration_1;
        if (_e50 >= 24u) {
            break;
        }
        let _e52 = upper_word_1;
        let _e53 = lower_word_1;
        let _e54 = root_1;
        let _e55 = remainder_1;
        let _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        let _e65 = ((_e54 << 2u) | 1u);
        let _e66 = (_e63 >= _e65);
        let _e69 = (_e54 << 1u);
        upper_word_1 = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word_1 = (_e53 << 2u);
        remainder_1 = select(_e63, (_e63 - _e65), _e66);
        root_1 = select(_e69, (_e69 | 1u), _e66);
        continuing {
            let _e72 = iteration_1;
            iteration_1 = (_e72 + 1u);
        }
    }
    let _e74 = root_1;
    let _e75 = remainder_1;
    return (((_e33 >> 1u) << 23u) | (select(_e74, (_e74 + 1u), (_e75 > _e74)) & 8388607u));
}

fn gen__naga_sqrtf_ru(input_bits_3: u32) -> u32 {
    var significand_2: u32;
    var adjusted_exponent_2: u32;
    var upper_word_2: u32;
    var lower_word_2: u32;
    var root_2: u32;
    var remainder_2: u32;
    var iteration_2: u32;

    let _e5 = (input_bits_3 & 2147483647u);
    if ((_e5 == 0u) || (input_bits_3 == 2139095040u)) {
        return input_bits_3;
    }
    if (((input_bits_3 & 2147483648u) != 0u) || (_e5 > 2139095040u)) {
        return 2143289344u;
    }
    let _e19 = (input_bits_3 & 8388607u);
    let _e20 = (_e5 >> 23u);
    significand_2 = (_e19 | 8388608u);
    adjusted_exponent_2 = (_e20 + 127u);
    if (_e20 == 0u) {
        let _e28 = (countLeadingZeros(_e19) - 8u);
        significand_2 = (_e19 << _e28);
        adjusted_exponent_2 = (128u - _e28);
    }
    let _e32 = significand_2;
    let _e33 = adjusted_exponent_2;
    let _e34 = (_e33 & 1u);
    upper_word_2 = (_e32 >> (9u - _e34));
    lower_word_2 = (_e32 << (23u + _e34));
    root_2 = 0u;
    remainder_2 = 0u;
    iteration_2 = 0u;
    loop {
        let _e50 = iteration_2;
        if (_e50 >= 24u) {
            break;
        }
        let _e52 = upper_word_2;
        let _e53 = lower_word_2;
        let _e54 = root_2;
        let _e55 = remainder_2;
        let _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        let _e65 = ((_e54 << 2u) | 1u);
        let _e66 = (_e63 >= _e65);
        let _e69 = (_e54 << 1u);
        upper_word_2 = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word_2 = (_e53 << 2u);
        remainder_2 = select(_e63, (_e63 - _e65), _e66);
        root_2 = select(_e69, (_e69 | 1u), _e66);
        continuing {
            let _e72 = iteration_2;
            iteration_2 = (_e72 + 1u);
        }
    }
    let _e74 = root_2;
    let _e75 = remainder_2;
    let _e78 = select(_e74, (_e74 + 1u), (_e75 > 0u));
    return ((((_e33 >> 1u) + (_e78 >> 24u)) << 23u) | (_e78 & 8388607u));
}

@compute @workgroup_size(32, 1, 1)
fn sqrt_round_zero(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var cursor: i32;
    var local_1: u32;
    var local_2: u32;
    var local_3: bool;
    var local_4: bool;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: f32;
    var local_13: u32;
    var directed_cursor: i32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;

    let index = (threadIdx.x + (blockIdx.x * 32u));
    if (index >= 4096u) {
        return;
    }
    let base = (4u + (index * 14u));
    let _e15 = input[index];
    let value_2 = bitcast<f32>(_e15);
    let _e18 = gen__naga_sqrtf_rz(bitcast<u32>(value_2));
    output[base] = bitcast<u32>(bitcast<f32>(_e18));
    let _e23 = truncated_sqrt(value_2);
    local = u32((base + 1u));
    let _e29 = local;
    output[_e29] = bitcast<u32>(_e23);
    cursor = 0i;
    let _e33 = cursor;
    cursor = (_e33 + 1i);
    local_2 = u32((index + u32(_e33)));
    let _e40 = local_2;
    let _e42 = input[_e40];
    let _e44 = truncated_sqrt(bitcast<f32>(_e42));
    local_1 = u32((base + 2u));
    let _e50 = local_1;
    output[_e50] = bitcast<u32>(_e44);
    local_3 = false;
    if false {
        let _e54 = cursor;
        cursor = (_e54 + 1i);
        let _e59 = gen__naga_sqrtf_rz(bitcast<u32>(f32(_e54)));
        let _e62 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if true {
    } else {
        let _e67 = cursor;
        cursor = (_e67 + 1i);
        let _e72 = gen__naga_sqrtf_rz(bitcast<u32>(f32(_e67)));
        let _e75 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e72)));
        local_4 = (_e75 != 0u);
    }
    let _e78 = cursor;
    local_5 = u32((base + 3u));
    let _e84 = local_5;
    output[_e84] = u32(_e78);
    let _e89 = gen__naga_sqrtf_rz(bitcast<u32>(-(0f)));
    local_6 = u32((base + 4u));
    let _e96 = local_6;
    output[_e96] = bitcast<u32>(bitcast<f32>(_e89));
    local_8 = 2139095040u;
    let _e100 = local_8;
    let _e103 = gen__naga_sqrtf_rz(bitcast<u32>(bitcast<f32>(_e100)));
    local_7 = u32((base + 5u));
    let _e110 = local_7;
    output[_e110] = bitcast<u32>(bitcast<f32>(_e103));
    let _e114 = truncated_sqrt(f32(4u));
    local_9 = u32((base + 6u));
    let _e120 = local_9;
    output[_e120] = bitcast<u32>(_e114);
    let _e123 = _fsqrt_rz(true);
    local_10 = u32((base + 7u));
    let _e129 = local_10;
    output[_e129] = u32(_e123);
    if true {
        let _e133 = gen__naga_sqrtf_rz(bitcast<u32>(value_2));
        local_12 = bitcast<f32>(_e133);
    } else {
        let _e136 = cursor;
        cursor = (_e136 + 1i);
        let _e141 = gen__naga_sqrtf_rz(bitcast<u32>(f32(_e136)));
        local_12 = bitcast<f32>(_e141);
    }
    let _e145 = local_12;
    local_11 = u32((base + 8u));
    let _e151 = local_11;
    output[_e151] = bitcast<u32>(_e145);
    let _e154 = gen__naga_sqrtf(bitcast<u32>(value_2));
    local_13 = u32((base + 9u));
    let _e161 = local_13;
    output[_e161] = bitcast<u32>(bitcast<f32>(_e154));
    directed_cursor = 0i;
    let _e165 = directed_cursor;
    directed_cursor = (_e165 + 1i);
    local_15 = u32((index + u32(_e165)));
    let _e172 = local_15;
    let _e174 = input[_e172];
    let _e177 = gen__naga_sqrtf_rz(bitcast<u32>(bitcast<f32>(_e174)));
    local_14 = u32((base + 10u));
    let _e184 = local_14;
    output[_e184] = bitcast<u32>(bitcast<f32>(_e177));
    let _e186 = directed_cursor;
    local_16 = u32((base + 11u));
    let _e192 = local_16;
    output[_e192] = u32(_e186);
    directed_cursor = 0i;
    let _e195 = directed_cursor;
    directed_cursor = (_e195 + 1i);
    local_18 = u32((index + u32(_e195)));
    let _e202 = local_18;
    let _e204 = input[_e202];
    let _e207 = gen__naga_sqrtf_ru(bitcast<u32>(bitcast<f32>(_e204)));
    local_17 = u32((base + 12u));
    let _e214 = local_17;
    output[_e214] = bitcast<u32>(bitcast<f32>(_e207));
    let _e216 = directed_cursor;
    local_19 = u32((base + 13u));
    let _e222 = local_19;
    output[_e222] = u32(_e216);
}
