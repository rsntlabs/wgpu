struct type_3 {
    uint value;
    int _end_pad_0;
    int _end_pad_1;
    int _end_pad_2;
};

RWByteAddressBuffer out_ : register(u0);
ByteAddressBuffer input : register(t1);
cbuffer n_1 : register(b2) { type_3 n_1; }

void consume(int value_1)
{
    int value_2 = (int)0;

    value_2 = value_1;
    int _e3 = value_2;
    if ((_e3 < int(0))) {
        return;
    } else {
        return;
    }
}

int pair_add(int left_1, int right_1)
{
    int left_2 = (int)0;
    int right_2 = (int)0;

    left_2 = left_1;
    right_2 = right_1;
    int _e4 = left_2;
    int _e5 = right_2;
    return asint(asuint(_e4) + asuint(_e5));
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % (rhs == 0u ? 1u : rhs);
}

[numthreads(64, 1, 1)]
void comma(uint3 blockIdx : SV_GroupID, uint3 threadIdx : SV_GroupThreadID)
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
    bool choose = (bool)0;
    int x = (int)0;
    int sequenced = (int)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    int target = (int)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    int rhs = (int)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    int middle = (int)0;
    int selected = (int)0;
    int local_17 = (int)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    int left = (int)0;
    int right = (int)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    int identity = (int)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint position = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    int effect = (int)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    int total = (int)0;
    int iteration = (int)0;
    int current = (int)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    int ticks = (int)0;
    int passes = (int)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    int argument = (int)0;
    int first = (int)0;
    int second = (int)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    int local_43 = (int)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;

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
        local_42 = uint((_e32 + _e33));
        uint _e38 = local_42;
        int _e40 = asint(input.Load(_e38*4));
        local_43 = _e40;
        int _e41 = local_43;
        value = _e41;
        uint _e43 = i;
        choose = (naga_mod(_e43, 2u) == 0u);
        int _e49 = value;
        x = _e49;
        int _e51 = x;
        x = asint(asuint(_e51) + asuint(int(2)));
        int _e54 = x;
        x = asint(asuint(_e54) * asuint(int(3)));
        int _e57 = x;
        sequenced = asint(asuint(_e57) - asuint(int(1)));
        int _e61 = sequenced;
        uint _e62 = local;
        local_5 = _e62;
        uint _e64 = local_5;
        local_6 = uint(_e64);
        uint _e67 = base;
        local_7 = uint(_e67);
        uint _e71 = local_6;
        uint _e72 = local_7;
        local_44 = uint((_e71 + _e72));
        uint _e76 = local_44;
        out_.Store(_e76*4, asuint(_e61));
        int _e78 = x;
        uint _e79 = local;
        local_8 = _e79;
        uint _e81 = local_8;
        local_9 = uint(_e81);
        uint _e84 = base;
        local_10 = uint((_e84 + 1u));
        uint _e89 = local_9;
        uint _e90 = local_10;
        local_45 = uint((_e89 + _e90));
        uint _e94 = local_45;
        out_.Store(_e94*4, asuint(_e78));
        target = int(0);
        int _e98 = value;
        target = _e98;
        int _e99 = target;
        target = asint(asuint(_e99) + asuint(int(4)));
        int _e102 = target;
        uint _e103 = local;
        local_11 = _e103;
        uint _e105 = local_11;
        local_12 = uint(_e105);
        uint _e108 = base;
        local_13 = uint((_e108 + 2u));
        uint _e113 = local_12;
        uint _e114 = local_13;
        local_46 = uint((_e113 + _e114));
        uint _e118 = local_46;
        out_.Store(_e118*4, asuint(_e102));
        int _e120 = value;
        target = asint(asuint(_e120) + asuint(int(1)));
        int _e123 = target;
        rhs = asint(asuint(_e123) + asuint(int(3)));
        int _e127 = rhs;
        int _e130 = target;
        uint _e132 = local;
        local_14 = _e132;
        uint _e134 = local_14;
        local_15 = uint(_e134);
        uint _e137 = base;
        local_16 = uint((_e137 + 3u));
        uint _e142 = local_15;
        uint _e143 = local_16;
        local_47 = uint((_e142 + _e143));
        uint _e147 = local_47;
        out_.Store(_e147*4, asuint(asint(asuint(asint(asuint(_e127) * asuint(int(10)))) + asuint(_e130))));
        middle = int(0);
        bool _e151 = choose;
        if (_e151) {
            int _e152 = value;
            middle = asint(asuint(_e152) + asuint(int(2)));
            int _e155 = middle;
            local_17 = asint(asuint(_e155) + asuint(int(3)));
        } else {
            int _e159 = value;
            local_17 = asint(asuint(_e159) - asuint(int(2)));
        }
        int _e164 = local_17;
        selected = _e164;
        int _e166 = selected;
        int _e169 = middle;
        uint _e171 = local;
        local_18 = _e171;
        uint _e173 = local_18;
        local_19 = uint(_e173);
        uint _e176 = base;
        local_20 = uint((_e176 + 4u));
        uint _e181 = local_19;
        uint _e182 = local_20;
        local_48 = uint((_e181 + _e182));
        uint _e186 = local_48;
        out_.Store(_e186*4, asuint(asint(asuint(asint(asuint(_e166) * asuint(int(10)))) + asuint(_e169))));
        int _e188 = value;
        left = _e188;
        int _e190 = value;
        right = asint(asuint(_e190) + asuint(int(10)));
        int _e194 = value;
        consume(_e194);
        bool _e195 = choose;
        if (_e195) {
            int _e196 = left;
            left = asint(asuint(_e196) + asuint(int(3)));
        } else {
            int _e199 = right;
            right = asint(asuint(_e199) + asuint(int(3)));
        }
        int _e202 = left;
        int _e205 = right;
        uint _e207 = local;
        local_21 = _e207;
        uint _e209 = local_21;
        local_22 = uint(_e209);
        uint _e212 = base;
        local_23 = uint((_e212 + 5u));
        uint _e217 = local_22;
        uint _e218 = local_23;
        local_49 = uint((_e217 + _e218));
        uint _e222 = local_49;
        out_.Store(_e222*4, asuint(asint(asuint(asint(asuint(_e202) * asuint(int(100)))) + asuint(_e205))));
        int _e224 = value;
        identity = _e224;
        int _e226 = identity;
        identity = asint(asuint(_e226) + asuint(int(1)));
        consume(_e226);
        int _e229 = identity;
        identity = asint(asuint(_e229) + asuint(int(1)));
        int _e232 = identity;
        uint _e233 = local;
        local_24 = _e233;
        uint _e235 = local_24;
        local_25 = uint(_e235);
        uint _e238 = base;
        local_26 = uint((_e238 + 6u));
        uint _e243 = local_25;
        uint _e244 = local_26;
        local_50 = uint((_e243 + _e244));
        uint _e248 = local_50;
        out_.Store(_e248*4, asuint(_e232));
        uint _e250 = base;
        position = (_e250 + 4u);
        uint _e254 = position;
        position = (_e254 + 2u);
        int _e257 = value;
        uint _e262 = position;
        position = (_e262 + uint(int(1)));
        uint _e266 = local;
        local_27 = _e266;
        uint _e268 = local_27;
        local_28 = uint(_e268);
        uint _e271 = position;
        local_29 = uint(_e271);
        uint _e274 = local_28;
        uint _e275 = local_29;
        local_51 = uint((_e274 + _e275));
        uint _e279 = local_51;
        out_.Store(_e279*4, asuint(asint(asuint(asint(asuint(_e257) * asuint(int(2)))) + asuint(int(2)))));
        int _e281 = value;
        effect = _e281;
        int _e283 = effect;
        effect = asint(asuint(_e283) + asuint(int(1)));
        consume(_e283);
        int _e286 = effect;
        effect = asint(asuint(_e286) + asuint(int(1)));
        consume(_e286);
        int _e289 = effect;
        effect = asint(asuint(_e289) + asuint(int(1)));
        consume(_e289);
        int _e292 = effect;
        effect = asint(asuint(_e292) + asuint(int(1)));
        consume(_e292);
        int _e295 = effect;
        uint _e296 = local;
        local_30 = _e296;
        uint _e298 = local_30;
        local_31 = uint(_e298);
        uint _e301 = base;
        local_32 = uint((_e301 + 8u));
        uint _e306 = local_31;
        uint _e307 = local_32;
        local_52 = uint((_e306 + _e307));
        uint _e311 = local_52;
        out_.Store(_e311*4, asuint(_e295));
        total = int(0);
        {
            iteration = int(0);
            int _e317 = value;
            current = _e317;
            uint2 loop_bound = uint2(4294967295u, 4294967295u);
            bool loop_init = true;
            while(true) {
                if (all(loop_bound == uint2(0u, 0u))) { break; }
                loop_bound -= uint2(loop_bound.y == 0u, 1u);
                if (!loop_init) {
                    int _e328 = iteration;
                    iteration = asint(asuint(_e328) + asuint(int(1)));
                    int _e331 = current;
                    current = asint(asuint(_e331) + asuint(int(2)));
                }
                loop_init = false;
                int _e319 = iteration;
                if ((_e319 < int(4))) {
                } else {
                    break;
                }
                int _e322 = iteration;
                if ((_e322 != int(1))) {
                    int _e325 = current;
                    int _e326 = total;
                    total = asint(asuint(_e326) + asuint(_e325));
                } else {
                    continue;
                }
            }
        }
        int _e334 = total;
        uint _e335 = local;
        local_33 = _e335;
        uint _e337 = local_33;
        local_34 = uint(_e337);
        uint _e340 = base;
        local_35 = uint((_e340 + 9u));
        uint _e345 = local_34;
        uint _e346 = local_35;
        local_53 = uint((_e345 + _e346));
        uint _e350 = local_53;
        out_.Store(_e350*4, asuint(_e334));
        int _e352 = value;
        ticks = _e352;
        passes = int(0);
        {
            int _e356 = value;
            ticks = asint(asuint(_e356) + asuint(int(1)));
            passes = int(0);
            uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
            bool loop_init_1 = true;
            while(true) {
                if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
                loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
                if (!loop_init_1) {
                    int _e366 = ticks;
                    ticks = asint(asuint(_e366) + asuint(int(2)));
                }
                loop_init_1 = false;
                int _e360 = passes;
                passes = asint(asuint(_e360) + asuint(int(1)));
                int _e363 = passes;
                if ((_e363 < int(4))) {
                } else {
                    break;
                }
            }
        }
        int _e369 = ticks;
        int _e372 = passes;
        uint _e374 = local;
        local_36 = _e374;
        uint _e376 = local_36;
        local_37 = uint(_e376);
        uint _e379 = base;
        local_38 = uint((_e379 + 10u));
        uint _e384 = local_37;
        uint _e385 = local_38;
        local_54 = uint((_e384 + _e385));
        uint _e389 = local_54;
        out_.Store(_e389*4, asuint(asint(asuint(asint(asuint(_e369) * asuint(int(10)))) + asuint(_e372))));
        int _e391 = value;
        argument = _e391;
        int _e393 = argument;
        argument = asint(asuint(_e393) + asuint(int(1)));
        int _e396 = argument;
        const int _e398 = pair_add(_e396, int(2));
        first = _e398;
        int _e400 = first;
        const int _e402 = pair_add(_e400, int(3));
        second = _e402;
        int _e404 = second;
        int _e407 = argument;
        uint _e409 = local;
        local_39 = _e409;
        uint _e411 = local_39;
        local_40 = uint(_e411);
        uint _e414 = base;
        local_41 = uint((_e414 + 11u));
        uint _e419 = local_40;
        uint _e420 = local_41;
        local_55 = uint((_e419 + _e420));
        uint _e424 = local_55;
        out_.Store(_e424*4, asuint(asint(asuint(asint(asuint(_e404) * asuint(int(10)))) + asuint(_e407))));
    }
}
