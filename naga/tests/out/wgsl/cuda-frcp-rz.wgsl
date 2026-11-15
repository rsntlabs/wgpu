@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_divide_f32_rz(numerator_bits: u32, denominator_bits: u32) -> u32 {
    var numerator_significand: u32;
    var numerator_exponent: i32;
    var denominator_significand: u32;
    var denominator_exponent: i32;
    var quotient: u32;
    var remainder: u32;
    var iteration: u32;

    let _e8 = (numerator_bits & 2147483647u);
    let _e9 = (denominator_bits & 2147483647u);
    let _e11 = ((numerator_bits ^ denominator_bits) & 2147483648u);
    let _e16 = (_e8 == 0u);
    let _e17 = (_e9 == 0u);
    let _e19 = (_e8 == 2139095040u);
    let _e20 = (_e9 == 2139095040u);
    if ((((_e8 > 2139095040u) || (_e9 > 2139095040u)) || (_e16 && _e17)) || (_e19 && _e20)) {
        return 2143289344u;
    }
    if (_e19 || _e17) {
        return (_e11 | 2139095040u);
    }
    if (_e16 || _e20) {
        return _e11;
    }
    let _e30 = (_e8 & 8388607u);
    let _e31 = (_e8 >> 23u);
    numerator_significand = (_e30 | 8388608u);
    numerator_exponent = (i32(_e31) - 127i);
    if (_e31 == 0u) {
        let _e41 = (countLeadingZeros(_e30) - 8u);
        numerator_significand = (_e30 << _e41);
        numerator_exponent = (-126i - i32(_e41));
    }
    let _e46 = numerator_significand;
    let _e47 = numerator_exponent;
    let _e52 = (_e9 & 8388607u);
    let _e53 = (_e9 >> 23u);
    denominator_significand = (_e52 | 8388608u);
    denominator_exponent = (i32(_e53) - 127i);
    if (_e53 == 0u) {
        let _e63 = (countLeadingZeros(_e52) - 8u);
        denominator_significand = (_e52 << _e63);
        denominator_exponent = (-126i - i32(_e63));
    }
    let _e68 = denominator_significand;
    let _e69 = denominator_exponent;
    let _e70 = (_e46 < _e68);
    let _e75 = ((_e47 - _e69) - i32(_e70));
    if (_e75 < -150i) {
        return _e11;
    }
    quotient = 1u;
    remainder = (select(_e46, (_e46 << 1u), _e70) - _e68);
    iteration = 0u;
    loop {
        let _e83 = iteration;
        if (_e83 >= 23u) {
            break;
        }
        let _e85 = remainder;
        let _e86 = quotient;
        let _e87 = (_e85 << 1u);
        let _e88 = (_e87 >= _e68);
        remainder = select(_e87, (_e87 - _e68), _e88);
        quotient = ((_e86 << 1u) | select(0u, 1u, _e88));
        continuing {
            let _e94 = iteration;
            iteration = (_e94 + 1u);
        }
    }
    let _e96 = quotient;
    if (_e75 < -126i) {
        return (_e11 | (_e96 >> (u32((-126i - _e75)) & 31u)));
    }
    if (_e75 > 127i) {
        return (_e11 | 2139095039u);
    }
    return (_e11 | ((u32((_e75 + 127i)) << 23u) | (_e96 & 8388607u)));
}

fn truncated_reciprocal(value: f32) -> f32 {
    let _e4 = gen__naga_divide_f32_rz(bitcast<u32>(1f), bitcast<u32>(value));
    return bitcast<f32>(_e4);
}

fn _frcp_rz(value_1: bool) -> i32 {
    var local_14: i32;

    if value_1 {
        local_14 = 7i;
    } else {
        local_14 = 9i;
    }
    let _e6 = local_14;
    return _e6;
}

fn gen__naga_fabsf(input_bits: u32) -> u32 {
    let _e2 = (input_bits & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

fn gen__naga_divide_f32_(numerator_bits_1: u32, denominator_bits_1: u32) -> u32 {
    var numerator_significand_1: u32;
    var numerator_exponent_1: i32;
    var denominator_significand_1: u32;
    var denominator_exponent_1: i32;
    var quotient_1: u32;
    var remainder_1: u32;
    var iteration_1: u32;

    let _e8 = (numerator_bits_1 & 2147483647u);
    let _e9 = (denominator_bits_1 & 2147483647u);
    let _e11 = ((numerator_bits_1 ^ denominator_bits_1) & 2147483648u);
    let _e12 = (_e11 | 2139095040u);
    let _e16 = (_e8 == 0u);
    let _e17 = (_e9 == 0u);
    let _e19 = (_e8 == 2139095040u);
    let _e20 = (_e9 == 2139095040u);
    if ((((_e8 > 2139095040u) || (_e9 > 2139095040u)) || (_e16 && _e17)) || (_e19 && _e20)) {
        return 2143289344u;
    }
    if (_e19 || _e17) {
        return _e12;
    }
    if (_e16 || _e20) {
        return _e11;
    }
    let _e30 = (_e8 & 8388607u);
    let _e31 = (_e8 >> 23u);
    numerator_significand_1 = (_e30 | 8388608u);
    numerator_exponent_1 = (i32(_e31) - 127i);
    if (_e31 == 0u) {
        let _e41 = (countLeadingZeros(_e30) - 8u);
        numerator_significand_1 = (_e30 << _e41);
        numerator_exponent_1 = (-126i - i32(_e41));
    }
    let _e46 = numerator_significand_1;
    let _e47 = numerator_exponent_1;
    let _e52 = (_e9 & 8388607u);
    let _e53 = (_e9 >> 23u);
    denominator_significand_1 = (_e52 | 8388608u);
    denominator_exponent_1 = (i32(_e53) - 127i);
    if (_e53 == 0u) {
        let _e63 = (countLeadingZeros(_e52) - 8u);
        denominator_significand_1 = (_e52 << _e63);
        denominator_exponent_1 = (-126i - i32(_e63));
    }
    let _e68 = denominator_significand_1;
    let _e69 = denominator_exponent_1;
    let _e70 = (_e46 < _e68);
    let _e75 = ((_e47 - _e69) - i32(_e70));
    if (_e75 < -150i) {
        return _e11;
    }
    quotient_1 = 1u;
    remainder_1 = (select(_e46, (_e46 << 1u), _e70) - _e68);
    iteration_1 = 0u;
    loop {
        let _e83 = iteration_1;
        if (_e83 >= 23u) {
            break;
        }
        let _e85 = remainder_1;
        let _e86 = quotient_1;
        let _e87 = (_e85 << 1u);
        let _e88 = (_e87 >= _e68);
        remainder_1 = select(_e87, (_e87 - _e68), _e88);
        quotient_1 = ((_e86 << 1u) | select(0u, 1u, _e88));
        continuing {
            let _e94 = iteration_1;
            iteration_1 = (_e94 + 1u);
        }
    }
    let _e96 = quotient_1;
    let _e97 = remainder_1;
    if (_e75 < -126i) {
        let _e103 = (u32((-126i - _e75)) & 31u);
        let _e104 = (1u << _e103);
        let _e106 = (_e96 & (_e104 - 1u));
        let _e107 = (_e104 >> 1u);
        let _e108 = (_e96 >> _e103);
        return (_e11 | (_e108 + select(0u, 1u, ((_e106 > _e107) || ((_e106 == _e107) && ((_e97 != 0u) || ((_e108 & 1u) != 0u)))))));
    }
    let _e120 = (_e97 << 1u);
    let _e128 = (_e96 + select(0u, 1u, ((_e120 > _e68) || ((_e120 == _e68) && ((_e96 & 1u) != 0u)))));
    let _e130 = (_e128 >> 24u);
    let _e133 = (_e75 + i32(_e130));
    if (_e133 > 127i) {
        return _e12;
    }
    return (_e11 | ((u32((_e133 + 127i)) << 23u) | ((_e128 >> _e130) & 8388607u)));
}

@compute @workgroup_size(32, 1, 1)
fn reciprocal_round_zero(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
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

    let index = (threadIdx.x + (blockIdx.x * 32u));
    if (index >= 4096u) {
        return;
    }
    let base = (4u + (index * 10u));
    let _e15 = input[index];
    let value_2 = bitcast<f32>(_e15);
    let _e20 = gen__naga_divide_f32_rz(bitcast<u32>(1f), bitcast<u32>(value_2));
    output[base] = bitcast<u32>(bitcast<f32>(_e20));
    let _e25 = truncated_reciprocal(value_2);
    local = u32((base + 1u));
    let _e31 = local;
    output[_e31] = bitcast<u32>(_e25);
    cursor = 0i;
    let _e35 = cursor;
    cursor = (_e35 + 1i);
    local_2 = u32((index + u32(_e35)));
    let _e42 = local_2;
    let _e44 = input[_e42];
    let _e46 = truncated_reciprocal(bitcast<f32>(_e44));
    local_1 = u32((base + 2u));
    let _e52 = local_1;
    output[_e52] = bitcast<u32>(_e46);
    local_3 = false;
    if false {
        let _e56 = cursor;
        cursor = (_e56 + 1i);
        let _e63 = gen__naga_divide_f32_rz(bitcast<u32>(1f), bitcast<u32>(f32(_e56)));
        let _e66 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e63)));
        local_3 = (_e66 != 0u);
    }
    local_4 = true;
    if true {
    } else {
        let _e71 = cursor;
        cursor = (_e71 + 1i);
        let _e78 = gen__naga_divide_f32_rz(bitcast<u32>(1f), bitcast<u32>(f32(_e71)));
        let _e81 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e78)));
        local_4 = (_e81 != 0u);
    }
    let _e84 = cursor;
    local_5 = u32((base + 3u));
    let _e90 = local_5;
    output[_e90] = u32(_e84);
    let _e97 = gen__naga_divide_f32_rz(bitcast<u32>(1f), bitcast<u32>(-(0f)));
    local_6 = u32((base + 4u));
    let _e104 = local_6;
    output[_e104] = bitcast<u32>(bitcast<f32>(_e97));
    local_8 = 4286578688u;
    let _e108 = local_8;
    let _e113 = gen__naga_divide_f32_rz(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e108)));
    local_7 = u32((base + 5u));
    let _e120 = local_7;
    output[_e120] = bitcast<u32>(bitcast<f32>(_e113));
    let _e124 = truncated_reciprocal(f32(2u));
    local_9 = u32((base + 6u));
    let _e130 = local_9;
    output[_e130] = bitcast<u32>(_e124);
    let _e133 = _frcp_rz(true);
    local_10 = u32((base + 7u));
    let _e139 = local_10;
    output[_e139] = u32(_e133);
    if true {
        let _e145 = gen__naga_divide_f32_rz(bitcast<u32>(1f), bitcast<u32>(value_2));
        local_12 = bitcast<f32>(_e145);
    } else {
        let _e148 = cursor;
        cursor = (_e148 + 1i);
        let _e155 = gen__naga_divide_f32_rz(bitcast<u32>(1f), bitcast<u32>(f32(_e148)));
        local_12 = bitcast<f32>(_e155);
    }
    let _e159 = local_12;
    local_11 = u32((base + 8u));
    let _e165 = local_11;
    output[_e165] = bitcast<u32>(_e159);
    let _e170 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(value_2));
    local_13 = u32((base + 9u));
    let _e177 = local_13;
    output[_e177] = bitcast<u32>(bitcast<f32>(_e170));
}
