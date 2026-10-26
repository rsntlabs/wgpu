// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_1 {
    int inner[2];
};
struct Packet_cuda_record_0_ {
    int key;
    type_1 values;
};
typedef uint type_4[1];
struct type_5 {
    uint inner[12];
};
struct type_6 {
    uint inner[22];
};
struct type_7 {
    uint inner[24];
};
struct type_8 {
    uint inner[2];
};
struct type_9 {
    uint inner[20];
};

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int route(
    float value
) {
    float value_1 = {};
    value_1 = value;
    float _e3 = value_1;
    return as_type<int>(as_type<uint>(10) + as_type<uint>(naga_f2i32(_e3)));
}

int earlier(
    int value_2
) {
    int value_3 = {};
    value_3 = value_2;
    int _e2 = value_3;
    int _e4 = route(static_cast<float>(_e2));
    return _e4;
}

int route_1(
    int value_4
) {
    int value_5 = {};
    value_5 = value_4;
    int _e3 = value_5;
    return as_type<int>(as_type<uint>(20) + as_type<uint>(_e3));
}

int forward(
    int value_6
) {
    int value_7 = {};
    value_7 = value_6;
    int _e2 = value_7;
    int _e3 = route_1(_e2);
    int _e4 = value_7;
    int _e5 = earlier(_e4);
    return as_type<int>(as_type<uint>(_e3) + as_type<uint>(_e5));
}

Packet_cuda_record_0_ packet(
    int value_8
) {
    int value_9 = {};
    Packet_cuda_record_0_ local_65 = {};
    value_9 = value_8;
    int _e3 = value_9;
    local_65.key = _e3;
    int _e7 = value_9;
    local_65.values.inner[0] = as_type<int>(as_type<uint>(_e7) + as_type<uint>(1));
    int _e12 = value_9;
    local_65.values.inner[1] = as_type<int>(as_type<uint>(_e12) + as_type<uint>(2));
    Packet_cuda_record_0_ _e14 = local_65;
    return _e14;
}

Packet_cuda_record_0_ adjust(
    Packet_cuda_record_0_ value_10
) {
    Packet_cuda_record_0_ value_11 = {};
    value_11 = value_10;
    int _e4 = value_11.key;
    value_11.key = as_type<int>(as_type<uint>(_e4) + as_type<uint>(4));
    int _e10 = value_11.values.inner[1];
    value_11.values.inner[1] = as_type<int>(as_type<uint>(_e10) + as_type<uint>(6));
    Packet_cuda_record_0_ _e12 = value_11;
    return _e12;
}

Packet_cuda_record_0_ operator_u002b(
    Packet_cuda_record_0_ left,
    Packet_cuda_record_0_ right
) {
    Packet_cuda_record_0_ left_1 = {};
    Packet_cuda_record_0_ right_1 = {};
    Packet_cuda_record_0_ local_66 = {};
    left_1 = left;
    right_1 = right;
    int _e7 = left_1.key;
    int _e8 = right_1.key;
    local_66.key = as_type<int>(as_type<uint>(_e7) + as_type<uint>(_e8));
    int _e18 = left_1.values.inner[0];
    int _e19 = right_1.values.inner[0];
    local_66.values.inner[0] = as_type<int>(as_type<uint>(_e18) + as_type<uint>(_e19));
    int _e29 = left_1.values.inner[1];
    int _e30 = right_1.values.inner[1];
    local_66.values.inner[1] = as_type<int>(as_type<uint>(_e29) + as_type<uint>(_e30));
    Packet_cuda_record_0_ _e32 = local_66;
    return _e32;
}

int pair(
    int first_1,
    int second_1
) {
    int first_2 = {};
    int second_2 = {};
    first_2 = first_1;
    second_2 = second_1;
    int _e5 = first_2;
    int _e7 = second_2;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e5) * as_type<uint>(10))) + as_type<uint>(_e7));
}

void consume(
    int value_12
) {
    int value_13 = {};
    value_13 = value_12;
    int _e2 = value_13;
    if (_e2 != 0) {
        return;
    } else {
        return;
    }
}

uint _naga_sqrtf(
    uint input_bits
) {
    uint significand = {};
    uint adjusted_exponent = {};
    uint upper_word = {};
    uint lower_word = {};
    uint root = {};
    uint remainder = {};
    uint iteration = {};
    uint _e5 = input_bits & 2147483647u;
    if ((_e5 == 0u) || (input_bits == 2139095040u)) {
        return input_bits;
    }
    if (((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u)) {
        return 2143289344u;
    }
    uint _e19 = input_bits & 8388607u;
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

type_6 _naga_trig_reduce_multiply(
    type_8 left_2,
    type_9 right_2
) {
    type_8 left_digits = type_8 {};
    type_9 right_digits = type_9 {};
    type_6 product = type_6 {};
    uint carry = uint {};
    uint left_index = uint {};
    uint right_index = uint {};
    type_6 result = type_6 {};
    uint result_index = uint {};
    left_digits = left_2;
    right_digits = right_2;
    left_index = 0u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e46 = left_index;
            left_index = _e46 + 1u;
        }
        loop_init_1 = false;
        uint _e13 = left_index;
        if (_e13 >= 2u) {
            break;
        }
        carry = 0u;
        uint _e18 = left_digits.inner[_e13];
        right_index = 0u;
        uint2 loop_bound_2 = uint2(4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (metal::all(loop_bound_2 == uint2(0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                uint _e39 = right_index;
                right_index = _e39 + 1u;
            }
            loop_init_2 = false;
            uint _e22 = right_index;
            if (_e22 >= 20u) {
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
        product.inner[_e13 + 20u] = _e44;
    }
    result_index = 0u;
    uint2 loop_bound_3 = uint2(4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (metal::all(loop_bound_3 == uint2(0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e62 = result_index;
            result_index = _e62 + 1u;
        }
        loop_init_3 = false;
        uint _e54 = result_index;
        if (_e54 >= 22u) {
            break;
        }
        uint _e60 = product.inner[_e54 + 0u];
        result.inner[_e54] = _e60;
    }
    type_6 _e65 = result;
    return _e65;
}

uint naga_div(uint lhs, uint rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

uint _naga_trig_extract_product(
    type_6 digits,
    uint offset
) {
    type_6 source = type_6 {};
    uint low = uint {};
    uint high = uint {};
    source = digits;
    uint _e5 = naga_div(offset, 16u);
    uint _e7 = naga_mod(offset, 16u);
    uint _e13 = _e5 + 0u;
    if (_e13 < 22u) {
        uint _e17 = source.inner[_e13];
        low = _e17;
    }
    uint _e19 = _e5 + 1u;
    if (_e19 < 22u) {
        uint _e23 = source.inner[_e19];
        high = _e23;
    }
    uint _e24 = low;
    uint _e25 = high;
    return ((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u;
}

type_5 _naga_trig_multiply(
    type_5 left_3,
    type_5 right_3
) {
    type_5 left_digits_1 = type_5 {};
    type_5 right_digits_1 = type_5 {};
    type_7 product_1 = type_7 {};
    uint carry_1 = uint {};
    uint left_index_1 = uint {};
    uint right_index_1 = uint {};
    type_5 result_1 = type_5 {};
    uint result_index_1 = uint {};
    left_digits_1 = left_3;
    right_digits_1 = right_3;
    left_index_1 = 0u;
    uint2 loop_bound_4 = uint2(4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (metal::all(loop_bound_4 == uint2(0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e46 = left_index_1;
            left_index_1 = _e46 + 1u;
        }
        loop_init_4 = false;
        uint _e13 = left_index_1;
        if (_e13 >= 12u) {
            break;
        }
        carry_1 = 0u;
        uint _e18 = left_digits_1.inner[_e13];
        right_index_1 = 0u;
        uint2 loop_bound_5 = uint2(4294967295u);
        bool loop_init_5 = true;
        while(true) {
            if (metal::all(loop_bound_5 == uint2(0u))) { break; }
            loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
            if (!loop_init_5) {
                uint _e39 = right_index_1;
                right_index_1 = _e39 + 1u;
            }
            loop_init_5 = false;
            uint _e22 = right_index_1;
            if (_e22 >= 12u) {
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
        product_1.inner[_e13 + 12u] = _e44;
    }
    result_index_1 = 0u;
    uint2 loop_bound_6 = uint2(4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (metal::all(loop_bound_6 == uint2(0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e62 = result_index_1;
            result_index_1 = _e62 + 1u;
        }
        loop_init_6 = false;
        uint _e54 = result_index_1;
        if (_e54 >= 12u) {
            break;
        }
        uint _e60 = product_1.inner[_e54 + 11u];
        result_1.inner[_e54] = _e60;
    }
    type_5 _e65 = result_1;
    return _e65;
}

type_5 _naga_trig_divide(
    type_5 value_14,
    uint divisor
) {
    type_5 source_1 = type_5 {};
    type_5 result_2 = type_5 {};
    uint remainder_1 = uint {};
    uint step = uint {};
    source_1 = value_14;
    step = 0u;
    uint2 loop_bound_7 = uint2(4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (metal::all(loop_bound_7 == uint2(0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e25 = step;
            step = _e25 + 1u;
        }
        loop_init_7 = false;
        uint _e11 = step;
        if (_e11 >= 12u) {
            break;
        }
        uint _e15 = 11u - _e11;
        uint _e16 = remainder_1;
        uint _e20 = source_1.inner[_e15];
        uint _e21 = (_e16 << 16u) | _e20;
        result_2.inner[_e15] = naga_div(_e21, divisor);
        remainder_1 = naga_mod(_e21, divisor);
    }
    type_5 _e28 = result_2;
    return _e28;
}

type_5 _naga_trig_combine(
    type_5 left_4,
    type_5 right_4,
    uint subtract
) {
    type_5 left_digits_2 = type_5 {};
    type_5 right_digits_2 = type_5 {};
    type_5 result_3 = type_5 {};
    uint carry_2 = uint {};
    uint digit_index = uint {};
    left_digits_2 = left_4;
    right_digits_2 = right_4;
    bool _e12 = subtract != 0u;
    digit_index = 0u;
    uint2 loop_bound_8 = uint2(4294967295u);
    bool loop_init_8 = true;
    while(true) {
        if (metal::all(loop_bound_8 == uint2(0u))) { break; }
        loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
        if (!loop_init_8) {
            uint _e38 = digit_index;
            digit_index = _e38 + 1u;
        }
        loop_init_8 = false;
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
    type_5 _e41 = result_3;
    return _e41;
}

type_5 _naga_trig_kernel(
    type_5 angle,
    uint sine
) {
    type_5 term = type_5 {};
    type_5 total_1 = type_5 {};
    uint step_1 = uint {};
    bool _e7 = sine != 0u;
    if (_e7) {
        term = angle;
    } else {
        term = type_5 {{0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u}};
    }
    type_5 _e21 = term;
    total_1 = _e21;
    type_5 _e22 = _naga_trig_multiply(angle, angle);
    step_1 = 0u;
    uint2 loop_bound_9 = uint2(4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (metal::all(loop_bound_9 == uint2(0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e46 = step_1;
            step_1 = _e46 + 1u;
        }
        loop_init_9 = false;
        uint _e26 = step_1;
        if (_e26 >= 8u) {
            break;
        }
        uint _e30 = _e26 + 1u;
        uint _e32 = _e30 * 2u;
        type_5 _e39 = term;
        type_5 _e40 = _naga_trig_multiply(_e39, _e22);
        type_5 _e41 = _naga_trig_divide(_e40, _e32 * (_e7 ? (_e32 + 1u) : (_e32 - 1u)));
        term = _e41;
        type_5 _e42 = total_1;
        type_5 _e45 = _naga_trig_combine(_e42, _e41, _e30 & 1u);
        total_1 = _e45;
    }
    type_5 _e49 = total_1;
    return _e49;
}

uint _naga_trig_extract_fixed(
    type_5 digits_1,
    uint offset_1
) {
    type_5 source_2 = type_5 {};
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

uint _naga_trig_round(
    type_5 digits_2
) {
    type_5 source_3 = type_5 {};
    uint highest_bit = uint {};
    uint nonzero = uint {};
    uint digit_index_1 = uint {};
    uint sticky = uint {};
    uint sticky_index = uint {};
    source_3 = digits_2;
    digit_index_1 = 0u;
    uint2 loop_bound_10 = uint2(4294967295u);
    bool loop_init_10 = true;
    while(true) {
        if (metal::all(loop_bound_10 == uint2(0u))) { break; }
        loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
        if (!loop_init_10) {
            uint _e25 = digit_index_1;
            digit_index_1 = _e25 + 1u;
        }
        loop_init_10 = false;
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
    uint2 loop_bound_11 = uint2(4294967295u);
    bool loop_init_11 = true;
    while(true) {
        if (metal::all(loop_bound_11 == uint2(0u))) { break; }
        loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
        if (!loop_init_11) {
            uint _e80 = sticky_index;
            sticky_index = _e80 + 1u;
        }
        loop_init_11 = false;
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
    uint input_bits_1,
    uint cosine
) {
    uint quadrant = uint {};
    type_5 fraction = type_5 {};
    uint fraction_index = uint {};
    uint _e3 = input_bits_1 & 2147483647u;
    if (_e3 >= 2139095040u) {
        return 2143289344u;
    }
    bool _e8 = cosine != 0u;
    if (_e3 <= 956301312u) {
        return _e8 ? 1065353216u : input_bits_1;
    }
    uint _e16 = 470u - (_e3 >> 23u);
    uint _e20 = (_e3 & 8388607u) | 8388608u;
    type_6 _e47 = _naga_trig_reduce_multiply(type_8 {{_e20 & 65535u, _e20 >> 16u}}, type_9 {{53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u}});
    uint _e50 = _naga_trig_extract_product(_e47, _e16);
    quadrant = _e50 & 3u;
    fraction_index = 0u;
    uint2 loop_bound_12 = uint2(4294967295u);
    bool loop_init_12 = true;
    while(true) {
        if (metal::all(loop_bound_12 == uint2(0u))) { break; }
        loop_bound_12 -= uint2(loop_bound_12.y == 0u, 1u);
        if (!loop_init_12) {
            uint _e68 = fraction_index;
            fraction_index = _e68 + 1u;
        }
        loop_init_12 = false;
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
        type_5 _e94 = fraction;
        type_5 _e96 = _naga_trig_combine(type_5 {{0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u}}, _e94, 1u);
        fraction = _e96;
    }
    type_5 _e97 = fraction;
    type_5 _e111 = _naga_trig_multiply(_e97, type_5 {{5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u}});
    uint _e112 = quadrant;
    bool _e115 = (_e112 & 1u) == cosine;
    type_5 _e119 = _naga_trig_kernel(_e111, _e115 ? 1u : 0u);
    uint _e120 = _naga_trig_round(_e119);
    return _e120 | ((((_e75 && _e115) ? 2147483648u : 0u) ^ (((_e8 ? (_e112 + 1u) : _e112) & 2u) << 30u)) ^ (_e8 ? 0u : (input_bits_1 & 2147483648u)));
}

float generated(
    float value_15
) {
    float value_16 = {};
    value_16 = value_15;
    uint _e4 = _naga_sqrtf(as_type<uint>(4.0));
    float _e6 = value_16;
    uint _e9 = _naga_trigonometry(as_type<uint>(_e6), 0u);
    float _e12 = value_16;
    uint _e15 = _naga_trigonometry(as_type<uint>(_e12), 1u);
    return (as_type<float>(_e4) + as_type<float>(_e9)) + as_type<float>(_e15);
}

int control(
    int count
) {
    int count_1 = {};
    int result_4 = {};
    int index = {};
    count_1 = count;
    result_4 = 0;
    {
        index = 0;
        uint2 loop_bound_13 = uint2(4294967295u);
        bool loop_init_13 = true;
        while(true) {
            if (metal::all(loop_bound_13 == uint2(0u))) { break; }
            loop_bound_13 -= uint2(loop_bound_13.y == 0u, 1u);
            if (!loop_init_13) {
                int _e9 = index;
                index = as_type<int>(as_type<uint>(_e9) + as_type<uint>(1));
            }
            loop_init_13 = false;
            int _e6 = index;
            int _e7 = count_1;
            if (_e6 < _e7) {
            } else {
                break;
            }
            int _e13 = index;
            if (_e13 == 1) {
                continue;
            }
            int _e15 = index;
            switch(_e15) {
                case 0: {
                    int _e16 = index;
                    int _e17 = route_1(_e16);
                    int _e18 = result_4;
                    result_4 = as_type<int>(as_type<uint>(_e18) + as_type<uint>(_e17));
                    break;
                }
                default: {
                    int _e20 = index;
                    int _e21 = forward(_e20);
                    int _e22 = index;
                    int _e23 = earlier(_e22);
                    int _e25 = result_4;
                    result_4 = as_type<int>(as_type<uint>(_e25) + as_type<uint>(as_type<int>(as_type<uint>(_e21) - as_type<uint>(_e23))));
                    break;
                }
            }
        }
    }
    int _e27 = result_4;
    return _e27;
}

uint late_index(
    thread metal::uint3& blockIdx_1,
    thread metal::uint3& threadIdx_1
) {
    metal::uint3 _e1 = blockIdx_1;
    metal::uint3 _e6 = threadIdx_1;
    return (_e1.x * 2u) + _e6.x;
}

struct prototypesInput {
};
kernel void prototypes(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_4& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::uint3 blockIdx_1 = {};
    metal::uint3 threadIdx_1 = {};
    uint local = {};
    uint lane = {};
    uint base = {};
    int counter = {};
    Packet_cuda_record_0_ first = {};
    Packet_cuda_record_0_ second = {};
    Packet_cuda_record_0_ total = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    int first_argument = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    local = 0u;
    uint _e6 = late_index(blockIdx_1, threadIdx_1);
    lane = _e6;
    uint _e8 = lane;
    base = _e8 * 16u;
    counter = 1;
    int _e14 = counter;
    counter = as_type<int>(as_type<uint>(_e14) + as_type<uint>(1));
    Packet_cuda_record_0_ _e17 = packet(_e14);
    first = _e17;
    Packet_cuda_record_0_ _e19 = first;
    Packet_cuda_record_0_ _e20 = adjust(_e19);
    second = _e20;
    Packet_cuda_record_0_ _e22 = first;
    Packet_cuda_record_0_ _e23 = second;
    Packet_cuda_record_0_ _e24 = operator_u002b(_e22, _e23);
    total = _e24;
    int _e27 = earlier(3);
    uint _e28 = local;
    local_1 = _e28;
    uint _e30 = local_1;
    local_2 = static_cast<uint>(_e30);
    uint _e33 = base;
    local_3 = static_cast<uint>(_e33);
    uint _e38 = local_2;
    uint _e39 = local_3;
    local_49 = static_cast<uint>(_e38 + _e39);
    uint _e43 = local_49;
    out[_e43] = static_cast<uint>(_e27);
    int _e46 = route_1(3);
    uint _e47 = local;
    local_4 = _e47;
    uint _e49 = local_4;
    local_5 = static_cast<uint>(_e49);
    uint _e52 = base;
    local_6 = static_cast<uint>(_e52 + static_cast<uint>(1));
    uint _e59 = local_5;
    uint _e60 = local_6;
    local_50 = static_cast<uint>(_e59 + _e60);
    uint _e64 = local_50;
    out[_e64] = static_cast<uint>(_e46);
    int _e67 = forward(4);
    uint _e68 = local;
    local_7 = _e68;
    uint _e70 = local_7;
    local_8 = static_cast<uint>(_e70);
    uint _e73 = base;
    local_9 = static_cast<uint>(_e73 + static_cast<uint>(2));
    uint _e80 = local_8;
    uint _e81 = local_9;
    local_51 = static_cast<uint>(_e80 + _e81);
    uint _e85 = local_51;
    out[_e85] = static_cast<uint>(_e67);
    int _e88 = first.key;
    uint _e89 = local;
    local_10 = _e89;
    uint _e91 = local_10;
    local_11 = static_cast<uint>(_e91);
    uint _e94 = base;
    local_12 = static_cast<uint>(_e94 + static_cast<uint>(3));
    uint _e101 = local_11;
    uint _e102 = local_12;
    local_52 = static_cast<uint>(_e101 + _e102);
    uint _e106 = local_52;
    out[_e106] = static_cast<uint>(_e88);
    int _e111 = first.values.inner[1];
    uint _e112 = local;
    local_13 = _e112;
    uint _e114 = local_13;
    local_14 = static_cast<uint>(_e114);
    uint _e117 = base;
    local_15 = static_cast<uint>(_e117 + static_cast<uint>(4));
    uint _e124 = local_14;
    uint _e125 = local_15;
    local_53 = static_cast<uint>(_e124 + _e125);
    uint _e129 = local_53;
    out[_e129] = static_cast<uint>(_e111);
    int _e132 = second.key;
    uint _e133 = local;
    local_16 = _e133;
    uint _e135 = local_16;
    local_17 = static_cast<uint>(_e135);
    uint _e138 = base;
    local_18 = static_cast<uint>(_e138 + static_cast<uint>(5));
    uint _e145 = local_17;
    uint _e146 = local_18;
    local_54 = static_cast<uint>(_e145 + _e146);
    uint _e150 = local_54;
    out[_e150] = static_cast<uint>(_e132);
    int _e155 = second.values.inner[1];
    uint _e156 = local;
    local_19 = _e156;
    uint _e158 = local_19;
    local_20 = static_cast<uint>(_e158);
    uint _e161 = base;
    local_21 = static_cast<uint>(_e161 + static_cast<uint>(6));
    uint _e168 = local_20;
    uint _e169 = local_21;
    local_55 = static_cast<uint>(_e168 + _e169);
    uint _e173 = local_55;
    out[_e173] = static_cast<uint>(_e155);
    int _e176 = total.key;
    uint _e177 = local;
    local_22 = _e177;
    uint _e179 = local_22;
    local_23 = static_cast<uint>(_e179);
    uint _e182 = base;
    local_24 = static_cast<uint>(_e182 + static_cast<uint>(7));
    uint _e189 = local_23;
    uint _e190 = local_24;
    local_56 = static_cast<uint>(_e189 + _e190);
    uint _e194 = local_56;
    out[_e194] = static_cast<uint>(_e176);
    int _e199 = total.values.inner[0];
    uint _e200 = local;
    local_25 = _e200;
    uint _e202 = local_25;
    local_26 = static_cast<uint>(_e202);
    uint _e205 = base;
    local_27 = static_cast<uint>(_e205 + static_cast<uint>(8));
    uint _e212 = local_26;
    uint _e213 = local_27;
    local_57 = static_cast<uint>(_e212 + _e213);
    uint _e217 = local_57;
    out[_e217] = static_cast<uint>(_e199);
    int _e222 = total.values.inner[1];
    uint _e223 = local;
    local_28 = _e223;
    uint _e225 = local_28;
    local_29 = static_cast<uint>(_e225);
    uint _e228 = base;
    local_30 = static_cast<uint>(_e228 + static_cast<uint>(9));
    uint _e235 = local_29;
    uint _e236 = local_30;
    local_58 = static_cast<uint>(_e235 + _e236);
    uint _e240 = local_58;
    out[_e240] = static_cast<uint>(_e222);
    int _e242 = counter;
    counter = as_type<int>(as_type<uint>(_e242) + as_type<uint>(1));
    first_argument = _e242;
    int _e246 = first_argument;
    int _e247 = counter;
    counter = as_type<int>(as_type<uint>(_e247) + as_type<uint>(1));
    int _e250 = pair(_e246, _e247);
    uint _e251 = local;
    local_31 = _e251;
    uint _e253 = local_31;
    local_32 = static_cast<uint>(_e253);
    uint _e256 = base;
    local_33 = static_cast<uint>(_e256 + static_cast<uint>(10));
    uint _e263 = local_32;
    uint _e264 = local_33;
    local_59 = static_cast<uint>(_e263 + _e264);
    uint _e268 = local_59;
    out[_e268] = static_cast<uint>(_e250);
    int _e270 = counter;
    counter = as_type<int>(as_type<uint>(_e270) + as_type<uint>(1));
    consume(_e270);
    int _e273 = counter;
    uint _e274 = local;
    local_34 = _e274;
    uint _e276 = local_34;
    local_35 = static_cast<uint>(_e276);
    uint _e279 = base;
    local_36 = static_cast<uint>(_e279 + static_cast<uint>(11));
    uint _e286 = local_35;
    uint _e287 = local_36;
    local_60 = static_cast<uint>(_e286 + _e287);
    uint _e291 = local_60;
    out[_e291] = static_cast<uint>(_e273);
    float _e294 = generated(0.0);
    uint _e296 = local;
    local_37 = _e296;
    uint _e298 = local_37;
    local_38 = static_cast<uint>(_e298);
    uint _e301 = base;
    local_39 = static_cast<uint>(_e301 + static_cast<uint>(12));
    uint _e307 = local_38;
    uint _e308 = local_39;
    local_61 = static_cast<uint>(_e307 + _e308);
    uint _e312 = local_61;
    out[_e312] = as_type<uint>(_e294);
    int _e315 = control(3);
    uint _e316 = local;
    local_40 = _e316;
    uint _e318 = local_40;
    local_41 = static_cast<uint>(_e318);
    uint _e321 = base;
    local_42 = static_cast<uint>(_e321 + static_cast<uint>(13));
    uint _e328 = local_41;
    uint _e329 = local_42;
    local_62 = static_cast<uint>(_e328 + _e329);
    uint _e333 = local_62;
    out[_e333] = static_cast<uint>(_e315);
    uint _e335 = lane;
    uint _e336 = local;
    local_43 = _e336;
    uint _e338 = local_43;
    local_44 = static_cast<uint>(_e338);
    uint _e341 = base;
    local_45 = static_cast<uint>(_e341 + static_cast<uint>(14));
    uint _e347 = local_44;
    uint _e348 = local_45;
    local_63 = static_cast<uint>(_e347 + _e348);
    uint _e352 = local_63;
    out[_e352] = _e335;
    int _e354 = counter;
    counter = as_type<int>(as_type<uint>(_e354) + as_type<uint>(1));
    int _e357 = counter;
    int _e358 = forward(_e357);
    uint _e359 = local;
    local_46 = _e359;
    uint _e361 = local_46;
    local_47 = static_cast<uint>(_e361);
    uint _e364 = base;
    local_48 = static_cast<uint>(_e364 + static_cast<uint>(15));
    uint _e371 = local_47;
    uint _e372 = local_48;
    local_64 = static_cast<uint>(_e371 + _e372);
    uint _e376 = local_64;
    out[_e376] = static_cast<uint>(_e358);
}
