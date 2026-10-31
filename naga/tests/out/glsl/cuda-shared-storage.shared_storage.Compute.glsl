#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { uint _group_0_binding_0_cs[]; };

shared uint values[64];

shared int signed_value;

shared float float_value;


void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        values = uint[64](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        signed_value = 0;
        float_value = 0.0;
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    uint out_[2] = uint[2](0u, 0u);
    uint local[2] = uint[2](0u, 0u);
    uint local_1 = 0u;
    uint local_2[2] = uint[2](0u, 0u);
    uint local_3 = 0u;
    uint local_4[2] = uint[2](0u, 0u);
    uint local_5 = 0u;
    uint local_6[2] = uint[2](0u, 0u);
    uint local_7 = 0u;
    uint local_8 = 0u;
    uint local_9[2] = uint[2](0u, 0u);
    uint local_10 = 0u;
    uint local_11 = 0u;
    uint local_12[2] = uint[2](0u, 0u);
    uint local_13 = 0u;
    uint local_14 = 0u;
    out_ = uint[2](0u, 0u);
    out_[0] = 0u;
    out_[1] = 0u;
    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 128u);
    values[lane] = (((blockIdx.x * 1000u) + lane) + 10u);
    uint _e21 = values[lane];
    uint _e23[2] = out_;
    local = _e23;
    local_1 = uint((base + lane));
    uint _e28[2] = local;
    local_6 = _e28;
    uint _e30 = local_1;
    uint _e32 = local_6[1];
    local_6[1] = (_e32 + _e30);
    uint _e36 = local_6[0];
    local_7 = uint(_e36);
    uint _e40 = local_6[1];
    local_8 = uint(_e40);
    uint _e43 = local_8;
    _group_0_binding_0_cs[_e43] = _e21;
    if ((lane == 0u)) {
        signed_value = -(7);
        float_value = 3.5;
        int _e53 = signed_value;
        uint _e56[2] = out_;
        local_2 = _e56;
        local_3 = uint((base + 64u));
        uint _e63[2] = local_2;
        local_9 = _e63;
        uint _e65 = local_3;
        uint _e67 = local_9[1];
        local_9[1] = (_e67 + _e65);
        uint _e71 = local_9[0];
        local_10 = uint(_e71);
        uint _e75 = local_9[1];
        local_11 = uint(_e75);
        uint _e78 = local_11;
        _group_0_binding_0_cs[_e78] = uint((_e53 + 10));
        float _e80 = float_value;
        uint _e83[2] = out_;
        local_4 = _e83;
        local_5 = uint((base + 65u));
        uint _e90[2] = local_4;
        local_12 = _e90;
        uint _e92 = local_5;
        uint _e94 = local_12[1];
        local_12[1] = (_e94 + _e92);
        uint _e98 = local_12[0];
        local_13 = uint(_e98);
        uint _e102 = local_12[1];
        local_14 = uint(_e102);
        uint _e105 = local_14;
        _group_0_binding_0_cs[_e105] = uint((_e80 * 2.0));
    }
}

