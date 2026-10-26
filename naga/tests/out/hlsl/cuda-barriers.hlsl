RWByteAddressBuffer out_ : register(u0);
groupshared uint values[64];
groupshared uint broadcast;

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

[numthreads(64, 1, 1)]
void barriers(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        values = (uint[64])0;
        broadcast = (uint)0;
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
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;

    local = 0u;
    lane = threadIdx.x;
    base = (blockIdx.x * 256u);
    uint _e13 = lane;
    uint _e17 = lane;
    values[min(uint(_e17), 63u)] = (((blockIdx.x * 2000u) + _e13) + 7u);
    uint _e23 = lane;
    uint _e25 = local;
    local_1 = _e25;
    uint _e27 = local_1;
    local_2 = uint(_e27);
    uint _e30 = base;
    uint _e31 = lane;
    local_3 = uint((_e30 + _e31));
    uint _e36 = local_2;
    uint _e37 = local_3;
    local_16 = uint((_e36 + _e37));
    uint _e41 = local_16;
    out_.Store(_e41*4, asuint(((blockIdx.x * 1000u) + _e23)));
    uint _e43 = lane;
    if ((_e43 == 0u)) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e52 = lane;
    uint _e56 = values[min(uint((63u - _e52)), 63u)];
    uint _e57 = local;
    local_4 = _e57;
    uint _e59 = local_4;
    local_5 = uint(_e59);
    uint _e62 = base;
    uint _e65 = lane;
    local_6 = uint(((_e62 + 64u) + _e65));
    uint _e69 = local_5;
    uint _e70 = local_6;
    local_17 = uint((_e69 + _e70));
    uint _e74 = local_17;
    out_.Store(_e74*4, asuint(_e56));
    uint _e76 = local;
    local_10 = _e76;
    uint _e78 = local_10;
    local_11 = uint(_e78);
    uint _e81 = lane;
    uint _e86 = base;
    local_12 = uint((_e86 + naga_mod((_e81 + 1u), 64u)));
    uint _e90 = local_11;
    uint _e91 = local_12;
    local_18 = uint((_e90 + _e91));
    uint _e96 = local_18;
    uint _e98 = asuint(out_.Load(_e96*4));
    local_19 = _e98;
    uint _e99 = local_19;
    uint _e100 = local;
    local_7 = _e100;
    uint _e102 = local_7;
    local_8 = uint(_e102);
    uint _e105 = base;
    uint _e108 = lane;
    local_9 = uint(((_e105 + 128u) + _e108));
    uint _e112 = local_8;
    uint _e113 = local_9;
    local_20 = uint((_e112 + _e113));
    uint _e117 = local_20;
    out_.Store(_e117*4, asuint(_e99));
    uint _e120 = broadcast;
    uint _e121 = local;
    local_13 = _e121;
    uint _e123 = local_13;
    local_14 = uint(_e123);
    uint _e126 = base;
    uint _e129 = lane;
    local_15 = uint(((_e126 + 192u) + _e129));
    uint _e133 = local_14;
    uint _e134 = local_15;
    local_21 = uint((_e133 + _e134));
    uint _e138 = local_21;
    out_.Store(_e138*4, asuint(_e120));
}
