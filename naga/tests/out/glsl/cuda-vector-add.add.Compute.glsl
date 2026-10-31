#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(std430) readonly buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };

layout(std430) readonly buffer type_1_block_1Compute { float _group_0_binding_1_cs[]; };

layout(std430) buffer type_1_block_2Compute { float _group_0_binding_2_cs[]; };


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
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e26[2] = a;
    local_2 = _e26;
    local_3 = uint(i);
    uint _e31[2] = b;
    local_4 = _e31;
    local_5 = uint(i);
    uint _e35[2] = local_4;
    local_8 = _e35;
    uint _e37 = local_5;
    uint _e39 = local_8[1];
    local_8[1] = (_e39 + _e37);
    uint _e43 = local_8[0];
    local_9 = uint(_e43);
    uint _e47 = local_8[1];
    local_10 = uint(_e47);
    uint _e50 = local_10;
    float _e53 = _group_0_binding_1_cs[_e50];
    local_11 = _e53;
    float _e55 = local_11;
    local_6 = _e55;
    float _e57 = local_6;
    uint _e60[2] = local_2;
    local_12 = _e60;
    uint _e62 = local_3;
    uint _e64 = local_12[1];
    local_12[1] = (_e64 + _e62);
    uint _e68 = local_12[0];
    local_13 = uint(_e68);
    uint _e72 = local_12[1];
    local_14 = uint(_e72);
    uint _e75 = local_14;
    float _e78 = _group_0_binding_0_cs[_e75];
    local_15 = _e78;
    float _e80 = local_15;
    local_7 = _e80;
    float _e82 = local_7;
    uint _e85[2] = out_;
    local = _e85;
    local_1 = uint(i);
    uint _e89[2] = local;
    local_16 = _e89;
    uint _e91 = local_1;
    uint _e93 = local_16[1];
    local_16[1] = (_e93 + _e91);
    uint _e97 = local_16[0];
    local_17 = uint(_e97);
    uint _e101 = local_16[1];
    local_18 = uint(_e101);
    uint _e104 = local_18;
    _group_0_binding_2_cs[_e104] = (_e82 + (_e57 * 2.0));
}

