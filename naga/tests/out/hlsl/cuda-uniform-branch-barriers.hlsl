struct type_2 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);
cbuffer mode : register(b2) { type_2 mode; }
groupshared uint values[4];

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

[numthreads(4, 1, 1)]
void exchange(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        values = (uint[4])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint local = (uint)0;
    uint transformed = (uint)0;
    uint local_1 = (uint)0;

    uint mode_1 = mode.value;
    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 4u);
    local = uint((base + lane));
    uint _e12 = local;
    uint _e15 = asuint(input.Load(_e12*4));
    values[min(uint(lane), 3u)] = _e15;
    if ((mode_1 != 0u)) {
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        uint _e25 = values[min(uint(naga_mod((lane + 1u), 4u)), 3u)];
        transformed = (_e25 + 10u);
    } else {
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
        uint _e34 = values[min(uint(naga_mod((lane + 2u), 4u)), 3u)];
        transformed = (_e34 + 20u);
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e39 = transformed;
    values[min(uint(lane), 3u)] = _e39;
    switch(naga_mod((blockIdx.x + mode_1), 3u)) {
        case 0u: {
            DeviceMemoryBarrierWithGroupSync();
            GroupMemoryBarrierWithGroupSync();
            uint _e46 = values[min(uint(lane), 3u)];
            values[min(uint(lane), 3u)] = (_e46 + 1u);
            break;
        }
        case 1u: {
            DeviceMemoryBarrierWithGroupSync();
            GroupMemoryBarrierWithGroupSync();
            uint _e50 = values[min(uint(lane), 3u)];
            values[min(uint(lane), 3u)] = (_e50 * 2u);
            DeviceMemoryBarrierWithGroupSync();
            GroupMemoryBarrierWithGroupSync();
            uint _e54 = values[min(uint(lane), 3u)];
            values[min(uint(lane), 3u)] = (_e54 + 3u);
            break;
        }
        default: {
            DeviceMemoryBarrierWithGroupSync();
            GroupMemoryBarrierWithGroupSync();
            uint _e58 = values[min(uint(lane), 3u)];
            values[min(uint(lane), 3u)] = (_e58 + 3u);
            break;
        }
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    uint _e66 = values[min(uint(naga_mod((lane + 3u), 4u)), 3u)];
    local_1 = uint((base + lane));
    uint _e70 = local_1;
    output.Store(_e70*4, asuint(_e66));
}
