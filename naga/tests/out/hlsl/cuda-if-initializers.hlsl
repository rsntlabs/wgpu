ByteAddressBuffer input : register(t0);
RWByteAddressBuffer output : register(u1);

[numthreads(4, 1, 1)]
void if_initializers(uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    int state = (int)0;
    uint local_1 = (uint)0;
    int index = (int)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    int header = (int)0;
    uint local_8 = (uint)0;
    int header_1 = (int)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    int header_2 = (int)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    int pass_ = (int)0;
    int selected = (int)0;
    int selected_1 = (int)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    int read = (int)0;
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
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;

    uint lane = threadIdx.x;
    uint base = (4u + (lane * 16u));
    int seed = asint(input.Load(lane*4));
    local = uint((lane + 4u));
    uint _e13 = local;
    int other = asint(input.Load(_e13*4));
    state = asint(asuint(int(lane)) + asuint(int(1)));
    if ((seed > int(0))) {
        int _e22 = state;
        state = asint(asuint(_e22) + asuint(int(10)));
    } else {
        int _e25 = state;
        state = asint(asuint(_e25) + asuint(int(20)));
    }
    int _e28 = state;
    output.Store(base*4, asuint(uint(_e28)));
    int _e32 = state;
    state = asint(asuint(_e32) + asuint(int(1)));
    if (false) {
        int _e36 = state;
        state = asint(asuint(_e36) + asuint(int(99)));
    } else {
        int _e39 = state;
        local_1 = uint((base + 1u));
        uint _e45 = local_1;
        local_21 = _e45;
        uint _e47 = local_21;
        output.Store(_e47*4, asuint(uint(_e39)));
    }
    index = int(0);
    int _e51 = index;
    index = asint(asuint(_e51) + asuint(int(1)));
    int _e54 = state;
    state = asint(asuint(_e54) + asuint(int(2)));
    if ((seed < other)) {
        int _e58 = state;
        state = asint(asuint(_e58) + asuint(int(3)));
    } else {
        int _e61 = state;
        state = asint(asuint(_e61) + asuint(int(5)));
    }
    int _e64 = index;
    local_2 = uint((base + 2u));
    uint _e70 = local_2;
    output.Store(_e70*4, asuint(uint(_e64)));
    int _e72 = state;
    local_3 = uint((base + 3u));
    uint _e78 = local_3;
    output.Store(_e78*4, asuint(uint(_e72)));
    if ((seed < other)) {
        local_4 = uint((base + 4u));
        uint _e88 = local_4;
        local_22 = _e88;
        uint _e90 = local_22;
        output.Store(_e90*4, asuint(uint(asint(asuint(seed) + asuint(int(100))))));
    } else {
        local_5 = uint((base + 4u));
        uint _e99 = local_5;
        local_23 = _e99;
        uint _e101 = local_23;
        output.Store(_e101*4, asuint(uint(asint(asuint(other) + asuint(int(200))))));
    }
    if (true) {
        local_6 = uint((base + 5u));
        uint _e111 = local_6;
        local_24 = _e111;
        uint _e113 = local_24;
        output.Store(_e113*4, asuint(uint(asint(asuint(seed) + asuint(int(300))))));
    }
    int _e115 = state;
    if ((_e115 > int(0))) {
        int _e118 = state;
        state = asint(asuint(_e118) + asuint(int(7)));
    }
    int _e121 = state;
    local_7 = uint((base + 6u));
    uint _e127 = local_7;
    output.Store(_e127*4, asuint(uint(_e121)));
    header = int(50);
    if ((seed > int(0))) {
        local_8 = uint((base + 7u));
        uint _e140 = local_8;
        local_25 = _e140;
        uint _e142 = local_25;
        output.Store(_e142*4, asuint(uint(asint(asuint(seed) + asuint(int(400))))));
    } else {
        header_1 = other;
        int _e145 = header_1;
        if ((_e145 > int(0))) {
            int _e148 = header_1;
            local_9 = uint((base + 7u));
            uint _e156 = local_9;
            local_26 = _e156;
            uint _e158 = local_26;
            output.Store(_e158*4, asuint(uint(asint(asuint(_e148) + asuint(int(500))))));
        } else {
            int _e160 = header_1;
            local_10 = uint((base + 7u));
            uint _e168 = local_10;
            local_27 = _e168;
            uint _e170 = local_27;
            output.Store(_e170*4, asuint(uint(asint(asuint(_e160) + asuint(int(600))))));
        }
    }
    int _e172 = header;
    local_11 = uint((base + 8u));
    uint _e178 = local_11;
    output.Store(_e178*4, asuint(uint(_e172)));
    if (true) {
        {
            header_2 = int(9);
            int _e183 = header_2;
            int _e184 = state;
            state = asint(asuint(_e184) + asuint(_e183));
        }
        local_12 = uint((base + 9u));
        uint _e193 = local_12;
        local_28 = _e193;
        uint _e195 = local_28;
        output.Store(_e195*4, asuint(uint(asint(asuint(seed) + asuint(int(20))))));
    }
    int _e197 = state;
    local_13 = uint((base + 10u));
    uint _e203 = local_13;
    output.Store(_e203*4, asuint(uint(_e197)));
    {
        pass_ = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e225 = pass_;
                pass_ = asint(asuint(_e225) + asuint(int(1)));
            }
            loop_init = false;
            int _e207 = pass_;
            if ((_e207 < int(4))) {
            } else {
                break;
            }
            int _e210 = pass_;
            selected = _e210;
            int _e212 = selected;
            if ((_e212 == int(1))) {
                continue;
            }
            int _e215 = pass_;
            selected_1 = _e215;
            int _e217 = selected_1;
            if ((_e217 == int(3))) {
                break;
            }
            int _e220 = pass_;
            int _e223 = state;
            state = asint(asuint(_e223) + asuint(asint(asuint(_e220) + asuint(int(1)))));
        }
    }
    int _e228 = state;
    local_14 = uint((base + 11u));
    uint _e234 = local_14;
    output.Store(_e234*4, asuint(uint(_e228)));
    int _e236 = state;
    state = asint(asuint(_e236) + asuint(int(1)));
    if (true) {
        int _e240 = state;
        local_15 = uint((base + 12u));
        uint _e246 = local_15;
        local_29 = _e246;
        uint _e248 = local_29;
        output.Store(_e248*4, asuint(uint(_e240)));
    }
    read = int(0);
    int _e252 = read;
    read = asint(asuint(_e252) + asuint(int(1)));
    local_16 = uint((lane + uint(_e252)));
    uint _e259 = local_16;
    int saved = asint(input.Load(_e259*4));
    if ((saved > int(0))) {
        int _e264 = read;
        local_17 = uint((base + 13u));
        uint _e272 = local_17;
        local_30 = _e272;
        uint _e274 = local_30;
        output.Store(_e274*4, asuint(uint(asint(asuint(_e264) + asuint(int(100))))));
    } else {
        int _e276 = read;
        local_18 = uint((base + 13u));
        uint _e284 = local_18;
        local_31 = _e284;
        uint _e286 = local_31;
        output.Store(_e286*4, asuint(uint(asint(asuint(_e276) + asuint(int(200))))));
    }
    int _e288 = state;
    local_19 = uint((base + 14u));
    uint _e294 = local_19;
    output.Store(_e294*4, asuint(uint(_e288)));
    int _e296 = index;
    local_20 = uint((base + 15u));
    uint _e302 = local_20;
    output.Store(_e302*4, asuint(uint(_e296)));
}
