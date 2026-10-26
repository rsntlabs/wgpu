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
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    float local_9 = 0.0;
    uint local_10 = 0u;
    float _e3 = _group_0_binding_0_cs.value;
    factor = _e3;
    local = 0u;
    local_1 = 0u;
    float _e9 = factor;
    factor = (_e9 * 2.0);
    uint _e12 = local;
    local_5 = _e12;
    uint _e14 = local_5;
    local_6 = uint(_e14);
    local_7 = uint(threadIdx.x);
    uint _e21 = local_6;
    uint _e22 = local_7;
    local_8 = uint((_e21 + _e22));
    uint _e27 = local_8;
    float _e29 = _group_0_binding_1_cs[_e27];
    local_9 = _e29;
    float _e30 = local_9;
    float _e31 = factor;
    uint _e33 = local_1;
    local_2 = _e33;
    uint _e35 = local_2;
    local_3 = uint(_e35);
    local_4 = uint(threadIdx.x);
    uint _e42 = local_3;
    uint _e43 = local_4;
    local_10 = uint((_e42 + _e43));
    uint _e47 = local_10;
    _group_0_binding_2_cs[_e47] = (_e30 * _e31);
}

