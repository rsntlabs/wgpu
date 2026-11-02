groupshared uint helper_values[4];
RWByteAddressBuffer output_1 : register(u0);
groupshared uint fixed_values[4];

void initialize(uint index, uint value)
{
    helper_values[min(uint(index), 3u)] = value;
    return;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(4, 1, 1)]
void exchange(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID, uint local_invocation_index : SV_GroupIndex)
{
    if (local_invocation_index == 0) {
        helper_values = (uint[4])0;
        fixed_values = (uint[4])0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint output[2] = (uint[2])0;
    uint neighbor = (uint)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint pointer[2] = (uint[2])0;
    uint local_2[2] = (uint[2])0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;

    output = ZeroValuearray2_uint_();
    output[0] = 2u;
    output[1] = 0u;
    uint lane = threadIdx.x;
    uint base = (blockIdx.x * 8u);
    initialize(lane, (((blockIdx.x * 10u) + lane) + 1u));
    fixed_values[min(uint(lane), 3u)] = (100u + lane);
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    {
        neighbor = naga_mod((lane + 1u), 4u);
        uint _e27 = neighbor;
        uint _e31 = helper_values[min(uint(_e27), 3u)];
        uint _e32 = fixed_values[min(uint(lane), 3u)];
        uint _e35[2] = output;
        local = _e35;
        local_1 = uint((base + lane));
        uint _e40[2] = local;
        local_5 = _e40;
        uint _e42 = local_1;
        uint _e44 = local_5[1];
        local_5[1] = (_e44 + _e42);
        uint _e48 = local_5[0];
        local_6 = uint(_e48);
        uint _e52 = local_5[1];
        local_7 = uint(_e52);
        uint _e55 = local_7;
        output_1.Store(_e55*4, asuint((_e31 + _e32)));
    }
    DeviceMemoryBarrierWithGroupSync();
    GroupMemoryBarrierWithGroupSync();
    pointer = ZeroValuearray2_uint_();
    pointer[0] = 3u;
    pointer[1] = 0u;
    uint _e65[2] = pointer;
    local_2 = _e65;
    uint _e67[2] = local_2;
    local_8 = _e67;
    uint _e70 = local_8[1];
    local_8[1] = (_e70 + lane);
    uint _e74 = local_8[0];
    local_9 = uint(_e74);
    uint _e78 = local_8[1];
    local_10 = uint(_e78);
    uint _e81 = local_10;
    uint _e84 = helper_values[min(uint(_e81), 3u)];
    uint _e88 = local_10;
    helper_values[min(uint(_e88), 3u)] = (_e84 + uint(int(1)));
    uint _e92 = helper_values[min(uint(lane), 3u)];
    uint _e93[2] = output;
    local_3 = _e93;
    local_4 = uint(((base + 4u) + lane));
    uint _e100[2] = local_3;
    local_11 = _e100;
    uint _e102 = local_4;
    uint _e104 = local_11[1];
    local_11[1] = (_e104 + _e102);
    uint _e108 = local_11[0];
    local_12 = uint(_e108);
    uint _e112 = local_11[1];
    local_13 = uint(_e112);
    uint _e115 = local_13;
    output_1.Store(_e115*4, asuint(_e92));
}
