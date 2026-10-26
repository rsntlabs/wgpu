struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer n_1 : register(b2) { type_3 n_1; }

int cached_type(int value_1)
{
    int value_2 = (int)0;
    int Number = (int)0;
    int next = (int)0;
    int result = (int)0;

    value_2 = value_1;
    int _e3 = value_2;
    Number = _e3;
    int _e6 = Number;
    next = asint(asuint(_e6) + asuint(int(1)));
    int _e10 = next;
    result = asint(asuint(_e10) * asuint(int(2)));
    int _e12 = result;
    return _e12;
}

int pair_add(int left, int right)
{
    int left_1 = (int)0;
    int right_1 = (int)0;

    left_1 = left;
    right_1 = right;
    int _e4 = left_1;
    int _e5 = right_1;
    return asint(asuint(_e4) + asuint(_e5));
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
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint n = (uint)0;
    uint i = (uint)0;
    uint base = (uint)0;
    int value = (int)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    int first = (int)0;
    int second = (int)0;
    int third = (int)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    int omitted = (int)0;
    int initialized = (int)0;
    int final = (int)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    int fixed = (int)0;
    int fixed_next = (int)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    int alias_first = (int)0;
    int alias_next = (int)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    bool positive = (bool)0;
    bool same = (bool)0;
    bool local_20 = (bool)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    float low = (float)0;
    float high = (float)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint start = (uint)0;
    uint finish = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    int outside = (int)0;
    int outside_1 = (int)0;
    int derived = (int)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    int total = (int)0;
    int iteration = (int)0;
    int seed = (int)0;
    int term = (int)0;
    int copied = (int)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    int from_call = (int)0;
    int from_prior = (int)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    int local_46 = (int)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    int local_53 = (int)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;

    local = 0u;
    local_1 = 0u;
    uint _e8 = n_1.value;
    n = _e8;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    uint _e16 = i;
    uint _e17 = n;
    if ((_e16 < _e17)) {
        uint _e19 = i;
        base = (_e19 * 12u);
        uint _e23 = local_1;
        local_2 = _e23;
        uint _e25 = local_2;
        local_3 = uint(_e25);
        uint _e28 = i;
        local_4 = uint(_e28);
        uint _e32 = local_3;
        uint _e33 = local_4;
        local_45 = uint((_e32 + _e33));
        uint _e38 = local_45;
        int _e40 = asint(input.Load(_e38*4));
        local_46 = _e40;
        int _e41 = local_46;
        value = _e41;
        int _e43 = value;
        value = asint(asuint(_e43) + asuint(int(1)));
        first = _e43;
        int _e47 = value;
        value = asint(asuint(_e47) + asuint(int(1)));
        second = _e47;
        int _e51 = value;
        third = _e51;
        int _e53 = first;
        int _e56 = second;
        int _e60 = third;
        uint _e62 = local;
        local_5 = _e62;
        uint _e64 = local_5;
        local_6 = uint(_e64);
        uint _e67 = base;
        local_7 = uint(_e67);
        uint _e71 = local_6;
        uint _e72 = local_7;
        local_47 = uint((_e71 + _e72));
        uint _e76 = local_47;
        out_.Store(_e76*4, asuint(asint(asuint(asint(asuint(asint(asuint(_e53) * asuint(int(100)))) + asuint(asint(asuint(_e56) * asuint(int(10)))))) + asuint(_e60))));
        int _e78 = value;
        uint _e79 = local;
        local_8 = _e79;
        uint _e81 = local_8;
        local_9 = uint(_e81);
        uint _e84 = base;
        local_10 = uint((_e84 + 1u));
        uint _e89 = local_9;
        uint _e90 = local_10;
        local_48 = uint((_e89 + _e90));
        uint _e94 = local_48;
        out_.Store(_e94*4, asuint(_e78));
        int _e96 = value;
        initialized = asint(asuint(_e96) + asuint(int(3)));
        int _e100 = initialized;
        omitted = asint(asuint(_e100) + asuint(int(2)));
        int _e104 = omitted;
        int _e105 = initialized;
        final = asint(asuint(_e104) + asuint(_e105));
        int _e108 = final;
        uint _e109 = local;
        local_11 = _e109;
        uint _e111 = local_11;
        local_12 = uint(_e111);
        uint _e114 = base;
        local_13 = uint((_e114 + 2u));
        uint _e119 = local_12;
        uint _e120 = local_13;
        local_49 = uint((_e119 + _e120));
        uint _e124 = local_49;
        out_.Store(_e124*4, asuint(_e108));
        int _e126 = value;
        fixed = asint(asuint(_e126) + asuint(int(1)));
        int _e130 = fixed;
        fixed_next = asint(asuint(_e130) + asuint(int(2)));
        int _e134 = fixed_next;
        uint _e135 = local;
        local_14 = _e135;
        uint _e137 = local_14;
        local_15 = uint(_e137);
        uint _e140 = base;
        local_16 = uint((_e140 + 3u));
        uint _e145 = local_15;
        uint _e146 = local_16;
        local_50 = uint((_e145 + _e146));
        uint _e150 = local_50;
        out_.Store(_e150*4, asuint(_e134));
        int _e152 = value;
        alias_first = asint(asuint(_e152) + asuint(int(4)));
        int _e156 = alias_first;
        alias_next = asint(asuint(_e156) + asuint(int(1)));
        int _e160 = alias_next;
        uint _e161 = local;
        local_17 = _e161;
        uint _e163 = local_17;
        local_18 = uint(_e163);
        uint _e166 = base;
        local_19 = uint((_e166 + 4u));
        uint _e171 = local_18;
        uint _e172 = local_19;
        local_51 = uint((_e171 + _e172));
        uint _e176 = local_51;
        out_.Store(_e176*4, asuint(_e160));
        int _e178 = value;
        positive = (_e178 > int(0));
        bool _e182 = positive;
        local_20 = _e182;
        if (_e182) {
            uint _e184 = local_1;
            local_21 = _e184;
            uint _e186 = local_21;
            local_22 = uint(_e186);
            uint _e189 = i;
            local_23 = uint(_e189);
            uint _e192 = local_22;
            uint _e193 = local_23;
            local_52 = uint((_e192 + _e193));
            uint _e198 = local_52;
            int _e200 = asint(input.Load(_e198*4));
            local_53 = _e200;
            int _e201 = local_53;
            int _e204 = value;
            local_20 = (_e204 == asint(asuint(_e201) + asuint(int(2))));
        }
        bool _e206 = local_20;
        same = _e206;
        bool _e208 = same;
        uint _e209 = local;
        local_24 = _e209;
        uint _e211 = local_24;
        local_25 = uint(_e211);
        uint _e214 = base;
        local_26 = uint((_e214 + 5u));
        uint _e220 = local_25;
        uint _e221 = local_26;
        local_54 = uint((_e220 + _e221));
        uint _e225 = local_54;
        out_.Store(_e225*4, asuint(int(_e208)));
        int _e227 = value;
        low = (float(_e227) * 0.5);
        float _e232 = low;
        high = (_e232 + 1.5);
        float _e236 = high;
        uint _e240 = local;
        local_27 = _e240;
        uint _e242 = local_27;
        local_28 = uint(_e242);
        uint _e245 = base;
        local_29 = uint((_e245 + 6u));
        uint _e250 = local_28;
        uint _e251 = local_29;
        local_55 = uint((_e250 + _e251));
        uint _e255 = local_55;
        out_.Store(_e255*4, asuint(naga_f2i32((_e236 * 2.0))));
        uint _e257 = i;
        start = naga_mod(_e257, 5u);
        uint _e261 = start;
        finish = (_e261 + 3u);
        uint _e265 = finish;
        uint _e266 = local;
        local_30 = _e266;
        uint _e268 = local_30;
        local_31 = uint(_e268);
        uint _e271 = base;
        local_32 = uint((_e271 + 7u));
        uint _e277 = local_31;
        uint _e278 = local_32;
        local_56 = uint((_e277 + _e278));
        uint _e282 = local_56;
        out_.Store(_e282*4, asuint(int(_e265)));
        int _e284 = value;
        const int _e285 = cached_type(_e284);
        uint _e286 = local;
        local_33 = _e286;
        uint _e288 = local_33;
        local_34 = uint(_e288);
        uint _e291 = base;
        local_35 = uint((_e291 + 8u));
        uint _e296 = local_34;
        uint _e297 = local_35;
        local_57 = uint((_e296 + _e297));
        uint _e301 = local_57;
        out_.Store(_e301*4, asuint(_e285));
        int _e303 = value;
        outside = _e303;
        {
            int _e305 = value;
            outside_1 = asint(asuint(_e305) + asuint(int(5)));
            int _e309 = outside_1;
            derived = asint(asuint(_e309) + asuint(int(2)));
            int _e313 = derived;
            uint _e314 = local;
            local_36 = _e314;
            uint _e316 = local_36;
            local_37 = uint(_e316);
            uint _e319 = base;
            local_38 = uint((_e319 + 9u));
            uint _e324 = local_37;
            uint _e325 = local_38;
            local_58 = uint((_e324 + _e325));
            uint _e329 = local_58;
            out_.Store(_e329*4, asuint(_e313));
        }
        total = int(0);
        {
            iteration = int(0);
            int _e335 = value;
            seed = _e335;
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e352 = iteration;
                    iteration = asint(asuint(_e352) + asuint(int(1)));
                }
                loop_init = false;
                int _e337 = iteration;
                if ((_e337 < int(4))) {
                } else {
                    break;
                }
                int _e340 = iteration;
                if ((_e340 == int(1))) {
                    continue;
                }
                int _e343 = seed;
                int _e344 = iteration;
                term = asint(asuint(_e343) + asuint(_e344));
                int _e347 = term;
                copied = _e347;
                int _e349 = copied;
                int _e350 = total;
                total = asint(asuint(_e350) + asuint(_e349));
            }
        }
        int _e355 = total;
        uint _e356 = local;
        local_39 = _e356;
        uint _e358 = local_39;
        local_40 = uint(_e358);
        uint _e361 = base;
        local_41 = uint((_e361 + 10u));
        uint _e366 = local_40;
        uint _e367 = local_41;
        local_59 = uint((_e366 + _e367));
        uint _e371 = local_59;
        out_.Store(_e371*4, asuint(_e355));
        int _e373 = value;
        const int _e375 = pair_add(_e373, int(2));
        from_call = _e375;
        int _e377 = from_call;
        const int _e379 = pair_add(_e377, int(3));
        from_prior = _e379;
        int _e381 = from_prior;
        int _e382 = outside;
        uint _e384 = local;
        local_42 = _e384;
        uint _e386 = local_42;
        local_43 = uint(_e386);
        uint _e389 = base;
        local_44 = uint((_e389 + 11u));
        uint _e394 = local_43;
        uint _e395 = local_44;
        local_60 = uint((_e394 + _e395));
        uint _e399 = local_60;
        out_.Store(_e399*4, asuint(asint(asuint(_e381) + asuint(_e382))));
    }
}
