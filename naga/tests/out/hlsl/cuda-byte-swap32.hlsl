RWByteAddressBuffer output : register(u0);
ByteAddressBuffer input : register(t1);

int swap_result(uint value_2)
{
    return int(1);
}

[numthreads(4, 1, 1)]
void byte_swap32_(uint3 threadIdx : SV_GroupThreadID)
{
    uint row = (uint)0;
    uint value = (uint)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint value_1 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    bool local_7 = (bool)0;
    bool local_8 = (bool)0;
    uint local_9 = (uint)0;
    uint index = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;

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
                uint _e92 = row;
                row = (_e92 + 4u);
            }
            loop_init = false;
            uint _e8 = row;
            if ((_e8 < count)) {
            } else {
                break;
            }
            uint _e10 = row;
            local = uint((1u + _e10));
            uint _e15 = local;
            local_16 = _e15;
            uint _e17 = local_16;
            uint _e19 = asuint(input.Load(_e17*4));
            local_17 = _e19;
            uint _e21 = local_17;
            local_15 = _e21;
            uint _e23 = local_15;
            value = _e23;
            uint _e25 = value;
            uint _e40 = row;
            local_1 = uint((4u + (_e40 * 2u)));
            uint _e47 = local_1;
            local_18 = _e47;
            uint _e49 = local_18;
            output.Store(_e49*4, asuint(((((_e25 & 255u) << 24u) | ((_e25 & 65280u) << 8u)) | (((_e25 >> 8u) & 65280u) | (_e25 >> 24u)))));
            uint _e52 = value;
            uint _e66 = ((((_e52 & 255u) << 24u) | ((_e52 & 65280u) << 8u)) | (((_e52 >> 8u) & 65280u) | (_e52 >> 24u)));
            uint _e81 = row;
            local_2 = uint((5u + (_e81 * 2u)));
            uint _e88 = local_2;
            local_19 = _e88;
            uint _e90 = local_19;
            output.Store(_e90*4, asuint(((((_e66 & 255u) << 24u) | ((_e66 & 65280u) << 8u)) | (((_e66 >> 8u) & 65280u) | (_e66 >> 24u)))));
        }
    }
    uint base = ((4u + (count * 2u)) + (lane * 10u));
    value_1 = (16909060u + lane);
    uint _e105 = value_1;
    value_1 = (_e105 + uint(int(1)));
    output.Store(base*4, asuint(((((_e105 & 255u) << 24u) | ((_e105 & 65280u) << 8u)) | (((_e105 >> 8u) & 65280u) | (_e105 >> 24u)))));
    uint _e125 = value_1;
    value_1 = (_e125 + uint(int(1)));
    local_3 = uint((base + 1u));
    uint _e147 = local_3;
    output.Store(_e147*4, asuint(((((_e125 & 255u) << 24u) | ((_e125 & 65280u) << 8u)) | (((_e125 >> 8u) & 65280u) | (_e125 >> 24u)))));
    uint _e149 = value_1;
    local_4 = uint((base + 2u));
    uint _e154 = local_4;
    output.Store(_e154*4, asuint(_e149));
    if (((lane & 1u) == 0u)) {
        uint _e160 = value_1;
        value_1 = (_e160 + uint(int(1)));
        local_5 = ((((_e160 & 255u) << 24u) | ((_e160 & 65280u) << 8u)) | (((_e160 >> 8u) & 65280u) | (_e160 >> 24u)));
    } else {
        local_5 = 0u;
    }
    uint _e181 = value_1;
    local_6 = uint((base + 3u));
    uint _e186 = local_6;
    output.Store(_e186*4, asuint(_e181));
    local_7 = false;
    if (false) {
        uint _e190 = value_1;
        value_1 = (_e190 + uint(int(1)));
        local_7 = (((((_e190 & 255u) << 24u) | ((_e190 & 65280u) << 8u)) | (((_e190 >> 8u) & 65280u) | (_e190 >> 24u))) != 0u);
    }
    local_8 = true;
    if (true) {
    } else {
        uint _e212 = value_1;
        value_1 = (_e212 + uint(int(1)));
        local_8 = (((((_e212 & 255u) << 24u) | ((_e212 & 65280u) << 8u)) | (((_e212 >> 8u) & 65280u) | (_e212 >> 24u))) != 0u);
    }
    uint _e232 = value_1;
    value_1 = (_e232 + uint(int(1)));
    uint _e236 = value_1;
    local_9 = uint((base + 4u));
    uint _e241 = local_9;
    output.Store(_e241*4, asuint(_e236));
    index = 1u;
    uint _e245 = index;
    index = (_e245 + uint(int(1)));
    uint _e250 = asuint(input.Load(_e245*4));
    local_10 = uint((base + 5u));
    uint _e269 = local_10;
    output.Store(_e269*4, asuint(((((_e250 & 255u) << 24u) | ((_e250 & 65280u) << 8u)) | (((_e250 >> 8u) & 65280u) | (_e250 >> 24u)))));
    uint _e271 = index;
    local_11 = uint((base + 6u));
    uint _e276 = local_11;
    output.Store(_e276*4, asuint(_e271));
    uint _e278 = value_1;
    const int _e293 = swap_result(((((_e278 & 255u) << 24u) | ((_e278 & 65280u) << 8u)) | (((_e278 >> 8u) & 65280u) | (_e278 >> 24u))));
    local_12 = uint((base + 7u));
    uint _e299 = local_12;
    output.Store(_e299*4, asuint(uint(_e293)));
    local_13 = uint((base + 8u));
    uint _e320 = local_13;
    output.Store(_e320*4, asuint(((((4294967295u & 255u) << 24u) | ((4294967295u & 65280u) << 8u)) | (((4294967295u >> 8u) & 65280u) | (4294967295u >> 24u)))));
    uint _e322 = value_1;
    uint _e336 = ((((_e322 & 255u) << 24u) | ((_e322 & 65280u) << 8u)) | (((_e322 >> 8u) & 65280u) | (_e322 >> 24u)));
    local_14 = uint((base + 9u));
    uint _e355 = local_14;
    output.Store(_e355*4, asuint(((((_e336 & 255u) << 24u) | ((_e336 & 65280u) << 8u)) | (((_e336 >> 8u) & 65280u) | (_e336 >> 24u)))));
}
