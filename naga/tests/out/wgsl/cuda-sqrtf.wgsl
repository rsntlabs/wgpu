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
    var local_40: i32;

    if value_5 {
        local_40 = 7i;
    } else {
        local_40 = 9i;
    }
    let _e6 = local_40;
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
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var value: f32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;

    let _e2 = gen__naga_sqrtf(bitcast<u32>(0f));
    local = u32(0i);
    let _e8 = local;
    out[_e8] = bitcast<u32>(bitcast<f32>(_e2));
    let _e14 = gen__naga_sqrtf(bitcast<u32>(-(0f)));
    local_1 = u32(1i);
    let _e20 = local_1;
    out[_e20] = bitcast<u32>(bitcast<f32>(_e14));
    let _e24 = gen__naga_sqrtf(bitcast<u32>(1f));
    local_2 = u32(2i);
    let _e30 = local_2;
    out[_e30] = bitcast<u32>(bitcast<f32>(_e24));
    let _e33 = root_2(4i);
    local_3 = u32(3i);
    let _e38 = local_3;
    out[_e38] = bitcast<u32>(_e33);
    let _e41 = root_3(9u);
    local_4 = u32(4i);
    let _e46 = local_4;
    out[_e46] = bitcast<u32>(_e41);
    let _e50 = gen__naga_sqrtf(bitcast<u32>(6.25f));
    local_5 = u32(5i);
    let _e56 = local_5;
    out[_e56] = bitcast<u32>(bitcast<f32>(_e50));
    let _e60 = gen__naga_sqrtf(bitcast<u32>(2f));
    local_6 = u32(6i);
    let _e66 = local_6;
    out[_e66] = bitcast<u32>(bitcast<f32>(_e60));
    local_8 = 1u;
    let _e70 = local_8;
    let _e73 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e70)));
    local_7 = u32(7i);
    let _e79 = local_7;
    out[_e79] = bitcast<u32>(bitcast<f32>(_e73));
    local_10 = 8388607u;
    let _e83 = local_10;
    let _e86 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e83)));
    local_9 = u32(8i);
    let _e92 = local_9;
    out[_e92] = bitcast<u32>(bitcast<f32>(_e86));
    local_12 = 8388608u;
    let _e96 = local_12;
    let _e99 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e96)));
    local_11 = u32(9i);
    let _e105 = local_11;
    out[_e105] = bitcast<u32>(bitcast<f32>(_e99));
    local_14 = 2139095039u;
    let _e109 = local_14;
    let _e112 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e109)));
    local_13 = u32(10i);
    let _e118 = local_13;
    out[_e118] = bitcast<u32>(bitcast<f32>(_e112));
    local_16 = 2139095040u;
    let _e122 = local_16;
    let _e125 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e122)));
    local_15 = u32(11i);
    let _e131 = local_15;
    out[_e131] = bitcast<u32>(bitcast<f32>(_e125));
    let _e136 = gen__naga_sqrtf(bitcast<u32>(-(1f)));
    local_17 = u32(12i);
    let _e142 = local_17;
    out[_e142] = bitcast<u32>(bitcast<f32>(_e136));
    local_19 = 2139095041u;
    let _e146 = local_19;
    let _e149 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e146)));
    local_18 = u32(13i);
    let _e155 = local_18;
    out[_e155] = bitcast<u32>(bitcast<f32>(_e149));
    value = 4f;
    let _e159 = value;
    value = (_e159 + f32(1i));
    let _e163 = root_1(_e159);
    local_20 = u32(14i);
    let _e168 = local_20;
    out[_e168] = bitcast<u32>(_e163);
    let _e170 = value;
    local_21 = u32(15i);
    let _e175 = local_21;
    out[_e175] = bitcast<u32>(_e170);
    let _e178 = sqrtf(true);
    local_22 = u32(16i);
    let _e183 = local_22;
    out[_e183] = u32(_e178);
    let _e186 = sqrtf(false);
    local_23 = u32(17i);
    let _e191 = local_23;
    out[_e191] = u32(_e186);
    let _e195 = sqrtf_1(2f, 3f);
    local_24 = u32(18i);
    let _e200 = local_24;
    out[_e200] = bitcast<u32>(_e195);
    local_26 = 1065353217u;
    let _e204 = local_26;
    let _e207 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e204)));
    local_25 = u32(19i);
    let _e213 = local_25;
    out[_e213] = bitcast<u32>(bitcast<f32>(_e207));
    local_28 = 1065353218u;
    let _e217 = local_28;
    let _e220 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e217)));
    local_27 = u32(20i);
    let _e226 = local_27;
    out[_e226] = bitcast<u32>(bitcast<f32>(_e220));
    local_30 = 1065353215u;
    let _e230 = local_30;
    let _e233 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e230)));
    local_29 = u32(21i);
    let _e239 = local_29;
    out[_e239] = bitcast<u32>(bitcast<f32>(_e233));
    let _e242 = root_3(4294967295u);
    local_31 = u32(22i);
    let _e247 = local_31;
    out[_e247] = bitcast<u32>(_e242);
    let _e251 = root_2(-(4i));
    local_32 = u32(23i);
    let _e256 = local_32;
    out[_e256] = bitcast<u32>(_e251);
    let _e259 = root_1(16f);
    local_33 = u32(24i);
    let _e264 = local_33;
    out[_e264] = bitcast<u32>(_e259);
    let _e268 = gen__naga_sqrtf(bitcast<u32>(0.25f));
    local_34 = u32(25i);
    let _e274 = local_34;
    out[_e274] = bitcast<u32>(bitcast<f32>(_e268));
    local_36 = 2147483649u;
    let _e278 = local_36;
    let _e281 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e278)));
    local_35 = u32(26i);
    let _e287 = local_35;
    out[_e287] = bitcast<u32>(bitcast<f32>(_e281));
    let _e290 = root_4(false);
    local_37 = u32(27i);
    let _e295 = local_37;
    out[_e295] = bitcast<u32>(_e290);
    let _e298 = root_4(true);
    local_38 = u32(28i);
    let _e303 = local_38;
    out[_e303] = bitcast<u32>(_e298);
    let _e306 = root_1(0.5f);
    local_39 = u32(29i);
    let _e311 = local_39;
    out[_e311] = bitcast<u32>(_e306);
}
