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
    uint local_1 = 0u;
    uint local_2 = 0u;
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
    local = amount_1;
    uint _e22 = local;
    bits = (_e20 << _e22);
    uint _e24 = bits;
    bits = (_e24 >> 1u);
    uint _e27 = bits;
    bits = (_e27 - 97u * (_e27 / 97u));
    uint _e30 = bits;
    bits = (_e30 & 255u);
    uint _e33 = bits;
    local_1 = uint(threadIdx.x);
    uint _e38 = local_1;
    local_2 = uint(_e38);
    uint _e41 = local_2;
    _group_0_binding_0_cs[_e41] = ~(_e33);
}

