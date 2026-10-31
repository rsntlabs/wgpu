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
    var local_70: i32;

    if value_5 {
        local_70 = 7i;
    } else {
        local_70 = 9i;
    }
    let _e6 = local_70;
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
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;
    var local_58: u32;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: u32;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;
    var local_66: u32;
    var local_67: u32;
    var local_68: u32;
    var local_69: u32;

    let _e2 = gen__naga_sqrtf(bitcast<u32>(0f));
    local = u32(0i);
    let _e9 = local;
    local_40 = u32(_e9);
    let _e12 = local_40;
    out[_e12] = bitcast<u32>(bitcast<f32>(_e2));
    let _e17 = gen__naga_sqrtf(bitcast<u32>(-(0f)));
    local_1 = u32(1i);
    let _e23 = local_1;
    local_41 = u32(_e23);
    let _e26 = local_41;
    out[_e26] = bitcast<u32>(bitcast<f32>(_e17));
    let _e30 = gen__naga_sqrtf(bitcast<u32>(1f));
    local_2 = u32(2i);
    let _e36 = local_2;
    local_42 = u32(_e36);
    let _e39 = local_42;
    out[_e39] = bitcast<u32>(bitcast<f32>(_e30));
    let _e42 = root_2(4i);
    local_3 = u32(3i);
    let _e47 = local_3;
    local_43 = u32(_e47);
    let _e50 = local_43;
    out[_e50] = bitcast<u32>(_e42);
    let _e53 = root_3(9u);
    local_4 = u32(4i);
    let _e58 = local_4;
    local_44 = u32(_e58);
    let _e61 = local_44;
    out[_e61] = bitcast<u32>(_e53);
    let _e65 = gen__naga_sqrtf(bitcast<u32>(6.25f));
    local_5 = u32(5i);
    let _e71 = local_5;
    local_45 = u32(_e71);
    let _e74 = local_45;
    out[_e74] = bitcast<u32>(bitcast<f32>(_e65));
    let _e78 = gen__naga_sqrtf(bitcast<u32>(2f));
    local_6 = u32(6i);
    let _e84 = local_6;
    local_46 = u32(_e84);
    let _e87 = local_46;
    out[_e87] = bitcast<u32>(bitcast<f32>(_e78));
    local_8 = 1u;
    let _e91 = local_8;
    let _e94 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e91)));
    local_7 = u32(7i);
    let _e100 = local_7;
    local_47 = u32(_e100);
    let _e103 = local_47;
    out[_e103] = bitcast<u32>(bitcast<f32>(_e94));
    local_10 = 8388607u;
    let _e107 = local_10;
    let _e110 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e107)));
    local_9 = u32(8i);
    let _e116 = local_9;
    local_48 = u32(_e116);
    let _e119 = local_48;
    out[_e119] = bitcast<u32>(bitcast<f32>(_e110));
    local_12 = 8388608u;
    let _e123 = local_12;
    let _e126 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e123)));
    local_11 = u32(9i);
    let _e132 = local_11;
    local_49 = u32(_e132);
    let _e135 = local_49;
    out[_e135] = bitcast<u32>(bitcast<f32>(_e126));
    local_14 = 2139095039u;
    let _e139 = local_14;
    let _e142 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e139)));
    local_13 = u32(10i);
    let _e148 = local_13;
    local_50 = u32(_e148);
    let _e151 = local_50;
    out[_e151] = bitcast<u32>(bitcast<f32>(_e142));
    local_16 = 2139095040u;
    let _e155 = local_16;
    let _e158 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e155)));
    local_15 = u32(11i);
    let _e164 = local_15;
    local_51 = u32(_e164);
    let _e167 = local_51;
    out[_e167] = bitcast<u32>(bitcast<f32>(_e158));
    let _e172 = gen__naga_sqrtf(bitcast<u32>(-(1f)));
    local_17 = u32(12i);
    let _e178 = local_17;
    local_52 = u32(_e178);
    let _e181 = local_52;
    out[_e181] = bitcast<u32>(bitcast<f32>(_e172));
    local_19 = 2139095041u;
    let _e185 = local_19;
    let _e188 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e185)));
    local_18 = u32(13i);
    let _e194 = local_18;
    local_53 = u32(_e194);
    let _e197 = local_53;
    out[_e197] = bitcast<u32>(bitcast<f32>(_e188));
    value = 4f;
    let _e201 = value;
    value = (_e201 + f32(1i));
    let _e205 = root_1(_e201);
    local_20 = u32(14i);
    let _e210 = local_20;
    local_54 = u32(_e210);
    let _e213 = local_54;
    out[_e213] = bitcast<u32>(_e205);
    let _e215 = value;
    local_21 = u32(15i);
    let _e220 = local_21;
    local_55 = u32(_e220);
    let _e223 = local_55;
    out[_e223] = bitcast<u32>(_e215);
    let _e226 = sqrtf(true);
    local_22 = u32(16i);
    let _e231 = local_22;
    local_56 = u32(_e231);
    let _e234 = local_56;
    out[_e234] = u32(_e226);
    let _e237 = sqrtf(false);
    local_23 = u32(17i);
    let _e242 = local_23;
    local_57 = u32(_e242);
    let _e245 = local_57;
    out[_e245] = u32(_e237);
    let _e249 = sqrtf_1(2f, 3f);
    local_24 = u32(18i);
    let _e254 = local_24;
    local_58 = u32(_e254);
    let _e257 = local_58;
    out[_e257] = bitcast<u32>(_e249);
    local_26 = 1065353217u;
    let _e261 = local_26;
    let _e264 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e261)));
    local_25 = u32(19i);
    let _e270 = local_25;
    local_59 = u32(_e270);
    let _e273 = local_59;
    out[_e273] = bitcast<u32>(bitcast<f32>(_e264));
    local_28 = 1065353218u;
    let _e277 = local_28;
    let _e280 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e277)));
    local_27 = u32(20i);
    let _e286 = local_27;
    local_60 = u32(_e286);
    let _e289 = local_60;
    out[_e289] = bitcast<u32>(bitcast<f32>(_e280));
    local_30 = 1065353215u;
    let _e293 = local_30;
    let _e296 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e293)));
    local_29 = u32(21i);
    let _e302 = local_29;
    local_61 = u32(_e302);
    let _e305 = local_61;
    out[_e305] = bitcast<u32>(bitcast<f32>(_e296));
    let _e308 = root_3(4294967295u);
    local_31 = u32(22i);
    let _e313 = local_31;
    local_62 = u32(_e313);
    let _e316 = local_62;
    out[_e316] = bitcast<u32>(_e308);
    let _e320 = root_2(-(4i));
    local_32 = u32(23i);
    let _e325 = local_32;
    local_63 = u32(_e325);
    let _e328 = local_63;
    out[_e328] = bitcast<u32>(_e320);
    let _e331 = root_1(16f);
    local_33 = u32(24i);
    let _e336 = local_33;
    local_64 = u32(_e336);
    let _e339 = local_64;
    out[_e339] = bitcast<u32>(_e331);
    let _e343 = gen__naga_sqrtf(bitcast<u32>(0.25f));
    local_34 = u32(25i);
    let _e349 = local_34;
    local_65 = u32(_e349);
    let _e352 = local_65;
    out[_e352] = bitcast<u32>(bitcast<f32>(_e343));
    local_36 = 2147483649u;
    let _e356 = local_36;
    let _e359 = gen__naga_sqrtf(bitcast<u32>(bitcast<f32>(_e356)));
    local_35 = u32(26i);
    let _e365 = local_35;
    local_66 = u32(_e365);
    let _e368 = local_66;
    out[_e368] = bitcast<u32>(bitcast<f32>(_e359));
    let _e371 = root_4(false);
    local_37 = u32(27i);
    let _e376 = local_37;
    local_67 = u32(_e376);
    let _e379 = local_67;
    out[_e379] = bitcast<u32>(_e371);
    let _e382 = root_4(true);
    local_38 = u32(28i);
    let _e387 = local_38;
    local_68 = u32(_e387);
    let _e390 = local_68;
    out[_e390] = bitcast<u32>(_e382);
    let _e393 = root_1(0.5f);
    local_39 = u32(29i);
    let _e398 = local_39;
    local_69 = u32(_e398);
    let _e401 = local_69;
    out[_e401] = bitcast<u32>(_e393);
}
