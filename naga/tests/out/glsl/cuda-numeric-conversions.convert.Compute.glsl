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
    uint local = 0u;
    uint local_1 = 0u;
    uint n = 0u;
    int i = 0;
    float offset = 0.0;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    float local_9 = 0.0;
    uint local_10 = 0u;
    local = 0u;
    local_1 = 0u;
    uint _e8 = _group_0_binding_2_cs.value;
    n = _e8;
    i = int(((blockIdx.x * 1u) + threadIdx.x));
    int _e17 = i;
    uint _e19 = n;
    if ((uint(_e17) < _e19)) {
        int _e21 = i;
        offset = float(_e21);
        uint _e24 = local;
        local_5 = _e24;
        uint _e26 = local_5;
        local_6 = uint(_e26);
        int _e29 = i;
        local_7 = uint(_e29);
        uint _e33 = local_6;
        uint _e34 = local_7;
        local_8 = uint((_e33 + _e34));
        uint _e39 = local_8;
        float _e41 = _group_0_binding_0_cs[_e39];
        local_9 = _e41;
        float _e42 = local_9;
        float _e43 = offset;
        uint _e45 = local_1;
        local_2 = _e45;
        uint _e47 = local_2;
        local_3 = uint(_e47);
        int _e50 = i;
        local_4 = uint(_e50);
        uint _e54 = local_3;
        uint _e55 = local_4;
        local_10 = uint((_e54 + _e55));
        uint _e59 = local_10;
        _group_0_binding_1_cs[_e59] = (_e42 + _e43);
    }
}

