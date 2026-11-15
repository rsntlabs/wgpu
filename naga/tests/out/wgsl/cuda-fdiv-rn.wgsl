@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_divide_f32_(numerator_bits: u32, denominator_bits: u32) -> u32 {
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
    let _e97 = remainder;
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

fn quotient_value(first: f32, second: f32) -> f32 {
    let _e4 = gen__naga_divide_f32_(bitcast<u32>(first), bitcast<u32>(second));
    return bitcast<f32>(_e4);
}

fn _fdiv_rn(first_1: bool, second_1: bool) -> i32 {
    var local_15: i32;

    if first_1 {
        local_15 = 7i;
    } else {
        local_15 = 9i;
    }
    let _e6 = local_15;
    return _e6;
}

fn gen__naga_fabsf(input_bits: u32) -> u32 {
    let _e2 = (input_bits & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

@compute @workgroup_size(32, 1, 1)
fn divide_round_nearest(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
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
    let _e34 = gen__naga_divide_f32_(bitcast<u32>(first_2), bitcast<u32>(second_2));
    output[base] = bitcast<u32>(bitcast<f32>(_e34));
    let _e39 = quotient_value(first_2, second_2);
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
    let _e75 = quotient_value(bitcast<f32>(_e60), bitcast<f32>(_e73));
    local_3 = u32((base + 2u));
    let _e81 = local_3;
    output[_e81] = bitcast<u32>(_e75);
    local_6 = false;
    if false {
        let _e85 = cursor;
        cursor = (_e85 + 1i);
        let _e91 = gen__naga_divide_f32_(bitcast<u32>(f32(_e85)), bitcast<u32>(first_2));
        let _e94 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e91)));
        local_6 = (_e94 != 0u);
    }
    local_7 = true;
    if true {
    } else {
        let _e99 = cursor;
        cursor = (_e99 + 1i);
        let _e105 = gen__naga_divide_f32_(bitcast<u32>(first_2), bitcast<u32>(f32(_e99)));
        let _e108 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e105)));
        local_7 = (_e108 != 0u);
    }
    let _e111 = cursor;
    local_8 = u32((base + 3u));
    let _e117 = local_8;
    output[_e117] = u32(_e111);
    let _e125 = gen__naga_divide_f32_(bitcast<u32>(-(0f)), bitcast<u32>(-(0f)));
    local_9 = u32((base + 4u));
    let _e132 = local_9;
    output[_e132] = bitcast<u32>(bitcast<f32>(_e125));
    let _e139 = gen__naga_divide_f32_(bitcast<u32>(-(0f)), bitcast<u32>(0f));
    local_10 = u32((base + 5u));
    let _e146 = local_10;
    output[_e146] = bitcast<u32>(bitcast<f32>(_e139));
    let _e152 = quotient_value(f32(2i), f32(3u));
    local_11 = u32((base + 6u));
    let _e158 = local_11;
    output[_e158] = bitcast<u32>(_e152);
    let _e162 = _fdiv_rn(true, false);
    local_12 = u32((base + 7u));
    let _e168 = local_12;
    output[_e168] = u32(_e162);
    let _e172 = gen__naga_divide_f32_(bitcast<u32>(second_2), bitcast<u32>(first_2));
    local_13 = u32((base + 8u));
    let _e179 = local_13;
    output[_e179] = bitcast<u32>(bitcast<f32>(_e172));
    let _e183 = quotient_value(1f, 3f);
    local_14 = u32((base + 9u));
    let _e189 = local_14;
    output[_e189] = bitcast<u32>(_e183);
}
