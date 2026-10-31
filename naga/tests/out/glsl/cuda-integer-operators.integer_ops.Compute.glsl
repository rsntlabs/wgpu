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
    uint bits = 0u;
    uint local = 0u;
    int value_1 = _group_0_binding_1_cs.value;
    uint amount_1 = _group_0_binding_2_cs.value;
    int _e8 = -(3);
    int remainder = (value_1 - _e8 * (value_1 / _e8));
    bits = (uint(remainder) & 15u);
    uint _e14 = bits;
    bits = (_e14 | 8u);
    uint _e17 = bits;
    bits = (_e17 ^ 1u);
    uint _e20 = bits;
    bits = (_e20 << amount_1);
    uint _e22 = bits;
    bits = (_e22 >> 1u);
    uint _e25 = bits;
    bits = (_e25 - 97u * (_e25 / 97u));
    uint _e28 = bits;
    bits = (_e28 & 255u);
    uint _e31 = bits;
    local = uint(threadIdx.x);
    uint _e36 = local;
    _group_0_binding_0_cs[_e36] = ~(_e31);
}

