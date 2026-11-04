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
    int local_4 = 0;
    if (value_4) {
        local_4 = 17;
    } else {
        local_4 = 19;
    }
    int _e6 = local_4;
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

uint _naga_fabsf(uint input_bits_1) {
    uint _e2 = (input_bits_1 & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

void main() {
    float value = 0.0;
    bool choose = false;
    int counter = 0;
    bool local = false;
    bool local_1 = false;
    float local_2 = 0.0;
    float values[2] = float[2](0.0, 0.0);
    int Count = 0;
    float scratch[2] = float[2](0.0, 0.0);
    int repeated = 0;
    int index = 0;
    float local_3 = 0.0;
    uint _e3 = _naga_trigonometry(floatBitsToUint(0.0), 0u);
    _group_0_binding_0_cs[uint(0)] = floatBitsToUint(uintBitsToFloat(_e3));
    uint _e14 = _naga_trigonometry(floatBitsToUint(-(0.0)), 0u);
    _group_0_binding_0_cs[uint(1)] = floatBitsToUint(uintBitsToFloat(_e14));
    uint _e23 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
    _group_0_binding_0_cs[uint(2)] = floatBitsToUint(uintBitsToFloat(_e23));
    uint _e33 = _naga_trigonometry(floatBitsToUint(-(0.0)), 1u);
    _group_0_binding_0_cs[uint(3)] = floatBitsToUint(uintBitsToFloat(_e33));
    float _e41 = sine_value(float(0));
    _group_0_binding_0_cs[uint(4)] = floatBitsToUint(_e41);
    float _e48 = cosine_value(float(0u));
    _group_0_binding_0_cs[uint(5)] = floatBitsToUint(_e48);
    int _e54 = sinf(true);
    _group_0_binding_0_cs[uint(6)] = uint(_e54);
    int _e60 = sinf(false);
    _group_0_binding_0_cs[uint(7)] = uint(_e60);
    int _e66 = cosf(4);
    _group_0_binding_0_cs[uint(8)] = uint(_e66);
    uint _e74 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
    _group_0_binding_0_cs[uint(9)] = floatBitsToUint(uintBitsToFloat(_e74));
    float _e82 = sinf_1(2.0, 3.0);
    _group_0_binding_0_cs[uint(10)] = floatBitsToUint(_e82);
    float _e90 = cosf_1(vec2(2.0, 3.0));
    _group_0_binding_0_cs[uint(11)] = floatBitsToUint(_e90);
    value = 0.0;
    float _e97 = value;
    value = (_e97 + float(1));
    uint _e103 = _naga_trigonometry(floatBitsToUint(_e97), 0u);
    _group_0_binding_0_cs[uint(12)] = floatBitsToUint(uintBitsToFloat(_e103));
    float _e109 = value;
    _group_0_binding_0_cs[uint(13)] = floatBitsToUint(_e109);
    value = -(1.0);
    float _e116 = value;
    value = (_e116 + float(1));
    float _e120 = value;
    uint _e123 = _naga_trigonometry(floatBitsToUint(_e120), 1u);
    _group_0_binding_0_cs[uint(14)] = floatBitsToUint(uintBitsToFloat(_e123));
    float _e129 = value;
    _group_0_binding_0_cs[uint(15)] = floatBitsToUint(_e129);
    float _e134 = value;
    value = (_e134 + float(1));
    float _e138 = identity(_e134);
    uint _e141 = _naga_trigonometry(floatBitsToUint(_e138), 0u);
    float _e143 = value;
    value = (_e143 + float(1));
    float _e147 = pair(uintBitsToFloat(_e141), _e143);
    _group_0_binding_0_cs[uint(16)] = floatBitsToUint(_e147);
    float _e152 = value;
    _group_0_binding_0_cs[uint(17)] = floatBitsToUint(_e152);
    choose = false;
    counter = 0;
    bool _e161 = choose;
    local = _e161;
    if (_e161) {
        int _e163 = counter;
        counter = (_e163 + 1);
        uint _e169 = _naga_trigonometry(floatBitsToUint(float(_e163)), 0u);
        uint _e172 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e169)));
        local = (_e172 != 0u);
    }
    bool _e175 = local;
    _group_0_binding_0_cs[uint(18)] = uint(_e175);
    local_1 = true;
    if (true) {
    } else {
        int _e182 = counter;
        counter = (_e182 + 1);
        uint _e188 = _naga_trigonometry(floatBitsToUint(float(_e182)), 1u);
        uint _e191 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e188)));
        local_1 = (_e191 != 0u);
    }
    bool _e194 = local_1;
    _group_0_binding_0_cs[uint(19)] = uint(_e194);
    bool _e199 = choose;
    if (_e199) {
        int _e200 = counter;
        counter = (_e200 + 1);
        int _e203 = counter;
        uint _e207 = _naga_trigonometry(floatBitsToUint(float(_e203)), 0u);
        local_2 = uintBitsToFloat(_e207);
    } else {
        int _e210 = counter;
        uint _e214 = _naga_trigonometry(floatBitsToUint(float(_e210)), 1u);
        local_2 = uintBitsToFloat(_e214);
    }
    float _e218 = local_2;
    _group_0_binding_0_cs[uint(20)] = uint(_e218);
    int _e223 = counter;
    _group_0_binding_0_cs[uint(21)] = uint(_e223);
    uint _e233 = _naga_trigonometry(floatBitsToUint(0.0), 0u);
    values[0] = uintBitsToFloat(_e233);
    uint _e239 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
    values[1] = uintBitsToFloat(_e239);
    float _e245 = values[0];
    float _e246 = values[1];
    _group_0_binding_0_cs[uint(22)] = floatBitsToUint((_e245 + _e246));
    Count = 2;
    scratch = float[2](0.0, 0.0);
    float _e258 = scratch[1];
    _group_0_binding_0_cs[uint(23)] = floatBitsToUint(_e258);
    repeated = 0;
    {
        index = 0;
        bool loop_init_12 = true;
        while(true) {
            if (!loop_init_12) {
                int _e281 = index;
                index = (_e281 + 1);
            }
            loop_init_12 = false;
            int _e267 = index;
            if ((_e267 < 3)) {
            } else {
                break;
            }
            int _e270 = index;
            if ((_e270 == 0)) {
                continue;
            }
            uint _e276 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
            int _e279 = repeated;
            repeated = (_e279 + int(uintBitsToFloat(_e276)));
        }
    }
    int _e284 = repeated;
    _group_0_binding_0_cs[uint(24)] = uint(_e284);
    value = 0.0;
    float _e290 = value;
    value = (_e290 + float(1));
    uint _e296 = _naga_trigonometry(floatBitsToUint(_e290), 0u);
    float _e297 = value;
    value = (_e297 - float(1));
    float _e301 = value;
    uint _e304 = _naga_trigonometry(floatBitsToUint(_e301), 1u);
    _group_0_binding_0_cs[uint(25)] = floatBitsToUint(uintBitsToFloat(_e304));
    float _e310 = value;
    _group_0_binding_0_cs[uint(26)] = floatBitsToUint(_e310);
    if (true) {
        uint _e319 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
        local_3 = uintBitsToFloat(_e319);
    } else {
        uint _e325 = _naga_trigonometry(floatBitsToUint(99.0), 0u);
        local_3 = uintBitsToFloat(_e325);
    }
    float _e329 = local_3;
    _group_0_binding_0_cs[uint(27)] = uint(_e329);
    float _e336 = cosine_value(float(false));
    _group_0_binding_0_cs[uint(28)] = floatBitsToUint(_e336);
}

