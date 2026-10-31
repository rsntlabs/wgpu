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

    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 256u);
    values[min(uint(lane), 63u)] = (((blockIdx.x * 2000u) + lane) + 7u);
    local = uint((base + lane));
    uint _e21 = local;
    local_5 = uint(_e21);
    uint _e24 = local_5;
    out_.Store(_e24*4, asuint(((blockIdx.x * 1000u) + lane)));
    if ((lane == 0u)) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e38 = values[min(uint((63u - lane)), 63u)];
    local_1 = uint(((base + 64u) + lane));
    uint _e44 = local_1;
    local_6 = uint(_e44);
    uint _e47 = local_6;
    out_.Store(_e47*4, asuint(_e38));
    local_3 = uint((base + naga_mod((lane + 1u), 64u)));
    uint _e56 = local_3;
    local_7 = uint(_e56);
    uint _e59 = local_7;
    uint _e61 = asuint(out_.Load(_e59*4));
    local_2 = uint(((base + 128u) + lane));
    uint _e67 = local_2;
    local_8 = uint(_e67);
    uint _e70 = local_8;
    out_.Store(_e70*4, asuint(_e61));
    uint _e73 = broadcast;
    local_4 = uint(((base + 192u) + lane));
    uint _e79 = local_4;
    local_9 = uint(_e79);
    uint _e82 = local_9;
    out_.Store(_e82*4, asuint(_e73));
}
