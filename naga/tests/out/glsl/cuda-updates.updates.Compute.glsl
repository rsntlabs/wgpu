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
    int value = 0;
    uint local = 0u;
    uint local_1 = 0u;
    int local_2 = 0;
    uint local_3 = 0u;
    int local_4 = 0;
    uint local_5 = 0u;
    int _e3 = _group_0_binding_1_cs.value;
    value = _e3;
    int previous = value;
    value = (previous + 1);
    local = uint(threadIdx.x);
    uint _e11 = local;
    local_3 = uint(_e11);
    uint _e14 = local_3;
    int _e17 = _group_0_binding_0_cs[_e14];
    local_4 = _e17;
    int _e19 = local_4;
    local_2 = _e19;
    int _e21 = local_2;
    uint _e23 = local_3;
    _group_0_binding_0_cs[_e23] = (_e21 + previous);
    int _e25 = value;
    value = (_e25 + 1);
    int _e28 = value;
    local_1 = uint(threadIdx.x);
    uint _e32 = local_1;
    local_5 = uint(_e32);
    uint _e35 = local_5;
    _group_0_binding_0_cs[_e35] = _e28;
}

