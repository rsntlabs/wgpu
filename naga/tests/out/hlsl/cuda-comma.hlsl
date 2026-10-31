struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer n : register(b2) { type_3 n; }

void consume(int value_1)
{
    if ((value_1 < int(0))) {
        return;
    } else {
        return;
    }
}

int pair_add(int left_1, int right_1)
{
    return asint(asuint(left_1) + asuint(right_1));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

[numthreads(64, 1, 1)]
void comma(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint base = (uint)0;
    int value = (int)0;
    uint local = (uint)0;
    bool choose = (bool)0;
    int x = (int)0;
    int sequenced = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int target = (int)0;
    uint local_3 = (uint)0;
    int rhs = (int)0;
    uint local_4 = (uint)0;
    int middle = (int)0;
    int selected = (int)0;
    int local_5 = (int)0;
    uint local_6 = (uint)0;
    int left = (int)0;
    int right = (int)0;
    uint local_7 = (uint)0;
    int identity = (int)0;
    uint local_8 = (uint)0;
    uint position = (uint)0;
    uint local_9 = (uint)0;
    int effect = (int)0;
    uint local_10 = (uint)0;
    int total = (int)0;
    int iteration = (int)0;
    int current = (int)0;
    uint local_11 = (uint)0;
    int ticks = (int)0;
    int passes = (int)0;
    uint local_12 = (uint)0;
    int argument = (int)0;
    int first = (int)0;
    int second = (int)0;
    uint local_13 = (uint)0;
    int local_14 = (int)0;
    uint local_15 = (uint)0;
    int local_16 = (int)0;
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

    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        local = uint(i);
        uint _e16 = local;
        local_15 = uint(_e16);
        uint _e19 = local_15;
        int _e22 = asint(input.Load(_e19*4));
        local_16 = _e22;
        int _e24 = local_16;
        local_14 = _e24;
        int _e26 = local_14;
        value = _e26;
        choose = (naga_mod(i, 2u) == 0u);
        int _e33 = value;
        x = _e33;
        int _e35 = x;
        x = asint(asuint(_e35) + asuint(int(2)));
        int _e38 = x;
        x = asint(asuint(_e38) * asuint(int(3)));
        int _e41 = x;
        sequenced = asint(asuint(_e41) - asuint(int(1)));
        int _e45 = sequenced;
        uint _e46 = base;
        local_1 = uint(_e46);
        uint _e49 = local_1;
        local_17 = uint(_e49);
        uint _e52 = local_17;
        out_.Store(_e52*4, asuint(_e45));
        int _e55 = x;
        uint _e56 = base;
        local_2 = uint((_e56 + 1u));
        uint _e61 = local_2;
        local_18 = uint(_e61);
        uint _e64 = local_18;
        out_.Store(_e64*4, asuint(_e55));
        target = int(0);
        int _e68 = value;
        target = _e68;
        int _e69 = target;
        target = asint(asuint(_e69) + asuint(int(4)));
        int _e72 = target;
        uint _e73 = base;
        local_3 = uint((_e73 + 2u));
        uint _e78 = local_3;
        local_19 = uint(_e78);
        uint _e81 = local_19;
        out_.Store(_e81*4, asuint(_e72));
        int _e83 = value;
        target = asint(asuint(_e83) + asuint(int(1)));
        int _e86 = target;
        rhs = asint(asuint(_e86) + asuint(int(3)));
        int _e90 = rhs;
        int _e93 = target;
        uint _e95 = base;
        local_4 = uint((_e95 + 3u));
        uint _e100 = local_4;
        local_20 = uint(_e100);
        uint _e103 = local_20;
        out_.Store(_e103*4, asuint(asint(asuint(asint(asuint(_e90) * asuint(int(10)))) + asuint(_e93))));
        middle = int(0);
        bool _e107 = choose;
        if (_e107) {
            int _e108 = value;
            middle = asint(asuint(_e108) + asuint(int(2)));
            int _e111 = middle;
            local_5 = asint(asuint(_e111) + asuint(int(3)));
        } else {
            int _e115 = value;
            local_5 = asint(asuint(_e115) - asuint(int(2)));
        }
        int _e120 = local_5;
        selected = _e120;
        int _e122 = selected;
        int _e125 = middle;
        uint _e127 = base;
        local_6 = uint((_e127 + 4u));
        uint _e132 = local_6;
        local_21 = uint(_e132);
        uint _e135 = local_21;
        out_.Store(_e135*4, asuint(asint(asuint(asint(asuint(_e122) * asuint(int(10)))) + asuint(_e125))));
        int _e137 = value;
        left = _e137;
        int _e139 = value;
        right = asint(asuint(_e139) + asuint(int(10)));
        int _e143 = value;
        consume(_e143);
        bool _e144 = choose;
        if (_e144) {
            int _e145 = left;
            left = asint(asuint(_e145) + asuint(int(3)));
        } else {
            int _e148 = right;
            right = asint(asuint(_e148) + asuint(int(3)));
        }
        int _e151 = left;
        int _e154 = right;
        uint _e156 = base;
        local_7 = uint((_e156 + 5u));
        uint _e161 = local_7;
        local_22 = uint(_e161);
        uint _e164 = local_22;
        out_.Store(_e164*4, asuint(asint(asuint(asint(asuint(_e151) * asuint(int(100)))) + asuint(_e154))));
        int _e166 = value;
        identity = _e166;
        int _e168 = identity;
        identity = asint(asuint(_e168) + asuint(int(1)));
        consume(_e168);
        int _e171 = identity;
        identity = asint(asuint(_e171) + asuint(int(1)));
        int _e174 = identity;
        uint _e175 = base;
        local_8 = uint((_e175 + 6u));
        uint _e180 = local_8;
        local_23 = uint(_e180);
        uint _e183 = local_23;
        out_.Store(_e183*4, asuint(_e174));
        uint _e185 = base;
        position = (_e185 + 4u);
        uint _e189 = position;
        position = (_e189 + 2u);
        int _e192 = value;
        uint _e197 = position;
        position = (_e197 + uint(int(1)));
        uint _e201 = position;
        local_9 = uint(_e201);
        uint _e204 = local_9;
        local_24 = uint(_e204);
        uint _e207 = local_24;
        out_.Store(_e207*4, asuint(asint(asuint(asint(asuint(_e192) * asuint(int(2)))) + asuint(int(2)))));
        int _e209 = value;
        effect = _e209;
        int _e211 = effect;
        effect = asint(asuint(_e211) + asuint(int(1)));
        consume(_e211);
        int _e214 = effect;
        effect = asint(asuint(_e214) + asuint(int(1)));
        consume(_e214);
        int _e217 = effect;
        effect = asint(asuint(_e217) + asuint(int(1)));
        consume(_e217);
        int _e220 = effect;
        effect = asint(asuint(_e220) + asuint(int(1)));
        consume(_e220);
        int _e223 = effect;
        uint _e224 = base;
        local_10 = uint((_e224 + 8u));
        uint _e229 = local_10;
        local_25 = uint(_e229);
        uint _e232 = local_25;
        out_.Store(_e232*4, asuint(_e223));
        total = int(0);
        {
            iteration = int(0);
            int _e238 = value;
            current = _e238;
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e249 = iteration;
                    iteration = asint(asuint(_e249) + asuint(int(1)));
                    int _e252 = current;
                    current = asint(asuint(_e252) + asuint(int(2)));
                }
                loop_init = false;
                int _e240 = iteration;
                if ((_e240 < int(4))) {
                } else {
                    break;
                }
                int _e243 = iteration;
                if ((_e243 != int(1))) {
                    int _e246 = current;
                    int _e247 = total;
                    total = asint(asuint(_e247) + asuint(_e246));
                } else {
                    continue;
                }
            }
        }
        int _e255 = total;
        uint _e256 = base;
        local_11 = uint((_e256 + 9u));
        uint _e261 = local_11;
        local_26 = uint(_e261);
        uint _e264 = local_26;
        out_.Store(_e264*4, asuint(_e255));
        int _e266 = value;
        ticks = _e266;
        passes = int(0);
        {
            int _e270 = value;
            ticks = asint(asuint(_e270) + asuint(int(1)));
            passes = int(0);
            uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e280 = ticks;
                    ticks = asint(asuint(_e280) + asuint(int(2)));
                }
                loop_init_1 = false;
                int _e274 = passes;
                passes = asint(asuint(_e274) + asuint(int(1)));
                int _e277 = passes;
                if ((_e277 < int(4))) {
                } else {
                    break;
                }
            }
        }
        int _e283 = ticks;
        int _e286 = passes;
        uint _e288 = base;
        local_12 = uint((_e288 + 10u));
        uint _e293 = local_12;
        local_27 = uint(_e293);
        uint _e296 = local_27;
        out_.Store(_e296*4, asuint(asint(asuint(asint(asuint(_e283) * asuint(int(10)))) + asuint(_e286))));
        int _e298 = value;
        argument = _e298;
        int _e300 = argument;
        argument = asint(asuint(_e300) + asuint(int(1)));
        int _e303 = argument;
        const int _e305 = pair_add(_e303, int(2));
        first = _e305;
        int _e307 = first;
        const int _e309 = pair_add(_e307, int(3));
        second = _e309;
        int _e311 = second;
        int _e314 = argument;
        uint _e316 = base;
        local_13 = uint((_e316 + 11u));
        uint _e321 = local_13;
        local_28 = uint(_e321);
        uint _e324 = local_28;
        out_.Store(_e324*4, asuint(asint(asuint(asint(asuint(_e311) * asuint(int(10)))) + asuint(_e314))));
    }
}
