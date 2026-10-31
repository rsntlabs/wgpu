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
        local = uint(_e14);
        uint _e17 = local;
        local_14 = uint(_e17);
        uint _e20 = local_14;
        _group_0_binding_0_cs[_e20] = 1024.5;
        uint _e24 = base;
        local_1 = uint((_e24 + 1u));
        uint _e29 = local_1;
        local_15 = uint(_e29);
        uint _e32 = local_15;
        _group_0_binding_0_cs[_e32] = 0.125;
        uint _e35 = base;
        local_2 = uint((_e35 + 2u));
        uint _e40 = local_2;
        local_16 = uint(_e40);
        uint _e43 = local_16;
        _group_0_binding_0_cs[_e43] = 12.0;
        uint _e46 = base;
        local_3 = uint((_e46 + 3u));
        uint _e51 = local_3;
        local_17 = uint(_e51);
        uint _e54 = local_17;
        _group_0_binding_0_cs[_e54] = 25.0;
        uint _e57 = base;
        local_4 = uint((_e57 + 4u));
        uint _e62 = local_4;
        local_18 = uint(_e62);
        uint _e65 = local_18;
        _group_0_binding_0_cs[_e65] = 0.5;
        uint _e68 = base;
        local_5 = uint((_e68 + 5u));
        uint _e73 = local_5;
        local_19 = uint(_e73);
        uint _e76 = local_19;
        _group_0_binding_0_cs[_e76] = 6.25;
        uint _e81 = base;
        local_6 = uint((_e81 + 6u));
        uint _e86 = local_6;
        local_20 = uint(_e86);
        uint _e89 = local_20;
        _group_0_binding_0_cs[_e89] = -(1024.5);
        uint _e91 = base;
        local_7 = uint((_e91 + 7u));
        uint _e96 = local_7;
        local_21 = uint(_e96);
        uint _e99 = local_21;
        _group_0_binding_0_cs[_e99] = 0.125;
        uint _e102 = base;
        local_8 = uint((_e102 + 8u));
        uint _e107 = local_8;
        local_22 = uint(_e107);
        uint _e110 = local_22;
        _group_0_binding_0_cs[_e110] = 3.1415927;
        uint _e113 = base;
        local_9 = uint((_e113 + 9u));
        uint _e118 = local_9;
        local_23 = uint(_e118);
        uint _e121 = local_23;
        _group_0_binding_0_cs[_e121] = 1.0;
        uint _e124 = base;
        local_10 = uint((_e124 + 10u));
        uint _e129 = local_10;
        local_24 = uint(_e129);
        uint _e132 = local_24;
        _group_0_binding_0_cs[_e132] = 1.0000002;
        local_12 = uint(i);
        uint _e137 = local_12;
        local_25 = uint(_e137);
        uint _e140 = local_25;
        float _e143 = _group_0_binding_1_cs[_e140];
        local_26 = _e143;
        float _e145 = local_26;
        local_13 = _e145;
        float _e147 = local_13;
        uint _e152 = base;
        local_11 = uint((_e152 + 11u));
        uint _e157 = local_11;
        local_27 = uint(_e157);
        uint _e160 = local_27;
        _group_0_binding_0_cs[_e160] = ((_e147 * 0.25) + 10.0);
    }
}

