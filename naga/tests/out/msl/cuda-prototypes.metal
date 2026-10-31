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
    return as_type<int>(as_type<uint>(10) + as_type<uint>(naga_f2i32(value)));
}

int earlier(
    int value_1
) {
    int _e2 = route(static_cast<float>(value_1));
    return _e2;
}

int route_1(
    int value_2
) {
    return as_type<int>(as_type<uint>(20) + as_type<uint>(value_2));
}

int forward(
    int value_3
) {
    int _e1 = route_1(value_3);
    int _e2 = earlier(value_3);
    return as_type<int>(as_type<uint>(_e1) + as_type<uint>(_e2));
}

Packet_cuda_record_0_ packet(
    int value_4
) {
    Packet_cuda_record_0_ local_80 = {};
    local_80.key = value_4;
    local_80.values.inner[0] = as_type<int>(as_type<uint>(value_4) + as_type<uint>(1));
    local_80.values.inner[1] = as_type<int>(as_type<uint>(value_4) + as_type<uint>(2));
    Packet_cuda_record_0_ _e10 = local_80;
    return _e10;
}

Packet_cuda_record_0_ adjust(
    Packet_cuda_record_0_ value_5
) {
    Packet_cuda_record_0_ value_6 = {};
    value_6 = value_5;
    int _e4 = value_6.key;
    value_6.key = as_type<int>(as_type<uint>(_e4) + as_type<uint>(4));
    int _e10 = value_6.values.inner[1];
    value_6.values.inner[1] = as_type<int>(as_type<uint>(_e10) + as_type<uint>(6));
    Packet_cuda_record_0_ _e12 = value_6;
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
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(first_1) * as_type<uint>(10))) + as_type<uint>(second_1));
}

void consume(
    int value_7
) {
    if (value_7 != 0) {
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
    type_5 value_8,
    uint divisor
) {
    type_5 source_1 = type_5 {};
    type_5 result_2 = type_5 {};
    uint remainder_1 = uint {};
    uint step = uint {};
    source_1 = value_8;
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
    float value_9
) {
    uint _e3 = _naga_sqrtf(as_type<uint>(4.0));
    uint _e7 = _naga_trigonometry(as_type<uint>(value_9), 0u);
    uint _e12 = _naga_trigonometry(as_type<uint>(value_9), 1u);
    return (as_type<float>(_e3) + as_type<float>(_e7)) + as_type<float>(_e12);
}

int control(
    int count
) {
    int result_4 = {};
    int index = {};
    result_4 = 0;
    {
        index = 0;
        uint2 loop_bound_13 = uint2(4294967295u);
        bool loop_init_13 = true;
        while(true) {
            if (metal::all(loop_bound_13 == uint2(0u))) { break; }
            loop_bound_13 -= uint2(loop_bound_13.y == 0u, 1u);
            if (!loop_init_13) {
                int _e22 = index;
                index = as_type<int>(as_type<uint>(_e22) + as_type<uint>(1));
            }
            loop_init_13 = false;
            int _e5 = index;
            if (_e5 < count) {
            } else {
                break;
            }
            int _e7 = index;
            if (_e7 == 1) {
                continue;
            }
            int _e10 = index;
            switch(_e10) {
                case 0: {
                    int _e11 = index;
                    int _e12 = route_1(_e11);
                    int _e13 = result_4;
                    result_4 = as_type<int>(as_type<uint>(_e13) + as_type<uint>(_e12));
                    break;
                }
                default: {
                    int _e15 = index;
                    int _e16 = forward(_e15);
                    int _e17 = index;
                    int _e18 = earlier(_e17);
                    int _e20 = result_4;
                    result_4 = as_type<int>(as_type<uint>(_e20) + as_type<uint>(as_type<int>(as_type<uint>(_e16) - as_type<uint>(_e18))));
                    break;
                }
            }
        }
    }
    int _e25 = result_4;
    return _e25;
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
    uint _e10 = late_index(blockIdx_1, threadIdx_1);
    uint base = _e10 * 16u;
    counter = 1;
    int _e15 = counter;
    counter = as_type<int>(as_type<uint>(_e15) + as_type<uint>(1));
    Packet_cuda_record_0_ _e18 = packet(_e15);
    first = _e18;
    Packet_cuda_record_0_ _e20 = first;
    Packet_cuda_record_0_ _e21 = adjust(_e20);
    second = _e21;
    Packet_cuda_record_0_ _e23 = first;
    Packet_cuda_record_0_ _e24 = second;
    Packet_cuda_record_0_ _e25 = operator_u002b(_e23, _e24);
    total = _e25;
    int _e28 = earlier(3);
    type_8 _e30 = out;
    local = _e30;
    local_1 = static_cast<uint>(base);
    type_8 _e35 = local;
    local_32 = _e35;
    uint _e37 = local_1;
    uint _e39 = local_32.inner[1];
    local_32.inner[1] = _e39 + _e37;
    uint _e43 = local_32.inner[0];
    local_33 = static_cast<uint>(_e43);
    uint _e47 = local_32.inner[1];
    local_34 = static_cast<uint>(_e47);
    uint _e50 = local_34;
    out_1[_e50] = static_cast<uint>(_e28);
    int _e54 = route_1(3);
    type_8 _e55 = out;
    local_2 = _e55;
    local_3 = static_cast<uint>(base + static_cast<uint>(1));
    type_8 _e63 = local_2;
    local_35 = _e63;
    uint _e65 = local_3;
    uint _e67 = local_35.inner[1];
    local_35.inner[1] = _e67 + _e65;
    uint _e71 = local_35.inner[0];
    local_36 = static_cast<uint>(_e71);
    uint _e75 = local_35.inner[1];
    local_37 = static_cast<uint>(_e75);
    uint _e78 = local_37;
    out_1[_e78] = static_cast<uint>(_e54);
    int _e81 = forward(4);
    type_8 _e82 = out;
    local_4 = _e82;
    local_5 = static_cast<uint>(base + static_cast<uint>(2));
    type_8 _e90 = local_4;
    local_38 = _e90;
    uint _e92 = local_5;
    uint _e94 = local_38.inner[1];
    local_38.inner[1] = _e94 + _e92;
    uint _e98 = local_38.inner[0];
    local_39 = static_cast<uint>(_e98);
    uint _e102 = local_38.inner[1];
    local_40 = static_cast<uint>(_e102);
    uint _e105 = local_40;
    out_1[_e105] = static_cast<uint>(_e81);
    int _e108 = first.key;
    type_8 _e109 = out;
    local_6 = _e109;
    local_7 = static_cast<uint>(base + static_cast<uint>(3));
    type_8 _e117 = local_6;
    local_41 = _e117;
    uint _e119 = local_7;
    uint _e121 = local_41.inner[1];
    local_41.inner[1] = _e121 + _e119;
    uint _e125 = local_41.inner[0];
    local_42 = static_cast<uint>(_e125);
    uint _e129 = local_41.inner[1];
    local_43 = static_cast<uint>(_e129);
    uint _e132 = local_43;
    out_1[_e132] = static_cast<uint>(_e108);
    int _e137 = first.values.inner[1];
    type_8 _e138 = out;
    local_8 = _e138;
    local_9 = static_cast<uint>(base + static_cast<uint>(4));
    type_8 _e146 = local_8;
    local_44 = _e146;
    uint _e148 = local_9;
    uint _e150 = local_44.inner[1];
    local_44.inner[1] = _e150 + _e148;
    uint _e154 = local_44.inner[0];
    local_45 = static_cast<uint>(_e154);
    uint _e158 = local_44.inner[1];
    local_46 = static_cast<uint>(_e158);
    uint _e161 = local_46;
    out_1[_e161] = static_cast<uint>(_e137);
    int _e164 = second.key;
    type_8 _e165 = out;
    local_10 = _e165;
    local_11 = static_cast<uint>(base + static_cast<uint>(5));
    type_8 _e173 = local_10;
    local_47 = _e173;
    uint _e175 = local_11;
    uint _e177 = local_47.inner[1];
    local_47.inner[1] = _e177 + _e175;
    uint _e181 = local_47.inner[0];
    local_48 = static_cast<uint>(_e181);
    uint _e185 = local_47.inner[1];
    local_49 = static_cast<uint>(_e185);
    uint _e188 = local_49;
    out_1[_e188] = static_cast<uint>(_e164);
    int _e193 = second.values.inner[1];
    type_8 _e194 = out;
    local_12 = _e194;
    local_13 = static_cast<uint>(base + static_cast<uint>(6));
    type_8 _e202 = local_12;
    local_50 = _e202;
    uint _e204 = local_13;
    uint _e206 = local_50.inner[1];
    local_50.inner[1] = _e206 + _e204;
    uint _e210 = local_50.inner[0];
    local_51 = static_cast<uint>(_e210);
    uint _e214 = local_50.inner[1];
    local_52 = static_cast<uint>(_e214);
    uint _e217 = local_52;
    out_1[_e217] = static_cast<uint>(_e193);
    int _e220 = total.key;
    type_8 _e221 = out;
    local_14 = _e221;
    local_15 = static_cast<uint>(base + static_cast<uint>(7));
    type_8 _e229 = local_14;
    local_53 = _e229;
    uint _e231 = local_15;
    uint _e233 = local_53.inner[1];
    local_53.inner[1] = _e233 + _e231;
    uint _e237 = local_53.inner[0];
    local_54 = static_cast<uint>(_e237);
    uint _e241 = local_53.inner[1];
    local_55 = static_cast<uint>(_e241);
    uint _e244 = local_55;
    out_1[_e244] = static_cast<uint>(_e220);
    int _e249 = total.values.inner[0];
    type_8 _e250 = out;
    local_16 = _e250;
    local_17 = static_cast<uint>(base + static_cast<uint>(8));
    type_8 _e258 = local_16;
    local_56 = _e258;
    uint _e260 = local_17;
    uint _e262 = local_56.inner[1];
    local_56.inner[1] = _e262 + _e260;
    uint _e266 = local_56.inner[0];
    local_57 = static_cast<uint>(_e266);
    uint _e270 = local_56.inner[1];
    local_58 = static_cast<uint>(_e270);
    uint _e273 = local_58;
    out_1[_e273] = static_cast<uint>(_e249);
    int _e278 = total.values.inner[1];
    type_8 _e279 = out;
    local_18 = _e279;
    local_19 = static_cast<uint>(base + static_cast<uint>(9));
    type_8 _e287 = local_18;
    local_59 = _e287;
    uint _e289 = local_19;
    uint _e291 = local_59.inner[1];
    local_59.inner[1] = _e291 + _e289;
    uint _e295 = local_59.inner[0];
    local_60 = static_cast<uint>(_e295);
    uint _e299 = local_59.inner[1];
    local_61 = static_cast<uint>(_e299);
    uint _e302 = local_61;
    out_1[_e302] = static_cast<uint>(_e278);
    int first_argument = counter;
    counter = as_type<int>(as_type<uint>(first_argument) + as_type<uint>(1));
    int _e307 = counter;
    counter = as_type<int>(as_type<uint>(_e307) + as_type<uint>(1));
    int _e310 = pair(first_argument, _e307);
    type_8 _e311 = out;
    local_20 = _e311;
    local_21 = static_cast<uint>(base + static_cast<uint>(10));
    type_8 _e319 = local_20;
    local_62 = _e319;
    uint _e321 = local_21;
    uint _e323 = local_62.inner[1];
    local_62.inner[1] = _e323 + _e321;
    uint _e327 = local_62.inner[0];
    local_63 = static_cast<uint>(_e327);
    uint _e331 = local_62.inner[1];
    local_64 = static_cast<uint>(_e331);
    uint _e334 = local_64;
    out_1[_e334] = static_cast<uint>(_e310);
    int _e336 = counter;
    counter = as_type<int>(as_type<uint>(_e336) + as_type<uint>(1));
    consume(_e336);
    int _e339 = counter;
    type_8 _e340 = out;
    local_22 = _e340;
    local_23 = static_cast<uint>(base + static_cast<uint>(11));
    type_8 _e348 = local_22;
    local_65 = _e348;
    uint _e350 = local_23;
    uint _e352 = local_65.inner[1];
    local_65.inner[1] = _e352 + _e350;
    uint _e356 = local_65.inner[0];
    local_66 = static_cast<uint>(_e356);
    uint _e360 = local_65.inner[1];
    local_67 = static_cast<uint>(_e360);
    uint _e363 = local_67;
    out_1[_e363] = static_cast<uint>(_e339);
    float _e366 = generated(0.0);
    type_8 _e368 = out;
    local_24 = _e368;
    local_25 = static_cast<uint>(base + static_cast<uint>(12));
    type_8 _e375 = local_24;
    local_68 = _e375;
    uint _e377 = local_25;
    uint _e379 = local_68.inner[1];
    local_68.inner[1] = _e379 + _e377;
    uint _e383 = local_68.inner[0];
    local_69 = static_cast<uint>(_e383);
    uint _e387 = local_68.inner[1];
    local_70 = static_cast<uint>(_e387);
    uint _e390 = local_70;
    out_1[_e390] = as_type<uint>(_e366);
    int _e393 = control(3);
    type_8 _e394 = out;
    local_26 = _e394;
    local_27 = static_cast<uint>(base + static_cast<uint>(13));
    type_8 _e402 = local_26;
    local_71 = _e402;
    uint _e404 = local_27;
    uint _e406 = local_71.inner[1];
    local_71.inner[1] = _e406 + _e404;
    uint _e410 = local_71.inner[0];
    local_72 = static_cast<uint>(_e410);
    uint _e414 = local_71.inner[1];
    local_73 = static_cast<uint>(_e414);
    uint _e417 = local_73;
    out_1[_e417] = static_cast<uint>(_e393);
    type_8 _e419 = out;
    local_28 = _e419;
    local_29 = static_cast<uint>(base + static_cast<uint>(14));
    type_8 _e426 = local_28;
    local_74 = _e426;
    uint _e428 = local_29;
    uint _e430 = local_74.inner[1];
    local_74.inner[1] = _e430 + _e428;
    uint _e434 = local_74.inner[0];
    local_75 = static_cast<uint>(_e434);
    uint _e438 = local_74.inner[1];
    local_76 = static_cast<uint>(_e438);
    uint _e441 = local_76;
    out_1[_e441] = _e10;
    int _e443 = counter;
    counter = as_type<int>(as_type<uint>(_e443) + as_type<uint>(1));
    int _e446 = counter;
    int _e447 = forward(_e446);
    type_8 _e448 = out;
    local_30 = _e448;
    local_31 = static_cast<uint>(base + static_cast<uint>(15));
    type_8 _e456 = local_30;
    local_77 = _e456;
    uint _e458 = local_31;
    uint _e460 = local_77.inner[1];
    local_77.inner[1] = _e460 + _e458;
    uint _e464 = local_77.inner[0];
    local_78 = static_cast<uint>(_e464);
    uint _e468 = local_77.inner[1];
    local_79 = static_cast<uint>(_e468);
    uint _e471 = local_79;
    out_1[_e471] = static_cast<uint>(_e447);
}
