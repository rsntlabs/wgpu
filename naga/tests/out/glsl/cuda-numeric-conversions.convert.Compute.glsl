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
    uint local[2] = uint[2](0u, 0u);
    uint local_1[2] = uint[2](0u, 0u);
    uint n = 0u;
    int i = 0;
    float offset = 0.0;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    float local_6 = 0.0;
    uint local_7[2] = uint[2](0u, 0u);
    uint local_8 = 0u;
    uint local_9 = 0u;
    float local_10 = 0.0;
    uint local_11[2] = uint[2](0u, 0u);
    uint local_12 = 0u;
    uint local_13 = 0u;
    local = uint[2](0u, 0u);
    local[0] = 0u;
    local[1] = 0u;
    local_1 = uint[2](0u, 0u);
    local_1[0] = 1u;
    local_1[1] = 0u;
    uint _e18 = _group_0_binding_2_cs.value;
    n = _e18;
    i = int(((blockIdx.x * 1u) + threadIdx.x));
    int _e27 = i;
    uint _e29 = n;
    if ((uint(_e27) < _e29)) {
        int _e31 = i;
        offset = float(_e31);
        uint _e36[2] = local;
        local_4 = _e36;
        int _e37 = i;
        local_5 = uint(_e37);
        uint _e41[2] = local_4;
        local_7 = _e41;
        uint _e42 = local_5;
        uint _e44 = local_7[1];
        local_7[1] = (_e44 + _e42);
        uint _e48 = local_7[0];
        local_8 = uint(_e48);
        uint _e52 = local_7[1];
        local_9 = uint(_e52);
        uint _e56 = local_9;
        float _e58 = _group_0_binding_0_cs[_e56];
        local_10 = _e58;
        float _e59 = local_10;
        local_6 = _e59;
        float _e61 = local_6;
        float _e62 = offset;
        uint _e66[2] = local_1;
        local_2 = _e66;
        int _e67 = i;
        local_3 = uint(_e67);
        uint _e71[2] = local_2;
        local_11 = _e71;
        uint _e72 = local_3;
        uint _e74 = local_11[1];
        local_11[1] = (_e74 + _e72);
        uint _e78 = local_11[0];
        local_12 = uint(_e78);
        uint _e82 = local_11[1];
        local_13 = uint(_e82);
        uint _e85 = local_13;
        _group_0_binding_1_cs[_e85] = (_e61 + _e62);
    }
}

