RWByteAddressBuffer out_ : register(u0);

typedef int ret_ZeroValuearray3_int_[3];
ret_ZeroValuearray3_int_ ZeroValuearray3_int_() {
    return (int[3])0;
}

int local_sum(int value)
{
    int value_1 = (int)0;
    int values[3] = (int[3])0;

    value_1 = value;
    values = ZeroValuearray3_int_();
    int _e6 = value_1;
    values[int(0)] = _e6;
    int _e10 = value_1;
    values[int(1)] = asint(asuint(_e10) + asuint(int(1)));
    int _e18 = values[int(0)];
    int _e19 = values[int(1)];
    values[int(2)] = asint(asuint(_e18) + asuint(_e19));
    int _e23 = values[int(2)];
    return _e23;
}

typedef int ret_ZeroValuearray2_int_[2];
ret_ZeroValuearray2_int_ ZeroValuearray2_int_() {
    return (int[2])0;
}

int reset_sum(int count)
{
    int count_1 = (int)0;
    int result = (int)0;
    int i_1 = (int)0;
    int values_1[2] = (int[2])0;

    count_1 = count;
    result = int(0);
    {
        i_1 = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e9 = i_1;
                i_1 = asint(asuint(_e9) + asuint(int(1)));
            }
            loop_init = false;
            int _e6 = i_1;
            int _e7 = count_1;
            if ((_e6 < _e7)) {
            } else {
                break;
            }
            values_1 = ZeroValuearray2_int_();
            int _e16 = i_1;
            values_1[int(1)] = _e16;
            int _e21 = values_1[int(0)];
            int _e22 = values_1[int(1)];
            int _e24 = result;
            result = asint(asuint(_e24) + asuint(asint(asuint(_e21) + asuint(_e22))));
            values_1[int(0)] = int(99);
        }
    }
    int _e29 = result;
    return _e29;
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

int naga_mod(int lhs, int rhs) {
    int divisor = ((lhs == int(-2147483647 - 1) & rhs == -1) | (rhs == 0)) ? 1 : rhs;
    return lhs - (lhs / divisor) * divisor;
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

typedef float ret_ZeroValuearray2_float_[2];
ret_ZeroValuearray2_float_ ZeroValuearray2_float_() {
    return (float[2])0;
}

typedef bool ret_ZeroValuearray3_bool_[3];
ret_ZeroValuearray3_bool_ ZeroValuearray3_bool_() {
    return (bool[3])0;
}

typedef bool ret_ZeroValuearray2_bool_[2];
ret_ZeroValuearray2_bool_ ZeroValuearray2_bool_() {
    return (bool[2])0;
}

int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

[numthreads(1, 1, 1)]
void local_arrays()
{
    uint local = (uint)0;
    int seed = (int)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    int signed_values[3] = (int[3])0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint words[2] = (uint[2])0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    float samples[2] = (float[2])0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    bool flags[3] = (bool[3])0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    int zeros[2] = (int[2])0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    bool zero_flags[2] = (bool[2])0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    bool local_28 = (bool)0;
    uint bank[2] = (uint[2])0;
    float bank_1[2] = (float[2])0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    int signed_values_1[2] = (int[2])0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    int mixed[2] = (int[2])0;
    int next = (int)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
    uint local_44 = (uint)0;
    uint local_45 = (uint)0;
    uint local_46 = (uint)0;
    int reset_total = (int)0;
    int i = (int)0;
    int reset[2] = (int[2])0;
    uint local_47 = (uint)0;
    uint local_48 = (uint)0;
    uint local_49 = (uint)0;
    int total = (int)0;
    int scratch[2] = (int[2])0;
    int j = (int)0;
    uint local_50 = (uint)0;
    uint local_51 = (uint)0;
    uint local_52 = (uint)0;
    float zero_samples[2] = (float[2])0;
    uint local_53 = (uint)0;
    uint local_54 = (uint)0;
    uint local_55 = (uint)0;
    int left[2] = (int[2])0;
    int right[2] = (int[2])0;
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    int temporary[2] = (int[2])0;
    int temporary_1[2] = (int[2])0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    bool choose = (bool)0;
    int index = (int)0;
    int rhs = (int)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    int local_68 = (int)0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    int local_78 = (int)0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    int local_83 = (int)0;
    uint local_84 = (uint)0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;
    uint local_90 = (uint)0;
    uint local_91 = (uint)0;
    uint local_92 = (uint)0;
    uint local_93 = (uint)0;
    uint local_94 = (uint)0;
    uint local_95 = (uint)0;
    uint local_96 = (uint)0;
    uint local_97 = (uint)0;
    uint local_98 = (uint)0;
    uint local_99 = (uint)0;
    uint local_100 = (uint)0;
    uint local_101 = (uint)0;
    uint local_102 = (uint)0;
    uint local_103 = (uint)0;
    uint local_104 = (uint)0;
    uint local_105 = (uint)0;
    uint local_106 = (uint)0;
    uint local_107 = (uint)0;
    uint local_108 = (uint)0;

    local = 0u;
    uint _e2 = local;
    local_1 = _e2;
    uint _e4 = local_1;
    local_2 = uint(_e4);
    local_3 = uint(int(0));
    uint _e11 = local_2;
    uint _e12 = local_3;
    local_82 = uint((_e11 + _e12));
    uint _e17 = local_82;
    int _e19 = asint(out_.Load(_e17*4));
    local_83 = _e19;
    int _e20 = local_83;
    seed = _e20;
    int _e22 = seed;
    signed_values[int(0)] = _e22;
    signed_values[int(1)] = naga_neg(int(2));
    signed_values[int(2)] = int(4);
    int _e37 = signed_values[int(0)];
    int _e38 = signed_values[int(1)];
    int _e42 = signed_values[int(2)];
    uint _e44 = local;
    local_4 = _e44;
    uint _e46 = local_4;
    local_5 = uint(_e46);
    local_6 = uint(int(0));
    uint _e52 = local_5;
    uint _e53 = local_6;
    local_84 = uint((_e52 + _e53));
    uint _e57 = local_84;
    out_.Store(_e57*4, asuint(asint(asuint(asint(asuint(_e37) + asuint(_e38))) + asuint(_e42))));
    words = ZeroValuearray2_uint_();
    words[int(0)] = 4294967295u;
    words[int(1)] = 1u;
    uint _e71 = words[int(0)];
    uint _e72 = words[int(1)];
    uint _e76 = local;
    local_7 = _e76;
    uint _e78 = local_7;
    local_8 = uint(_e78);
    local_9 = uint(int(1));
    uint _e85 = local_8;
    uint _e86 = local_9;
    local_85 = uint((_e85 + _e86));
    uint _e90 = local_85;
    out_.Store(_e90*4, asuint(int(((_e71 + _e72) == 0u))));
    samples = ZeroValuearray2_float_();
    samples[int(0)] = 1.5;
    samples[int(1)] = 2.25;
    float _e104 = samples[int(0)];
    float _e105 = samples[int(1)];
    uint _e110 = local;
    local_10 = _e110;
    uint _e112 = local_10;
    local_11 = uint(_e112);
    local_12 = uint(int(2));
    uint _e118 = local_11;
    uint _e119 = local_12;
    local_86 = uint((_e118 + _e119));
    uint _e123 = local_86;
    out_.Store(_e123*4, asuint(naga_f2i32(((_e104 + _e105) * 4.0))));
    flags = ZeroValuearray3_bool_();
    int _e127 = seed;
    flags[int(0)] = (_e127 != int(0));
    flags[int(2)] = true;
    bool _e137 = flags[int(0)];
    bool _e143 = flags[int(1)];
    bool _e150 = flags[int(2)];
    uint _e153 = local;
    local_13 = _e153;
    uint _e155 = local_13;
    local_14 = uint(_e155);
    local_15 = uint(int(3));
    uint _e161 = local_14;
    uint _e162 = local_15;
    local_87 = uint((_e161 + _e162));
    uint _e166 = local_87;
    out_.Store(_e166*4, asuint(asint(asuint(asint(asuint(asint(asuint(int(_e137)) * asuint(int(100)))) + asuint(asint(asuint(int(_e143)) * asuint(int(10)))))) + asuint(int(_e150)))));
    zeros = ZeroValuearray2_int_();
    int _e174 = zeros[int(0)];
    int _e175 = zeros[int(1)];
    uint _e177 = local;
    local_16 = _e177;
    uint _e179 = local_16;
    local_17 = uint(_e179);
    local_18 = uint(int(4));
    uint _e185 = local_17;
    uint _e186 = local_18;
    local_88 = uint((_e185 + _e186));
    uint _e190 = local_88;
    out_.Store(_e190*4, asuint(asint(asuint(_e174) + asuint(_e175))));
    int _e192 = seed;
    const int _e193 = local_sum(_e192);
    uint _e194 = local;
    local_19 = _e194;
    uint _e196 = local_19;
    local_20 = uint(_e196);
    local_21 = uint(int(5));
    uint _e202 = local_20;
    uint _e203 = local_21;
    local_89 = uint((_e202 + _e203));
    uint _e207 = local_89;
    out_.Store(_e207*4, asuint(_e193));
    const int _e210 = reset_sum(int(3));
    uint _e211 = local;
    local_22 = _e211;
    uint _e213 = local_22;
    local_23 = uint(_e213);
    local_24 = uint(int(6));
    uint _e219 = local_23;
    uint _e220 = local_24;
    local_90 = uint((_e219 + _e220));
    uint _e224 = local_90;
    out_.Store(_e224*4, asuint(_e210));
    zero_flags = ZeroValuearray2_bool_();
    bool _e230 = zero_flags[int(0)];
    local_28 = _e230;
    if (_e230) {
    } else {
        bool _e234 = zero_flags[int(1)];
        local_28 = _e234;
    }
    bool _e235 = local_28;
    uint _e236 = local;
    local_25 = _e236;
    uint _e238 = local_25;
    local_26 = uint(_e238);
    local_27 = uint(int(7));
    uint _e245 = local_26;
    uint _e246 = local_27;
    local_91 = uint((_e245 + _e246));
    uint _e250 = local_91;
    out_.Store(_e250*4, asuint(int(_e235)));
    bank = ZeroValuearray2_uint_();
    bank[int(0)] = 3u;
    bank[int(1)] = 4u;
    {
        bank_1 = ZeroValuearray2_float_();
        bank_1[int(1)] = 6.5;
        float _e269 = bank_1[int(0)];
        float _e270 = bank_1[int(1)];
        uint _e273 = local;
        local_29 = _e273;
        uint _e275 = local_29;
        local_30 = uint(_e275);
        local_31 = uint(int(8));
        uint _e281 = local_30;
        uint _e282 = local_31;
        local_92 = uint((_e281 + _e282));
        uint _e286 = local_92;
        out_.Store(_e286*4, asuint(naga_f2i32((_e269 + _e270))));
    }
    uint _e292 = bank[int(0)];
    uint _e293 = bank[int(1)];
    uint _e296 = local;
    local_32 = _e296;
    uint _e298 = local_32;
    local_33 = uint(_e298);
    local_34 = uint(int(9));
    uint _e304 = local_33;
    uint _e305 = local_34;
    local_93 = uint((_e304 + _e305));
    uint _e309 = local_93;
    out_.Store(_e309*4, asuint(int((_e292 + _e293))));
    {
        int _e311 = seed;
        signed_values_1[int(0)] = _e311;
        int _e315 = seed;
        signed_values_1[int(1)] = _e315;
        int _e322 = signed_values_1[int(0)];
        int _e323 = signed_values_1[int(1)];
        uint _e325 = local;
        local_35 = _e325;
        uint _e327 = local_35;
        local_36 = uint(_e327);
        local_37 = uint(int(10));
        uint _e333 = local_36;
        uint _e334 = local_37;
        local_94 = uint((_e333 + _e334));
        uint _e338 = local_94;
        out_.Store(_e338*4, asuint(asint(asuint(_e322) + asuint(_e323))));
    }
    int _e342 = signed_values[int(0)];
    uint _e343 = local;
    local_38 = _e343;
    uint _e345 = local_38;
    local_39 = uint(_e345);
    local_40 = uint(int(11));
    uint _e351 = local_39;
    uint _e352 = local_40;
    local_95 = uint((_e351 + _e352));
    uint _e356 = local_95;
    out_.Store(_e356*4, asuint(_e342));
    mixed = ZeroValuearray2_int_();
    int _e360 = seed;
    seed = asint(asuint(_e360) + asuint(int(1)));
    int _e363 = seed;
    next = _e363;
    int _e365 = next;
    mixed[int(0)] = _e365;
    int _e368 = seed;
    seed = asint(asuint(_e368) + asuint(int(1)));
    mixed[int(1)] = _e368;
    int _e375 = mixed[int(0)];
    int _e380 = mixed[int(1)];
    uint _e382 = local;
    local_41 = _e382;
    uint _e384 = local_41;
    local_42 = uint(_e384);
    local_43 = uint(int(12));
    uint _e390 = local_42;
    uint _e391 = local_43;
    local_96 = uint((_e390 + _e391));
    uint _e395 = local_96;
    out_.Store(_e395*4, asuint(asint(asuint(asint(asuint(_e375) * asuint(int(10)))) + asuint(_e380))));
    int _e397 = seed;
    uint _e398 = local;
    local_44 = _e398;
    uint _e400 = local_44;
    local_45 = uint(_e400);
    local_46 = uint(int(13));
    uint _e406 = local_45;
    uint _e407 = local_46;
    local_97 = uint((_e406 + _e407));
    uint _e411 = local_97;
    out_.Store(_e411*4, asuint(_e397));
    reset_total = int(0);
    {
        i = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e438 = i;
                i = asint(asuint(_e438) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e417 = i;
            if ((_e417 < int(3))) {
            } else {
                break;
            }
            reset = ZeroValuearray2_int_();
            int _e422 = i;
            if ((_e422 == int(1))) {
                reset[int(0)] = int(90);
                continue;
            }
            int _e430 = reset[int(0)];
            int _e431 = i;
            int _e433 = reset_total;
            reset_total = asint(asuint(_e433) + asuint(asint(asuint(_e430) + asuint(_e431))));
            reset[int(0)] = int(99);
        }
    }
    int _e441 = reset_total;
    uint _e442 = local;
    local_47 = _e442;
    uint _e444 = local_47;
    local_48 = uint(_e444);
    local_49 = uint(int(14));
    uint _e450 = local_48;
    uint _e451 = local_49;
    local_98 = uint((_e450 + _e451));
    uint _e455 = local_98;
    out_.Store(_e455*4, asuint(_e441));
    total = int(0);
    {
        scratch = ZeroValuearray2_int_();
        j = int(0);
        uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
        bool loop_init_2 = true;
        while(true) {
            if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
            loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
            if (!loop_init_2) {
                int _e487 = j;
                j = asint(asuint(_e487) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e463 = j;
            if ((_e463 < int(3))) {
            } else {
                break;
            }
            int _e466 = j;
            int _e470 = scratch[min(uint(naga_mod(_e466, int(2))), 1u)];
            scratch[min(uint(naga_mod(_e466, int(2))), 1u)] = asint(asuint(_e470) + asuint(int(1)));
            int _e473 = j;
            if ((_e473 == int(1))) {
                continue;
            }
            int _e478 = scratch[int(0)];
            int _e483 = scratch[int(1)];
            int _e485 = total;
            total = asint(asuint(_e485) + asuint(asint(asuint(asint(asuint(_e478) * asuint(int(10)))) + asuint(_e483))));
        }
    }
    int _e490 = total;
    uint _e491 = local;
    local_50 = _e491;
    uint _e493 = local_50;
    local_51 = uint(_e493);
    local_52 = uint(int(15));
    uint _e499 = local_51;
    uint _e500 = local_52;
    local_99 = uint((_e499 + _e500));
    uint _e504 = local_99;
    out_.Store(_e504*4, asuint(_e490));
    zero_samples = ZeroValuearray2_float_();
    float _e512 = zero_samples[int(0)];
    float _e513 = zero_samples[int(1)];
    uint _e516 = local;
    local_53 = _e516;
    uint _e518 = local_53;
    local_54 = uint(_e518);
    local_55 = uint(int(16));
    uint _e524 = local_54;
    uint _e525 = local_55;
    local_100 = uint((_e524 + _e525));
    uint _e529 = local_100;
    out_.Store(_e529*4, asuint(naga_f2i32((_e512 + _e513))));
    left = ZeroValuearray2_int_();
    right = ZeroValuearray2_int_();
    left[int(0)] = int(5);
    left[int(1)] = int(7);
    right[int(0)] = int(11);
    right[int(1)] = int(13);
    int _e551 = left[int(0)];
    int _e552 = right[int(0)];
    uint _e554 = local;
    local_56 = _e554;
    uint _e556 = local_56;
    local_57 = uint(_e556);
    local_58 = uint(int(17));
    uint _e562 = local_57;
    uint _e563 = local_58;
    local_101 = uint((_e562 + _e563));
    uint _e567 = local_101;
    out_.Store(_e567*4, asuint(asint(asuint(_e551) + asuint(_e552))));
    {
        temporary = ZeroValuearray2_int_();
        int _e571 = seed;
        temporary[int(0)] = _e571;
        {
            temporary_1 = ZeroValuearray2_int_();
            temporary_1[int(1)] = int(3);
            int _e583 = temporary_1[int(0)];
            int _e584 = temporary_1[int(1)];
            uint _e586 = local;
            local_59 = _e586;
            uint _e588 = local_59;
            local_60 = uint(_e588);
            local_61 = uint(int(18));
            uint _e594 = local_60;
            uint _e595 = local_61;
            local_102 = uint((_e594 + _e595));
            uint _e599 = local_102;
            out_.Store(_e599*4, asuint(asint(asuint(_e583) + asuint(_e584))));
        }
        int _e603 = temporary[int(0)];
        uint _e604 = local;
        local_62 = _e604;
        uint _e606 = local_62;
        local_63 = uint(_e606);
        local_64 = uint(int(19));
        uint _e612 = local_63;
        uint _e613 = local_64;
        local_103 = uint((_e612 + _e613));
        uint _e617 = local_103;
        out_.Store(_e617*4, asuint(_e603));
    }
    int _e619 = seed;
    choose = ((_e619 & int(1)) == int(0));
    index = int(0);
    rhs = int(20);
    int _e629 = rhs;
    rhs = asint(asuint(_e629) + asuint(int(1)));
    int _e632 = rhs;
    bool _e633 = choose;
    if (_e633) {
        int _e634 = index;
        index = asint(asuint(_e634) + asuint(int(1)));
        int _e638 = left[min(uint(_e634), 1u)];
        left[min(uint(_e634), 1u)] = asint(asuint(_e638) + asuint(_e632));
        int _e640 = left[min(uint(_e634), 1u)];
        local_68 = _e640;
    } else {
        int _e642 = index;
        index = asint(asuint(_e642) + asuint(int(1)));
        int _e646 = right[min(uint(_e642), 1u)];
        right[min(uint(_e642), 1u)] = asint(asuint(_e646) + asuint(_e632));
        int _e648 = right[min(uint(_e642), 1u)];
        local_68 = _e648;
    }
    int _e651 = local_68;
    uint _e652 = local;
    local_65 = _e652;
    uint _e654 = local_65;
    local_66 = uint(_e654);
    local_67 = uint(int(20));
    uint _e660 = local_66;
    uint _e661 = local_67;
    local_104 = uint((_e660 + _e661));
    uint _e665 = local_104;
    out_.Store(_e665*4, asuint(_e651));
    int _e667 = index;
    uint _e668 = local;
    local_69 = _e668;
    uint _e670 = local_69;
    local_70 = uint(_e670);
    local_71 = uint(int(21));
    uint _e676 = local_70;
    uint _e677 = local_71;
    local_105 = uint((_e676 + _e677));
    uint _e681 = local_105;
    out_.Store(_e681*4, asuint(_e667));
    int _e685 = left[int(0)];
    int _e690 = right[int(0)];
    uint _e692 = local;
    local_72 = _e692;
    uint _e694 = local_72;
    local_73 = uint(_e694);
    local_74 = uint(int(22));
    uint _e700 = local_73;
    uint _e701 = local_74;
    local_106 = uint((_e700 + _e701));
    uint _e705 = local_106;
    out_.Store(_e705*4, asuint(asint(asuint(asint(asuint(_e685) * asuint(int(100)))) + asuint(_e690))));
    bool _e707 = choose;
    if (_e707) {
        right[int(1)] = int(9);
        int _e711 = right[int(1)];
        right[int(1)] = asint(asuint(_e711) + asuint(int(1)));
        local_78 = _e711;
    } else {
        left[int(1)] = int(9);
        int _e718 = left[int(1)];
        left[int(1)] = asint(asuint(_e718) + asuint(int(1)));
        local_78 = _e718;
    }
    int _e723 = local_78;
    uint _e724 = local;
    local_75 = _e724;
    uint _e726 = local_75;
    local_76 = uint(_e726);
    local_77 = uint(int(23));
    uint _e732 = local_76;
    uint _e733 = local_77;
    local_107 = uint((_e732 + _e733));
    uint _e737 = local_107;
    out_.Store(_e737*4, asuint(_e723));
    int _e741 = left[int(1)];
    int _e746 = right[int(1)];
    uint _e748 = local;
    local_79 = _e748;
    uint _e750 = local_79;
    local_80 = uint(_e750);
    local_81 = uint(int(24));
    uint _e756 = local_80;
    uint _e757 = local_81;
    local_108 = uint((_e756 + _e757));
    uint _e761 = local_108;
    out_.Store(_e761*4, asuint(asint(asuint(asint(asuint(_e741) * asuint(int(100)))) + asuint(_e746))));
}
