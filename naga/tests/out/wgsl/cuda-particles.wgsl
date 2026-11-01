@group(0) @binding(0)
var<storage, read_write> points: array<vec4<f32>>;
@group(0) @binding(1)
var<storage> params: array<f32>;

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
    let _e6 = gen__naga_floorf(bitcast<u32>(((angle / 6.2831855f) + 0.5f)));
    let x = (angle - (bitcast<f32>(_e6) * 6.2831855f));
    let _e16 = gen__naga_fabsf(bitcast<u32>(x));
    let y = ((1.2732395f * x) - ((0.4052847f * x) * bitcast<f32>(_e16)));
    let _e21 = gen__naga_fabsf(bitcast<u32>(y));
    return (y + (0.225f * ((y * bitcast<f32>(_e21)) - y)));
}

fn gen__naga_sqrtf(input_bits_2: u32) -> u32 {
    var significand: u32;
    var adjusted_exponent: u32;
    var upper_word: u32;
    var lower_word: u32;
    var root: u32;
    var remainder: u32;
    var iteration: u32;

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
    let _e75 = remainder;
    return (((_e33 >> 1u) << 23u) | (select(_e74, (_e74 + 1u), (_e75 > _e74)) & 8388607u));
}

@compute @workgroup_size(64, 1, 1)
fn particles(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;

    let i = ((blockIdx.x * 64u) + threadIdx.x);
    local = u32(1i);
    let _e10 = local;
    let _e13 = params[_e10];
    let count = u32(_e13);
    if (i >= count) {
        return;
    }
    local_1 = u32(0i);
    let _e19 = local_1;
    let time = params[_e19];
    let _e24 = gen__naga_sqrtf(bitcast<u32>(f32(count)));
    let side = u32(bitcast<f32>(_e24));
    let x_1 = (((f32((i % side)) / f32(side)) * 2f) - 1f);
    let y_1 = (((f32((i / side)) / f32(side)) * 2f) - 1f);
    let _e47 = gen__naga_sqrtf(bitcast<u32>(((x_1 * x_1) + (y_1 * y_1))));
    let distance_ = bitcast<f32>(_e47);
    let ripple = wave(((distance_ * 14f) - (time * 2f)));
    points[i].x = (x_1 * 0.84f);
    points[i].y = ((y_1 * 0.72f) + (ripple * 0.13f));
    points[i].z = (distance_ * 0.65f);
    points[i].w = (0.3f + ((ripple + 1f) * 0.25f));
}
