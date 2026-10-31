#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct type_1 {
    float value;
};
layout(std140) uniform type_1_block_0Compute { type_1 _group_0_binding_0_cs; };

layout(std430) readonly buffer type_2_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std430) buffer type_2_block_2Compute { float _group_0_binding_2_cs[]; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    float factor = 0.0;
    uint local = 0u;
    uint local_1 = 0u;
    float _e3 = _group_0_binding_0_cs.value;
    factor = _e3;
    float _e5 = factor;
    factor = (_e5 * 2.0);
    local_1 = uint(threadIdx.x);
    uint _e11 = local_1;
    float _e14 = _group_0_binding_1_cs[_e11];
    float _e15 = factor;
    local = uint(threadIdx.x);
    uint _e20 = local;
    _group_0_binding_2_cs[_e20] = (_e14 * _e15);
}

