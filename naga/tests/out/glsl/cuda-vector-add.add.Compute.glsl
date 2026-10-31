#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std430) buffer type_1_block_2Compute { float _group_0_binding_2_cs[]; };


void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    float _e9 = _group_0_binding_1_cs[i];
    float _e14 = _group_0_binding_0_cs[i];
    _group_0_binding_2_cs[i] = (_e14 + (_e9 * 2.0));
}

