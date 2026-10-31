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

    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 256u);
    values[min(uint(lane), 63u)] = (((blockIdx.x * 2000u) + lane) + 7u);
    local = uint((base + lane));
    uint _e21 = local;
    local_6 = uint(_e21);
    uint _e24 = local_6;
    out_.Store(_e24*4, asuint(((blockIdx.x * 1000u) + lane)));
    if ((lane == 0u)) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e38 = values[min(uint((63u - lane)), 63u)];
    local_1 = uint(((base + 64u) + lane));
    uint _e44 = local_1;
    local_7 = uint(_e44);
    uint _e47 = local_7;
    out_.Store(_e47*4, asuint(_e38));
    local_3 = uint((base + naga_mod((lane + 1u), 64u)));
    uint _e56 = local_3;
    local_8 = uint(_e56);
    uint _e59 = local_8;
    uint _e61 = asuint(out_.Load(_e59*4));
    local_9 = _e61;
    uint _e63 = local_9;
    local_5 = _e63;
    uint _e65 = local_5;
    local_2 = uint(((base + 128u) + lane));
    uint _e71 = local_2;
    local_10 = uint(_e71);
    uint _e74 = local_10;
    out_.Store(_e74*4, asuint(_e65));
    uint _e77 = broadcast;
    local_4 = uint(((base + 192u) + lane));
    uint _e83 = local_4;
    local_11 = uint(_e83);
    uint _e86 = local_11;
    out_.Store(_e86*4, asuint(_e77));
}
