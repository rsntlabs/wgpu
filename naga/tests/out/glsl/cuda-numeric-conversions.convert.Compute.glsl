#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) readonly buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };

layout(std430) buffer type_1_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_2Compute { type_3 _group_0_binding_2_cs; };


void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    float offset = 0.0;
    uint local = 0u;
    uint local_1 = 0u;
    float local_2 = 0.0;
    uint local_3 = 0u;
    float local_4 = 0.0;
    uint local_5 = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    int i = int(((blockIdx.x * 1u) + threadIdx.x));
    if ((uint(i) < n_1)) {
        offset = float(i);
        local_1 = uint(i);
        uint _e17 = local_1;
        local_3 = uint(_e17);
        uint _e20 = local_3;
        float _e23 = _group_0_binding_0_cs[_e20];
        local_4 = _e23;
        float _e25 = local_4;
        local_2 = _e25;
        float _e27 = local_2;
        float _e28 = offset;
        local = uint(i);
        uint _e32 = local;
        local_5 = uint(_e32);
        uint _e35 = local_5;
        _group_0_binding_1_cs[_e35] = (_e27 + _e28);
    }
}

