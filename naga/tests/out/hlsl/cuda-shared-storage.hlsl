RWByteAddressBuffer out_ : register(u0);
groupshared uint values[64];
groupshared int signed_value;
groupshared float float_value;

int naga_neg(int val) {
    return asint(-asuint(val));
}

uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

[numthreads(64, 1, 1)]
void shared_storage(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        values = (uint[64])0;
        signed_value = (int)0;
        float_value = (float)0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint local = (uint)0;
    uint lane = (uint)0;
    uint base = (uint)0;
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

    local = 0u;
    lane = threadIdx.x;
    base = (blockIdx.x * 128u);
    uint _e13 = lane;
    uint _e17 = lane;
    values[min(uint(_e17), 63u)] = (((blockIdx.x * 1000u) + _e13) + 10u);
    uint _e20 = lane;
    uint _e22 = values[min(uint(_e20), 63u)];
    uint _e23 = local;
    local_1 = _e23;
    uint _e25 = local_1;
    local_2 = uint(_e25);
    uint _e28 = base;
    uint _e29 = lane;
    local_3 = uint((_e28 + _e29));
    uint _e34 = local_2;
    uint _e35 = local_3;
    local_10 = uint((_e34 + _e35));
    uint _e39 = local_10;
    out_.Store(_e39*4, asuint(_e22));
    uint _e41 = lane;
    if ((_e41 == 0u)) {
        signed_value = naga_neg(int(7));
        float_value = 3.5;
        int _e49 = signed_value;
        uint _e52 = local;
        local_4 = _e52;
        uint _e54 = local_4;
        local_5 = uint(_e54);
        uint _e57 = base;
        local_6 = uint((_e57 + 64u));
        uint _e63 = local_5;
        uint _e64 = local_6;
        local_11 = uint((_e63 + _e64));
        uint _e68 = local_11;
        out_.Store(_e68*4, asuint(uint(asint(asuint(_e49) + asuint(int(10))))));
        float _e70 = float_value;
        uint _e73 = local;
        local_7 = _e73;
        uint _e75 = local_7;
        local_8 = uint(_e75);
        uint _e78 = base;
        local_9 = uint((_e78 + 65u));
        uint _e84 = local_8;
        uint _e85 = local_9;
        local_12 = uint((_e84 + _e85));
        uint _e89 = local_12;
        out_.Store(_e89*4, asuint(naga_f2u32((_e70 * 2.0))));
    }
}
