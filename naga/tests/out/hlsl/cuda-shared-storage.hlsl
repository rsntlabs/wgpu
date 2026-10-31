RWByteAddressBuffer out_ : register(u0);
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
    uint local[2] = (uint[2])0;
    uint lane = (uint)0;
    uint base = (uint)0;
    uint local_1[2] = (uint[2])0;
    uint local_2 = (uint)0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13[2] = (uint[2])0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;

    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
    lane = threadIdx.x;
    base = (blockIdx.x * 128u);
    uint _e18 = lane;
    uint _e22 = lane;
    values[min(uint(_e22), 63u)] = (((blockIdx.x * 1000u) + _e18) + 10u);
    uint _e25 = lane;
    uint _e27 = values[min(uint(_e25), 63u)];
    uint _e30[2] = local;
    local_1 = _e30;
    uint _e31 = base;
    uint _e32 = lane;
    local_2 = uint((_e31 + _e32));
    uint _e37[2] = local_1;
    local_7 = _e37;
    uint _e38 = local_2;
    uint _e40 = local_7[1];
    local_7[1] = (_e40 + _e38);
    uint _e44 = local_7[0];
    local_8 = uint(_e44);
    uint _e48 = local_7[1];
    local_9 = uint(_e48);
    uint _e51 = local_9;
    out_.Store(_e51*4, asuint(_e27));
    uint _e53 = lane;
    if ((_e53 == 0u)) {
        signed_value = naga_neg(int(7));
        float_value = 3.5;
        int _e61 = signed_value;
        uint _e65[2] = local;
        local_3 = _e65;
        uint _e66 = base;
        local_4 = uint((_e66 + 64u));
        uint _e73[2] = local_3;
        local_10 = _e73;
        uint _e74 = local_4;
        uint _e76 = local_10[1];
        local_10[1] = (_e76 + _e74);
        uint _e80 = local_10[0];
        local_11 = uint(_e80);
        uint _e84 = local_10[1];
        local_12 = uint(_e84);
        uint _e87 = local_12;
        out_.Store(_e87*4, asuint(uint(asint(asuint(_e61) + asuint(int(10))))));
        float _e89 = float_value;
        uint _e93[2] = local;
        local_5 = _e93;
        uint _e94 = base;
        local_6 = uint((_e94 + 65u));
        uint _e101[2] = local_5;
        local_13 = _e101;
        uint _e102 = local_6;
        uint _e104 = local_13[1];
        local_13[1] = (_e104 + _e102);
        uint _e108 = local_13[0];
        local_14 = uint(_e108);
        uint _e112 = local_13[1];
        local_15 = uint(_e112);
        uint _e115 = local_15;
        out_.Store(_e115*4, asuint(naga_f2u32((_e89 * 2.0))));
    }
}
