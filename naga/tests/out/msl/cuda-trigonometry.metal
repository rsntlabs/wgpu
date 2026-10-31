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
    uint _e3 = _naga_trigonometry(as_type<uint>(value_2), 0u);
    return as_type<float>(_e3);
}

float cosine_value(
    float value_3
) {
    uint _e3 = _naga_trigonometry(as_type<uint>(value_3), 1u);
    return as_type<float>(_e3);
}

int sinf(
    bool value_4
) {
    int local_33 = {};
    if (value_4) {
        local_33 = 17;
    } else {
        local_33 = 19;
    }
    int _e6 = local_33;
    return _e6;
}

int cosf(
    int value_5
) {
    return as_type<int>(as_type<uint>(value_5) + as_type<uint>(23));
}

float sinf_1(
    float first,
    float second
) {
    return first + second;
}

float cosf_1(
    metal::float2 value_6
) {
    metal::float2 value_7 = {};
    value_7 = value_6;
    float _e4 = value_7.x;
    float _e5 = value_7.y;
    return _e4 + _e5;
}

float identity(
    float value_8
) {
    return value_8;
}

float pair(
    float first_1,
    float second_1
) {
    return (first_1 * 10.0) + second_1;
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
    float value = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    bool choose = {};
    int counter = {};
    uint local_18 = {};
    bool local_19 = {};
    uint local_20 = {};
    bool local_21 = {};
    uint local_22 = {};
    float local_23 = {};
    uint local_24 = {};
    type_11 values = {};
    uint local_25 = {};
    int Count = {};
    type_11 scratch = {};
    uint local_26 = {};
    int repeated = {};
    int index = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    float local_31 = {};
    uint local_32 = {};
    uint _e3 = _naga_trigonometry(as_type<uint>(0.0), 0u);
    local = static_cast<uint>(0);
    uint _e9 = local;
    out[_e9] = as_type<uint>(as_type<float>(_e3));
    uint _e16 = _naga_trigonometry(as_type<uint>(-(0.0)), 0u);
    local_1 = static_cast<uint>(1);
    uint _e22 = local_1;
    out[_e22] = as_type<uint>(as_type<float>(_e16));
    uint _e27 = _naga_trigonometry(as_type<uint>(0.0), 1u);
    local_2 = static_cast<uint>(2);
    uint _e33 = local_2;
    out[_e33] = as_type<uint>(as_type<float>(_e27));
    uint _e39 = _naga_trigonometry(as_type<uint>(-(0.0)), 1u);
    local_3 = static_cast<uint>(3);
    uint _e45 = local_3;
    out[_e45] = as_type<uint>(as_type<float>(_e39));
    float _e49 = sine_value(static_cast<float>(0));
    local_4 = static_cast<uint>(4);
    uint _e54 = local_4;
    out[_e54] = as_type<uint>(_e49);
    float _e58 = cosine_value(static_cast<float>(0u));
    local_5 = static_cast<uint>(5);
    uint _e63 = local_5;
    out[_e63] = as_type<uint>(_e58);
    int _e66 = sinf(true);
    local_6 = static_cast<uint>(6);
    uint _e71 = local_6;
    out[_e71] = static_cast<uint>(_e66);
    int _e74 = sinf(false);
    local_7 = static_cast<uint>(7);
    uint _e79 = local_7;
    out[_e79] = static_cast<uint>(_e74);
    int _e82 = cosf(4);
    local_8 = static_cast<uint>(8);
    uint _e87 = local_8;
    out[_e87] = static_cast<uint>(_e82);
    uint _e92 = _naga_trigonometry(as_type<uint>(0.0), 1u);
    local_9 = static_cast<uint>(9);
    uint _e98 = local_9;
    out[_e98] = as_type<uint>(as_type<float>(_e92));
    float _e102 = sinf_1(2.0, 3.0);
    local_10 = static_cast<uint>(10);
    uint _e107 = local_10;
    out[_e107] = as_type<uint>(_e102);
    float _e112 = cosf_1(metal::float2(2.0, 3.0));
    local_11 = static_cast<uint>(11);
    uint _e117 = local_11;
    out[_e117] = as_type<uint>(_e112);
    value = 0.0;
    float _e121 = value;
    value = _e121 + static_cast<float>(1);
    uint _e127 = _naga_trigonometry(as_type<uint>(_e121), 0u);
    local_12 = static_cast<uint>(12);
    uint _e133 = local_12;
    out[_e133] = as_type<uint>(as_type<float>(_e127));
    float _e135 = value;
    local_13 = static_cast<uint>(13);
    uint _e140 = local_13;
    out[_e140] = as_type<uint>(_e135);
    value = -(1.0);
    float _e144 = value;
    value = _e144 + static_cast<float>(1);
    float _e148 = value;
    uint _e151 = _naga_trigonometry(as_type<uint>(_e148), 1u);
    local_14 = static_cast<uint>(14);
    uint _e157 = local_14;
    out[_e157] = as_type<uint>(as_type<float>(_e151));
    float _e159 = value;
    local_15 = static_cast<uint>(15);
    uint _e164 = local_15;
    out[_e164] = as_type<uint>(_e159);
    float _e166 = value;
    value = _e166 + static_cast<float>(1);
    float _e170 = identity(_e166);
    uint _e173 = _naga_trigonometry(as_type<uint>(_e170), 0u);
    float _e175 = value;
    value = _e175 + static_cast<float>(1);
    float _e179 = pair(as_type<float>(_e173), _e175);
    local_16 = static_cast<uint>(16);
    uint _e184 = local_16;
    out[_e184] = as_type<uint>(_e179);
    float _e186 = value;
    local_17 = static_cast<uint>(17);
    uint _e191 = local_17;
    out[_e191] = as_type<uint>(_e186);
    choose = false;
    counter = 0;
    bool _e197 = choose;
    local_19 = _e197;
    if (_e197) {
        int _e199 = counter;
        counter = as_type<int>(as_type<uint>(_e199) + as_type<uint>(1));
        uint _e205 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e199)), 0u);
        local_19 = as_type<float>(_e205) != 0.0;
    }
    bool _e209 = local_19;
    local_18 = static_cast<uint>(18);
    uint _e214 = local_18;
    out[_e214] = static_cast<uint>(_e209);
    local_21 = true;
    if (true) {
    } else {
        int _e218 = counter;
        counter = as_type<int>(as_type<uint>(_e218) + as_type<uint>(1));
        uint _e224 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e218)), 1u);
        local_21 = as_type<float>(_e224) != 0.0;
    }
    bool _e228 = local_21;
    local_20 = static_cast<uint>(19);
    uint _e233 = local_20;
    out[_e233] = static_cast<uint>(_e228);
    bool _e235 = choose;
    if (_e235) {
        int _e236 = counter;
        counter = as_type<int>(as_type<uint>(_e236) + as_type<uint>(1));
        int _e239 = counter;
        uint _e243 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e239)), 0u);
        local_23 = as_type<float>(_e243);
    } else {
        int _e246 = counter;
        uint _e250 = _naga_trigonometry(as_type<uint>(static_cast<float>(_e246)), 1u);
        local_23 = as_type<float>(_e250);
    }
    float _e254 = local_23;
    local_22 = static_cast<uint>(20);
    uint _e259 = local_22;
    out[_e259] = naga_f2u32(_e254);
    int _e261 = counter;
    local_24 = static_cast<uint>(21);
    uint _e266 = local_24;
    out[_e266] = static_cast<uint>(_e261);
    uint _e273 = _naga_trigonometry(as_type<uint>(0.0), 0u);
    values.inner[0] = as_type<float>(_e273);
    uint _e279 = _naga_trigonometry(as_type<uint>(0.0), 1u);
    values.inner[1] = as_type<float>(_e279);
    float _e285 = values.inner[0];
    float _e286 = values.inner[1];
    local_25 = static_cast<uint>(22);
    uint _e292 = local_25;
    out[_e292] = as_type<uint>(_e285 + _e286);
    Count = 2;
    scratch = type_11 {};
    float _e300 = scratch.inner[1];
    local_26 = static_cast<uint>(23);
    uint _e305 = local_26;
    out[_e305] = as_type<uint>(_e300);
    repeated = 0;
    {
        index = 0;
        uint2 loop_bound_12 = uint2(4294967295u);
        bool loop_init_12 = true;
        while(true) {
            if (metal::all(loop_bound_12 == uint2(0u))) { break; }
            loop_bound_12 -= uint2(loop_bound_12.y == 0u, 1u);
            if (!loop_init_12) {
                int _e325 = index;
                index = as_type<int>(as_type<uint>(_e325) + as_type<uint>(1));
            }
            loop_init_12 = false;
            int _e311 = index;
            if (_e311 < 3) {
            } else {
                break;
            }
            int _e314 = index;
            if (_e314 == 0) {
                continue;
            }
            uint _e320 = _naga_trigonometry(as_type<uint>(0.0), 1u);
            int _e323 = repeated;
            repeated = as_type<int>(as_type<uint>(_e323) + as_type<uint>(naga_f2i32(as_type<float>(_e320))));
        }
    }
    int _e328 = repeated;
    local_27 = static_cast<uint>(24);
    uint _e333 = local_27;
    out[_e333] = static_cast<uint>(_e328);
    value = 0.0;
    float _e336 = value;
    value = _e336 + static_cast<float>(1);
    uint _e342 = _naga_trigonometry(as_type<uint>(_e336), 0u);
    float _e343 = value;
    value = _e343 - static_cast<float>(1);
    float _e347 = value;
    uint _e350 = _naga_trigonometry(as_type<uint>(_e347), 1u);
    local_28 = static_cast<uint>(25);
    uint _e356 = local_28;
    out[_e356] = as_type<uint>(as_type<float>(_e350));
    float _e358 = value;
    local_29 = static_cast<uint>(26);
    uint _e363 = local_29;
    out[_e363] = as_type<uint>(_e358);
    if (true) {
        uint _e369 = _naga_trigonometry(as_type<uint>(0.0), 1u);
        local_31 = as_type<float>(_e369);
    } else {
        uint _e375 = _naga_trigonometry(as_type<uint>(99.0), 0u);
        local_31 = as_type<float>(_e375);
    }
    float _e379 = local_31;
    local_30 = static_cast<uint>(27);
    uint _e384 = local_30;
    out[_e384] = naga_f2u32(_e379);
    float _e388 = cosine_value(static_cast<float>(false));
    local_32 = static_cast<uint>(28);
    uint _e393 = local_32;
    out[_e393] = as_type<uint>(_e388);
}
