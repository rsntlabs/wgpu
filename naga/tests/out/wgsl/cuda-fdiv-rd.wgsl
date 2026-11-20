struct type_6 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<vec2<u32>>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_6;

fn kind(value_6: f32) -> u32 {
    return 1u;
}

fn gen__naga_divide_f32_rd(numerator_bits: u32, denominator_bits: u32) -> u32 {
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
    let _e78 = (_e11 != 0u);
    if (_e75 < -150i) {
        return (_e11 | u32(_e78));
    }
    quotient = 1u;
    remainder = (select(_e46, (_e46 << 1u), _e70) - _e68);
    iteration = 0u;
    loop {
        let _e86 = iteration;
        if (_e86 >= 23u) {
            break;
        }
        let _e88 = remainder;
        let _e89 = quotient;
        let _e90 = (_e88 << 1u);
        let _e91 = (_e90 >= _e68);
        remainder = select(_e90, (_e90 - _e68), _e91);
        quotient = ((_e89 << 1u) | select(0u, 1u, _e91));
        continuing {
            let _e97 = iteration;
            iteration = (_e97 + 1u);
        }
    }
    let _e99 = quotient;
    let _e100 = remainder;
    if (_e75 < -126i) {
        let _e106 = (u32((-126i - _e75)) & 31u);
        return (_e11 | ((_e99 >> _e106) + u32((_e78 && (((_e99 & ((1u << _e106) - 1u)) | _e100) != 0u)))));
    }
    let _e120 = (_e99 + select(0u, 1u, (_e78 && (_e100 != 0u))));
    let _e122 = (_e120 >> 24u);
    let _e125 = (_e75 + i32(_e122));
    if (_e125 > 127i) {
        return select(2139095039u, _e12, _e78);
    }
    return (_e11 | ((u32((_e125 + 127i)) << 23u) | ((_e120 >> _e122) & 8388607u)));
}

fn gen__naga_divide_f32_ru(numerator_bits_1: u32, denominator_bits_1: u32) -> u32 {
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
    let _e78 = (_e11 == 0u);
    if (_e75 < -150i) {
        return (_e11 | u32(_e78));
    }
    quotient_1 = 1u;
    remainder_1 = (select(_e46, (_e46 << 1u), _e70) - _e68);
    iteration_1 = 0u;
    loop {
        let _e86 = iteration_1;
        if (_e86 >= 23u) {
            break;
        }
        let _e88 = remainder_1;
        let _e89 = quotient_1;
        let _e90 = (_e88 << 1u);
        let _e91 = (_e90 >= _e68);
        remainder_1 = select(_e90, (_e90 - _e68), _e91);
        quotient_1 = ((_e89 << 1u) | select(0u, 1u, _e91));
        continuing {
            let _e97 = iteration_1;
            iteration_1 = (_e97 + 1u);
        }
    }
    let _e99 = quotient_1;
    let _e100 = remainder_1;
    if (_e75 < -126i) {
        let _e106 = (u32((-126i - _e75)) & 31u);
        return (_e11 | ((_e99 >> _e106) + u32((_e78 && (((_e99 & ((1u << _e106) - 1u)) | _e100) != 0u)))));
    }
    let _e120 = (_e99 + select(0u, 1u, (_e78 && (_e100 != 0u))));
    let _e122 = (_e120 >> 24u);
    let _e125 = (_e75 + i32(_e122));
    if (_e125 > 127i) {
        return select(4286578687u, _e12, _e78);
    }
    return (_e11 | ((u32((_e125 + 127i)) << 23u) | ((_e120 >> _e122) & 8388607u)));
}

@compute @workgroup_size(4, 1, 1)
fn divide_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var value: f32;
    var value_1: f32;
    var value_2: f32;
    var value_3: f32;
    var value_4: f32;
    var value_5: f32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 16u));
    let _e18 = input[index].x;
    let x = bitcast<f32>(_e18);
    let _e22 = input[index].y;
    let y = bitcast<f32>(_e22);
    counter = 0u;
    let _e28 = gen__naga_divide_f32_rd(bitcast<u32>(x), bitcast<u32>(y));
    output[base] = bitcast<u32>(bitcast<f32>(_e28));
    value = f32();
    value = x;
    let _e36 = counter;
    counter = (_e36 + u32(1i));
    let _e40 = value;
    value_1 = f32();
    value_1 = y;
    let _e44 = counter;
    counter = (_e44 + u32(1i));
    let _e48 = value_1;
    let _e51 = gen__naga_divide_f32_rd(bitcast<u32>(_e40), bitcast<u32>(_e48));
    local = u32((base + 1u));
    let _e58 = local;
    output[_e58] = bitcast<u32>(bitcast<f32>(_e51));
    let _e60 = counter;
    local_1 = u32((base + 2u));
    let _e65 = local_1;
    output[_e65] = _e60;
    let _e70 = gen__naga_divide_f32_rd(bitcast<u32>(1f), bitcast<u32>(y));
    local_2 = u32((base + 3u));
    let _e77 = local_2;
    output[_e77] = bitcast<u32>(bitcast<f32>(_e70));
    value_2 = f32();
    value_2 = y;
    let _e82 = counter;
    counter = (_e82 + u32(1i));
    let _e86 = value_2;
    let _e90 = gen__naga_divide_f32_rd(bitcast<u32>(1f), bitcast<u32>(_e86));
    local_3 = u32((base + 4u));
    let _e97 = local_3;
    output[_e97] = bitcast<u32>(bitcast<f32>(_e90));
    let _e99 = counter;
    local_4 = u32((base + 5u));
    let _e104 = local_4;
    output[_e104] = _e99;
    let _e108 = gen__naga_divide_f32_rd(bitcast<u32>(x), bitcast<u32>(y));
    let _e110 = kind(bitcast<f32>(_e108));
    local_5 = u32((base + 6u));
    let _e115 = local_5;
    output[_e115] = _e110;
    let _e120 = gen__naga_divide_f32_rd(bitcast<u32>(1f), bitcast<u32>(y));
    let _e122 = kind(bitcast<f32>(_e120));
    local_6 = u32((base + 7u));
    let _e127 = local_6;
    output[_e127] = _e122;
    let _e131 = gen__naga_divide_f32_ru(bitcast<u32>(x), bitcast<u32>(y));
    local_7 = u32((base + 8u));
    let _e138 = local_7;
    output[_e138] = bitcast<u32>(bitcast<f32>(_e131));
    value_3 = f32();
    value_3 = x;
    let _e143 = counter;
    counter = (_e143 + u32(1i));
    let _e147 = value_3;
    value_4 = f32();
    value_4 = y;
    let _e151 = counter;
    counter = (_e151 + u32(1i));
    let _e155 = value_4;
    let _e158 = gen__naga_divide_f32_ru(bitcast<u32>(_e147), bitcast<u32>(_e155));
    local_8 = u32((base + 9u));
    let _e165 = local_8;
    output[_e165] = bitcast<u32>(bitcast<f32>(_e158));
    let _e167 = counter;
    local_9 = u32((base + 10u));
    let _e172 = local_9;
    output[_e172] = _e167;
    let _e177 = gen__naga_divide_f32_ru(bitcast<u32>(1f), bitcast<u32>(y));
    local_10 = u32((base + 11u));
    let _e184 = local_10;
    output[_e184] = bitcast<u32>(bitcast<f32>(_e177));
    value_5 = f32();
    value_5 = y;
    let _e189 = counter;
    counter = (_e189 + u32(1i));
    let _e193 = value_5;
    let _e197 = gen__naga_divide_f32_ru(bitcast<u32>(1f), bitcast<u32>(_e193));
    local_11 = u32((base + 12u));
    let _e204 = local_11;
    output[_e204] = bitcast<u32>(bitcast<f32>(_e197));
    let _e206 = counter;
    local_12 = u32((base + 13u));
    let _e211 = local_12;
    output[_e211] = _e206;
    let _e215 = gen__naga_divide_f32_ru(bitcast<u32>(x), bitcast<u32>(y));
    let _e217 = kind(bitcast<f32>(_e215));
    local_13 = u32((base + 14u));
    let _e222 = local_13;
    output[_e222] = _e217;
    let _e227 = gen__naga_divide_f32_ru(bitcast<u32>(1f), bitcast<u32>(y));
    let _e229 = kind(bitcast<f32>(_e227));
    local_14 = u32((base + 15u));
    let _e234 = local_14;
    output[_e234] = _e229;
}
