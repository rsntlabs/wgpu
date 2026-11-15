#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_frsqrt_rn(uint input_bits) {
    uint significand = 0u;
    uint trial_bit = 0u;
    uint _e7 = (input_bits & 2147483647u);
    uint _e8 = (input_bits & 2147483648u);
    if ((_e7 == 0u)) {
        return (_e8 | 2139095040u);
    }
    if (((_e8 != 0u) || (_e7 > 2139095040u))) {
        return 2143289344u;
    }
    if ((_e7 == 2139095040u)) {
        return 0u;
    }
    uint _e18 = (_e7 >> 23u);
    uint _e19 = (_e7 & 8388607u);
    bool _e20 = (_e18 != 0u);
    uint _e25 = (uint(31 - findMSB((_e19 | 1u))) - 8u);
    uint _e29 = (_e20 ? (_e19 | 8388608u) : (_e19 << (_e25 & 31u)));
    int _e35 = (_e20 ? int(_e18) : (1 - int(_e25)));
    int _e37 = (_e35 - 127);
    int _e46 = ((-((_e37 + 1)) >> 1u) + int((((_e37 & 1) == 0) && (_e29 == 8388608u))));
    uint _e52 = uint(((198 - _e35) - (_e46 * 2)));
    significand = 8388608u;
    trial_bit = 22u;
    while(true) {
        uint _e56 = significand;
        uint _e57 = trial_bit;
        uint _e60 = (_e56 | (1u << (_e57 & 31u)));
        uint _e61 = (_e60 << 1u);
        uint _e65 = (_e61 & 4095u);
        uint _e66 = (_e61 >> 12u);
        uint _e67 = (_e65 * _e65);
        uint _e71 = ((2u * (_e65 * _e66)) + (_e67 >> 12u));
        uint _e74 = ((_e66 * _e66) + (_e71 >> 12u));
        uint _e75 = (_e67 & 4095u);
        uint _e76 = (_e71 & 4095u);
        uint _e77 = (_e74 & 4095u);
        uint _e79 = ((_e74 >> 12u) & 4095u);
        uint _e81 = (_e74 >> 24u);
        uint _e82 = (_e29 & 4095u);
        uint _e83 = (_e29 >> 12u);
        uint _e108 = (((_e83 * _e81) + ((((_e82 * _e81) + (_e83 * _e79)) + ((((_e82 * _e79) + (_e83 * _e77)) + ((((_e82 * _e77) + (_e83 * _e76)) + ((((_e82 * _e76) + (_e83 * _e75)) + ((_e82 * _e75) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u);
        significand = ((((71u + uint((_e108 != 0u))) + uint((_e108 >= 2u))) < _e52) ? _e60 : _e56);
        if ((_e57 == 0u)) {
            break;
        }
        trial_bit = (_e57 - 1u);
    }
    uint _e121 = significand;
    uint _e123 = ((_e121 << 1u) + 1u);
    uint _e127 = (_e123 & 4095u);
    uint _e128 = (_e123 >> 12u);
    uint _e129 = (_e127 * _e127);
    uint _e133 = ((2u * (_e127 * _e128)) + (_e129 >> 12u));
    uint _e136 = ((_e128 * _e128) + (_e133 >> 12u));
    uint _e137 = (_e129 & 4095u);
    uint _e138 = (_e133 & 4095u);
    uint _e139 = (_e136 & 4095u);
    uint _e141 = ((_e136 >> 12u) & 4095u);
    uint _e143 = (_e136 >> 24u);
    uint _e144 = (_e29 & 4095u);
    uint _e145 = (_e29 >> 12u);
    uint _e170 = (((_e145 * _e143) + ((((_e144 * _e143) + (_e145 * _e141)) + ((((_e144 * _e141) + (_e145 * _e139)) + ((((_e144 * _e139) + (_e145 * _e138)) + ((((_e144 * _e138) + (_e145 * _e137)) + ((_e144 * _e137) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u)) >> 12u);
    uint _e181 = (_e121 + uint((((71u + uint((_e170 != 0u))) + uint((_e170 >= 2u))) < _e52)));
    bool _e183 = (_e181 >= 16777216u);
    return ((uint(((_e46 + int(_e183)) + 127)) << 23u) | ((_e183 ? (_e181 >> 1u) : _e181) & 8388607u));
}

float reciprocal_sqrt_value(float value) {
    uint _e2 = _naga_frsqrt_rn(floatBitsToUint(value));
    return uintBitsToFloat(_e2);
}

int _frsqrt_rn(bool value_1) {
    int local_14 = 0;
    if (value_1) {
        local_14 = 7;
    } else {
        local_14 = 9;
    }
    int _e6 = local_14;
    return _e6;
}

uint _naga_fabsf(uint input_bits_1) {
    uint _e2 = (input_bits_1 & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
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
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 10u));
    uint _e15 = _group_0_binding_0_cs[index];
    float value_2 = uintBitsToFloat(_e15);
    uint _e18 = _naga_frsqrt_rn(floatBitsToUint(value_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e18));
    float _e23 = reciprocal_sqrt_value(value_2);
    local = uint((base + 1u));
    uint _e29 = local;
    _group_0_binding_1_cs[_e29] = floatBitsToUint(_e23);
    cursor = 0;
    int _e33 = cursor;
    cursor = (_e33 + 1);
    local_2 = uint((index + uint(_e33)));
    uint _e40 = local_2;
    uint _e42 = _group_0_binding_0_cs[_e40];
    float _e44 = reciprocal_sqrt_value(uintBitsToFloat(_e42));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    _group_0_binding_1_cs[_e50] = floatBitsToUint(_e44);
    local_3 = false;
    if (false) {
        int _e54 = cursor;
        cursor = (_e54 + 1);
        uint _e59 = _naga_frsqrt_rn(floatBitsToUint(float(_e54)));
        uint _e62 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if (true) {
    } else {
        int _e67 = cursor;
        cursor = (_e67 + 1);
        uint _e72 = _naga_frsqrt_rn(floatBitsToUint(float(_e67)));
        uint _e75 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e72)));
        local_4 = (_e75 != 0u);
    }
    int _e78 = cursor;
    local_5 = uint((base + 3u));
    uint _e84 = local_5;
    _group_0_binding_1_cs[_e84] = uint(_e78);
    uint _e89 = _naga_frsqrt_rn(floatBitsToUint(-(0.0)));
    local_6 = uint((base + 4u));
    uint _e96 = local_6;
    _group_0_binding_1_cs[_e96] = floatBitsToUint(uintBitsToFloat(_e89));
    local_8 = 2139095040u;
    uint _e100 = local_8;
    uint _e103 = _naga_frsqrt_rn(floatBitsToUint(uintBitsToFloat(_e100)));
    local_7 = uint((base + 5u));
    uint _e110 = local_7;
    _group_0_binding_1_cs[_e110] = floatBitsToUint(uintBitsToFloat(_e103));
    float _e114 = reciprocal_sqrt_value(float(4u));
    local_9 = uint((base + 6u));
    uint _e120 = local_9;
    _group_0_binding_1_cs[_e120] = floatBitsToUint(_e114);
    int _e123 = _frsqrt_rn(true);
    local_10 = uint((base + 7u));
    uint _e129 = local_10;
    _group_0_binding_1_cs[_e129] = uint(_e123);
    if (true) {
        uint _e133 = _naga_frsqrt_rn(floatBitsToUint(value_2));
        local_12 = uintBitsToFloat(_e133);
    } else {
        int _e136 = cursor;
        cursor = (_e136 + 1);
        uint _e141 = _naga_frsqrt_rn(floatBitsToUint(float(_e136)));
        local_12 = uintBitsToFloat(_e141);
    }
    float _e145 = local_12;
    local_11 = uint((base + 8u));
    uint _e151 = local_11;
    _group_0_binding_1_cs[_e151] = floatBitsToUint(_e145);
    int _e153 = cursor;
    local_13 = uint((base + 9u));
    uint _e159 = local_13;
    _group_0_binding_1_cs[_e159] = uint(_e153);
}

