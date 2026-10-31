struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer n : register(b2) { type_3 n; }

int cached_type(int value_1)
{
    int next = asint(asuint(value_1) + asuint(int(1)));
    int result = asint(asuint(next) * asuint(int(2)));
    return result;
}

int pair_add(int left, int right)
{
    return asint(asuint(left) + asuint(right));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(64, 1, 1)]
void local_declarators(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
{
    uint base = (uint)0;
    int value = (int)0;
    uint local = (uint)0;
    int first = (int)0;
    int second = (int)0;
    int third = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    int omitted = (int)0;
    int initialized = (int)0;
    int final = (int)0;
    uint local_3 = (uint)0;
    int fixed = (int)0;
    int fixed_next = (int)0;
    uint local_4 = (uint)0;
    int alias_first = (int)0;
    int alias_next = (int)0;
    uint local_5 = (uint)0;
    bool positive = (bool)0;
    bool same = (bool)0;
    bool local_6 = (bool)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    float low = (float)0;
    float high = (float)0;
    uint local_9 = (uint)0;
    uint start = (uint)0;
    uint finish = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    int outside = (int)0;
    int outside_1 = (int)0;
    int derived = (int)0;
    uint local_12 = (uint)0;
    int total = (int)0;
    int iteration = (int)0;
    int seed = (int)0;
    int term = (int)0;
    int copied = (int)0;
    uint local_13 = (uint)0;
    int from_call = (int)0;
    int from_prior = (int)0;
    uint local_14 = (uint)0;
    int local_15 = (int)0;
    int local_16 = (int)0;
    uint local_17 = (uint)0;
    int local_18 = (int)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    int local_25 = (int)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;

    uint n_1 = n.value;
    uint i = ((blockIdx.x * 64u) + threadIdx.x);
    if ((i < n_1)) {
        base = (i * 12u);
        local = uint(i);
        uint _e16 = local;
        local_17 = uint(_e16);
        uint _e19 = local_17;
        int _e22 = asint(input.Load(_e19*4));
        local_18 = _e22;
        int _e24 = local_18;
        local_15 = _e24;
        int _e26 = local_15;
        value = _e26;
        int _e28 = value;
        value = asint(asuint(_e28) + asuint(int(1)));
        first = _e28;
        int _e32 = value;
        value = asint(asuint(_e32) + asuint(int(1)));
        second = _e32;
        int _e36 = value;
        third = _e36;
        int _e38 = first;
        int _e41 = second;
        int _e45 = third;
        uint _e47 = base;
        local_1 = uint(_e47);
        uint _e50 = local_1;
        local_19 = uint(_e50);
        uint _e53 = local_19;
        out_.Store(_e53*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e38) * asuint(int(100)))) + asuint(asint(asuint(_e41) * asuint(int(10)))))) + asuint(_e45))));
        int _e56 = value;
        uint _e57 = base;
        local_2 = uint((_e57 + 1u));
        uint _e62 = local_2;
        local_20 = uint(_e62);
        uint _e65 = local_20;
        out_.Store(_e65*4, asuint(_e56));
        int _e67 = value;
        initialized = asint(asuint(_e67) + asuint(int(3)));
        int _e71 = initialized;
        omitted = asint(asuint(_e71) + asuint(int(2)));
        int _e75 = omitted;
        int _e76 = initialized;
        final = asint(asuint(_e75) + asuint(_e76));
        int _e79 = final;
        uint _e80 = base;
        local_3 = uint((_e80 + 2u));
        uint _e85 = local_3;
        local_21 = uint(_e85);
        uint _e88 = local_21;
        out_.Store(_e88*4, asuint(_e79));
        int _e90 = value;
        fixed = asint(asuint(_e90) + asuint(int(1)));
        int _e94 = fixed;
        fixed_next = asint(asuint(_e94) + asuint(int(2)));
        int _e98 = fixed_next;
        uint _e99 = base;
        local_4 = uint((_e99 + 3u));
        uint _e104 = local_4;
        local_22 = uint(_e104);
        uint _e107 = local_22;
        out_.Store(_e107*4, asuint(_e98));
        int _e109 = value;
        alias_first = asint(asuint(_e109) + asuint(int(4)));
        int _e113 = alias_first;
        alias_next = asint(asuint(_e113) + asuint(int(1)));
        int _e117 = alias_next;
        uint _e118 = base;
        local_5 = uint((_e118 + 4u));
        uint _e123 = local_5;
        local_23 = uint(_e123);
        uint _e126 = local_23;
        out_.Store(_e126*4, asuint(_e117));
        int _e128 = value;
        positive = (_e128 > int(0));
        bool _e132 = positive;
        local_6 = _e132;
        if (_e132) {
            local_7 = uint(i);
            uint _e136 = local_7;
            local_24 = uint(_e136);
            uint _e139 = local_24;
            int _e141 = asint(input.Load(_e139*4));
            local_25 = _e141;
            int _e143 = local_25;
            local_16 = _e143;
            int _e145 = local_16;
            int _e148 = value;
            local_6 = (_e148 == asint(asuint(_e145) + asuint(int(2))));
        }
        bool _e150 = local_6;
        same = _e150;
        bool _e152 = same;
        uint _e153 = base;
        local_8 = uint((_e153 + 5u));
        uint _e159 = local_8;
        local_26 = uint(_e159);
        uint _e162 = local_26;
        out_.Store(_e162*4, asuint(int(_e152)));
        int _e164 = value;
        low = (float(_e164) * 0.5);
        float _e169 = low;
        high = (_e169 + 1.5);
        float _e173 = high;
        uint _e177 = base;
        local_9 = uint((_e177 + 6u));
        uint _e182 = local_9;
        local_27 = uint(_e182);
        uint _e185 = local_27;
        out_.Store(_e185*4, asuint(naga_f2i32((_e173 * 2.0))));
        start = naga_mod(i, 5u);
        uint _e190 = start;
        finish = (_e190 + 3u);
        uint _e194 = finish;
        uint _e195 = base;
        local_10 = uint((_e195 + 7u));
        uint _e201 = local_10;
        local_28 = uint(_e201);
        uint _e204 = local_28;
        out_.Store(_e204*4, asuint(int(_e194)));
        int _e206 = value;
        const int _e207 = cached_type(_e206);
        uint _e208 = base;
        local_11 = uint((_e208 + 8u));
        uint _e213 = local_11;
        local_29 = uint(_e213);
        uint _e216 = local_29;
        out_.Store(_e216*4, asuint(_e207));
        int _e218 = value;
        outside = _e218;
        {
            int _e220 = value;
            outside_1 = asint(asuint(_e220) + asuint(int(5)));
            int _e224 = outside_1;
            derived = asint(asuint(_e224) + asuint(int(2)));
            int _e228 = derived;
            uint _e229 = base;
            local_12 = uint((_e229 + 9u));
            uint _e234 = local_12;
            local_30 = uint(_e234);
            uint _e237 = local_30;
            out_.Store(_e237*4, asuint(_e228));
        }
        total = int(0);
        {
            iteration = int(0);
            int _e243 = value;
            seed = _e243;
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e260 = iteration;
                    iteration = asint(asuint(_e260) + asuint(int(1)));
                }
                loop_init = false;
                int _e245 = iteration;
                if ((_e245 < int(4))) {
                } else {
                    break;
                }
                int _e248 = iteration;
                if ((_e248 == int(1))) {
                    continue;
                }
                int _e251 = seed;
                int _e252 = iteration;
                term = asint(asuint(_e251) + asuint(_e252));
                int _e255 = term;
                copied = _e255;
                int _e257 = copied;
                int _e258 = total;
                total = asint(asuint(_e258) + asuint(_e257));
            }
        }
        int _e263 = total;
        uint _e264 = base;
        local_13 = uint((_e264 + 10u));
        uint _e269 = local_13;
        local_31 = uint(_e269);
        uint _e272 = local_31;
        out_.Store(_e272*4, asuint(_e263));
        int _e274 = value;
        const int _e276 = pair_add(_e274, int(2));
        from_call = _e276;
        int _e278 = from_call;
        const int _e280 = pair_add(_e278, int(3));
        from_prior = _e280;
        int _e282 = from_prior;
        int _e283 = outside;
        uint _e285 = base;
        local_14 = uint((_e285 + 11u));
        uint _e290 = local_14;
        local_32 = uint(_e290);
        uint _e293 = local_32;
        out_.Store(_e293*4, asuint(asint(asuint(_e282) + asuint(_e283))));
    }
}
