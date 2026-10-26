#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

struct Packet_cuda_record_0_ {
    int key;
    int values[2];
};
layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

uvec3 blockIdx_1 = uvec3(0u);

uvec3 threadIdx_1 = uvec3(0u);


int route(float value) {
    float value_1 = 0.0;
    value_1 = value;
    float _e3 = value_1;
    return (10 + int(_e3));
}

int earlier(int value_2) {
    int value_3 = 0;
    value_3 = value_2;
    int _e2 = value_3;
    int _e4 = route(float(_e2));
    return _e4;
}

int route_1(int value_4) {
    int value_5 = 0;
    value_5 = value_4;
    int _e3 = value_5;
    return (20 + _e3);
}

int forward(int value_6) {
    int value_7 = 0;
    value_7 = value_6;
    int _e2 = value_7;
    int _e3 = route_1(_e2);
    int _e4 = value_7;
    int _e5 = earlier(_e4);
    return (_e3 + _e5);
}

Packet_cuda_record_0_ packet(int value_8) {
    int value_9 = 0;
    Packet_cuda_record_0_ local_65 = Packet_cuda_record_0_(0, int[2](0, 0));
    value_9 = value_8;
    int _e3 = value_9;
    local_65.key = _e3;
    int _e7 = value_9;
    local_65.values[0] = (_e7 + 1);
    int _e12 = value_9;
    local_65.values[1] = (_e12 + 2);
    Packet_cuda_record_0_ _e14 = local_65;
    return _e14;
}

Packet_cuda_record_0_ adjust(Packet_cuda_record_0_ value_10) {
    Packet_cuda_record_0_ value_11 = Packet_cuda_record_0_(0, int[2](0, 0));
    value_11 = value_10;
    int _e4 = value_11.key;
    value_11.key = (_e4 + 4);
    int _e10 = value_11.values[1];
    value_11.values[1] = (_e10 + 6);
    Packet_cuda_record_0_ _e12 = value_11;
    return _e12;
}

Packet_cuda_record_0_ operator_u002b(Packet_cuda_record_0_ left, Packet_cuda_record_0_ right) {
    Packet_cuda_record_0_ left_1 = Packet_cuda_record_0_(0, int[2](0, 0));
    Packet_cuda_record_0_ right_1 = Packet_cuda_record_0_(0, int[2](0, 0));
    Packet_cuda_record_0_ local_66 = Packet_cuda_record_0_(0, int[2](0, 0));
    left_1 = left;
    right_1 = right;
    int _e7 = left_1.key;
    int _e8 = right_1.key;
    local_66.key = (_e7 + _e8);
    int _e18 = left_1.values[0];
    int _e19 = right_1.values[0];
    local_66.values[0] = (_e18 + _e19);
    int _e29 = left_1.values[1];
    int _e30 = right_1.values[1];
    local_66.values[1] = (_e29 + _e30);
    Packet_cuda_record_0_ _e32 = local_66;
    return _e32;
}

int pair(int first_1, int second_1) {
    int first_2 = 0;
    int second_2 = 0;
    first_2 = first_1;
    second_2 = second_1;
    int _e5 = first_2;
    int _e7 = second_2;
    return ((_e5 * 10) + _e7);
}

void consume(int value_12) {
    int value_13 = 0;
    value_13 = value_12;
    int _e2 = value_13;
    if ((_e2 != 0)) {
        return;
    } else {
        return;
    }
}

uint _naga_sqrtf(uint input_bits) {
    uint significand = 0u;
    uint adjusted_exponent = 0u;
    uint upper_word = 0u;
    uint lower_word = 0u;
    uint root = 0u;
    uint remainder = 0u;
    uint iteration = 0u;
    uint _e5 = (input_bits & 2147483647u);
    if (((_e5 == 0u) || (input_bits == 2139095040u))) {
        return input_bits;
    }
    if ((((input_bits & 2147483648u) != 0u) || (_e5 > 2139095040u))) {
        return 2143289344u;
    }
    uint _e19 = (input_bits & 8388607u);
    uint _e20 = (_e5 >> 23u);
    significand = (_e19 | 8388608u);
    adjusted_exponent = (_e20 + 127u);
    if ((_e20 == 0u)) {
        uint _e28 = (uint(31 - findMSB(_e19)) - 8u);
        significand = (_e19 << _e28);
        adjusted_exponent = (128u - _e28);
    }
    uint _e32 = significand;
    uint _e33 = adjusted_exponent;
    uint _e34 = (_e33 & 1u);
    upper_word = (_e32 >> (9u - _e34));
    lower_word = (_e32 << (23u + _e34));
    root = 0u;
    remainder = 0u;
    iteration = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e72 = iteration;
            iteration = (_e72 + 1u);
        }
        loop_init = false;
        uint _e50 = iteration;
        if ((_e50 >= 24u)) {
            break;
        }
        uint _e52 = upper_word;
        uint _e53 = lower_word;
        uint _e54 = root;
        uint _e55 = remainder;
        uint _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        uint _e65 = ((_e54 << 2u) | 1u);
        bool _e66 = (_e63 >= _e65);
        uint _e69 = (_e54 << 1u);
        upper_word = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word = (_e53 << 2u);
        remainder = (_e66 ? (_e63 - _e65) : _e63);
        root = (_e66 ? (_e69 | 1u) : _e69);
    }
    uint _e74 = root;
    uint _e75 = remainder;
    return (((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u));
}

uint[22] _naga_trig_reduce_multiply(uint left_2[2], uint right_2[20]) {
    uint left_digits[2] = uint[2](0u, 0u);
    uint right_digits[20] = uint[20](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint product[22] = uint[22](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint carry = 0u;
    uint left_index = 0u;
    uint right_index = 0u;
    uint result[22] = uint[22](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint result_index = 0u;
    left_digits = left_2;
    right_digits = right_2;
    left_index = 0u;
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            uint _e46 = left_index;
            left_index = (_e46 + 1u);
        }
        loop_init_1 = false;
        uint _e13 = left_index;
        if ((_e13 >= 2u)) {
            break;
        }
        carry = 0u;
        uint _e18 = left_digits[_e13];
        right_index = 0u;
        bool loop_init_2 = true;
        while(true) {
            if (!loop_init_2) {
                uint _e39 = right_index;
                right_index = (_e39 + 1u);
            }
            loop_init_2 = false;
            uint _e22 = right_index;
            if ((_e22 >= 20u)) {
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
        product[(_e13 + 20u)] = _e44;
    }
    result_index = 0u;
    bool loop_init_3 = true;
    while(true) {
        if (!loop_init_3) {
            uint _e62 = result_index;
            result_index = (_e62 + 1u);
        }
        loop_init_3 = false;
        uint _e54 = result_index;
        if ((_e54 >= 22u)) {
            break;
        }
        uint _e60 = product[(_e54 + 0u)];
        result[_e54] = _e60;
    }
    uint _e65[22] = result;
    return _e65;
}

uint _naga_trig_extract_product(uint digits[22], uint offset) {
    uint source[22] = uint[22](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint low = 0u;
    uint high = 0u;
    source = digits;
    uint _e5 = (offset / 16u);
    uint _e7 = (offset - 16u * (offset / 16u));
    uint _e13 = (_e5 + 0u);
    if ((_e13 < 22u)) {
        uint _e17 = source[_e13];
        low = _e17;
    }
    uint _e19 = (_e5 + 1u);
    if ((_e19 < 22u)) {
        uint _e23 = source[_e19];
        high = _e23;
    }
    uint _e24 = low;
    uint _e25 = high;
    return (((_e24 >> _e7) | (_e25 << (16u - _e7))) & 65535u);
}

uint[12] _naga_trig_multiply(uint left_3[12], uint right_3[12]) {
    uint left_digits_1[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint right_digits_1[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint product_1[24] = uint[24](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint carry_1 = 0u;
    uint left_index_1 = 0u;
    uint right_index_1 = 0u;
    uint result_1[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint result_index_1 = 0u;
    left_digits_1 = left_3;
    right_digits_1 = right_3;
    left_index_1 = 0u;
    bool loop_init_4 = true;
    while(true) {
        if (!loop_init_4) {
            uint _e46 = left_index_1;
            left_index_1 = (_e46 + 1u);
        }
        loop_init_4 = false;
        uint _e13 = left_index_1;
        if ((_e13 >= 12u)) {
            break;
        }
        carry_1 = 0u;
        uint _e18 = left_digits_1[_e13];
        right_index_1 = 0u;
        bool loop_init_5 = true;
        while(true) {
            if (!loop_init_5) {
                uint _e39 = right_index_1;
                right_index_1 = (_e39 + 1u);
            }
            loop_init_5 = false;
            uint _e22 = right_index_1;
            if ((_e22 >= 12u)) {
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
        product_1[(_e13 + 12u)] = _e44;
    }
    result_index_1 = 0u;
    bool loop_init_6 = true;
    while(true) {
        if (!loop_init_6) {
            uint _e62 = result_index_1;
            result_index_1 = (_e62 + 1u);
        }
        loop_init_6 = false;
        uint _e54 = result_index_1;
        if ((_e54 >= 12u)) {
            break;
        }
        uint _e60 = product_1[(_e54 + 11u)];
        result_1[_e54] = _e60;
    }
    uint _e65[12] = result_1;
    return _e65;
}

uint[12] _naga_trig_divide(uint value_14[12], uint divisor) {
    uint source_1[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint result_2[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint remainder_1 = 0u;
    uint step_ = 0u;
    source_1 = value_14;
    step_ = 0u;
    bool loop_init_7 = true;
    while(true) {
        if (!loop_init_7) {
            uint _e25 = step_;
            step_ = (_e25 + 1u);
        }
        loop_init_7 = false;
        uint _e11 = step_;
        if ((_e11 >= 12u)) {
            break;
        }
        uint _e15 = (11u - _e11);
        uint _e16 = remainder_1;
        uint _e20 = source_1[_e15];
        uint _e21 = ((_e16 << 16u) | _e20);
        result_2[_e15] = (_e21 / divisor);
        remainder_1 = (_e21 - divisor * (_e21 / divisor));
    }
    uint _e28[12] = result_2;
    return _e28;
}

uint[12] _naga_trig_combine(uint left_4[12], uint right_4[12], uint subtract) {
    uint left_digits_2[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint right_digits_2[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint result_3[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint carry_2 = 0u;
    uint digit_index = 0u;
    left_digits_2 = left_4;
    right_digits_2 = right_4;
    bool _e12 = (subtract != 0u);
    digit_index = 0u;
    bool loop_init_8 = true;
    while(true) {
        if (!loop_init_8) {
            uint _e38 = digit_index;
            digit_index = (_e38 + 1u);
        }
        loop_init_8 = false;
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

uint[12] _naga_trig_kernel(uint angle[12], uint sine) {
    uint term[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint total_1[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint step_1 = 0u;
    bool _e7 = (sine != 0u);
    if (_e7) {
        term = angle;
    } else {
        term = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u);
    }
    uint _e21[12] = term;
    total_1 = _e21;
    uint _e22[12] = _naga_trig_multiply(angle, angle);
    step_1 = 0u;
    bool loop_init_9 = true;
    while(true) {
        if (!loop_init_9) {
            uint _e46 = step_1;
            step_1 = (_e46 + 1u);
        }
        loop_init_9 = false;
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
        uint _e42[12] = total_1;
        uint _e45[12] = _naga_trig_combine(_e42, _e41, (_e30 & 1u));
        total_1 = _e45;
    }
    uint _e49[12] = total_1;
    return _e49;
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

uint _naga_trig_round(uint digits_2[12]) {
    uint source_3[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint highest_bit = 0u;
    uint nonzero = 0u;
    uint digit_index_1 = 0u;
    uint sticky = 0u;
    uint sticky_index = 0u;
    source_3 = digits_2;
    digit_index_1 = 0u;
    bool loop_init_10 = true;
    while(true) {
        if (!loop_init_10) {
            uint _e25 = digit_index_1;
            digit_index_1 = (_e25 + 1u);
        }
        loop_init_10 = false;
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
    bool loop_init_11 = true;
    while(true) {
        if (!loop_init_11) {
            uint _e80 = sticky_index;
            sticky_index = (_e80 + 1u);
        }
        loop_init_11 = false;
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

uint _naga_trigonometry(uint input_bits_1, uint cosine) {
    uint quadrant = 0u;
    uint fraction[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint fraction_index = 0u;
    uint _e3 = (input_bits_1 & 2147483647u);
    if ((_e3 >= 2139095040u)) {
        return 2143289344u;
    }
    bool _e8 = (cosine != 0u);
    if ((_e3 <= 956301312u)) {
        return (_e8 ? 1065353216u : input_bits_1);
    }
    uint _e16 = (470u - (_e3 >> 23u));
    uint _e20 = ((_e3 & 8388607u) | 8388608u);
    uint _e47[22] = _naga_trig_reduce_multiply(uint[2]((_e20 & 65535u), (_e20 >> 16u)), uint[20](53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    uint _e50 = _naga_trig_extract_product(_e47, _e16);
    quadrant = (_e50 & 3u);
    fraction_index = 0u;
    bool loop_init_12 = true;
    while(true) {
        if (!loop_init_12) {
            uint _e68 = fraction_index;
            fraction_index = (_e68 + 1u);
        }
        loop_init_12 = false;
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
    return (_e120 | ((((_e75 && _e115) ? 2147483648u : 0u) ^ (((_e8 ? (_e112 + 1u) : _e112) & 2u) << 30u)) ^ (_e8 ? 0u : (input_bits_1 & 2147483648u))));
}

float generated(float value_15) {
    float value_16 = 0.0;
    value_16 = value_15;
    uint _e4 = _naga_sqrtf(floatBitsToUint(4.0));
    float _e6 = value_16;
    uint _e9 = _naga_trigonometry(floatBitsToUint(_e6), 0u);
    float _e12 = value_16;
    uint _e15 = _naga_trigonometry(floatBitsToUint(_e12), 1u);
    return ((uintBitsToFloat(_e4) + uintBitsToFloat(_e9)) + uintBitsToFloat(_e15));
}

int control(int count) {
    int count_1 = 0;
    int result_4 = 0;
    int index = 0;
    count_1 = count;
    result_4 = 0;
    {
        index = 0;
        bool loop_init_13 = true;
        while(true) {
            if (!loop_init_13) {
                int _e9 = index;
                index = (_e9 + 1);
            }
            loop_init_13 = false;
            int _e6 = index;
            int _e7 = count_1;
            if ((_e6 < _e7)) {
            } else {
                break;
            }
            int _e13 = index;
            if ((_e13 == 1)) {
                continue;
            }
            int _e15 = index;
            switch(_e15) {
                case 0: {
                    int _e16 = index;
                    int _e17 = route_1(_e16);
                    int _e18 = result_4;
                    result_4 = (_e18 + _e17);
                    break;
                }
                default: {
                    int _e20 = index;
                    int _e21 = forward(_e20);
                    int _e22 = index;
                    int _e23 = earlier(_e22);
                    int _e25 = result_4;
                    result_4 = (_e25 + (_e21 - _e23));
                    break;
                }
            }
        }
    }
    int _e27 = result_4;
    return _e27;
}

uint late_index() {
    uvec3 _e1 = blockIdx_1;
    uvec3 _e6 = threadIdx_1;
    return ((_e1.x * 2u) + _e6.x);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint local = 0u;
    uint lane = 0u;
    uint base = 0u;
    int counter = 0;
    Packet_cuda_record_0_ first = Packet_cuda_record_0_(0, int[2](0, 0));
    Packet_cuda_record_0_ second = Packet_cuda_record_0_(0, int[2](0, 0));
    Packet_cuda_record_0_ total = Packet_cuda_record_0_(0, int[2](0, 0));
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
    int first_argument = 0;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    uint local_36 = 0u;
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
    uint local_55 = 0u;
    uint local_56 = 0u;
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59 = 0u;
    uint local_60 = 0u;
    uint local_61 = 0u;
    uint local_62 = 0u;
    uint local_63 = 0u;
    uint local_64 = 0u;
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    local = 0u;
    uint _e6 = late_index();
    lane = _e6;
    uint _e8 = lane;
    base = (_e8 * 16u);
    counter = 1;
    int _e14 = counter;
    counter = (_e14 + 1);
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
    local_2 = uint(_e30);
    uint _e33 = base;
    local_3 = uint(_e33);
    uint _e38 = local_2;
    uint _e39 = local_3;
    local_49 = uint((_e38 + _e39));
    uint _e43 = local_49;
    _group_0_binding_0_cs[_e43] = uint(_e27);
    int _e46 = route_1(3);
    uint _e47 = local;
    local_4 = _e47;
    uint _e49 = local_4;
    local_5 = uint(_e49);
    uint _e52 = base;
    local_6 = uint((_e52 + uint(1)));
    uint _e59 = local_5;
    uint _e60 = local_6;
    local_50 = uint((_e59 + _e60));
    uint _e64 = local_50;
    _group_0_binding_0_cs[_e64] = uint(_e46);
    int _e67 = forward(4);
    uint _e68 = local;
    local_7 = _e68;
    uint _e70 = local_7;
    local_8 = uint(_e70);
    uint _e73 = base;
    local_9 = uint((_e73 + uint(2)));
    uint _e80 = local_8;
    uint _e81 = local_9;
    local_51 = uint((_e80 + _e81));
    uint _e85 = local_51;
    _group_0_binding_0_cs[_e85] = uint(_e67);
    int _e88 = first.key;
    uint _e89 = local;
    local_10 = _e89;
    uint _e91 = local_10;
    local_11 = uint(_e91);
    uint _e94 = base;
    local_12 = uint((_e94 + uint(3)));
    uint _e101 = local_11;
    uint _e102 = local_12;
    local_52 = uint((_e101 + _e102));
    uint _e106 = local_52;
    _group_0_binding_0_cs[_e106] = uint(_e88);
    int _e111 = first.values[1];
    uint _e112 = local;
    local_13 = _e112;
    uint _e114 = local_13;
    local_14 = uint(_e114);
    uint _e117 = base;
    local_15 = uint((_e117 + uint(4)));
    uint _e124 = local_14;
    uint _e125 = local_15;
    local_53 = uint((_e124 + _e125));
    uint _e129 = local_53;
    _group_0_binding_0_cs[_e129] = uint(_e111);
    int _e132 = second.key;
    uint _e133 = local;
    local_16 = _e133;
    uint _e135 = local_16;
    local_17 = uint(_e135);
    uint _e138 = base;
    local_18 = uint((_e138 + uint(5)));
    uint _e145 = local_17;
    uint _e146 = local_18;
    local_54 = uint((_e145 + _e146));
    uint _e150 = local_54;
    _group_0_binding_0_cs[_e150] = uint(_e132);
    int _e155 = second.values[1];
    uint _e156 = local;
    local_19 = _e156;
    uint _e158 = local_19;
    local_20 = uint(_e158);
    uint _e161 = base;
    local_21 = uint((_e161 + uint(6)));
    uint _e168 = local_20;
    uint _e169 = local_21;
    local_55 = uint((_e168 + _e169));
    uint _e173 = local_55;
    _group_0_binding_0_cs[_e173] = uint(_e155);
    int _e176 = total.key;
    uint _e177 = local;
    local_22 = _e177;
    uint _e179 = local_22;
    local_23 = uint(_e179);
    uint _e182 = base;
    local_24 = uint((_e182 + uint(7)));
    uint _e189 = local_23;
    uint _e190 = local_24;
    local_56 = uint((_e189 + _e190));
    uint _e194 = local_56;
    _group_0_binding_0_cs[_e194] = uint(_e176);
    int _e199 = total.values[0];
    uint _e200 = local;
    local_25 = _e200;
    uint _e202 = local_25;
    local_26 = uint(_e202);
    uint _e205 = base;
    local_27 = uint((_e205 + uint(8)));
    uint _e212 = local_26;
    uint _e213 = local_27;
    local_57 = uint((_e212 + _e213));
    uint _e217 = local_57;
    _group_0_binding_0_cs[_e217] = uint(_e199);
    int _e222 = total.values[1];
    uint _e223 = local;
    local_28 = _e223;
    uint _e225 = local_28;
    local_29 = uint(_e225);
    uint _e228 = base;
    local_30 = uint((_e228 + uint(9)));
    uint _e235 = local_29;
    uint _e236 = local_30;
    local_58 = uint((_e235 + _e236));
    uint _e240 = local_58;
    _group_0_binding_0_cs[_e240] = uint(_e222);
    int _e242 = counter;
    counter = (_e242 + 1);
    first_argument = _e242;
    int _e246 = first_argument;
    int _e247 = counter;
    counter = (_e247 + 1);
    int _e250 = pair(_e246, _e247);
    uint _e251 = local;
    local_31 = _e251;
    uint _e253 = local_31;
    local_32 = uint(_e253);
    uint _e256 = base;
    local_33 = uint((_e256 + uint(10)));
    uint _e263 = local_32;
    uint _e264 = local_33;
    local_59 = uint((_e263 + _e264));
    uint _e268 = local_59;
    _group_0_binding_0_cs[_e268] = uint(_e250);
    int _e270 = counter;
    counter = (_e270 + 1);
    consume(_e270);
    int _e273 = counter;
    uint _e274 = local;
    local_34 = _e274;
    uint _e276 = local_34;
    local_35 = uint(_e276);
    uint _e279 = base;
    local_36 = uint((_e279 + uint(11)));
    uint _e286 = local_35;
    uint _e287 = local_36;
    local_60 = uint((_e286 + _e287));
    uint _e291 = local_60;
    _group_0_binding_0_cs[_e291] = uint(_e273);
    float _e294 = generated(0.0);
    uint _e296 = local;
    local_37 = _e296;
    uint _e298 = local_37;
    local_38 = uint(_e298);
    uint _e301 = base;
    local_39 = uint((_e301 + uint(12)));
    uint _e307 = local_38;
    uint _e308 = local_39;
    local_61 = uint((_e307 + _e308));
    uint _e312 = local_61;
    _group_0_binding_0_cs[_e312] = floatBitsToUint(_e294);
    int _e315 = control(3);
    uint _e316 = local;
    local_40 = _e316;
    uint _e318 = local_40;
    local_41 = uint(_e318);
    uint _e321 = base;
    local_42 = uint((_e321 + uint(13)));
    uint _e328 = local_41;
    uint _e329 = local_42;
    local_62 = uint((_e328 + _e329));
    uint _e333 = local_62;
    _group_0_binding_0_cs[_e333] = uint(_e315);
    uint _e335 = lane;
    uint _e336 = local;
    local_43 = _e336;
    uint _e338 = local_43;
    local_44 = uint(_e338);
    uint _e341 = base;
    local_45 = uint((_e341 + uint(14)));
    uint _e347 = local_44;
    uint _e348 = local_45;
    local_63 = uint((_e347 + _e348));
    uint _e352 = local_63;
    _group_0_binding_0_cs[_e352] = _e335;
    int _e354 = counter;
    counter = (_e354 + 1);
    int _e357 = counter;
    int _e358 = forward(_e357);
    uint _e359 = local;
    local_46 = _e359;
    uint _e361 = local_46;
    local_47 = uint(_e361);
    uint _e364 = base;
    local_48 = uint((_e364 + uint(15)));
    uint _e371 = local_47;
    uint _e372 = local_48;
    local_64 = uint((_e371 + _e372));
    uint _e376 = local_64;
    _group_0_binding_0_cs[_e376] = uint(_e358);
}

