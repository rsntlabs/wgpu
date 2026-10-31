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
    var local_150: i32;

    value_7 = value_6;
    let _e2 = value_7;
    if _e2 {
        local_150 = 17i;
    } else {
        local_150 = 19i;
    }
    let _e6 = local_150;
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
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var local_2: u32;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: array<u32, 2>;
    var local_14: u32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var local_17: array<u32, 2>;
    var local_18: u32;
    var local_19: array<u32, 2>;
    var local_20: u32;
    var local_21: array<u32, 2>;
    var local_22: u32;
    var local_23: array<u32, 2>;
    var local_24: u32;
    var value: f32;
    var local_25: array<u32, 2>;
    var local_26: u32;
    var local_27: array<u32, 2>;
    var local_28: u32;
    var local_29: array<u32, 2>;
    var local_30: u32;
    var local_31: array<u32, 2>;
    var local_32: u32;
    var local_33: array<u32, 2>;
    var local_34: u32;
    var local_35: array<u32, 2>;
    var local_36: u32;
    var choose: bool;
    var counter: i32;
    var local_37: array<u32, 2>;
    var local_38: u32;
    var local_39: bool;
    var local_40: array<u32, 2>;
    var local_41: u32;
    var local_42: bool;
    var local_43: array<u32, 2>;
    var local_44: u32;
    var local_45: f32;
    var local_46: array<u32, 2>;
    var local_47: u32;
    var values: array<f32, 2>;
    var local_48: array<u32, 2>;
    var local_49: u32;
    var Count: i32;
    var scratch: array<f32, 2>;
    var local_50: array<u32, 2>;
    var local_51: u32;
    var repeated: i32;
    var index: i32;
    var local_52: array<u32, 2>;
    var local_53: u32;
    var local_54: array<u32, 2>;
    var local_55: u32;
    var local_56: array<u32, 2>;
    var local_57: u32;
    var local_58: array<u32, 2>;
    var local_59: u32;
    var local_60: f32;
    var local_61: array<u32, 2>;
    var local_62: u32;
    var local_63: array<u32, 2>;
    var local_64: u32;
    var local_65: u32;
    var local_66: array<u32, 2>;
    var local_67: u32;
    var local_68: u32;
    var local_69: array<u32, 2>;
    var local_70: u32;
    var local_71: u32;
    var local_72: array<u32, 2>;
    var local_73: u32;
    var local_74: u32;
    var local_75: array<u32, 2>;
    var local_76: u32;
    var local_77: u32;
    var local_78: array<u32, 2>;
    var local_79: u32;
    var local_80: u32;
    var local_81: array<u32, 2>;
    var local_82: u32;
    var local_83: u32;
    var local_84: array<u32, 2>;
    var local_85: u32;
    var local_86: u32;
    var local_87: array<u32, 2>;
    var local_88: u32;
    var local_89: u32;
    var local_90: array<u32, 2>;
    var local_91: u32;
    var local_92: u32;
    var local_93: array<u32, 2>;
    var local_94: u32;
    var local_95: u32;
    var local_96: array<u32, 2>;
    var local_97: u32;
    var local_98: u32;
    var local_99: array<u32, 2>;
    var local_100: u32;
    var local_101: u32;
    var local_102: array<u32, 2>;
    var local_103: u32;
    var local_104: u32;
    var local_105: array<u32, 2>;
    var local_106: u32;
    var local_107: u32;
    var local_108: array<u32, 2>;
    var local_109: u32;
    var local_110: u32;
    var local_111: array<u32, 2>;
    var local_112: u32;
    var local_113: u32;
    var local_114: array<u32, 2>;
    var local_115: u32;
    var local_116: u32;
    var local_117: array<u32, 2>;
    var local_118: u32;
    var local_119: u32;
    var local_120: array<u32, 2>;
    var local_121: u32;
    var local_122: u32;
    var local_123: array<u32, 2>;
    var local_124: u32;
    var local_125: u32;
    var local_126: array<u32, 2>;
    var local_127: u32;
    var local_128: u32;
    var local_129: array<u32, 2>;
    var local_130: u32;
    var local_131: u32;
    var local_132: array<u32, 2>;
    var local_133: u32;
    var local_134: u32;
    var local_135: array<u32, 2>;
    var local_136: u32;
    var local_137: u32;
    var local_138: array<u32, 2>;
    var local_139: u32;
    var local_140: u32;
    var local_141: array<u32, 2>;
    var local_142: u32;
    var local_143: u32;
    var local_144: array<u32, 2>;
    var local_145: u32;
    var local_146: u32;
    var local_147: array<u32, 2>;
    var local_148: u32;
    var local_149: u32;

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    let _e10 = gen__naga_trigonometry(bitcast<u32>(0f), 0u);
    let _e15 = local;
    local_1 = _e15;
    local_2 = u32(0i);
    let _e20 = local_1;
    local_63 = _e20;
    let _e21 = local_2;
    let _e23 = local_63[1];
    local_63[1] = (_e23 + _e21);
    let _e27 = local_63[0];
    local_64 = u32(_e27);
    let _e31 = local_63[1];
    local_65 = u32(_e31);
    let _e34 = local_65;
    out[_e34] = bitcast<u32>(bitcast<f32>(_e10));
    let _e40 = gen__naga_trigonometry(bitcast<u32>(-(0f)), 0u);
    let _e44 = local;
    local_3 = _e44;
    local_4 = u32(1i);
    let _e49 = local_3;
    local_66 = _e49;
    let _e50 = local_4;
    let _e52 = local_66[1];
    local_66[1] = (_e52 + _e50);
    let _e56 = local_66[0];
    local_67 = u32(_e56);
    let _e60 = local_66[1];
    local_68 = u32(_e60);
    let _e63 = local_68;
    out[_e63] = bitcast<u32>(bitcast<f32>(_e40));
    let _e68 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    let _e72 = local;
    local_5 = _e72;
    local_6 = u32(2i);
    let _e77 = local_5;
    local_69 = _e77;
    let _e78 = local_6;
    let _e80 = local_69[1];
    local_69[1] = (_e80 + _e78);
    let _e84 = local_69[0];
    local_70 = u32(_e84);
    let _e88 = local_69[1];
    local_71 = u32(_e88);
    let _e91 = local_71;
    out[_e91] = bitcast<u32>(bitcast<f32>(_e68));
    let _e97 = gen__naga_trigonometry(bitcast<u32>(-(0f)), 1u);
    let _e101 = local;
    local_7 = _e101;
    local_8 = u32(3i);
    let _e106 = local_7;
    local_72 = _e106;
    let _e107 = local_8;
    let _e109 = local_72[1];
    local_72[1] = (_e109 + _e107);
    let _e113 = local_72[0];
    local_73 = u32(_e113);
    let _e117 = local_72[1];
    local_74 = u32(_e117);
    let _e120 = local_74;
    out[_e120] = bitcast<u32>(bitcast<f32>(_e97));
    let _e124 = sine_value(f32(0i));
    let _e127 = local;
    local_9 = _e127;
    local_10 = u32(4i);
    let _e132 = local_9;
    local_75 = _e132;
    let _e133 = local_10;
    let _e135 = local_75[1];
    local_75[1] = (_e135 + _e133);
    let _e139 = local_75[0];
    local_76 = u32(_e139);
    let _e143 = local_75[1];
    local_77 = u32(_e143);
    let _e146 = local_77;
    out[_e146] = bitcast<u32>(_e124);
    let _e150 = cosine_value(f32(0u));
    let _e153 = local;
    local_11 = _e153;
    local_12 = u32(5i);
    let _e158 = local_11;
    local_78 = _e158;
    let _e159 = local_12;
    let _e161 = local_78[1];
    local_78[1] = (_e161 + _e159);
    let _e165 = local_78[0];
    local_79 = u32(_e165);
    let _e169 = local_78[1];
    local_80 = u32(_e169);
    let _e172 = local_80;
    out[_e172] = bitcast<u32>(_e150);
    let _e175 = sinf(true);
    let _e178 = local;
    local_13 = _e178;
    local_14 = u32(6i);
    let _e183 = local_13;
    local_81 = _e183;
    let _e184 = local_14;
    let _e186 = local_81[1];
    local_81[1] = (_e186 + _e184);
    let _e190 = local_81[0];
    local_82 = u32(_e190);
    let _e194 = local_81[1];
    local_83 = u32(_e194);
    let _e197 = local_83;
    out[_e197] = u32(_e175);
    let _e200 = sinf(false);
    let _e203 = local;
    local_15 = _e203;
    local_16 = u32(7i);
    let _e208 = local_15;
    local_84 = _e208;
    let _e209 = local_16;
    let _e211 = local_84[1];
    local_84[1] = (_e211 + _e209);
    let _e215 = local_84[0];
    local_85 = u32(_e215);
    let _e219 = local_84[1];
    local_86 = u32(_e219);
    let _e222 = local_86;
    out[_e222] = u32(_e200);
    let _e225 = cosf(4i);
    let _e228 = local;
    local_17 = _e228;
    local_18 = u32(8i);
    let _e233 = local_17;
    local_87 = _e233;
    let _e234 = local_18;
    let _e236 = local_87[1];
    local_87[1] = (_e236 + _e234);
    let _e240 = local_87[0];
    local_88 = u32(_e240);
    let _e244 = local_87[1];
    local_89 = u32(_e244);
    let _e247 = local_89;
    out[_e247] = u32(_e225);
    let _e252 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    let _e256 = local;
    local_19 = _e256;
    local_20 = u32(9i);
    let _e261 = local_19;
    local_90 = _e261;
    let _e262 = local_20;
    let _e264 = local_90[1];
    local_90[1] = (_e264 + _e262);
    let _e268 = local_90[0];
    local_91 = u32(_e268);
    let _e272 = local_90[1];
    local_92 = u32(_e272);
    let _e275 = local_92;
    out[_e275] = bitcast<u32>(bitcast<f32>(_e252));
    let _e279 = sinf_1(2f, 3f);
    let _e282 = local;
    local_21 = _e282;
    local_22 = u32(10i);
    let _e287 = local_21;
    local_93 = _e287;
    let _e288 = local_22;
    let _e290 = local_93[1];
    local_93[1] = (_e290 + _e288);
    let _e294 = local_93[0];
    local_94 = u32(_e294);
    let _e298 = local_93[1];
    local_95 = u32(_e298);
    let _e301 = local_95;
    out[_e301] = bitcast<u32>(_e279);
    let _e306 = cosf_1(vec2<f32>(2f, 3f));
    let _e309 = local;
    local_23 = _e309;
    local_24 = u32(11i);
    let _e314 = local_23;
    local_96 = _e314;
    let _e315 = local_24;
    let _e317 = local_96[1];
    local_96[1] = (_e317 + _e315);
    let _e321 = local_96[0];
    local_97 = u32(_e321);
    let _e325 = local_96[1];
    local_98 = u32(_e325);
    let _e328 = local_98;
    out[_e328] = bitcast<u32>(_e306);
    value = 0f;
    let _e332 = value;
    value = (_e332 + f32(1i));
    let _e338 = gen__naga_trigonometry(bitcast<u32>(_e332), 0u);
    let _e342 = local;
    local_25 = _e342;
    local_26 = u32(12i);
    let _e347 = local_25;
    local_99 = _e347;
    let _e348 = local_26;
    let _e350 = local_99[1];
    local_99[1] = (_e350 + _e348);
    let _e354 = local_99[0];
    local_100 = u32(_e354);
    let _e358 = local_99[1];
    local_101 = u32(_e358);
    let _e361 = local_101;
    out[_e361] = bitcast<u32>(bitcast<f32>(_e338));
    let _e363 = value;
    let _e366 = local;
    local_27 = _e366;
    local_28 = u32(13i);
    let _e371 = local_27;
    local_102 = _e371;
    let _e372 = local_28;
    let _e374 = local_102[1];
    local_102[1] = (_e374 + _e372);
    let _e378 = local_102[0];
    local_103 = u32(_e378);
    let _e382 = local_102[1];
    local_104 = u32(_e382);
    let _e385 = local_104;
    out[_e385] = bitcast<u32>(_e363);
    value = -(1f);
    let _e389 = value;
    value = (_e389 + f32(1i));
    let _e393 = value;
    let _e396 = gen__naga_trigonometry(bitcast<u32>(_e393), 1u);
    let _e400 = local;
    local_29 = _e400;
    local_30 = u32(14i);
    let _e405 = local_29;
    local_105 = _e405;
    let _e406 = local_30;
    let _e408 = local_105[1];
    local_105[1] = (_e408 + _e406);
    let _e412 = local_105[0];
    local_106 = u32(_e412);
    let _e416 = local_105[1];
    local_107 = u32(_e416);
    let _e419 = local_107;
    out[_e419] = bitcast<u32>(bitcast<f32>(_e396));
    let _e421 = value;
    let _e424 = local;
    local_31 = _e424;
    local_32 = u32(15i);
    let _e429 = local_31;
    local_108 = _e429;
    let _e430 = local_32;
    let _e432 = local_108[1];
    local_108[1] = (_e432 + _e430);
    let _e436 = local_108[0];
    local_109 = u32(_e436);
    let _e440 = local_108[1];
    local_110 = u32(_e440);
    let _e443 = local_110;
    out[_e443] = bitcast<u32>(_e421);
    let _e445 = value;
    value = (_e445 + f32(1i));
    let _e449 = identity(_e445);
    let _e452 = gen__naga_trigonometry(bitcast<u32>(_e449), 0u);
    let _e454 = value;
    value = (_e454 + f32(1i));
    let _e458 = pair(bitcast<f32>(_e452), _e454);
    let _e461 = local;
    local_33 = _e461;
    local_34 = u32(16i);
    let _e466 = local_33;
    local_111 = _e466;
    let _e467 = local_34;
    let _e469 = local_111[1];
    local_111[1] = (_e469 + _e467);
    let _e473 = local_111[0];
    local_112 = u32(_e473);
    let _e477 = local_111[1];
    local_113 = u32(_e477);
    let _e480 = local_113;
    out[_e480] = bitcast<u32>(_e458);
    let _e482 = value;
    let _e485 = local;
    local_35 = _e485;
    local_36 = u32(17i);
    let _e490 = local_35;
    local_114 = _e490;
    let _e491 = local_36;
    let _e493 = local_114[1];
    local_114[1] = (_e493 + _e491);
    let _e497 = local_114[0];
    local_115 = u32(_e497);
    let _e501 = local_114[1];
    local_116 = u32(_e501);
    let _e504 = local_116;
    out[_e504] = bitcast<u32>(_e482);
    choose = false;
    counter = 0i;
    let _e510 = choose;
    local_39 = _e510;
    if _e510 {
        let _e512 = counter;
        counter = (_e512 + 1i);
        let _e518 = gen__naga_trigonometry(bitcast<u32>(f32(_e512)), 0u);
        local_39 = (bitcast<f32>(_e518) != 0f);
    }
    let _e522 = local_39;
    let _e525 = local;
    local_37 = _e525;
    local_38 = u32(18i);
    let _e530 = local_37;
    local_117 = _e530;
    let _e531 = local_38;
    let _e533 = local_117[1];
    local_117[1] = (_e533 + _e531);
    let _e537 = local_117[0];
    local_118 = u32(_e537);
    let _e541 = local_117[1];
    local_119 = u32(_e541);
    let _e544 = local_119;
    out[_e544] = u32(_e522);
    local_42 = true;
    if true {
    } else {
        let _e548 = counter;
        counter = (_e548 + 1i);
        let _e554 = gen__naga_trigonometry(bitcast<u32>(f32(_e548)), 1u);
        local_42 = (bitcast<f32>(_e554) != 0f);
    }
    let _e558 = local_42;
    let _e561 = local;
    local_40 = _e561;
    local_41 = u32(19i);
    let _e566 = local_40;
    local_120 = _e566;
    let _e567 = local_41;
    let _e569 = local_120[1];
    local_120[1] = (_e569 + _e567);
    let _e573 = local_120[0];
    local_121 = u32(_e573);
    let _e577 = local_120[1];
    local_122 = u32(_e577);
    let _e580 = local_122;
    out[_e580] = u32(_e558);
    let _e582 = choose;
    if _e582 {
        let _e583 = counter;
        counter = (_e583 + 1i);
        let _e586 = counter;
        let _e590 = gen__naga_trigonometry(bitcast<u32>(f32(_e586)), 0u);
        local_45 = bitcast<f32>(_e590);
    } else {
        let _e593 = counter;
        let _e597 = gen__naga_trigonometry(bitcast<u32>(f32(_e593)), 1u);
        local_45 = bitcast<f32>(_e597);
    }
    let _e601 = local_45;
    let _e604 = local;
    local_43 = _e604;
    local_44 = u32(20i);
    let _e609 = local_43;
    local_123 = _e609;
    let _e610 = local_44;
    let _e612 = local_123[1];
    local_123[1] = (_e612 + _e610);
    let _e616 = local_123[0];
    local_124 = u32(_e616);
    let _e620 = local_123[1];
    local_125 = u32(_e620);
    let _e623 = local_125;
    out[_e623] = u32(_e601);
    let _e625 = counter;
    let _e628 = local;
    local_46 = _e628;
    local_47 = u32(21i);
    let _e633 = local_46;
    local_126 = _e633;
    let _e634 = local_47;
    let _e636 = local_126[1];
    local_126[1] = (_e636 + _e634);
    let _e640 = local_126[0];
    local_127 = u32(_e640);
    let _e644 = local_126[1];
    local_128 = u32(_e644);
    let _e647 = local_128;
    out[_e647] = u32(_e625);
    let _e654 = gen__naga_trigonometry(bitcast<u32>(0f), 0u);
    values[0] = bitcast<f32>(_e654);
    let _e660 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    values[1] = bitcast<f32>(_e660);
    let _e666 = values[0i];
    let _e667 = values[1i];
    let _e671 = local;
    local_48 = _e671;
    local_49 = u32(22i);
    let _e676 = local_48;
    local_129 = _e676;
    let _e677 = local_49;
    let _e679 = local_129[1];
    local_129[1] = (_e679 + _e677);
    let _e683 = local_129[0];
    local_130 = u32(_e683);
    let _e687 = local_129[1];
    local_131 = u32(_e687);
    let _e690 = local_131;
    out[_e690] = bitcast<u32>((_e666 + _e667));
    Count = 2i;
    scratch = array<f32, 2>();
    let _e698 = scratch[1i];
    let _e701 = local;
    local_50 = _e701;
    local_51 = u32(23i);
    let _e706 = local_50;
    local_132 = _e706;
    let _e707 = local_51;
    let _e709 = local_132[1];
    local_132[1] = (_e709 + _e707);
    let _e713 = local_132[0];
    local_133 = u32(_e713);
    let _e717 = local_132[1];
    local_134 = u32(_e717);
    let _e720 = local_134;
    out[_e720] = bitcast<u32>(_e698);
    repeated = 0i;
    {
        index = 0i;
        loop {
            let _e726 = index;
            if (_e726 < 3i) {
            } else {
                break;
            }
            let _e729 = index;
            if (_e729 == 0i) {
                continue;
            }
            let _e735 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
            let _e738 = repeated;
            repeated = (_e738 + i32(bitcast<f32>(_e735)));
            continuing {
                let _e740 = index;
                index = (_e740 + 1i);
            }
        }
    }
    let _e743 = repeated;
    let _e746 = local;
    local_52 = _e746;
    local_53 = u32(24i);
    let _e751 = local_52;
    local_135 = _e751;
    let _e752 = local_53;
    let _e754 = local_135[1];
    local_135[1] = (_e754 + _e752);
    let _e758 = local_135[0];
    local_136 = u32(_e758);
    let _e762 = local_135[1];
    local_137 = u32(_e762);
    let _e765 = local_137;
    out[_e765] = u32(_e743);
    value = 0f;
    let _e768 = value;
    value = (_e768 + f32(1i));
    let _e774 = gen__naga_trigonometry(bitcast<u32>(_e768), 0u);
    let _e775 = value;
    value = (_e775 - f32(1i));
    let _e779 = value;
    let _e782 = gen__naga_trigonometry(bitcast<u32>(_e779), 1u);
    let _e786 = local;
    local_54 = _e786;
    local_55 = u32(25i);
    let _e791 = local_54;
    local_138 = _e791;
    let _e792 = local_55;
    let _e794 = local_138[1];
    local_138[1] = (_e794 + _e792);
    let _e798 = local_138[0];
    local_139 = u32(_e798);
    let _e802 = local_138[1];
    local_140 = u32(_e802);
    let _e805 = local_140;
    out[_e805] = bitcast<u32>(bitcast<f32>(_e782));
    let _e807 = value;
    let _e810 = local;
    local_56 = _e810;
    local_57 = u32(26i);
    let _e815 = local_56;
    local_141 = _e815;
    let _e816 = local_57;
    let _e818 = local_141[1];
    local_141[1] = (_e818 + _e816);
    let _e822 = local_141[0];
    local_142 = u32(_e822);
    let _e826 = local_141[1];
    local_143 = u32(_e826);
    let _e829 = local_143;
    out[_e829] = bitcast<u32>(_e807);
    if true {
        let _e835 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
        local_60 = bitcast<f32>(_e835);
    } else {
        let _e841 = gen__naga_trigonometry(bitcast<u32>(99f), 0u);
        local_60 = bitcast<f32>(_e841);
    }
    let _e845 = local_60;
    let _e848 = local;
    local_58 = _e848;
    local_59 = u32(27i);
    let _e853 = local_58;
    local_144 = _e853;
    let _e854 = local_59;
    let _e856 = local_144[1];
    local_144[1] = (_e856 + _e854);
    let _e860 = local_144[0];
    local_145 = u32(_e860);
    let _e864 = local_144[1];
    local_146 = u32(_e864);
    let _e867 = local_146;
    out[_e867] = u32(_e845);
    let _e871 = cosine_value(f32(false));
    let _e874 = local;
    local_61 = _e874;
    local_62 = u32(28i);
    let _e879 = local_61;
    local_147 = _e879;
    let _e880 = local_62;
    let _e882 = local_147[1];
    local_147[1] = (_e882 + _e880);
    let _e886 = local_147[0];
    local_148 = u32(_e886);
    let _e890 = local_147[1];
    local_149 = u32(_e890);
    let _e893 = local_149;
    out[_e893] = bitcast<u32>(_e871);
}
