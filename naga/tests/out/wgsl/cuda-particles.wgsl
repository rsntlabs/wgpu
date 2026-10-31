@group(0) @binding(0)
var<storage, read_write> points: array<vec4<f32>>;
@group(0) @binding(1)
var<storage> params: array<f32>;

fn wave(angle: f32) -> f32 {
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;

    let _e5 = bitcast<u32>(((angle / 6.2831855f) + 0.5f));
    let _e7 = (_e5 & 2147483647u);
    let _e11 = ((_e5 & 2147483648u) != 0u);
    let _e19 = (1u << ((150u - (_e7 >> 23u)) & 31u));
    let _e20 = (_e19 - 1u);
    let _e24 = (_e5 & ~(_e20));
    local_16 = select(select(select(select(_e24, (_e24 + _e19), (_e11 && ((_e5 & _e20) != 0u))), select(select(0u, 3212836864u, _e11), _e5, (_e7 == 0u)), (_e7 < 1065353216u)), _e5, (_e7 >= 1258291200u)), 2143289344u, (_e7 > 2139095040u));
    let _e43 = local_16;
    let x = (angle - (bitcast<f32>(_e43) * 6.2831855f));
    let _e54 = (bitcast<u32>(x) & 2147483647u);
    local_17 = select(_e54, 2143289344u, (_e54 > 2139095040u));
    let _e60 = local_17;
    let y = ((1.2732395f * x) - ((0.4052847f * x) * bitcast<f32>(_e60)));
    let _e66 = (bitcast<u32>(y) & 2147483647u);
    local_18 = select(_e66, 2143289344u, (_e66 > 2139095040u));
    let _e72 = local_18;
    return (y + (0.225f * ((y * bitcast<f32>(_e72)) - y)));
}

fn gen__naga_sqrtf(input_bits: u32) -> u32 {
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
    let _e75 = remainder;
    return (((_e33 >> 1u) << 23u) | (select(_e74, (_e74 + 1u), (_e75 > _e74)) & 8388607u));
}

@compute @workgroup_size(64, 1, 1)
fn particles(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: f32;
    var local_7: f32;
    var local_8: u32;
    var local_9: f32;
    var local_10: u32;
    var local_11: f32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;

    let i = ((blockIdx.x * 64u) + threadIdx.x);
    local = u32(1i);
    let _e10 = local;
    local_8 = u32(_e10);
    let _e13 = local_8;
    let _e16 = params[_e13];
    local_9 = _e16;
    let _e18 = local_9;
    local_6 = _e18;
    let _e20 = local_6;
    let count = u32(_e20);
    if (i >= count) {
        return;
    }
    local_1 = u32(0i);
    let _e26 = local_1;
    local_10 = u32(_e26);
    let _e29 = local_10;
    let _e31 = params[_e29];
    local_11 = _e31;
    let _e33 = local_11;
    local_7 = _e33;
    let time = local_7;
    let _e38 = gen__naga_sqrtf(bitcast<u32>(f32(count)));
    let side = u32(bitcast<f32>(_e38));
    let x_1 = (((f32((i % side)) / f32(side)) * 2f) - 1f);
    let y_1 = (((f32((i / side)) / f32(side)) * 2f) - 1f);
    let _e61 = gen__naga_sqrtf(bitcast<u32>(((x_1 * x_1) + (y_1 * y_1))));
    let distance_ = bitcast<f32>(_e61);
    let ripple = wave(((distance_ * 14f) - (time * 2f)));
    local_2 = u32(i);
    let _e73 = local_2;
    local_12 = u32(_e73);
    let _e76 = local_12;
    points[_e76].x = (x_1 * 0.84f);
    local_3 = u32(i);
    let _e87 = local_3;
    local_13 = u32(_e87);
    let _e90 = local_13;
    points[_e90].y = ((y_1 * 0.72f) + (ripple * 0.13f));
    local_4 = u32(i);
    let _e97 = local_4;
    local_14 = u32(_e97);
    let _e100 = local_14;
    points[_e100].z = (distance_ * 0.65f);
    local_5 = u32(i);
    let _e111 = local_5;
    local_15 = u32(_e111);
    let _e114 = local_15;
    points[_e114].w = (0.3f + ((ripple + 1f) * 0.25f));
}
