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
    uint local[2] = uint[2](0u, 0u);
    int value = 0;
    int previous = 0;
    uint local_1[2] = uint[2](0u, 0u);
    uint local_2 = 0u;
    uint local_3[2] = uint[2](0u, 0u);
    uint local_4 = 0u;
    int local_5 = 0;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    uint local_8 = 0u;
    int local_9 = 0;
    uint local_10[2] = uint[2](0u, 0u);
    uint local_11 = 0u;
    uint local_12 = 0u;
    local = uint[2](0u, 0u);
    local[0] = 0u;
    local[1] = 0u;
    int _e10 = _group_0_binding_1_cs.value;
    value = _e10;
    int _e12 = value;
    value = (_e12 + 1);
    previous = _e12;
    int _e16 = previous;
    uint _e19[2] = local;
    local_1 = _e19;
    local_2 = uint(threadIdx.x);
    uint _e24[2] = local_1;
    local_6 = _e24;
    uint _e25 = local_2;
    uint _e27 = local_6[1];
    local_6[1] = (_e27 + _e25);
    uint _e31 = local_6[0];
    local_7 = uint(_e31);
    uint _e35 = local_6[1];
    local_8 = uint(_e35);
    uint _e39 = local_8;
    int _e41 = _group_0_binding_0_cs[_e39];
    local_9 = _e41;
    int _e42 = local_9;
    local_5 = _e42;
    int _e44 = local_5;
    uint _e46 = local_8;
    _group_0_binding_0_cs[_e46] = (_e44 + _e16);
    int _e48 = value;
    value = (_e48 + 1);
    int _e51 = value;
    uint _e53[2] = local;
    local_3 = _e53;
    local_4 = uint(threadIdx.x);
    uint _e58[2] = local_3;
    local_10 = _e58;
    uint _e59 = local_4;
    uint _e61 = local_10[1];
    local_10[1] = (_e61 + _e59);
    uint _e65 = local_10[0];
    local_11 = uint(_e65);
    uint _e69 = local_10[1];
    local_12 = uint(_e69);
    uint _e72 = local_12;
    _group_0_binding_0_cs[_e72] = _e51;
}

