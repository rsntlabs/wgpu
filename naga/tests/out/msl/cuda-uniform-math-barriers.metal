// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size1;
};

struct type_2 {
    float value;
    char _pad1[12];
};
typedef uint type_3[1];
struct type_4 {
    uint inner[4];
};
struct type_7 {
    uint inner[12];
};
struct type_8 {
    uint inner[22];
};
struct type_9 {
    uint inner[24];
};
struct type_10 {
    uint inner[2];
};
struct type_11 {
    uint inner[20];
};

uint _naga_floorf(
    uint input_bits
) {
    uint _e5 = input_bits & 2147483647u;
    bool _e7 = (input_bits & 2147483648u) != 0u;
    uint _e14 = 1u << ((150u - (_e5 >> 23u)) & 31u);
    uint _e15 = _e14 - 1u;
    uint _e19 = input_bits & ~(_e15);
    return (_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e7 ? 3212836864u : 0u)) : ((_e7 && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19)));
}

uint _naga_ceilf(
    uint input_bits_1
) {
    uint _e5 = input_bits_1 & 2147483647u;
    uint _e6 = input_bits_1 & 2147483648u;
    uint _e14 = 1u << ((150u - (_e5 >> 23u)) & 31u);
    uint _e15 = _e14 - 1u;
    uint _e19 = input_bits_1 & ~(_e15);
    return (_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits_1 : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits_1 : ((_e6 != 0u) ? 2147483648u : 1065353216u)) : (((_e6 == 0u) && ((input_bits_1 & _e15) != 0u)) ? (_e19 + _e14) : _e19)));
}

uint _naga_roundf(
    uint input_bits_2
) {
    uint _e5 = input_bits_2 & 2147483647u;
    uint _e6 = input_bits_2 & 2147483648u;
    uint _e13 = 1u << ((150u - (_e5 >> 23u)) & 31u);
    uint _e14 = _e13 - 1u;
    uint _e15 = input_bits_2 & _e14;
    uint _e18 = input_bits_2 & ~(_e14);
    return (_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits_2 : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits_2 : ((_e5 >= 1056964608u) ? (_e6 | 1065353216u) : _e6)) : (((_e15 >= (_e13 >> 1u)) && (_e15 != 0u)) ? (_e18 + _e13) : _e18)));
}

uint _naga_fabsf(
    uint input_bits_3
) {
    uint _e2 = input_bits_3 & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}

uint _naga_sqrtf(
    uint input_bits_4
) {
    uint significand = {};
    uint adjusted_exponent = {};
    uint upper_word = {};
    uint lower_word = {};
    uint root = {};
    uint remainder = {};
    uint iteration = {};
    uint _e5 = input_bits_4 & 2147483647u;
    if ((_e5 == 0u) || (input_bits_4 == 2139095040u)) {
        return input_bits_4;
    }
    if (((input_bits_4 & 2147483648u) != 0u) || (_e5 > 2139095040u)) {
        return 2143289344u;
    }
    uint _e19 = input_bits_4 & 8388607u;
    uint _e20 = _e5 >> 23u;
    significand = _e19 | 8388608u;
    adjusted_exponent = _e20 + 127u;
    if (_e20 == 0u) {
        uint _e28 = metal::clz(_e19) - 8u;
        significand = _e19 << _e28;
        adjusted_exponent = 128u - _e28;
    }
    uint _e32 = significand;
    uint _e33 = adjusted_exponent;
    uint _e34 = _e33 & 1u;
    upper_word = _e32 >> (9u - _e34);
    lower_word = _e32 << (23u + _e34);
    root = 0u;
    remainder = 0u;
    iteration = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e72 = iteration;
            iteration = _e72 + 1u;
        }
        loop_init = false;
        uint _e50 = iteration;
        if (_e50 >= 24u) {
            break;
        }
        uint _e52 = upper_word;
        uint _e53 = lower_word;
        uint _e54 = root;
        uint _e55 = remainder;
        uint _e63 = (_e55 << 2u) | (_e52 >> 14u);
        uint _e65 = (_e54 << 2u) | 1u;
        bool _e66 = _e63 >= _e65;
        uint _e69 = _e54 << 1u;
        upper_word = ((_e52 << 2u) | (_e53 >> 30u)) & 65535u;
        lower_word = _e53 << 2u;
        remainder = _e66 ? (_e63 - _e65) : _e63;
        root = _e66 ? (_e69 | 1u) : _e69;
    }
    uint _e74 = root;
    uint _e75 = remainder;
    return ((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u);
}

uint _naga_divide_f32_(
    uint numerator_bits,
    uint denominator_bits
) {
    uint numerator_significand = {};
    int numerator_exponent = {};
    uint denominator_significand = {};
    int denominator_exponent = {};
    uint quotient = {};
    uint remainder_1 = {};
    uint iteration_1 = {};
    uint _e8 = numerator_bits & 2147483647u;
    uint _e9 = denominator_bits & 2147483647u;
    uint _e11 = (numerator_bits ^ denominator_bits) & 2147483648u;
    uint _e12 = _e11 | 2139095040u;
    bool _e16 = _e8 == 0u;
    bool _e17 = _e9 == 0u;
    bool _e19 = _e8 == 2139095040u;
    bool _e20 = _e9 == 2139095040u;
    if ((((_e8 > 2139095040u) || (_e9 > 2139095040u)) || (_e16 && _e17)) || (_e19 && _e20)) {
        return 2143289344u;
    }
    if (_e19 || _e17) {
        return _e12;
    }
    if (_e16 || _e20) {
        return _e11;
    }
    uint _e30 = _e8 & 8388607u;
    uint _e31 = _e8 >> 23u;
    numerator_significand = _e30 | 8388608u;
    numerator_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e31)) - as_type<uint>(127));
    if (_e31 == 0u) {
        uint _e41 = metal::clz(_e30) - 8u;
        numerator_significand = _e30 << _e41;
        numerator_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e41)));
    }
    uint _e46 = numerator_significand;
    int _e47 = numerator_exponent;
    uint _e52 = _e9 & 8388607u;
    uint _e53 = _e9 >> 23u;
    denominator_significand = _e52 | 8388608u;
    denominator_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e53)) - as_type<uint>(127));
    if (_e53 == 0u) {
        uint _e63 = metal::clz(_e52) - 8u;
        denominator_significand = _e52 << _e63;
        denominator_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e63)));
    }
    uint _e68 = denominator_significand;
    int _e69 = denominator_exponent;
    bool _e70 = _e46 < _e68;
    int _e75 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e47) - as_type<uint>(_e69))) - as_type<uint>(static_cast<int>(_e70)));
    if (_e75 < -150) {
        return _e11;
    }
    quotient = 1u;
    remainder_1 = (_e70 ? (_e46 << 1u) : _e46) - _e68;
    iteration_1 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e94 = iteration_1;
            iteration_1 = _e94 + 1u;
        }
        loop_init_1 = false;
        uint _e83 = iteration_1;
        if (_e83 >= 23u) {
            break;
        }
        uint _e85 = remainder_1;
        uint _e86 = quotient;
        uint _e87 = _e85 << 1u;
        bool _e88 = _e87 >= _e68;
        remainder_1 = _e88 ? (_e87 - _e68) : _e87;
        quotient = (_e86 << 1u) | (_e88 ? 1u : 0u);
    }
    uint _e96 = quotient;
    uint _e97 = remainder_1;
    if (_e75 < -126) {
        uint _e103 = static_cast<uint>(as_type<int>(as_type<uint>(-126) - as_type<uint>(_e75))) & 31u;
        uint _e104 = 1u << _e103;
        uint _e106 = _e96 & (_e104 - 1u);
        uint _e107 = _e104 >> 1u;
        uint _e108 = _e96 >> _e103;
        return _e11 | (_e108 + (((_e106 > _e107) || ((_e106 == _e107) && ((_e97 != 0u) || ((_e108 & 1u) != 0u)))) ? 1u : 0u));
    }
    uint _e120 = _e97 << 1u;
    uint _e128 = _e96 + (((_e120 > _e68) || ((_e120 == _e68) && ((_e96 & 1u) != 0u))) ? 1u : 0u);
    uint _e130 = _e128 >> 24u;
    int _e133 = as_type<int>(as_type<uint>(_e75) + as_type<uint>(static_cast<int>(_e130)));
    if (_e133 > 127) {
        return _e12;
    }
    return _e11 | ((static_cast<uint>(as_type<int>(as_type<uint>(_e133) + as_type<uint>(127))) << 23u) | ((_e128 >> _e130) & 8388607u));
}

uint _naga_fmodf(
    uint dividend_bits,
    uint divisor_bits
) {
    uint dividend_significand = {};
    int dividend_exponent = {};
    uint divisor_significand = {};
    int divisor_exponent = {};
    uint remainder_2 = {};
    uint remaining_bits = {};
    uint _e8 = dividend_bits & 2147483647u;
    uint _e9 = divisor_bits & 2147483647u;
    uint _e10 = dividend_bits & 2147483648u;
    if ((_e8 >= 2139095040u) || ((_e9 > 2139095040u) || (_e9 == 0u))) {
        return 2143289344u;
    }
    if (_e8 < _e9) {
        return dividend_bits;
    }
    if (_e8 == _e9) {
        return _e10;
    }
    uint _e22 = _e8 & 8388607u;
    uint _e23 = _e8 >> 23u;
    dividend_significand = _e22 | 8388608u;
    dividend_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e23)) - as_type<uint>(127));
    if (_e23 == 0u) {
        uint _e33 = metal::clz(_e22) - 8u;
        dividend_significand = _e22 << _e33;
        dividend_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e33)));
    }
    uint _e38 = dividend_significand;
    int _e39 = dividend_exponent;
    uint _e44 = _e9 & 8388607u;
    uint _e45 = _e9 >> 23u;
    divisor_significand = _e44 | 8388608u;
    divisor_exponent = as_type<int>(as_type<uint>(static_cast<int>(_e45)) - as_type<uint>(127));
    if (_e45 == 0u) {
        uint _e55 = metal::clz(_e44) - 8u;
        divisor_significand = _e44 << _e55;
        divisor_exponent = as_type<int>(as_type<uint>(-126) - as_type<uint>(static_cast<int>(_e55)));
    }
    uint _e60 = divisor_significand;
    int _e61 = divisor_exponent;
    remainder_2 = _e38;
    remaining_bits = static_cast<uint>(as_type<int>(as_type<uint>(_e39) - as_type<uint>(_e61)));
    uint2 loop_bound_2 = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound_2 == uint2(0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        uint _e66 = remaining_bits;
        if (_e66 == 0u) {
            break;
        }
        uint _e68 = remainder_2;
        remainder_2 = ((_e68 >= _e60) ? (_e68 - _e60) : _e68) << 1u;
        remaining_bits = _e66 - 1u;
    }
    uint _e74 = remainder_2;
    uint _e77 = (_e74 >= _e60) ? (_e74 - _e60) : _e74;
    if (_e77 == 0u) {
        return _e10;
    }
    uint _e81 = metal::clz(_e77) - 8u;
    uint _e82 = _e77 << _e81;
    int _e84 = as_type<int>(as_type<uint>(_e61) - as_type<uint>(static_cast<int>(_e81)));
    return _e10 | ((_e84 >= -126) ? ((static_cast<uint>(as_type<int>(as_type<uint>(_e84) + as_type<uint>(127))) << 23u) | (_e82 & 8388607u)) : (_e82 >> (static_cast<uint>(as_type<int>(as_type<uint>(-126) - as_type<uint>(_e84))) & 31u)));
}

type_7 _naga_trig_multiply(
    type_7 left,
    type_7 right
) {
    type_7 left_digits = type_7 {};
    type_7 right_digits = type_7 {};
    type_9 product = type_9 {};
    uint carry = uint {};
    uint left_index = uint {};
    uint right_index = uint {};
    type_7 result = type_7 {};
    uint result_index = uint {};
    left_digits = left;
    right_digits = right;
    left_index = 0u;
    uint2 loop_bound_3 = uint2(4294967295u);
    bool loop_init_2 = true;
    while(true) {
        if (metal::all(loop_bound_3 == uint2(0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_2) {
            uint _e46 = left_index;
            left_index = _e46 + 1u;
        }
        loop_init_2 = false;
        uint _e13 = left_index;
        if (_e13 >= 12u) {
            break;
        }
        carry = 0u;
        uint _e18 = left_digits.inner[_e13];
        right_index = 0u;
        uint2 loop_bound_4 = uint2(4294967295u);
        bool loop_init_3 = true;
        while(true) {
            if (metal::all(loop_bound_4 == uint2(0u))) { break; }
            loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
            if (!loop_init_3) {
                uint _e39 = right_index;
                right_index = _e39 + 1u;
            }
            loop_init_3 = false;
            uint _e22 = right_index;
            if (_e22 >= 12u) {
                break;
            }
            uint _e26 = right_digits.inner[_e22];
            uint _e27 = _e13 + _e22;
            uint _e29 = product.inner[_e27];
            uint _e30 = carry;
            uint _e33 = ((_e18 * _e26) + _e29) + _e30;
            product.inner[_e27] = _e33 & 65535u;
            carry = _e33 >> 16u;
        }
        uint _e44 = carry;
        product.inner[_e13 + 12u] = _e44;
    }
    result_index = 0u;
    uint2 loop_bound_5 = uint2(4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (metal::all(loop_bound_5 == uint2(0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e62 = result_index;
            result_index = _e62 + 1u;
        }
        loop_init_4 = false;
        uint _e54 = result_index;
        if (_e54 >= 12u) {
            break;
        }
        uint _e60 = product.inner[_e54 + 11u];
        result.inner[_e54] = _e60;
    }
    type_7 _e65 = result;
    return _e65;
}

type_8 _naga_trig_reduce_multiply(
    type_10 left_1,
    type_11 right_1
) {
    type_10 left_digits_1 = type_10 {};
    type_11 right_digits_1 = type_11 {};
    type_8 product_1 = type_8 {};
    uint carry_1 = uint {};
    uint left_index_1 = uint {};
    uint right_index_1 = uint {};
    type_8 result_1 = type_8 {};
    uint result_index_1 = uint {};
    left_digits_1 = left_1;
    right_digits_1 = right_1;
    left_index_1 = 0u;
    uint2 loop_bound_6 = uint2(4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (metal::all(loop_bound_6 == uint2(0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e46 = left_index_1;
            left_index_1 = _e46 + 1u;
        }
        loop_init_5 = false;
        uint _e13 = left_index_1;
        if (_e13 >= 2u) {
            break;
        }
        carry_1 = 0u;
        uint _e18 = left_digits_1.inner[_e13];
        right_index_1 = 0u;
        uint2 loop_bound_7 = uint2(4294967295u);
        bool loop_init_6 = true;
        while(true) {
            if (metal::all(loop_bound_7 == uint2(0u))) { break; }
            loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
            if (!loop_init_6) {
                uint _e39 = right_index_1;
                right_index_1 = _e39 + 1u;
            }
            loop_init_6 = false;
            uint _e22 = right_index_1;
            if (_e22 >= 20u) {
                break;
            }
            uint _e26 = right_digits_1.inner[_e22];
            uint _e27 = _e13 + _e22;
            uint _e29 = product_1.inner[_e27];
            uint _e30 = carry_1;
            uint _e33 = ((_e18 * _e26) + _e29) + _e30;
            product_1.inner[_e27] = _e33 & 65535u;
            carry_1 = _e33 >> 16u;
        }
        uint _e44 = carry_1;
        product_1.inner[_e13 + 20u] = _e44;
    }
    result_index_1 = 0u;
    uint2 loop_bound_8 = uint2(4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (metal::all(loop_bound_8 == uint2(0u))) { break; }
        loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e62 = result_index_1;
            result_index_1 = _e62 + 1u;
        }
        loop_init_7 = false;
        uint _e54 = result_index_1;
        if (_e54 >= 22u) {
            break;
        }
        uint _e60 = product_1.inner[_e54 + 0u];
        result_1.inner[_e54] = _e60;
    }
    type_8 _e65 = result_1;
    return _e65;
}

uint naga_div(uint lhs, uint rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

type_7 _naga_trig_divide(
    type_7 value,
    uint divisor
) {
    type_7 source = type_7 {};
    type_7 result_2 = type_7 {};
    uint remainder_3 = uint {};
    uint step = uint {};
    source = value;
    step = 0u;
    uint2 loop_bound_9 = uint2(4294967295u);
    bool loop_init_8 = true;
    while(true) {
        if (metal::all(loop_bound_9 == uint2(0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_8) {
            uint _e25 = step;
            step = _e25 + 1u;
        }
        loop_init_8 = false;
        uint _e11 = step;
        if (_e11 >= 12u) {
            break;
        }
        uint _e15 = 11u - _e11;
        uint _e16 = remainder_3;
        uint _e20 = source.inner[_e15];
        uint _e21 = (_e16 << 16u) | _e20;
        result_2.inner[_e15] = naga_div(_e21, divisor);
        remainder_3 = naga_mod(_e21, divisor);
    }
    type_7 _e28 = result_2;
    return _e28;
}

type_7 _naga_trig_combine(
    type_7 left_2,
    type_7 right_2,
    uint subtract
) {
    type_7 left_digits_2 = type_7 {};
    type_7 right_digits_2 = type_7 {};
    type_7 result_3 = type_7 {};
    uint carry_2 = uint {};
    uint digit_index = uint {};
    left_digits_2 = left_2;
    right_digits_2 = right_2;
    bool _e12 = subtract != 0u;
    digit_index = 0u;
    uint2 loop_bound_10 = uint2(4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (metal::all(loop_bound_10 == uint2(0u))) { break; }
        loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e38 = digit_index;
            digit_index = _e38 + 1u;
        }
        loop_init_9 = false;
        uint _e16 = digit_index;
        if (_e16 >= 12u) {
            break;
        }
        uint _e20 = left_digits_2.inner[_e16];
        uint _e22 = right_digits_2.inner[_e16];
        uint _e23 = carry_2;
        uint _e24 = _e22 + _e23;
        uint _e26 = _e20 + _e24;
        result_3.inner[_e16] = (_e12 ? (_e20 - _e24) : _e26) & 65535u;
        carry_2 = _e12 ? ((_e20 < _e24) ? 1u : 0u) : (_e26 >> 16u);
    }
    type_7 _e41 = result_3;
    return _e41;
}

uint _naga_trig_extract_product(
    type_8 digits,
    uint offset
) {
    type_8 source_1 = type_8 {};
    uint low = uint {};
    uint high = uint {};
    source_1 = digits;
    uint _e5 = naga_div(offset, 16u);
    uint _e7 = naga_mod(offset, 16u);
    uint _e13 = _e5 + 0u;
    if (_e13 < 22u) {
        uint _e17 = source_1.inner[_e13];
        low = _e17;
    }
    uint _e19 = _e5 + 1u;
    if (_e19 < 22u) {
        uint _e23 = source_1.inner[_e19];
        high = _e23;
    }
    uint _e24 = low;
    uint _e25 = high;
    return ((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u;
}

uint _naga_trig_extract_fixed(
    type_7 digits_1,
    uint offset_1
) {
    type_7 source_2 = type_7 {};
    uint low_1 = uint {};
    uint high_1 = uint {};
    source_2 = digits_1;
    uint _e5 = naga_div(offset_1, 16u);
    uint _e7 = naga_mod(offset_1, 16u);
    uint _e13 = _e5 + 0u;
    if (_e13 < 12u) {
        uint _e17 = source_2.inner[_e13];
        low_1 = _e17;
    }
    uint _e19 = _e5 + 1u;
    if (_e19 < 12u) {
        uint _e23 = source_2.inner[_e19];
        high_1 = _e23;
    }
    uint _e24 = low_1;
    uint _e25 = high_1;
    return ((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u;
}

type_7 _naga_trig_kernel(
    type_7 angle,
    uint sine
) {
    type_7 term = type_7 {};
    type_7 total = type_7 {};
    uint step_1 = uint {};
    bool _e7 = sine != 0u;
    if (_e7) {
        term = angle;
    } else {
        term = type_7 {{0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u}};
    }
    type_7 _e21 = term;
    total = _e21;
    type_7 _e22 = _naga_trig_multiply(angle, angle);
    step_1 = 0u;
    uint2 loop_bound_11 = uint2(4294967295u);
    bool loop_init_10 = true;
    while(true) {
        if (metal::all(loop_bound_11 == uint2(0u))) { break; }
        loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
        if (!loop_init_10) {
            uint _e46 = step_1;
            step_1 = _e46 + 1u;
        }
        loop_init_10 = false;
        uint _e26 = step_1;
        if (_e26 >= 8u) {
            break;
        }
        uint _e30 = _e26 + 1u;
        uint _e32 = _e30 * 2u;
        type_7 _e39 = term;
        type_7 _e40 = _naga_trig_multiply(_e39, _e22);
        type_7 _e41 = _naga_trig_divide(_e40, _e32 * (_e7 ? (_e32 + 1u) : (_e32 - 1u)));
        term = _e41;
        type_7 _e42 = total;
        type_7 _e45 = _naga_trig_combine(_e42, _e41, _e30 & 1u);
        total = _e45;
    }
    type_7 _e49 = total;
    return _e49;
}

uint _naga_trig_round(
    type_7 digits_2
) {
    type_7 source_3 = type_7 {};
    uint highest_bit = uint {};
    uint nonzero = uint {};
    uint digit_index_1 = uint {};
    uint sticky = uint {};
    uint sticky_index = uint {};
    source_3 = digits_2;
    digit_index_1 = 0u;
    uint2 loop_bound_12 = uint2(4294967295u);
    bool loop_init_11 = true;
    while(true) {
        if (metal::all(loop_bound_12 == uint2(0u))) { break; }
        loop_bound_12 -= uint2(loop_bound_12.y == 0u, 1u);
        if (!loop_init_11) {
            uint _e25 = digit_index_1;
            digit_index_1 = _e25 + 1u;
        }
        loop_init_11 = false;
        uint _e10 = digit_index_1;
        if (_e10 >= 12u) {
            break;
        }
        uint _e14 = source_3.inner[_e10];
        uint _e15 = nonzero;
        nonzero = _e15 | _e14;
        if (_e14 != 0u) {
            highest_bit = (_e10 * 16u) + (31u - metal::clz(_e14));
        }
    }
    uint _e28 = nonzero;
    if (_e28 == 0u) {
        return 0u;
    }
    uint _e32 = highest_bit;
    uint _e38 = (_e32 >= 50u) ? (_e32 - 23u) : 27u;
    uint _e39 = _naga_trig_extract_fixed(digits_2, _e38);
    uint _e42 = _naga_trig_extract_fixed(digits_2, _e38 + 16u);
    uint _e45 = _e39 | (_e42 << 16u);
    uint _e47 = _e38 - 1u;
    uint _e48 = _naga_trig_extract_fixed(digits_2, _e47);
    uint _e54 = naga_div(_e47, 16u);
    sticky_index = 0u;
    uint2 loop_bound_13 = uint2(4294967295u);
    bool loop_init_12 = true;
    while(true) {
        if (metal::all(loop_bound_13 == uint2(0u))) { break; }
        loop_bound_13 -= uint2(loop_bound_13.y == 0u, 1u);
        if (!loop_init_12) {
            uint _e80 = sticky_index;
            sticky_index = _e80 + 1u;
        }
        loop_init_12 = false;
        uint _e66 = sticky_index;
        if (_e66 >= 12u) {
            break;
        }
        uint _e76 = source_3.inner[_e66];
        uint _e78 = sticky;
        sticky = _e78 | (_e76 & ((_e66 < _e54) ? 65535u : ((_e66 == _e54) ? ((1u << naga_mod(_e47, 16u)) - 1u) : 0u)));
    }
    uint _e83 = sticky;
    uint _e93 = _e45 + ((((_e48 & 1u) != 0u) && ((_e83 | (_e45 & 1u)) != 0u)) ? 1u : 0u);
    if (_e32 < 50u) {
        return _e93;
    }
    bool _e97 = _e93 == 16777216u;
    uint _e102 = _e32 - 49u;
    return ((_e97 ? (_e102 + 1u) : _e102) << 23u) | ((_e97 ? (_e93 >> 1u) : _e93) & 8388607u);
}

uint _naga_trigonometry(
    uint input_bits_5,
    uint cosine
) {
    uint quadrant = uint {};
    type_7 fraction = type_7 {};
    uint fraction_index = uint {};
    uint _e3 = input_bits_5 & 2147483647u;
    if (_e3 >= 2139095040u) {
        return 2143289344u;
    }
    bool _e8 = cosine != 0u;
    if (_e3 <= 956301312u) {
        return _e8 ? 1065353216u : input_bits_5;
    }
    uint _e16 = 470u - (_e3 >> 23u);
    uint _e20 = (_e3 & 8388607u) | 8388608u;
    type_8 _e47 = _naga_trig_reduce_multiply(type_10 {{_e20 & 65535u, _e20 >> 16u}}, type_11 {{53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u}});
    uint _e50 = _naga_trig_extract_product(_e47, _e16);
    quadrant = _e50 & 3u;
    fraction_index = 0u;
    uint2 loop_bound_14 = uint2(4294967295u);
    bool loop_init_13 = true;
    while(true) {
        if (metal::all(loop_bound_14 == uint2(0u))) { break; }
        loop_bound_14 -= uint2(loop_bound_14.y == 0u, 1u);
        if (!loop_init_13) {
            uint _e68 = fraction_index;
            fraction_index = _e68 + 1u;
        }
        loop_init_13 = false;
        uint _e60 = fraction_index;
        if (_e60 >= 11u) {
            break;
        }
        uint _e66 = _naga_trig_extract_product(_e47, (_e16 - 176u) + (_e60 * 16u));
        fraction.inner[_e60] = _e66;
    }
    uint _e73 = fraction.inner[10u];
    bool _e75 = _e73 >= 32768u;
    if (_e75) {
        uint _e89 = quadrant;
        quadrant = (_e89 + 1u) & 3u;
        type_7 _e94 = fraction;
        type_7 _e96 = _naga_trig_combine(type_7 {{0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u}}, _e94, 1u);
        fraction = _e96;
    }
    type_7 _e97 = fraction;
    type_7 _e111 = _naga_trig_multiply(_e97, type_7 {{5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u}});
    uint _e112 = quadrant;
    bool _e115 = (_e112 & 1u) == cosine;
    type_7 _e119 = _naga_trig_kernel(_e111, _e115 ? 1u : 0u);
    uint _e120 = _naga_trig_round(_e119);
    return _e120 | ((((_e75 && _e115) ? 2147483648u : 0u) ^ (((_e8 ? (_e112 + 1u) : _e112) & 2u) << 30u)) ^ (_e8 ? 0u : (input_bits_5 & 2147483648u)));
}

struct uniform_math_barriersInput {
};
kernel void uniform_math_barriers(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, constant type_2& value_1 [[buffer(0)]]
, device type_3& output [[buffer(1)]]
, threadgroup type_4& shared_values
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    if (__local_invocation_index == 0u) {
        shared_values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint flags = {};
    uint local = {};
    uint local_1 = {};
    float value_2 = value_1.value;
    uint lane = threadIdx.x;
    shared_values.inner[lane] = lane + 1u;
    flags = 1u;
    flags = 0u;
    uint _e13 = _naga_floorf(as_type<uint>(value_2));
    if (as_type<float>(_e13) > 0.0) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e17 = flags;
        flags = _e17 | 1u;
    }
    uint _e21 = _naga_ceilf(as_type<uint>(value_2));
    if (as_type<float>(_e21) > 0.0) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e25 = flags;
        flags = _e25 | 2u;
    }
    uint _e29 = _naga_roundf(as_type<uint>(value_2));
    if (as_type<float>(_e29) > 0.0) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e33 = flags;
        flags = _e33 | 4u;
    }
    uint _e37 = _naga_fabsf(as_type<uint>(value_2));
    if (as_type<float>(_e37) > 0.0) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e41 = flags;
        flags = _e41 | 8u;
    }
    uint _e45 = _naga_sqrtf(as_type<uint>(value_2));
    if (as_type<float>(_e45) > 0.0) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e49 = flags;
        flags = _e49 | 16u;
    }
    uint _e53 = _naga_sqrtf(as_type<uint>(value_2));
    uint _e58 = _naga_divide_f32_(as_type<uint>(1.0), as_type<uint>(as_type<float>(_e53)));
    if (as_type<float>(_e58) > 0.0) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e62 = flags;
        flags = _e62 | 32u;
    }
    uint _e68 = _naga_fmodf(as_type<uint>(value_2), as_type<uint>(2.0));
    if (as_type<float>(_e68) > 0.0) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e72 = flags;
        flags = _e72 | 64u;
    }
    uint _e78 = _naga_divide_f32_(as_type<uint>(value_2), as_type<uint>(2.0));
    if (as_type<float>(_e78) > 0.0) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e82 = flags;
        flags = _e82 | 128u;
    }
    uint _e87 = _naga_trigonometry(as_type<uint>(value_2), 0u);
    if (as_type<float>(_e87) > 0.0) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e91 = flags;
        flags = _e91 | 256u;
    }
    uint _e96 = _naga_trigonometry(as_type<uint>(value_2), 1u);
    if (as_type<float>(_e96) > 0.0) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e100 = flags;
        flags = _e100 | 512u;
    }
    uint _e108 = shared_values.inner[(lane + 1u) & 3u];
    local = static_cast<uint>(4u + (lane * 2u));
    uint _e115 = local;
    output[_e115] = _e108;
    uint _e118 = flags;
    local_1 = static_cast<uint>(5u + (lane * 2u));
    uint _e125 = local_1;
    output[_e125] = _e118;
}
