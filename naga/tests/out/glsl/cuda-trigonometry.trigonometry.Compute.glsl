#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_10_block_0Compute { uint _group_0_binding_0_cs[]; };


uint[12] _naga_trig_multiply(uint left[12], uint right[12]) {
    uint left_digits[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint right_digits[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint product[24] = uint[24](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint carry = 0u;
    uint left_index = 0u;
    uint right_index = 0u;
    uint result[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint result_index = 0u;
    left_digits = left;
    right_digits = right;
    left_index = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e46 = left_index;
            left_index = (_e46 + 1u);
        }
        loop_init = false;
        uint _e13 = left_index;
        if ((_e13 >= 12u)) {
            break;
        }
        carry = 0u;
        uint _e18 = left_digits[_e13];
        right_index = 0u;
        bool loop_init_1 = true;
        while(true) {
            if (!loop_init_1) {
                uint _e39 = right_index;
                right_index = (_e39 + 1u);
            }
            loop_init_1 = false;
            uint _e22 = right_index;
            if ((_e22 >= 12u)) {
                break;
            }
            uint _e26 = right_digits[_e22];
            uint _e27 = (_e13 + _e22);
            uint _e29 = product[_e27];
            uint _e30 = carry;
            uint _e33 = (((_e18 * _e26) + _e29) + _e30);
            product[_e27] = (_e33 & 65535u);
            carry = (_e33 >> 16u);
        }
        uint _e44 = carry;
        product[(_e13 + 12u)] = _e44;
    }
    result_index = 0u;
    bool loop_init_2 = true;
    while(true) {
        if (!loop_init_2) {
            uint _e62 = result_index;
            result_index = (_e62 + 1u);
        }
        loop_init_2 = false;
        uint _e54 = result_index;
        if ((_e54 >= 12u)) {
            break;
        }
        uint _e60 = product[(_e54 + 11u)];
        result[_e54] = _e60;
    }
    uint _e65[12] = result;
    return _e65;
}

uint[22] _naga_trig_reduce_multiply(uint left_1[2], uint right_1[20]) {
    uint left_digits_1[2] = uint[2](0u, 0u);
    uint right_digits_1[20] = uint[20](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint product_1[22] = uint[22](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint carry_1 = 0u;
    uint left_index_1 = 0u;
    uint right_index_1 = 0u;
    uint result_1[22] = uint[22](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint result_index_1 = 0u;
    left_digits_1 = left_1;
    right_digits_1 = right_1;
    left_index_1 = 0u;
    bool loop_init_3 = true;
    while(true) {
        if (!loop_init_3) {
            uint _e46 = left_index_1;
            left_index_1 = (_e46 + 1u);
        }
        loop_init_3 = false;
        uint _e13 = left_index_1;
        if ((_e13 >= 2u)) {
            break;
        }
        carry_1 = 0u;
        uint _e18 = left_digits_1[_e13];
        right_index_1 = 0u;
        bool loop_init_4 = true;
        while(true) {
            if (!loop_init_4) {
                uint _e39 = right_index_1;
                right_index_1 = (_e39 + 1u);
            }
            loop_init_4 = false;
            uint _e22 = right_index_1;
            if ((_e22 >= 20u)) {
                break;
            }
            uint _e26 = right_digits_1[_e22];
            uint _e27 = (_e13 + _e22);
            uint _e29 = product_1[_e27];
            uint _e30 = carry_1;
            uint _e33 = (((_e18 * _e26) + _e29) + _e30);
            product_1[_e27] = (_e33 & 65535u);
            carry_1 = (_e33 >> 16u);
        }
        uint _e44 = carry_1;
        product_1[(_e13 + 20u)] = _e44;
    }
    result_index_1 = 0u;
    bool loop_init_5 = true;
    while(true) {
        if (!loop_init_5) {
            uint _e62 = result_index_1;
            result_index_1 = (_e62 + 1u);
        }
        loop_init_5 = false;
        uint _e54 = result_index_1;
        if ((_e54 >= 22u)) {
            break;
        }
        uint _e60 = product_1[(_e54 + 0u)];
        result_1[_e54] = _e60;
    }
    uint _e65[22] = result_1;
    return _e65;
}

uint[12] _naga_trig_divide(uint value_1[12], uint divisor) {
    uint source[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint result_2[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint remainder = 0u;
    uint step_ = 0u;
    source = value_1;
    step_ = 0u;
    bool loop_init_6 = true;
    while(true) {
        if (!loop_init_6) {
            uint _e25 = step_;
            step_ = (_e25 + 1u);
        }
        loop_init_6 = false;
        uint _e11 = step_;
        if ((_e11 >= 12u)) {
            break;
        }
        uint _e15 = (11u - _e11);
        uint _e16 = remainder;
        uint _e20 = source[_e15];
        uint _e21 = ((_e16 << 16u) | _e20);
        result_2[_e15] = (_e21 / divisor);
        remainder = (_e21 - divisor * (_e21 / divisor));
    }
    uint _e28[12] = result_2;
    return _e28;
}

uint[12] _naga_trig_combine(uint left_2[12], uint right_2[12], uint subtract) {
    uint left_digits_2[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint right_digits_2[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint result_3[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint carry_2 = 0u;
    uint digit_index = 0u;
    left_digits_2 = left_2;
    right_digits_2 = right_2;
    bool _e12 = (subtract != 0u);
    digit_index = 0u;
    bool loop_init_7 = true;
    while(true) {
        if (!loop_init_7) {
            uint _e38 = digit_index;
            digit_index = (_e38 + 1u);
        }
        loop_init_7 = false;
        uint _e16 = digit_index;
        if ((_e16 >= 12u)) {
            break;
        }
        uint _e20 = left_digits_2[_e16];
        uint _e22 = right_digits_2[_e16];
        uint _e23 = carry_2;
        uint _e24 = (_e22 + _e23);
        uint _e26 = (_e20 + _e24);
        result_3[_e16] = ((_e12 ? (_e20 - _e24) : _e26) & 65535u);
        carry_2 = (_e12 ? ((_e20 < _e24) ? 1u : 0u) : (_e26 >> 16u));
    }
    uint _e41[12] = result_3;
    return _e41;
}

uint _naga_trig_extract_product(uint digits[22], uint offset) {
    uint source_1[22] = uint[22](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint low = 0u;
    uint high = 0u;
    source_1 = digits;
    uint _e5 = (offset / 16u);
    uint _e7 = (offset - 16u * (offset / 16u));
    uint _e13 = (_e5 + 0u);
    if ((_e13 < 22u)) {
        uint _e17 = source_1[_e13];
        low = _e17;
    }
    uint _e19 = (_e5 + 1u);
    if ((_e19 < 22u)) {
        uint _e23 = source_1[_e19];
        high = _e23;
    }
    uint _e24 = low;
    uint _e25 = high;
    return (((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u);
}

uint _naga_trig_extract_fixed(uint digits_1[12], uint offset_1) {
    uint source_2[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint low_1 = 0u;
    uint high_1 = 0u;
    source_2 = digits_1;
    uint _e5 = (offset_1 / 16u);
    uint _e7 = (offset_1 - 16u * (offset_1 / 16u));
    uint _e13 = (_e5 + 0u);
    if ((_e13 < 12u)) {
        uint _e17 = source_2[_e13];
        low_1 = _e17;
    }
    uint _e19 = (_e5 + 1u);
    if ((_e19 < 12u)) {
        uint _e23 = source_2[_e19];
        high_1 = _e23;
    }
    uint _e24 = low_1;
    uint _e25 = high_1;
    return (((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u);
}

uint[12] _naga_trig_kernel(uint angle[12], uint sine) {
    uint term[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint total[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint step_1 = 0u;
    bool _e7 = (sine != 0u);
    if (_e7) {
        term = angle;
    } else {
        term = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u);
    }
    uint _e21[12] = term;
    total = _e21;
    uint _e22[12] = _naga_trig_multiply(angle, angle);
    step_1 = 0u;
    bool loop_init_8 = true;
    while(true) {
        if (!loop_init_8) {
            uint _e46 = step_1;
            step_1 = (_e46 + 1u);
        }
        loop_init_8 = false;
        uint _e26 = step_1;
        if ((_e26 >= 8u)) {
            break;
        }
        uint _e30 = (_e26 + 1u);
        uint _e32 = (_e30 * 2u);
        uint _e39[12] = term;
        uint _e40[12] = _naga_trig_multiply(_e39, _e22);
        uint _e41[12] = _naga_trig_divide(_e40, (_e32 * (_e7 ? (_e32 + 1u) : (_e32 - 1u))));
        term = _e41;
        uint _e42[12] = total;
        uint _e45[12] = _naga_trig_combine(_e42, _e41, (_e30 & 1u));
        total = _e45;
    }
    uint _e49[12] = total;
    return _e49;
}

uint _naga_trig_round(uint digits_2[12]) {
    uint source_3[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint highest_bit = 0u;
    uint nonzero = 0u;
    uint digit_index_1 = 0u;
    uint sticky = 0u;
    uint sticky_index = 0u;
    source_3 = digits_2;
    digit_index_1 = 0u;
    bool loop_init_9 = true;
    while(true) {
        if (!loop_init_9) {
            uint _e25 = digit_index_1;
            digit_index_1 = (_e25 + 1u);
        }
        loop_init_9 = false;
        uint _e10 = digit_index_1;
        if ((_e10 >= 12u)) {
            break;
        }
        uint _e14 = source_3[_e10];
        uint _e15 = nonzero;
        nonzero = (_e15 | _e14);
        if ((_e14 != 0u)) {
            highest_bit = ((_e10 * 16u) + (31u - uint(31 - findMSB(_e14))));
        }
    }
    uint _e28 = nonzero;
    if ((_e28 == 0u)) {
        return 0u;
    }
    uint _e32 = highest_bit;
    uint _e38 = ((_e32 >= 50u) ? (_e32 - 23u) : 27u);
    uint _e39 = _naga_trig_extract_fixed(digits_2, _e38);
    uint _e42 = _naga_trig_extract_fixed(digits_2, (_e38 + 16u));
    uint _e45 = (_e39 | (_e42 << 16u));
    uint _e47 = (_e38 - 1u);
    uint _e48 = _naga_trig_extract_fixed(digits_2, _e47);
    uint _e54 = (_e47 / 16u);
    sticky_index = 0u;
    bool loop_init_10 = true;
    while(true) {
        if (!loop_init_10) {
            uint _e80 = sticky_index;
            sticky_index = (_e80 + 1u);
        }
        loop_init_10 = false;
        uint _e66 = sticky_index;
        if ((_e66 >= 12u)) {
            break;
        }
        uint _e76 = source_3[_e66];
        uint _e78 = sticky;
        sticky = (_e78 | (_e76 & ((_e66 < _e54) ? 65535u : ((_e66 == _e54) ? ((1u << (_e47 - 16u * (_e47 / 16u))) - 1u) : 0u))));
    }
    uint _e83 = sticky;
    uint _e93 = (_e45 + ((((_e48 & 1u) != 0u) && ((_e83 | (_e45 & 1u)) != 0u)) ? 1u : 0u));
    if ((_e32 < 50u)) {
        return _e93;
    }
    bool _e97 = (_e93 == 16777216u);
    uint _e102 = (_e32 - 49u);
    return (((_e97 ? (_e102 + 1u) : _e102) << 23u) | ((_e97 ? (_e93 >> 1u) : _e93) & 8388607u));
}

uint _naga_trigonometry(uint input_bits, uint cosine) {
    uint quadrant = 0u;
    uint fraction[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint fraction_index = 0u;
    uint _e3 = (input_bits & 2147483647u);
    if ((_e3 >= 2139095040u)) {
        return 2143289344u;
    }
    bool _e8 = (cosine != 0u);
    if ((_e3 <= 956301312u)) {
        return (_e8 ? 1065353216u : input_bits);
    }
    uint _e16 = (470u - (_e3 >> 23u));
    uint _e20 = ((_e3 & 8388607u) | 8388608u);
    uint _e47[22] = _naga_trig_reduce_multiply(uint[2]((_e20 & 65535u), (_e20 >> 16u)), uint[20](53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    uint _e50 = _naga_trig_extract_product(_e47, _e16);
    quadrant = (_e50 & 3u);
    fraction_index = 0u;
    bool loop_init_11 = true;
    while(true) {
        if (!loop_init_11) {
            uint _e68 = fraction_index;
            fraction_index = (_e68 + 1u);
        }
        loop_init_11 = false;
        uint _e60 = fraction_index;
        if ((_e60 >= 11u)) {
            break;
        }
        uint _e66 = _naga_trig_extract_product(_e47, ((_e16 - 176u) + (_e60 * 16u)));
        fraction[_e60] = _e66;
    }
    uint _e73 = fraction[10u];
    bool _e75 = (_e73 >= 32768u);
    if (_e75) {
        uint _e89 = quadrant;
        quadrant = ((_e89 + 1u) & 3u);
        uint _e94[12] = fraction;
        uint _e96[12] = _naga_trig_combine(uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u), _e94, 1u);
        fraction = _e96;
    }
    uint _e97[12] = fraction;
    uint _e111[12] = _naga_trig_multiply(_e97, uint[12](5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u));
    uint _e112 = quadrant;
    bool _e115 = ((_e112 & 1u) == cosine);
    uint _e119[12] = _naga_trig_kernel(_e111, (_e115 ? 1u : 0u));
    uint _e120 = _naga_trig_round(_e119);
    return (_e120 | ((((_e75 && _e115) ? 2147483648u : 0u) ^ (((_e8 ? (_e112 + 1u) : _e112) & 2u) << 30u)) ^ (_e8 ? 0u : (input_bits & 2147483648u))));
}

float sine_value(float value_2) {
    uint _e3 = _naga_trigonometry(floatBitsToUint(value_2), 0u);
    return uintBitsToFloat(_e3);
}

float cosine_value(float value_3) {
    uint _e3 = _naga_trigonometry(floatBitsToUint(value_3), 1u);
    return uintBitsToFloat(_e3);
}

int sinf(bool value_4) {
    int local_149 = 0;
    if (value_4) {
        local_149 = 17;
    } else {
        local_149 = 19;
    }
    int _e6 = local_149;
    return _e6;
}

int cosf(int value_5) {
    return (value_5 + 23);
}

float sinf_1(float first, float second) {
    return (first + second);
}

float cosf_1(vec2 value_6) {
    vec2 value_7 = vec2(0.0);
    value_7 = value_6;
    float _e4 = value_7.x;
    float _e5 = value_7.y;
    return (_e4 + _e5);
}

float identity(float value_8) {
    return value_8;
}

float pair(float first_1, float second_1) {
    return ((first_1 * 10.0) + second_1);
}

void main() {
    uint out_[2] = uint[2](0u, 0u);
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    uint local_14[2] = uint[2](0u, 0u);
    uint local_15 = 0u;
    uint local_16[2] = uint[2](0u, 0u);
    uint local_17 = 0u;
    uint local_18[2] = uint[2](0u, 0u);
    uint local_19 = 0u;
    uint local_20[2] = uint[2](0u, 0u);
    uint local_21 = 0u;
    uint local_22[2] = uint[2](0u, 0u);
    uint local_23 = 0u;
    float value = 0.0;
    uint local_24[2] = uint[2](0u, 0u);
    uint local_25 = 0u;
    uint local_26[2] = uint[2](0u, 0u);
    uint local_27 = 0u;
    uint local_28[2] = uint[2](0u, 0u);
    uint local_29 = 0u;
    uint local_30[2] = uint[2](0u, 0u);
    uint local_31 = 0u;
    uint local_32[2] = uint[2](0u, 0u);
    uint local_33 = 0u;
    uint local_34[2] = uint[2](0u, 0u);
    uint local_35 = 0u;
    bool choose = false;
    int counter = 0;
    uint local_36[2] = uint[2](0u, 0u);
    uint local_37 = 0u;
    bool local_38 = false;
    uint local_39[2] = uint[2](0u, 0u);
    uint local_40 = 0u;
    bool local_41 = false;
    uint local_42[2] = uint[2](0u, 0u);
    uint local_43 = 0u;
    float local_44 = 0.0;
    uint local_45[2] = uint[2](0u, 0u);
    uint local_46 = 0u;
    float values[2] = float[2](0.0, 0.0);
    uint local_47[2] = uint[2](0u, 0u);
    uint local_48 = 0u;
    int Count = 0;
    float scratch[2] = float[2](0.0, 0.0);
    uint local_49[2] = uint[2](0u, 0u);
    uint local_50 = 0u;
    int repeated = 0;
    int index = 0;
    uint local_51[2] = uint[2](0u, 0u);
    uint local_52 = 0u;
    uint local_53[2] = uint[2](0u, 0u);
    uint local_54 = 0u;
    uint local_55[2] = uint[2](0u, 0u);
    uint local_56 = 0u;
    uint local_57[2] = uint[2](0u, 0u);
    uint local_58 = 0u;
    float local_59 = 0.0;
    uint local_60[2] = uint[2](0u, 0u);
    uint local_61 = 0u;
    uint local_62[2] = uint[2](0u, 0u);
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65[2] = uint[2](0u, 0u);
    uint local_66 = 0u;
    uint local_67 = 0u;
    uint local_68[2] = uint[2](0u, 0u);
    uint local_69 = 0u;
    uint local_70 = 0u;
    uint local_71[2] = uint[2](0u, 0u);
    uint local_72 = 0u;
    uint local_73 = 0u;
    uint local_74[2] = uint[2](0u, 0u);
    uint local_75 = 0u;
    uint local_76 = 0u;
    uint local_77[2] = uint[2](0u, 0u);
    uint local_78 = 0u;
    uint local_79 = 0u;
    uint local_80[2] = uint[2](0u, 0u);
    uint local_81 = 0u;
    uint local_82 = 0u;
    uint local_83[2] = uint[2](0u, 0u);
    uint local_84 = 0u;
    uint local_85 = 0u;
    uint local_86[2] = uint[2](0u, 0u);
    uint local_87 = 0u;
    uint local_88 = 0u;
    uint local_89[2] = uint[2](0u, 0u);
    uint local_90 = 0u;
    uint local_91 = 0u;
    uint local_92[2] = uint[2](0u, 0u);
    uint local_93 = 0u;
    uint local_94 = 0u;
    uint local_95[2] = uint[2](0u, 0u);
    uint local_96 = 0u;
    uint local_97 = 0u;
    uint local_98[2] = uint[2](0u, 0u);
    uint local_99 = 0u;
    uint local_100 = 0u;
    uint local_101[2] = uint[2](0u, 0u);
    uint local_102 = 0u;
    uint local_103 = 0u;
    uint local_104[2] = uint[2](0u, 0u);
    uint local_105 = 0u;
    uint local_106 = 0u;
    uint local_107[2] = uint[2](0u, 0u);
    uint local_108 = 0u;
    uint local_109 = 0u;
    uint local_110[2] = uint[2](0u, 0u);
    uint local_111 = 0u;
    uint local_112 = 0u;
    uint local_113[2] = uint[2](0u, 0u);
    uint local_114 = 0u;
    uint local_115 = 0u;
    uint local_116[2] = uint[2](0u, 0u);
    uint local_117 = 0u;
    uint local_118 = 0u;
    uint local_119[2] = uint[2](0u, 0u);
    uint local_120 = 0u;
    uint local_121 = 0u;
    uint local_122[2] = uint[2](0u, 0u);
    uint local_123 = 0u;
    uint local_124 = 0u;
    uint local_125[2] = uint[2](0u, 0u);
    uint local_126 = 0u;
    uint local_127 = 0u;
    uint local_128[2] = uint[2](0u, 0u);
    uint local_129 = 0u;
    uint local_130 = 0u;
    uint local_131[2] = uint[2](0u, 0u);
    uint local_132 = 0u;
    uint local_133 = 0u;
    uint local_134[2] = uint[2](0u, 0u);
    uint local_135 = 0u;
    uint local_136 = 0u;
    uint local_137[2] = uint[2](0u, 0u);
    uint local_138 = 0u;
    uint local_139 = 0u;
    uint local_140[2] = uint[2](0u, 0u);
    uint local_141 = 0u;
    uint local_142 = 0u;
    uint local_143[2] = uint[2](0u, 0u);
    uint local_144 = 0u;
    uint local_145 = 0u;
    uint local_146[2] = uint[2](0u, 0u);
    uint local_147 = 0u;
    uint local_148 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    uint _e10 = _naga_trigonometry(floatBitsToUint(0.0), 0u);
    uint _e15[2] = out_;
    local = _e15;
    local_1 = uint(0);
    uint _e20[2] = local;
    local_62 = _e20;
    uint _e21 = local_1;
    uint _e23 = local_62[1];
    local_62[1] = (_e23 + _e21);
    uint _e27 = local_62[0];
    local_63 = uint(_e27);
    uint _e31 = local_62[1];
    local_64 = uint(_e31);
    uint _e34 = local_64;
    _group_0_binding_0_cs[_e34] = floatBitsToUint(uintBitsToFloat(_e10));
    uint _e40 = _naga_trigonometry(floatBitsToUint(-(0.0)), 0u);
    uint _e44[2] = out_;
    local_2 = _e44;
    local_3 = uint(1);
    uint _e49[2] = local_2;
    local_65 = _e49;
    uint _e50 = local_3;
    uint _e52 = local_65[1];
    local_65[1] = (_e52 + _e50);
    uint _e56 = local_65[0];
    local_66 = uint(_e56);
    uint _e60 = local_65[1];
    local_67 = uint(_e60);
    uint _e63 = local_67;
    _group_0_binding_0_cs[_e63] = floatBitsToUint(uintBitsToFloat(_e40));
    uint _e68 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
    uint _e72[2] = out_;
    local_4 = _e72;
    local_5 = uint(2);
    uint _e77[2] = local_4;
    local_68 = _e77;
    uint _e78 = local_5;
    uint _e80 = local_68[1];
    local_68[1] = (_e80 + _e78);
    uint _e84 = local_68[0];
    local_69 = uint(_e84);
    uint _e88 = local_68[1];
    local_70 = uint(_e88);
    uint _e91 = local_70;
    _group_0_binding_0_cs[_e91] = floatBitsToUint(uintBitsToFloat(_e68));
    uint _e97 = _naga_trigonometry(floatBitsToUint(-(0.0)), 1u);
    uint _e101[2] = out_;
    local_6 = _e101;
    local_7 = uint(3);
    uint _e106[2] = local_6;
    local_71 = _e106;
    uint _e107 = local_7;
    uint _e109 = local_71[1];
    local_71[1] = (_e109 + _e107);
    uint _e113 = local_71[0];
    local_72 = uint(_e113);
    uint _e117 = local_71[1];
    local_73 = uint(_e117);
    uint _e120 = local_73;
    _group_0_binding_0_cs[_e120] = floatBitsToUint(uintBitsToFloat(_e97));
    float _e124 = sine_value(float(0));
    uint _e127[2] = out_;
    local_8 = _e127;
    local_9 = uint(4);
    uint _e132[2] = local_8;
    local_74 = _e132;
    uint _e133 = local_9;
    uint _e135 = local_74[1];
    local_74[1] = (_e135 + _e133);
    uint _e139 = local_74[0];
    local_75 = uint(_e139);
    uint _e143 = local_74[1];
    local_76 = uint(_e143);
    uint _e146 = local_76;
    _group_0_binding_0_cs[_e146] = floatBitsToUint(_e124);
    float _e150 = cosine_value(float(0u));
    uint _e153[2] = out_;
    local_10 = _e153;
    local_11 = uint(5);
    uint _e158[2] = local_10;
    local_77 = _e158;
    uint _e159 = local_11;
    uint _e161 = local_77[1];
    local_77[1] = (_e161 + _e159);
    uint _e165 = local_77[0];
    local_78 = uint(_e165);
    uint _e169 = local_77[1];
    local_79 = uint(_e169);
    uint _e172 = local_79;
    _group_0_binding_0_cs[_e172] = floatBitsToUint(_e150);
    int _e175 = sinf(true);
    uint _e178[2] = out_;
    local_12 = _e178;
    local_13 = uint(6);
    uint _e183[2] = local_12;
    local_80 = _e183;
    uint _e184 = local_13;
    uint _e186 = local_80[1];
    local_80[1] = (_e186 + _e184);
    uint _e190 = local_80[0];
    local_81 = uint(_e190);
    uint _e194 = local_80[1];
    local_82 = uint(_e194);
    uint _e197 = local_82;
    _group_0_binding_0_cs[_e197] = uint(_e175);
    int _e200 = sinf(false);
    uint _e203[2] = out_;
    local_14 = _e203;
    local_15 = uint(7);
    uint _e208[2] = local_14;
    local_83 = _e208;
    uint _e209 = local_15;
    uint _e211 = local_83[1];
    local_83[1] = (_e211 + _e209);
    uint _e215 = local_83[0];
    local_84 = uint(_e215);
    uint _e219 = local_83[1];
    local_85 = uint(_e219);
    uint _e222 = local_85;
    _group_0_binding_0_cs[_e222] = uint(_e200);
    int _e225 = cosf(4);
    uint _e228[2] = out_;
    local_16 = _e228;
    local_17 = uint(8);
    uint _e233[2] = local_16;
    local_86 = _e233;
    uint _e234 = local_17;
    uint _e236 = local_86[1];
    local_86[1] = (_e236 + _e234);
    uint _e240 = local_86[0];
    local_87 = uint(_e240);
    uint _e244 = local_86[1];
    local_88 = uint(_e244);
    uint _e247 = local_88;
    _group_0_binding_0_cs[_e247] = uint(_e225);
    uint _e252 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
    uint _e256[2] = out_;
    local_18 = _e256;
    local_19 = uint(9);
    uint _e261[2] = local_18;
    local_89 = _e261;
    uint _e262 = local_19;
    uint _e264 = local_89[1];
    local_89[1] = (_e264 + _e262);
    uint _e268 = local_89[0];
    local_90 = uint(_e268);
    uint _e272 = local_89[1];
    local_91 = uint(_e272);
    uint _e275 = local_91;
    _group_0_binding_0_cs[_e275] = floatBitsToUint(uintBitsToFloat(_e252));
    float _e279 = sinf_1(2.0, 3.0);
    uint _e282[2] = out_;
    local_20 = _e282;
    local_21 = uint(10);
    uint _e287[2] = local_20;
    local_92 = _e287;
    uint _e288 = local_21;
    uint _e290 = local_92[1];
    local_92[1] = (_e290 + _e288);
    uint _e294 = local_92[0];
    local_93 = uint(_e294);
    uint _e298 = local_92[1];
    local_94 = uint(_e298);
    uint _e301 = local_94;
    _group_0_binding_0_cs[_e301] = floatBitsToUint(_e279);
    float _e306 = cosf_1(vec2(2.0, 3.0));
    uint _e309[2] = out_;
    local_22 = _e309;
    local_23 = uint(11);
    uint _e314[2] = local_22;
    local_95 = _e314;
    uint _e315 = local_23;
    uint _e317 = local_95[1];
    local_95[1] = (_e317 + _e315);
    uint _e321 = local_95[0];
    local_96 = uint(_e321);
    uint _e325 = local_95[1];
    local_97 = uint(_e325);
    uint _e328 = local_97;
    _group_0_binding_0_cs[_e328] = floatBitsToUint(_e306);
    value = 0.0;
    float _e332 = value;
    value = (_e332 + float(1));
    uint _e338 = _naga_trigonometry(floatBitsToUint(_e332), 0u);
    uint _e342[2] = out_;
    local_24 = _e342;
    local_25 = uint(12);
    uint _e347[2] = local_24;
    local_98 = _e347;
    uint _e348 = local_25;
    uint _e350 = local_98[1];
    local_98[1] = (_e350 + _e348);
    uint _e354 = local_98[0];
    local_99 = uint(_e354);
    uint _e358 = local_98[1];
    local_100 = uint(_e358);
    uint _e361 = local_100;
    _group_0_binding_0_cs[_e361] = floatBitsToUint(uintBitsToFloat(_e338));
    float _e363 = value;
    uint _e366[2] = out_;
    local_26 = _e366;
    local_27 = uint(13);
    uint _e371[2] = local_26;
    local_101 = _e371;
    uint _e372 = local_27;
    uint _e374 = local_101[1];
    local_101[1] = (_e374 + _e372);
    uint _e378 = local_101[0];
    local_102 = uint(_e378);
    uint _e382 = local_101[1];
    local_103 = uint(_e382);
    uint _e385 = local_103;
    _group_0_binding_0_cs[_e385] = floatBitsToUint(_e363);
    value = -(1.0);
    float _e389 = value;
    value = (_e389 + float(1));
    float _e393 = value;
    uint _e396 = _naga_trigonometry(floatBitsToUint(_e393), 1u);
    uint _e400[2] = out_;
    local_28 = _e400;
    local_29 = uint(14);
    uint _e405[2] = local_28;
    local_104 = _e405;
    uint _e406 = local_29;
    uint _e408 = local_104[1];
    local_104[1] = (_e408 + _e406);
    uint _e412 = local_104[0];
    local_105 = uint(_e412);
    uint _e416 = local_104[1];
    local_106 = uint(_e416);
    uint _e419 = local_106;
    _group_0_binding_0_cs[_e419] = floatBitsToUint(uintBitsToFloat(_e396));
    float _e421 = value;
    uint _e424[2] = out_;
    local_30 = _e424;
    local_31 = uint(15);
    uint _e429[2] = local_30;
    local_107 = _e429;
    uint _e430 = local_31;
    uint _e432 = local_107[1];
    local_107[1] = (_e432 + _e430);
    uint _e436 = local_107[0];
    local_108 = uint(_e436);
    uint _e440 = local_107[1];
    local_109 = uint(_e440);
    uint _e443 = local_109;
    _group_0_binding_0_cs[_e443] = floatBitsToUint(_e421);
    float _e445 = value;
    value = (_e445 + float(1));
    float _e449 = identity(_e445);
    uint _e452 = _naga_trigonometry(floatBitsToUint(_e449), 0u);
    float _e454 = value;
    value = (_e454 + float(1));
    float _e458 = pair(uintBitsToFloat(_e452), _e454);
    uint _e461[2] = out_;
    local_32 = _e461;
    local_33 = uint(16);
    uint _e466[2] = local_32;
    local_110 = _e466;
    uint _e467 = local_33;
    uint _e469 = local_110[1];
    local_110[1] = (_e469 + _e467);
    uint _e473 = local_110[0];
    local_111 = uint(_e473);
    uint _e477 = local_110[1];
    local_112 = uint(_e477);
    uint _e480 = local_112;
    _group_0_binding_0_cs[_e480] = floatBitsToUint(_e458);
    float _e482 = value;
    uint _e485[2] = out_;
    local_34 = _e485;
    local_35 = uint(17);
    uint _e490[2] = local_34;
    local_113 = _e490;
    uint _e491 = local_35;
    uint _e493 = local_113[1];
    local_113[1] = (_e493 + _e491);
    uint _e497 = local_113[0];
    local_114 = uint(_e497);
    uint _e501 = local_113[1];
    local_115 = uint(_e501);
    uint _e504 = local_115;
    _group_0_binding_0_cs[_e504] = floatBitsToUint(_e482);
    choose = false;
    counter = 0;
    bool _e510 = choose;
    local_38 = _e510;
    if (_e510) {
        int _e512 = counter;
        counter = (_e512 + 1);
        uint _e518 = _naga_trigonometry(floatBitsToUint(float(_e512)), 0u);
        local_38 = (uintBitsToFloat(_e518) != 0.0);
    }
    bool _e522 = local_38;
    uint _e525[2] = out_;
    local_36 = _e525;
    local_37 = uint(18);
    uint _e530[2] = local_36;
    local_116 = _e530;
    uint _e531 = local_37;
    uint _e533 = local_116[1];
    local_116[1] = (_e533 + _e531);
    uint _e537 = local_116[0];
    local_117 = uint(_e537);
    uint _e541 = local_116[1];
    local_118 = uint(_e541);
    uint _e544 = local_118;
    _group_0_binding_0_cs[_e544] = uint(_e522);
    local_41 = true;
    if (true) {
    } else {
        int _e548 = counter;
        counter = (_e548 + 1);
        uint _e554 = _naga_trigonometry(floatBitsToUint(float(_e548)), 1u);
        local_41 = (uintBitsToFloat(_e554) != 0.0);
    }
    bool _e558 = local_41;
    uint _e561[2] = out_;
    local_39 = _e561;
    local_40 = uint(19);
    uint _e566[2] = local_39;
    local_119 = _e566;
    uint _e567 = local_40;
    uint _e569 = local_119[1];
    local_119[1] = (_e569 + _e567);
    uint _e573 = local_119[0];
    local_120 = uint(_e573);
    uint _e577 = local_119[1];
    local_121 = uint(_e577);
    uint _e580 = local_121;
    _group_0_binding_0_cs[_e580] = uint(_e558);
    bool _e582 = choose;
    if (_e582) {
        int _e583 = counter;
        counter = (_e583 + 1);
        int _e586 = counter;
        uint _e590 = _naga_trigonometry(floatBitsToUint(float(_e586)), 0u);
        local_44 = uintBitsToFloat(_e590);
    } else {
        int _e593 = counter;
        uint _e597 = _naga_trigonometry(floatBitsToUint(float(_e593)), 1u);
        local_44 = uintBitsToFloat(_e597);
    }
    float _e601 = local_44;
    uint _e604[2] = out_;
    local_42 = _e604;
    local_43 = uint(20);
    uint _e609[2] = local_42;
    local_122 = _e609;
    uint _e610 = local_43;
    uint _e612 = local_122[1];
    local_122[1] = (_e612 + _e610);
    uint _e616 = local_122[0];
    local_123 = uint(_e616);
    uint _e620 = local_122[1];
    local_124 = uint(_e620);
    uint _e623 = local_124;
    _group_0_binding_0_cs[_e623] = uint(_e601);
    int _e625 = counter;
    uint _e628[2] = out_;
    local_45 = _e628;
    local_46 = uint(21);
    uint _e633[2] = local_45;
    local_125 = _e633;
    uint _e634 = local_46;
    uint _e636 = local_125[1];
    local_125[1] = (_e636 + _e634);
    uint _e640 = local_125[0];
    local_126 = uint(_e640);
    uint _e644 = local_125[1];
    local_127 = uint(_e644);
    uint _e647 = local_127;
    _group_0_binding_0_cs[_e647] = uint(_e625);
    uint _e654 = _naga_trigonometry(floatBitsToUint(0.0), 0u);
    values[0] = uintBitsToFloat(_e654);
    uint _e660 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
    values[1] = uintBitsToFloat(_e660);
    float _e666 = values[0];
    float _e667 = values[1];
    uint _e671[2] = out_;
    local_47 = _e671;
    local_48 = uint(22);
    uint _e676[2] = local_47;
    local_128 = _e676;
    uint _e677 = local_48;
    uint _e679 = local_128[1];
    local_128[1] = (_e679 + _e677);
    uint _e683 = local_128[0];
    local_129 = uint(_e683);
    uint _e687 = local_128[1];
    local_130 = uint(_e687);
    uint _e690 = local_130;
    _group_0_binding_0_cs[_e690] = floatBitsToUint((_e666 + _e667));
    Count = 2;
    scratch = float[2](0.0, 0.0);
    float _e698 = scratch[1];
    uint _e701[2] = out_;
    local_49 = _e701;
    local_50 = uint(23);
    uint _e706[2] = local_49;
    local_131 = _e706;
    uint _e707 = local_50;
    uint _e709 = local_131[1];
    local_131[1] = (_e709 + _e707);
    uint _e713 = local_131[0];
    local_132 = uint(_e713);
    uint _e717 = local_131[1];
    local_133 = uint(_e717);
    uint _e720 = local_133;
    _group_0_binding_0_cs[_e720] = floatBitsToUint(_e698);
    repeated = 0;
    {
        index = 0;
        bool loop_init_12 = true;
        while(true) {
            if (!loop_init_12) {
                int _e740 = index;
                index = (_e740 + 1);
            }
            loop_init_12 = false;
            int _e726 = index;
            if ((_e726 < 3)) {
            } else {
                break;
            }
            int _e729 = index;
            if ((_e729 == 0)) {
                continue;
            }
            uint _e735 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
            int _e738 = repeated;
            repeated = (_e738 + int(uintBitsToFloat(_e735)));
        }
    }
    int _e743 = repeated;
    uint _e746[2] = out_;
    local_51 = _e746;
    local_52 = uint(24);
    uint _e751[2] = local_51;
    local_134 = _e751;
    uint _e752 = local_52;
    uint _e754 = local_134[1];
    local_134[1] = (_e754 + _e752);
    uint _e758 = local_134[0];
    local_135 = uint(_e758);
    uint _e762 = local_134[1];
    local_136 = uint(_e762);
    uint _e765 = local_136;
    _group_0_binding_0_cs[_e765] = uint(_e743);
    value = 0.0;
    float _e768 = value;
    value = (_e768 + float(1));
    uint _e774 = _naga_trigonometry(floatBitsToUint(_e768), 0u);
    float _e775 = value;
    value = (_e775 - float(1));
    float _e779 = value;
    uint _e782 = _naga_trigonometry(floatBitsToUint(_e779), 1u);
    uint _e786[2] = out_;
    local_53 = _e786;
    local_54 = uint(25);
    uint _e791[2] = local_53;
    local_137 = _e791;
    uint _e792 = local_54;
    uint _e794 = local_137[1];
    local_137[1] = (_e794 + _e792);
    uint _e798 = local_137[0];
    local_138 = uint(_e798);
    uint _e802 = local_137[1];
    local_139 = uint(_e802);
    uint _e805 = local_139;
    _group_0_binding_0_cs[_e805] = floatBitsToUint(uintBitsToFloat(_e782));
    float _e807 = value;
    uint _e810[2] = out_;
    local_55 = _e810;
    local_56 = uint(26);
    uint _e815[2] = local_55;
    local_140 = _e815;
    uint _e816 = local_56;
    uint _e818 = local_140[1];
    local_140[1] = (_e818 + _e816);
    uint _e822 = local_140[0];
    local_141 = uint(_e822);
    uint _e826 = local_140[1];
    local_142 = uint(_e826);
    uint _e829 = local_142;
    _group_0_binding_0_cs[_e829] = floatBitsToUint(_e807);
    if (true) {
        uint _e835 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
        local_59 = uintBitsToFloat(_e835);
    } else {
        uint _e841 = _naga_trigonometry(floatBitsToUint(99.0), 0u);
        local_59 = uintBitsToFloat(_e841);
    }
    float _e845 = local_59;
    uint _e848[2] = out_;
    local_57 = _e848;
    local_58 = uint(27);
    uint _e853[2] = local_57;
    local_143 = _e853;
    uint _e854 = local_58;
    uint _e856 = local_143[1];
    local_143[1] = (_e856 + _e854);
    uint _e860 = local_143[0];
    local_144 = uint(_e860);
    uint _e864 = local_143[1];
    local_145 = uint(_e864);
    uint _e867 = local_145;
    _group_0_binding_0_cs[_e867] = uint(_e845);
    float _e871 = cosine_value(float(false));
    uint _e874[2] = out_;
    local_60 = _e874;
    local_61 = uint(28);
    uint _e879[2] = local_60;
    local_146 = _e879;
    uint _e880 = local_61;
    uint _e882 = local_146[1];
    local_146[1] = (_e882 + _e880);
    uint _e886 = local_146[0];
    local_147 = uint(_e886);
    uint _e890 = local_146[1];
    local_148 = uint(_e890);
    uint _e893 = local_148;
    _group_0_binding_0_cs[_e893] = floatBitsToUint(_e871);
}

