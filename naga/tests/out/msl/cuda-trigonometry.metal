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
    int local_121 = {};
    value_7 = value_6;
    bool _e2 = value_7;
    if (_e2) {
        local_121 = 17;
    } else {
        local_121 = 19;
    }
    int _e6 = local_121;
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
    uint local = {};
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
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    float value = {};
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
    bool choose = {};
    int counter = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    bool local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    bool local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    float local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    type_11 values = {};
    uint local_70 = {};
    uint local_71 = {};
    uint local_72 = {};
    int Count = {};
    type_11 scratch = {};
    uint local_73 = {};
    uint local_74 = {};
    uint local_75 = {};
    int repeated = {};
    int index = {};
    uint local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
    float local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    uint local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    uint local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    uint local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    uint local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    uint local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    uint local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    uint local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    uint local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    uint local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    uint local_120 = {};
    local = 0u;
    uint _e5 = _naga_trigonometry(as_type<uint>(0.0), 0u);
    uint _e8 = local;
    local_1 = _e8;
    uint _e10 = local_1;
    local_2 = static_cast<uint>(_e10);
    local_3 = static_cast<uint>(0);
    uint _e17 = local_2;
    uint _e18 = local_3;
    local_92 = static_cast<uint>(_e17 + _e18);
    uint _e22 = local_92;
    out[_e22] = as_type<uint>(as_type<float>(_e5));
    uint _e28 = _naga_trigonometry(as_type<uint>(-(0.0)), 0u);
    uint _e31 = local;
    local_4 = _e31;
    uint _e33 = local_4;
    local_5 = static_cast<uint>(_e33);
    local_6 = static_cast<uint>(1);
    uint _e39 = local_5;
    uint _e40 = local_6;
    local_93 = static_cast<uint>(_e39 + _e40);
    uint _e44 = local_93;
    out[_e44] = as_type<uint>(as_type<float>(_e28));
    uint _e49 = _naga_trigonometry(as_type<uint>(0.0), 1u);
    uint _e52 = local;
    local_7 = _e52;
    uint _e54 = local_7;
    local_8 = static_cast<uint>(_e54);
    local_9 = static_cast<uint>(2);
    uint _e60 = local_8;
    uint _e61 = local_9;
    local_94 = static_cast<uint>(_e60 + _e61);
    uint _e65 = local_94;
    out[_e65] = as_type<uint>(as_type<float>(_e49));
    uint _e71 = _naga_trigonometry(as_type<uint>(-(0.0)), 1u);
    uint _e74 = local;
    local_10 = _e74;
    uint _e76 = local_10;
    local_11 = static_cast<uint>(_e76);
    local_12 = static_cast<uint>(3);
    uint _e82 = local_11;
    uint _e83 = local_12;
    local_95 = static_cast<uint>(_e82 + _e83);
    uint _e87 = local_95;
    out[_e87] = as_type<uint>(as_type<float>(_e71));
    float _e91 = sine_value(static_cast<float>(0));
    uint _e93 = local;
    local_13 = _e93;
    uint _e95 = local_13;
    local_14 = static_cast<uint>(_e95);
    local_15 = static_cast<uint>(4);
    uint _e101 = local_14;
    uint _e102 = local_15;
    local_96 = static_cast<uint>(_e101 + _e102);
    uint _e106 = local_96;
    out[_e106] = as_type<uint>(_e91);
    float _e110 = cosine_value(static_cast<float>(0u));
    uint _e112 = local;
    local_16 = _e112;
    uint _e114 = local_16;
    local_17 = static_cast<uint>(_e114);
    local_18 = static_cast<uint>(5);
    uint _e120 = local_17;
    uint _e121 = local_18;
    local_97 = static_cast<uint>(_e120 + _e121);
    uint _e125 = local_97;
    out[_e125] = as_type<uint>(_e110);
    int _e128 = sinf(true);
    uint _e130 = local;
    local_19 = _e130;
    uint _e132 = local_19;
    local_20 = static_cast<uint>(_e132);
    local_21 = static_cast<uint>(6);
    uint _e138 = local_20;
    uint _e139 = local_21;
    local_98 = static_cast<uint>(_e138 + _e139);
    uint _e143 = local_98;
    out[_e143] = static_cast<uint>(_e128);
    int _e146 = sinf(false);
    uint _e148 = local;
    local_22 = _e148;
    uint _e150 = local_22;
    local_23 = static_cast<uint>(_e150);
    local_24 = static_cast<uint>(7);
    uint _e156 = local_23;
    uint _e157 = local_24;
    local_99 = static_cast<uint>(_e156 + _e157);
    uint _e161 = local_99;
    out[_e161] = static_cast<uint>(_e146);
    int _e164 = cosf(4);
    uint _e166 = local;
    local_25 = _e166;
    uint _e168 = local_25;
    local_26 = static_cast<uint>(_e168);
    local_27 = static_cast<uint>(8);
    uint _e174 = local_26;
    uint _e175 = local_27;
    local_100 = static_cast<uint>(_e174 + _e175);
    uint _e179 = local_100;
    out[_e179] = static_cast<uint>(_e164);
    uint _e184 = _naga_trigonometry(as_type<uint>(0.0), 1u);
    uint _e187 = local;
    local_28 = _e187;
    uint _e189 = local_28;
    local_29 = static_cast<uint>(_e189);
    local_30 = static_cast<uint>(9);
    uint _e195 = local_29;
    uint _e196 = local_30;
    local_101 = static_cast<uint>(_e195 + _e196);
    uint _e200 = local_101;
    out[_e200] = as_type<uint>(as_type<float>(_e184));
    float _e204 = sinf_1(2.0, 3.0);
    uint _e206 = local;
    local_31 = _e206;
    uint _e208 = local_31;
    local_32 = static_cast<uint>(_e208);
    local_33 = static_cast<uint>(10);
    uint _e214 = local_32;
    uint _e215 = local_33;
    local_102 = static_cast<uint>(_e214 + _e215);
    uint _e219 = local_102;
    out[_e219] = as_type<uint>(_e204);
    float _e224 = cosf_1(metal::float2(2.0, 3.0));
    uint _e226 = local;
    local_34 = _e226;
    uint _e228 = local_34;
    local_35 = static_cast<uint>(_e228);
    local_36 = static_cast<uint>(11);
    uint _e234 = local_35;
    uint _e235 = local_36;
    local_103 = static_cast<uint>(_e234 + _e235);
    uint _e239 = local_103;
    out[_e239] = as_type<uint>(_e224);
    value = 0.0;
    float _e243 = value;
    value = _e243 + static_cast<float>(1);
    uint _e249 = _naga_trigonometry(as_type<uint>(_e243), 0u);
    uint _e252 = local;
    local_37 = _e252;
    uint _e254 = local_37;
    local_38 = static_cast<uint>(_e254);
    local_39 = static_cast<uint>(12);
    uint _e260 = local_38;
    uint _e261 = local_39;
    local_104 = static_cast<uint>(_e260 + _e261);
    uint _e265 = local_104;
    out[_e265] = as_type<uint>(as_type<float>(_e249));
    float _e267 = value;
    uint _e269 = local;
    local_40 = _e269;
    uint _e271 = local_40;
    local_41 = static_cast<uint>(_e271);
    local_42 = static_cast<uint>(13);
    uint _e277 = local_41;
    uint _e278 = local_42;
    local_105 = static_cast<uint>(_e277 + _e278);
    uint _e282 = local_105;
    out[_e282] = as_type<uint>(_e267);
    value = -(1.0);
    float _e286 = value;
    value = _e286 + static_cast<float>(1);
    float _e290 = value;
    uint _e293 = _naga_trigonometry(as_type<uint>(_e290), 1u);
    uint _e296 = local;
    local_43 = _e296;
    uint _e298 = local_43;
    local_44 = static_cast<uint>(_e298);
    local_45 = static_cast<uint>(14);
    uint _e304 = local_44;
    uint _e305 = local_45;
    local_106 = static_cast<uint>(_e304 + _e305);
    uint _e309 = local_106;
    out[_e309] = as_type<uint>(as_type<float>(_e293));
    float _e311 = value;
    uint _e313 = local;
    local_46 = _e313;
    uint _e315 = local_46;
    local_47 = static_cast<uint>(_e315);
    local_48 = static_cast<uint>(15);
    uint _e321 = local_47;
    uint _e322 = local_48;
    local_107 = static_cast<uint>(_e321 + _e322);
    uint _e326 = local_107;
    out[_e326] = as_type<uint>(_e311);
    float _e328 = value;
    value = _e328 + static_cast<float>(1);
    float _e332 = identity(_e328);
    uint _e335 = _naga_trigonometry(as_type<uint>(_e332), 0u);
    float _e337 = value;
    value = _e337 + static_cast<float>(1);
    float _e341 = pair(as_type<float>(_e335), _e337);
    uint _e343 = local;
    local_49 = _e343;
    uint _e345 = local_49;
    local_50 = static_cast<uint>(_e345);
    local_51 = static_cast<uint>(16);
    uint _e351 = local_50;
    uint _e352 = local_51;
    local_108 = static_cast<uint>(_e351 + _e352);
    uint _e356 = local_108;
    out[_e356] = as_type<uint>(_e341);
    float _e358 = value;
    uint _e360 = local;
    local_52 = _e360;
    uint _e362 = local_52;
    local_53 = static_cast<uint>(_e362);
    local_54 = static_cast<uint>(17);
    uint _e368 = local_53;
    uint _e369 = local_54;
    local_109 = static_cast<uint>(_e368 + _e369);
    uint _e373 = local_109;
    out[_e373] = as_type<uint>(_e358);
    choose = false;
    counter = 0;
    bool _e379 = choose;
    local_58 = _e379;
    if (_e379) {
        int _e381 = counter;
        counter = as_type<int>(as_type<uint>(_e381) + as_type<uint>(1));
        uint _e387 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e381)), 0u);
        local_58 = as_type<float>(_e387) != 0.0;
    }
    bool _e391 = local_58;
    uint _e393 = local;
    local_55 = _e393;
    uint _e395 = local_55;
    local_56 = static_cast<uint>(_e395);
    local_57 = static_cast<uint>(18);
    uint _e401 = local_56;
    uint _e402 = local_57;
    local_110 = static_cast<uint>(_e401 + _e402);
    uint _e406 = local_110;
    out[_e406] = static_cast<uint>(_e391);
    local_62 = true;
    if (true) {
    } else {
        int _e410 = counter;
        counter = as_type<int>(as_type<uint>(_e410) + as_type<uint>(1));
        uint _e416 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e410)), 1u);
        local_62 = as_type<float>(_e416) != 0.0;
    }
    bool _e420 = local_62;
    uint _e422 = local;
    local_59 = _e422;
    uint _e424 = local_59;
    local_60 = static_cast<uint>(_e424);
    local_61 = static_cast<uint>(19);
    uint _e430 = local_60;
    uint _e431 = local_61;
    local_111 = static_cast<uint>(_e430 + _e431);
    uint _e435 = local_111;
    out[_e435] = static_cast<uint>(_e420);
    bool _e437 = choose;
    if (_e437) {
        int _e438 = counter;
        counter = as_type<int>(as_type<uint>(_e438) + as_type<uint>(1));
        int _e441 = counter;
        uint _e445 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e441)), 0u);
        local_66 = as_type<float>(_e445);
    } else {
        int _e448 = counter;
        uint _e452 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e448)), 1u);
        local_66 = as_type<float>(_e452);
    }
    float _e456 = local_66;
    uint _e458 = local;
    local_63 = _e458;
    uint _e460 = local_63;
    local_64 = static_cast<uint>(_e460);
    local_65 = static_cast<uint>(20);
    uint _e466 = local_64;
    uint _e467 = local_65;
    local_112 = static_cast<uint>(_e466 + _e467);
    uint _e471 = local_112;
    out[_e471] = naga_f2u32(_e456);
    int _e473 = counter;
    uint _e475 = local;
    local_67 = _e475;
    uint _e477 = local_67;
    local_68 = static_cast<uint>(_e477);
    local_69 = static_cast<uint>(21);
    uint _e483 = local_68;
    uint _e484 = local_69;
    local_113 = static_cast<uint>(_e483 + _e484);
    uint _e488 = local_113;
    out[_e488] = static_cast<uint>(_e473);
    uint _e495 = _naga_trigonometry(as_type<uint>(0.0), 0u);
    values.inner[0] = as_type<float>(_e495);
    uint _e501 = _naga_trigonometry(as_type<uint>(0.0), 1u);
    values.inner[1] = as_type<float>(_e501);
    float _e507 = values.inner[0];
    float _e508 = values.inner[1];
    uint _e511 = local;
    local_70 = _e511;
    uint _e513 = local_70;
    local_71 = static_cast<uint>(_e513);
    local_72 = static_cast<uint>(22);
    uint _e519 = local_71;
    uint _e520 = local_72;
    local_114 = static_cast<uint>(_e519 + _e520);
    uint _e524 = local_114;
    out[_e524] = as_type<uint>(_e507 + _e508);
    Count = 2;
    scratch = type_11 {};
    float _e532 = scratch.inner[1];
    uint _e534 = local;
    local_73 = _e534;
    uint _e536 = local_73;
    local_74 = static_cast<uint>(_e536);
    local_75 = static_cast<uint>(23);
    uint _e542 = local_74;
    uint _e543 = local_75;
    local_115 = static_cast<uint>(_e542 + _e543);
    uint _e547 = local_115;
    out[_e547] = as_type<uint>(_e532);
    repeated = 0;
    {
        index = 0;
        uint2 loop_bound_12 = uint2(4294967295u);
        bool loop_init_12 = true;
        while(true) {
            if (metal::all(loop_bound_12 == uint2(0u))) { break; }
            loop_bound_12 -= uint2(loop_bound_12.y == 0u, 1u);
            if (!loop_init_12) {
                int _e567 = index;
                index = as_type<int>(as_type<uint>(_e567) + as_type<uint>(1));
            }
            loop_init_12 = false;
            int _e553 = index;
            if (_e553 < 3) {
            } else {
                break;
            }
            int _e556 = index;
            if (_e556 == 0) {
                continue;
            }
            uint _e562 = _naga_trigonometry(as_type<uint>(0.0), 1u);
            int _e565 = repeated;
            repeated = as_type<int>(as_type<uint>(_e565) + as_type<uint>(naga_f2i32(as_type<float>(_e562))));
        }
    }
    int _e570 = repeated;
    uint _e572 = local;
    local_76 = _e572;
    uint _e574 = local_76;
    local_77 = static_cast<uint>(_e574);
    local_78 = static_cast<uint>(24);
    uint _e580 = local_77;
    uint _e581 = local_78;
    local_116 = static_cast<uint>(_e580 + _e581);
    uint _e585 = local_116;
    out[_e585] = static_cast<uint>(_e570);
    value = 0.0;
    float _e588 = value;
    value = _e588 + static_cast<float>(1);
    uint _e594 = _naga_trigonometry(as_type<uint>(_e588), 0u);
    float _e595 = value;
    value = _e595 - static_cast<float>(1);
    float _e599 = value;
    uint _e602 = _naga_trigonometry(as_type<uint>(_e599), 1u);
    uint _e605 = local;
    local_79 = _e605;
    uint _e607 = local_79;
    local_80 = static_cast<uint>(_e607);
    local_81 = static_cast<uint>(25);
    uint _e613 = local_80;
    uint _e614 = local_81;
    local_117 = static_cast<uint>(_e613 + _e614);
    uint _e618 = local_117;
    out[_e618] = as_type<uint>(as_type<float>(_e602));
    float _e620 = value;
    uint _e622 = local;
    local_82 = _e622;
    uint _e624 = local_82;
    local_83 = static_cast<uint>(_e624);
    local_84 = static_cast<uint>(26);
    uint _e630 = local_83;
    uint _e631 = local_84;
    local_118 = static_cast<uint>(_e630 + _e631);
    uint _e635 = local_118;
    out[_e635] = as_type<uint>(_e620);
    if (true) {
        uint _e641 = _naga_trigonometry(as_type<uint>(0.0), 1u);
        local_88 = as_type<float>(_e641);
    } else {
        uint _e647 = _naga_trigonometry(as_type<uint>(99.0), 0u);
        local_88 = as_type<float>(_e647);
    }
    float _e651 = local_88;
    uint _e653 = local;
    local_85 = _e653;
    uint _e655 = local_85;
    local_86 = static_cast<uint>(_e655);
    local_87 = static_cast<uint>(27);
    uint _e661 = local_86;
    uint _e662 = local_87;
    local_119 = static_cast<uint>(_e661 + _e662);
    uint _e666 = local_119;
    out[_e666] = naga_f2u32(_e651);
    float _e670 = cosine_value(static_cast<float>(false));
    uint _e672 = local;
    local_89 = _e672;
    uint _e674 = local_89;
    local_90 = static_cast<uint>(_e674);
    local_91 = static_cast<uint>(28);
    uint _e680 = local_90;
    uint _e681 = local_91;
    local_120 = static_cast<uint>(_e680 + _e681);
    uint _e685 = local_120;
    out[_e685] = as_type<uint>(_e670);
}
