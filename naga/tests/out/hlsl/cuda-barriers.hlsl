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
    uint lane = (uint)0;
    uint base = (uint)0;
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
    lane = threadIdx.x;
    base = (blockIdx.x * 256u);
    uint _e18 = lane;
    uint _e22 = lane;
    values[min(uint(_e22), 63u)] = (((blockIdx.x * 2000u) + _e18) + 7u);
    uint _e28 = lane;
    uint _e32[2] = out_;
    local = _e32;
    uint _e33 = base;
    uint _e34 = lane;
    local_1 = uint((_e33 + _e34));
    uint _e39[2] = local;
    local_11 = _e39;
    uint _e40 = local_1;
    uint _e42 = local_11[1];
    local_11[1] = (_e42 + _e40);
    uint _e46 = local_11[0];
    local_12 = uint(_e46);
    uint _e50 = local_11[1];
    local_13 = uint(_e50);
    uint _e53 = local_13;
    out_1.Store(_e53*4, asuint(((blockIdx.x * 1000u) + _e28)));
    uint _e55 = lane;
    if ((_e55 == 0u)) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e64 = lane;
    uint _e68 = values[min(uint((63u - _e64)), 63u)];
    uint _e70[2] = out_;
    local_2 = _e70;
    uint _e71 = base;
    uint _e74 = lane;
    local_3 = uint(((_e71 + 64u) + _e74));
    uint _e79[2] = local_2;
    local_14 = _e79;
    uint _e80 = local_3;
    uint _e82 = local_14[1];
    local_14[1] = (_e82 + _e80);
    uint _e86 = local_14[0];
    local_15 = uint(_e86);
    uint _e90 = local_14[1];
    local_16 = uint(_e90);
    uint _e93 = local_16;
    out_1.Store(_e93*4, asuint(_e68));
    uint _e96[2] = out_;
    local_6 = _e96;
    uint _e97 = lane;
    uint _e102 = base;
    local_7 = uint((_e102 + naga_mod((_e97 + 1u), 64u)));
    uint _e107[2] = local_6;
    local_17 = _e107;
    uint _e108 = local_7;
    uint _e110 = local_17[1];
    local_17[1] = (_e110 + _e108);
    uint _e114 = local_17[0];
    local_18 = uint(_e114);
    uint _e118 = local_17[1];
    local_19 = uint(_e118);
    uint _e122 = local_19;
    uint _e124 = asuint(out_1.Load(_e122*4));
    local_20 = _e124;
    uint _e125 = local_20;
    local_10 = _e125;
    uint _e127 = local_10;
    uint _e129[2] = out_;
    local_4 = _e129;
    uint _e130 = base;
    uint _e133 = lane;
    local_5 = uint(((_e130 + 128u) + _e133));
    uint _e138[2] = local_4;
    local_21 = _e138;
    uint _e139 = local_5;
    uint _e141 = local_21[1];
    local_21[1] = (_e141 + _e139);
    uint _e145 = local_21[0];
    local_22 = uint(_e145);
    uint _e149 = local_21[1];
    local_23 = uint(_e149);
    uint _e152 = local_23;
    out_1.Store(_e152*4, asuint(_e127));
    uint _e155 = broadcast;
    uint _e157[2] = out_;
    local_8 = _e157;
    uint _e158 = base;
    uint _e161 = lane;
    local_9 = uint(((_e158 + 192u) + _e161));
    uint _e166[2] = local_8;
    local_24 = _e166;
    uint _e167 = local_9;
    uint _e169 = local_24[1];
    local_24[1] = (_e169 + _e167);
    uint _e173 = local_24[0];
    local_25 = uint(_e173);
    uint _e177 = local_24[1];
    local_26 = uint(_e177);
    uint _e180 = local_26;
    out_1.Store(_e180*4, asuint(_e155));
}
