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
        local = i;
        uint _e15 = local;
        local_17 = _e15;
        uint _e17 = local_17;
        int _e20 = asint(input.Load(_e17*4));
        local_18 = _e20;
        int _e22 = local_18;
        local_15 = _e22;
        int _e24 = local_15;
        value = _e24;
        int _e26 = value;
        value = asint(asuint(_e26) + asuint(int(1)));
        first = _e26;
        int _e30 = value;
        value = asint(asuint(_e30) + asuint(int(1)));
        second = _e30;
        int _e34 = value;
        third = _e34;
        int _e36 = first;
        int _e39 = second;
        int _e43 = third;
        uint _e45 = base;
        local_1 = _e45;
        uint _e47 = local_1;
        local_19 = _e47;
        uint _e49 = local_19;
        out_.Store(_e49*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e36) * asuint(int(100)))) + asuint(asint(asuint(_e39) * asuint(int(10)))))) + asuint(_e43))));
        int _e52 = value;
        uint _e53 = base;
        local_2 = uint((_e53 + 1u));
        uint _e58 = local_2;
        local_20 = _e58;
        uint _e60 = local_20;
        out_.Store(_e60*4, asuint(_e52));
        int _e62 = value;
        initialized = asint(asuint(_e62) + asuint(int(3)));
        int _e66 = initialized;
        omitted = asint(asuint(_e66) + asuint(int(2)));
        int _e70 = omitted;
        int _e71 = initialized;
        final = asint(asuint(_e70) + asuint(_e71));
        int _e74 = final;
        uint _e75 = base;
        local_3 = uint((_e75 + 2u));
        uint _e80 = local_3;
        local_21 = _e80;
        uint _e82 = local_21;
        out_.Store(_e82*4, asuint(_e74));
        int _e84 = value;
        fixed = asint(asuint(_e84) + asuint(int(1)));
        int _e88 = fixed;
        fixed_next = asint(asuint(_e88) + asuint(int(2)));
        int _e92 = fixed_next;
        uint _e93 = base;
        local_4 = uint((_e93 + 3u));
        uint _e98 = local_4;
        local_22 = _e98;
        uint _e100 = local_22;
        out_.Store(_e100*4, asuint(_e92));
        int _e102 = value;
        alias_first = asint(asuint(_e102) + asuint(int(4)));
        int _e106 = alias_first;
        alias_next = asint(asuint(_e106) + asuint(int(1)));
        int _e110 = alias_next;
        uint _e111 = base;
        local_5 = uint((_e111 + 4u));
        uint _e116 = local_5;
        local_23 = _e116;
        uint _e118 = local_23;
        out_.Store(_e118*4, asuint(_e110));
        int _e120 = value;
        positive = (_e120 > int(0));
        bool _e124 = positive;
        local_6 = _e124;
        if (_e124) {
            local_7 = i;
            uint _e127 = local_7;
            local_24 = _e127;
            uint _e129 = local_24;
            int _e131 = asint(input.Load(_e129*4));
            local_25 = _e131;
            int _e133 = local_25;
            local_16 = _e133;
            int _e135 = local_16;
            int _e138 = value;
            local_6 = (_e138 == asint(asuint(_e135) + asuint(int(2))));
        }
        bool _e140 = local_6;
        same = _e140;
        bool _e142 = same;
        uint _e143 = base;
        local_8 = uint((_e143 + 5u));
        uint _e149 = local_8;
        local_26 = _e149;
        uint _e151 = local_26;
        out_.Store(_e151*4, asuint(int(_e142)));
        int _e153 = value;
        low = (float(_e153) * 0.5);
        float _e158 = low;
        high = (_e158 + 1.5);
        float _e162 = high;
        uint _e166 = base;
        local_9 = uint((_e166 + 6u));
        uint _e171 = local_9;
        local_27 = _e171;
        uint _e173 = local_27;
        out_.Store(_e173*4, asuint(naga_f2i32((_e162 * 2.0))));
        start = naga_mod(i, 5u);
        uint _e178 = start;
        finish = (_e178 + 3u);
        uint _e182 = finish;
        uint _e183 = base;
        local_10 = uint((_e183 + 7u));
        uint _e189 = local_10;
        local_28 = _e189;
        uint _e191 = local_28;
        out_.Store(_e191*4, asuint(int(_e182)));
        int _e193 = value;
        const int _e194 = cached_type(_e193);
        uint _e195 = base;
        local_11 = uint((_e195 + 8u));
        uint _e200 = local_11;
        local_29 = _e200;
        uint _e202 = local_29;
        out_.Store(_e202*4, asuint(_e194));
        int _e204 = value;
        outside = _e204;
        {
            int _e206 = value;
            outside_1 = asint(asuint(_e206) + asuint(int(5)));
            int _e210 = outside_1;
            derived = asint(asuint(_e210) + asuint(int(2)));
            int _e214 = derived;
            uint _e215 = base;
            local_12 = uint((_e215 + 9u));
            uint _e220 = local_12;
            local_30 = _e220;
            uint _e222 = local_30;
            out_.Store(_e222*4, asuint(_e214));
        }
        total = int(0);
        {
            iteration = int(0);
            int _e228 = value;
            seed = _e228;
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e245 = iteration;
                    iteration = asint(asuint(_e245) + asuint(int(1)));
                }
                loop_init = false;
                int _e230 = iteration;
                if ((_e230 < int(4))) {
                } else {
                    break;
                }
                int _e233 = iteration;
                if ((_e233 == int(1))) {
                    continue;
                }
                int _e236 = seed;
                int _e237 = iteration;
                term = asint(asuint(_e236) + asuint(_e237));
                int _e240 = term;
                copied = _e240;
                int _e242 = copied;
                int _e243 = total;
                total = asint(asuint(_e243) + asuint(_e242));
            }
        }
        int _e248 = total;
        uint _e249 = base;
        local_13 = uint((_e249 + 10u));
        uint _e254 = local_13;
        local_31 = _e254;
        uint _e256 = local_31;
        out_.Store(_e256*4, asuint(_e248));
        int _e258 = value;
        const int _e260 = pair_add(_e258, int(2));
        from_call = _e260;
        int _e262 = from_call;
        const int _e264 = pair_add(_e262, int(3));
        from_prior = _e264;
        int _e266 = from_prior;
        int _e267 = outside;
        uint _e269 = base;
        local_14 = uint((_e269 + 11u));
        uint _e274 = local_14;
        local_32 = _e274;
        uint _e276 = local_32;
        out_.Store(_e276*4, asuint(asint(asuint(_e266) + asuint(_e267))));
    }
}
