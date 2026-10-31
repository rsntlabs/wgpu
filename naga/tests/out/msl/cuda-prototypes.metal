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
    Packet_cuda_record_0_ local_80 = {};
    value_9 = value_8;
    int _e3 = value_9;
    local_80.key = _e3;
    int _e7 = value_9;
    local_80.values.inner[0] = as_type<int>(as_type<uint>(_e7) + as_type<uint>(1));
    int _e12 = value_9;
    local_80.values.inner[1] = as_type<int>(as_type<uint>(_e12) + as_type<uint>(2));
    Packet_cuda_record_0_ _e14 = local_80;
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
    Packet_cuda_record_0_ local_81 = {};
    left_1 = left;
    right_1 = right;
    int _e7 = left_1.key;
    int _e8 = right_1.key;
    local_81.key = as_type<int>(as_type<uint>(_e7) + as_type<uint>(_e8));
    int _e18 = left_1.values.inner[0];
    int _e19 = right_1.values.inner[0];
    local_81.values.inner[0] = as_type<int>(as_type<uint>(_e18) + as_type<uint>(_e19));
    int _e29 = left_1.values.inner[1];
    int _e30 = right_1.values.inner[1];
    local_81.values.inner[1] = as_type<int>(as_type<uint>(_e29) + as_type<uint>(_e30));
    Packet_cuda_record_0_ _e32 = local_81;
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
, device type_4& out_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::uint3 blockIdx_1 = {};
    metal::uint3 threadIdx_1 = {};
    type_8 out = {};
    uint lane = {};
    uint base = {};
    int counter = {};
    Packet_cuda_record_0_ first = {};
    Packet_cuda_record_0_ second = {};
    Packet_cuda_record_0_ total = {};
    type_8 local = {};
    uint local_1 = {};
    type_8 local_2 = {};
    uint local_3 = {};
    type_8 local_4 = {};
    uint local_5 = {};
    type_8 local_6 = {};
    uint local_7 = {};
    type_8 local_8 = {};
    uint local_9 = {};
    type_8 local_10 = {};
    uint local_11 = {};
    type_8 local_12 = {};
    uint local_13 = {};
    type_8 local_14 = {};
    uint local_15 = {};
    type_8 local_16 = {};
    uint local_17 = {};
    type_8 local_18 = {};
    uint local_19 = {};
    int first_argument = {};
    type_8 local_20 = {};
    uint local_21 = {};
    type_8 local_22 = {};
    uint local_23 = {};
    type_8 local_24 = {};
    uint local_25 = {};
    type_8 local_26 = {};
    uint local_27 = {};
    type_8 local_28 = {};
    uint local_29 = {};
    type_8 local_30 = {};
    uint local_31 = {};
    type_8 local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    type_8 local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    type_8 local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    type_8 local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    type_8 local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    type_8 local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    type_8 local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    type_8 local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    type_8 local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    type_8 local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    type_8 local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    type_8 local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    type_8 local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    type_8 local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    type_8 local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    type_8 local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    out = type_8 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    uint _e11 = late_index(blockIdx_1, threadIdx_1);
    lane = _e11;
    uint _e13 = lane;
    base = _e13 * 16u;
    counter = 1;
    int _e19 = counter;
    counter = as_type<int>(as_type<uint>(_e19) + as_type<uint>(1));
    Packet_cuda_record_0_ _e22 = packet(_e19);
    first = _e22;
    Packet_cuda_record_0_ _e24 = first;
    Packet_cuda_record_0_ _e25 = adjust(_e24);
    second = _e25;
    Packet_cuda_record_0_ _e27 = first;
    Packet_cuda_record_0_ _e28 = second;
    Packet_cuda_record_0_ _e29 = operator_u002b(_e27, _e28);
    total = _e29;
    int _e32 = earlier(3);
    type_8 _e35 = out;
    local = _e35;
    uint _e36 = base;
    local_1 = static_cast<uint>(_e36);
    type_8 _e41 = local;
    local_32 = _e41;
    uint _e42 = local_1;
    uint _e44 = local_32.inner[1];
    local_32.inner[1] = _e44 + _e42;
    uint _e48 = local_32.inner[0];
    local_33 = static_cast<uint>(_e48);
    uint _e52 = local_32.inner[1];
    local_34 = static_cast<uint>(_e52);
    uint _e55 = local_34;
    out_1[_e55] = static_cast<uint>(_e32);
    int _e58 = route_1(3);
    type_8 _e60 = out;
    local_2 = _e60;
    uint _e61 = base;
    local_3 = static_cast<uint>(_e61 + static_cast<uint>(1));
    type_8 _e69 = local_2;
    local_35 = _e69;
    uint _e70 = local_3;
    uint _e72 = local_35.inner[1];
    local_35.inner[1] = _e72 + _e70;
    uint _e76 = local_35.inner[0];
    local_36 = static_cast<uint>(_e76);
    uint _e80 = local_35.inner[1];
    local_37 = static_cast<uint>(_e80);
    uint _e83 = local_37;
    out_1[_e83] = static_cast<uint>(_e58);
    int _e86 = forward(4);
    type_8 _e88 = out;
    local_4 = _e88;
    uint _e89 = base;
    local_5 = static_cast<uint>(_e89 + static_cast<uint>(2));
    type_8 _e97 = local_4;
    local_38 = _e97;
    uint _e98 = local_5;
    uint _e100 = local_38.inner[1];
    local_38.inner[1] = _e100 + _e98;
    uint _e104 = local_38.inner[0];
    local_39 = static_cast<uint>(_e104);
    uint _e108 = local_38.inner[1];
    local_40 = static_cast<uint>(_e108);
    uint _e111 = local_40;
    out_1[_e111] = static_cast<uint>(_e86);
    int _e114 = first.key;
    type_8 _e116 = out;
    local_6 = _e116;
    uint _e117 = base;
    local_7 = static_cast<uint>(_e117 + static_cast<uint>(3));
    type_8 _e125 = local_6;
    local_41 = _e125;
    uint _e126 = local_7;
    uint _e128 = local_41.inner[1];
    local_41.inner[1] = _e128 + _e126;
    uint _e132 = local_41.inner[0];
    local_42 = static_cast<uint>(_e132);
    uint _e136 = local_41.inner[1];
    local_43 = static_cast<uint>(_e136);
    uint _e139 = local_43;
    out_1[_e139] = static_cast<uint>(_e114);
    int _e144 = first.values.inner[1];
    type_8 _e146 = out;
    local_8 = _e146;
    uint _e147 = base;
    local_9 = static_cast<uint>(_e147 + static_cast<uint>(4));
    type_8 _e155 = local_8;
    local_44 = _e155;
    uint _e156 = local_9;
    uint _e158 = local_44.inner[1];
    local_44.inner[1] = _e158 + _e156;
    uint _e162 = local_44.inner[0];
    local_45 = static_cast<uint>(_e162);
    uint _e166 = local_44.inner[1];
    local_46 = static_cast<uint>(_e166);
    uint _e169 = local_46;
    out_1[_e169] = static_cast<uint>(_e144);
    int _e172 = second.key;
    type_8 _e174 = out;
    local_10 = _e174;
    uint _e175 = base;
    local_11 = static_cast<uint>(_e175 + static_cast<uint>(5));
    type_8 _e183 = local_10;
    local_47 = _e183;
    uint _e184 = local_11;
    uint _e186 = local_47.inner[1];
    local_47.inner[1] = _e186 + _e184;
    uint _e190 = local_47.inner[0];
    local_48 = static_cast<uint>(_e190);
    uint _e194 = local_47.inner[1];
    local_49 = static_cast<uint>(_e194);
    uint _e197 = local_49;
    out_1[_e197] = static_cast<uint>(_e172);
    int _e202 = second.values.inner[1];
    type_8 _e204 = out;
    local_12 = _e204;
    uint _e205 = base;
    local_13 = static_cast<uint>(_e205 + static_cast<uint>(6));
    type_8 _e213 = local_12;
    local_50 = _e213;
    uint _e214 = local_13;
    uint _e216 = local_50.inner[1];
    local_50.inner[1] = _e216 + _e214;
    uint _e220 = local_50.inner[0];
    local_51 = static_cast<uint>(_e220);
    uint _e224 = local_50.inner[1];
    local_52 = static_cast<uint>(_e224);
    uint _e227 = local_52;
    out_1[_e227] = static_cast<uint>(_e202);
    int _e230 = total.key;
    type_8 _e232 = out;
    local_14 = _e232;
    uint _e233 = base;
    local_15 = static_cast<uint>(_e233 + static_cast<uint>(7));
    type_8 _e241 = local_14;
    local_53 = _e241;
    uint _e242 = local_15;
    uint _e244 = local_53.inner[1];
    local_53.inner[1] = _e244 + _e242;
    uint _e248 = local_53.inner[0];
    local_54 = static_cast<uint>(_e248);
    uint _e252 = local_53.inner[1];
    local_55 = static_cast<uint>(_e252);
    uint _e255 = local_55;
    out_1[_e255] = static_cast<uint>(_e230);
    int _e260 = total.values.inner[0];
    type_8 _e262 = out;
    local_16 = _e262;
    uint _e263 = base;
    local_17 = static_cast<uint>(_e263 + static_cast<uint>(8));
    type_8 _e271 = local_16;
    local_56 = _e271;
    uint _e272 = local_17;
    uint _e274 = local_56.inner[1];
    local_56.inner[1] = _e274 + _e272;
    uint _e278 = local_56.inner[0];
    local_57 = static_cast<uint>(_e278);
    uint _e282 = local_56.inner[1];
    local_58 = static_cast<uint>(_e282);
    uint _e285 = local_58;
    out_1[_e285] = static_cast<uint>(_e260);
    int _e290 = total.values.inner[1];
    type_8 _e292 = out;
    local_18 = _e292;
    uint _e293 = base;
    local_19 = static_cast<uint>(_e293 + static_cast<uint>(9));
    type_8 _e301 = local_18;
    local_59 = _e301;
    uint _e302 = local_19;
    uint _e304 = local_59.inner[1];
    local_59.inner[1] = _e304 + _e302;
    uint _e308 = local_59.inner[0];
    local_60 = static_cast<uint>(_e308);
    uint _e312 = local_59.inner[1];
    local_61 = static_cast<uint>(_e312);
    uint _e315 = local_61;
    out_1[_e315] = static_cast<uint>(_e290);
    int _e317 = counter;
    counter = as_type<int>(as_type<uint>(_e317) + as_type<uint>(1));
    first_argument = _e317;
    int _e321 = first_argument;
    int _e322 = counter;
    counter = as_type<int>(as_type<uint>(_e322) + as_type<uint>(1));
    int _e325 = pair(_e321, _e322);
    type_8 _e327 = out;
    local_20 = _e327;
    uint _e328 = base;
    local_21 = static_cast<uint>(_e328 + static_cast<uint>(10));
    type_8 _e336 = local_20;
    local_62 = _e336;
    uint _e337 = local_21;
    uint _e339 = local_62.inner[1];
    local_62.inner[1] = _e339 + _e337;
    uint _e343 = local_62.inner[0];
    local_63 = static_cast<uint>(_e343);
    uint _e347 = local_62.inner[1];
    local_64 = static_cast<uint>(_e347);
    uint _e350 = local_64;
    out_1[_e350] = static_cast<uint>(_e325);
    int _e352 = counter;
    counter = as_type<int>(as_type<uint>(_e352) + as_type<uint>(1));
    consume(_e352);
    int _e355 = counter;
    type_8 _e357 = out;
    local_22 = _e357;
    uint _e358 = base;
    local_23 = static_cast<uint>(_e358 + static_cast<uint>(11));
    type_8 _e366 = local_22;
    local_65 = _e366;
    uint _e367 = local_23;
    uint _e369 = local_65.inner[1];
    local_65.inner[1] = _e369 + _e367;
    uint _e373 = local_65.inner[0];
    local_66 = static_cast<uint>(_e373);
    uint _e377 = local_65.inner[1];
    local_67 = static_cast<uint>(_e377);
    uint _e380 = local_67;
    out_1[_e380] = static_cast<uint>(_e355);
    float _e383 = generated(0.0);
    type_8 _e386 = out;
    local_24 = _e386;
    uint _e387 = base;
    local_25 = static_cast<uint>(_e387 + static_cast<uint>(12));
    type_8 _e394 = local_24;
    local_68 = _e394;
    uint _e395 = local_25;
    uint _e397 = local_68.inner[1];
    local_68.inner[1] = _e397 + _e395;
    uint _e401 = local_68.inner[0];
    local_69 = static_cast<uint>(_e401);
    uint _e405 = local_68.inner[1];
    local_70 = static_cast<uint>(_e405);
    uint _e408 = local_70;
    out_1[_e408] = as_type<uint>(_e383);
    int _e411 = control(3);
    type_8 _e413 = out;
    local_26 = _e413;
    uint _e414 = base;
    local_27 = static_cast<uint>(_e414 + static_cast<uint>(13));
    type_8 _e422 = local_26;
    local_71 = _e422;
    uint _e423 = local_27;
    uint _e425 = local_71.inner[1];
    local_71.inner[1] = _e425 + _e423;
    uint _e429 = local_71.inner[0];
    local_72 = static_cast<uint>(_e429);
    uint _e433 = local_71.inner[1];
    local_73 = static_cast<uint>(_e433);
    uint _e436 = local_73;
    out_1[_e436] = static_cast<uint>(_e411);
    uint _e438 = lane;
    type_8 _e440 = out;
    local_28 = _e440;
    uint _e441 = base;
    local_29 = static_cast<uint>(_e441 + static_cast<uint>(14));
    type_8 _e448 = local_28;
    local_74 = _e448;
    uint _e449 = local_29;
    uint _e451 = local_74.inner[1];
    local_74.inner[1] = _e451 + _e449;
    uint _e455 = local_74.inner[0];
    local_75 = static_cast<uint>(_e455);
    uint _e459 = local_74.inner[1];
    local_76 = static_cast<uint>(_e459);
    uint _e462 = local_76;
    out_1[_e462] = _e438;
    int _e464 = counter;
    counter = as_type<int>(as_type<uint>(_e464) + as_type<uint>(1));
    int _e467 = counter;
    int _e468 = forward(_e467);
    type_8 _e470 = out;
    local_30 = _e470;
    uint _e471 = base;
    local_31 = static_cast<uint>(_e471 + static_cast<uint>(15));
    type_8 _e479 = local_30;
    local_77 = _e479;
    uint _e480 = local_31;
    uint _e482 = local_77.inner[1];
    local_77.inner[1] = _e482 + _e480;
    uint _e486 = local_77.inner[0];
    local_78 = static_cast<uint>(_e486);
    uint _e490 = local_77.inner[1];
    local_79 = static_cast<uint>(_e490);
    uint _e493 = local_79;
    out_1[_e493] = static_cast<uint>(_e468);
}
