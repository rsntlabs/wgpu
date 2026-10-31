@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

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

fn root_1(value_1: f32) -> f32 {
    let _e2 = gen__naga_sqrtf(bitcast<u32>(value_1));
    return bitcast<f32>(_e2);
}

fn sqrt_(value_2: i32) -> i32 {
    return (value_2 + 40i);
}

fn sqrt_1(value_3: u32) -> u32 {
    return (value_3 + 50u);
}

fn sqrt_2(value_4: bool) -> i32 {
    var local_21: i32;

    if value_4 {
        local_21 = 7i;
    } else {
        local_21 = 9i;
    }
    let _e6 = local_21;
    return _e6;
}

fn sqrt_3(first: i32, second: i32) -> i32 {
    return (first + second);
}

fn sqrt_4(value_5: vec2<f32>) -> vec2<f32> {
    var value_6: vec2<f32>;

    value_6 = value_5;
    let _e3 = value_6.x;
    let _e5 = gen__naga_sqrtf(bitcast<u32>(_e3));
    let _e8 = value_6.y;
    let _e10 = gen__naga_sqrtf(bitcast<u32>(_e8));
    return vec2<f32>(bitcast<f32>(_e5), bitcast<f32>(_e10));
}

@compute @workgroup_size(1, 1, 1)
fn roots() {
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
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var pair: vec2<f32>;
    var local_19: u32;
    var local_20: u32;

    let _e2 = gen__naga_sqrtf(bitcast<u32>(0f));
    local = u32(0i);
    let _e8 = local;
    output[_e8] = bitcast<u32>(bitcast<f32>(_e2));
    let _e14 = gen__naga_sqrtf(bitcast<u32>(-(0f)));
    local_1 = u32(1i);
    let _e20 = local_1;
    output[_e20] = bitcast<u32>(bitcast<f32>(_e14));
    let _e23 = root_1(6.25f);
    local_2 = u32(2i);
    let _e28 = local_2;
    output[_e28] = bitcast<u32>(_e23);
    let _e32 = gen__naga_sqrtf(bitcast<u32>(9f));
    local_3 = u32(3i);
    let _e38 = local_3;
    output[_e38] = bitcast<u32>(bitcast<f32>(_e32));
    let _e42 = sqrt_(-(3i));
    local_4 = u32(4i);
    let _e47 = local_4;
    output[_e47] = u32(_e42);
    let _e50 = sqrt_1(3u);
    local_5 = u32(5i);
    let _e54 = local_5;
    output[_e54] = _e50;
    let _e57 = sqrt_2(true);
    local_6 = u32(6i);
    let _e62 = local_6;
    output[_e62] = u32(_e57);
    let _e65 = sqrt_2(false);
    local_7 = u32(7i);
    let _e70 = local_7;
    output[_e70] = u32(_e65);
    local_9 = 1u;
    let _e74 = local_9;
    let _e77 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e74)));
    local_8 = u32(8i);
    let _e83 = local_8;
    output[_e83] = bitcast<u32>(bitcast<f32>(_e77));
    local_11 = 2139095040u;
    let _e87 = local_11;
    let _e90 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e87)));
    local_10 = u32(9i);
    let _e96 = local_10;
    output[_e96] = bitcast<u32>(bitcast<f32>(_e90));
    let _e101 = gen__naga_sqrtf(bitcast<u32>(-(4f)));
    local_12 = u32(10i);
    let _e107 = local_12;
    output[_e107] = bitcast<u32>(bitcast<f32>(_e101));
    local_14 = 2139095041u;
    let _e111 = local_14;
    let _e114 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e111)));
    local_13 = u32(11i);
    let _e120 = local_13;
    output[_e120] = bitcast<u32>(bitcast<f32>(_e114));
    value = 4f;
    let _e124 = value;
    value = (_e124 + f32(1i));
    let _e129 = gen__naga_sqrtf(bitcast<u32>(_e124));
    local_15 = u32(12i);
    let _e135 = local_15;
    output[_e135] = bitcast<u32>(bitcast<f32>(_e129));
    let _e137 = value;
    local_16 = u32(13i);
    let _e142 = local_16;
    output[_e142] = bitcast<u32>(_e137);
    let _e146 = sqrt_3(3i, 4i);
    local_17 = u32(14i);
    let _e151 = local_17;
    output[_e151] = u32(_e146);
    let _e155 = root_1(f32(16i));
    local_18 = u32(15i);
    let _e160 = local_18;
    output[_e160] = bitcast<u32>(_e155);
    let _e165 = sqrt_4(vec2<f32>(9f, 16f));
    pair = _e165;
    let _e168 = pair.x;
    local_19 = u32(16i);
    let _e173 = local_19;
    output[_e173] = bitcast<u32>(_e168);
    let _e176 = pair.y;
    local_20 = u32(17i);
    let _e181 = local_20;
    output[_e181] = bitcast<u32>(_e176);
}
