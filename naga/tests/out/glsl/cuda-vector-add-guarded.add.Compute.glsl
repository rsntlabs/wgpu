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
    uint n = 0u;
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
    uint _e10 = _group_0_binding_3_cs.value;
    n = _e10;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e18 = i;
    uint _e19 = n;
    if ((_e18 < _e19)) {
        uint _e21 = local;
        local_6 = _e21;
        uint _e23 = local_6;
        local_7 = uint(_e23);
        uint _e26 = i;
        local_8 = uint(_e26);
        uint _e29 = local_1;
        local_9 = _e29;
        uint _e31 = local_9;
        local_10 = uint(_e31);
        uint _e34 = i;
        local_11 = uint(_e34);
        uint _e38 = local_10;
        uint _e39 = local_11;
        local_12 = uint((_e38 + _e39));
        uint _e44 = local_12;
        float _e46 = _group_0_binding_1_cs[_e44];
        local_13 = _e46;
        float _e47 = local_13;
        uint _e51 = local_7;
        uint _e52 = local_8;
        local_14 = uint((_e51 + _e52));
        uint _e57 = local_14;
        float _e59 = _group_0_binding_0_cs[_e57];
        local_15 = _e59;
        float _e60 = local_15;
        uint _e62 = local_2;
        local_3 = _e62;
        uint _e64 = local_3;
        local_4 = uint(_e64);
        uint _e67 = i;
        local_5 = uint(_e67);
        uint _e71 = local_4;
        uint _e72 = local_5;
        local_16 = uint((_e71 + _e72));
        uint _e76 = local_16;
        _group_0_binding_2_cs[_e76] = (_e60 + (_e47 * 2.0));
    }
}

