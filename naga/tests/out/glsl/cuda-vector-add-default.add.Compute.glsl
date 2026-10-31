#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std430) buffer type_1_block_2Compute { float _group_0_binding_2_cs[]; };


void main() {
    uvec3 blockIdx = gl_WorkGroupID;
    uvec3 threadIdx = gl_LocalInvocationID;
    uint a[2] = uint[2](0u, 0u);
    uint b[2] = uint[2](0u, 0u);
    uint out_[2] = uint[2](0u, 0u);
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
    i = ((blockIdx.x * 1u) + threadIdx.x);
    uint _e31[2] = a;
    local_2 = _e31;
    uint _e32 = i;
    local_3 = uint(_e32);
    uint _e37[2] = b;
    local_4 = _e37;
    uint _e38 = i;
    local_5 = uint(_e38);
    uint _e42[2] = local_4;
    local_8 = _e42;
    uint _e43 = local_5;
    uint _e45 = local_8[1];
    local_8[1] = (_e45 + _e43);
    uint _e49 = local_8[0];
    local_9 = uint(_e49);
    uint _e53 = local_8[1];
    local_10 = uint(_e53);
    uint _e57 = local_10;
    float _e59 = _group_0_binding_1_cs[_e57];
    local_11 = _e59;
    float _e60 = local_11;
    local_6 = _e60;
    float _e62 = local_6;
    uint _e66[2] = local_2;
    local_12 = _e66;
    uint _e67 = local_3;
    uint _e69 = local_12[1];
    local_12[1] = (_e69 + _e67);
    uint _e73 = local_12[0];
    local_13 = uint(_e73);
    uint _e77 = local_12[1];
    local_14 = uint(_e77);
    uint _e81 = local_14;
    float _e83 = _group_0_binding_0_cs[_e81];
    local_15 = _e83;
    float _e84 = local_15;
    local_7 = _e84;
    float _e86 = local_7;
    uint _e90[2] = out_;
    local = _e90;
    uint _e91 = i;
    local_1 = uint(_e91);
    uint _e95[2] = local;
    local_16 = _e95;
    uint _e96 = local_1;
    uint _e98 = local_16[1];
    local_16[1] = (_e98 + _e96);
    uint _e102 = local_16[0];
    local_17 = uint(_e102);
    uint _e106 = local_16[1];
    local_18 = uint(_e106);
    uint _e109 = local_18;
    _group_0_binding_2_cs[_e109] = (_e86 + (_e62 * 2.0));
}

