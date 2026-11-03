@group(0) @binding(0)
var<storage, read_write> points: array<vec4<f32>>;
@group(0) @binding(1)
var<storage> params: array<f32>;

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

fn gen__naga_floorf(input_bits: u32) -> u32 {
    let _e5 = (input_bits & 2147483647u);
    let _e7 = ((input_bits & 2147483648u) != 0u);
    let _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e15 = (_e14 - 1u);
    let _e19 = (input_bits & ~(_e15));
    return select(select(select(select(_e19, (_e19 + _e14), (_e7 && ((input_bits & _e15) != 0u))), select(select(0u, 3212836864u, _e7), input_bits, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

fn gen__naga_fabsf(input_bits_1: u32) -> u32 {
    let _e2 = (input_bits_1 & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

fn wave(angle: f32) -> f32 {
    let _e4 = gen__naga_divide_f32_(bitcast<u32>(angle), bitcast<u32>(6.2831855f));
    let _e9 = gen__naga_floorf(bitcast<u32>((bitcast<f32>(_e4) + 0.5f)));
    let x = (angle - (bitcast<f32>(_e9) * 6.2831855f));
    let _e19 = gen__naga_fabsf(bitcast<u32>(x));
    let y = ((1.2732395f * x) - ((0.4052847f * x) * bitcast<f32>(_e19)));
    let _e24 = gen__naga_fabsf(bitcast<u32>(y));
    return (y + (0.225f * ((y * bitcast<f32>(_e24)) - y)));
}

fn gen__naga_sqrtf(input_bits_2: u32) -> u32 {
    var significand: u32;
    var adjusted_exponent: u32;
    var upper_word: u32;
    var lower_word: u32;
    var root: u32;
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
    remainder_1 = 0u;
    iteration_1 = 0u;
    loop {
        let _e50 = iteration_1;
        if (_e50 >= 24u) {
            break;
        }
        let _e52 = upper_word;
        let _e53 = lower_word;
        let _e54 = root;
        let _e55 = remainder_1;
        let _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        let _e65 = ((_e54 << 2u) | 1u);
        let _e66 = (_e63 >= _e65);
        let _e69 = (_e54 << 1u);
        upper_word = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word = (_e53 << 2u);
        remainder_1 = select(_e63, (_e63 - _e65), _e66);
        root = select(_e69, (_e69 | 1u), _e66);
        continuing {
            let _e72 = iteration_1;
            iteration_1 = (_e72 + 1u);
        }
    }
    let _e74 = root;
    let _e75 = remainder_1;
    return (((_e33 >> 1u) << 23u) | (select(_e74, (_e74 + 1u), (_e75 > _e74)) & 8388607u));
}

@compute @workgroup_size(64, 1, 1)
fn particles(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e11 = params[u32(1i)];
    let count = u32(_e11);
    if (i >= count) {
        return;
    }
    let time = params[u32(0i)];
    let _e20 = gen__naga_sqrtf(bitcast<u32>(f32(count)));
    let side = u32(bitcast<f32>(_e20));
    let _e28 = gen__naga_divide_f32_(bitcast<u32>(f32((i % side))), bitcast<u32>(f32(side)));
    let x_1 = ((bitcast<f32>(_e28) * 2f) - 1f);
    let _e39 = gen__naga_divide_f32_(bitcast<u32>(f32((i / side))), bitcast<u32>(f32(side)));
    let y_1 = ((bitcast<f32>(_e39) * 2f) - 1f);
    let _e49 = gen__naga_sqrtf(bitcast<u32>(((x_1 * x_1) + (y_1 * y_1))));
    let distance_ = bitcast<f32>(_e49);
    let ripple = wave(((distance_ * 14f) - (time * 2f)));
    points[i].x = (x_1 * 0.84f);
    points[i].y = ((y_1 * 0.72f) + (ripple * 0.13f));
    points[i].z = (distance_ * 0.65f);
    points[i].w = (0.3f + ((ripple + 1f) * 0.25f));
}
