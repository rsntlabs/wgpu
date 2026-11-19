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
    _group_0_binding_1_cs[base] = int(value_1);
    float _e24 = forward(value_1);
    local = uint((base + 1u));
    uint _e30 = local;
    _group_0_binding_1_cs[_e30] = int(_e24);
    uint _e32 = counter;
    counter = (_e32 + uint(1));
    local_1 = uint((base + 2u));
    uint _e41 = local_1;
    _group_0_binding_1_cs[_e41] = int(value_1);
    uint _e43 = counter;
    local_2 = uint((base + 3u));
    uint _e49 = local_2;
    _group_0_binding_1_cs[_e49] = int(_e43);
    if (((index & 1u) != 0u)) {
        uint _e55 = counter;
        local_12 = _e55;
        uint _e57 = local_12;
        counter = (_e57 + uint(1));
        local_13 = value_1;
        float _e62 = local_13;
        local_4 = _e62;
        float _e64 = local_4;
        local_6 = int(_e64);
    } else {
        uint _e67 = counter;
        local_14 = _e67;
        uint _e69 = local_14;
        counter = (_e69 + uint(1));
        local_15 = value_1;
        float _e74 = local_15;
        local_5 = _e74;
        float _e76 = local_5;
        local_6 = int(_e76);
    }
    int _e80 = local_6;
    local_3 = uint((base + 4u));
    uint _e85 = local_3;
    _group_0_binding_1_cs[_e85] = _e80;
    uint _e87 = counter;
    local_7 = uint((base + 5u));
    uint _e93 = local_7;
    _group_0_binding_1_cs[_e93] = int(_e87);
    local_8 = uint((base + 6u));
    uint _e102 = local_8;
    _group_0_binding_1_cs[_e102] = int(float(16777217));
    local_9 = 7;
    extra = 0;
    extra = 3;
    int _e110 = local_9;
    int _e111 = extra;
    local_11 = (_e110 + _e111);
    int _e114 = local_11;
    local_10 = uint((base + 7u));
    uint _e119 = local_10;
    _group_0_binding_1_cs[_e119] = _e114;
}

