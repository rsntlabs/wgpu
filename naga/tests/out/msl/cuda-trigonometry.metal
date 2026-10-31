// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_2 {
    uint inner[12];
};
struct type_3 {
    uint inner[22];
};
struct type_4 {
    uint inner[24];
};
struct type_5 {
    uint inner[2];
};
struct type_6 {
    uint inner[20];
};
typedef uint type_10[1];
struct type_11 {
    float inner[2];
};

type_2 _naga_trig_multiply(
    type_2 left,
    type_2 right
) {
    type_2 left_digits = type_2 {};
    type_2 right_digits = type_2 {};
    type_4 product = type_4 {};
    uint carry = uint {};
    uint left_index = uint {};
    uint right_index = uint {};
    type_2 result = type_2 {};
    uint result_index = uint {};
    left_digits = left;
    right_digits = right;
    left_index = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e46 = left_index;
            left_index = _e46 + 1u;
        }
        loop_init = false;
        uint _e13 = left_index;
        if (_e13 >= 12u) {
            break;
        }
        carry = 0u;
        uint _e18 = left_digits.inner[_e13];
        right_index = 0u;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                uint _e39 = right_index;
                right_index = _e39 + 1u;
            }
            loop_init_1 = false;
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
    uint2 loop_bound_2 = uint2(4294967295u);
    bool loop_init_2 = true;
    while(true) {
        if (metal::all(loop_bound_2 == uint2(0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_2) {
            uint _e62 = result_index;
            result_index = _e62 + 1u;
        }
        loop_init_2 = false;
        uint _e54 = result_index;
        if (_e54 >= 12u) {
            break;
        }
        uint _e60 = product.inner[_e54 + 11u];
        result.inner[_e54] = _e60;
    }
    type_2 _e65 = result;
    return _e65;
}

type_3 _naga_trig_reduce_multiply(
    type_5 left_1,
    type_6 right_1
) {
    type_5 left_digits_1 = type_5 {};
    type_6 right_digits_1 = type_6 {};
    type_3 product_1 = type_3 {};
    uint carry_1 = uint {};
    uint left_index_1 = uint {};
    uint right_index_1 = uint {};
    type_3 result_1 = type_3 {};
    uint result_index_1 = uint {};
    left_digits_1 = left_1;
    right_digits_1 = right_1;
    left_index_1 = 0u;
    uint2 loop_bound_3 = uint2(4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (metal::all(loop_bound_3 == uint2(0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e46 = left_index_1;
            left_index_1 = _e46 + 1u;
        }
        loop_init_3 = false;
        uint _e13 = left_index_1;
        if (_e13 >= 2u) {
            break;
        }
        carry_1 = 0u;
        uint _e18 = left_digits_1.inner[_e13];
        right_index_1 = 0u;
        uint2 loop_bound_4 = uint2(4294967295u);
        bool loop_init_4 = true;
        while(true) {
            if (metal::all(loop_bound_4 == uint2(0u))) { break; }
            loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
            if (!loop_init_4) {
                uint _e39 = right_index_1;
                right_index_1 = _e39 + 1u;
            }
            loop_init_4 = false;
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
    uint2 loop_bound_5 = uint2(4294967295u);
    bool loop_init_5 = true;
    while(true) {
        if (metal::all(loop_bound_5 == uint2(0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        if (!loop_init_5) {
            uint _e62 = result_index_1;
            result_index_1 = _e62 + 1u;
        }
        loop_init_5 = false;
        uint _e54 = result_index_1;
        if (_e54 >= 22u) {
            break;
        }
        uint _e60 = product_1.inner[_e54 + 0u];
        result_1.inner[_e54] = _e60;
    }
    type_3 _e65 = result_1;
    return _e65;
}

uint naga_div(uint lhs, uint rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

type_2 _naga_trig_divide(
    type_2 value_1,
    uint divisor
) {
    type_2 source = type_2 {};
    type_2 result_2 = type_2 {};
    uint remainder = uint {};
    uint step = uint {};
    source = value_1;
    step = 0u;
    uint2 loop_bound_6 = uint2(4294967295u);
    bool loop_init_6 = true;
    while(true) {
        if (metal::all(loop_bound_6 == uint2(0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        if (!loop_init_6) {
            uint _e25 = step;
            step = _e25 + 1u;
        }
        loop_init_6 = false;
        uint _e11 = step;
        if (_e11 >= 12u) {
            break;
        }
        uint _e15 = 11u - _e11;
        uint _e16 = remainder;
        uint _e20 = source.inner[_e15];
        uint _e21 = (_e16 << 16u) | _e20;
        result_2.inner[_e15] = naga_div(_e21, divisor);
        remainder = naga_mod(_e21, divisor);
    }
    type_2 _e28 = result_2;
    return _e28;
}

type_2 _naga_trig_combine(
    type_2 left_2,
    type_2 right_2,
    uint subtract
) {
    type_2 left_digits_2 = type_2 {};
    type_2 right_digits_2 = type_2 {};
    type_2 result_3 = type_2 {};
    uint carry_2 = uint {};
    uint digit_index = uint {};
    left_digits_2 = left_2;
    right_digits_2 = right_2;
    bool _e12 = subtract != 0u;
    digit_index = 0u;
    uint2 loop_bound_7 = uint2(4294967295u);
    bool loop_init_7 = true;
    while(true) {
        if (metal::all(loop_bound_7 == uint2(0u))) { break; }
        loop_bound_7 -= uint2(loop_bound_7.y == 0u, 1u);
        if (!loop_init_7) {
            uint _e38 = digit_index;
            digit_index = _e38 + 1u;
        }
        loop_init_7 = false;
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
    type_2 _e41 = result_3;
    return _e41;
}

uint _naga_trig_extract_product(
    type_3 digits,
    uint offset
) {
    type_3 source_1 = type_3 {};
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
    type_2 digits_1,
    uint offset_1
) {
    type_2 source_2 = type_2 {};
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

type_2 _naga_trig_kernel(
    type_2 angle,
    uint sine
) {
    type_2 term = type_2 {};
    type_2 total = type_2 {};
    uint step_1 = uint {};
    bool _e7 = sine != 0u;
    if (_e7) {
        term = angle;
    } else {
        term = type_2 {{0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u}};
    }
    type_2 _e21 = term;
    total = _e21;
    type_2 _e22 = _naga_trig_multiply(angle, angle);
    step_1 = 0u;
    uint2 loop_bound_8 = uint2(4294967295u);
    bool loop_init_8 = true;
    while(true) {
        if (metal::all(loop_bound_8 == uint2(0u))) { break; }
        loop_bound_8 -= uint2(loop_bound_8.y == 0u, 1u);
        if (!loop_init_8) {
            uint _e46 = step_1;
            step_1 = _e46 + 1u;
        }
        loop_init_8 = false;
        uint _e26 = step_1;
        if (_e26 >= 8u) {
            break;
        }
        uint _e30 = _e26 + 1u;
        uint _e32 = _e30 * 2u;
        type_2 _e39 = term;
        type_2 _e40 = _naga_trig_multiply(_e39, _e22);
        type_2 _e41 = _naga_trig_divide(_e40, _e32 * (_e7 ? (_e32 + 1u) : (_e32 - 1u)));
        term = _e41;
        type_2 _e42 = total;
        type_2 _e45 = _naga_trig_combine(_e42, _e41, _e30 & 1u);
        total = _e45;
    }
    type_2 _e49 = total;
    return _e49;
}

uint _naga_trig_round(
    type_2 digits_2
) {
    type_2 source_3 = type_2 {};
    uint highest_bit = uint {};
    uint nonzero = uint {};
    uint digit_index_1 = uint {};
    uint sticky = uint {};
    uint sticky_index = uint {};
    source_3 = digits_2;
    digit_index_1 = 0u;
    uint2 loop_bound_9 = uint2(4294967295u);
    bool loop_init_9 = true;
    while(true) {
        if (metal::all(loop_bound_9 == uint2(0u))) { break; }
        loop_bound_9 -= uint2(loop_bound_9.y == 0u, 1u);
        if (!loop_init_9) {
            uint _e25 = digit_index_1;
            digit_index_1 = _e25 + 1u;
        }
        loop_init_9 = false;
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
    uint2 loop_bound_10 = uint2(4294967295u);
    bool loop_init_10 = true;
    while(true) {
        if (metal::all(loop_bound_10 == uint2(0u))) { break; }
        loop_bound_10 -= uint2(loop_bound_10.y == 0u, 1u);
        if (!loop_init_10) {
            uint _e80 = sticky_index;
            sticky_index = _e80 + 1u;
        }
        loop_init_10 = false;
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
    uint input_bits,
    uint cosine
) {
    uint quadrant = uint {};
    type_2 fraction = type_2 {};
    uint fraction_index = uint {};
    uint _e3 = input_bits & 2147483647u;
    if (_e3 >= 2139095040u) {
        return 2143289344u;
    }
    bool _e8 = cosine != 0u;
    if (_e3 <= 956301312u) {
        return _e8 ? 1065353216u : input_bits;
    }
    uint _e16 = 470u - (_e3 >> 23u);
    uint _e20 = (_e3 & 8388607u) | 8388608u;
    type_3 _e47 = _naga_trig_reduce_multiply(type_5 {{_e20 & 65535u, _e20 >> 16u}}, type_6 {{53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u}});
    uint _e50 = _naga_trig_extract_product(_e47, _e16);
    quadrant = _e50 & 3u;
    fraction_index = 0u;
    uint2 loop_bound_11 = uint2(4294967295u);
    bool loop_init_11 = true;
    while(true) {
        if (metal::all(loop_bound_11 == uint2(0u))) { break; }
        loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
        if (!loop_init_11) {
            uint _e68 = fraction_index;
            fraction_index = _e68 + 1u;
        }
        loop_init_11 = false;
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
        type_2 _e94 = fraction;
        type_2 _e96 = _naga_trig_combine(type_2 {{0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u}}, _e94, 1u);
        fraction = _e96;
    }
    type_2 _e97 = fraction;
    type_2 _e111 = _naga_trig_multiply(_e97, type_2 {{5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u}});
    uint _e112 = quadrant;
    bool _e115 = (_e112 & 1u) == cosine;
    type_2 _e119 = _naga_trig_kernel(_e111, _e115 ? 1u : 0u);
    uint _e120 = _naga_trig_round(_e119);
    return _e120 | ((((_e75 && _e115) ? 2147483648u : 0u) ^ (((_e8 ? (_e112 + 1u) : _e112) & 2u) << 30u)) ^ (_e8 ? 0u : (input_bits & 2147483648u)));
}

float sine_value(
    float value_2
) {
    float value_3 = {};
    value_3 = value_2;
    float _e2 = value_3;
    uint _e5 = _naga_trigonometry(as_type<uint>(_e2), 0u);
    return as_type<float>(_e5);
}

float cosine_value(
    float value_4
) {
    float value_5 = {};
    value_5 = value_4;
    float _e2 = value_5;
    uint _e5 = _naga_trigonometry(as_type<uint>(_e2), 1u);
    return as_type<float>(_e5);
}

int sinf(
    bool value_6
) {
    bool value_7 = {};
    int local_150 = {};
    value_7 = value_6;
    bool _e2 = value_7;
    if (_e2) {
        local_150 = 17;
    } else {
        local_150 = 19;
    }
    int _e6 = local_150;
    return _e6;
}

int cosf(
    int value_8
) {
    int value_9 = {};
    value_9 = value_8;
    int _e3 = value_9;
    return as_type<int>(as_type<uint>(_e3) + as_type<uint>(23));
}

float sinf_1(
    float first,
    float second
) {
    float first_1 = {};
    float second_1 = {};
    first_1 = first;
    second_1 = second;
    float _e4 = first_1;
    float _e5 = second_1;
    return _e4 + _e5;
}

float cosf_1(
    metal::float2 value_10
) {
    metal::float2 value_11 = {};
    value_11 = value_10;
    float _e4 = value_11.x;
    float _e5 = value_11.y;
    return _e4 + _e5;
}

float identity(
    float value_12
) {
    float value_13 = {};
    value_13 = value_12;
    float _e2 = value_13;
    return _e2;
}

float pair(
    float first_2,
    float second_2
) {
    float first_3 = {};
    float second_3 = {};
    first_3 = first_2;
    second_3 = second_2;
    float _e5 = first_3;
    float _e7 = second_3;
    return (_e5 * 10.0) + _e7;
}
uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}


kernel void trigonometry(
  device type_10& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_5 local = {};
    type_5 local_1 = {};
    uint local_2 = {};
    type_5 local_3 = {};
    uint local_4 = {};
    type_5 local_5 = {};
    uint local_6 = {};
    type_5 local_7 = {};
    uint local_8 = {};
    type_5 local_9 = {};
    uint local_10 = {};
    type_5 local_11 = {};
    uint local_12 = {};
    type_5 local_13 = {};
    uint local_14 = {};
    type_5 local_15 = {};
    uint local_16 = {};
    type_5 local_17 = {};
    uint local_18 = {};
    type_5 local_19 = {};
    uint local_20 = {};
    type_5 local_21 = {};
    uint local_22 = {};
    type_5 local_23 = {};
    uint local_24 = {};
    float value = {};
    type_5 local_25 = {};
    uint local_26 = {};
    type_5 local_27 = {};
    uint local_28 = {};
    type_5 local_29 = {};
    uint local_30 = {};
    type_5 local_31 = {};
    uint local_32 = {};
    type_5 local_33 = {};
    uint local_34 = {};
    type_5 local_35 = {};
    uint local_36 = {};
    bool choose = {};
    int counter = {};
    type_5 local_37 = {};
    uint local_38 = {};
    bool local_39 = {};
    type_5 local_40 = {};
    uint local_41 = {};
    bool local_42 = {};
    type_5 local_43 = {};
    uint local_44 = {};
    float local_45 = {};
    type_5 local_46 = {};
    uint local_47 = {};
    type_11 values = {};
    type_5 local_48 = {};
    uint local_49 = {};
    int Count = {};
    type_11 scratch = {};
    type_5 local_50 = {};
    uint local_51 = {};
    int repeated = {};
    int index = {};
    type_5 local_52 = {};
    uint local_53 = {};
    type_5 local_54 = {};
    uint local_55 = {};
    type_5 local_56 = {};
    uint local_57 = {};
    type_5 local_58 = {};
    uint local_59 = {};
    float local_60 = {};
    type_5 local_61 = {};
    uint local_62 = {};
    type_5 local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    type_5 local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    type_5 local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    type_5 local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    type_5 local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    type_5 local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    type_5 local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    type_5 local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    type_5 local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    type_5 local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    type_5 local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    type_5 local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    type_5 local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    type_5 local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    type_5 local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    type_5 local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    type_5 local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    type_5 local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    type_5 local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    type_5 local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    type_5 local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    type_5 local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    type_5 local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    type_5 local_132 = {};
    uint local_133 = {};
    uint local_134 = {};
    type_5 local_135 = {};
    uint local_136 = {};
    uint local_137 = {};
    type_5 local_138 = {};
    uint local_139 = {};
    uint local_140 = {};
    type_5 local_141 = {};
    uint local_142 = {};
    uint local_143 = {};
    type_5 local_144 = {};
    uint local_145 = {};
    uint local_146 = {};
    type_5 local_147 = {};
    uint local_148 = {};
    uint local_149 = {};
    local = type_5 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    uint _e10 = _naga_trigonometry(as_type<uint>(0.0), 0u);
    type_5 _e15 = local;
    local_1 = _e15;
    local_2 = static_cast<uint>(0);
    type_5 _e20 = local_1;
    local_63 = _e20;
    uint _e21 = local_2;
    uint _e23 = local_63.inner[1];
    local_63.inner[1] = _e23 + _e21;
    uint _e27 = local_63.inner[0];
    local_64 = static_cast<uint>(_e27);
    uint _e31 = local_63.inner[1];
    local_65 = static_cast<uint>(_e31);
    uint _e34 = local_65;
    out[_e34] = as_type<uint>(as_type<float>(_e10));
    uint _e40 = _naga_trigonometry(as_type<uint>(-(0.0)), 0u);
    type_5 _e44 = local;
    local_3 = _e44;
    local_4 = static_cast<uint>(1);
    type_5 _e49 = local_3;
    local_66 = _e49;
    uint _e50 = local_4;
    uint _e52 = local_66.inner[1];
    local_66.inner[1] = _e52 + _e50;
    uint _e56 = local_66.inner[0];
    local_67 = static_cast<uint>(_e56);
    uint _e60 = local_66.inner[1];
    local_68 = static_cast<uint>(_e60);
    uint _e63 = local_68;
    out[_e63] = as_type<uint>(as_type<float>(_e40));
    uint _e68 = _naga_trigonometry(as_type<uint>(0.0), 1u);
    type_5 _e72 = local;
    local_5 = _e72;
    local_6 = static_cast<uint>(2);
    type_5 _e77 = local_5;
    local_69 = _e77;
    uint _e78 = local_6;
    uint _e80 = local_69.inner[1];
    local_69.inner[1] = _e80 + _e78;
    uint _e84 = local_69.inner[0];
    local_70 = static_cast<uint>(_e84);
    uint _e88 = local_69.inner[1];
    local_71 = static_cast<uint>(_e88);
    uint _e91 = local_71;
    out[_e91] = as_type<uint>(as_type<float>(_e68));
    uint _e97 = _naga_trigonometry(as_type<uint>(-(0.0)), 1u);
    type_5 _e101 = local;
    local_7 = _e101;
    local_8 = static_cast<uint>(3);
    type_5 _e106 = local_7;
    local_72 = _e106;
    uint _e107 = local_8;
    uint _e109 = local_72.inner[1];
    local_72.inner[1] = _e109 + _e107;
    uint _e113 = local_72.inner[0];
    local_73 = static_cast<uint>(_e113);
    uint _e117 = local_72.inner[1];
    local_74 = static_cast<uint>(_e117);
    uint _e120 = local_74;
    out[_e120] = as_type<uint>(as_type<float>(_e97));
    float _e124 = sine_value(static_cast<float>(0));
    type_5 _e127 = local;
    local_9 = _e127;
    local_10 = static_cast<uint>(4);
    type_5 _e132 = local_9;
    local_75 = _e132;
    uint _e133 = local_10;
    uint _e135 = local_75.inner[1];
    local_75.inner[1] = _e135 + _e133;
    uint _e139 = local_75.inner[0];
    local_76 = static_cast<uint>(_e139);
    uint _e143 = local_75.inner[1];
    local_77 = static_cast<uint>(_e143);
    uint _e146 = local_77;
    out[_e146] = as_type<uint>(_e124);
    float _e150 = cosine_value(static_cast<float>(0u));
    type_5 _e153 = local;
    local_11 = _e153;
    local_12 = static_cast<uint>(5);
    type_5 _e158 = local_11;
    local_78 = _e158;
    uint _e159 = local_12;
    uint _e161 = local_78.inner[1];
    local_78.inner[1] = _e161 + _e159;
    uint _e165 = local_78.inner[0];
    local_79 = static_cast<uint>(_e165);
    uint _e169 = local_78.inner[1];
    local_80 = static_cast<uint>(_e169);
    uint _e172 = local_80;
    out[_e172] = as_type<uint>(_e150);
    int _e175 = sinf(true);
    type_5 _e178 = local;
    local_13 = _e178;
    local_14 = static_cast<uint>(6);
    type_5 _e183 = local_13;
    local_81 = _e183;
    uint _e184 = local_14;
    uint _e186 = local_81.inner[1];
    local_81.inner[1] = _e186 + _e184;
    uint _e190 = local_81.inner[0];
    local_82 = static_cast<uint>(_e190);
    uint _e194 = local_81.inner[1];
    local_83 = static_cast<uint>(_e194);
    uint _e197 = local_83;
    out[_e197] = static_cast<uint>(_e175);
    int _e200 = sinf(false);
    type_5 _e203 = local;
    local_15 = _e203;
    local_16 = static_cast<uint>(7);
    type_5 _e208 = local_15;
    local_84 = _e208;
    uint _e209 = local_16;
    uint _e211 = local_84.inner[1];
    local_84.inner[1] = _e211 + _e209;
    uint _e215 = local_84.inner[0];
    local_85 = static_cast<uint>(_e215);
    uint _e219 = local_84.inner[1];
    local_86 = static_cast<uint>(_e219);
    uint _e222 = local_86;
    out[_e222] = static_cast<uint>(_e200);
    int _e225 = cosf(4);
    type_5 _e228 = local;
    local_17 = _e228;
    local_18 = static_cast<uint>(8);
    type_5 _e233 = local_17;
    local_87 = _e233;
    uint _e234 = local_18;
    uint _e236 = local_87.inner[1];
    local_87.inner[1] = _e236 + _e234;
    uint _e240 = local_87.inner[0];
    local_88 = static_cast<uint>(_e240);
    uint _e244 = local_87.inner[1];
    local_89 = static_cast<uint>(_e244);
    uint _e247 = local_89;
    out[_e247] = static_cast<uint>(_e225);
    uint _e252 = _naga_trigonometry(as_type<uint>(0.0), 1u);
    type_5 _e256 = local;
    local_19 = _e256;
    local_20 = static_cast<uint>(9);
    type_5 _e261 = local_19;
    local_90 = _e261;
    uint _e262 = local_20;
    uint _e264 = local_90.inner[1];
    local_90.inner[1] = _e264 + _e262;
    uint _e268 = local_90.inner[0];
    local_91 = static_cast<uint>(_e268);
    uint _e272 = local_90.inner[1];
    local_92 = static_cast<uint>(_e272);
    uint _e275 = local_92;
    out[_e275] = as_type<uint>(as_type<float>(_e252));
    float _e279 = sinf_1(2.0, 3.0);
    type_5 _e282 = local;
    local_21 = _e282;
    local_22 = static_cast<uint>(10);
    type_5 _e287 = local_21;
    local_93 = _e287;
    uint _e288 = local_22;
    uint _e290 = local_93.inner[1];
    local_93.inner[1] = _e290 + _e288;
    uint _e294 = local_93.inner[0];
    local_94 = static_cast<uint>(_e294);
    uint _e298 = local_93.inner[1];
    local_95 = static_cast<uint>(_e298);
    uint _e301 = local_95;
    out[_e301] = as_type<uint>(_e279);
    float _e306 = cosf_1(metal::float2(2.0, 3.0));
    type_5 _e309 = local;
    local_23 = _e309;
    local_24 = static_cast<uint>(11);
    type_5 _e314 = local_23;
    local_96 = _e314;
    uint _e315 = local_24;
    uint _e317 = local_96.inner[1];
    local_96.inner[1] = _e317 + _e315;
    uint _e321 = local_96.inner[0];
    local_97 = static_cast<uint>(_e321);
    uint _e325 = local_96.inner[1];
    local_98 = static_cast<uint>(_e325);
    uint _e328 = local_98;
    out[_e328] = as_type<uint>(_e306);
    value = 0.0;
    float _e332 = value;
    value = _e332 + static_cast<float>(1);
    uint _e338 = _naga_trigonometry(as_type<uint>(_e332), 0u);
    type_5 _e342 = local;
    local_25 = _e342;
    local_26 = static_cast<uint>(12);
    type_5 _e347 = local_25;
    local_99 = _e347;
    uint _e348 = local_26;
    uint _e350 = local_99.inner[1];
    local_99.inner[1] = _e350 + _e348;
    uint _e354 = local_99.inner[0];
    local_100 = static_cast<uint>(_e354);
    uint _e358 = local_99.inner[1];
    local_101 = static_cast<uint>(_e358);
    uint _e361 = local_101;
    out[_e361] = as_type<uint>(as_type<float>(_e338));
    float _e363 = value;
    type_5 _e366 = local;
    local_27 = _e366;
    local_28 = static_cast<uint>(13);
    type_5 _e371 = local_27;
    local_102 = _e371;
    uint _e372 = local_28;
    uint _e374 = local_102.inner[1];
    local_102.inner[1] = _e374 + _e372;
    uint _e378 = local_102.inner[0];
    local_103 = static_cast<uint>(_e378);
    uint _e382 = local_102.inner[1];
    local_104 = static_cast<uint>(_e382);
    uint _e385 = local_104;
    out[_e385] = as_type<uint>(_e363);
    value = -(1.0);
    float _e389 = value;
    value = _e389 + static_cast<float>(1);
    float _e393 = value;
    uint _e396 = _naga_trigonometry(as_type<uint>(_e393), 1u);
    type_5 _e400 = local;
    local_29 = _e400;
    local_30 = static_cast<uint>(14);
    type_5 _e405 = local_29;
    local_105 = _e405;
    uint _e406 = local_30;
    uint _e408 = local_105.inner[1];
    local_105.inner[1] = _e408 + _e406;
    uint _e412 = local_105.inner[0];
    local_106 = static_cast<uint>(_e412);
    uint _e416 = local_105.inner[1];
    local_107 = static_cast<uint>(_e416);
    uint _e419 = local_107;
    out[_e419] = as_type<uint>(as_type<float>(_e396));
    float _e421 = value;
    type_5 _e424 = local;
    local_31 = _e424;
    local_32 = static_cast<uint>(15);
    type_5 _e429 = local_31;
    local_108 = _e429;
    uint _e430 = local_32;
    uint _e432 = local_108.inner[1];
    local_108.inner[1] = _e432 + _e430;
    uint _e436 = local_108.inner[0];
    local_109 = static_cast<uint>(_e436);
    uint _e440 = local_108.inner[1];
    local_110 = static_cast<uint>(_e440);
    uint _e443 = local_110;
    out[_e443] = as_type<uint>(_e421);
    float _e445 = value;
    value = _e445 + static_cast<float>(1);
    float _e449 = identity(_e445);
    uint _e452 = _naga_trigonometry(as_type<uint>(_e449), 0u);
    float _e454 = value;
    value = _e454 + static_cast<float>(1);
    float _e458 = pair(as_type<float>(_e452), _e454);
    type_5 _e461 = local;
    local_33 = _e461;
    local_34 = static_cast<uint>(16);
    type_5 _e466 = local_33;
    local_111 = _e466;
    uint _e467 = local_34;
    uint _e469 = local_111.inner[1];
    local_111.inner[1] = _e469 + _e467;
    uint _e473 = local_111.inner[0];
    local_112 = static_cast<uint>(_e473);
    uint _e477 = local_111.inner[1];
    local_113 = static_cast<uint>(_e477);
    uint _e480 = local_113;
    out[_e480] = as_type<uint>(_e458);
    float _e482 = value;
    type_5 _e485 = local;
    local_35 = _e485;
    local_36 = static_cast<uint>(17);
    type_5 _e490 = local_35;
    local_114 = _e490;
    uint _e491 = local_36;
    uint _e493 = local_114.inner[1];
    local_114.inner[1] = _e493 + _e491;
    uint _e497 = local_114.inner[0];
    local_115 = static_cast<uint>(_e497);
    uint _e501 = local_114.inner[1];
    local_116 = static_cast<uint>(_e501);
    uint _e504 = local_116;
    out[_e504] = as_type<uint>(_e482);
    choose = false;
    counter = 0;
    bool _e510 = choose;
    local_39 = _e510;
    if (_e510) {
        int _e512 = counter;
        counter = as_type<int>(as_type<uint>(_e512) + as_type<uint>(1));
        uint _e518 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e512)), 0u);
        local_39 = as_type<float>(_e518) != 0.0;
    }
    bool _e522 = local_39;
    type_5 _e525 = local;
    local_37 = _e525;
    local_38 = static_cast<uint>(18);
    type_5 _e530 = local_37;
    local_117 = _e530;
    uint _e531 = local_38;
    uint _e533 = local_117.inner[1];
    local_117.inner[1] = _e533 + _e531;
    uint _e537 = local_117.inner[0];
    local_118 = static_cast<uint>(_e537);
    uint _e541 = local_117.inner[1];
    local_119 = static_cast<uint>(_e541);
    uint _e544 = local_119;
    out[_e544] = static_cast<uint>(_e522);
    local_42 = true;
    if (true) {
    } else {
        int _e548 = counter;
        counter = as_type<int>(as_type<uint>(_e548) + as_type<uint>(1));
        uint _e554 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e548)), 1u);
        local_42 = as_type<float>(_e554) != 0.0;
    }
    bool _e558 = local_42;
    type_5 _e561 = local;
    local_40 = _e561;
    local_41 = static_cast<uint>(19);
    type_5 _e566 = local_40;
    local_120 = _e566;
    uint _e567 = local_41;
    uint _e569 = local_120.inner[1];
    local_120.inner[1] = _e569 + _e567;
    uint _e573 = local_120.inner[0];
    local_121 = static_cast<uint>(_e573);
    uint _e577 = local_120.inner[1];
    local_122 = static_cast<uint>(_e577);
    uint _e580 = local_122;
    out[_e580] = static_cast<uint>(_e558);
    bool _e582 = choose;
    if (_e582) {
        int _e583 = counter;
        counter = as_type<int>(as_type<uint>(_e583) + as_type<uint>(1));
        int _e586 = counter;
        uint _e590 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e586)), 0u);
        local_45 = as_type<float>(_e590);
    } else {
        int _e593 = counter;
        uint _e597 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e593)), 1u);
        local_45 = as_type<float>(_e597);
    }
    float _e601 = local_45;
    type_5 _e604 = local;
    local_43 = _e604;
    local_44 = static_cast<uint>(20);
    type_5 _e609 = local_43;
    local_123 = _e609;
    uint _e610 = local_44;
    uint _e612 = local_123.inner[1];
    local_123.inner[1] = _e612 + _e610;
    uint _e616 = local_123.inner[0];
    local_124 = static_cast<uint>(_e616);
    uint _e620 = local_123.inner[1];
    local_125 = static_cast<uint>(_e620);
    uint _e623 = local_125;
    out[_e623] = naga_f2u32(_e601);
    int _e625 = counter;
    type_5 _e628 = local;
    local_46 = _e628;
    local_47 = static_cast<uint>(21);
    type_5 _e633 = local_46;
    local_126 = _e633;
    uint _e634 = local_47;
    uint _e636 = local_126.inner[1];
    local_126.inner[1] = _e636 + _e634;
    uint _e640 = local_126.inner[0];
    local_127 = static_cast<uint>(_e640);
    uint _e644 = local_126.inner[1];
    local_128 = static_cast<uint>(_e644);
    uint _e647 = local_128;
    out[_e647] = static_cast<uint>(_e625);
    uint _e654 = _naga_trigonometry(as_type<uint>(0.0), 0u);
    values.inner[0] = as_type<float>(_e654);
    uint _e660 = _naga_trigonometry(as_type<uint>(0.0), 1u);
    values.inner[1] = as_type<float>(_e660);
    float _e666 = values.inner[0];
    float _e667 = values.inner[1];
    type_5 _e671 = local;
    local_48 = _e671;
    local_49 = static_cast<uint>(22);
    type_5 _e676 = local_48;
    local_129 = _e676;
    uint _e677 = local_49;
    uint _e679 = local_129.inner[1];
    local_129.inner[1] = _e679 + _e677;
    uint _e683 = local_129.inner[0];
    local_130 = static_cast<uint>(_e683);
    uint _e687 = local_129.inner[1];
    local_131 = static_cast<uint>(_e687);
    uint _e690 = local_131;
    out[_e690] = as_type<uint>(_e666 + _e667);
    Count = 2;
    scratch = type_11 {};
    float _e698 = scratch.inner[1];
    type_5 _e701 = local;
    local_50 = _e701;
    local_51 = static_cast<uint>(23);
    type_5 _e706 = local_50;
    local_132 = _e706;
    uint _e707 = local_51;
    uint _e709 = local_132.inner[1];
    local_132.inner[1] = _e709 + _e707;
    uint _e713 = local_132.inner[0];
    local_133 = static_cast<uint>(_e713);
    uint _e717 = local_132.inner[1];
    local_134 = static_cast<uint>(_e717);
    uint _e720 = local_134;
    out[_e720] = as_type<uint>(_e698);
    repeated = 0;
    {
        index = 0;
        uint2 loop_bound_12 = uint2(4294967295u);
        bool loop_init_12 = true;
        while(true) {
            if (metal::all(loop_bound_12 == uint2(0u))) { break; }
            loop_bound_12 -= uint2(loop_bound_12.y == 0u, 1u);
            if (!loop_init_12) {
                int _e740 = index;
                index = as_type<int>(as_type<uint>(_e740) + as_type<uint>(1));
            }
            loop_init_12 = false;
            int _e726 = index;
            if (_e726 < 3) {
            } else {
                break;
            }
            int _e729 = index;
            if (_e729 == 0) {
                continue;
            }
            uint _e735 = _naga_trigonometry(as_type<uint>(0.0), 1u);
            int _e738 = repeated;
            repeated = as_type<int>(as_type<uint>(_e738) + as_type<uint>(naga_f2i32(as_type<float>(_e735))));
        }
    }
    int _e743 = repeated;
    type_5 _e746 = local;
    local_52 = _e746;
    local_53 = static_cast<uint>(24);
    type_5 _e751 = local_52;
    local_135 = _e751;
    uint _e752 = local_53;
    uint _e754 = local_135.inner[1];
    local_135.inner[1] = _e754 + _e752;
    uint _e758 = local_135.inner[0];
    local_136 = static_cast<uint>(_e758);
    uint _e762 = local_135.inner[1];
    local_137 = static_cast<uint>(_e762);
    uint _e765 = local_137;
    out[_e765] = static_cast<uint>(_e743);
    value = 0.0;
    float _e768 = value;
    value = _e768 + static_cast<float>(1);
    uint _e774 = _naga_trigonometry(as_type<uint>(_e768), 0u);
    float _e775 = value;
    value = _e775 - static_cast<float>(1);
    float _e779 = value;
    uint _e782 = _naga_trigonometry(as_type<uint>(_e779), 1u);
    type_5 _e786 = local;
    local_54 = _e786;
    local_55 = static_cast<uint>(25);
    type_5 _e791 = local_54;
    local_138 = _e791;
    uint _e792 = local_55;
    uint _e794 = local_138.inner[1];
    local_138.inner[1] = _e794 + _e792;
    uint _e798 = local_138.inner[0];
    local_139 = static_cast<uint>(_e798);
    uint _e802 = local_138.inner[1];
    local_140 = static_cast<uint>(_e802);
    uint _e805 = local_140;
    out[_e805] = as_type<uint>(as_type<float>(_e782));
    float _e807 = value;
    type_5 _e810 = local;
    local_56 = _e810;
    local_57 = static_cast<uint>(26);
    type_5 _e815 = local_56;
    local_141 = _e815;
    uint _e816 = local_57;
    uint _e818 = local_141.inner[1];
    local_141.inner[1] = _e818 + _e816;
    uint _e822 = local_141.inner[0];
    local_142 = static_cast<uint>(_e822);
    uint _e826 = local_141.inner[1];
    local_143 = static_cast<uint>(_e826);
    uint _e829 = local_143;
    out[_e829] = as_type<uint>(_e807);
    if (true) {
        uint _e835 = _naga_trigonometry(as_type<uint>(0.0), 1u);
        local_60 = as_type<float>(_e835);
    } else {
        uint _e841 = _naga_trigonometry(as_type<uint>(99.0), 0u);
        local_60 = as_type<float>(_e841);
    }
    float _e845 = local_60;
    type_5 _e848 = local;
    local_58 = _e848;
    local_59 = static_cast<uint>(27);
    type_5 _e853 = local_58;
    local_144 = _e853;
    uint _e854 = local_59;
    uint _e856 = local_144.inner[1];
    local_144.inner[1] = _e856 + _e854;
    uint _e860 = local_144.inner[0];
    local_145 = static_cast<uint>(_e860);
    uint _e864 = local_144.inner[1];
    local_146 = static_cast<uint>(_e864);
    uint _e867 = local_146;
    out[_e867] = naga_f2u32(_e845);
    float _e871 = cosine_value(static_cast<float>(false));
    type_5 _e874 = local;
    local_61 = _e874;
    local_62 = static_cast<uint>(28);
    type_5 _e879 = local_61;
    local_147 = _e879;
    uint _e880 = local_62;
    uint _e882 = local_147.inner[1];
    local_147.inner[1] = _e882 + _e880;
    uint _e886 = local_147.inner[0];
    local_148 = static_cast<uint>(_e886);
    uint _e890 = local_147.inner[1];
    local_149 = static_cast<uint>(_e890);
    uint _e893 = local_149;
    out[_e893] = as_type<uint>(_e871);
}
