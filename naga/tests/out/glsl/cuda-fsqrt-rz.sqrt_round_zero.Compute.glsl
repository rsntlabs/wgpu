#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_sqrtf_rz(uint input_bits) {
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
    return (((_e33 >> 1u) << 23u) | (_e74 & 8388607u));
}

float truncated_sqrt(float value) {
    uint _e2 = _naga_sqrtf_rz(floatBitsToUint(value));
    return uintBitsToFloat(_e2);
}

int _fsqrt_rz(bool value_1) {
    int local_20 = 0;
    if (value_1) {
        local_20 = 7;
    } else {
        local_20 = 9;
    }
    int _e6 = local_20;
    return _e6;
}

uint _naga_fabsf(uint input_bits_1) {
    uint _e2 = (input_bits_1 & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

uint _naga_sqrtf(uint input_bits_2) {
    uint significand_1 = 0u;
    uint adjusted_exponent_1 = 0u;
    uint upper_word_1 = 0u;
    uint lower_word_1 = 0u;
    uint root_1 = 0u;
    uint remainder_1 = 0u;
    uint iteration_1 = 0u;
    uint _e5 = (input_bits_2 & 2147483647u);
    if (((_e5 == 0u) || (input_bits_2 == 2139095040u))) {
        return input_bits_2;
    }
    if ((((input_bits_2 & 2147483648u) != 0u) || (_e5 > 2139095040u))) {
        return 2143289344u;
    }
    uint _e19 = (input_bits_2 & 8388607u);
    uint _e20 = (_e5 >> 23u);
    significand_1 = (_e19 | 8388608u);
    adjusted_exponent_1 = (_e20 + 127u);
    if ((_e20 == 0u)) {
        uint _e28 = (uint(31 - findMSB(_e19)) - 8u);
        significand_1 = (_e19 << _e28);
        adjusted_exponent_1 = (128u - _e28);
    }
    uint _e32 = significand_1;
    uint _e33 = adjusted_exponent_1;
    uint _e34 = (_e33 & 1u);
    upper_word_1 = (_e32 >> (9u - _e34));
    lower_word_1 = (_e32 << (23u + _e34));
    root_1 = 0u;
    remainder_1 = 0u;
    iteration_1 = 0u;
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            uint _e72 = iteration_1;
            iteration_1 = (_e72 + 1u);
        }
        loop_init_1 = false;
        uint _e50 = iteration_1;
        if ((_e50 >= 24u)) {
            break;
        }
        uint _e52 = upper_word_1;
        uint _e53 = lower_word_1;
        uint _e54 = root_1;
        uint _e55 = remainder_1;
        uint _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        uint _e65 = ((_e54 << 2u) | 1u);
        bool _e66 = (_e63 >= _e65);
        uint _e69 = (_e54 << 1u);
        upper_word_1 = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word_1 = (_e53 << 2u);
        remainder_1 = (_e66 ? (_e63 - _e65) : _e63);
        root_1 = (_e66 ? (_e69 | 1u) : _e69);
    }
    uint _e74 = root_1;
    uint _e75 = remainder_1;
    return (((_e33 >> 1u) << 23u) | (((_e75 > _e74) ? (_e74 + 1u) : _e74) & 8388607u));
}

uint _naga_sqrtf_ru(uint input_bits_3) {
    uint significand_2 = 0u;
    uint adjusted_exponent_2 = 0u;
    uint upper_word_2 = 0u;
    uint lower_word_2 = 0u;
    uint root_2 = 0u;
    uint remainder_2 = 0u;
    uint iteration_2 = 0u;
    uint _e5 = (input_bits_3 & 2147483647u);
    if (((_e5 == 0u) || (input_bits_3 == 2139095040u))) {
        return input_bits_3;
    }
    if ((((input_bits_3 & 2147483648u) != 0u) || (_e5 > 2139095040u))) {
        return 2143289344u;
    }
    uint _e19 = (input_bits_3 & 8388607u);
    uint _e20 = (_e5 >> 23u);
    significand_2 = (_e19 | 8388608u);
    adjusted_exponent_2 = (_e20 + 127u);
    if ((_e20 == 0u)) {
        uint _e28 = (uint(31 - findMSB(_e19)) - 8u);
        significand_2 = (_e19 << _e28);
        adjusted_exponent_2 = (128u - _e28);
    }
    uint _e32 = significand_2;
    uint _e33 = adjusted_exponent_2;
    uint _e34 = (_e33 & 1u);
    upper_word_2 = (_e32 >> (9u - _e34));
    lower_word_2 = (_e32 << (23u + _e34));
    root_2 = 0u;
    remainder_2 = 0u;
    iteration_2 = 0u;
    bool loop_init_2 = true;
    while(true) {
        if (!loop_init_2) {
            uint _e72 = iteration_2;
            iteration_2 = (_e72 + 1u);
        }
        loop_init_2 = false;
        uint _e50 = iteration_2;
        if ((_e50 >= 24u)) {
            break;
        }
        uint _e52 = upper_word_2;
        uint _e53 = lower_word_2;
        uint _e54 = root_2;
        uint _e55 = remainder_2;
        uint _e63 = ((_e55 << 2u) | (_e52 >> 14u));
        uint _e65 = ((_e54 << 2u) | 1u);
        bool _e66 = (_e63 >= _e65);
        uint _e69 = (_e54 << 1u);
        upper_word_2 = (((_e52 << 2u) | (_e53 >> 30u)) & 65535u);
        lower_word_2 = (_e53 << 2u);
        remainder_2 = (_e66 ? (_e63 - _e65) : _e63);
        root_2 = (_e66 ? (_e69 | 1u) : _e69);
    }
    uint _e74 = root_2;
    uint _e75 = remainder_2;
    uint _e78 = ((_e75 > 0u) ? (_e74 + 1u) : _e74);
    return ((((_e33 >> 1u) + (_e78 >> 24u)) << 23u) | (_e78 & 8388607u));
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint local = 0u;
    int cursor = 0;
    uint local_1 = 0u;
    uint local_2 = 0u;
    bool local_3 = false;
    bool local_4 = false;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    float local_12 = 0.0;
    uint local_13 = 0u;
    int directed_cursor = 0;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 14u));
    uint _e15 = _group_0_binding_0_cs[index];
    float value_2 = uintBitsToFloat(_e15);
    uint _e18 = _naga_sqrtf_rz(floatBitsToUint(value_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e18));
    float _e23 = truncated_sqrt(value_2);
    local = uint((base + 1u));
    uint _e29 = local;
    _group_0_binding_1_cs[_e29] = floatBitsToUint(_e23);
    cursor = 0;
    int _e33 = cursor;
    cursor = (_e33 + 1);
    local_2 = uint((index + uint(_e33)));
    uint _e40 = local_2;
    uint _e42 = _group_0_binding_0_cs[_e40];
    float _e44 = truncated_sqrt(uintBitsToFloat(_e42));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    _group_0_binding_1_cs[_e50] = floatBitsToUint(_e44);
    local_3 = false;
    if (false) {
        int _e54 = cursor;
        cursor = (_e54 + 1);
        uint _e59 = _naga_sqrtf_rz(floatBitsToUint(float(_e54)));
        uint _e62 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if (true) {
    } else {
        int _e67 = cursor;
        cursor = (_e67 + 1);
        uint _e72 = _naga_sqrtf_rz(floatBitsToUint(float(_e67)));
        uint _e75 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e72)));
        local_4 = (_e75 != 0u);
    }
    int _e78 = cursor;
    local_5 = uint((base + 3u));
    uint _e84 = local_5;
    _group_0_binding_1_cs[_e84] = uint(_e78);
    uint _e89 = _naga_sqrtf_rz(floatBitsToUint(-(0.0)));
    local_6 = uint((base + 4u));
    uint _e96 = local_6;
    _group_0_binding_1_cs[_e96] = floatBitsToUint(uintBitsToFloat(_e89));
    local_8 = 2139095040u;
    uint _e100 = local_8;
    uint _e103 = _naga_sqrtf_rz(floatBitsToUint(uintBitsToFloat(_e100)));
    local_7 = uint((base + 5u));
    uint _e110 = local_7;
    _group_0_binding_1_cs[_e110] = floatBitsToUint(uintBitsToFloat(_e103));
    float _e114 = truncated_sqrt(float(4u));
    local_9 = uint((base + 6u));
    uint _e120 = local_9;
    _group_0_binding_1_cs[_e120] = floatBitsToUint(_e114);
    int _e123 = _fsqrt_rz(true);
    local_10 = uint((base + 7u));
    uint _e129 = local_10;
    _group_0_binding_1_cs[_e129] = uint(_e123);
    if (true) {
        uint _e133 = _naga_sqrtf_rz(floatBitsToUint(value_2));
        local_12 = uintBitsToFloat(_e133);
    } else {
        int _e136 = cursor;
        cursor = (_e136 + 1);
        uint _e141 = _naga_sqrtf_rz(floatBitsToUint(float(_e136)));
        local_12 = uintBitsToFloat(_e141);
    }
    float _e145 = local_12;
    local_11 = uint((base + 8u));
    uint _e151 = local_11;
    _group_0_binding_1_cs[_e151] = floatBitsToUint(_e145);
    uint _e154 = _naga_sqrtf(floatBitsToUint(value_2));
    local_13 = uint((base + 9u));
    uint _e161 = local_13;
    _group_0_binding_1_cs[_e161] = floatBitsToUint(uintBitsToFloat(_e154));
    directed_cursor = 0;
    int _e165 = directed_cursor;
    directed_cursor = (_e165 + 1);
    local_15 = uint((index + uint(_e165)));
    uint _e172 = local_15;
    uint _e174 = _group_0_binding_0_cs[_e172];
    uint _e177 = _naga_sqrtf_rz(floatBitsToUint(uintBitsToFloat(_e174)));
    local_14 = uint((base + 10u));
    uint _e184 = local_14;
    _group_0_binding_1_cs[_e184] = floatBitsToUint(uintBitsToFloat(_e177));
    int _e186 = directed_cursor;
    local_16 = uint((base + 11u));
    uint _e192 = local_16;
    _group_0_binding_1_cs[_e192] = uint(_e186);
    directed_cursor = 0;
    int _e195 = directed_cursor;
    directed_cursor = (_e195 + 1);
    local_18 = uint((index + uint(_e195)));
    uint _e202 = local_18;
    uint _e204 = _group_0_binding_0_cs[_e202];
    uint _e207 = _naga_sqrtf_ru(floatBitsToUint(uintBitsToFloat(_e204)));
    local_17 = uint((base + 12u));
    uint _e214 = local_17;
    _group_0_binding_1_cs[_e214] = floatBitsToUint(uintBitsToFloat(_e207));
    int _e216 = directed_cursor;
    local_19 = uint((base + 13u));
    uint _e222 = local_19;
    _group_0_binding_1_cs[_e222] = uint(_e216);
}

