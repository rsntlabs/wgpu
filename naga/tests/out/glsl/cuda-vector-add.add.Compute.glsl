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
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    local_1 = uint(i);
    local_2 = uint(i);
    uint _e11 = local_2;
    local_5 = uint(_e11);
    uint _e14 = local_5;
    float _e17 = _group_0_binding_1_cs[_e14];
    local_6 = _e17;
    float _e19 = local_6;
    local_3 = _e19;
    float _e21 = local_3;
    uint _e24 = local_1;
    local_7 = uint(_e24);
    uint _e27 = local_7;
    float _e30 = _group_0_binding_0_cs[_e27];
    local_8 = _e30;
    float _e32 = local_8;
    local_4 = _e32;
    float _e34 = local_4;
    local = uint(i);
    uint _e38 = local;
    local_9 = uint(_e38);
    uint _e41 = local_9;
    _group_0_binding_2_cs[_e41] = (_e34 + (_e21 * 2.0));
}

