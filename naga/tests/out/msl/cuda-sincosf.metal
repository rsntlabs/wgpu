// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef float type_1[1];
struct type_4 {
    uint inner[12];
};
struct type_5 {
    uint inner[22];
};
struct type_6 {
    uint inner[24];
};
struct type_7 {
    uint inner[2];
};
struct type_8 {
    uint inner[20];
};

type_4 _naga_trig_multiply(
    type_4 left,
    type_4 right
) {
    type_4 left_digits = type_4 {};
    type_4 right_digits = type_4 {};
    type_6 product = type_6 {};
    uint carry = uint {};
    uint left_index = uint {};
    uint right_index = uint {};
    type_4 result = type_4 {};
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
    type_4 _e65 = result;
    return _e65;
}

type_5 _naga_trig_reduce_multiply(
    type_7 left_1,
    type_8 right_1
) {
    type_7 left_digits_1 = type_7 {};
    type_8 right_digits_1 = type_8 {};
    type_5 product_1 = type_5 {};
    uint carry_1 = uint {};
    uint left_index_1 = uint {};
    uint right_index_1 = uint {};
    type_5 result_1 = type_5 {};
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
    type_5 _e65 = result_1;
    return _e65;
}

uint naga_div(uint lhs, uint rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

type_4 _naga_trig_divide(
    type_4 value_1,
    uint divisor
) {
    type_4 source = type_4 {};
    type_4 result_2 = type_4 {};
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
    type_4 _e28 = result_2;
    return _e28;
}

type_4 _naga_trig_combine(
    type_4 left_2,
    type_4 right_2,
    uint subtract
) {
    type_4 left_digits_2 = type_4 {};
    type_4 right_digits_2 = type_4 {};
    type_4 result_3 = type_4 {};
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
    type_4 _e41 = result_3;
    return _e41;
}

uint _naga_trig_extract_product(
    type_5 digits,
    uint offset
) {
    type_5 source_1 = type_5 {};
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
    type_4 digits_1,
    uint offset_1
) {
    type_4 source_2 = type_4 {};
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

type_4 _naga_trig_kernel(
    type_4 angle,
    uint sine_1
) {
    type_4 term = type_4 {};
    type_4 total = type_4 {};
    uint step_1 = uint {};
    bool _e7 = sine_1 != 0u;
    if (_e7) {
        term = angle;
    } else {
        term = type_4 {{0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u}};
    }
    type_4 _e21 = term;
    total = _e21;
    type_4 _e22 = _naga_trig_multiply(angle, angle);
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
        type_4 _e39 = term;
        type_4 _e40 = _naga_trig_multiply(_e39, _e22);
        type_4 _e41 = _naga_trig_divide(_e40, _e32 * (_e7 ? (_e32 + 1u) : (_e32 - 1u)));
        term = _e41;
        type_4 _e42 = total;
        type_4 _e45 = _naga_trig_combine(_e42, _e41, _e30 & 1u);
        total = _e45;
    }
    type_4 _e49 = total;
    return _e49;
}

uint _naga_trig_round(
    type_4 digits_2
) {
    type_4 source_3 = type_4 {};
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
    uint cosine_1
) {
    uint quadrant = uint {};
    type_4 fraction = type_4 {};
    uint fraction_index = uint {};
    uint _e3 = input_bits & 2147483647u;
    if (_e3 >= 2139095040u) {
        return 2143289344u;
    }
    bool _e8 = cosine_1 != 0u;
    if (_e3 <= 956301312u) {
        return (cosine_1 * 1065353216u) | ((1u - cosine_1) * input_bits);
    }
    uint _e20 = 470u - (_e3 >> 23u);
    uint _e24 = (_e3 & 8388607u) | 8388608u;
    type_5 _e51 = _naga_trig_reduce_multiply(type_7 {{_e24 & 65535u, _e24 >> 16u}}, type_8 {{53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u}});
    uint _e54 = _naga_trig_extract_product(_e51, _e20);
    quadrant = _e54 & 3u;
    fraction_index = 0u;
    uint2 loop_bound_11 = uint2(4294967295u);
    bool loop_init_11 = true;
    while(true) {
        if (metal::all(loop_bound_11 == uint2(0u))) { break; }
        loop_bound_11 -= uint2(loop_bound_11.y == 0u, 1u);
        if (!loop_init_11) {
            uint _e72 = fraction_index;
            fraction_index = _e72 + 1u;
        }
        loop_init_11 = false;
        uint _e64 = fraction_index;
        if (_e64 >= 11u) {
            break;
        }
        uint _e70 = _naga_trig_extract_product(_e51, (_e20 - 176u) + (_e64 * 16u));
        fraction.inner[_e64] = _e70;
    }
    uint _e77 = fraction.inner[10u];
    bool _e79 = _e77 >= 32768u;
    if (_e79) {
        uint _e93 = quadrant;
        quadrant = (_e93 + 1u) & 3u;
        type_4 _e98 = fraction;
        type_4 _e100 = _naga_trig_combine(type_4 {{0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u}}, _e98, 1u);
        fraction = _e100;
    }
    type_4 _e101 = fraction;
    type_4 _e115 = _naga_trig_multiply(_e101, type_4 {{5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u}});
    uint _e116 = quadrant;
    bool _e119 = (_e116 & 1u) == cosine_1;
    type_4 _e123 = _naga_trig_kernel(_e115, _e119 ? 1u : 0u);
    uint _e124 = _naga_trig_round(_e123);
    return _e124 | ((((_e79 && _e119) ? 2147483648u : 0u) ^ (((_e8 ? (_e116 + 1u) : _e116) & 2u) << 30u)) ^ (_e8 ? 0u : (input_bits & 2147483648u)));
}

struct paired_trigInput {
};
kernel void paired_trig(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& input [[buffer(0)]]
, device type_1& output [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    float value = {};
    float sine = {};
    float cosine = {};
    uint local = {};
    uint cursor = {};
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
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 16u);
    float _e8 = input[lane];
    value = _e8;
    float _e10 = value;
    uint _e13 = _naga_trigonometry(as_type<uint>(_e10), 0u);
    uint _e17 = _naga_trigonometry(as_type<uint>(_e10), 1u);
    sine = as_type<float>(_e13);
    cosine = as_type<float>(_e17);
    float _e21 = sine;
    output[base] = _e21;
    float _e24 = cosine;
    local = static_cast<uint>(base + 1u);
    uint _e29 = local;
    output[_e29] = _e24;
    cursor = base + 2u;
    float _e34 = value;
    value = _e34 + static_cast<float>(1);
    uint _e38 = cursor;
    cursor = _e38 + static_cast<uint>(1);
    uint _e42 = cursor;
    cursor = _e42 + static_cast<uint>(1);
    uint _e48 = _naga_trigonometry(as_type<uint>(_e34), 0u);
    uint _e52 = _naga_trigonometry(as_type<uint>(_e34), 1u);
    output[_e38] = as_type<float>(_e48);
    output[_e42] = as_type<float>(_e52);
    uint _e56 = cursor;
    local_1 = static_cast<uint>(base + 4u);
    uint _e62 = local_1;
    output[_e62] = static_cast<float>(_e56);
    float _e64 = value;
    local_2 = static_cast<uint>(base + 5u);
    uint _e69 = local_2;
    output[_e69] = _e64;
    uint _e74 = _naga_trigonometry(as_type<uint>(0.0), 0u);
    uint _e78 = _naga_trigonometry(as_type<uint>(0.0), 1u);
    sine = as_type<float>(_e74);
    sine = as_type<float>(_e78);
    float _e80 = sine;
    local_3 = static_cast<uint>(base + 6u);
    uint _e85 = local_3;
    output[_e85] = _e80;
    float _e87 = cosine;
    local_4 = static_cast<uint>(base + 7u);
    uint _e92 = local_4;
    output[_e92] = _e87;
    float _e95 = input[lane];
    value = _e95;
    float _e96 = value;
    uint _e97 = as_type<uint>(_e96);
    uint _e104 = ((_e97 & 2139095040u) == 0u) ? (_e97 & 2147483648u) : _e97;
    uint _e106 = _naga_trigonometry(_e104, 0u);
    uint _e108 = _naga_trigonometry(_e104, 1u);
    sine = as_type<float>(((_e106 & 2139095040u) == 0u) ? (_e106 & 2147483648u) : _e106);
    cosine = as_type<float>(((_e108 & 2139095040u) == 0u) ? (_e108 & 2147483648u) : _e108);
    float _e125 = sine;
    local_5 = static_cast<uint>(base + 8u);
    uint _e130 = local_5;
    output[_e130] = _e125;
    float _e132 = cosine;
    local_6 = static_cast<uint>(base + 9u);
    uint _e137 = local_6;
    output[_e137] = _e132;
    cursor = base + 10u;
    float _e141 = value;
    value = _e141 + static_cast<float>(1);
    uint _e145 = cursor;
    cursor = _e145 + static_cast<uint>(1);
    uint _e149 = cursor;
    cursor = _e149 + static_cast<uint>(1);
    uint _e153 = as_type<uint>(_e141);
    uint _e160 = ((_e153 & 2139095040u) == 0u) ? (_e153 & 2147483648u) : _e153;
    uint _e162 = _naga_trigonometry(_e160, 0u);
    uint _e164 = _naga_trigonometry(_e160, 1u);
    output[_e145] = as_type<float>(((_e162 & 2139095040u) == 0u) ? (_e162 & 2147483648u) : _e162);
    output[_e149] = as_type<float>(((_e164 & 2139095040u) == 0u) ? (_e164 & 2147483648u) : _e164);
    uint _e183 = cursor;
    local_7 = static_cast<uint>(base + 12u);
    uint _e189 = local_7;
    output[_e189] = static_cast<float>(_e183);
    float _e191 = value;
    local_8 = static_cast<uint>(base + 13u);
    uint _e196 = local_8;
    output[_e196] = _e191;
    float _e199 = input[lane];
    uint _e200 = as_type<uint>(_e199);
    uint _e207 = ((_e200 & 2139095040u) == 0u) ? (_e200 & 2147483648u) : _e200;
    uint _e209 = _naga_trigonometry(_e207, 0u);
    uint _e211 = _naga_trigonometry(_e207, 1u);
    sine = as_type<float>(((_e209 & 2139095040u) == 0u) ? (_e209 & 2147483648u) : _e209);
    sine = as_type<float>(((_e211 & 2139095040u) == 0u) ? (_e211 & 2147483648u) : _e211);
    float _e228 = sine;
    local_9 = static_cast<uint>(base + 14u);
    uint _e233 = local_9;
    output[_e233] = _e228;
    float _e235 = cosine;
    local_10 = static_cast<uint>(base + 15u);
    uint _e240 = local_10;
    output[_e240] = _e235;
}
