#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) buffer type_5_block_0Compute { float _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_5_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_2Compute { type_3 _group_0_binding_2_cs; };


uint copied_unsigned(uint value) {
    return value;
}

float copied_float(float value_1) {
    return value_1;
}

void main() {
    uvec3 blockIdx_1 = gl_WorkGroupID;
    uvec3 threadIdx_1 = gl_LocalInvocationID;
    uint local_6 = 0u;
    uint local_7 = 0u;
    float local_8 = 0.0;
    uint local_9 = 0u;
    float local_10 = 0.0;
    uint local_11 = 0u;
    uint count_2 = _group_0_binding_2_cs.value;
    uint index = ((blockIdx_1.x * 4u) + threadIdx_1.x);
    if ((index < count_2)) {
        local_7 = index;
        uint _e12 = local_7;
        local_9 = _e12;
        uint _e14 = local_9;
        float _e17 = _group_0_binding_1_cs[_e14];
        local_10 = _e17;
        float _e19 = local_10;
        local_8 = _e19;
        float _e21 = local_8;
        float _e22 = copied_float(_e21);
        local_6 = index;
        uint _e24 = local_6;
        local_11 = _e24;
        uint _e26 = local_11;
        _group_0_binding_0_cs[_e26] = _e22;
    }
}

