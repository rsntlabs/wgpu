RWByteAddressBuffer out_1 : register(u0);
groupshared uint values[64];
groupshared int signed_value;
groupshared float float_value;

int naga_neg(int val) {
    return asint(-asuint(val));
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
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
    uint out_[2] = (uint[2])0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 128u);
    values[min(uint(lane), 63u)] = (((blockIdx.x * 1000u) + lane) + 10u);
    uint _e21 = values[min(uint(lane), 63u)];
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
    out_1.Store(_e43*4, asuint(_e21));
    if ((lane == 0u)) {
        signed_value = naga_neg(int(7));
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
        out_1.Store(_e78*4, asuint(uint(asint(asuint(_e53) + asuint(int(10))))));
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
        out_1.Store(_e105*4, asuint(naga_f2u32((_e80 * 2.0))));
    }
}
