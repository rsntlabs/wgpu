RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);

[numthreads(4, 1, 1)]
void funnel_shifts_clamped(uint3 threadIdx : SV_GroupThreadID)
{
    uint row = (uint)0;
    uint at = (uint)0;
    uint lo = (uint)0;
    uint local = (uint)0;
    uint hi = (uint)0;
    uint local_1 = (uint)0;
    uint shift = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint value = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    bool local_8 = (bool)0;
    bool local_9 = (bool)0;
    uint local_10 = (uint)0;
    uint index = (uint)0;
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
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;

    uint lane = threadIdx.x;
    uint count = asuint(input.Load(uint(int(0))*4));
    {
        row = lane;
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e113 = row;
                row = (_e113 + 4u);
            }
            loop_init = false;
            uint _e8 = row;
            if ((_e8 < count)) {
            } else {
                break;
            }
            uint _e10 = row;
            at = (1u + (_e10 * 3u));
            uint _e16 = at;
            local = _e16;
            uint _e18 = local;
            local_16 = _e18;
            uint _e20 = local_16;
            uint _e22 = asuint(input.Load(_e20*4));
            local_17 = _e22;
            uint _e24 = local_17;
            local_13 = _e24;
            uint _e26 = local_13;
            lo = _e26;
            uint _e28 = at;
            local_1 = uint((_e28 + 1u));
            uint _e33 = local_1;
            local_18 = _e33;
            uint _e35 = local_18;
            uint _e37 = asuint(input.Load(_e35*4));
            local_19 = _e37;
            uint _e39 = local_19;
            local_14 = _e39;
            uint _e41 = local_14;
            hi = _e41;
            uint _e43 = at;
            local_2 = uint((_e43 + 2u));
            uint _e48 = local_2;
            local_20 = _e48;
            uint _e50 = local_20;
            uint _e52 = asuint(input.Load(_e50*4));
            local_21 = _e52;
            uint _e54 = local_21;
            local_15 = _e54;
            uint _e56 = local_15;
            shift = _e56;
            uint _e58 = lo;
            uint _e59 = hi;
            uint _e60 = shift;
            uint _e62 = (_e60 & 31u);
            uint _e74 = row;
            local_3 = uint((4u + (_e74 * 2u)));
            uint _e81 = local_3;
            local_22 = _e81;
            uint _e83 = local_22;
            output.Store(_e83*4, asuint(((_e60 >= 32u) ? _e58 : ((_e62 != 0u) ? ((_e59 << _e62) | (_e58 >> ((32u - _e62) & 31u))) : _e59))));
            uint _e86 = lo;
            uint _e87 = hi;
            uint _e88 = shift;
            uint _e90 = (_e88 & 31u);
            uint _e102 = row;
            local_4 = uint((5u + (_e102 * 2u)));
            uint _e109 = local_4;
            local_23 = _e109;
            uint _e111 = local_23;
            output.Store(_e111*4, asuint(((_e88 >= 32u) ? _e87 : ((_e90 != 0u) ? ((_e86 >> _e90) | (_e87 << ((32u - _e90) & 31u))) : _e86))));
        }
    }
    uint base = ((4u + (count * 2u)) + (lane * 6u));
    value = 1u;
    uint _e125 = value;
    value = (_e125 + uint(int(1)));
    uint _e129 = value;
    value = (_e129 + uint(int(1)));
    uint _e133 = value;
    value = (_e133 + uint(int(1)));
    uint _e138 = (_e133 & 31u);
    output.Store(base*4, asuint(((_e133 >= 32u) ? _e125 : ((_e138 != 0u) ? ((_e129 << _e138) | (_e125 >> ((32u - _e138) & 31u))) : _e129))));
    uint _e152 = value;
    value = (_e152 + uint(int(1)));
    uint _e156 = value;
    value = (_e156 + uint(int(1)));
    uint _e160 = value;
    value = (_e160 + uint(int(1)));
    uint _e165 = (_e160 & 31u);
    local_5 = uint((base + 1u));
    uint _e181 = local_5;
    output.Store(_e181*4, asuint(((_e160 >= 32u) ? _e156 : ((_e165 != 0u) ? ((_e152 >> _e165) | (_e156 << ((32u - _e165) & 31u))) : _e152))));
    if (((lane & 1u) == 0u)) {
        uint _e187 = value;
        value = (_e187 + uint(int(1)));
        uint _e191 = value;
        value = (_e191 + uint(int(1)));
        uint _e195 = value;
        value = (_e195 + uint(int(1)));
        uint _e200 = (_e195 & 31u);
        local_6 = ((_e195 >= 32u) ? _e187 : ((_e200 != 0u) ? ((_e191 << _e200) | (_e187 >> ((32u - _e200) & 31u))) : _e191));
    } else {
        local_6 = 0u;
    }
    uint _e215 = value;
    local_7 = uint((base + 2u));
    uint _e220 = local_7;
    output.Store(_e220*4, asuint(_e215));
    local_8 = false;
    if (false) {
        uint _e224 = value;
        value = (_e224 + uint(int(1)));
        uint _e228 = value;
        value = (_e228 + uint(int(1)));
        uint _e232 = value;
        value = (_e232 + uint(int(1)));
        uint _e237 = (_e232 & 31u);
        local_8 = (((_e232 >= 32u) ? _e228 : ((_e237 != 0u) ? ((_e224 >> _e237) | (_e228 << ((32u - _e237) & 31u))) : _e224)) != 0u);
    }
    local_9 = true;
    if (true) {
    } else {
        uint _e253 = value;
        value = (_e253 + uint(int(1)));
        uint _e257 = value;
        value = (_e257 + uint(int(1)));
        uint _e261 = value;
        value = (_e261 + uint(int(1)));
        uint _e266 = (_e261 & 31u);
        local_9 = (((_e261 >= 32u) ? _e253 : ((_e266 != 0u) ? ((_e257 << _e266) | (_e253 >> ((32u - _e266) & 31u))) : _e257)) != 0u);
    }
    uint _e280 = value;
    value = (_e280 + uint(int(1)));
    uint _e284 = value;
    value = (_e284 + uint(int(1)));
    uint _e288 = value;
    value = (_e288 + uint(int(1)));
    uint _e292 = value;
    local_10 = uint((base + 3u));
    uint _e297 = local_10;
    output.Store(_e297*4, asuint(_e292));
    index = 1u;
    uint _e301 = index;
    index = (_e301 + uint(int(1)));
    uint _e306 = asuint(input.Load(_e301*4));
    uint _e307 = index;
    index = (_e307 + uint(int(1)));
    uint _e312 = asuint(input.Load(_e307*4));
    uint _e313 = index;
    index = (_e313 + uint(int(1)));
    uint _e318 = asuint(input.Load(_e313*4));
    uint _e320 = (_e318 & 31u);
    local_11 = uint((base + 4u));
    uint _e336 = local_11;
    output.Store(_e336*4, asuint(((_e318 >= 32u) ? _e306 : ((_e320 != 0u) ? ((_e312 << _e320) | (_e306 >> ((32u - _e320) & 31u))) : _e312))));
    uint _e338 = index;
    local_12 = uint((base + 5u));
    uint _e343 = local_12;
    output.Store(_e343*4, asuint(_e338));
}
