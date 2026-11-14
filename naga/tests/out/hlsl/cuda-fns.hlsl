RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);
groupshared uint shared_values[4];

uint _naga_fns(uint mask, uint base, int offset)
{
    int position = (int)0;
    int remaining = (int)0;

    if ((base > 31u)) {
        return 4294967295u;
    }
    uint _e8 = (base & 31u);
    if ((offset == int(0))) {
        return ((((mask >> _e8) & 1u) != 0u) ? base : 4294967295u);
    }
    int _e18 = ((offset > int(0)) ? int(1) : int(-1));
    position = int(_e8);
    remaining = offset;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        int _e23 = position;
        if (((_e23 < int(0)) || (_e23 > int(31)))) {
            break;
        }
        uint _e27 = uint(_e23);
        if ((((mask >> (_e27 & 31u)) & 1u) != 0u)) {
            int _e32 = remaining;
            if ((_e32 == _e18)) {
                return _e27;
            }
            remaining = asint(asuint(_e32) - asuint(_e18));
        }
        position = asint(asuint(_e23) + asuint(_e18));
    }
    return 4294967295u;
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

[numthreads(4, 1, 1)]
void fns(uint3 threadIdx : SV_GroupThreadID, uint local_invocation_index : SV_GroupIndex)
{
    [loop]
    for (uint zero_flat_index = local_invocation_index; zero_flat_index < 4u; zero_flat_index += 4u) {
        uint zero_index = zero_flat_index;
        shared_values[zero_index] = (uint)0;
    }
    GroupMemoryBarrierWithGroupSync();
    uint row = (uint)0;
    uint at = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint value = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    int local_6 = (int)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    bool local_10 = (bool)0;
    bool local_11 = (bool)0;
    uint local_12 = (uint)0;
    uint index = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;

    uint lane = threadIdx.x;
    uint count = asuint(input.Load(uint(int(0))*4));
    shared_values[min(uint(lane), 3u)] = (lane + 1u);
    const uint _e14 = _naga_fns(1u, 0u, int(1));
    if ((_e14 == 0u)) {
        DeviceMemoryBarrierWithGroupSync();
        GroupMemoryBarrierWithGroupSync();
    }
    {
        row = lane;
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init) {
                uint _e77 = row;
                row = (_e77 + 4u);
            }
            loop_init = false;
            uint _e18 = row;
            if ((_e18 < count)) {
            } else {
                break;
            }
            uint _e20 = row;
            at = (1u + (_e20 * 3u));
            uint _e26 = at;
            local_1 = _e26;
            uint _e28 = local_1;
            local_23 = _e28;
            uint _e30 = local_23;
            uint _e32 = asuint(input.Load(_e30*4));
            local_24 = _e32;
            uint _e34 = local_24;
            local_20 = _e34;
            uint _e36 = local_20;
            uint _e37 = at;
            local_2 = uint((_e37 + 1u));
            uint _e42 = local_2;
            local_25 = _e42;
            uint _e44 = local_25;
            uint _e46 = asuint(input.Load(_e44*4));
            local_26 = _e46;
            uint _e48 = local_26;
            local_21 = _e48;
            uint _e50 = local_21;
            uint _e51 = at;
            local_3 = uint((_e51 + 2u));
            uint _e56 = local_3;
            local_27 = _e56;
            uint _e58 = local_27;
            uint _e60 = asuint(input.Load(_e58*4));
            local_28 = _e60;
            uint _e62 = local_28;
            local_22 = _e62;
            uint _e64 = local_22;
            const uint _e66 = _naga_fns(_e36, _e50, int(_e64));
            uint _e67 = row;
            local = uint((4u + _e67));
            uint _e72 = local;
            local_29 = _e72;
            uint _e74 = local_29;
            output.Store(_e74*4, asuint(_e66));
        }
    }
    uint base_1 = ((4u + count) + (lane * 11u));
    value = 1u;
    uint _e87 = value;
    value = (_e87 + uint(int(1)));
    local_4 = ((_e87 * 16909060u) ^ 2164195711u);
    uint _e96 = local_4;
    uint _e97 = value;
    value = (_e97 + uint(int(1)));
    local_5 = ((_e97 * 5u) & 31u);
    uint _e106 = local_5;
    uint _e107 = value;
    value = (_e107 + uint(int(1)));
    local_6 = asint(asuint(int(2)) - asuint(int(_e107)));
    int _e115 = local_6;
    const uint _e116 = _naga_fns(_e96, _e106, _e115);
    output.Store(base_1*4, asuint(_e116));
    uint _e119 = value;
    local_7 = uint((base_1 + 1u));
    uint _e124 = local_7;
    output.Store(_e124*4, asuint(_e119));
    if (((lane & 1u) == 0u)) {
        uint _e130 = value;
        value = (_e130 + uint(int(1)));
        const uint _e136 = _naga_fns(_e130, 0u, int(1));
        local_8 = _e136;
    } else {
        local_8 = 0u;
    }
    uint _e140 = value;
    local_9 = uint((base_1 + 2u));
    uint _e145 = local_9;
    output.Store(_e145*4, asuint(_e140));
    local_10 = false;
    if (false) {
        uint _e149 = value;
        value = (_e149 + uint(int(1)));
        const uint _e155 = _naga_fns(_e149, 0u, int(1));
        local_10 = (_e155 != 0u);
    }
    local_11 = true;
    if (true) {
    } else {
        uint _e160 = value;
        value = (_e160 + uint(int(1)));
        const uint _e166 = _naga_fns(_e160, 0u, int(1));
        local_11 = (_e166 != 0u);
    }
    uint _e169 = value;
    value = (_e169 + uint(int(1)));
    const uint _e175 = _naga_fns(_e169, 0u, int(1));
    uint _e176 = value;
    local_12 = uint((base_1 + 3u));
    uint _e181 = local_12;
    output.Store(_e181*4, asuint(_e176));
    index = 1u;
    uint _e185 = index;
    index = (_e185 + uint(int(1)));
    uint _e190 = asuint(input.Load(_e185*4));
    uint _e191 = index;
    index = (_e191 + uint(int(1)));
    uint _e196 = asuint(input.Load(_e191*4));
    uint _e197 = index;
    index = (_e197 + uint(int(1)));
    uint _e202 = asuint(input.Load(_e197*4));
    const uint _e204 = _naga_fns(_e190, _e196, int(_e202));
    local_13 = uint((base_1 + 4u));
    uint _e209 = local_13;
    output.Store(_e209*4, asuint(_e204));
    uint _e211 = index;
    local_14 = uint((base_1 + 5u));
    uint _e216 = local_14;
    output.Store(_e216*4, asuint(_e211));
    const uint _e221 = _naga_fns(2863311530u, 2u, int(0));
    local_15 = uint((base_1 + 6u));
    uint _e226 = local_15;
    output.Store(_e226*4, asuint(_e221));
    const uint _e231 = _naga_fns(2863311530u, 2u, int(1));
    local_16 = uint((base_1 + 7u));
    uint _e236 = local_16;
    output.Store(_e236*4, asuint(_e231));
    const uint _e242 = _naga_fns(2863311530u, 2u, naga_neg(int(1)));
    local_17 = uint((base_1 + 8u));
    uint _e247 = local_17;
    output.Store(_e247*4, asuint(_e242));
    const uint _e255 = _naga_fns(4294967295u, 31u, asint(asuint(naga_neg(int(2147483647))) - asuint(int(1))));
    local_18 = uint((base_1 + 9u));
    uint _e260 = local_18;
    output.Store(_e260*4, asuint(_e255));
    uint _e267 = shared_values[min(uint(((lane + 1u) & 3u)), 3u)];
    local_19 = uint((base_1 + 10u));
    uint _e272 = local_19;
    output.Store(_e272*4, asuint(_e267));
}
