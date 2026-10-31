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

    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 256u);
    values[min(uint(lane), 63u)] = (((blockIdx.x * 2000u) + lane) + 7u);
    local = uint((base + lane));
    uint _e21 = local;
    out_.Store(_e21*4, asuint(((blockIdx.x * 1000u) + lane)));
    if ((lane == 0u)) {
        broadcast = ((blockIdx.x * 100u) + 11u);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e35 = values[min(uint((63u - lane)), 63u)];
    local_1 = uint(((base + 64u) + lane));
    uint _e41 = local_1;
    out_.Store(_e41*4, asuint(_e35));
    local_3 = uint((base + naga_mod((lane + 1u), 64u)));
    uint _e50 = local_3;
    uint _e52 = asuint(out_.Load(_e50*4));
    local_2 = uint(((base + 128u) + lane));
    uint _e58 = local_2;
    out_.Store(_e58*4, asuint(_e52));
    uint _e61 = broadcast;
    local_4 = uint(((base + 192u) + lane));
    uint _e67 = local_4;
    out_.Store(_e67*4, asuint(_e61));
}
