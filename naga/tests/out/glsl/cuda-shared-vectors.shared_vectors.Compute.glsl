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
    _group_0_binding_0_cs[row] = _e70;
    float _e74 = copied.y;
    local = uint((row + 1u));
    uint _e79 = local;
    _group_0_binding_0_cs[_e79] = _e74;
    float _e82 = copied.z;
    local_1 = uint((row + 2u));
    uint _e87 = local_1;
    _group_0_binding_0_cs[_e87] = _e82;
    memoryBarrierBuffer();
    memoryBarrierShared();
    barrier();
    float _e91 = values[next].x;
    local_2 = uint((row + 3u));
    uint _e96 = local_2;
    _group_0_binding_0_cs[_e96] = _e91;
    float _e100 = values[next].y;
    local_3 = uint((row + 4u));
    uint _e105 = local_3;
    _group_0_binding_0_cs[_e105] = _e100;
    float _e109 = values[next].z;
    local_4 = uint((row + 5u));
    uint _e114 = local_4;
    _group_0_binding_0_cs[_e114] = _e109;
    float _e117 = broadcast.x;
    local_5 = uint((row + 6u));
    uint _e122 = local_5;
    _group_0_binding_0_cs[_e122] = _e117;
    float _e125 = broadcast.y;
    local_6 = uint((row + 7u));
    uint _e130 = local_6;
    _group_0_binding_0_cs[_e130] = _e125;
    float _e133 = broadcast.z;
    local_7 = uint((row + 8u));
    uint _e138 = local_7;
    _group_0_binding_0_cs[_e138] = _e133;
}

