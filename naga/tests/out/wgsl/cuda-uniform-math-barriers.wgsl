struct type_2 {
    value: f32,
}

@group(0) @binding(0)
var<uniform> value_1: type_2;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
var<workgroup> shared_values: array<u32, 4>;

fn gen__naga_floorf(input_bits: u32) -> u32 {
    let _e5 = (input_bits & 2147483647u);
    let _e6 = (input_bits & 2147483648u);
    let _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e15 = (_e14 - 1u);
    let _e19 = (input_bits & ~(_e15));
    return select(select(select(select(_e19, (_e19 + _e14), ((_e6 != 0u) && ((input_bits & _e15) != 0u))), select((_e6 | ((_e6 >> 31u) * 1065353216u)), input_bits, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

fn gen__naga_ceilf(input_bits_1: u32) -> u32 {
    let _e5 = (input_bits_1 & 2147483647u);
    let _e6 = (input_bits_1 & 2147483648u);
    let _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e14 = (_e13 - 1u);
    let _e18 = (input_bits_1 & ~(_e14));
    return select(select(select(select(_e18, (_e18 + _e13), ((_e6 == 0u) && ((input_bits_1 & _e14) != 0u))), select((_e6 | ((1u - (_e6 >> 31u)) * 1065353216u)), input_bits_1, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits_1, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

fn gen__naga_roundf(input_bits_2: u32) -> u32 {
    let _e5 = (input_bits_2 & 2147483647u);
    let _e6 = (input_bits_2 & 2147483648u);
    let _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e14 = (_e13 - 1u);
    let _e15 = (input_bits_2 & _e14);
    let _e18 = (input_bits_2 & ~(_e14));
    return select(select(select(select(_e18, (_e18 + _e13), ((_e15 >= (_e13 >> 1u)) && (_e15 != 0u))), select(select(_e6, (_e6 | 1065353216u), (_e5 >= 1056964608u)), input_bits_2, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits_2, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

fn gen__naga_fabsf(input_bits_3: u32) -> u32 {
    let _e2 = (input_bits_3 & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

fn gen__naga_sqrtf(input_bits_4: u32) -> u32 {
    var significand: u32;
    var adjusted_exponent: u32;
    var upper_word: u32;
    var lower_word: u32;
    var root: u32;
    var remainder: u32;
    var iteration: u32;

    let _e5 = (input_bits_4 & 2147483647u);
    if ((_e5 == 0u) || (input_bits_4 == 2139095040u)) {
        return input_bits_4;
    }
    if (((input_bits_4 & 2147483648u) != 0u) || (_e5 > 2139095040u)) {
        return 2143289344u;
    }
    let _e19 = (input_bits_4 & 8388607u);
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

fn gen__naga_divide_f32_(numerator_bits: u32, denominator_bits: u32) -> u32 {
    var numerator_significand: u32;
    var numerator_exponent: i32;
    var denominator_significand: u32;
    var denominator_exponent: i32;
    var quotient: u32;
    var remainder_1: u32;
    var iteration_1: u32;

    let _e8 = (numerator_bits & 2147483647u);
    let _e9 = (denominator_bits & 2147483647u);
    let _e11 = ((numerator_bits ^ denominator_bits) & 2147483648u);
    let _e12 = (_e11 | 2139095040u);
    let _e16 = (_e8 == 0u);
    let _e17 = (_e9 == 0u);
    let _e19 = (_e8 == 2139095040u);
    let _e20 = (_e9 == 2139095040u);
    if ((((_e8 > 2139095040u) || (_e9 > 2139095040u)) || (_e16 && _e17)) || (_e19 && _e20)) {
        return 2143289344u;
    }
    if (_e19 || _e17) {
        return _e12;
    }
    if (_e16 || _e20) {
        return _e11;
    }
    let _e30 = (_e8 & 8388607u);
    let _e31 = (_e8 >> 23u);
    numerator_significand = (_e30 | 8388608u);
    numerator_exponent = (i32(_e31) - 127i);
    if (_e31 == 0u) {
        let _e41 = (countLeadingZeros(_e30) - 8u);
        numerator_significand = (_e30 << _e41);
        numerator_exponent = (-126i - i32(_e41));
    }
    let _e46 = numerator_significand;
    let _e47 = numerator_exponent;
    let _e52 = (_e9 & 8388607u);
    let _e53 = (_e9 >> 23u);
    denominator_significand = (_e52 | 8388608u);
    denominator_exponent = (i32(_e53) - 127i);
    if (_e53 == 0u) {
        let _e63 = (countLeadingZeros(_e52) - 8u);
        denominator_significand = (_e52 << _e63);
        denominator_exponent = (-126i - i32(_e63));
    }
    let _e68 = denominator_significand;
    let _e69 = denominator_exponent;
    let _e70 = (_e46 < _e68);
    let _e75 = ((_e47 - _e69) - i32(_e70));
    if (_e75 < -150i) {
        return _e11;
    }
    quotient = 1u;
    remainder_1 = (select(_e46, (_e46 << 1u), _e70) - _e68);
    iteration_1 = 0u;
    loop {
        let _e83 = iteration_1;
        if (_e83 >= 23u) {
            break;
        }
        let _e85 = remainder_1;
        let _e86 = quotient;
        let _e87 = (_e85 << 1u);
        let _e88 = (_e87 >= _e68);
        remainder_1 = select(_e87, (_e87 - _e68), _e88);
        quotient = ((_e86 << 1u) | select(0u, 1u, _e88));
        continuing {
            let _e94 = iteration_1;
            iteration_1 = (_e94 + 1u);
        }
    }
    let _e96 = quotient;
    let _e97 = remainder_1;
    if (_e75 < -126i) {
        let _e103 = (u32((-126i - _e75)) & 31u);
        let _e104 = (1u << _e103);
        let _e106 = (_e96 & (_e104 - 1u));
        let _e107 = (_e104 >> 1u);
        let _e108 = (_e96 >> _e103);
        return (_e11 | (_e108 + select(0u, 1u, ((_e106 > _e107) || ((_e106 == _e107) && ((_e97 != 0u) || ((_e108 & 1u) != 0u)))))));
    }
    let _e120 = (_e97 << 1u);
    let _e128 = (_e96 + select(0u, 1u, ((_e120 > _e68) || ((_e120 == _e68) && ((_e96 & 1u) != 0u)))));
    let _e130 = (_e128 >> 24u);
    let _e133 = (_e75 + i32(_e130));
    if (_e133 > 127i) {
        return _e12;
    }
    return (_e11 | ((u32((_e133 + 127i)) << 23u) | ((_e128 >> _e130) & 8388607u)));
}

fn gen__naga_fmodf(dividend_bits: u32, divisor_bits: u32) -> u32 {
    var dividend_significand: u32;
    var dividend_exponent: i32;
    var divisor_significand: u32;
    var divisor_exponent: i32;
    var remainder_2: u32;
    var remaining_bits: u32;

    let _e8 = (dividend_bits & 2147483647u);
    let _e9 = (divisor_bits & 2147483647u);
    let _e10 = (dividend_bits & 2147483648u);
    if ((_e8 >= 2139095040u) || ((_e9 > 2139095040u) || (_e9 == 0u))) {
        return 2143289344u;
    }
    if (_e8 < _e9) {
        return dividend_bits;
    }
    if (_e8 == _e9) {
        return _e10;
    }
    let _e22 = (_e8 & 8388607u);
    let _e23 = (_e8 >> 23u);
    dividend_significand = (_e22 | 8388608u);
    dividend_exponent = (i32(_e23) - 127i);
    if (_e23 == 0u) {
        let _e33 = (countLeadingZeros(_e22) - 8u);
        dividend_significand = (_e22 << _e33);
        dividend_exponent = (-126i - i32(_e33));
    }
    let _e38 = dividend_significand;
    let _e39 = dividend_exponent;
    let _e44 = (_e9 & 8388607u);
    let _e45 = (_e9 >> 23u);
    divisor_significand = (_e44 | 8388608u);
    divisor_exponent = (i32(_e45) - 127i);
    if (_e45 == 0u) {
        let _e55 = (countLeadingZeros(_e44) - 8u);
        divisor_significand = (_e44 << _e55);
        divisor_exponent = (-126i - i32(_e55));
    }
    let _e60 = divisor_significand;
    let _e61 = divisor_exponent;
    remainder_2 = _e38;
    remaining_bits = u32((_e39 - _e61));
    loop {
        let _e66 = remaining_bits;
        if (_e66 == 0u) {
            break;
        }
        let _e68 = remainder_2;
        remainder_2 = (select(_e68, (_e68 - _e60), (_e68 >= _e60)) << 1u);
        remaining_bits = (_e66 - 1u);
    }
    let _e74 = remainder_2;
    let _e77 = select(_e74, (_e74 - _e60), (_e74 >= _e60));
    if (_e77 == 0u) {
        return _e10;
    }
    let _e81 = (countLeadingZeros(_e77) - 8u);
    let _e82 = (_e77 << _e81);
    let _e84 = (_e61 - i32(_e81));
    return (_e10 | select((_e82 >> (u32((-126i - _e84)) & 31u)), ((u32((_e84 + 127i)) << 23u) | (_e82 & 8388607u)), (_e84 >= -126i)));
}

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

fn gen__naga_trig_divide(value: array<u32, 12>, divisor: u32) -> array<u32, 12> {
    var source: array<u32, 12> = array<u32, 12>();
    var result_2: array<u32, 12> = array<u32, 12>();
    var remainder_3: u32 = u32();
    var step_: u32 = u32();

    source = value;
    step_ = 0u;
    loop {
        let _e11 = step_;
        if (_e11 >= 12u) {
            break;
        }
        let _e15 = (11u - _e11);
        let _e16 = remainder_3;
        let _e20 = source[_e15];
        let _e21 = ((_e16 << 16u) | _e20);
        result_2[_e15] = (_e21 / divisor);
        remainder_3 = (_e21 % divisor);
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

fn gen__naga_trigonometry(input_bits_5: u32, cosine: u32) -> u32 {
    var quadrant: u32 = u32();
    var fraction: array<u32, 12> = array<u32, 12>();
    var fraction_index: u32 = u32();

    let _e3 = (input_bits_5 & 2147483647u);
    if (_e3 >= 2139095040u) {
        return 2143289344u;
    }
    let _e8 = (cosine != 0u);
    if (_e3 <= 956301312u) {
        return ((cosine * 1065353216u) | ((1u - cosine) * input_bits_5));
    }
    let _e20 = (470u - (_e3 >> 23u));
    let _e24 = ((_e3 & 8388607u) | 8388608u);
    let _e51 = gen__naga_trig_reduce_multiply(array<u32, 2>((_e24 & 65535u), (_e24 >> 16u)), array<u32, 20>(53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    let _e54 = gen__naga_trig_extract_product(_e51, _e20);
    quadrant = (_e54 & 3u);
    fraction_index = 0u;
    loop {
        let _e64 = fraction_index;
        if (_e64 >= 11u) {
            break;
        }
        let _e70 = gen__naga_trig_extract_product(_e51, ((_e20 - 176u) + (_e64 * 16u)));
        fraction[_e64] = _e70;
        continuing {
            let _e72 = fraction_index;
            fraction_index = (_e72 + 1u);
        }
    }
    let _e77 = fraction[10u];
    let _e79 = (_e77 >= 32768u);
    if _e79 {
        let _e93 = quadrant;
        quadrant = ((_e93 + 1u) & 3u);
        let _e98 = fraction;
        let _e100 = gen__naga_trig_combine(array<u32, 12>(0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u), _e98, 1u);
        fraction = _e100;
    }
    let _e101 = fraction;
    let _e115 = gen__naga_trig_multiply(_e101, array<u32, 12>(5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u));
    let _e116 = quadrant;
    let _e119 = ((_e116 & 1u) == cosine);
    let _e123 = gen__naga_trig_kernel(_e115, select(0u, 1u, _e119));
    let _e124 = gen__naga_trig_round(_e123);
    return (_e124 | ((select(0u, 2147483648u, (_e79 && _e119)) ^ ((select(_e116, (_e116 + 1u), _e8) & 2u) << 30u)) ^ select((input_bits_5 & 2147483648u), 0u, _e8)));
}

@compute @workgroup_size(4, 1, 1)
fn uniform_math_barriers(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var flags: u32;
    var local: u32;
    var local_1: u32;

    let value_2 = value_1.value;
    let lane = threadIdx.x;
    shared_values[lane] = (lane + 1u);
    flags = 1u;
    flags = 0u;
    let _e13 = gen__naga_floorf(bitcast<u32>(value_2));
    if (bitcast<f32>(_e13) > 0f) {
        storageBarrier();
        workgroupBarrier();
        let _e17 = flags;
        flags = (_e17 | 1u);
    }
    let _e21 = gen__naga_ceilf(bitcast<u32>(value_2));
    if (bitcast<f32>(_e21) > 0f) {
        storageBarrier();
        workgroupBarrier();
        let _e25 = flags;
        flags = (_e25 | 2u);
    }
    let _e29 = gen__naga_roundf(bitcast<u32>(value_2));
    if (bitcast<f32>(_e29) > 0f) {
        storageBarrier();
        workgroupBarrier();
        let _e33 = flags;
        flags = (_e33 | 4u);
    }
    let _e37 = gen__naga_fabsf(bitcast<u32>(value_2));
    if (bitcast<f32>(_e37) > 0f) {
        storageBarrier();
        workgroupBarrier();
        let _e41 = flags;
        flags = (_e41 | 8u);
    }
    let _e45 = gen__naga_sqrtf(bitcast<u32>(value_2));
    if (bitcast<f32>(_e45) > 0f) {
        storageBarrier();
        workgroupBarrier();
        let _e49 = flags;
        flags = (_e49 | 16u);
    }
    let _e53 = gen__naga_sqrtf(bitcast<u32>(value_2));
    let _e58 = gen__naga_divide_f32_(bitcast<u32>(1f), bitcast<u32>(bitcast<f32>(_e53)));
    if (bitcast<f32>(_e58) > 0f) {
        storageBarrier();
        workgroupBarrier();
        let _e62 = flags;
        flags = (_e62 | 32u);
    }
    let _e68 = gen__naga_fmodf(bitcast<u32>(value_2), bitcast<u32>(2f));
    if (bitcast<f32>(_e68) > 0f) {
        storageBarrier();
        workgroupBarrier();
        let _e72 = flags;
        flags = (_e72 | 64u);
    }
    let _e78 = gen__naga_divide_f32_(bitcast<u32>(value_2), bitcast<u32>(2f));
    if (bitcast<f32>(_e78) > 0f) {
        storageBarrier();
        workgroupBarrier();
        let _e82 = flags;
        flags = (_e82 | 128u);
    }
    let _e87 = gen__naga_trigonometry(bitcast<u32>(value_2), 0u);
    if (bitcast<f32>(_e87) > 0f) {
        storageBarrier();
        workgroupBarrier();
        let _e91 = flags;
        flags = (_e91 | 256u);
    }
    let _e96 = gen__naga_trigonometry(bitcast<u32>(value_2), 1u);
    if (bitcast<f32>(_e96) > 0f) {
        storageBarrier();
        workgroupBarrier();
        let _e100 = flags;
        flags = (_e100 | 512u);
    }
    let _e108 = shared_values[((lane + 1u) & 3u)];
    local = u32((4u + (lane * 2u)));
    let _e115 = local;
    output[_e115] = _e108;
    let _e118 = flags;
    local_1 = u32((5u + (lane * 2u)));
    let _e125 = local_1;
    output[_e125] = _e118;
}
