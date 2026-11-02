RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);
groupshared uint values[4];
RWByteAddressBuffer output_1 : register(u0);
ByteAddressBuffer input_1 : register(t1);
groupshared uint values_1[8];

uint adjusted_4_(uint value)
{
    return (value + uint(int(4)));
}

uint adjusted_8_(uint value_1)
{
    return (value_1 + uint(int(8)));
}

[numthreads(4, 1, 1)]
void reduce_4_(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        values = (uint[4])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint local = (uint)0;
    uint stride = (uint)0;
    uint local_1 = (uint)0;

    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 4u);
    local = uint((base + lane));
    uint _e9 = local;
    uint _e12 = asuint(input.Load(_e9*4));
    values[min(uint(lane), 3u)] = _e12;
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    {
        stride = 2u;
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e29 = stride;
                stride = (_e29 >> 1u);
            }
            loop_init = false;
            uint _e17 = stride;
            if ((_e17 > 0u)) {
            } else {
                break;
            }
            uint _e20 = stride;
            if ((lane < _e20)) {
                uint _e22 = stride;
                uint _e25 = values[min(uint((lane + _e22)), 3u)];
                uint _e27 = values[min(uint(lane), 3u)];
                values[min(uint(lane), 3u)] = (_e27 + _e25);
            }
            DeviceMemoryBarrierWithGroupSync();
            GroupMemoryBarrierWithGroupSync();
        }
    }
    uint _e34 = values[int(0)];
    const uint _e35 = adjusted_4_(_e34);
    local_1 = uint((base + lane));
    uint _e39 = local_1;
    output.Store(_e39*4, asuint(_e35));
}

[numthreads(4, 1, 1)]
void reduce_8_(uint3 threadIdx_1 : SV_GroupThreadID, uint3 blockIdx_1 : SV_GroupID, uint local_invocation_index_1 : SV_GroupIndex)
{
    if (local_invocation_index_1 == 0) {
        values_1 = (uint[8])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint local_2 = (uint)0;
    uint stride_1 = (uint)0;
    uint local_3 = (uint)0;

    uint lane_1 = threadIdx_1.x;
    uint base_1 = (blockIdx_1.x * 4u);
    local_2 = uint((base_1 + lane_1));
    uint _e9 = local_2;
    uint _e12 = asuint(input_1.Load(_e9*4));
    values_1[min(uint(lane_1), 7u)] = _e12;
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    {
        stride_1 = 2u;
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                uint _e29 = stride_1;
                stride_1 = (_e29 >> 1u);
            }
            loop_init_1 = false;
            uint _e17 = stride_1;
            if ((_e17 > 0u)) {
            } else {
                break;
            }
            uint _e20 = stride_1;
            if ((lane_1 < _e20)) {
                uint _e22 = stride_1;
                uint _e25 = values_1[min(uint((lane_1 + _e22)), 7u)];
                uint _e27 = values_1[min(uint(lane_1), 7u)];
                values_1[min(uint(lane_1), 7u)] = (_e27 + _e25);
            }
            DeviceMemoryBarrierWithGroupSync();
            GroupMemoryBarrierWithGroupSync();
        }
    }
    uint _e34 = values_1[int(0)];
    const uint _e35 = adjusted_8_(_e34);
    local_3 = uint((base_1 + lane_1));
    uint _e39 = local_3;
    output_1.Store(_e39*4, asuint(_e35));
}
