struct type_2 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer output : register(u0);
cbuffer mode_1 : register(b1) { type_2 mode_1; }
cbuffer count_1 : register(b2) { type_2 count_1; }

void synchronize()
{
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    return;
}

void rounds(uint count, uint mode)
{
    uint iteration = (uint)0;

    {
        iteration = 0u;
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e8 = iteration;
                iteration = (_e8 + uint(int(1)));
            }
            loop_init = false;
            uint _e4 = iteration;
            if ((_e4 < count)) {
            } else {
                break;
            }
            if ((mode != 0u)) {
                DeviceMemoryBarrierWithGroupSync();
                GroupMemoryBarrierWithGroupSync();
            } else {
                DeviceMemoryBarrierWithGroupSync();
                GroupMemoryBarrierWithGroupSync();
            }
        }
        return;
    }
}

uint finish(uint lane)
{
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    if (((lane & 1u) != 0u)) {
        return (lane + 100u);
    }
    return (lane + 200u);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

[numthreads(4, 1, 1)]
void exchange(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;

    uint mode_2 = mode_1.value;
    uint count_2 = count_1.value;
    uint lane_1 = threadIdx.x;
    uint base = (blockIdx.x * 12u);
    local = uint((base + lane_1));
    uint _e21 = local;
    output.Store(_e21*4, asuint((((blockIdx.x * 10u) + lane_1) + 1u)));
    synchronize();
    local_1 = uint((base + naga_mod((lane_1 + 1u), 4u)));
    uint _e31 = local_1;
    uint next = asuint(output.Load(_e31*4));
    synchronize();
    local_2 = uint((base + lane_1));
    uint _e39 = local_2;
    output.Store(_e39*4, asuint((next + 10u)));
    rounds(count_2, mode_2);
    local_4 = uint((base + naga_mod((lane_1 + 1u), 4u)));
    uint _e48 = local_4;
    uint _e50 = asuint(output.Load(_e48*4));
    local_3 = uint(((base + 4u) + lane_1));
    uint _e56 = local_3;
    output.Store(_e56*4, asuint(_e50));
    const uint _e58 = finish(lane_1);
    local_5 = uint(((base + 8u) + lane_1));
    uint _e64 = local_5;
    output.Store(_e64*4, asuint(_e58));
    synchronize();
}
