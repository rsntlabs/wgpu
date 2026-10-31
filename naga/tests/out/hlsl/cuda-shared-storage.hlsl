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
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;

    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 128u);
    values[min(uint(lane), 63u)] = (((blockIdx.x * 1000u) + lane) + 10u);
    uint _e15 = values[min(uint(lane), 63u)];
    local = uint((base + lane));
    uint _e19 = local;
    local_3 = uint(_e19);
    uint _e22 = local_3;
    out_.Store(_e22*4, asuint(_e15));
    if ((lane == 0u)) {
        signed_value = naga_neg(int(7));
        float_value = 3.5;
        int _e32 = signed_value;
        local_1 = uint((base + 64u));
        uint _e40 = local_1;
        local_4 = uint(_e40);
        uint _e43 = local_4;
        out_.Store(_e43*4, asuint(uint(asint(asuint(_e32) + asuint(int(10))))));
        float _e45 = float_value;
        local_2 = uint((base + 65u));
        uint _e53 = local_2;
        local_5 = uint(_e53);
        uint _e56 = local_5;
        out_.Store(_e56*4, asuint(naga_f2u32((_e45 * 2.0))));
    }
}
