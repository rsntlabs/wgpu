#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct type_3 {
    uint value;
};
layout(std430) buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std140) uniform type_3_block_2Compute { type_3 _group_0_binding_2_cs; };


void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint base = 0u;
    uint local = 0u;
    uint local_1 = 0u;
    uint local_2 = 0u;
    uint local_3 = 0u;
    uint local_4 = 0u;
    uint local_5 = 0u;
    uint local_6 = 0u;
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9 = 0u;
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12 = 0u;
    float local_13 = 0.0;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint local_18 = 0u;
    uint local_19 = 0u;
    uint local_20 = 0u;
    uint local_21 = 0u;
    uint local_22 = 0u;
    uint local_23 = 0u;
    uint local_24 = 0u;
    uint local_25 = 0u;
    float local_26 = 0.0;
    uint local_27 = 0u;
    uint n_1 = _group_0_binding_2_cs.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        uint _e14 = base;
        local = _e14;
        uint _e16 = local;
        local_14 = _e16;
        uint _e18 = local_14;
        _group_0_binding_0_cs[_e18] = 1024.5;
        uint _e22 = base;
        local_1 = uint((_e22 + 1u));
        uint _e27 = local_1;
        local_15 = _e27;
        uint _e29 = local_15;
        _group_0_binding_0_cs[_e29] = 0.125;
        uint _e32 = base;
        local_2 = uint((_e32 + 2u));
        uint _e37 = local_2;
        local_16 = _e37;
        uint _e39 = local_16;
        _group_0_binding_0_cs[_e39] = 12.0;
        uint _e42 = base;
        local_3 = uint((_e42 + 3u));
        uint _e47 = local_3;
        local_17 = _e47;
        uint _e49 = local_17;
        _group_0_binding_0_cs[_e49] = 25.0;
        uint _e52 = base;
        local_4 = uint((_e52 + 4u));
        uint _e57 = local_4;
        local_18 = _e57;
        uint _e59 = local_18;
        _group_0_binding_0_cs[_e59] = 0.5;
        uint _e62 = base;
        local_5 = uint((_e62 + 5u));
        uint _e67 = local_5;
        local_19 = _e67;
        uint _e69 = local_19;
        _group_0_binding_0_cs[_e69] = 6.25;
        uint _e74 = base;
        local_6 = uint((_e74 + 6u));
        uint _e79 = local_6;
        local_20 = _e79;
        uint _e81 = local_20;
        _group_0_binding_0_cs[_e81] = -(1024.5);
        uint _e83 = base;
        local_7 = uint((_e83 + 7u));
        uint _e88 = local_7;
        local_21 = _e88;
        uint _e90 = local_21;
        _group_0_binding_0_cs[_e90] = 0.125;
        uint _e93 = base;
        local_8 = uint((_e93 + 8u));
        uint _e98 = local_8;
        local_22 = _e98;
        uint _e100 = local_22;
        _group_0_binding_0_cs[_e100] = 3.1415927;
        uint _e103 = base;
        local_9 = uint((_e103 + 9u));
        uint _e108 = local_9;
        local_23 = _e108;
        uint _e110 = local_23;
        _group_0_binding_0_cs[_e110] = 1.0;
        uint _e113 = base;
        local_10 = uint((_e113 + 10u));
        uint _e118 = local_10;
        local_24 = _e118;
        uint _e120 = local_24;
        _group_0_binding_0_cs[_e120] = 1.0000002;
        local_12 = i;
        uint _e124 = local_12;
        local_25 = _e124;
        uint _e126 = local_25;
        float _e129 = _group_0_binding_1_cs[_e126];
        local_26 = _e129;
        float _e131 = local_26;
        local_13 = _e131;
        float _e133 = local_13;
        uint _e138 = base;
        local_11 = uint((_e138 + 11u));
        uint _e143 = local_11;
        local_27 = _e143;
        uint _e145 = local_27;
        _group_0_binding_0_cs[_e145] = ((_e133 * 0.25) + 10.0);
    }
}

