#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { uint _group_0_binding_1_cs[]; };


uint _naga_truncf(uint input_bits) {
    uint _e4 = (input_bits & 2147483647u);
    return ((_e4 > 2139095040u) ? 2143289344u : ((_e4 >= 1258291200u) ? input_bits : ((_e4 < 1065353216u) ? (input_bits & 2147483648u) : (input_bits & ~(((1u << ((150u - (_e4 >> 23u)) & 31u)) - 1u))))));
}

float truncated(float value) {
    uint _e2 = _naga_truncf(floatBitsToUint(value));
    return uintBitsToFloat(_e2);
}

int truncf(bool value_1) {
    int local_15 = 0;
    if (value_1) {
        local_15 = 7;
    } else {
        local_15 = 9;
    }
    int _e6 = local_15;
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
    uint local_14 = 0u;
    uint index = (threadIdx.x + (blockIdx.x * 32u));
    if ((index >= 4096u)) {
        return;
    }
    uint base = (4u + (index * 12u));
    uint _e15 = _group_0_binding_0_cs[index];
    float value_2 = uintBitsToFloat(_e15);
    uint _e18 = _naga_truncf(floatBitsToUint(value_2));
    _group_0_binding_1_cs[base] = floatBitsToUint(uintBitsToFloat(_e18));
    float _e23 = truncated(value_2);
    local = uint((base + 1u));
    uint _e29 = local;
    _group_0_binding_1_cs[_e29] = floatBitsToUint(_e23);
    cursor = 0;
    int _e33 = cursor;
    cursor = (_e33 + 1);
    local_2 = uint((index + uint(_e33)));
    uint _e40 = local_2;
    uint _e42 = _group_0_binding_0_cs[_e40];
    float _e44 = truncated(uintBitsToFloat(_e42));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    _group_0_binding_1_cs[_e50] = floatBitsToUint(_e44);
    local_3 = false;
    if (false) {
        int _e54 = cursor;
        cursor = (_e54 + 1);
        uint _e59 = _naga_truncf(floatBitsToUint(float(_e54)));
        uint _e62 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if (true) {
    } else {
        int _e67 = cursor;
        cursor = (_e67 + 1);
        uint _e72 = _naga_truncf(floatBitsToUint(float(_e67)));
        uint _e75 = _naga_fabsf(floatBitsToUint(uintBitsToFloat(_e72)));
        local_4 = (_e75 != 0u);
    }
    int _e78 = cursor;
    local_5 = uint((base + 3u));
    uint _e84 = local_5;
    _group_0_binding_1_cs[_e84] = uint(_e78);
    uint _e89 = _naga_truncf(floatBitsToUint(-(0.0)));
    local_6 = uint((base + 4u));
    uint _e96 = local_6;
    _group_0_binding_1_cs[_e96] = floatBitsToUint(uintBitsToFloat(_e89));
    uint _e101 = _naga_truncf(floatBitsToUint(-(0.25)));
    local_7 = uint((base + 5u));
    uint _e108 = local_7;
    _group_0_binding_1_cs[_e108] = floatBitsToUint(uintBitsToFloat(_e101));
    uint _e113 = _naga_truncf(floatBitsToUint(-(1.75)));
    local_8 = uint((base + 6u));
    uint _e120 = local_8;
    _group_0_binding_1_cs[_e120] = floatBitsToUint(uintBitsToFloat(_e113));
    float _e124 = truncated(float(3u));
    local_9 = uint((base + 7u));
    uint _e130 = local_9;
    _group_0_binding_1_cs[_e130] = floatBitsToUint(_e124);
    int _e133 = truncf(true);
    local_10 = uint((base + 8u));
    uint _e139 = local_10;
    _group_0_binding_1_cs[_e139] = uint(_e133);
    if (true) {
        uint _e143 = _naga_truncf(floatBitsToUint(value_2));
        local_12 = uintBitsToFloat(_e143);
    } else {
        int _e146 = cursor;
        cursor = (_e146 + 1);
        uint _e151 = _naga_truncf(floatBitsToUint(float(_e146)));
        local_12 = uintBitsToFloat(_e151);
    }
    float _e155 = local_12;
    local_11 = uint((base + 9u));
    uint _e161 = local_11;
    _group_0_binding_1_cs[_e161] = floatBitsToUint(_e155);
    uint _e164 = _naga_truncf(floatBitsToUint(value_2));
    uint _e167 = _naga_truncf(floatBitsToUint(uintBitsToFloat(_e164)));
    local_13 = uint((base + 10u));
    uint _e174 = local_13;
    _group_0_binding_1_cs[_e174] = floatBitsToUint(uintBitsToFloat(_e167));
    int _e176 = cursor;
    local_14 = uint((base + 11u));
    uint _e182 = local_14;
    _group_0_binding_1_cs[_e182] = uint(_e176);
}

