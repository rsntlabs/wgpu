#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_5 {
    uint value;
};
layout(std430) readonly buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_4_block_1Compute { int _group_0_binding_1_cs[]; };

layout(std140) uniform type_5_block_2Compute { type_5 _group_0_binding_2_cs; };


float forward(float value) {
    return value;
}

uint _naga_floorf(uint input_bits) {
    uint _e5 = (input_bits & 2147483647u);
    uint _e6 = (input_bits & 2147483648u);
    uint _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    uint _e15 = (_e14 - 1u);
    uint _e19 = (input_bits & ~(_e15));
    return ((_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e6 | ((_e6 >> 31u) * 1065353216u))) : (((_e6 != 0u) && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19))));
}

void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint counter = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    float local_4 = 0.0;
    float local_5 = 0.0;
    int local_6 = 0;
    uint local_7 = 0u;
    uint local_8 = 0u;
    int local_9 = 0;
    uint local_10 = 0u;
    int local_11 = 0;
    uint local_12 = 0u;
    float local_13 = 0.0;
    uint local_14 = 0u;
    float local_15 = 0.0;
    int extra = 0;
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 8u));
    uint _e17 = _group_0_binding_0_cs[index];
    float value_1 = uintBitsToFloat(_e17);
    counter = 0u;
    uint _e22 = _naga_floorf(floatBitsToUint(value_1));
    _group_0_binding_1_cs[base] = int(uintBitsToFloat(_e22));
    float _e27 = forward(value_1);
    uint _e29 = _naga_floorf(floatBitsToUint(_e27));
    local = uint((base + 1u));
    uint _e36 = local;
    _group_0_binding_1_cs[_e36] = int(uintBitsToFloat(_e29));
    uint _e38 = counter;
    counter = (_e38 + uint(1));
    uint _e43 = _naga_floorf(floatBitsToUint(value_1));
    local_1 = uint((base + 2u));
    uint _e50 = local_1;
    _group_0_binding_1_cs[_e50] = int(uintBitsToFloat(_e43));
    uint _e52 = counter;
    local_2 = uint((base + 3u));
    uint _e58 = local_2;
    _group_0_binding_1_cs[_e58] = int(_e52);
    if (((index & 1u) != 0u)) {
        uint _e64 = counter;
        local_12 = _e64;
        uint _e66 = local_12;
        counter = (_e66 + uint(1));
        local_13 = value_1;
        float _e71 = local_13;
        local_4 = _e71;
        float _e73 = local_4;
        uint _e75 = _naga_floorf(floatBitsToUint(_e73));
        local_6 = int(uintBitsToFloat(_e75));
    } else {
        uint _e79 = counter;
        local_14 = _e79;
        uint _e81 = local_14;
        counter = (_e81 + uint(1));
        local_15 = value_1;
        float _e86 = local_15;
        local_5 = _e86;
        float _e88 = local_5;
        uint _e90 = _naga_floorf(floatBitsToUint(_e88));
        local_6 = int(uintBitsToFloat(_e90));
    }
    int _e95 = local_6;
    local_3 = uint((base + 4u));
    uint _e100 = local_3;
    _group_0_binding_1_cs[_e100] = _e95;
    uint _e102 = counter;
    local_7 = uint((base + 5u));
    uint _e108 = local_7;
    _group_0_binding_1_cs[_e108] = int(_e102);
    uint _e113 = _naga_floorf(floatBitsToUint(float(16777217)));
    local_8 = uint((base + 6u));
    uint _e120 = local_8;
    _group_0_binding_1_cs[_e120] = int(uintBitsToFloat(_e113));
    local_9 = 7;
    extra = 0;
    extra = 3;
    int _e128 = local_9;
    int _e129 = extra;
    local_11 = (_e128 + _e129);
    int _e132 = local_11;
    local_10 = uint((base + 7u));
    uint _e137 = local_10;
    _group_0_binding_1_cs[_e137] = _e132;
}

