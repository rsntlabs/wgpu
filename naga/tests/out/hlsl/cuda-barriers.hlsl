RWByteAddressBuffer out_1 : register(u0);
groupshared uint values[64];
groupshared uint broadcast;

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(64, 1, 1)]
void barriers(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        values = (uint[64])0;
        broadcast = (uint)0;
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
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17[2] = (uint[2])0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21[2] = (uint[2])0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 256u);
    values[min(uint(lane), 63u)] = (((blockIdx.x * 2000u) + lane) + 7u);
    uint _e25[2] = out_;
    local = _e25;
    local_1 = uint((base + lane));
    uint _e30[2] = local;
    local_11 = _e30;
    uint _e32 = local_1;
    uint _e34 = local_11[1];
    local_11[1] = (_e34 + _e32);
    uint _e38 = local_11[0];
    local_12 = uint(_e38);
    uint _e42 = local_11[1];
    local_13 = uint(_e42);
    uint _e45 = local_13;
    out_1.Store(_e45*4, asuint(((blockIdx.x * 1000u) + lane)));
    if ((lane == 0u)) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e59 = values[min(uint((63u - lane)), 63u)];
    uint _e60[2] = out_;
    local_2 = _e60;
    local_3 = uint(((base + 64u) + lane));
    uint _e67[2] = local_2;
    local_14 = _e67;
    uint _e69 = local_3;
    uint _e71 = local_14[1];
    local_14[1] = (_e71 + _e69);
    uint _e75 = local_14[0];
    local_15 = uint(_e75);
    uint _e79 = local_14[1];
    local_16 = uint(_e79);
    uint _e82 = local_16;
    out_1.Store(_e82*4, asuint(_e59));
    uint _e84[2] = out_;
    local_6 = _e84;
    local_7 = uint((base + naga_mod((lane + 1u), 64u)));
    uint _e93[2] = local_6;
    local_17 = _e93;
    uint _e95 = local_7;
    uint _e97 = local_17[1];
    local_17[1] = (_e97 + _e95);
    uint _e101 = local_17[0];
    local_18 = uint(_e101);
    uint _e105 = local_17[1];
    local_19 = uint(_e105);
    uint _e108 = local_19;
    uint _e110 = asuint(out_1.Load(_e108*4));
    local_20 = _e110;
    uint _e112 = local_20;
    local_10 = _e112;
    uint _e114 = local_10;
    uint _e115[2] = out_;
    local_4 = _e115;
    local_5 = uint(((base + 128u) + lane));
    uint _e122[2] = local_4;
    local_21 = _e122;
    uint _e124 = local_5;
    uint _e126 = local_21[1];
    local_21[1] = (_e126 + _e124);
    uint _e130 = local_21[0];
    local_22 = uint(_e130);
    uint _e134 = local_21[1];
    local_23 = uint(_e134);
    uint _e137 = local_23;
    out_1.Store(_e137*4, asuint(_e114));
    uint _e140 = broadcast;
    uint _e141[2] = out_;
    local_8 = _e141;
    local_9 = uint(((base + 192u) + lane));
    uint _e148[2] = local_8;
    local_24 = _e148;
    uint _e150 = local_9;
    uint _e152 = local_24[1];
    local_24[1] = (_e152 + _e150);
    uint _e156 = local_24[0];
    local_25 = uint(_e156);
    uint _e160 = local_24[1];
    local_26 = uint(_e160);
    uint _e163 = local_26;
    out_1.Store(_e163*4, asuint(_e140));
}
