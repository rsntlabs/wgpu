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
    int value = 0;
    uint amount = 0u;
    int remainder = 0;
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
    int _e10 = _group_0_binding_1_cs.value;
    value = _e10;
    uint _e14 = _group_0_binding_2_cs.value;
    amount = _e14;
    int _e17 = -(3);
    int _e18 = value;
    remainder = (_e18 - _e17 * (_e18 / _e17));
    int _e21 = remainder;
    bits = (uint(_e21) & 15u);
    uint _e26 = bits;
    bits = (_e26 | 8u);
    uint _e29 = bits;
    bits = (_e29 ^ 1u);
    uint _e32 = amount;
    uint _e33 = bits;
    local = _e32;
    uint _e35 = local;
    bits = (_e33 << _e35);
    uint _e37 = bits;
    bits = (_e37 >> 1u);
    uint _e40 = bits;
    bits = (_e40 - 97u * (_e40 / 97u));
    uint _e43 = bits;
    bits = (_e43 & 255u);
    uint _e46 = bits;
    uint _e50[2] = out_;
    local_1 = _e50;
    local_2 = uint(threadIdx.x);
    uint _e55[2] = local_1;
    local_3 = _e55;
    uint _e56 = local_2;
    uint _e58 = local_3[1];
    local_3[1] = (_e58 + _e56);
    uint _e62 = local_3[0];
    local_4 = uint(_e62);
    uint _e66 = local_3[1];
    local_5 = uint(_e66);
    uint _e69 = local_5;
    _group_0_binding_0_cs[_e69] = ~(_e46);
}

