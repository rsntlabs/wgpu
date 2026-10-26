#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    int value;
};
struct type_4 {
    uint value;
};
layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

layout(std140) uniform type_3_block_1Compute { type_3 _group_0_binding_1_cs; };

layout(std140) uniform type_4_block_2Compute { type_4 _group_0_binding_2_cs; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local = 0u;
    int value = 0;
    uint amount = 0u;
    int remainder = 0;
    uint bits = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    local = 0u;
    int _e5 = _group_0_binding_1_cs.value;
    value = _e5;
    uint _e9 = _group_0_binding_2_cs.value;
    amount = _e9;
    int _e12 = -(3);
    int _e13 = value;
    remainder = (_e13 - _e12 * (_e13 / _e12));
    int _e16 = remainder;
    bits = (uint(_e16) & 15u);
    uint _e21 = bits;
    bits = (_e21 | 8u);
    uint _e24 = bits;
    bits = (_e24 ^ 1u);
    uint _e27 = amount;
    uint _e28 = bits;
    local_1 = _e27;
    uint _e30 = local_1;
    bits = (_e28 << _e30);
    uint _e32 = bits;
    bits = (_e32 >> 1u);
    uint _e35 = bits;
    bits = (_e35 - 97u * (_e35 / 97u));
    uint _e38 = bits;
    bits = (_e38 & 255u);
    uint _e41 = bits;
    uint _e43 = local;
    local_2 = _e43;
    uint _e45 = local_2;
    local_3 = uint(_e45);
    local_4 = uint(threadIdx.x);
    uint _e52 = local_3;
    uint _e53 = local_4;
    local_5 = uint((_e52 + _e53));
    uint _e57 = local_5;
    _group_0_binding_0_cs[_e57] = ~(_e41);
}

