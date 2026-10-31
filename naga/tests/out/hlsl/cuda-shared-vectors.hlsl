struct float3_ {
    float x;
    float y;
    float z;
};

RWByteAddressBuffer output : register(u0);
groupshared float3_ values[8];
groupshared float3_ broadcast;

float3_ shift(float3_ value)
{
    float3_ value_1 = (float3_)0;

    value_1 = value;
    float _e4 = value_1.x;
    value_1.x = (_e4 + 1.0);
    float _e9 = value_1.z;
    float _e10 = value_1.y;
    value_1.y = (_e9 - _e10);
    float3_ _e12 = value_1;
    const float3_ float3_1 = _e12;
    return float3_1;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

float3_ Constructfloat3_(float arg0, float arg1, float arg2) {
    float3_ ret = (float3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

[numthreads(8, 1, 1)]
void shared_vectors(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        values = (float3_[8])0;
        broadcast = (float3_)0;
    }
    GroupMemoryBarrierWithGroupSync();
    float3_ copied = (float3_)0;
    int offset = (int)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;

    uint lane = threadIdx.x;
    uint group = blockIdx.x;
    float base = float(((group * 16u) + lane));
    values[min(uint(lane), 7u)] = Constructfloat3_((base + 0.5), (-(base) - 1.25), (base + 2.5));
    if ((lane == 0u)) {
        broadcast = Constructfloat3_((float(group) + 0.25), (float(group) + 0.5), (float(group) + 0.75));
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint next = naga_mod((lane + 1u), 8u);
    float3_ _e36 = values[min(uint(next), 7u)];
    const float3_ _e37 = shift(_e36);
    copied = _e37;
    {
        offset = int(1);
        int _e41 = offset;
        float _e43 = copied.x;
        copied.x = (_e43 + float(_e41));
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    bool choose_shared = ((lane & 1u) != 0u);
    float _e52 = broadcast.x;
    if (choose_shared) {
        float _e55 = values[min(uint(lane), 7u)].y;
        values[min(uint(lane), 7u)].y = (_e55 + _e52);
    } else {
        float _e58 = copied.y;
        copied.y = (_e58 + _e52);
    }
    float _e61 = copied.x;
    values[min(uint(lane), 7u)].z = _e61;
    uint row = (((group * 8u) + lane) * 9u);
    float _e70 = copied.x;
    output.Store(row*4, asuint(_e70));
    float _e74 = copied.y;
    local = uint((row + 1u));
    uint _e79 = local;
    output.Store(_e79*4, asuint(_e74));
    float _e82 = copied.z;
    local_1 = uint((row + 2u));
    uint _e87 = local_1;
    output.Store(_e87*4, asuint(_e82));
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    float _e91 = values[min(uint(next), 7u)].x;
    local_2 = uint((row + 3u));
    uint _e96 = local_2;
    output.Store(_e96*4, asuint(_e91));
    float _e100 = values[min(uint(next), 7u)].y;
    local_3 = uint((row + 4u));
    uint _e105 = local_3;
    output.Store(_e105*4, asuint(_e100));
    float _e109 = values[min(uint(next), 7u)].z;
    local_4 = uint((row + 5u));
    uint _e114 = local_4;
    output.Store(_e114*4, asuint(_e109));
    float _e117 = broadcast.x;
    local_5 = uint((row + 6u));
    uint _e122 = local_5;
    output.Store(_e122*4, asuint(_e117));
    float _e125 = broadcast.y;
    local_6 = uint((row + 7u));
    uint _e130 = local_6;
    output.Store(_e130*4, asuint(_e125));
    float _e133 = broadcast.z;
    local_7 = uint((row + 8u));
    uint _e138 = local_7;
    output.Store(_e138*4, asuint(_e133));
}
