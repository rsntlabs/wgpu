#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };

layout(std430) buffer type_1_block_1Compute { float _group_0_binding_1_cs[]; };


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

uint[12] _naga_trig_kernel(uint angle[12], uint sine_1) {
    uint term[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint total[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint step_1 = 0u;
    bool _e7 = (sine_1 != 0u);
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

uint _naga_trigonometry(uint input_bits, uint cosine_1) {
    uint quadrant = 0u;
    uint fraction[12] = uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint fraction_index = 0u;
    uint _e3 = (input_bits & 2147483647u);
    if ((_e3 >= 2139095040u)) {
        return 2143289344u;
    }
    bool _e8 = (cosine_1 != 0u);
    if ((_e3 <= 956301312u)) {
        return ((cosine_1 * 1065353216u) | ((1u - cosine_1) * input_bits));
    }
    uint _e20 = (470u - (_e3 >> 23u));
    uint _e24 = ((_e3 & 8388607u) | 8388608u);
    uint _e51[22] = _naga_trig_reduce_multiply(uint[2]((_e24 & 65535u), (_e24 >> 16u)), uint[20](53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    uint _e54 = _naga_trig_extract_product(_e51, _e20);
    quadrant = (_e54 & 3u);
    fraction_index = 0u;
    bool loop_init_11 = true;
    while(true) {
        if (!loop_init_11) {
            uint _e72 = fraction_index;
            fraction_index = (_e72 + 1u);
        }
        loop_init_11 = false;
        uint _e64 = fraction_index;
        if ((_e64 >= 11u)) {
            break;
        }
        uint _e70 = _naga_trig_extract_product(_e51, ((_e20 - 176u) + (_e64 * 16u)));
        fraction[_e64] = _e70;
    }
    uint _e77 = fraction[10u];
    bool _e79 = (_e77 >= 32768u);
    if (_e79) {
        uint _e93 = quadrant;
        quadrant = ((_e93 + 1u) & 3u);
        uint _e98[12] = fraction;
        uint _e100[12] = _naga_trig_combine(uint[12](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u), _e98, 1u);
        fraction = _e100;
    }
    uint _e101[12] = fraction;
    uint _e115[12] = _naga_trig_multiply(_e101, uint[12](5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u));
    uint _e116 = quadrant;
    bool _e119 = ((_e116 & 1u) == cosine_1);
    uint _e123[12] = _naga_trig_kernel(_e115, (_e119 ? 1u : 0u));
    uint _e124 = _naga_trig_round(_e123);
    return (_e124 | ((((_e79 && _e119) ? 2147483648u : 0u) ^ (((_e8 ? (_e116 + 1u) : _e116) & 2u) << 30u)) ^ (_e8 ? 0u : (input_bits & 2147483648u))));
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    float value = 0.0;
    float sine = 0.0;
    float cosine = 0.0;
    uint local = 0u;
    uint cursor = 0u;
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
    uint lane = threadIdx.x;
    uint base = (4u + (lane * 16u));
    float _e8 = _group_0_binding_0_cs[lane];
    value = _e8;
    float _e10 = value;
    uint _e13 = _naga_trigonometry(floatBitsToUint(_e10), 0u);
    uint _e17 = _naga_trigonometry(floatBitsToUint(_e10), 1u);
    sine = uintBitsToFloat(_e13);
    cosine = uintBitsToFloat(_e17);
    float _e21 = sine;
    _group_0_binding_1_cs[base] = _e21;
    float _e24 = cosine;
    local = uint((base + 1u));
    uint _e29 = local;
    _group_0_binding_1_cs[_e29] = _e24;
    cursor = (base + 2u);
    float _e34 = value;
    value = (_e34 + float(1));
    uint _e38 = cursor;
    cursor = (_e38 + uint(1));
    uint _e42 = cursor;
    cursor = (_e42 + uint(1));
    uint _e48 = _naga_trigonometry(floatBitsToUint(_e34), 0u);
    uint _e52 = _naga_trigonometry(floatBitsToUint(_e34), 1u);
    _group_0_binding_1_cs[_e38] = uintBitsToFloat(_e48);
    _group_0_binding_1_cs[_e42] = uintBitsToFloat(_e52);
    uint _e56 = cursor;
    local_1 = uint((base + 4u));
    uint _e62 = local_1;
    _group_0_binding_1_cs[_e62] = float(_e56);
    float _e64 = value;
    local_2 = uint((base + 5u));
    uint _e69 = local_2;
    _group_0_binding_1_cs[_e69] = _e64;
    uint _e74 = _naga_trigonometry(floatBitsToUint(0.0), 0u);
    uint _e78 = _naga_trigonometry(floatBitsToUint(0.0), 1u);
    sine = uintBitsToFloat(_e74);
    sine = uintBitsToFloat(_e78);
    float _e80 = sine;
    local_3 = uint((base + 6u));
    uint _e85 = local_3;
    _group_0_binding_1_cs[_e85] = _e80;
    float _e87 = cosine;
    local_4 = uint((base + 7u));
    uint _e92 = local_4;
    _group_0_binding_1_cs[_e92] = _e87;
    float _e95 = _group_0_binding_0_cs[lane];
    value = _e95;
    float _e96 = value;
    uint _e97 = floatBitsToUint(_e96);
    uint _e104 = (((_e97 & 2139095040u) == 0u) ? (_e97 & 2147483648u) : _e97);
    uint _e106 = _naga_trigonometry(_e104, 0u);
    uint _e108 = _naga_trigonometry(_e104, 1u);
    sine = uintBitsToFloat((((_e106 & 2139095040u) == 0u) ? (_e106 & 2147483648u) : _e106));
    cosine = uintBitsToFloat((((_e108 & 2139095040u) == 0u) ? (_e108 & 2147483648u) : _e108));
    float _e125 = sine;
    local_5 = uint((base + 8u));
    uint _e130 = local_5;
    _group_0_binding_1_cs[_e130] = _e125;
    float _e132 = cosine;
    local_6 = uint((base + 9u));
    uint _e137 = local_6;
    _group_0_binding_1_cs[_e137] = _e132;
    cursor = (base + 10u);
    float _e141 = value;
    value = (_e141 + float(1));
    uint _e145 = cursor;
    cursor = (_e145 + uint(1));
    uint _e149 = cursor;
    cursor = (_e149 + uint(1));
    uint _e153 = floatBitsToUint(_e141);
    uint _e160 = (((_e153 & 2139095040u) == 0u) ? (_e153 & 2147483648u) : _e153);
    uint _e162 = _naga_trigonometry(_e160, 0u);
    uint _e164 = _naga_trigonometry(_e160, 1u);
    _group_0_binding_1_cs[_e145] = uintBitsToFloat((((_e162 & 2139095040u) == 0u) ? (_e162 & 2147483648u) : _e162));
    _group_0_binding_1_cs[_e149] = uintBitsToFloat((((_e164 & 2139095040u) == 0u) ? (_e164 & 2147483648u) : _e164));
    uint _e183 = cursor;
    local_7 = uint((base + 12u));
    uint _e189 = local_7;
    _group_0_binding_1_cs[_e189] = float(_e183);
    float _e191 = value;
    local_8 = uint((base + 13u));
    uint _e196 = local_8;
    _group_0_binding_1_cs[_e196] = _e191;
    float _e199 = _group_0_binding_0_cs[lane];
    uint _e200 = floatBitsToUint(_e199);
    uint _e207 = (((_e200 & 2139095040u) == 0u) ? (_e200 & 2147483648u) : _e200);
    uint _e209 = _naga_trigonometry(_e207, 0u);
    uint _e211 = _naga_trigonometry(_e207, 1u);
    sine = uintBitsToFloat((((_e209 & 2139095040u) == 0u) ? (_e209 & 2147483648u) : _e209));
    sine = uintBitsToFloat((((_e211 & 2139095040u) == 0u) ? (_e211 & 2147483648u) : _e211));
    float _e228 = sine;
    local_9 = uint((base + 14u));
    uint _e233 = local_9;
    _group_0_binding_1_cs[_e233] = _e228;
    float _e235 = cosine;
    local_10 = uint((base + 15u));
    uint _e240 = local_10;
    _group_0_binding_1_cs[_e240] = _e235;
}

