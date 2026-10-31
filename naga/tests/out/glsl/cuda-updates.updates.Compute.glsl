#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    int value;
};
layout(std430) buffer type_1_block_0Compute { int _group_0_binding_0_cs[]; };

layout(std140) uniform type_3_block_1Compute { type_3 _group_0_binding_1_cs; };


void main() {
    uvec3 threadIdx = gl_LocalInvocationID;
    uint out_[2] = uint[2](0u, 0u);
    int value = 0;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    int local_4 = 0;
    uint local_5[2] = uint[2](0u, 0u);
    uint local_6 = 0u;
    uint local_7 = 0u;
    int local_8 = 0;
    uint local_9[2] = uint[2](0u, 0u);
    uint local_10 = 0u;
    uint local_11 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    int _e9 = _group_0_binding_1_cs.value;
    value = _e9;
    int previous = value;
    value = (previous + 1);
    uint _e15[2] = out_;
    local = _e15;
    local_1 = uint(threadIdx.x);
    uint _e20[2] = local;
    local_5 = _e20;
    uint _e22 = local_1;
    uint _e24 = local_5[1];
    local_5[1] = (_e24 + _e22);
    uint _e28 = local_5[0];
    local_6 = uint(_e28);
    uint _e32 = local_5[1];
    local_7 = uint(_e32);
    uint _e35 = local_7;
    int _e38 = _group_0_binding_0_cs[_e35];
    local_8 = _e38;
    int _e40 = local_8;
    local_4 = _e40;
    int _e42 = local_4;
    uint _e44 = local_7;
    _group_0_binding_0_cs[_e44] = (_e42 + previous);
    int _e46 = value;
    value = (_e46 + 1);
    int _e49 = value;
    uint _e50[2] = out_;
    local_2 = _e50;
    local_3 = uint(threadIdx.x);
    uint _e55[2] = local_2;
    local_9 = _e55;
    uint _e57 = local_3;
    uint _e59 = local_9[1];
    local_9[1] = (_e59 + _e57);
    uint _e63 = local_9[0];
    local_10 = uint(_e63);
    uint _e67 = local_9[1];
    local_11 = uint(_e67);
    uint _e70 = local_11;
    _group_0_binding_0_cs[_e70] = _e49;
}

