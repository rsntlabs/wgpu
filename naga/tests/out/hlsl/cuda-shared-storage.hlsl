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

    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 128u);
    values[min(uint(lane), 63u)] = (((blockIdx.x * 1000u) + lane) + 10u);
    uint _e15 = values[min(uint(lane), 63u)];
    local = uint((base + lane));
    uint _e19 = local;
    out_.Store(_e19*4, asuint(_e15));
    if ((lane == 0u)) {
        signed_value = naga_neg(int(7));
        float_value = 3.5;
        int _e29 = signed_value;
        local_1 = uint((base + 64u));
        uint _e37 = local_1;
        local_3 = _e37;
        uint _e39 = local_3;
        out_.Store(_e39*4, asuint(uint(asint(asuint(_e29) + asuint(int(10))))));
        float _e41 = float_value;
        local_2 = uint((base + 65u));
        uint _e49 = local_2;
        local_4 = _e49;
        uint _e51 = local_4;
        out_.Store(_e51*4, asuint(naga_f2u32((_e41 * 2.0))));
    }
}
