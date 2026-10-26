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
    uint i = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    float local_13 = 0.0;
    uint local_14 = 0u;
    float local_15 = 0.0;
    uint local_16 = 0u;
    local = 0u;
    local_1 = 0u;
    local_2 = 0u;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e14 = local;
    local_6 = _e14;
    uint _e16 = local_6;
    local_7 = uint(_e16);
    uint _e19 = i;
    local_8 = uint(_e19);
    uint _e22 = local_1;
    local_9 = _e22;
    uint _e24 = local_9;
    local_10 = uint(_e24);
    uint _e27 = i;
    local_11 = uint(_e27);
    uint _e31 = local_10;
    uint _e32 = local_11;
    local_12 = uint((_e31 + _e32));
    uint _e37 = local_12;
    float _e39 = _group_0_binding_1_cs[_e37];
    local_13 = _e39;
    float _e40 = local_13;
    uint _e44 = local_7;
    uint _e45 = local_8;
    local_14 = uint((_e44 + _e45));
    uint _e50 = local_14;
    float _e52 = _group_0_binding_0_cs[_e50];
    local_15 = _e52;
    float _e53 = local_15;
    uint _e55 = local_2;
    local_3 = _e55;
    uint _e57 = local_3;
    local_4 = uint(_e57);
    uint _e60 = i;
    local_5 = uint(_e60);
    uint _e64 = local_4;
    uint _e65 = local_5;
    local_16 = uint((_e64 + _e65));
    uint _e69 = local_16;
    _group_0_binding_2_cs[_e69] = (_e53 + (_e40 * 2.0));
}

