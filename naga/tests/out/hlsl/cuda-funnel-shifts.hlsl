RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);

[numthreads(4, 1, 1)]
void funnel_shifts(uint3 threadIdx : SV_GroupThreadID)
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
                uint _e109 = row;
                row = (_e109 + 4u);
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
            uint _e72 = row;
            local_3 = uint((4u + (_e72 * 2u)));
            uint _e79 = local_3;
            local_22 = _e79;
            uint _e81 = local_22;
            output.Store(_e81*4, asuint(((_e62 != 0u) ? ((_e59 << _e62) | (_e58 >> ((32u - _e62) & 31u))) : _e59)));
            uint _e84 = lo;
            uint _e85 = hi;
            uint _e86 = shift;
            uint _e88 = (_e86 & 31u);
            uint _e98 = row;
            local_4 = uint((5u + (_e98 * 2u)));
            uint _e105 = local_4;
            local_23 = _e105;
            uint _e107 = local_23;
            output.Store(_e107*4, asuint(((_e88 != 0u) ? ((_e84 >> _e88) | (_e85 << ((32u - _e88) & 31u))) : _e84)));
        }
    }
    uint base = ((4u + (count * 2u)) + (lane * 6u));
    value = 1u;
    uint _e121 = value;
    value = (_e121 + uint(int(1)));
    uint _e125 = value;
    value = (_e125 + uint(int(1)));
    uint _e129 = value;
    value = (_e129 + uint(int(1)));
    uint _e134 = (_e129 & 31u);
    output.Store(base*4, asuint(((_e134 != 0u) ? ((_e125 << _e134) | (_e121 >> ((32u - _e134) & 31u))) : _e125)));
    uint _e146 = value;
    value = (_e146 + uint(int(1)));
    uint _e150 = value;
    value = (_e150 + uint(int(1)));
    uint _e154 = value;
    value = (_e154 + uint(int(1)));
    uint _e159 = (_e154 & 31u);
    local_5 = uint((base + 1u));
    uint _e173 = local_5;
    output.Store(_e173*4, asuint(((_e159 != 0u) ? ((_e146 >> _e159) | (_e150 << ((32u - _e159) & 31u))) : _e146)));
    if (((lane & 1u) == 0u)) {
        uint _e179 = value;
        value = (_e179 + uint(int(1)));
        uint _e183 = value;
        value = (_e183 + uint(int(1)));
        uint _e187 = value;
        value = (_e187 + uint(int(1)));
        uint _e192 = (_e187 & 31u);
        local_6 = ((_e192 != 0u) ? ((_e183 << _e192) | (_e179 >> ((32u - _e192) & 31u))) : _e183);
    } else {
        local_6 = 0u;
    }
    uint _e205 = value;
    local_7 = uint((base + 2u));
    uint _e210 = local_7;
    output.Store(_e210*4, asuint(_e205));
    local_8 = false;
    if (false) {
        uint _e214 = value;
        value = (_e214 + uint(int(1)));
        uint _e218 = value;
        value = (_e218 + uint(int(1)));
        uint _e222 = value;
        value = (_e222 + uint(int(1)));
        uint _e227 = (_e222 & 31u);
        local_8 = (((_e227 != 0u) ? ((_e214 >> _e227) | (_e218 << ((32u - _e227) & 31u))) : _e214) != 0u);
    }
    local_9 = true;
    if (true) {
    } else {
        uint _e241 = value;
        value = (_e241 + uint(int(1)));
        uint _e245 = value;
        value = (_e245 + uint(int(1)));
        uint _e249 = value;
        value = (_e249 + uint(int(1)));
        uint _e254 = (_e249 & 31u);
        local_9 = (((_e254 != 0u) ? ((_e245 << _e254) | (_e241 >> ((32u - _e254) & 31u))) : _e245) != 0u);
    }
    uint _e266 = value;
    value = (_e266 + uint(int(1)));
    uint _e270 = value;
    value = (_e270 + uint(int(1)));
    uint _e274 = value;
    value = (_e274 + uint(int(1)));
    uint _e278 = value;
    local_10 = uint((base + 3u));
    uint _e283 = local_10;
    output.Store(_e283*4, asuint(_e278));
    index = 1u;
    uint _e287 = index;
    index = (_e287 + uint(int(1)));
    uint _e292 = asuint(input.Load(_e287*4));
    uint _e293 = index;
    index = (_e293 + uint(int(1)));
    uint _e298 = asuint(input.Load(_e293*4));
    uint _e299 = index;
    index = (_e299 + uint(int(1)));
    uint _e304 = asuint(input.Load(_e299*4));
    uint _e306 = (_e304 & 31u);
    local_11 = uint((base + 4u));
    uint _e320 = local_11;
    output.Store(_e320*4, asuint(((_e306 != 0u) ? ((_e298 << _e306) | (_e292 >> ((32u - _e306) & 31u))) : _e298)));
    uint _e322 = index;
    local_12 = uint((base + 5u));
    uint _e327 = local_12;
    output.Store(_e327*4, asuint(_e322));
}
