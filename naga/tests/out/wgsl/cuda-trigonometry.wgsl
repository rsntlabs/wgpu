@group(0) @binding(0)
var<storage, read_write> out: array<u32>;

fn gen__naga_trig_multiply(left: array<u32, 12>, right: array<u32, 12>) -> array<u32, 12> {
    var left_digits: array<u32, 12> = array<u32, 12>();
    var right_digits: array<u32, 12> = array<u32, 12>();
    var product: array<u32, 24> = array<u32, 24>();
    var carry: u32 = u32();
    var left_index: u32 = u32();
    var right_index: u32 = u32();
    var result: array<u32, 12> = array<u32, 12>();
    var result_index: u32 = u32();

    left_digits = left;
    right_digits = right;
    left_index = 0u;
    loop {
        let _e13 = left_index;
        if (_e13 >= 12u) {
            break;
        }
        carry = 0u;
        let _e18 = left_digits[_e13];
        right_index = 0u;
        loop {
            let _e22 = right_index;
            if (_e22 >= 12u) {
                break;
            }
            let _e26 = right_digits[_e22];
            let _e27 = (_e13 + _e22);
            let _e29 = product[_e27];
            let _e30 = carry;
            let _e33 = (((_e18 * _e26) + _e29) + _e30);
            product[_e27] = (_e33 & 65535u);
            carry = (_e33 >> 16u);
            continuing {
                let _e39 = right_index;
                right_index = (_e39 + 1u);
            }
        }
        let _e44 = carry;
        product[(_e13 + 12u)] = _e44;
        continuing {
            let _e46 = left_index;
            left_index = (_e46 + 1u);
        }
    }
    result_index = 0u;
    loop {
        let _e54 = result_index;
        if (_e54 >= 12u) {
            break;
        }
        let _e60 = product[(_e54 + 11u)];
        result[_e54] = _e60;
        continuing {
            let _e62 = result_index;
            result_index = (_e62 + 1u);
        }
    }
    let _e65 = result;
    return _e65;
}

fn gen__naga_trig_reduce_multiply(left_1: array<u32, 2>, right_1: array<u32, 20>) -> array<u32, 22> {
    var left_digits_1: array<u32, 2> = array<u32, 2>();
    var right_digits_1: array<u32, 20> = array<u32, 20>();
    var product_1: array<u32, 22> = array<u32, 22>();
    var carry_1: u32 = u32();
    var left_index_1: u32 = u32();
    var right_index_1: u32 = u32();
    var result_1: array<u32, 22> = array<u32, 22>();
    var result_index_1: u32 = u32();

    left_digits_1 = left_1;
    right_digits_1 = right_1;
    left_index_1 = 0u;
    loop {
        let _e13 = left_index_1;
        if (_e13 >= 2u) {
            break;
        }
        carry_1 = 0u;
        let _e18 = left_digits_1[_e13];
        right_index_1 = 0u;
        loop {
            let _e22 = right_index_1;
            if (_e22 >= 20u) {
                break;
            }
            let _e26 = right_digits_1[_e22];
            let _e27 = (_e13 + _e22);
            let _e29 = product_1[_e27];
            let _e30 = carry_1;
            let _e33 = (((_e18 * _e26) + _e29) + _e30);
            product_1[_e27] = (_e33 & 65535u);
            carry_1 = (_e33 >> 16u);
            continuing {
                let _e39 = right_index_1;
                right_index_1 = (_e39 + 1u);
            }
        }
        let _e44 = carry_1;
        product_1[(_e13 + 20u)] = _e44;
        continuing {
            let _e46 = left_index_1;
            left_index_1 = (_e46 + 1u);
        }
    }
    result_index_1 = 0u;
    loop {
        let _e54 = result_index_1;
        if (_e54 >= 22u) {
            break;
        }
        let _e60 = product_1[(_e54 + 0u)];
        result_1[_e54] = _e60;
        continuing {
            let _e62 = result_index_1;
            result_index_1 = (_e62 + 1u);
        }
    }
    let _e65 = result_1;
    return _e65;
}

fn gen__naga_trig_divide(value_1: array<u32, 12>, divisor: u32) -> array<u32, 12> {
    var source: array<u32, 12> = array<u32, 12>();
    var result_2: array<u32, 12> = array<u32, 12>();
    var remainder: u32 = u32();
    var step_: u32 = u32();

    source = value_1;
    step_ = 0u;
    loop {
        let _e11 = step_;
        if (_e11 >= 12u) {
            break;
        }
        let _e15 = (11u - _e11);
        let _e16 = remainder;
        let _e20 = source[_e15];
        let _e21 = ((_e16 << 16u) | _e20);
        result_2[_e15] = (_e21 / divisor);
        remainder = (_e21 % divisor);
        continuing {
            let _e25 = step_;
            step_ = (_e25 + 1u);
        }
    }
    let _e28 = result_2;
    return _e28;
}

fn gen__naga_trig_combine(left_2: array<u32, 12>, right_2: array<u32, 12>, subtract: u32) -> array<u32, 12> {
    var left_digits_2: array<u32, 12> = array<u32, 12>();
    var right_digits_2: array<u32, 12> = array<u32, 12>();
    var result_3: array<u32, 12> = array<u32, 12>();
    var carry_2: u32 = u32();
    var digit_index: u32 = u32();

    left_digits_2 = left_2;
    right_digits_2 = right_2;
    let _e12 = (subtract != 0u);
    digit_index = 0u;
    loop {
        let _e16 = digit_index;
        if (_e16 >= 12u) {
            break;
        }
        let _e20 = left_digits_2[_e16];
        let _e22 = right_digits_2[_e16];
        let _e23 = carry_2;
        let _e24 = (_e22 + _e23);
        let _e26 = (_e20 + _e24);
        result_3[_e16] = (select(_e26, (_e20 - _e24), _e12) & 65535u);
        carry_2 = select((_e26 >> 16u), select(0u, 1u, (_e20 < _e24)), _e12);
        continuing {
            let _e38 = digit_index;
            digit_index = (_e38 + 1u);
        }
    }
    let _e41 = result_3;
    return _e41;
}

fn gen__naga_trig_extract_product(digits: array<u32, 22>, offset: u32) -> u32 {
    var source_1: array<u32, 22> = array<u32, 22>();
    var low: u32 = u32();
    var high: u32 = u32();

    source_1 = digits;
    let _e5 = (offset / 16u);
    let _e7 = (offset % 16u);
    let _e13 = (_e5 + 0u);
    if (_e13 < 22u) {
        let _e17 = source_1[_e13];
        low = _e17;
    }
    let _e19 = (_e5 + 1u);
    if (_e19 < 22u) {
        let _e23 = source_1[_e19];
        high = _e23;
    }
    let _e24 = low;
    let _e25 = high;
    return (((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u);
}

fn gen__naga_trig_extract_fixed(digits_1: array<u32, 12>, offset_1: u32) -> u32 {
    var source_2: array<u32, 12> = array<u32, 12>();
    var low_1: u32 = u32();
    var high_1: u32 = u32();

    source_2 = digits_1;
    let _e5 = (offset_1 / 16u);
    let _e7 = (offset_1 % 16u);
    let _e13 = (_e5 + 0u);
    if (_e13 < 12u) {
        let _e17 = source_2[_e13];
        low_1 = _e17;
    }
    let _e19 = (_e5 + 1u);
    if (_e19 < 12u) {
        let _e23 = source_2[_e19];
        high_1 = _e23;
    }
    let _e24 = low_1;
    let _e25 = high_1;
    return (((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u);
}

fn gen__naga_trig_kernel(angle: array<u32, 12>, sine: u32) -> array<u32, 12> {
    var term: array<u32, 12> = array<u32, 12>();
    var total: array<u32, 12> = array<u32, 12>();
    var step_1: u32 = u32();

    let _e7 = (sine != 0u);
    if _e7 {
        term = angle;
    } else {
        term = array<u32, 12>(0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u);
    }
    let _e21 = term;
    total = _e21;
    let _e22 = gen__naga_trig_multiply(angle, angle);
    step_1 = 0u;
    loop {
        let _e26 = step_1;
        if (_e26 >= 8u) {
            break;
        }
        let _e30 = (_e26 + 1u);
        let _e32 = (_e30 * 2u);
        let _e39 = term;
        let _e40 = gen__naga_trig_multiply(_e39, _e22);
        let _e41 = gen__naga_trig_divide(_e40, (_e32 * select((_e32 - 1u), (_e32 + 1u), _e7)));
        term = _e41;
        let _e42 = total;
        let _e45 = gen__naga_trig_combine(_e42, _e41, (_e30 & 1u));
        total = _e45;
        continuing {
            let _e46 = step_1;
            step_1 = (_e46 + 1u);
        }
    }
    let _e49 = total;
    return _e49;
}

fn gen__naga_trig_round(digits_2: array<u32, 12>) -> u32 {
    var source_3: array<u32, 12> = array<u32, 12>();
    var highest_bit: u32 = u32();
    var nonzero: u32 = u32();
    var digit_index_1: u32 = u32();
    var sticky: u32 = u32();
    var sticky_index: u32 = u32();

    source_3 = digits_2;
    digit_index_1 = 0u;
    loop {
        let _e10 = digit_index_1;
        if (_e10 >= 12u) {
            break;
        }
        let _e14 = source_3[_e10];
        let _e15 = nonzero;
        nonzero = (_e15 | _e14);
        if (_e14 != 0u) {
            highest_bit = ((_e10 * 16u) + (31u - countLeadingZeros(_e14)));
        }
        continuing {
            let _e25 = digit_index_1;
            digit_index_1 = (_e25 + 1u);
        }
    }
    let _e28 = nonzero;
    if (_e28 == 0u) {
        return 0u;
    }
    let _e32 = highest_bit;
    let _e38 = select(27u, (_e32 - 23u), (_e32 >= 50u));
    let _e39 = gen__naga_trig_extract_fixed(digits_2, _e38);
    let _e42 = gen__naga_trig_extract_fixed(digits_2, (_e38 + 16u));
    let _e45 = (_e39 | (_e42 << 16u));
    let _e47 = (_e38 - 1u);
    let _e48 = gen__naga_trig_extract_fixed(digits_2, _e47);
    let _e54 = (_e47 / 16u);
    sticky_index = 0u;
    loop {
        let _e66 = sticky_index;
        if (_e66 >= 12u) {
            break;
        }
        let _e76 = source_3[_e66];
        let _e78 = sticky;
        sticky = (_e78 | (_e76 & select(select(0u, ((1u << (_e47 % 16u)) - 1u), (_e66 == _e54)), 65535u, (_e66 < _e54))));
        continuing {
            let _e80 = sticky_index;
            sticky_index = (_e80 + 1u);
        }
    }
    let _e83 = sticky;
    let _e93 = (_e45 + select(0u, 1u, (((_e48 & 1u) != 0u) && ((_e83 | (_e45 & 1u)) != 0u))));
    if (_e32 < 50u) {
        return _e93;
    }
    let _e97 = (_e93 == 16777216u);
    let _e102 = (_e32 - 49u);
    return ((select(_e102, (_e102 + 1u), _e97) << 23u) | (select(_e93, (_e93 >> 1u), _e97) & 8388607u));
}

fn gen__naga_trigonometry(input_bits: u32, cosine: u32) -> u32 {
    var quadrant: u32 = u32();
    var fraction: array<u32, 12> = array<u32, 12>();
    var fraction_index: u32 = u32();

    let _e3 = (input_bits & 2147483647u);
    if (_e3 >= 2139095040u) {
        return 2143289344u;
    }
    let _e8 = (cosine != 0u);
    if (_e3 <= 956301312u) {
        return select(input_bits, 1065353216u, _e8);
    }
    let _e16 = (470u - (_e3 >> 23u));
    let _e20 = ((_e3 & 8388607u) | 8388608u);
    let _e47 = gen__naga_trig_reduce_multiply(array<u32, 2>((_e20 & 65535u), (_e20 >> 16u)), array<u32, 20>(53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    let _e50 = gen__naga_trig_extract_product(_e47, _e16);
    quadrant = (_e50 & 3u);
    fraction_index = 0u;
    loop {
        let _e60 = fraction_index;
        if (_e60 >= 11u) {
            break;
        }
        let _e66 = gen__naga_trig_extract_product(_e47, ((_e16 - 176u) + (_e60 * 16u)));
        fraction[_e60] = _e66;
        continuing {
            let _e68 = fraction_index;
            fraction_index = (_e68 + 1u);
        }
    }
    let _e73 = fraction[10u];
    let _e75 = (_e73 >= 32768u);
    if _e75 {
        let _e89 = quadrant;
        quadrant = ((_e89 + 1u) & 3u);
        let _e94 = fraction;
        let _e96 = gen__naga_trig_combine(array<u32, 12>(0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u), _e94, 1u);
        fraction = _e96;
    }
    let _e97 = fraction;
    let _e111 = gen__naga_trig_multiply(_e97, array<u32, 12>(5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u));
    let _e112 = quadrant;
    let _e115 = ((_e112 & 1u) == cosine);
    let _e119 = gen__naga_trig_kernel(_e111, select(0u, 1u, _e115));
    let _e120 = gen__naga_trig_round(_e119);
    return (_e120 | ((select(0u, 2147483648u, (_e75 && _e115)) ^ ((select(_e112, (_e112 + 1u), _e8) & 2u) << 30u)) ^ select((input_bits & 2147483648u), 0u, _e8)));
}

fn sine_value(value_2: f32) -> f32 {
    var value_3: f32;

    value_3 = value_2;
    let _e2 = value_3;
    let _e5 = gen__naga_trigonometry(bitcast<u32>(_e2), 0u);
    return bitcast<f32>(_e5);
}

fn cosine_value(value_4: f32) -> f32 {
    var value_5: f32;

    value_5 = value_4;
    let _e2 = value_5;
    let _e5 = gen__naga_trigonometry(bitcast<u32>(_e2), 1u);
    return bitcast<f32>(_e5);
}

fn sinf(value_6: bool) -> i32 {
    var value_7: bool;
    var local_121: i32;

    value_7 = value_6;
    let _e2 = value_7;
    if _e2 {
        local_121 = 17i;
    } else {
        local_121 = 19i;
    }
    let _e6 = local_121;
    return _e6;
}

fn cosf(value_8: i32) -> i32 {
    var value_9: i32;

    value_9 = value_8;
    let _e3 = value_9;
    return (_e3 + 23i);
}

fn sinf_1(first: f32, second: f32) -> f32 {
    var first_1: f32;
    var second_1: f32;

    first_1 = first;
    second_1 = second;
    let _e4 = first_1;
    let _e5 = second_1;
    return (_e4 + _e5);
}

fn cosf_1(value_10: vec2<f32>) -> f32 {
    var value_11: vec2<f32>;

    value_11 = value_10;
    let _e4 = value_11.x;
    let _e5 = value_11.y;
    return (_e4 + _e5);
}

fn identity(value_12: f32) -> f32 {
    var value_13: f32;

    value_13 = value_12;
    let _e2 = value_13;
    return _e2;
}

fn pair(first_2: f32, second_2: f32) -> f32 {
    var first_3: f32;
    var second_3: f32;

    first_3 = first_2;
    second_3 = second_2;
    let _e5 = first_3;
    let _e7 = second_3;
    return ((_e5 * 10f) + _e7);
}

@compute @workgroup_size(1, 1, 1)
fn trigonometry() {
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
    var value: f32;
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
    var choose: bool;
    var counter: i32;
    var local_55: u32;
    var local_56: u32;
    var local_57: u32;
    var local_58: bool;
    var local_59: u32;
    var local_60: u32;
    var local_61: u32;
    var local_62: bool;
    var local_63: u32;
    var local_64: u32;
    var local_65: u32;
    var local_66: f32;
    var local_67: u32;
    var local_68: u32;
    var local_69: u32;
    var values: array<f32, 2>;
    var local_70: u32;
    var local_71: u32;
    var local_72: u32;
    var Count: i32;
    var scratch: array<f32, 2>;
    var local_73: u32;
    var local_74: u32;
    var local_75: u32;
    var repeated: i32;
    var index: i32;
    var local_76: u32;
    var local_77: u32;
    var local_78: u32;
    var local_79: u32;
    var local_80: u32;
    var local_81: u32;
    var local_82: u32;
    var local_83: u32;
    var local_84: u32;
    var local_85: u32;
    var local_86: u32;
    var local_87: u32;
    var local_88: f32;
    var local_89: u32;
    var local_90: u32;
    var local_91: u32;
    var local_92: u32;
    var local_93: u32;
    var local_94: u32;
    var local_95: u32;
    var local_96: u32;
    var local_97: u32;
    var local_98: u32;
    var local_99: u32;
    var local_100: u32;
    var local_101: u32;
    var local_102: u32;
    var local_103: u32;
    var local_104: u32;
    var local_105: u32;
    var local_106: u32;
    var local_107: u32;
    var local_108: u32;
    var local_109: u32;
    var local_110: u32;
    var local_111: u32;
    var local_112: u32;
    var local_113: u32;
    var local_114: u32;
    var local_115: u32;
    var local_116: u32;
    var local_117: u32;
    var local_118: u32;
    var local_119: u32;
    var local_120: u32;

    local = 0u;
    let _e5 = gen__naga_trigonometry(bitcast<u32>(0f), 0u);
    let _e8 = local;
    local_1 = _e8;
    let _e10 = local_1;
    local_2 = u32(_e10);
    local_3 = u32(0i);
    let _e17 = local_2;
    let _e18 = local_3;
    local_92 = u32((_e17 + _e18));
    let _e22 = local_92;
    out[_e22] = bitcast<u32>(bitcast<f32>(_e5));
    let _e28 = gen__naga_trigonometry(bitcast<u32>(-(0f)), 0u);
    let _e31 = local;
    local_4 = _e31;
    let _e33 = local_4;
    local_5 = u32(_e33);
    local_6 = u32(1i);
    let _e39 = local_5;
    let _e40 = local_6;
    local_93 = u32((_e39 + _e40));
    let _e44 = local_93;
    out[_e44] = bitcast<u32>(bitcast<f32>(_e28));
    let _e49 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    let _e52 = local;
    local_7 = _e52;
    let _e54 = local_7;
    local_8 = u32(_e54);
    local_9 = u32(2i);
    let _e60 = local_8;
    let _e61 = local_9;
    local_94 = u32((_e60 + _e61));
    let _e65 = local_94;
    out[_e65] = bitcast<u32>(bitcast<f32>(_e49));
    let _e71 = gen__naga_trigonometry(bitcast<u32>(-(0f)), 1u);
    let _e74 = local;
    local_10 = _e74;
    let _e76 = local_10;
    local_11 = u32(_e76);
    local_12 = u32(3i);
    let _e82 = local_11;
    let _e83 = local_12;
    local_95 = u32((_e82 + _e83));
    let _e87 = local_95;
    out[_e87] = bitcast<u32>(bitcast<f32>(_e71));
    let _e91 = sine_value(f32(0i));
    let _e93 = local;
    local_13 = _e93;
    let _e95 = local_13;
    local_14 = u32(_e95);
    local_15 = u32(4i);
    let _e101 = local_14;
    let _e102 = local_15;
    local_96 = u32((_e101 + _e102));
    let _e106 = local_96;
    out[_e106] = bitcast<u32>(_e91);
    let _e110 = cosine_value(f32(0u));
    let _e112 = local;
    local_16 = _e112;
    let _e114 = local_16;
    local_17 = u32(_e114);
    local_18 = u32(5i);
    let _e120 = local_17;
    let _e121 = local_18;
    local_97 = u32((_e120 + _e121));
    let _e125 = local_97;
    out[_e125] = bitcast<u32>(_e110);
    let _e128 = sinf(true);
    let _e130 = local;
    local_19 = _e130;
    let _e132 = local_19;
    local_20 = u32(_e132);
    local_21 = u32(6i);
    let _e138 = local_20;
    let _e139 = local_21;
    local_98 = u32((_e138 + _e139));
    let _e143 = local_98;
    out[_e143] = u32(_e128);
    let _e146 = sinf(false);
    let _e148 = local;
    local_22 = _e148;
    let _e150 = local_22;
    local_23 = u32(_e150);
    local_24 = u32(7i);
    let _e156 = local_23;
    let _e157 = local_24;
    local_99 = u32((_e156 + _e157));
    let _e161 = local_99;
    out[_e161] = u32(_e146);
    let _e164 = cosf(4i);
    let _e166 = local;
    local_25 = _e166;
    let _e168 = local_25;
    local_26 = u32(_e168);
    local_27 = u32(8i);
    let _e174 = local_26;
    let _e175 = local_27;
    local_100 = u32((_e174 + _e175));
    let _e179 = local_100;
    out[_e179] = u32(_e164);
    let _e184 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    let _e187 = local;
    local_28 = _e187;
    let _e189 = local_28;
    local_29 = u32(_e189);
    local_30 = u32(9i);
    let _e195 = local_29;
    let _e196 = local_30;
    local_101 = u32((_e195 + _e196));
    let _e200 = local_101;
    out[_e200] = bitcast<u32>(bitcast<f32>(_e184));
    let _e204 = sinf_1(2f, 3f);
    let _e206 = local;
    local_31 = _e206;
    let _e208 = local_31;
    local_32 = u32(_e208);
    local_33 = u32(10i);
    let _e214 = local_32;
    let _e215 = local_33;
    local_102 = u32((_e214 + _e215));
    let _e219 = local_102;
    out[_e219] = bitcast<u32>(_e204);
    let _e224 = cosf_1(vec2<f32>(2f, 3f));
    let _e226 = local;
    local_34 = _e226;
    let _e228 = local_34;
    local_35 = u32(_e228);
    local_36 = u32(11i);
    let _e234 = local_35;
    let _e235 = local_36;
    local_103 = u32((_e234 + _e235));
    let _e239 = local_103;
    out[_e239] = bitcast<u32>(_e224);
    value = 0f;
    let _e243 = value;
    value = (_e243 + f32(1i));
    let _e249 = gen__naga_trigonometry(bitcast<u32>(_e243), 0u);
    let _e252 = local;
    local_37 = _e252;
    let _e254 = local_37;
    local_38 = u32(_e254);
    local_39 = u32(12i);
    let _e260 = local_38;
    let _e261 = local_39;
    local_104 = u32((_e260 + _e261));
    let _e265 = local_104;
    out[_e265] = bitcast<u32>(bitcast<f32>(_e249));
    let _e267 = value;
    let _e269 = local;
    local_40 = _e269;
    let _e271 = local_40;
    local_41 = u32(_e271);
    local_42 = u32(13i);
    let _e277 = local_41;
    let _e278 = local_42;
    local_105 = u32((_e277 + _e278));
    let _e282 = local_105;
    out[_e282] = bitcast<u32>(_e267);
    value = -(1f);
    let _e286 = value;
    value = (_e286 + f32(1i));
    let _e290 = value;
    let _e293 = gen__naga_trigonometry(bitcast<u32>(_e290), 1u);
    let _e296 = local;
    local_43 = _e296;
    let _e298 = local_43;
    local_44 = u32(_e298);
    local_45 = u32(14i);
    let _e304 = local_44;
    let _e305 = local_45;
    local_106 = u32((_e304 + _e305));
    let _e309 = local_106;
    out[_e309] = bitcast<u32>(bitcast<f32>(_e293));
    let _e311 = value;
    let _e313 = local;
    local_46 = _e313;
    let _e315 = local_46;
    local_47 = u32(_e315);
    local_48 = u32(15i);
    let _e321 = local_47;
    let _e322 = local_48;
    local_107 = u32((_e321 + _e322));
    let _e326 = local_107;
    out[_e326] = bitcast<u32>(_e311);
    let _e328 = value;
    value = (_e328 + f32(1i));
    let _e332 = identity(_e328);
    let _e335 = gen__naga_trigonometry(bitcast<u32>(_e332), 0u);
    let _e337 = value;
    value = (_e337 + f32(1i));
    let _e341 = pair(bitcast<f32>(_e335), _e337);
    let _e343 = local;
    local_49 = _e343;
    let _e345 = local_49;
    local_50 = u32(_e345);
    local_51 = u32(16i);
    let _e351 = local_50;
    let _e352 = local_51;
    local_108 = u32((_e351 + _e352));
    let _e356 = local_108;
    out[_e356] = bitcast<u32>(_e341);
    let _e358 = value;
    let _e360 = local;
    local_52 = _e360;
    let _e362 = local_52;
    local_53 = u32(_e362);
    local_54 = u32(17i);
    let _e368 = local_53;
    let _e369 = local_54;
    local_109 = u32((_e368 + _e369));
    let _e373 = local_109;
    out[_e373] = bitcast<u32>(_e358);
    choose = false;
    counter = 0i;
    let _e379 = choose;
    local_58 = _e379;
    if _e379 {
        let _e381 = counter;
        counter = (_e381 + 1i);
        let _e387 = gen__naga_trigonometry(bitcast<u32>(f32(_e381)), 0u);
        local_58 = (bitcast<f32>(_e387) != 0f);
    }
    let _e391 = local_58;
    let _e393 = local;
    local_55 = _e393;
    let _e395 = local_55;
    local_56 = u32(_e395);
    local_57 = u32(18i);
    let _e401 = local_56;
    let _e402 = local_57;
    local_110 = u32((_e401 + _e402));
    let _e406 = local_110;
    out[_e406] = u32(_e391);
    local_62 = true;
    if true {
    } else {
        let _e410 = counter;
        counter = (_e410 + 1i);
        let _e416 = gen__naga_trigonometry(bitcast<u32>(f32(_e410)), 1u);
        local_62 = (bitcast<f32>(_e416) != 0f);
    }
    let _e420 = local_62;
    let _e422 = local;
    local_59 = _e422;
    let _e424 = local_59;
    local_60 = u32(_e424);
    local_61 = u32(19i);
    let _e430 = local_60;
    let _e431 = local_61;
    local_111 = u32((_e430 + _e431));
    let _e435 = local_111;
    out[_e435] = u32(_e420);
    let _e437 = choose;
    if _e437 {
        let _e438 = counter;
        counter = (_e438 + 1i);
        let _e441 = counter;
        let _e445 = gen__naga_trigonometry(bitcast<u32>(f32(_e441)), 0u);
        local_66 = bitcast<f32>(_e445);
    } else {
        let _e448 = counter;
        let _e452 = gen__naga_trigonometry(bitcast<u32>(f32(_e448)), 1u);
        local_66 = bitcast<f32>(_e452);
    }
    let _e456 = local_66;
    let _e458 = local;
    local_63 = _e458;
    let _e460 = local_63;
    local_64 = u32(_e460);
    local_65 = u32(20i);
    let _e466 = local_64;
    let _e467 = local_65;
    local_112 = u32((_e466 + _e467));
    let _e471 = local_112;
    out[_e471] = u32(_e456);
    let _e473 = counter;
    let _e475 = local;
    local_67 = _e475;
    let _e477 = local_67;
    local_68 = u32(_e477);
    local_69 = u32(21i);
    let _e483 = local_68;
    let _e484 = local_69;
    local_113 = u32((_e483 + _e484));
    let _e488 = local_113;
    out[_e488] = u32(_e473);
    let _e495 = gen__naga_trigonometry(bitcast<u32>(0f), 0u);
    values[0] = bitcast<f32>(_e495);
    let _e501 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    values[1] = bitcast<f32>(_e501);
    let _e507 = values[0i];
    let _e508 = values[1i];
    let _e511 = local;
    local_70 = _e511;
    let _e513 = local_70;
    local_71 = u32(_e513);
    local_72 = u32(22i);
    let _e519 = local_71;
    let _e520 = local_72;
    local_114 = u32((_e519 + _e520));
    let _e524 = local_114;
    out[_e524] = bitcast<u32>((_e507 + _e508));
    Count = 2i;
    scratch = array<f32, 2>();
    let _e532 = scratch[1i];
    let _e534 = local;
    local_73 = _e534;
    let _e536 = local_73;
    local_74 = u32(_e536);
    local_75 = u32(23i);
    let _e542 = local_74;
    let _e543 = local_75;
    local_115 = u32((_e542 + _e543));
    let _e547 = local_115;
    out[_e547] = bitcast<u32>(_e532);
    repeated = 0i;
    {
        index = 0i;
        loop {
            let _e553 = index;
            if (_e553 < 3i) {
            } else {
                break;
            }
            let _e556 = index;
            if (_e556 == 0i) {
                continue;
            }
            let _e562 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
            let _e565 = repeated;
            repeated = (_e565 + i32(bitcast<f32>(_e562)));
            continuing {
                let _e567 = index;
                index = (_e567 + 1i);
            }
        }
    }
    let _e570 = repeated;
    let _e572 = local;
    local_76 = _e572;
    let _e574 = local_76;
    local_77 = u32(_e574);
    local_78 = u32(24i);
    let _e580 = local_77;
    let _e581 = local_78;
    local_116 = u32((_e580 + _e581));
    let _e585 = local_116;
    out[_e585] = u32(_e570);
    value = 0f;
    let _e588 = value;
    value = (_e588 + f32(1i));
    let _e594 = gen__naga_trigonometry(bitcast<u32>(_e588), 0u);
    let _e595 = value;
    value = (_e595 - f32(1i));
    let _e599 = value;
    let _e602 = gen__naga_trigonometry(bitcast<u32>(_e599), 1u);
    let _e605 = local;
    local_79 = _e605;
    let _e607 = local_79;
    local_80 = u32(_e607);
    local_81 = u32(25i);
    let _e613 = local_80;
    let _e614 = local_81;
    local_117 = u32((_e613 + _e614));
    let _e618 = local_117;
    out[_e618] = bitcast<u32>(bitcast<f32>(_e602));
    let _e620 = value;
    let _e622 = local;
    local_82 = _e622;
    let _e624 = local_82;
    local_83 = u32(_e624);
    local_84 = u32(26i);
    let _e630 = local_83;
    let _e631 = local_84;
    local_118 = u32((_e630 + _e631));
    let _e635 = local_118;
    out[_e635] = bitcast<u32>(_e620);
    if true {
        let _e641 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
        local_88 = bitcast<f32>(_e641);
    } else {
        let _e647 = gen__naga_trigonometry(bitcast<u32>(99f), 0u);
        local_88 = bitcast<f32>(_e647);
    }
    let _e651 = local_88;
    let _e653 = local;
    local_85 = _e653;
    let _e655 = local_85;
    local_86 = u32(_e655);
    local_87 = u32(27i);
    let _e661 = local_86;
    let _e662 = local_87;
    local_119 = u32((_e661 + _e662));
    let _e666 = local_119;
    out[_e666] = u32(_e651);
    let _e670 = cosine_value(f32(false));
    let _e672 = local;
    local_89 = _e672;
    let _e674 = local_89;
    local_90 = u32(_e674);
    local_91 = u32(28i);
    let _e680 = local_90;
    let _e681 = local_91;
    local_120 = u32((_e680 + _e681));
    let _e685 = local_120;
    out[_e685] = bitcast<u32>(_e670);
}
