#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std430) buffer type_1_block_2Compute { float _group_0_binding_2_cs[]; };


void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint i = ((blockIdx.x * 1u) + threadIdx.x);
    local_1 = uint(i);
    local_2 = uint(i);
    uint _e11 = local_2;
    local_3 = uint(_e11);
    uint _e14 = local_3;
    float _e17 = _group_0_binding_1_cs[_e14];
    uint _e20 = local_1;
    local_4 = uint(_e20);
    uint _e23 = local_4;
    float _e26 = _group_0_binding_0_cs[_e23];
    local = uint(i);
    uint _e30 = local;
    local_5 = uint(_e30);
    uint _e33 = local_5;
    _group_0_binding_2_cs[_e33] = (_e26 + (_e17 * 2.0));
}

