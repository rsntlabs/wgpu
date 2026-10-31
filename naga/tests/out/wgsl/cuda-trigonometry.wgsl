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
    let _e3 = gen__naga_trigonometry(bitcast<u32>(value_2), 0u);
    return bitcast<f32>(_e3);
}

fn cosine_value(value_3: f32) -> f32 {
    let _e3 = gen__naga_trigonometry(bitcast<u32>(value_3), 1u);
    return bitcast<f32>(_e3);
}

fn sinf(value_4: bool) -> i32 {
    var local_62: i32;

    if value_4 {
        local_62 = 17i;
    } else {
        local_62 = 19i;
    }
    let _e6 = local_62;
    return _e6;
}

fn cosf(value_5: i32) -> i32 {
    return (value_5 + 23i);
}

fn sinf_1(first: f32, second: f32) -> f32 {
    return (first + second);
}

fn cosf_1(value_6: vec2<f32>) -> f32 {
    var value_7: vec2<f32>;

    value_7 = value_6;
    let _e4 = value_7.x;
    let _e5 = value_7.y;
    return (_e4 + _e5);
}

fn identity(value_8: f32) -> f32 {
    return value_8;
}

fn pair(first_1: f32, second_1: f32) -> f32 {
    return ((first_1 * 10f) + second_1);
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
    var value: f32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var choose: bool;
    var counter: i32;
    var local_18: u32;
    var local_19: bool;
    var local_20: u32;
    var local_21: bool;
    var local_22: u32;
    var local_23: f32;
    var local_24: u32;
    var values: array<f32, 2>;
    var local_25: u32;
    var Count: i32;
    var scratch: array<f32, 2>;
    var local_26: u32;
    var repeated: i32;
    var index: i32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: f32;
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

    let _e3 = gen__naga_trigonometry(bitcast<u32>(0f), 0u);
    local = u32(0i);
    let _e10 = local;
    local_33 = u32(_e10);
    let _e13 = local_33;
    out[_e13] = bitcast<u32>(bitcast<f32>(_e3));
    let _e19 = gen__naga_trigonometry(bitcast<u32>(-(0f)), 0u);
    local_1 = u32(1i);
    let _e25 = local_1;
    local_34 = u32(_e25);
    let _e28 = local_34;
    out[_e28] = bitcast<u32>(bitcast<f32>(_e19));
    let _e33 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    local_2 = u32(2i);
    let _e39 = local_2;
    local_35 = u32(_e39);
    let _e42 = local_35;
    out[_e42] = bitcast<u32>(bitcast<f32>(_e33));
    let _e48 = gen__naga_trigonometry(bitcast<u32>(-(0f)), 1u);
    local_3 = u32(3i);
    let _e54 = local_3;
    local_36 = u32(_e54);
    let _e57 = local_36;
    out[_e57] = bitcast<u32>(bitcast<f32>(_e48));
    let _e61 = sine_value(f32(0i));
    local_4 = u32(4i);
    let _e66 = local_4;
    local_37 = u32(_e66);
    let _e69 = local_37;
    out[_e69] = bitcast<u32>(_e61);
    let _e73 = cosine_value(f32(0u));
    local_5 = u32(5i);
    let _e78 = local_5;
    local_38 = u32(_e78);
    let _e81 = local_38;
    out[_e81] = bitcast<u32>(_e73);
    let _e84 = sinf(true);
    local_6 = u32(6i);
    let _e89 = local_6;
    local_39 = u32(_e89);
    let _e92 = local_39;
    out[_e92] = u32(_e84);
    let _e95 = sinf(false);
    local_7 = u32(7i);
    let _e100 = local_7;
    local_40 = u32(_e100);
    let _e103 = local_40;
    out[_e103] = u32(_e95);
    let _e106 = cosf(4i);
    local_8 = u32(8i);
    let _e111 = local_8;
    local_41 = u32(_e111);
    let _e114 = local_41;
    out[_e114] = u32(_e106);
    let _e119 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    local_9 = u32(9i);
    let _e125 = local_9;
    local_42 = u32(_e125);
    let _e128 = local_42;
    out[_e128] = bitcast<u32>(bitcast<f32>(_e119));
    let _e132 = sinf_1(2f, 3f);
    local_10 = u32(10i);
    let _e137 = local_10;
    local_43 = u32(_e137);
    let _e140 = local_43;
    out[_e140] = bitcast<u32>(_e132);
    let _e145 = cosf_1(vec2<f32>(2f, 3f));
    local_11 = u32(11i);
    let _e150 = local_11;
    local_44 = u32(_e150);
    let _e153 = local_44;
    out[_e153] = bitcast<u32>(_e145);
    value = 0f;
    let _e157 = value;
    value = (_e157 + f32(1i));
    let _e163 = gen__naga_trigonometry(bitcast<u32>(_e157), 0u);
    local_12 = u32(12i);
    let _e169 = local_12;
    local_45 = u32(_e169);
    let _e172 = local_45;
    out[_e172] = bitcast<u32>(bitcast<f32>(_e163));
    let _e174 = value;
    local_13 = u32(13i);
    let _e179 = local_13;
    local_46 = u32(_e179);
    let _e182 = local_46;
    out[_e182] = bitcast<u32>(_e174);
    value = -(1f);
    let _e186 = value;
    value = (_e186 + f32(1i));
    let _e190 = value;
    let _e193 = gen__naga_trigonometry(bitcast<u32>(_e190), 1u);
    local_14 = u32(14i);
    let _e199 = local_14;
    local_47 = u32(_e199);
    let _e202 = local_47;
    out[_e202] = bitcast<u32>(bitcast<f32>(_e193));
    let _e204 = value;
    local_15 = u32(15i);
    let _e209 = local_15;
    local_48 = u32(_e209);
    let _e212 = local_48;
    out[_e212] = bitcast<u32>(_e204);
    let _e214 = value;
    value = (_e214 + f32(1i));
    let _e218 = identity(_e214);
    let _e221 = gen__naga_trigonometry(bitcast<u32>(_e218), 0u);
    let _e223 = value;
    value = (_e223 + f32(1i));
    let _e227 = pair(bitcast<f32>(_e221), _e223);
    local_16 = u32(16i);
    let _e232 = local_16;
    local_49 = u32(_e232);
    let _e235 = local_49;
    out[_e235] = bitcast<u32>(_e227);
    let _e237 = value;
    local_17 = u32(17i);
    let _e242 = local_17;
    local_50 = u32(_e242);
    let _e245 = local_50;
    out[_e245] = bitcast<u32>(_e237);
    choose = false;
    counter = 0i;
    let _e251 = choose;
    local_19 = _e251;
    if _e251 {
        let _e253 = counter;
        counter = (_e253 + 1i);
        let _e259 = gen__naga_trigonometry(bitcast<u32>(f32(_e253)), 0u);
        local_19 = (bitcast<f32>(_e259) != 0f);
    }
    let _e263 = local_19;
    local_18 = u32(18i);
    let _e268 = local_18;
    local_51 = u32(_e268);
    let _e271 = local_51;
    out[_e271] = u32(_e263);
    local_21 = true;
    if true {
    } else {
        let _e275 = counter;
        counter = (_e275 + 1i);
        let _e281 = gen__naga_trigonometry(bitcast<u32>(f32(_e275)), 1u);
        local_21 = (bitcast<f32>(_e281) != 0f);
    }
    let _e285 = local_21;
    local_20 = u32(19i);
    let _e290 = local_20;
    local_52 = u32(_e290);
    let _e293 = local_52;
    out[_e293] = u32(_e285);
    let _e295 = choose;
    if _e295 {
        let _e296 = counter;
        counter = (_e296 + 1i);
        let _e299 = counter;
        let _e303 = gen__naga_trigonometry(bitcast<u32>(f32(_e299)), 0u);
        local_23 = bitcast<f32>(_e303);
    } else {
        let _e306 = counter;
        let _e310 = gen__naga_trigonometry(bitcast<u32>(f32(_e306)), 1u);
        local_23 = bitcast<f32>(_e310);
    }
    let _e314 = local_23;
    local_22 = u32(20i);
    let _e319 = local_22;
    local_53 = u32(_e319);
    let _e322 = local_53;
    out[_e322] = u32(_e314);
    let _e324 = counter;
    local_24 = u32(21i);
    let _e329 = local_24;
    local_54 = u32(_e329);
    let _e332 = local_54;
    out[_e332] = u32(_e324);
    let _e339 = gen__naga_trigonometry(bitcast<u32>(0f), 0u);
    values[0] = bitcast<f32>(_e339);
    let _e345 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
    values[1] = bitcast<f32>(_e345);
    let _e351 = values[0i];
    let _e352 = values[1i];
    local_25 = u32(22i);
    let _e358 = local_25;
    local_55 = u32(_e358);
    let _e361 = local_55;
    out[_e361] = bitcast<u32>((_e351 + _e352));
    Count = 2i;
    scratch = array<f32, 2>();
    let _e369 = scratch[1i];
    local_26 = u32(23i);
    let _e374 = local_26;
    local_56 = u32(_e374);
    let _e377 = local_56;
    out[_e377] = bitcast<u32>(_e369);
    repeated = 0i;
    {
        index = 0i;
        loop {
            let _e383 = index;
            if (_e383 < 3i) {
            } else {
                break;
            }
            let _e386 = index;
            if (_e386 == 0i) {
                continue;
            }
            let _e392 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
            let _e395 = repeated;
            repeated = (_e395 + i32(bitcast<f32>(_e392)));
            continuing {
                let _e397 = index;
                index = (_e397 + 1i);
            }
        }
    }
    let _e400 = repeated;
    local_27 = u32(24i);
    let _e405 = local_27;
    local_57 = u32(_e405);
    let _e408 = local_57;
    out[_e408] = u32(_e400);
    value = 0f;
    let _e411 = value;
    value = (_e411 + f32(1i));
    let _e417 = gen__naga_trigonometry(bitcast<u32>(_e411), 0u);
    let _e418 = value;
    value = (_e418 - f32(1i));
    let _e422 = value;
    let _e425 = gen__naga_trigonometry(bitcast<u32>(_e422), 1u);
    local_28 = u32(25i);
    let _e431 = local_28;
    local_58 = u32(_e431);
    let _e434 = local_58;
    out[_e434] = bitcast<u32>(bitcast<f32>(_e425));
    let _e436 = value;
    local_29 = u32(26i);
    let _e441 = local_29;
    local_59 = u32(_e441);
    let _e444 = local_59;
    out[_e444] = bitcast<u32>(_e436);
    if true {
        let _e450 = gen__naga_trigonometry(bitcast<u32>(0f), 1u);
        local_31 = bitcast<f32>(_e450);
    } else {
        let _e456 = gen__naga_trigonometry(bitcast<u32>(99f), 0u);
        local_31 = bitcast<f32>(_e456);
    }
    let _e460 = local_31;
    local_30 = u32(27i);
    let _e465 = local_30;
    local_60 = u32(_e465);
    let _e468 = local_60;
    out[_e468] = u32(_e460);
    let _e472 = cosine_value(f32(false));
    local_32 = u32(28i);
    let _e477 = local_32;
    local_61 = u32(_e477);
    let _e480 = local_61;
    out[_e480] = bitcast<u32>(_e472);
}
