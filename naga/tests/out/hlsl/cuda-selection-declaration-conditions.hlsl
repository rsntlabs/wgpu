ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

uint _naga_fabsf(uint input_bits)
{
    uint _e2 = (input_bits & 2147483647u);
    return ((_e2 > 2139095040u) ? 2143289344u : _e2);
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

[numthreads(4, 1, 1)]
void selection_conditions(uint3 threadIdx : SV_GroupThreadID, uint3 blockIdx : SV_GroupID)
{
    int cursor = (int)0;
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    int header = (int)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    int state = (int)0;
    uint local_10 = (uint)0;
    int fixed = (int)0;
    int pass_ = (int)0;
    int skip = (int)0;
    bool stop = (bool)0;
    uint local_11 = (uint)0;
    int nested = (int)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    float fraction = (float)0;
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

    uint lane = (threadIdx.x + (blockIdx.x * 4u));
    if ((lane >= 4u)) {
        return;
    }
    uint base = (4u + (lane * 12u));
    cursor = int(0);
    int _e15 = cursor;
    cursor = asint(asuint(_e15) + asuint(int(1)));
    local = uint((lane + uint(_e15)));
    uint _e22 = local;
    int selected = asint(input.Load(_e22*4));
    if ((selected != int(0))) {
        local_1 = base;
        uint _e32 = local_1;
        local_18 = _e32;
        uint _e34 = local_18;
        output.Store(_e34*4, asuint(uint(asint(asuint(selected) + asuint(int(100))))));
    } else {
        local_2 = base;
        uint _e41 = local_2;
        local_19 = _e41;
        uint _e43 = local_19;
        output.Store(_e43*4, asuint(uint(asint(asuint(selected) + asuint(int(200))))));
    }
    int _e46 = cursor;
    local_3 = uint((base + 1u));
    uint _e52 = local_3;
    output.Store(_e52*4, asuint(uint(_e46)));
    header = int(50);
    int header_1 = asint(input.Load(lane*4));
    if ((header_1 != int(0))) {
        local_4 = uint((base + 2u));
        uint _e68 = local_4;
        local_20 = _e68;
        uint _e70 = local_20;
        output.Store(_e70*4, asuint(uint(asint(asuint(header_1) + asuint(int(300))))));
    } else {
        local_5 = uint((base + 2u));
        uint _e79 = local_5;
        local_21 = _e79;
        uint _e81 = local_21;
        output.Store(_e81*4, asuint(uint(asint(asuint(header_1) + asuint(int(400))))));
    }
    int _e83 = header;
    local_6 = uint((base + 3u));
    uint _e89 = local_6;
    output.Store(_e89*4, asuint(uint(_e83)));
    local_7 = uint((lane + 4u));
    uint _e95 = local_7;
    int seed = asint(input.Load(_e95*4));
    bool ready = (seed > int(0));
    if (ready) {
        local_8 = uint((base + 4u));
        uint _e107 = local_8;
        local_22 = _e107;
        uint _e109 = local_22;
        output.Store(_e109*4, asuint(uint(asint(asuint(seed) + asuint(int(500))))));
    } else {
        local_9 = uint((base + 4u));
        uint _e118 = local_9;
        local_23 = _e118;
        uint _e120 = local_23;
        output.Store(_e120*4, asuint(uint(asint(asuint(seed) + asuint(int(600))))));
    }
    state = int(0);
    int _e124 = cursor;
    cursor = asint(asuint(_e124) + asuint(int(1)));
    uint mode = naga_mod(lane, 3u);
    switch(mode) {
        case 0u: {
            int _e129 = state;
            state = asint(asuint(_e129) + asuint(int(10)));
            break;
        }
        case 1u: {
            int _e132 = state;
            state = asint(asuint(_e132) + asuint(int(20)));
            int _e135 = state;
            state = asint(asuint(_e135) + asuint(int(30)));
            break;
        }
        default: {
            int _e138 = state;
            state = asint(asuint(_e138) + asuint(int(30)));
            break;
        }
    }
    int _e141 = state;
    local_10 = uint((base + 5u));
    uint _e147 = local_10;
    output.Store(_e147*4, asuint(uint(_e141)));
    fixed = int(2);
    int _e151 = fixed;
    switch(_e151) {
        case 2: {
            int _e152 = state;
            state = asint(asuint(_e152) + asuint(int(7)));
            break;
        }
        default: {
            break;
        }
    }
    {
        pass_ = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e178 = pass_;
                pass_ = asint(asuint(_e178) + asuint(int(1)));
            }
            loop_init = false;
            int _e157 = pass_;
            if ((_e157 < int(4))) {
            } else {
                break;
            }
            int _e160 = pass_;
            skip = int((_e160 == int(1)));
            int _e165 = skip;
            if ((_e165 != int(0))) {
                continue;
            }
            int _e168 = pass_;
            stop = (_e168 == int(3));
            bool _e172 = stop;
            if (_e172) {
                break;
            }
            int _e173 = pass_;
            int _e176 = state;
            state = asint(asuint(_e176) + asuint(asint(asuint(_e173) + asuint(int(1)))));
        }
    }
    int _e181 = state;
    local_11 = uint((base + 6u));
    uint _e187 = local_11;
    output.Store(_e187*4, asuint(uint(_e181)));
    int nested_1 = asint(input.Load(lane*4));
    if ((nested_1 != int(0))) {
        {
            nested = int(9);
            int _e195 = nested;
            int _e196 = state;
            state = asint(asuint(_e196) + asuint(_e195));
        }
        local_12 = uint((base + 7u));
        uint _e205 = local_12;
        local_24 = _e205;
        uint _e207 = local_24;
        output.Store(_e207*4, asuint(uint(asint(asuint(nested_1) + asuint(int(700))))));
    } else {
        local_13 = uint((base + 7u));
        uint _e213 = local_13;
        local_25 = _e213;
        uint _e215 = local_25;
        output.Store(_e215*4, asuint(800u));
    }
    int _e218 = state;
    local_14 = uint((base + 8u));
    uint _e224 = local_14;
    output.Store(_e224*4, asuint(uint(_e218)));
    fraction = 0.5;
    float _e228 = fraction;
    const uint _e230 = _naga_fabsf(asuint(_e228));
    if ((_e230 != 0u)) {
        int _e233 = state;
        state = asint(asuint(_e233) + asuint(int(1)));
    }
    int _e236 = state;
    local_15 = uint((base + 9u));
    uint _e242 = local_15;
    output.Store(_e242*4, asuint(uint(_e236)));
    int _e245 = asint(input.Load(lane*4));
    if ((_e245 != int(0))) {
        int _e248 = state;
        state = asint(asuint(_e248) + asuint(int(1)));
    }
    int _e251 = state;
    local_16 = uint((base + 10u));
    uint _e257 = local_16;
    output.Store(_e257*4, asuint(uint(_e251)));
    int _e259 = cursor;
    local_17 = uint((base + 11u));
    uint _e265 = local_17;
    output.Store(_e265*4, asuint(uint(_e259)));
}
