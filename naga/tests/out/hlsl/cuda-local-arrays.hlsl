RWByteAddressBuffer out_1 : register(u0);

typedef int ret_ZeroValuearray3_int_[3];
ret_ZeroValuearray3_int_ ZeroValuearray3_int_() {
    return (int[3])0;
}

int local_sum(int value)
{
    int values[3] = (int[3])0;

    values = ZeroValuearray3_int_();
    values[int(0)] = value;
    values[int(1)] = asint(asuint(value) + asuint(int(1)));
    int _e13 = values[int(0)];
    int _e14 = values[int(1)];
    values[int(2)] = asint(asuint(_e13) + asuint(_e14));
    int _e20 = values[int(2)];
    return _e20;
}

typedef int ret_ZeroValuearray2_int_[2];
ret_ZeroValuearray2_int_ ZeroValuearray2_int_() {
    return (int[2])0;
}

int reset_sum(int count)
{
    int result = (int)0;
    int i_1 = (int)0;
    int values_1[2] = (int[2])0;

    result = int(0);
    {
        i_1 = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e24 = i_1;
                i_1 = asint(asuint(_e24) + asuint(int(1)));
            }
            loop_init = false;
            int _e5 = i_1;
            if ((_e5 < count)) {
            } else {
                break;
            }
            values_1 = ZeroValuearray2_int_();
            int _e9 = i_1;
            values_1[int(1)] = _e9;
            int _e16 = values_1[int(0)];
            int _e17 = values_1[int(1)];
            int _e19 = result;
            result = asint(asuint(_e19) + asuint(asint(asuint(_e16) + asuint(_e17))));
            values_1[int(0)] = int(99);
        }
    }
    int _e27 = result;
    return _e27;
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
    uint out_[2] = (uint[2])0;
    int seed = (int)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    int signed_values[3] = (int[3])0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint words[2] = (uint[2])0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    float samples[2] = (float[2])0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    bool flags[3] = (bool[3])0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    int zeros[2] = (int[2])0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    bool zero_flags[2] = (bool[2])0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    bool local_18 = (bool)0;
    uint bank[2] = (uint[2])0;
    float bank_1[2] = (float[2])0;
    uint local_19[2] = (uint[2])0;
    uint local_20 = (uint)0;
    uint local_21[2] = (uint[2])0;
    uint local_22 = (uint)0;
    int signed_values_1[2] = (int[2])0;
    uint local_23[2] = (uint[2])0;
    uint local_24 = (uint)0;
    uint local_25[2] = (uint[2])0;
    uint local_26 = (uint)0;
    int mixed[2] = (int[2])0;
    uint local_27[2] = (uint[2])0;
    uint local_28 = (uint)0;
    uint local_29[2] = (uint[2])0;
    uint local_30 = (uint)0;
    int reset_total = (int)0;
    int i = (int)0;
    int reset[2] = (int[2])0;
    uint local_31[2] = (uint[2])0;
    uint local_32 = (uint)0;
    int total = (int)0;
    int scratch[2] = (int[2])0;
    int j = (int)0;
    uint local_33[2] = (uint[2])0;
    uint local_34 = (uint)0;
    float zero_samples[2] = (float[2])0;
    uint local_35[2] = (uint[2])0;
    uint local_36 = (uint)0;
    int left[2] = (int[2])0;
    int right[2] = (int[2])0;
    uint local_37[2] = (uint[2])0;
    uint local_38 = (uint)0;
    int temporary[2] = (int[2])0;
    int temporary_1[2] = (int[2])0;
    uint local_39[2] = (uint[2])0;
    uint local_40 = (uint)0;
    uint local_41[2] = (uint[2])0;
    uint local_42 = (uint)0;
    int index = (int)0;
    int rhs = (int)0;
    uint local_43[2] = (uint[2])0;
    uint local_44 = (uint)0;
    int local_45 = (int)0;
    uint local_46[2] = (uint[2])0;
    uint local_47 = (uint)0;
    uint local_48[2] = (uint[2])0;
    uint local_49 = (uint)0;
    uint local_50[2] = (uint[2])0;
    uint local_51 = (uint)0;
    int local_52 = (int)0;
    uint local_53[2] = (uint[2])0;
    uint local_54 = (uint)0;
    int local_55 = (int)0;
    uint local_56[2] = (uint[2])0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    int local_59 = (int)0;
    uint local_60[2] = (uint[2])0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63[2] = (uint[2])0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66[2] = (uint[2])0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint local_69[2] = (uint[2])0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72[2] = (uint[2])0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75[2] = (uint[2])0;
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78[2] = (uint[2])0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81[2] = (uint[2])0;
    uint local_82 = (uint)0;
    uint local_83 = (uint)0;
    uint local_84[2] = (uint[2])0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87[2] = (uint[2])0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;
    uint local_90[2] = (uint[2])0;
    uint local_91 = (uint)0;
    uint local_92 = (uint)0;
    uint local_93[2] = (uint[2])0;
    uint local_94 = (uint)0;
    uint local_95 = (uint)0;
    uint local_96[2] = (uint[2])0;
    uint local_97 = (uint)0;
    uint local_98 = (uint)0;
    uint local_99[2] = (uint[2])0;
    uint local_100 = (uint)0;
    uint local_101 = (uint)0;
    uint local_102[2] = (uint[2])0;
    uint local_103 = (uint)0;
    uint local_104 = (uint)0;
    uint local_105[2] = (uint[2])0;
    uint local_106 = (uint)0;
    uint local_107 = (uint)0;
    uint local_108[2] = (uint[2])0;
    uint local_109 = (uint)0;
    uint local_110 = (uint)0;
    uint local_111[2] = (uint[2])0;
    uint local_112 = (uint)0;
    uint local_113 = (uint)0;
    uint local_114[2] = (uint[2])0;
    uint local_115 = (uint)0;
    uint local_116 = (uint)0;
    uint local_117[2] = (uint[2])0;
    uint local_118 = (uint)0;
    uint local_119 = (uint)0;
    uint local_120[2] = (uint[2])0;
    uint local_121 = (uint)0;
    uint local_122 = (uint)0;
    uint local_123[2] = (uint[2])0;
    uint local_124 = (uint)0;
    uint local_125 = (uint)0;
    uint local_126[2] = (uint[2])0;
    uint local_127 = (uint)0;
    uint local_128 = (uint)0;
    uint local_129[2] = (uint[2])0;
    uint local_130 = (uint)0;
    uint local_131 = (uint)0;
    uint local_132[2] = (uint[2])0;
    uint local_133 = (uint)0;
    uint local_134 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    uint _e7[2] = out_;
    local = _e7;
    local_1 = uint(int(0));
    uint _e12[2] = local;
    local_56 = _e12;
    uint _e14 = local_1;
    uint _e16 = local_56[1];
    local_56[1] = (_e16 + _e14);
    uint _e20 = local_56[0];
    local_57 = uint(_e20);
    uint _e24 = local_56[1];
    local_58 = uint(_e24);
    uint _e27 = local_58;
    int _e30 = asint(out_1.Load(_e27*4));
    local_59 = _e30;
    int _e32 = local_59;
    local_55 = _e32;
    int _e34 = local_55;
    seed = _e34;
    int _e36 = seed;
    signed_values[int(0)] = _e36;
    signed_values[int(1)] = naga_neg(int(2));
    signed_values[int(2)] = int(4);
    int _e51 = signed_values[int(0)];
    int _e52 = signed_values[int(1)];
    int _e56 = signed_values[int(2)];
    uint _e58[2] = out_;
    local_2 = _e58;
    local_3 = uint(int(0));
    uint _e63[2] = local_2;
    local_60 = _e63;
    uint _e65 = local_3;
    uint _e67 = local_60[1];
    local_60[1] = (_e67 + _e65);
    uint _e71 = local_60[0];
    local_61 = uint(_e71);
    uint _e75 = local_60[1];
    local_62 = uint(_e75);
    uint _e78 = local_62;
    out_1.Store(_e78*4, asuint(asint(asuint(asint(asuint(_e51) + asuint(_e52))) + asuint(_e56))));
    words = ZeroValuearray2_uint_();
    words[int(0)] = 4294967295u;
    words[int(1)] = 1u;
    uint _e92 = words[int(0)];
    uint _e93 = words[int(1)];
    uint _e97[2] = out_;
    local_4 = _e97;
    local_5 = uint(int(1));
    uint _e103[2] = local_4;
    local_63 = _e103;
    uint _e105 = local_5;
    uint _e107 = local_63[1];
    local_63[1] = (_e107 + _e105);
    uint _e111 = local_63[0];
    local_64 = uint(_e111);
    uint _e115 = local_63[1];
    local_65 = uint(_e115);
    uint _e118 = local_65;
    out_1.Store(_e118*4, asuint(int(((_e92 + _e93) == 0u))));
    samples = ZeroValuearray2_float_();
    samples[int(0)] = 1.5;
    samples[int(1)] = 2.25;
    float _e132 = samples[int(0)];
    float _e133 = samples[int(1)];
    uint _e138[2] = out_;
    local_6 = _e138;
    local_7 = uint(int(2));
    uint _e143[2] = local_6;
    local_66 = _e143;
    uint _e145 = local_7;
    uint _e147 = local_66[1];
    local_66[1] = (_e147 + _e145);
    uint _e151 = local_66[0];
    local_67 = uint(_e151);
    uint _e155 = local_66[1];
    local_68 = uint(_e155);
    uint _e158 = local_68;
    out_1.Store(_e158*4, asuint(naga_f2i32(((_e132 + _e133) * 4.0))));
    flags = ZeroValuearray3_bool_();
    int _e162 = seed;
    flags[int(0)] = (_e162 != int(0));
    flags[int(2)] = true;
    bool _e172 = flags[int(0)];
    bool _e178 = flags[int(1)];
    bool _e185 = flags[int(2)];
    uint _e188[2] = out_;
    local_8 = _e188;
    local_9 = uint(int(3));
    uint _e193[2] = local_8;
    local_69 = _e193;
    uint _e195 = local_9;
    uint _e197 = local_69[1];
    local_69[1] = (_e197 + _e195);
    uint _e201 = local_69[0];
    local_70 = uint(_e201);
    uint _e205 = local_69[1];
    local_71 = uint(_e205);
    uint _e208 = local_71;
    out_1.Store(_e208*4, asuint(asint(asuint(asint(asuint(asint(asuint(int(_e172)) * asuint(int(100)))) + asuint(asint(asuint(int(_e178)) * asuint(int(10)))))) + asuint(int(_e185)))));
    zeros = ZeroValuearray2_int_();
    int _e216 = zeros[int(0)];
    int _e217 = zeros[int(1)];
    uint _e219[2] = out_;
    local_10 = _e219;
    local_11 = uint(int(4));
    uint _e224[2] = local_10;
    local_72 = _e224;
    uint _e226 = local_11;
    uint _e228 = local_72[1];
    local_72[1] = (_e228 + _e226);
    uint _e232 = local_72[0];
    local_73 = uint(_e232);
    uint _e236 = local_72[1];
    local_74 = uint(_e236);
    uint _e239 = local_74;
    out_1.Store(_e239*4, asuint(asint(asuint(_e216) + asuint(_e217))));
    int _e241 = seed;
    const int _e242 = local_sum(_e241);
    uint _e243[2] = out_;
    local_12 = _e243;
    local_13 = uint(int(5));
    uint _e248[2] = local_12;
    local_75 = _e248;
    uint _e250 = local_13;
    uint _e252 = local_75[1];
    local_75[1] = (_e252 + _e250);
    uint _e256 = local_75[0];
    local_76 = uint(_e256);
    uint _e260 = local_75[1];
    local_77 = uint(_e260);
    uint _e263 = local_77;
    out_1.Store(_e263*4, asuint(_e242));
    const int _e266 = reset_sum(int(3));
    uint _e267[2] = out_;
    local_14 = _e267;
    local_15 = uint(int(6));
    uint _e272[2] = local_14;
    local_78 = _e272;
    uint _e274 = local_15;
    uint _e276 = local_78[1];
    local_78[1] = (_e276 + _e274);
    uint _e280 = local_78[0];
    local_79 = uint(_e280);
    uint _e284 = local_78[1];
    local_80 = uint(_e284);
    uint _e287 = local_80;
    out_1.Store(_e287*4, asuint(_e266));
    zero_flags = ZeroValuearray2_bool_();
    bool _e293 = zero_flags[int(0)];
    local_18 = _e293;
    if (_e293) {
    } else {
        bool _e297 = zero_flags[int(1)];
        local_18 = _e297;
    }
    bool _e298 = local_18;
    uint _e299[2] = out_;
    local_16 = _e299;
    local_17 = uint(int(7));
    uint _e305[2] = local_16;
    local_81 = _e305;
    uint _e307 = local_17;
    uint _e309 = local_81[1];
    local_81[1] = (_e309 + _e307);
    uint _e313 = local_81[0];
    local_82 = uint(_e313);
    uint _e317 = local_81[1];
    local_83 = uint(_e317);
    uint _e320 = local_83;
    out_1.Store(_e320*4, asuint(int(_e298)));
    bank = ZeroValuearray2_uint_();
    bank[int(0)] = 3u;
    bank[int(1)] = 4u;
    {
        bank_1 = ZeroValuearray2_float_();
        bank_1[int(1)] = 6.5;
        float _e339 = bank_1[int(0)];
        float _e340 = bank_1[int(1)];
        uint _e343[2] = out_;
        local_19 = _e343;
        local_20 = uint(int(8));
        uint _e348[2] = local_19;
        local_84 = _e348;
        uint _e350 = local_20;
        uint _e352 = local_84[1];
        local_84[1] = (_e352 + _e350);
        uint _e356 = local_84[0];
        local_85 = uint(_e356);
        uint _e360 = local_84[1];
        local_86 = uint(_e360);
        uint _e363 = local_86;
        out_1.Store(_e363*4, asuint(naga_f2i32((_e339 + _e340))));
    }
    uint _e369 = bank[int(0)];
    uint _e370 = bank[int(1)];
    uint _e373[2] = out_;
    local_21 = _e373;
    local_22 = uint(int(9));
    uint _e378[2] = local_21;
    local_87 = _e378;
    uint _e380 = local_22;
    uint _e382 = local_87[1];
    local_87[1] = (_e382 + _e380);
    uint _e386 = local_87[0];
    local_88 = uint(_e386);
    uint _e390 = local_87[1];
    local_89 = uint(_e390);
    uint _e393 = local_89;
    out_1.Store(_e393*4, asuint(int((_e369 + _e370))));
    {
        int _e395 = seed;
        signed_values_1[int(0)] = _e395;
        int _e399 = seed;
        signed_values_1[int(1)] = _e399;
        int _e406 = signed_values_1[int(0)];
        int _e407 = signed_values_1[int(1)];
        uint _e409[2] = out_;
        local_23 = _e409;
        local_24 = uint(int(10));
        uint _e414[2] = local_23;
        local_90 = _e414;
        uint _e416 = local_24;
        uint _e418 = local_90[1];
        local_90[1] = (_e418 + _e416);
        uint _e422 = local_90[0];
        local_91 = uint(_e422);
        uint _e426 = local_90[1];
        local_92 = uint(_e426);
        uint _e429 = local_92;
        out_1.Store(_e429*4, asuint(asint(asuint(_e406) + asuint(_e407))));
    }
    int _e433 = signed_values[int(0)];
    uint _e434[2] = out_;
    local_25 = _e434;
    local_26 = uint(int(11));
    uint _e439[2] = local_25;
    local_93 = _e439;
    uint _e441 = local_26;
    uint _e443 = local_93[1];
    local_93[1] = (_e443 + _e441);
    uint _e447 = local_93[0];
    local_94 = uint(_e447);
    uint _e451 = local_93[1];
    local_95 = uint(_e451);
    uint _e454 = local_95;
    out_1.Store(_e454*4, asuint(_e433));
    mixed = ZeroValuearray2_int_();
    int _e458 = seed;
    seed = asint(asuint(_e458) + asuint(int(1)));
    int next = seed;
    mixed[int(0)] = next;
    int _e464 = seed;
    seed = asint(asuint(_e464) + asuint(int(1)));
    mixed[int(1)] = _e464;
    int _e471 = mixed[int(0)];
    int _e476 = mixed[int(1)];
    uint _e478[2] = out_;
    local_27 = _e478;
    local_28 = uint(int(12));
    uint _e483[2] = local_27;
    local_96 = _e483;
    uint _e485 = local_28;
    uint _e487 = local_96[1];
    local_96[1] = (_e487 + _e485);
    uint _e491 = local_96[0];
    local_97 = uint(_e491);
    uint _e495 = local_96[1];
    local_98 = uint(_e495);
    uint _e498 = local_98;
    out_1.Store(_e498*4, asuint(asint(asuint(asint(asuint(_e471) * asuint(int(10)))) + asuint(_e476))));
    int _e500 = seed;
    uint _e501[2] = out_;
    local_29 = _e501;
    local_30 = uint(int(13));
    uint _e506[2] = local_29;
    local_99 = _e506;
    uint _e508 = local_30;
    uint _e510 = local_99[1];
    local_99[1] = (_e510 + _e508);
    uint _e514 = local_99[0];
    local_100 = uint(_e514);
    uint _e518 = local_99[1];
    local_101 = uint(_e518);
    uint _e521 = local_101;
    out_1.Store(_e521*4, asuint(_e500));
    reset_total = int(0);
    {
        i = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e548 = i;
                i = asint(asuint(_e548) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e527 = i;
            if ((_e527 < int(3))) {
            } else {
                break;
            }
            reset = ZeroValuearray2_int_();
            int _e532 = i;
            if ((_e532 == int(1))) {
                reset[int(0)] = int(90);
                continue;
            }
            int _e540 = reset[int(0)];
            int _e541 = i;
            int _e543 = reset_total;
            reset_total = asint(asuint(_e543) + asuint(asint(asuint(_e540) + asuint(_e541))));
            reset[int(0)] = int(99);
        }
    }
    int _e551 = reset_total;
    uint _e552[2] = out_;
    local_31 = _e552;
    local_32 = uint(int(14));
    uint _e557[2] = local_31;
    local_102 = _e557;
    uint _e559 = local_32;
    uint _e561 = local_102[1];
    local_102[1] = (_e561 + _e559);
    uint _e565 = local_102[0];
    local_103 = uint(_e565);
    uint _e569 = local_102[1];
    local_104 = uint(_e569);
    uint _e572 = local_104;
    out_1.Store(_e572*4, asuint(_e551));
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
                int _e604 = j;
                j = asint(asuint(_e604) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e580 = j;
            if ((_e580 < int(3))) {
            } else {
                break;
            }
            int _e583 = j;
            int _e587 = scratch[min(uint(naga_mod(_e583, int(2))), 1u)];
            scratch[min(uint(naga_mod(_e583, int(2))), 1u)] = asint(asuint(_e587) + asuint(int(1)));
            int _e590 = j;
            if ((_e590 == int(1))) {
                continue;
            }
            int _e595 = scratch[int(0)];
            int _e600 = scratch[int(1)];
            int _e602 = total;
            total = asint(asuint(_e602) + asuint(asint(asuint(asint(asuint(_e595) * asuint(int(10)))) + asuint(_e600))));
        }
    }
    int _e607 = total;
    uint _e608[2] = out_;
    local_33 = _e608;
    local_34 = uint(int(15));
    uint _e613[2] = local_33;
    local_105 = _e613;
    uint _e615 = local_34;
    uint _e617 = local_105[1];
    local_105[1] = (_e617 + _e615);
    uint _e621 = local_105[0];
    local_106 = uint(_e621);
    uint _e625 = local_105[1];
    local_107 = uint(_e625);
    uint _e628 = local_107;
    out_1.Store(_e628*4, asuint(_e607));
    zero_samples = ZeroValuearray2_float_();
    float _e636 = zero_samples[int(0)];
    float _e637 = zero_samples[int(1)];
    uint _e640[2] = out_;
    local_35 = _e640;
    local_36 = uint(int(16));
    uint _e645[2] = local_35;
    local_108 = _e645;
    uint _e647 = local_36;
    uint _e649 = local_108[1];
    local_108[1] = (_e649 + _e647);
    uint _e653 = local_108[0];
    local_109 = uint(_e653);
    uint _e657 = local_108[1];
    local_110 = uint(_e657);
    uint _e660 = local_110;
    out_1.Store(_e660*4, asuint(naga_f2i32((_e636 + _e637))));
    left = ZeroValuearray2_int_();
    right = ZeroValuearray2_int_();
    left[int(0)] = int(5);
    left[int(1)] = int(7);
    right[int(0)] = int(11);
    right[int(1)] = int(13);
    int _e682 = left[int(0)];
    int _e683 = right[int(0)];
    uint _e685[2] = out_;
    local_37 = _e685;
    local_38 = uint(int(17));
    uint _e690[2] = local_37;
    local_111 = _e690;
    uint _e692 = local_38;
    uint _e694 = local_111[1];
    local_111[1] = (_e694 + _e692);
    uint _e698 = local_111[0];
    local_112 = uint(_e698);
    uint _e702 = local_111[1];
    local_113 = uint(_e702);
    uint _e705 = local_113;
    out_1.Store(_e705*4, asuint(asint(asuint(_e682) + asuint(_e683))));
    {
        temporary = ZeroValuearray2_int_();
        int _e709 = seed;
        temporary[int(0)] = _e709;
        {
            temporary_1 = ZeroValuearray2_int_();
            temporary_1[int(1)] = int(3);
            int _e721 = temporary_1[int(0)];
            int _e722 = temporary_1[int(1)];
            uint _e724[2] = out_;
            local_39 = _e724;
            local_40 = uint(int(18));
            uint _e729[2] = local_39;
            local_114 = _e729;
            uint _e731 = local_40;
            uint _e733 = local_114[1];
            local_114[1] = (_e733 + _e731);
            uint _e737 = local_114[0];
            local_115 = uint(_e737);
            uint _e741 = local_114[1];
            local_116 = uint(_e741);
            uint _e744 = local_116;
            out_1.Store(_e744*4, asuint(asint(asuint(_e721) + asuint(_e722))));
        }
        int _e748 = temporary[int(0)];
        uint _e749[2] = out_;
        local_41 = _e749;
        local_42 = uint(int(19));
        uint _e754[2] = local_41;
        local_117 = _e754;
        uint _e756 = local_42;
        uint _e758 = local_117[1];
        local_117[1] = (_e758 + _e756);
        uint _e762 = local_117[0];
        local_118 = uint(_e762);
        uint _e766 = local_117[1];
        local_119 = uint(_e766);
        uint _e769 = local_119;
        out_1.Store(_e769*4, asuint(_e748));
    }
    int _e771 = seed;
    bool choose = ((_e771 & int(1)) == int(0));
    index = int(0);
    rhs = int(20);
    int _e780 = rhs;
    rhs = asint(asuint(_e780) + asuint(int(1)));
    int _e783 = rhs;
    if (choose) {
        int _e784 = index;
        index = asint(asuint(_e784) + asuint(int(1)));
        int _e788 = left[min(uint(_e784), 1u)];
        left[min(uint(_e784), 1u)] = asint(asuint(_e788) + asuint(_e783));
        int _e790 = left[min(uint(_e784), 1u)];
        local_45 = _e790;
    } else {
        int _e792 = index;
        index = asint(asuint(_e792) + asuint(int(1)));
        int _e796 = right[min(uint(_e792), 1u)];
        right[min(uint(_e792), 1u)] = asint(asuint(_e796) + asuint(_e783));
        int _e798 = right[min(uint(_e792), 1u)];
        local_45 = _e798;
    }
    int _e801 = local_45;
    uint _e802[2] = out_;
    local_43 = _e802;
    local_44 = uint(int(20));
    uint _e807[2] = local_43;
    local_120 = _e807;
    uint _e809 = local_44;
    uint _e811 = local_120[1];
    local_120[1] = (_e811 + _e809);
    uint _e815 = local_120[0];
    local_121 = uint(_e815);
    uint _e819 = local_120[1];
    local_122 = uint(_e819);
    uint _e822 = local_122;
    out_1.Store(_e822*4, asuint(_e801));
    int _e824 = index;
    uint _e825[2] = out_;
    local_46 = _e825;
    local_47 = uint(int(21));
    uint _e830[2] = local_46;
    local_123 = _e830;
    uint _e832 = local_47;
    uint _e834 = local_123[1];
    local_123[1] = (_e834 + _e832);
    uint _e838 = local_123[0];
    local_124 = uint(_e838);
    uint _e842 = local_123[1];
    local_125 = uint(_e842);
    uint _e845 = local_125;
    out_1.Store(_e845*4, asuint(_e824));
    int _e849 = left[int(0)];
    int _e854 = right[int(0)];
    uint _e856[2] = out_;
    local_48 = _e856;
    local_49 = uint(int(22));
    uint _e861[2] = local_48;
    local_126 = _e861;
    uint _e863 = local_49;
    uint _e865 = local_126[1];
    local_126[1] = (_e865 + _e863);
    uint _e869 = local_126[0];
    local_127 = uint(_e869);
    uint _e873 = local_126[1];
    local_128 = uint(_e873);
    uint _e876 = local_128;
    out_1.Store(_e876*4, asuint(asint(asuint(asint(asuint(_e849) * asuint(int(100)))) + asuint(_e854))));
    if (choose) {
        right[int(1)] = int(9);
        int _e881 = right[int(1)];
        right[int(1)] = asint(asuint(_e881) + asuint(int(1)));
        local_52 = _e881;
    } else {
        left[int(1)] = int(9);
        int _e888 = left[int(1)];
        left[int(1)] = asint(asuint(_e888) + asuint(int(1)));
        local_52 = _e888;
    }
    int _e893 = local_52;
    uint _e894[2] = out_;
    local_50 = _e894;
    local_51 = uint(int(23));
    uint _e899[2] = local_50;
    local_129 = _e899;
    uint _e901 = local_51;
    uint _e903 = local_129[1];
    local_129[1] = (_e903 + _e901);
    uint _e907 = local_129[0];
    local_130 = uint(_e907);
    uint _e911 = local_129[1];
    local_131 = uint(_e911);
    uint _e914 = local_131;
    out_1.Store(_e914*4, asuint(_e893));
    int _e918 = left[int(1)];
    int _e923 = right[int(1)];
    uint _e925[2] = out_;
    local_53 = _e925;
    local_54 = uint(int(24));
    uint _e930[2] = local_53;
    local_132 = _e930;
    uint _e932 = local_54;
    uint _e934 = local_132[1];
    local_132[1] = (_e934 + _e932);
    uint _e938 = local_132[0];
    local_133 = uint(_e938);
    uint _e942 = local_132[1];
    local_134 = uint(_e942);
    uint _e945 = local_134;
    out_1.Store(_e945*4, asuint(asint(asuint(asint(asuint(_e918) * asuint(int(100)))) + asuint(_e923))));
}
