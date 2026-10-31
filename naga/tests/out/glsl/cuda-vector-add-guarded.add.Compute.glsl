#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) readonly buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std430) buffer type_1_block_2Compute { float _group_0_binding_2_cs[]; };

layout(std140) uniform type_3_block_3Compute { type_3 _group_0_binding_3_cs; };


void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    float local_3 = 0.0;
    float local_4 = 0.0;
    uint local_5 = 0u;
    float local_6 = 0.0;
    uint local_7 = 0u;
    float local_8 = 0.0;
    uint local_9 = 0u;
    uint n_1 = _group_0_binding_3_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        local_1 = uint(i);
        local_2 = uint(i);
        uint _e15 = local_2;
        local_5 = uint(_e15);
        uint _e18 = local_5;
        float _e21 = _group_0_binding_1_cs[_e18];
        local_6 = _e21;
        float _e23 = local_6;
        local_3 = _e23;
        float _e25 = local_3;
        uint _e28 = local_1;
        local_7 = uint(_e28);
        uint _e31 = local_7;
        float _e34 = _group_0_binding_0_cs[_e31];
        local_8 = _e34;
        float _e36 = local_8;
        local_4 = _e36;
        float _e38 = local_4;
        local = uint(i);
        uint _e42 = local;
        local_9 = uint(_e42);
        uint _e45 = local_9;
        _group_0_binding_2_cs[_e45] = (_e38 + (_e25 * 2.0));
    }
}

