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
    uint out_[2] = uint[2](0u, 0u);
    uint bits = 0u;
    uint local = 0u;
    uint local_1[2] = uint[2](0u, 0u);
    uint local_2 = 0u;
    uint local_3[2] = uint[2](0u, 0u);
    uint local_4 = 0u;
    uint local_5 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    int value_1 = _group_0_binding_1_cs.value;
    uint amount_1 = _group_0_binding_2_cs.value;
    int _e14 = -(3);
    int remainder = (value_1 - _e14 * (value_1 / _e14));
    bits = (uint(remainder) & 15u);
    uint _e20 = bits;
    bits = (_e20 | 8u);
    uint _e23 = bits;
    bits = (_e23 ^ 1u);
    uint _e26 = bits;
    local = amount_1;
    uint _e28 = local;
    bits = (_e26 << _e28);
    uint _e30 = bits;
    bits = (_e30 >> 1u);
    uint _e33 = bits;
    bits = (_e33 - 97u * (_e33 / 97u));
    uint _e36 = bits;
    bits = (_e36 & 255u);
    uint _e39 = bits;
    uint _e42[2] = out_;
    local_1 = _e42;
    local_2 = uint(threadIdx.x);
    uint _e47[2] = local_1;
    local_3 = _e47;
    uint _e49 = local_2;
    uint _e51 = local_3[1];
    local_3[1] = (_e51 + _e49);
    uint _e55 = local_3[0];
    local_4 = uint(_e55);
    uint _e59 = local_3[1];
    local_5 = uint(_e59);
    uint _e62 = local_5;
    _group_0_binding_0_cs[_e62] = ~(_e39);
}

