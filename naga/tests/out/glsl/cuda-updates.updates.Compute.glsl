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
    uint local = 0u;
    int value = 0;
    int previous = 0;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    int local_8 = 0;
    uint local_9 = 0u;
    local = 0u;
    int _e5 = _group_0_binding_1_cs.value;
    value = _e5;
    int _e7 = value;
    value = (_e7 + 1);
    previous = _e7;
    int _e11 = previous;
    uint _e12 = local;
    local_1 = _e12;
    uint _e14 = local_1;
    local_2 = uint(_e14);
    local_3 = uint(threadIdx.x);
    uint _e21 = local_2;
    uint _e22 = local_3;
    local_7 = uint((_e21 + _e22));
    uint _e27 = local_7;
    int _e29 = _group_0_binding_0_cs[_e27];
    local_8 = _e29;
    int _e30 = local_8;
    uint _e32 = local_7;
    _group_0_binding_0_cs[_e32] = (_e30 + _e11);
    int _e34 = value;
    value = (_e34 + 1);
    int _e37 = value;
    uint _e38 = local;
    local_4 = _e38;
    uint _e40 = local_4;
    local_5 = uint(_e40);
    local_6 = uint(threadIdx.x);
    uint _e46 = local_5;
    uint _e47 = local_6;
    local_9 = uint((_e46 + _e47));
    uint _e51 = local_9;
    _group_0_binding_0_cs[_e51] = _e37;
}

