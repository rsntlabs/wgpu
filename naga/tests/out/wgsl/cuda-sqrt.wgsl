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
    var local_3: i32;

    if value_4 {
        local_3 = 7i;
    } else {
        local_3 = 9i;
    }
    let _e6 = local_3;
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
    var value: f32;
    var pair: vec2<f32>;

    let _e2 = gen__naga_sqrtf(bitcast<u32>(0f));
    output[u32(0i)] = bitcast<u32>(bitcast<f32>(_e2));
    let _e12 = gen__naga_sqrtf(bitcast<u32>(-(0f)));
    output[u32(1i)] = bitcast<u32>(bitcast<f32>(_e12));
    let _e19 = root_1(6.25f);
    output[u32(2i)] = bitcast<u32>(_e19);
    let _e26 = gen__naga_sqrtf(bitcast<u32>(9f));
    output[u32(3i)] = bitcast<u32>(bitcast<f32>(_e26));
    let _e34 = sqrt_(-(3i));
    output[u32(4i)] = u32(_e34);
    let _e40 = sqrt_1(3u);
    output[u32(5i)] = _e40;
    let _e45 = sqrt_2(true);
    output[u32(6i)] = u32(_e45);
    let _e51 = sqrt_2(false);
    output[u32(7i)] = u32(_e51);
    local = 1u;
    let _e58 = local;
    let _e61 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e58)));
    output[u32(8i)] = bitcast<u32>(bitcast<f32>(_e61));
    local_1 = 2139095040u;
    let _e69 = local_1;
    let _e72 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e69)));
    output[u32(9i)] = bitcast<u32>(bitcast<f32>(_e72));
    let _e81 = gen__naga_sqrtf(bitcast<u32>(-(4f)));
    output[u32(10i)] = bitcast<u32>(bitcast<f32>(_e81));
    local_2 = 2139095041u;
    let _e89 = local_2;
    let _e92 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e89)));
    output[u32(11i)] = bitcast<u32>(bitcast<f32>(_e92));
    value = 4f;
    let _e100 = value;
    value = (_e100 + f32(1i));
    let _e105 = gen__naga_sqrtf(bitcast<u32>(_e100));
    output[u32(12i)] = bitcast<u32>(bitcast<f32>(_e105));
    let _e111 = value;
    output[u32(13i)] = bitcast<u32>(_e111);
    let _e118 = sqrt_3(3i, 4i);
    output[u32(14i)] = u32(_e118);
    let _e125 = root_1(f32(16i));
    output[u32(15i)] = bitcast<u32>(_e125);
    let _e133 = sqrt_4(vec2<f32>(9f, 16f));
    pair = _e133;
    let _e136 = pair.x;
    output[u32(16i)] = bitcast<u32>(_e136);
    let _e142 = pair.y;
    output[u32(17i)] = bitcast<u32>(_e142);
}
