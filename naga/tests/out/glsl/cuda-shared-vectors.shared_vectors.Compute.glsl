#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;

struct float3_ {
    float x;
    float y;
    float z;
};
layout(std430) buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };

shared float3_ values[8];

shared float3_ broadcast;


float3_ shift(float3_ value) {
    float3_ value_1 = float3_(0.0, 0.0, 0.0);
    value_1 = value;
    float _e4 = value_1.x;
    value_1.x = (_e4 + 1.0);
    float _e9 = value_1.z;
    float _e10 = value_1.y;
    value_1.y = (_e9 - _e10);
    float3_ _e12 = value_1;
    return _e12;
}

void main() {
    if (gl_LocalInvocationID == uvec3(0u)) {
        values = float3_[8](float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0), float3_(0.0, 0.0, 0.0));
        broadcast = float3_(0.0, 0.0, 0.0);
    }
    memoryBarrierShared();
    barrier();
    uvec3 threadIdx = gl_LocalInvocationID;
    uvec3 blockIdx = gl_WorkGroupID;
    float3_ copied = float3_(0.0, 0.0, 0.0);
    int offset = 0;
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
    uint local_13 = 0u;
    uint local_14 = 0u;
    uint local_15 = 0u;
    uint local_16 = 0u;
    uint local_17 = 0u;
    uint lane = threadIdx.x;
    uint group = blockIdx.x;
    float base = float(((group * 16u) + lane));
    values[lane] = float3_((base + 0.5), (-(base) - 1.25), (base + 2.5));
    if ((lane == 0u)) {
        broadcast = float3_((float(group) + 0.25), (float(group) + 0.5), (float(group) + 0.75));
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    uint _e32 = (lane + 1u);
    uint next = (_e32 - 8u * (_e32 / 8u));
    float3_ _e36 = values[next];
    float3_ _e37 = shift(_e36);
    copied = _e37;
    {
        offset = 1;
        int _e41 = offset;
        float _e43 = copied.x;
        copied.x = (_e43 + float(_e41));
    }
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    bool choose_shared = ((lane & 1u) != 0u);
    float _e52 = broadcast.x;
    if (choose_shared) {
        float _e55 = values[lane].y;
        values[lane].y = (_e55 + _e52);
    } else {
        float _e58 = copied.y;
        copied.y = (_e58 + _e52);
    }
    float _e61 = copied.x;
    values[lane].z = _e61;
    uint row = (((group * 8u) + lane) * 9u);
    float _e70 = copied.x;
    local = uint(row);
    uint _e73 = local;
    local_9 = uint(_e73);
    uint _e76 = local_9;
    _group_0_binding_0_cs[_e76] = _e70;
    float _e80 = copied.y;
    local_1 = uint((row + 1u));
    uint _e85 = local_1;
    local_10 = uint(_e85);
    uint _e88 = local_10;
    _group_0_binding_0_cs[_e88] = _e80;
    float _e91 = copied.z;
    local_2 = uint((row + 2u));
    uint _e96 = local_2;
    local_11 = uint(_e96);
    uint _e99 = local_11;
    _group_0_binding_0_cs[_e99] = _e91;
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    float _e103 = values[next].x;
    local_3 = uint((row + 3u));
    uint _e108 = local_3;
    local_12 = uint(_e108);
    uint _e111 = local_12;
    _group_0_binding_0_cs[_e111] = _e103;
    float _e115 = values[next].y;
    local_4 = uint((row + 4u));
    uint _e120 = local_4;
    local_13 = uint(_e120);
    uint _e123 = local_13;
    _group_0_binding_0_cs[_e123] = _e115;
    float _e127 = values[next].z;
    local_5 = uint((row + 5u));
    uint _e132 = local_5;
    local_14 = uint(_e132);
    uint _e135 = local_14;
    _group_0_binding_0_cs[_e135] = _e127;
    float _e138 = broadcast.x;
    local_6 = uint((row + 6u));
    uint _e143 = local_6;
    local_15 = uint(_e143);
    uint _e146 = local_15;
    _group_0_binding_0_cs[_e146] = _e138;
    float _e149 = broadcast.y;
    local_7 = uint((row + 7u));
    uint _e154 = local_7;
    local_16 = uint(_e154);
    uint _e157 = local_16;
    _group_0_binding_0_cs[_e157] = _e149;
    float _e160 = broadcast.z;
    local_8 = uint((row + 8u));
    uint _e165 = local_8;
    local_17 = uint(_e165);
    uint _e168 = local_17;
    _group_0_binding_0_cs[_e168] = _e160;
}

