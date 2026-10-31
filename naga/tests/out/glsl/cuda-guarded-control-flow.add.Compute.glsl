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
    uint n_1 = _group_0_binding_3_cs.value;
    uint i = ((blockIdx.x * 1u) + threadIdx.x);
    if ((i < n_1)) {
        uint _e30[2] = a;
        local_2 = _e30;
        local_3 = uint(i);
        uint _e35[2] = b;
        local_4 = _e35;
        local_5 = uint(i);
        uint _e39[2] = local_2;
        local_8 = _e39;
        uint _e41 = local_3;
        uint _e43 = local_8[1];
        local_8[1] = (_e43 + _e41);
        uint _e47 = local_8[0];
        local_9 = uint(_e47);
        uint _e51 = local_8[1];
        local_10 = uint(_e51);
        uint _e54 = local_10;
        float _e57 = _group_0_binding_0_cs[_e54];
        local_11 = _e57;
        float _e59 = local_11;
        local_6 = _e59;
        float _e61 = local_6;
        uint _e62[2] = local_4;
        local_12 = _e62;
        uint _e64 = local_5;
        uint _e66 = local_12[1];
        local_12[1] = (_e66 + _e64);
        uint _e70 = local_12[0];
        local_13 = uint(_e70);
        uint _e74 = local_12[1];
        local_14 = uint(_e74);
        uint _e77 = local_14;
        float _e80 = _group_0_binding_1_cs[_e77];
        local_15 = _e80;
        float _e82 = local_15;
        local_7 = _e82;
        float _e84 = local_7;
        uint _e87[2] = out_;
        local = _e87;
        local_1 = uint(i);
        uint _e91[2] = local;
        local_16 = _e91;
        uint _e93 = local_1;
        uint _e95 = local_16[1];
        local_16[1] = (_e95 + _e93);
        uint _e99 = local_16[0];
        local_17 = uint(_e99);
        uint _e103 = local_16[1];
        local_18 = uint(_e103);
        uint _e106 = local_18;
        _group_0_binding_2_cs[_e106] = (_e61 + _e84);
    }
}

