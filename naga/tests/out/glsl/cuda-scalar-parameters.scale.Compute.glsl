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
    float local_2 = 0.0;
    uint local_3 = 0u;
    float local_4 = 0.0;
    uint local_5 = 0u;
    float _e3 = _group_0_binding_0_cs.value;
    factor = _e3;
    float _e5 = factor;
    factor = (_e5 * 2.0);
    local_1 = uint(threadIdx.x);
    uint _e12 = local_1;
    local_3 = uint(_e12);
    uint _e16 = local_3;
    float _e18 = _group_0_binding_1_cs[_e16];
    local_4 = _e18;
    float _e19 = local_4;
    local_2 = _e19;
    float _e21 = local_2;
    float _e22 = factor;
    local = uint(threadIdx.x);
    uint _e28 = local;
    local_5 = uint(_e28);
    uint _e31 = local_5;
    _group_0_binding_2_cs[_e31] = (_e21 * _e22);
}

