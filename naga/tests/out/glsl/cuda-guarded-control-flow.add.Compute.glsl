#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

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
    uint a[2] = uint[2](0u, 0u);
    uint b[2] = uint[2](0u, 0u);
    uint out_[2] = uint[2](0u, 0u);
    uint n = 0u;
    uint i = 0u;
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    float local_6 = 0.0;
    float local_7 = 0.0;
    uint local_8[2] = uint[2](0u, 0u);
    uint local_9 = 0u;
    uint local_10 = 0u;
    float local_11 = 0.0;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    uint local_14 = 0u;
    float local_15 = 0.0;
    uint local_16[2] = uint[2](0u, 0u);
    uint local_17 = 0u;
    uint local_18 = 0u;
    a = uint[2](0u, 0u);
    a[0] = 0u;
    a[1] = 0u;
    b = uint[2](0u, 0u);
    b[0] = 1u;
    b[1] = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 2u;
    out_[1] = 0u;
    uint _e25 = _group_0_binding_3_cs.value;
    n = _e25;
    i = ((blockIdx.x * 1u) + threadIdx.x);
    uint _e33 = i;
    uint _e34 = n;
    if ((_e33 < _e34)) {
        uint _e38[2] = a;
        local_2 = _e38;
        uint _e39 = i;
        local_3 = uint(_e39);
        uint _e44[2] = b;
        local_4 = _e44;
        uint _e45 = i;
        local_5 = uint(_e45);
        uint _e49[2] = local_2;
        local_8 = _e49;
        uint _e50 = local_3;
        uint _e52 = local_8[1];
        local_8[1] = (_e52 + _e50);
        uint _e56 = local_8[0];
        local_9 = uint(_e56);
        uint _e60 = local_8[1];
        local_10 = uint(_e60);
        uint _e64 = local_10;
        float _e66 = _group_0_binding_0_cs[_e64];
        local_11 = _e66;
        float _e67 = local_11;
        local_6 = _e67;
        float _e69 = local_6;
        uint _e71[2] = local_4;
        local_12 = _e71;
        uint _e72 = local_5;
        uint _e74 = local_12[1];
        local_12[1] = (_e74 + _e72);
        uint _e78 = local_12[0];
        local_13 = uint(_e78);
        uint _e82 = local_12[1];
        local_14 = uint(_e82);
        uint _e86 = local_14;
        float _e88 = _group_0_binding_1_cs[_e86];
        local_15 = _e88;
        float _e89 = local_15;
        local_7 = _e89;
        float _e91 = local_7;
        uint _e95[2] = out_;
        local = _e95;
        uint _e96 = i;
        local_1 = uint(_e96);
        uint _e100[2] = local;
        local_16 = _e100;
        uint _e101 = local_1;
        uint _e103 = local_16[1];
        local_16[1] = (_e103 + _e101);
        uint _e107 = local_16[0];
        local_17 = uint(_e107);
        uint _e111 = local_16[1];
        local_18 = uint(_e111);
        uint _e114 = local_18;
        _group_0_binding_2_cs[_e114] = (_e69 + _e91);
    }
}

