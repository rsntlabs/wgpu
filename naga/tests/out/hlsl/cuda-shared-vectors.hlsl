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
    uint local = (uint)0;
    uint lane = (uint)0;
    uint group = (uint)0;
    float base = (float)0;
    uint next = (uint)0;
    float3_ copied = (float3_)0;
    int offset = (int)0;
    bool choose_shared = (bool)0;
    uint row = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;

    local = 0u;
    lane = threadIdx.x;
    group = blockIdx.x;
    uint _e8 = group;
    uint _e11 = lane;
    base = float(((_e8 * 16u) + _e11));
    float _e15 = base;
    float _e18 = base;
    float _e22 = base;
    uint _e26 = lane;
    values[min(uint(_e26), 7u)] = Constructfloat3_((_e15 + 0.5), (-(_e18) - 1.25), (_e22 + 2.5));
    uint _e29 = lane;
    if ((_e29 == 0u)) {
        uint _e32 = group;
        uint _e36 = group;
        uint _e40 = group;
        broadcast = Constructfloat3_((float(_e32) + 0.25), (float(_e36) + 0.5), (float(_e40) + 0.75));
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e46 = lane;
    next = naga_mod((_e46 + 1u), 8u);
    uint _e52 = next;
    float3_ _e54 = values[min(uint(_e52), 7u)];
    const float3_ _e55 = shift(_e54);
    copied = _e55;
    {
        offset = int(1);
        int _e59 = offset;
        float _e61 = copied.x;
        copied.x = (_e61 + float(_e59));
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e64 = lane;
    choose_shared = ((_e64 & 1u) != 0u);
    float _e72 = broadcast.x;
    bool _e73 = choose_shared;
    if (_e73) {
        uint _e74 = lane;
        float _e77 = values[min(uint(_e74), 7u)].y;
        values[min(uint(_e74), 7u)].y = (_e77 + _e72);
    } else {
        float _e80 = copied.y;
        copied.y = (_e80 + _e72);
    }
    float _e83 = copied.x;
    uint _e84 = lane;
    values[min(uint(_e84), 7u)].z = _e83;
    uint _e87 = group;
    uint _e90 = lane;
    row = (((_e87 * 8u) + _e90) * 9u);
    float _e96 = copied.x;
    uint _e97 = local;
    local_1 = _e97;
    uint _e99 = local_1;
    local_2 = uint(_e99);
    uint _e102 = row;
    local_3 = uint(_e102);
    uint _e106 = local_2;
    uint _e107 = local_3;
    local_28 = uint((_e106 + _e107));
    uint _e111 = local_28;
    output.Store(_e111*4, asuint(_e96));
    float _e114 = copied.y;
    uint _e115 = local;
    local_4 = _e115;
    uint _e117 = local_4;
    local_5 = uint(_e117);
    uint _e120 = row;
    local_6 = uint((_e120 + 1u));
    uint _e125 = local_5;
    uint _e126 = local_6;
    local_29 = uint((_e125 + _e126));
    uint _e130 = local_29;
    output.Store(_e130*4, asuint(_e114));
    float _e133 = copied.z;
    uint _e134 = local;
    local_7 = _e134;
    uint _e136 = local_7;
    local_8 = uint(_e136);
    uint _e139 = row;
    local_9 = uint((_e139 + 2u));
    uint _e144 = local_8;
    uint _e145 = local_9;
    local_30 = uint((_e144 + _e145));
    uint _e149 = local_30;
    output.Store(_e149*4, asuint(_e133));
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e151 = next;
    float _e154 = values[min(uint(_e151), 7u)].x;
    uint _e155 = local;
    local_10 = _e155;
    uint _e157 = local_10;
    local_11 = uint(_e157);
    uint _e160 = row;
    local_12 = uint((_e160 + 3u));
    uint _e165 = local_11;
    uint _e166 = local_12;
    local_31 = uint((_e165 + _e166));
    uint _e170 = local_31;
    output.Store(_e170*4, asuint(_e154));
    uint _e172 = next;
    float _e175 = values[min(uint(_e172), 7u)].y;
    uint _e176 = local;
    local_13 = _e176;
    uint _e178 = local_13;
    local_14 = uint(_e178);
    uint _e181 = row;
    local_15 = uint((_e181 + 4u));
    uint _e186 = local_14;
    uint _e187 = local_15;
    local_32 = uint((_e186 + _e187));
    uint _e191 = local_32;
    output.Store(_e191*4, asuint(_e175));
    uint _e193 = next;
    float _e196 = values[min(uint(_e193), 7u)].z;
    uint _e197 = local;
    local_16 = _e197;
    uint _e199 = local_16;
    local_17 = uint(_e199);
    uint _e202 = row;
    local_18 = uint((_e202 + 5u));
    uint _e207 = local_17;
    uint _e208 = local_18;
    local_33 = uint((_e207 + _e208));
    uint _e212 = local_33;
    output.Store(_e212*4, asuint(_e196));
    float _e215 = broadcast.x;
    uint _e216 = local;
    local_19 = _e216;
    uint _e218 = local_19;
    local_20 = uint(_e218);
    uint _e221 = row;
    local_21 = uint((_e221 + 6u));
    uint _e226 = local_20;
    uint _e227 = local_21;
    local_34 = uint((_e226 + _e227));
    uint _e231 = local_34;
    output.Store(_e231*4, asuint(_e215));
    float _e234 = broadcast.y;
    uint _e235 = local;
    local_22 = _e235;
    uint _e237 = local_22;
    local_23 = uint(_e237);
    uint _e240 = row;
    local_24 = uint((_e240 + 7u));
    uint _e245 = local_23;
    uint _e246 = local_24;
    local_35 = uint((_e245 + _e246));
    uint _e250 = local_35;
    output.Store(_e250*4, asuint(_e234));
    float _e253 = broadcast.z;
    uint _e254 = local;
    local_25 = _e254;
    uint _e256 = local_25;
    local_26 = uint(_e256);
    uint _e259 = row;
    local_27 = uint((_e259 + 8u));
    uint _e264 = local_26;
    uint _e265 = local_27;
    local_36 = uint((_e264 + _e265));
    uint _e269 = local_36;
    output.Store(_e269*4, asuint(_e253));
}
