@group(0) @binding(0)
var<storage, read_write> points_1: array<vec4<f32>>;
@group(0) @binding(1)
var<storage> params_1: array<f32>;

fn wave(angle: f32) -> f32 {
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;

    let _e5 = bitcast<u32>(((angle / 6.2831855f) + 0.5f));
    let _e7 = (_e5 & 2147483647u);
    let _e11 = ((_e5 & 2147483648u) != 0u);
    let _e19 = (1u << ((150u - (_e7 >> 23u)) & 31u));
    let _e20 = (_e19 - 1u);
    let _e24 = (_e5 & ~(_e20));
    local_34 = select(select(select(select(_e24, (_e24 + _e19), (_e11 && ((_e5 & _e20) != 0u))), select(select(0u, 3212836864u, _e11), _e5, (_e7 == 0u)), (_e7 < 1065353216u)), _e5, (_e7 >= 1258291200u)), 2143289344u, (_e7 > 2139095040u));
    let _e43 = local_34;
    let x = (angle - (bitcast<f32>(_e43) * 6.2831855f));
    let _e54 = (bitcast<u32>(x) & 2147483647u);
    local_35 = select(_e54, 2143289344u, (_e54 > 2139095040u));
    let _e60 = local_35;
    let y = ((1.2732395f * x) - ((0.4052847f * x) * bitcast<f32>(_e60)));
    let _e66 = (bitcast<u32>(y) & 2147483647u);
    local_36 = select(_e66, 2143289344u, (_e66 > 2139095040u));
    let _e72 = local_36;
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
    var points: array<u32, 2>;
    var params: array<u32, 2>;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: f32;
    var local_13: f32;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var local_16: u32;
    var local_17: f32;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var local_20: u32;
    var local_21: f32;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var local_24: u32;
    var local_25: array<u32, 2>;
    var local_26: u32;
    var local_27: u32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var local_30: u32;
    var local_31: array<u32, 2>;
    var local_32: u32;
    var local_33: u32;

    points = array<u32, 2>();
    points[0] = 0u;
    points[1] = 0u;
    params = array<u32, 2>();
    params[0] = 1u;
    params[1] = 0u;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e20 = params;
    local = _e20;
    local_1 = u32(1i);
    let _e25 = local;
    local_14 = _e25;
    let _e27 = local_1;
    let _e29 = local_14[1];
    local_14[1] = (_e29 + _e27);
    let _e33 = local_14[0];
    local_15 = u32(_e33);
    let _e37 = local_14[1];
    local_16 = u32(_e37);
    let _e40 = local_16;
    let _e43 = params_1[_e40];
    local_17 = _e43;
    let _e45 = local_17;
    local_12 = _e45;
    let _e47 = local_12;
    let count = u32(_e47);
    if (i >= count) {
        return;
    }
    let _e50 = params;
    local_2 = _e50;
    local_3 = u32(0i);
    let _e55 = local_2;
    local_18 = _e55;
    let _e57 = local_3;
    let _e59 = local_18[1];
    local_18[1] = (_e59 + _e57);
    let _e63 = local_18[0];
    local_19 = u32(_e63);
    let _e67 = local_18[1];
    local_20 = u32(_e67);
    let _e70 = local_20;
    let _e72 = params_1[_e70];
    local_21 = _e72;
    let _e74 = local_21;
    local_13 = _e74;
    let time = local_13;
    let _e79 = gen__naga_sqrtf(bitcast<u32>(f32(count)));
    let side = u32(bitcast<f32>(_e79));
    let x_1 = (((f32((i % side)) / f32(side)) * 2f) - 1f);
    let y_1 = (((f32((i / side)) / f32(side)) * 2f) - 1f);
    let _e102 = gen__naga_sqrtf(bitcast<u32>(((x_1 * x_1) + (y_1 * y_1))));
    let distance_ = bitcast<f32>(_e102);
    let ripple = wave(((distance_ * 14f) - (time * 2f)));
    let _e113 = points;
    local_4 = _e113;
    local_5 = u32(i);
    let _e117 = local_4;
    local_22 = _e117;
    let _e119 = local_5;
    let _e121 = local_22[1];
    local_22[1] = (_e121 + _e119);
    let _e125 = local_22[0];
    local_23 = u32(_e125);
    let _e129 = local_22[1];
    local_24 = u32(_e129);
    let _e132 = local_24;
    points_1[_e132].x = (x_1 * 0.84f);
    let _e141 = points;
    local_6 = _e141;
    local_7 = u32(i);
    let _e145 = local_6;
    local_25 = _e145;
    let _e147 = local_7;
    let _e149 = local_25[1];
    local_25[1] = (_e149 + _e147);
    let _e153 = local_25[0];
    local_26 = u32(_e153);
    let _e157 = local_25[1];
    local_27 = u32(_e157);
    let _e160 = local_27;
    points_1[_e160].y = ((y_1 * 0.72f) + (ripple * 0.13f));
    let _e165 = points;
    local_8 = _e165;
    local_9 = u32(i);
    let _e169 = local_8;
    local_28 = _e169;
    let _e171 = local_9;
    let _e173 = local_28[1];
    local_28[1] = (_e173 + _e171);
    let _e177 = local_28[0];
    local_29 = u32(_e177);
    let _e181 = local_28[1];
    local_30 = u32(_e181);
    let _e184 = local_30;
    points_1[_e184].z = (distance_ * 0.65f);
    let _e193 = points;
    local_10 = _e193;
    local_11 = u32(i);
    let _e197 = local_10;
    local_31 = _e197;
    let _e199 = local_11;
    let _e201 = local_31[1];
    local_31[1] = (_e201 + _e199);
    let _e205 = local_31[0];
    local_32 = u32(_e205);
    let _e209 = local_31[1];
    local_33 = u32(_e209);
    let _e212 = local_33;
    points_1[_e212].w = (0.3f + ((ripple + 1f) * 0.25f));
}
