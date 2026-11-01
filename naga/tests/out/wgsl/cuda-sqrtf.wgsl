@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

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

fn root_2(value_2: i32) -> f32 {
    let _e3 = gen__naga_sqrtf(bitcast<u32>(f32(value_2)));
    return bitcast<f32>(_e3);
}

fn root_3(value_3: u32) -> f32 {
    let _e3 = gen__naga_sqrtf(bitcast<u32>(f32(value_3)));
    return bitcast<f32>(_e3);
}

fn root_4(value_4: bool) -> f32 {
    let _e3 = gen__naga_sqrtf(bitcast<u32>(f32(value_4)));
    return bitcast<f32>(_e3);
}

fn sqrtf(value_5: bool) -> i32 {
    var local_10: i32;

    if value_5 {
        local_10 = 7i;
    } else {
        local_10 = 9i;
    }
    let _e6 = local_10;
    return _e6;
}

fn sqrtf_1(first: f32, second: f32) -> f32 {
    return (first + second);
}

@compute @workgroup_size(1, 1, 1)
fn roots() {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var value: f32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;

    let _e2 = gen__naga_sqrtf(bitcast<u32>(0f));
    out[u32(0i)] = bitcast<u32>(bitcast<f32>(_e2));
    let _e12 = gen__naga_sqrtf(bitcast<u32>(-(0f)));
    out[u32(1i)] = bitcast<u32>(bitcast<f32>(_e12));
    let _e20 = gen__naga_sqrtf(bitcast<u32>(1f));
    out[u32(2i)] = bitcast<u32>(bitcast<f32>(_e20));
    let _e27 = root_2(4i);
    out[u32(3i)] = bitcast<u32>(_e27);
    let _e33 = root_3(9u);
    out[u32(4i)] = bitcast<u32>(_e33);
    let _e40 = gen__naga_sqrtf(bitcast<u32>(6.25f));
    out[u32(5i)] = bitcast<u32>(bitcast<f32>(_e40));
    let _e48 = gen__naga_sqrtf(bitcast<u32>(2f));
    out[u32(6i)] = bitcast<u32>(bitcast<f32>(_e48));
    local = 1u;
    let _e56 = local;
    let _e59 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e56)));
    out[u32(7i)] = bitcast<u32>(bitcast<f32>(_e59));
    local_1 = 8388607u;
    let _e67 = local_1;
    let _e70 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e67)));
    out[u32(8i)] = bitcast<u32>(bitcast<f32>(_e70));
    local_2 = 8388608u;
    let _e78 = local_2;
    let _e81 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e78)));
    out[u32(9i)] = bitcast<u32>(bitcast<f32>(_e81));
    local_3 = 2139095039u;
    let _e89 = local_3;
    let _e92 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e89)));
    out[u32(10i)] = bitcast<u32>(bitcast<f32>(_e92));
    local_4 = 2139095040u;
    let _e100 = local_4;
    let _e103 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e100)));
    out[u32(11i)] = bitcast<u32>(bitcast<f32>(_e103));
    let _e112 = gen__naga_sqrtf(bitcast<u32>(-(1f)));
    out[u32(12i)] = bitcast<u32>(bitcast<f32>(_e112));
    local_5 = 2139095041u;
    let _e120 = local_5;
    let _e123 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e120)));
    out[u32(13i)] = bitcast<u32>(bitcast<f32>(_e123));
    value = 4f;
    let _e131 = value;
    value = (_e131 + f32(1i));
    let _e135 = root_1(_e131);
    out[u32(14i)] = bitcast<u32>(_e135);
    let _e140 = value;
    out[u32(15i)] = bitcast<u32>(_e140);
    let _e146 = sqrtf(true);
    out[u32(16i)] = u32(_e146);
    let _e152 = sqrtf(false);
    out[u32(17i)] = u32(_e152);
    let _e159 = sqrtf_1(2f, 3f);
    out[u32(18i)] = bitcast<u32>(_e159);
    local_6 = 1065353217u;
    let _e166 = local_6;
    let _e169 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e166)));
    out[u32(19i)] = bitcast<u32>(bitcast<f32>(_e169));
    local_7 = 1065353218u;
    let _e177 = local_7;
    let _e180 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e177)));
    out[u32(20i)] = bitcast<u32>(bitcast<f32>(_e180));
    local_8 = 1065353215u;
    let _e188 = local_8;
    let _e191 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e188)));
    out[u32(21i)] = bitcast<u32>(bitcast<f32>(_e191));
    let _e198 = root_3(4294967295u);
    out[u32(22i)] = bitcast<u32>(_e198);
    let _e205 = root_2(-(4i));
    out[u32(23i)] = bitcast<u32>(_e205);
    let _e211 = root_1(16f);
    out[u32(24i)] = bitcast<u32>(_e211);
    let _e218 = gen__naga_sqrtf(bitcast<u32>(0.25f));
    out[u32(25i)] = bitcast<u32>(bitcast<f32>(_e218));
    local_9 = 2147483649u;
    let _e226 = local_9;
    let _e229 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e226)));
    out[u32(26i)] = bitcast<u32>(bitcast<f32>(_e229));
    let _e236 = root_4(false);
    out[u32(27i)] = bitcast<u32>(_e236);
    let _e242 = root_4(true);
    out[u32(28i)] = bitcast<u32>(_e242);
    let _e248 = root_1(0.5f);
    out[u32(29i)] = bitcast<u32>(_e248);
}
