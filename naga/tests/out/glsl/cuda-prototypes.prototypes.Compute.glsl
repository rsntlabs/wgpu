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
    return (10 + int(value));
}

int earlier(int value_1) {
    int _e2 = route(float(value_1));
    return _e2;
}

int route_1(int value_2) {
    return (20 + value_2);
}

int forward(int value_3) {
    int _e1 = route_1(value_3);
    int _e2 = earlier(value_3);
    return (_e1 + _e2);
}

Packet_cuda_record_0_ packet(int value_4) {
    Packet_cuda_record_0_ local_80 = Packet_cuda_record_0_(0, int[2](0, 0));
    local_80.key = value_4;
    local_80.values[0] = (value_4 + 1);
    local_80.values[1] = (value_4 + 2);
    Packet_cuda_record_0_ _e10 = local_80;
    return _e10;
}

Packet_cuda_record_0_ adjust(Packet_cuda_record_0_ value_5) {
    Packet_cuda_record_0_ value_6 = Packet_cuda_record_0_(0, int[2](0, 0));
    value_6 = value_5;
    int _e4 = value_6.key;
    value_6.key = (_e4 + 4);
    int _e10 = value_6.values[1];
    value_6.values[1] = (_e10 + 6);
    Packet_cuda_record_0_ _e12 = value_6;
    return _e12;
}

Packet_cuda_record_0_ operator_u002b(Packet_cuda_record_0_ left, Packet_cuda_record_0_ right) {
    Packet_cuda_record_0_ left_1 = Packet_cuda_record_0_(0, int[2](0, 0));
    Packet_cuda_record_0_ right_1 = Packet_cuda_record_0_(0, int[2](0, 0));
    Packet_cuda_record_0_ local_81 = Packet_cuda_record_0_(0, int[2](0, 0));
    left_1 = left;
    right_1 = right;
    int _e7 = left_1.key;
    int _e8 = right_1.key;
    local_81.key = (_e7 + _e8);
    int _e18 = left_1.values[0];
    int _e19 = right_1.values[0];
    local_81.values[0] = (_e18 + _e19);
    int _e29 = left_1.values[1];
    int _e30 = right_1.values[1];
    local_81.values[1] = (_e29 + _e30);
    Packet_cuda_record_0_ _e32 = local_81;
    return _e32;
}

int pair(int first_1, int second_1) {
    return ((first_1 * 10) + second_1);
}

void consume(int value_7) {
    if ((value_7 != 0)) {
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

uint[12] _naga_trig_divide(uint value_8[12], uint divisor) {
    uint source_1[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint result_2[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint remainder_1 = 0u;
    uint step_ = 0u;
    source_1 = value_8;
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

float generated(float value_9) {
    uint _e3 = _naga_sqrtf(floatBitsToUint(4.0));
    uint _e7 = _naga_trigonometry(floatBitsToUint(value_9), 0u);
    uint _e12 = _naga_trigonometry(floatBitsToUint(value_9), 1u);
    return ((uintBitsToFloat(_e3) + uintBitsToFloat(_e7)) + uintBitsToFloat(_e12));
}

int control(int count) {
    int result_4 = 0;
    int index = 0;
    result_4 = 0;
    {
        index = 0;
        bool loop_init_13 = true;
        while(true) {
            if (!loop_init_13) {
                int _e22 = index;
                index = (_e22 + 1);
            }
            loop_init_13 = false;
            int _e5 = index;
            if ((_e5 < count)) {
            } else {
                break;
            }
            int _e7 = index;
            if ((_e7 == 1)) {
                continue;
            }
            int _e10 = index;
            switch(_e10) {
                case 0: {
                    int _e11 = index;
                    int _e12 = route_1(_e11);
                    int _e13 = result_4;
                    result_4 = (_e13 + _e12);
                    break;
                }
                default: {
                    int _e15 = index;
                    int _e16 = forward(_e15);
                    int _e17 = index;
                    int _e18 = earlier(_e17);
                    int _e20 = result_4;
                    result_4 = (_e20 + (_e16 - _e18));
                    break;
                }
            }
        }
    }
    int _e25 = result_4;
    return _e25;
}

uint late_index() {
    uvec3 _e1 = blockIdx_1;
    uvec3 _e6 = threadIdx_1;
    return ((_e1.x * 2u) + _e6.x);
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint out_[2] = uint[2](0u, 0u);
    int counter = 0;
    Packet_cuda_record_0_ first = Packet_cuda_record_0_(0, int[2](0, 0));
    Packet_cuda_record_0_ second = Packet_cuda_record_0_(0, int[2](0, 0));
    Packet_cuda_record_0_ total = Packet_cuda_record_0_(0, int[2](0, 0));
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
    uint local_34 = 0u;
    uint local_35[2] = uint[2](0u, 0u);
    uint local_36 = 0u;
    uint local_37 = 0u;
    uint local_38[2] = uint[2](0u, 0u);
    uint local_39 = 0u;
    uint local_40 = 0u;
    uint local_41[2] = uint[2](0u, 0u);
    uint local_42 = 0u;
    uint local_43 = 0u;
    uint local_44[2] = uint[2](0u, 0u);
    uint local_45 = 0u;
    uint local_46 = 0u;
    uint local_47[2] = uint[2](0u, 0u);
    uint local_48 = 0u;
    uint local_49 = 0u;
    uint local_50[2] = uint[2](0u, 0u);
    uint local_51 = 0u;
    uint local_52 = 0u;
    uint local_53[2] = uint[2](0u, 0u);
    uint local_54 = 0u;
    uint local_55 = 0u;
    uint local_56[2] = uint[2](0u, 0u);
    uint local_57 = 0u;
    uint local_58 = 0u;
    uint local_59[2] = uint[2](0u, 0u);
    uint local_60 = 0u;
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
    threadIdx_1 = threadIdx;
    blockIdx_1 = blockIdx;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    uint _e10 = late_index();
    uint base = (_e10 * 16u);
    counter = 1;
    int _e15 = counter;
    counter = (_e15 + 1);
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
    uint _e30[2] = out_;
    local = _e30;
    local_1 = uint(base);
    uint _e35[2] = local;
    local_32 = _e35;
    uint _e37 = local_1;
    uint _e39 = local_32[1];
    local_32[1] = (_e39 + _e37);
    uint _e43 = local_32[0];
    local_33 = uint(_e43);
    uint _e47 = local_32[1];
    local_34 = uint(_e47);
    uint _e50 = local_34;
    _group_0_binding_0_cs[_e50] = uint(_e28);
    int _e54 = route_1(3);
    uint _e55[2] = out_;
    local_2 = _e55;
    local_3 = uint((base + uint(1)));
    uint _e63[2] = local_2;
    local_35 = _e63;
    uint _e65 = local_3;
    uint _e67 = local_35[1];
    local_35[1] = (_e67 + _e65);
    uint _e71 = local_35[0];
    local_36 = uint(_e71);
    uint _e75 = local_35[1];
    local_37 = uint(_e75);
    uint _e78 = local_37;
    _group_0_binding_0_cs[_e78] = uint(_e54);
    int _e81 = forward(4);
    uint _e82[2] = out_;
    local_4 = _e82;
    local_5 = uint((base + uint(2)));
    uint _e90[2] = local_4;
    local_38 = _e90;
    uint _e92 = local_5;
    uint _e94 = local_38[1];
    local_38[1] = (_e94 + _e92);
    uint _e98 = local_38[0];
    local_39 = uint(_e98);
    uint _e102 = local_38[1];
    local_40 = uint(_e102);
    uint _e105 = local_40;
    _group_0_binding_0_cs[_e105] = uint(_e81);
    int _e108 = first.key;
    uint _e109[2] = out_;
    local_6 = _e109;
    local_7 = uint((base + uint(3)));
    uint _e117[2] = local_6;
    local_41 = _e117;
    uint _e119 = local_7;
    uint _e121 = local_41[1];
    local_41[1] = (_e121 + _e119);
    uint _e125 = local_41[0];
    local_42 = uint(_e125);
    uint _e129 = local_41[1];
    local_43 = uint(_e129);
    uint _e132 = local_43;
    _group_0_binding_0_cs[_e132] = uint(_e108);
    int _e137 = first.values[1];
    uint _e138[2] = out_;
    local_8 = _e138;
    local_9 = uint((base + uint(4)));
    uint _e146[2] = local_8;
    local_44 = _e146;
    uint _e148 = local_9;
    uint _e150 = local_44[1];
    local_44[1] = (_e150 + _e148);
    uint _e154 = local_44[0];
    local_45 = uint(_e154);
    uint _e158 = local_44[1];
    local_46 = uint(_e158);
    uint _e161 = local_46;
    _group_0_binding_0_cs[_e161] = uint(_e137);
    int _e164 = second.key;
    uint _e165[2] = out_;
    local_10 = _e165;
    local_11 = uint((base + uint(5)));
    uint _e173[2] = local_10;
    local_47 = _e173;
    uint _e175 = local_11;
    uint _e177 = local_47[1];
    local_47[1] = (_e177 + _e175);
    uint _e181 = local_47[0];
    local_48 = uint(_e181);
    uint _e185 = local_47[1];
    local_49 = uint(_e185);
    uint _e188 = local_49;
    _group_0_binding_0_cs[_e188] = uint(_e164);
    int _e193 = second.values[1];
    uint _e194[2] = out_;
    local_12 = _e194;
    local_13 = uint((base + uint(6)));
    uint _e202[2] = local_12;
    local_50 = _e202;
    uint _e204 = local_13;
    uint _e206 = local_50[1];
    local_50[1] = (_e206 + _e204);
    uint _e210 = local_50[0];
    local_51 = uint(_e210);
    uint _e214 = local_50[1];
    local_52 = uint(_e214);
    uint _e217 = local_52;
    _group_0_binding_0_cs[_e217] = uint(_e193);
    int _e220 = total.key;
    uint _e221[2] = out_;
    local_14 = _e221;
    local_15 = uint((base + uint(7)));
    uint _e229[2] = local_14;
    local_53 = _e229;
    uint _e231 = local_15;
    uint _e233 = local_53[1];
    local_53[1] = (_e233 + _e231);
    uint _e237 = local_53[0];
    local_54 = uint(_e237);
    uint _e241 = local_53[1];
    local_55 = uint(_e241);
    uint _e244 = local_55;
    _group_0_binding_0_cs[_e244] = uint(_e220);
    int _e249 = total.values[0];
    uint _e250[2] = out_;
    local_16 = _e250;
    local_17 = uint((base + uint(8)));
    uint _e258[2] = local_16;
    local_56 = _e258;
    uint _e260 = local_17;
    uint _e262 = local_56[1];
    local_56[1] = (_e262 + _e260);
    uint _e266 = local_56[0];
    local_57 = uint(_e266);
    uint _e270 = local_56[1];
    local_58 = uint(_e270);
    uint _e273 = local_58;
    _group_0_binding_0_cs[_e273] = uint(_e249);
    int _e278 = total.values[1];
    uint _e279[2] = out_;
    local_18 = _e279;
    local_19 = uint((base + uint(9)));
    uint _e287[2] = local_18;
    local_59 = _e287;
    uint _e289 = local_19;
    uint _e291 = local_59[1];
    local_59[1] = (_e291 + _e289);
    uint _e295 = local_59[0];
    local_60 = uint(_e295);
    uint _e299 = local_59[1];
    local_61 = uint(_e299);
    uint _e302 = local_61;
    _group_0_binding_0_cs[_e302] = uint(_e278);
    int first_argument = counter;
    counter = (first_argument + 1);
    int _e307 = counter;
    counter = (_e307 + 1);
    int _e310 = pair(first_argument, _e307);
    uint _e311[2] = out_;
    local_20 = _e311;
    local_21 = uint((base + uint(10)));
    uint _e319[2] = local_20;
    local_62 = _e319;
    uint _e321 = local_21;
    uint _e323 = local_62[1];
    local_62[1] = (_e323 + _e321);
    uint _e327 = local_62[0];
    local_63 = uint(_e327);
    uint _e331 = local_62[1];
    local_64 = uint(_e331);
    uint _e334 = local_64;
    _group_0_binding_0_cs[_e334] = uint(_e310);
    int _e336 = counter;
    counter = (_e336 + 1);
    consume(_e336);
    int _e339 = counter;
    uint _e340[2] = out_;
    local_22 = _e340;
    local_23 = uint((base + uint(11)));
    uint _e348[2] = local_22;
    local_65 = _e348;
    uint _e350 = local_23;
    uint _e352 = local_65[1];
    local_65[1] = (_e352 + _e350);
    uint _e356 = local_65[0];
    local_66 = uint(_e356);
    uint _e360 = local_65[1];
    local_67 = uint(_e360);
    uint _e363 = local_67;
    _group_0_binding_0_cs[_e363] = uint(_e339);
    float _e366 = generated(0.0);
    uint _e368[2] = out_;
    local_24 = _e368;
    local_25 = uint((base + uint(12)));
    uint _e375[2] = local_24;
    local_68 = _e375;
    uint _e377 = local_25;
    uint _e379 = local_68[1];
    local_68[1] = (_e379 + _e377);
    uint _e383 = local_68[0];
    local_69 = uint(_e383);
    uint _e387 = local_68[1];
    local_70 = uint(_e387);
    uint _e390 = local_70;
    _group_0_binding_0_cs[_e390] = floatBitsToUint(_e366);
    int _e393 = control(3);
    uint _e394[2] = out_;
    local_26 = _e394;
    local_27 = uint((base + uint(13)));
    uint _e402[2] = local_26;
    local_71 = _e402;
    uint _e404 = local_27;
    uint _e406 = local_71[1];
    local_71[1] = (_e406 + _e404);
    uint _e410 = local_71[0];
    local_72 = uint(_e410);
    uint _e414 = local_71[1];
    local_73 = uint(_e414);
    uint _e417 = local_73;
    _group_0_binding_0_cs[_e417] = uint(_e393);
    uint _e419[2] = out_;
    local_28 = _e419;
    local_29 = uint((base + uint(14)));
    uint _e426[2] = local_28;
    local_74 = _e426;
    uint _e428 = local_29;
    uint _e430 = local_74[1];
    local_74[1] = (_e430 + _e428);
    uint _e434 = local_74[0];
    local_75 = uint(_e434);
    uint _e438 = local_74[1];
    local_76 = uint(_e438);
    uint _e441 = local_76;
    _group_0_binding_0_cs[_e441] = _e10;
    int _e443 = counter;
    counter = (_e443 + 1);
    int _e446 = counter;
    int _e447 = forward(_e446);
    uint _e448[2] = out_;
    local_30 = _e448;
    local_31 = uint((base + uint(15)));
    uint _e456[2] = local_30;
    local_77 = _e456;
    uint _e458 = local_31;
    uint _e460 = local_77[1];
    local_77[1] = (_e460 + _e458);
    uint _e464 = local_77[0];
    local_78 = uint(_e464);
    uint _e468 = local_77[1];
    local_79 = uint(_e468);
    uint _e471 = local_79;
    _group_0_binding_0_cs[_e471] = uint(_e447);
}

