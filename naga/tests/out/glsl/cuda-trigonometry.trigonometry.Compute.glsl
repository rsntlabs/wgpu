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
    float value_3 = 0.0;
    value_3 = value_2;
    float _e2 = value_3;
    uint _e5 = _naga_trigonometry(floatBitsToUint(_e2), 0u);
    return uintBitsToFloat(_e5);
}

float cosine_value(float value_4) {
    float value_5 = 0.0;
    value_5 = value_4;
    float _e2 = value_5;
    uint _e5 = _naga_trigonometry(floatBitsToUint(_e2), 1u);
    return uintBitsToFloat(_e5);
}

int sinf(bool value_6) {
    bool value_7 = false;
    int local_121 = 0;
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

int cosf(int value_8) {
    int value_9 = 0;
    value_9 = value_8;
    int _e3 = value_9;
    return (_e3 + 23);
}

float sinf_1(float first, float second) {
    float first_1 = 0.0;
    float second_1 = 0.0;
    first_1 = first;
    second_1 = second;
    float _e4 = first_1;
    float _e5 = second_1;
    return (_e4 + _e5);
}

float cosf_1(vec2 value_10) {
    vec2 value_11 = vec2(0.0);
    value_11 = value_10;
    float _e4 = value_11.x;
    float _e5 = value_11.y;
    return (_e4 + _e5);
}

float identity(float value_12) {
    float value_13 = 0.0;
    value_13 = value_12;
    float _e2 = value_13;
    return _e2;
}

float pair(float first_2, float second_2) {
    float first_3 = 0.0;
    float second_3 = 0.0;
    first_3 = first_2;
    second_3 = second_2;
    float _e5 = first_3;
    float _e7 = second_3;
    return ((_e5 * 10.0) + _e7);
}

void main() {
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
    float value = 0.0;
    uint local_37 = 0u;
    uint local_38 = 0u;
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41 = 0u;
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44 = 0u;
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47 = 0u;
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50 = 0u;
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53 = 0u;
    uint local_54 = 0u;
    bool choose = false;
    int counter = 0;
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57 = 0u;
    bool local_58 = false;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    bool local_62 = false;
    uint local_63 = 0u;
    uint local_64 = 0u;
    uint local_65 = 0u;
    float local_66 = 0.0;
    uint local_67 = 0u;
    uint local_68 = 0u;
    uint local_69 = 0u;
    float values[2] = float[2](0.0, 0.0);
    uint local_70 = 0u;
    uint local_71 = 0u;
    uint local_72 = 0u;
    int Count = 0;
    float scratch[2] = float[2](0.0, 0.0);
    uint local_73 = 0u;
    uint local_74 = 0u;
    uint local_75 = 0u;
    int repeated = 0;
    int index = 0;
    uint local_76 = 0u;
    uint local_77 = 0u;
    uint local_78 = 0u;
    uint local_79 = 0u;
    uint local_80 = 0u;
    uint local_81 = 0u;
    uint local_82 = 0u;
    uint local_83 = 0u;
    uint local_84 = 0u;
    uint local_85 = 0u;
    uint local_86 = 0u;
    uint local_87 = 0u;
    float local_88 = 0.0;
    uint local_89 = 0u;
    uint local_90 = 0u;
    uint local_91 = 0u;
    uint local_92 = 0u;
    uint local_93 = 0u;
    uint local_94 = 0u;
    uint local_95 = 0u;
    uint local_96 = 0u;
    uint local_97 = 0u;
    uint local_98 = 0u;
    uint local_99 = 0u;
    uint local_100 = 0u;
    uint local_101 = 0u;
    uint local_102 = 0u;
    uint local_103 = 0u;
    uint local_104 = 0u;
    uint local_105 = 0u;
    uint local_106 = 0u;
    uint local_107 = 0u;
    uint local_108 = 0u;
    uint local_109 = 0u;
    uint local_110 = 0u;
    uint local_111 = 0u;
    uint local_112 = 0u;
    uint local_113 = 0u;
    uint local_114 = 0u;
    uint local_115 = 0u;
    uint local_116 = 0u;
    uint local_117 = 0u;
    uint local_118 = 0u;
    uint local_119 = 0u;
    uint local_120 = 0u;
    local = 0u;
    uint _e5 = _naga_trigonometry(floatBitsToUint(0.0), 0u);
    uint _e8 = local;
    local_1 = _e8;
    uint _e10 = local_1;
    local_2 = uint(_e10);
    local_3 = uint(0);
    uint _e17 = local_2;
    uint _e18 = local_3;
    local_92 = uint((_e17 + _e18));
    uint _e22 = local_92;
    _group_0_binding_0_cs[_e22] = floatBitsToUint(uintBitsToFloat(_e5));
    uint _e28 = _naga_trigonometry(floatBitsToUint(-(0.0)), 0u);
    uint _e31 = local;
    local_4 = _e31;
    uint _e33 = local_4;
    local_5 = uint(_e33);
    local_6 = uint(1);
    uint _e39 = local_5;
    uint _e40 = local_6;
    local_93 = uint((_e39 + _e40));
    uint _e44 = local_93;
    _group_0_binding_0_cs[_e44] = floatBitsToUint(uintBitsToFloat(_e28));
    uint _e49 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
    uint _e52 = local;
    local_7 = _e52;
    uint _e54 = local_7;
    local_8 = uint(_e54);
    local_9 = uint(2);
    uint _e60 = local_8;
    uint _e61 = local_9;
    local_94 = uint((_e60 + _e61));
    uint _e65 = local_94;
    _group_0_binding_0_cs[_e65] = floatBitsToUint(uintBitsToFloat(_e49));
    uint _e71 = _naga_trigonometry(floatBitsToUint(-(0.0)), 1u);
    uint _e74 = local;
    local_10 = _e74;
    uint _e76 = local_10;
    local_11 = uint(_e76);
    local_12 = uint(3);
    uint _e82 = local_11;
    uint _e83 = local_12;
    local_95 = uint((_e82 + _e83));
    uint _e87 = local_95;
    _group_0_binding_0_cs[_e87] = floatBitsToUint(uintBitsToFloat(_e71));
    float _e91 = sine_value(float(0));
    uint _e93 = local;
    local_13 = _e93;
    uint _e95 = local_13;
    local_14 = uint(_e95);
    local_15 = uint(4);
    uint _e101 = local_14;
    uint _e102 = local_15;
    local_96 = uint((_e101 + _e102));
    uint _e106 = local_96;
    _group_0_binding_0_cs[_e106] = floatBitsToUint(_e91);
    float _e110 = cosine_value(float(0u));
    uint _e112 = local;
    local_16 = _e112;
    uint _e114 = local_16;
    local_17 = uint(_e114);
    local_18 = uint(5);
    uint _e120 = local_17;
    uint _e121 = local_18;
    local_97 = uint((_e120 + _e121));
    uint _e125 = local_97;
    _group_0_binding_0_cs[_e125] = floatBitsToUint(_e110);
    int _e128 = sinf(true);
    uint _e130 = local;
    local_19 = _e130;
    uint _e132 = local_19;
    local_20 = uint(_e132);
    local_21 = uint(6);
    uint _e138 = local_20;
    uint _e139 = local_21;
    local_98 = uint((_e138 + _e139));
    uint _e143 = local_98;
    _group_0_binding_0_cs[_e143] = uint(_e128);
    int _e146 = sinf(false);
    uint _e148 = local;
    local_22 = _e148;
    uint _e150 = local_22;
    local_23 = uint(_e150);
    local_24 = uint(7);
    uint _e156 = local_23;
    uint _e157 = local_24;
    local_99 = uint((_e156 + _e157));
    uint _e161 = local_99;
    _group_0_binding_0_cs[_e161] = uint(_e146);
    int _e164 = cosf(4);
    uint _e166 = local;
    local_25 = _e166;
    uint _e168 = local_25;
    local_26 = uint(_e168);
    local_27 = uint(8);
    uint _e174 = local_26;
    uint _e175 = local_27;
    local_100 = uint((_e174 + _e175));
    uint _e179 = local_100;
    _group_0_binding_0_cs[_e179] = uint(_e164);
    uint _e184 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
    uint _e187 = local;
    local_28 = _e187;
    uint _e189 = local_28;
    local_29 = uint(_e189);
    local_30 = uint(9);
    uint _e195 = local_29;
    uint _e196 = local_30;
    local_101 = uint((_e195 + _e196));
    uint _e200 = local_101;
    _group_0_binding_0_cs[_e200] = floatBitsToUint(uintBitsToFloat(_e184));
    float _e204 = sinf_1(2.0, 3.0);
    uint _e206 = local;
    local_31 = _e206;
    uint _e208 = local_31;
    local_32 = uint(_e208);
    local_33 = uint(10);
    uint _e214 = local_32;
    uint _e215 = local_33;
    local_102 = uint((_e214 + _e215));
    uint _e219 = local_102;
    _group_0_binding_0_cs[_e219] = floatBitsToUint(_e204);
    float _e224 = cosf_1(vec2(2.0, 3.0));
    uint _e226 = local;
    local_34 = _e226;
    uint _e228 = local_34;
    local_35 = uint(_e228);
    local_36 = uint(11);
    uint _e234 = local_35;
    uint _e235 = local_36;
    local_103 = uint((_e234 + _e235));
    uint _e239 = local_103;
    _group_0_binding_0_cs[_e239] = floatBitsToUint(_e224);
    value = 0.0;
    float _e243 = value;
    value = (_e243 + float(1));
    uint _e249 = _naga_trigonometry(floatBitsToUint(_e243), 0u);
    uint _e252 = local;
    local_37 = _e252;
    uint _e254 = local_37;
    local_38 = uint(_e254);
    local_39 = uint(12);
    uint _e260 = local_38;
    uint _e261 = local_39;
    local_104 = uint((_e260 + _e261));
    uint _e265 = local_104;
    _group_0_binding_0_cs[_e265] = floatBitsToUint(uintBitsToFloat(_e249));
    float _e267 = value;
    uint _e269 = local;
    local_40 = _e269;
    uint _e271 = local_40;
    local_41 = uint(_e271);
    local_42 = uint(13);
    uint _e277 = local_41;
    uint _e278 = local_42;
    local_105 = uint((_e277 + _e278));
    uint _e282 = local_105;
    _group_0_binding_0_cs[_e282] = floatBitsToUint(_e267);
    value = -(1.0);
    float _e286 = value;
    value = (_e286 + float(1));
    float _e290 = value;
    uint _e293 = _naga_trigonometry(floatBitsToUint(_e290), 1u);
    uint _e296 = local;
    local_43 = _e296;
    uint _e298 = local_43;
    local_44 = uint(_e298);
    local_45 = uint(14);
    uint _e304 = local_44;
    uint _e305 = local_45;
    local_106 = uint((_e304 + _e305));
    uint _e309 = local_106;
    _group_0_binding_0_cs[_e309] = floatBitsToUint(uintBitsToFloat(_e293));
    float _e311 = value;
    uint _e313 = local;
    local_46 = _e313;
    uint _e315 = local_46;
    local_47 = uint(_e315);
    local_48 = uint(15);
    uint _e321 = local_47;
    uint _e322 = local_48;
    local_107 = uint((_e321 + _e322));
    uint _e326 = local_107;
    _group_0_binding_0_cs[_e326] = floatBitsToUint(_e311);
    float _e328 = value;
    value = (_e328 + float(1));
    float _e332 = identity(_e328);
    uint _e335 = _naga_trigonometry(floatBitsToUint(_e332), 0u);
    float _e337 = value;
    value = (_e337 + float(1));
    float _e341 = pair(uintBitsToFloat(_e335), _e337);
    uint _e343 = local;
    local_49 = _e343;
    uint _e345 = local_49;
    local_50 = uint(_e345);
    local_51 = uint(16);
    uint _e351 = local_50;
    uint _e352 = local_51;
    local_108 = uint((_e351 + _e352));
    uint _e356 = local_108;
    _group_0_binding_0_cs[_e356] = floatBitsToUint(_e341);
    float _e358 = value;
    uint _e360 = local;
    local_52 = _e360;
    uint _e362 = local_52;
    local_53 = uint(_e362);
    local_54 = uint(17);
    uint _e368 = local_53;
    uint _e369 = local_54;
    local_109 = uint((_e368 + _e369));
    uint _e373 = local_109;
    _group_0_binding_0_cs[_e373] = floatBitsToUint(_e358);
    choose = false;
    counter = 0;
    bool _e379 = choose;
    local_58 = _e379;
    if (_e379) {
        int _e381 = counter;
        counter = (_e381 + 1);
        uint _e387 = _naga_trigonometry(floatBitsToUint(float(_e381)), 0u);
        local_58 = (uintBitsToFloat(_e387) != 0.0);
    }
    bool _e391 = local_58;
    uint _e393 = local;
    local_55 = _e393;
    uint _e395 = local_55;
    local_56 = uint(_e395);
    local_57 = uint(18);
    uint _e401 = local_56;
    uint _e402 = local_57;
    local_110 = uint((_e401 + _e402));
    uint _e406 = local_110;
    _group_0_binding_0_cs[_e406] = uint(_e391);
    local_62 = true;
    if (true) {
    } else {
        int _e410 = counter;
        counter = (_e410 + 1);
        uint _e416 = _naga_trigonometry(floatBitsToUint(float(_e410)), 1u);
        local_62 = (uintBitsToFloat(_e416) != 0.0);
    }
    bool _e420 = local_62;
    uint _e422 = local;
    local_59 = _e422;
    uint _e424 = local_59;
    local_60 = uint(_e424);
    local_61 = uint(19);
    uint _e430 = local_60;
    uint _e431 = local_61;
    local_111 = uint((_e430 + _e431));
    uint _e435 = local_111;
    _group_0_binding_0_cs[_e435] = uint(_e420);
    bool _e437 = choose;
    if (_e437) {
        int _e438 = counter;
        counter = (_e438 + 1);
        int _e441 = counter;
        uint _e445 = _naga_trigonometry(floatBitsToUint(float(_e441)), 0u);
        local_66 = uintBitsToFloat(_e445);
    } else {
        int _e448 = counter;
        uint _e452 = _naga_trigonometry(floatBitsToUint(float(_e448)), 1u);
        local_66 = uintBitsToFloat(_e452);
    }
    float _e456 = local_66;
    uint _e458 = local;
    local_63 = _e458;
    uint _e460 = local_63;
    local_64 = uint(_e460);
    local_65 = uint(20);
    uint _e466 = local_64;
    uint _e467 = local_65;
    local_112 = uint((_e466 + _e467));
    uint _e471 = local_112;
    _group_0_binding_0_cs[_e471] = uint(_e456);
    int _e473 = counter;
    uint _e475 = local;
    local_67 = _e475;
    uint _e477 = local_67;
    local_68 = uint(_e477);
    local_69 = uint(21);
    uint _e483 = local_68;
    uint _e484 = local_69;
    local_113 = uint((_e483 + _e484));
    uint _e488 = local_113;
    _group_0_binding_0_cs[_e488] = uint(_e473);
    uint _e495 = _naga_trigonometry(floatBitsToUint(0.0), 0u);
    values[0] = uintBitsToFloat(_e495);
    uint _e501 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
    values[1] = uintBitsToFloat(_e501);
    float _e507 = values[0];
    float _e508 = values[1];
    uint _e511 = local;
    local_70 = _e511;
    uint _e513 = local_70;
    local_71 = uint(_e513);
    local_72 = uint(22);
    uint _e519 = local_71;
    uint _e520 = local_72;
    local_114 = uint((_e519 + _e520));
    uint _e524 = local_114;
    _group_0_binding_0_cs[_e524] = floatBitsToUint((_e507 + _e508));
    Count = 2;
    scratch = float[2](0.0, 0.0);
    float _e532 = scratch[1];
    uint _e534 = local;
    local_73 = _e534;
    uint _e536 = local_73;
    local_74 = uint(_e536);
    local_75 = uint(23);
    uint _e542 = local_74;
    uint _e543 = local_75;
    local_115 = uint((_e542 + _e543));
    uint _e547 = local_115;
    _group_0_binding_0_cs[_e547] = floatBitsToUint(_e532);
    repeated = 0;
    {
        index = 0;
        bool loop_init_12 = true;
        while(true) {
            if (!loop_init_12) {
                int _e567 = index;
                index = (_e567 + 1);
            }
            loop_init_12 = false;
            int _e553 = index;
            if ((_e553 < 3)) {
            } else {
                break;
            }
            int _e556 = index;
            if ((_e556 == 0)) {
                continue;
            }
            uint _e562 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
            int _e565 = repeated;
            repeated = (_e565 + int(uintBitsToFloat(_e562)));
        }
    }
    int _e570 = repeated;
    uint _e572 = local;
    local_76 = _e572;
    uint _e574 = local_76;
    local_77 = uint(_e574);
    local_78 = uint(24);
    uint _e580 = local_77;
    uint _e581 = local_78;
    local_116 = uint((_e580 + _e581));
    uint _e585 = local_116;
    _group_0_binding_0_cs[_e585] = uint(_e570);
    value = 0.0;
    float _e588 = value;
    value = (_e588 + float(1));
    uint _e594 = _naga_trigonometry(floatBitsToUint(_e588), 0u);
    float _e595 = value;
    value = (_e595 - float(1));
    float _e599 = value;
    uint _e602 = _naga_trigonometry(floatBitsToUint(_e599), 1u);
    uint _e605 = local;
    local_79 = _e605;
    uint _e607 = local_79;
    local_80 = uint(_e607);
    local_81 = uint(25);
    uint _e613 = local_80;
    uint _e614 = local_81;
    local_117 = uint((_e613 + _e614));
    uint _e618 = local_117;
    _group_0_binding_0_cs[_e618] = floatBitsToUint(uintBitsToFloat(_e602));
    float _e620 = value;
    uint _e622 = local;
    local_82 = _e622;
    uint _e624 = local_82;
    local_83 = uint(_e624);
    local_84 = uint(26);
    uint _e630 = local_83;
    uint _e631 = local_84;
    local_118 = uint((_e630 + _e631));
    uint _e635 = local_118;
    _group_0_binding_0_cs[_e635] = floatBitsToUint(_e620);
    if (true) {
        uint _e641 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
        local_88 = uintBitsToFloat(_e641);
    } else {
        uint _e647 = _naga_trigonometry(floatBitsToUint(99.0), 0u);
        local_88 = uintBitsToFloat(_e647);
    }
    float _e651 = local_88;
    uint _e653 = local;
    local_85 = _e653;
    uint _e655 = local_85;
    local_86 = uint(_e655);
    local_87 = uint(27);
    uint _e661 = local_86;
    uint _e662 = local_87;
    local_119 = uint((_e661 + _e662));
    uint _e666 = local_119;
    _group_0_binding_0_cs[_e666] = uint(_e651);
    float _e670 = cosine_value(float(false));
    uint _e672 = local;
    local_89 = _e672;
    uint _e674 = local_89;
    local_90 = uint(_e674);
    local_91 = uint(28);
    uint _e680 = local_90;
    uint _e681 = local_91;
    local_120 = uint((_e680 + _e681));
    uint _e685 = local_120;
    _group_0_binding_0_cs[_e685] = floatBitsToUint(_e670);
}

