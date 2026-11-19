#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_4 {
    uint value;
};
layout(std430) readonly buffer type_3_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) buffer type_3_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_4_block_2Compute { type_4 _group_0_binding_2_cs; };


float forward(float value) {
    return value;
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
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    int local_11 = 0;
    uint local_12 = 0u;
    uint local_13 = 0u;
    uint local_14 = 0u;
    float local_15 = 0.0;
    uint local_16 = 0u;
    float local_17 = 0.0;
    int extra = 0;
    uint count_1 = _group_0_binding_2_cs.value;
    uint index = (threadIdx.x + (blockIdx.x * 4u));
    if ((index >= count_1)) {
        return;
    }
    uint base = (4u + (index * 10u));
    uint _e17 = _group_0_binding_0_cs[index];
    float value_1 = uintBitsToFloat(_e17);
    counter = 0u;
    _group_0_binding_1_cs[base] = uint(value_1);
    float _e24 = forward(value_1);
    local = uint((base + 1u));
    uint _e30 = local;
    _group_0_binding_1_cs[_e30] = uint(_e24);
    uint _e32 = counter;
    counter = (_e32 + uint(1));
    local_1 = uint((base + 2u));
    uint _e41 = local_1;
    _group_0_binding_1_cs[_e41] = uint(value_1);
    uint _e43 = counter;
    local_2 = uint((base + 3u));
    uint _e48 = local_2;
    _group_0_binding_1_cs[_e48] = _e43;
    if (((index & 1u) != 0u)) {
        uint _e54 = counter;
        local_14 = _e54;
        uint _e56 = local_14;
        counter = (_e56 + uint(1));
        local_15 = value_1;
        float _e61 = local_15;
        local_4 = _e61;
        float _e63 = local_4;
        local_6 = uint(_e63);
    } else {
        uint _e66 = counter;
        local_16 = _e66;
        uint _e68 = local_16;
        counter = (_e68 + uint(1));
        local_17 = value_1;
        float _e73 = local_17;
        local_5 = _e73;
        float _e75 = local_5;
        local_6 = uint(_e75);
    }
    uint _e79 = local_6;
    local_3 = uint((base + 4u));
    uint _e84 = local_3;
    _group_0_binding_1_cs[_e84] = _e79;
    uint _e86 = counter;
    local_7 = uint((base + 5u));
    uint _e91 = local_7;
    _group_0_binding_1_cs[_e91] = _e86;
    local_8 = uint((base + 6u));
    uint _e100 = local_8;
    _group_0_binding_1_cs[_e100] = uint(float(16777217u));
    local_9 = uint((base + 7u));
    uint _e109 = local_9;
    _group_0_binding_1_cs[_e109] = uint(float(2147483649u));
    local_10 = uint((base + 8u));
    uint _e118 = local_10;
    _group_0_binding_1_cs[_e118] = uint(float(true));
    local_11 = 7;
    extra = 0;
    extra = 3;
    int _e126 = local_11;
    int _e127 = extra;
    local_13 = uint((_e126 + _e127));
    uint _e131 = local_13;
    local_12 = uint((base + 9u));
    uint _e136 = local_12;
    _group_0_binding_1_cs[_e136] = _e131;
}

