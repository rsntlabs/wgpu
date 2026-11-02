#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) buffer type_2_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_2_block_1Compute { uint _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_2Compute { type_3 _group_0_binding_2_cs; };


uint copied_unsigned(uint value) {
    return value;
}

float copied_float(float value_1) {
    return value_1;
}

void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint count_2 = _group_0_binding_2_cs.value;
    uint index = ((blockIdx.x * 4u) + threadIdx.x);
    if ((index < count_2)) {
        local_1 = index;
        uint _e12 = local_1;
        local_3 = _e12;
        uint _e14 = local_3;
        uint _e17 = _group_0_binding_1_cs[_e14];
        local_4 = _e17;
        uint _e19 = local_4;
        local_2 = _e19;
        uint _e21 = local_2;
        uint _e22 = copied_unsigned(_e21);
        local = index;
        uint _e24 = local;
        local_5 = _e24;
        uint _e26 = local_5;
        _group_0_binding_0_cs[_e26] = _e22;
    }
}

