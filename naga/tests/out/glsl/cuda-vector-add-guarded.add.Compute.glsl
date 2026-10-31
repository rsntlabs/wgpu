#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) readonly buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std430) buffer type_1_block_2Compute { float _group_0_binding_2_cs[]; };

layout(std140) uniform type_3_block_3Compute { type_3 _group_0_binding_3_cs; };


void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint local[2] = uint[2](0u, 0u);
    uint local_1[2] = uint[2](0u, 0u);
    uint local_2[2] = uint[2](0u, 0u);
    uint n = 0u;
    uint i = 0u;
    uint local_3[2] = uint[2](0u, 0u);
    uint local_4 = 0u;
    uint local_5[2] = uint[2](0u, 0u);
    uint local_6 = 0u;
    uint local_7[2] = uint[2](0u, 0u);
    uint local_8 = 0u;
    float local_9 = 0.0;
    float local_10 = 0.0;
    uint local_11[2] = uint[2](0u, 0u);
    uint local_12 = 0u;
    uint local_13 = 0u;
    float local_14 = 0.0;
    uint local_15[2] = uint[2](0u, 0u);
    uint local_16 = 0u;
    uint local_17 = 0u;
    float local_18 = 0.0;
    uint local_19[2] = uint[2](0u, 0u);
    uint local_20 = 0u;
    uint local_21 = 0u;
    local = uint[2](0u, 0u);
    local[0] = 0u;
    local[1] = 0u;
    local_1 = uint[2](0u, 0u);
    local_1[0] = 1u;
    local_1[1] = 0u;
    local_2 = uint[2](0u, 0u);
    local_2[0] = 2u;
    local_2[1] = 0u;
    uint _e25 = _group_0_binding_3_cs.value;
    n = _e25;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e33 = i;
    uint _e34 = n;
    if ((_e33 < _e34)) {
        uint _e38[2] = local;
        local_5 = _e38;
        uint _e39 = i;
        local_6 = uint(_e39);
        uint _e44[2] = local_1;
        local_7 = _e44;
        uint _e45 = i;
        local_8 = uint(_e45);
        uint _e49[2] = local_7;
        local_11 = _e49;
        uint _e50 = local_8;
        uint _e52 = local_11[1];
        local_11[1] = (_e52 + _e50);
        uint _e56 = local_11[0];
        local_12 = uint(_e56);
        uint _e60 = local_11[1];
        local_13 = uint(_e60);
        uint _e64 = local_13;
        float _e66 = _group_0_binding_1_cs[_e64];
        local_14 = _e66;
        float _e67 = local_14;
        local_9 = _e67;
        float _e69 = local_9;
        uint _e73[2] = local_5;
        local_15 = _e73;
        uint _e74 = local_6;
        uint _e76 = local_15[1];
        local_15[1] = (_e76 + _e74);
        uint _e80 = local_15[0];
        local_16 = uint(_e80);
        uint _e84 = local_15[1];
        local_17 = uint(_e84);
        uint _e88 = local_17;
        float _e90 = _group_0_binding_0_cs[_e88];
        local_18 = _e90;
        float _e91 = local_18;
        local_10 = _e91;
        float _e93 = local_10;
        uint _e97[2] = local_2;
        local_3 = _e97;
        uint _e98 = i;
        local_4 = uint(_e98);
        uint _e102[2] = local_3;
        local_19 = _e102;
        uint _e103 = local_4;
        uint _e105 = local_19[1];
        local_19[1] = (_e105 + _e103);
        uint _e109 = local_19[0];
        local_20 = uint(_e109);
        uint _e113 = local_19[1];
        local_21 = uint(_e113);
        uint _e116 = local_21;
        _group_0_binding_2_cs[_e116] = (_e93 + (_e69 * 2.0));
    }
}

