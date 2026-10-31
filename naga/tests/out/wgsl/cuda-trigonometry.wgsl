@group(0) @binding(0)
var<storage, read_write> out_1: array<u32>;

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
    var local_149: i32;

    value_7 = value_6;
    let _e2 = value_7;
    if _e2 {
        local_149 = 17i;
    } else {
        local_149 = 19i;
    }
    let _e6 = local_149;
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
    var out: array<u32, 2>;
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
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: array<u32, 2>;
    var local_15: u32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var local_18: array<u32, 2>;
    var local_19: u32;
    var local_20: array<u32, 2>;
    var local_21: u32;
    var local_22: array<u32, 2>;
    var local_23: u32;
    var value: f32;
    var local_24: array<u32, 2>;
    var local_25: u32;
    var local_26: array<u32, 2>;
    var local_27: u32;
    var local_28: array<u32, 2>;
    var local_29: u32;
    var local_30: array<u32, 2>;
    var local_31: u32;
    var local_32: array<u32, 2>;
    var local_33: u32;
    var local_34: array<u32, 2>;
    var local_35: u32;
    var choose: bool;
    var counter: i32;
    var local_36: array<u32, 2>;
    var local_37: u32;
    var local_38: bool;
    var local_39: array<u32, 2>;
    var local_40: u32;
    var local_41: bool;
    var local_42: array<u32, 2>;
    var local_43: u32;
    var local_44: f32;
    var local_45: array<u32, 2>;
    var local_46: u32;
    var values: array<f32, 2>;
    var local_47: array<u32, 2>;
    var local_48: u32;
    var Count: i32;
    var scratch: array<f32, 2>;
    var local_49: array<u32, 2>;
    var local_50: u32;
    var repeated: i32;
    var index: i32;
    var local_51: array<u32, 2>;
    var local_52: u32;
    var local_53: array<u32, 2>;
    var local_54: u32;
    var local_55: array<u32, 2>;
    var local_56: u32;
    var local_57: array<u32, 2>;
    var local_58: u32;
    var local_59: f32;
    var local_60: array<u32, 2>;
    var local_61: u32;
    var local_62: array<u32, 2>;
    var local_63: u32;
    var local_64: u32;
    var local_65: array<u32, 2>;
    var local_66: u32;
    var local_67: u32;
    var local_68: array<u32, 2>;
    var local_69: u32;
    var local_70: u32;
    var local_71: array<u32, 2>;
    var local_72: u32;
    var local_73: u32;
    var local_74: array<u32, 2>;
    var local_75: u32;
    var local_76: u32;
    var local_77: array<u32, 2>;
    var local_78: u32;
    var local_79: u32;
    var local_80: array<u32, 2>;
    var local_81: u32;
    var local_82: u32;
    var local_83: array<u32, 2>;
    var local_84: u32;
    var local_85: u32;
    var local_86: array<u32, 2>;
    var local_87: u32;
    var local_88: u32;
    var local_89: array<u32, 2>;
    var local_90: u32;
    var local_91: u32;
    var local_92: array<u32, 2>;
    var local_93: u32;
    var local_94: u32;
    var local_95: array<u32, 2>;
    var local_96: u32;
    var local_97: u32;
    var local_98: array<u32, 2>;
    var local_99: u32;
    var local_100: u32;
    var local_101: array<u32, 2>;
    var local_102: u32;
    var local_103: u32;
    var local_104: array<u32, 2>;
    var local_105: u32;
    var local_106: u32;
    var local_107: array<u32, 2>;
    var local_108: u32;
    var local_109: u32;
    var local_110: array<u32, 2>;
    var local_111: u32;
    var local_112: u32;
    var local_113: array<u32, 2>;
    var local_114: u32;
    var local_115: u32;
    var local_116: array<u32, 2>;
    var local_117: u32;
    var local_118: u32;
    var local_119: array<u32, 2>;
    var local_120: u32;
    var local_121: u32;
    var local_122: array<u32, 2>;
    var local_123: u32;
    var local_124: u32;
    var local_125: array<u32, 2>;
    var local_126: u32;
    var local_127: u32;
    var local_128: array<u32, 2>;
    var local_129: u32;
    var local_130: u32;
    var local_131: array<u32, 2>;
    var local_132: u32;
    var local_133: u32;
    var local_134: array<u32, 2>;
    var local_135: u32;
    var local_136: u32;
    var local_137: array<u32, 2>;
    var local_138: u32;
    var local_139: u32;
    var local_140: array<u32, 2>;
    var local_141: u32;
    var local_142: u32;
    var local_143: array<u32, 2>;
    var local_144: u32;
    var local_145: u32;
    var local_146: array<u32, 2>;
    var local_147: u32;
    var local_148: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    let _e10 = gen__naga_trigonometry(bitcast<u32>(0f), 0u);
    let _e15 = out;
    local = _e15;
    local_1 = u32(0i);
    let _e20 = local;
    local_62 = _e20;
    let _e21 = local_1;
    let _e23 = local_62[1];
    local_62[1] = (_e23 + _e21);
    let _e27 = local_62[0];
    local_63 = u32(_e27);
    let _e31 = local_62[1];
    local_64 = u32(_e31);
    let _e34 = local_64;
    out_1[_e34] = bitcast<u32>(bitcast<f32>(_e10));
    let _e40 = gen__naga_trigonometry(bitcast<u32>(-(0f)), 0u);
    let _e44 = out;
    local_2 = _e44;
    local_3 = u32(1i);
    let _e49 = local_2;
    local_65 = _e49;
    let _e50 = local_3;
    let _e52 = local_65[1];
    local_65[1] = (_e52 + _e50);
    let _e56 = local_65[0];
    local_66 = u32(_e56);
    let _e60 = local_65[1];
    local_67 = u32(_e60);
    let _e63 = local_67;
    out_1[_e63] = bitcast<u32>(bitcast<f32>(_e40));
    let _e68 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    let _e72 = out;
    local_4 = _e72;
    local_5 = u32(2i);
    let _e77 = local_4;
    local_68 = _e77;
    let _e78 = local_5;
    let _e80 = local_68[1];
    local_68[1] = (_e80 + _e78);
    let _e84 = local_68[0];
    local_69 = u32(_e84);
    let _e88 = local_68[1];
    local_70 = u32(_e88);
    let _e91 = local_70;
    out_1[_e91] = bitcast<u32>(bitcast<f32>(_e68));
    let _e97 = gen__naga_trigonometry(bitcast<u32>(-(0f)), 1u);
    let _e101 = out;
    local_6 = _e101;
    local_7 = u32(3i);
    let _e106 = local_6;
    local_71 = _e106;
    let _e107 = local_7;
    let _e109 = local_71[1];
    local_71[1] = (_e109 + _e107);
    let _e113 = local_71[0];
    local_72 = u32(_e113);
    let _e117 = local_71[1];
    local_73 = u32(_e117);
    let _e120 = local_73;
    out_1[_e120] = bitcast<u32>(bitcast<f32>(_e97));
    let _e124 = sine_value(f32(0i));
    let _e127 = out;
    local_8 = _e127;
    local_9 = u32(4i);
    let _e132 = local_8;
    local_74 = _e132;
    let _e133 = local_9;
    let _e135 = local_74[1];
    local_74[1] = (_e135 + _e133);
    let _e139 = local_74[0];
    local_75 = u32(_e139);
    let _e143 = local_74[1];
    local_76 = u32(_e143);
    let _e146 = local_76;
    out_1[_e146] = bitcast<u32>(_e124);
    let _e150 = cosine_value(f32(0u));
    let _e153 = out;
    local_10 = _e153;
    local_11 = u32(5i);
    let _e158 = local_10;
    local_77 = _e158;
    let _e159 = local_11;
    let _e161 = local_77[1];
    local_77[1] = (_e161 + _e159);
    let _e165 = local_77[0];
    local_78 = u32(_e165);
    let _e169 = local_77[1];
    local_79 = u32(_e169);
    let _e172 = local_79;
    out_1[_e172] = bitcast<u32>(_e150);
    let _e175 = sinf(true);
    let _e178 = out;
    local_12 = _e178;
    local_13 = u32(6i);
    let _e183 = local_12;
    local_80 = _e183;
    let _e184 = local_13;
    let _e186 = local_80[1];
    local_80[1] = (_e186 + _e184);
    let _e190 = local_80[0];
    local_81 = u32(_e190);
    let _e194 = local_80[1];
    local_82 = u32(_e194);
    let _e197 = local_82;
    out_1[_e197] = u32(_e175);
    let _e200 = sinf(false);
    let _e203 = out;
    local_14 = _e203;
    local_15 = u32(7i);
    let _e208 = local_14;
    local_83 = _e208;
    let _e209 = local_15;
    let _e211 = local_83[1];
    local_83[1] = (_e211 + _e209);
    let _e215 = local_83[0];
    local_84 = u32(_e215);
    let _e219 = local_83[1];
    local_85 = u32(_e219);
    let _e222 = local_85;
    out_1[_e222] = u32(_e200);
    let _e225 = cosf(4i);
    let _e228 = out;
    local_16 = _e228;
    local_17 = u32(8i);
    let _e233 = local_16;
    local_86 = _e233;
    let _e234 = local_17;
    let _e236 = local_86[1];
    local_86[1] = (_e236 + _e234);
    let _e240 = local_86[0];
    local_87 = u32(_e240);
    let _e244 = local_86[1];
    local_88 = u32(_e244);
    let _e247 = local_88;
    out_1[_e247] = u32(_e225);
    let _e252 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    let _e256 = out;
    local_18 = _e256;
    local_19 = u32(9i);
    let _e261 = local_18;
    local_89 = _e261;
    let _e262 = local_19;
    let _e264 = local_89[1];
    local_89[1] = (_e264 + _e262);
    let _e268 = local_89[0];
    local_90 = u32(_e268);
    let _e272 = local_89[1];
    local_91 = u32(_e272);
    let _e275 = local_91;
    out_1[_e275] = bitcast<u32>(bitcast<f32>(_e252));
    let _e279 = sinf_1(2f, 3f);
    let _e282 = out;
    local_20 = _e282;
    local_21 = u32(10i);
    let _e287 = local_20;
    local_92 = _e287;
    let _e288 = local_21;
    let _e290 = local_92[1];
    local_92[1] = (_e290 + _e288);
    let _e294 = local_92[0];
    local_93 = u32(_e294);
    let _e298 = local_92[1];
    local_94 = u32(_e298);
    let _e301 = local_94;
    out_1[_e301] = bitcast<u32>(_e279);
    let _e306 = cosf_1(vec2<f32>(2f, 3f));
    let _e309 = out;
    local_22 = _e309;
    local_23 = u32(11i);
    let _e314 = local_22;
    local_95 = _e314;
    let _e315 = local_23;
    let _e317 = local_95[1];
    local_95[1] = (_e317 + _e315);
    let _e321 = local_95[0];
    local_96 = u32(_e321);
    let _e325 = local_95[1];
    local_97 = u32(_e325);
    let _e328 = local_97;
    out_1[_e328] = bitcast<u32>(_e306);
    value = 0f;
    let _e332 = value;
    value = (_e332 + f32(1i));
    let _e338 = gen__naga_trigonometry(bitcast<u32>(_e332), 0u);
    let _e342 = out;
    local_24 = _e342;
    local_25 = u32(12i);
    let _e347 = local_24;
    local_98 = _e347;
    let _e348 = local_25;
    let _e350 = local_98[1];
    local_98[1] = (_e350 + _e348);
    let _e354 = local_98[0];
    local_99 = u32(_e354);
    let _e358 = local_98[1];
    local_100 = u32(_e358);
    let _e361 = local_100;
    out_1[_e361] = bitcast<u32>(bitcast<f32>(_e338));
    let _e363 = value;
    let _e366 = out;
    local_26 = _e366;
    local_27 = u32(13i);
    let _e371 = local_26;
    local_101 = _e371;
    let _e372 = local_27;
    let _e374 = local_101[1];
    local_101[1] = (_e374 + _e372);
    let _e378 = local_101[0];
    local_102 = u32(_e378);
    let _e382 = local_101[1];
    local_103 = u32(_e382);
    let _e385 = local_103;
    out_1[_e385] = bitcast<u32>(_e363);
    value = -(1f);
    let _e389 = value;
    value = (_e389 + f32(1i));
    let _e393 = value;
    let _e396 = gen__naga_trigonometry(bitcast<u32>(_e393), 1u);
    let _e400 = out;
    local_28 = _e400;
    local_29 = u32(14i);
    let _e405 = local_28;
    local_104 = _e405;
    let _e406 = local_29;
    let _e408 = local_104[1];
    local_104[1] = (_e408 + _e406);
    let _e412 = local_104[0];
    local_105 = u32(_e412);
    let _e416 = local_104[1];
    local_106 = u32(_e416);
    let _e419 = local_106;
    out_1[_e419] = bitcast<u32>(bitcast<f32>(_e396));
    let _e421 = value;
    let _e424 = out;
    local_30 = _e424;
    local_31 = u32(15i);
    let _e429 = local_30;
    local_107 = _e429;
    let _e430 = local_31;
    let _e432 = local_107[1];
    local_107[1] = (_e432 + _e430);
    let _e436 = local_107[0];
    local_108 = u32(_e436);
    let _e440 = local_107[1];
    local_109 = u32(_e440);
    let _e443 = local_109;
    out_1[_e443] = bitcast<u32>(_e421);
    let _e445 = value;
    value = (_e445 + f32(1i));
    let _e449 = identity(_e445);
    let _e452 = gen__naga_trigonometry(bitcast<u32>(_e449), 0u);
    let _e454 = value;
    value = (_e454 + f32(1i));
    let _e458 = pair(bitcast<f32>(_e452), _e454);
    let _e461 = out;
    local_32 = _e461;
    local_33 = u32(16i);
    let _e466 = local_32;
    local_110 = _e466;
    let _e467 = local_33;
    let _e469 = local_110[1];
    local_110[1] = (_e469 + _e467);
    let _e473 = local_110[0];
    local_111 = u32(_e473);
    let _e477 = local_110[1];
    local_112 = u32(_e477);
    let _e480 = local_112;
    out_1[_e480] = bitcast<u32>(_e458);
    let _e482 = value;
    let _e485 = out;
    local_34 = _e485;
    local_35 = u32(17i);
    let _e490 = local_34;
    local_113 = _e490;
    let _e491 = local_35;
    let _e493 = local_113[1];
    local_113[1] = (_e493 + _e491);
    let _e497 = local_113[0];
    local_114 = u32(_e497);
    let _e501 = local_113[1];
    local_115 = u32(_e501);
    let _e504 = local_115;
    out_1[_e504] = bitcast<u32>(_e482);
    choose = false;
    counter = 0i;
    let _e510 = choose;
    local_38 = _e510;
    if _e510 {
        let _e512 = counter;
        counter = (_e512 + 1i);
        let _e518 = gen__naga_trigonometry(bitcast<u32>(f32(_e512)), 0u);
        local_38 = (bitcast<f32>(_e518) != 0f);
    }
    let _e522 = local_38;
    let _e525 = out;
    local_36 = _e525;
    local_37 = u32(18i);
    let _e530 = local_36;
    local_116 = _e530;
    let _e531 = local_37;
    let _e533 = local_116[1];
    local_116[1] = (_e533 + _e531);
    let _e537 = local_116[0];
    local_117 = u32(_e537);
    let _e541 = local_116[1];
    local_118 = u32(_e541);
    let _e544 = local_118;
    out_1[_e544] = u32(_e522);
    local_41 = true;
    if true {
    } else {
        let _e548 = counter;
        counter = (_e548 + 1i);
        let _e554 = gen__naga_trigonometry(bitcast<u32>(f32(_e548)), 1u);
        local_41 = (bitcast<f32>(_e554) != 0f);
    }
    let _e558 = local_41;
    let _e561 = out;
    local_39 = _e561;
    local_40 = u32(19i);
    let _e566 = local_39;
    local_119 = _e566;
    let _e567 = local_40;
    let _e569 = local_119[1];
    local_119[1] = (_e569 + _e567);
    let _e573 = local_119[0];
    local_120 = u32(_e573);
    let _e577 = local_119[1];
    local_121 = u32(_e577);
    let _e580 = local_121;
    out_1[_e580] = u32(_e558);
    let _e582 = choose;
    if _e582 {
        let _e583 = counter;
        counter = (_e583 + 1i);
        let _e586 = counter;
        let _e590 = gen__naga_trigonometry(bitcast<u32>(f32(_e586)), 0u);
        local_44 = bitcast<f32>(_e590);
    } else {
        let _e593 = counter;
        let _e597 = gen__naga_trigonometry(bitcast<u32>(f32(_e593)), 1u);
        local_44 = bitcast<f32>(_e597);
    }
    let _e601 = local_44;
    let _e604 = out;
    local_42 = _e604;
    local_43 = u32(20i);
    let _e609 = local_42;
    local_122 = _e609;
    let _e610 = local_43;
    let _e612 = local_122[1];
    local_122[1] = (_e612 + _e610);
    let _e616 = local_122[0];
    local_123 = u32(_e616);
    let _e620 = local_122[1];
    local_124 = u32(_e620);
    let _e623 = local_124;
    out_1[_e623] = u32(_e601);
    let _e625 = counter;
    let _e628 = out;
    local_45 = _e628;
    local_46 = u32(21i);
    let _e633 = local_45;
    local_125 = _e633;
    let _e634 = local_46;
    let _e636 = local_125[1];
    local_125[1] = (_e636 + _e634);
    let _e640 = local_125[0];
    local_126 = u32(_e640);
    let _e644 = local_125[1];
    local_127 = u32(_e644);
    let _e647 = local_127;
    out_1[_e647] = u32(_e625);
    let _e654 = gen__naga_trigonometry(bitcast<u32>(0f), 0u);
    values[0] = bitcast<f32>(_e654);
    let _e660 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    values[1] = bitcast<f32>(_e660);
    let _e666 = values[0i];
    let _e667 = values[1i];
    let _e671 = out;
    local_47 = _e671;
    local_48 = u32(22i);
    let _e676 = local_47;
    local_128 = _e676;
    let _e677 = local_48;
    let _e679 = local_128[1];
    local_128[1] = (_e679 + _e677);
    let _e683 = local_128[0];
    local_129 = u32(_e683);
    let _e687 = local_128[1];
    local_130 = u32(_e687);
    let _e690 = local_130;
    out_1[_e690] = bitcast<u32>((_e666 + _e667));
    Count = 2i;
    scratch = array<f32, 2>();
    let _e698 = scratch[1i];
    let _e701 = out;
    local_49 = _e701;
    local_50 = u32(23i);
    let _e706 = local_49;
    local_131 = _e706;
    let _e707 = local_50;
    let _e709 = local_131[1];
    local_131[1] = (_e709 + _e707);
    let _e713 = local_131[0];
    local_132 = u32(_e713);
    let _e717 = local_131[1];
    local_133 = u32(_e717);
    let _e720 = local_133;
    out_1[_e720] = bitcast<u32>(_e698);
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
    let _e746 = out;
    local_51 = _e746;
    local_52 = u32(24i);
    let _e751 = local_51;
    local_134 = _e751;
    let _e752 = local_52;
    let _e754 = local_134[1];
    local_134[1] = (_e754 + _e752);
    let _e758 = local_134[0];
    local_135 = u32(_e758);
    let _e762 = local_134[1];
    local_136 = u32(_e762);
    let _e765 = local_136;
    out_1[_e765] = u32(_e743);
    value = 0f;
    let _e768 = value;
    value = (_e768 + f32(1i));
    let _e774 = gen__naga_trigonometry(bitcast<u32>(_e768), 0u);
    let _e775 = value;
    value = (_e775 - f32(1i));
    let _e779 = value;
    let _e782 = gen__naga_trigonometry(bitcast<u32>(_e779), 1u);
    let _e786 = out;
    local_53 = _e786;
    local_54 = u32(25i);
    let _e791 = local_53;
    local_137 = _e791;
    let _e792 = local_54;
    let _e794 = local_137[1];
    local_137[1] = (_e794 + _e792);
    let _e798 = local_137[0];
    local_138 = u32(_e798);
    let _e802 = local_137[1];
    local_139 = u32(_e802);
    let _e805 = local_139;
    out_1[_e805] = bitcast<u32>(bitcast<f32>(_e782));
    let _e807 = value;
    let _e810 = out;
    local_55 = _e810;
    local_56 = u32(26i);
    let _e815 = local_55;
    local_140 = _e815;
    let _e816 = local_56;
    let _e818 = local_140[1];
    local_140[1] = (_e818 + _e816);
    let _e822 = local_140[0];
    local_141 = u32(_e822);
    let _e826 = local_140[1];
    local_142 = u32(_e826);
    let _e829 = local_142;
    out_1[_e829] = bitcast<u32>(_e807);
    if true {
        let _e835 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
        local_59 = bitcast<f32>(_e835);
    } else {
        let _e841 = gen__naga_trigonometry(bitcast<u32>(99f), 0u);
        local_59 = bitcast<f32>(_e841);
    }
    let _e845 = local_59;
    let _e848 = out;
    local_57 = _e848;
    local_58 = u32(27i);
    let _e853 = local_57;
    local_143 = _e853;
    let _e854 = local_58;
    let _e856 = local_143[1];
    local_143[1] = (_e856 + _e854);
    let _e860 = local_143[0];
    local_144 = u32(_e860);
    let _e864 = local_143[1];
    local_145 = u32(_e864);
    let _e867 = local_145;
    out_1[_e867] = u32(_e845);
    let _e871 = cosine_value(f32(false));
    let _e874 = out;
    local_60 = _e874;
    local_61 = u32(28i);
    let _e879 = local_60;
    local_146 = _e879;
    let _e880 = local_61;
    let _e882 = local_146[1];
    local_146[1] = (_e882 + _e880);
    let _e886 = local_146[0];
    local_147 = u32(_e886);
    let _e890 = local_146[1];
    local_148 = u32(_e890);
    let _e893 = local_148;
    out_1[_e893] = bitcast<u32>(_e871);
}
