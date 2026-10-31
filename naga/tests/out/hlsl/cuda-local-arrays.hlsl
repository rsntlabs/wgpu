RWByteAddressBuffer out_1 : register(u0);

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
    int next = (int)0;
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
    bool choose = (bool)0;
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
    uint _e9[2] = out_;
    local = _e9;
    local_1 = uint(int(0));
    uint _e14[2] = local;
    local_56 = _e14;
    uint _e15 = local_1;
    uint _e17 = local_56[1];
    local_56[1] = (_e17 + _e15);
    uint _e21 = local_56[0];
    local_57 = uint(_e21);
    uint _e25 = local_56[1];
    local_58 = uint(_e25);
    uint _e29 = local_58;
    int _e31 = asint(out_1.Load(_e29*4));
    local_59 = _e31;
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
    uint _e59[2] = out_;
    local_2 = _e59;
    local_3 = uint(int(0));
    uint _e64[2] = local_2;
    local_60 = _e64;
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
    uint _e98[2] = out_;
    local_4 = _e98;
    local_5 = uint(int(1));
    uint _e104[2] = local_4;
    local_63 = _e104;
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
    uint _e139[2] = out_;
    local_6 = _e139;
    local_7 = uint(int(2));
    uint _e144[2] = local_6;
    local_66 = _e144;
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
    uint _e189[2] = out_;
    local_8 = _e189;
    local_9 = uint(int(3));
    uint _e194[2] = local_8;
    local_69 = _e194;
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
    uint _e220[2] = out_;
    local_10 = _e220;
    local_11 = uint(int(4));
    uint _e225[2] = local_10;
    local_72 = _e225;
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
    uint _e244[2] = out_;
    local_12 = _e244;
    local_13 = uint(int(5));
    uint _e249[2] = local_12;
    local_75 = _e249;
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
    uint _e268[2] = out_;
    local_14 = _e268;
    local_15 = uint(int(6));
    uint _e273[2] = local_14;
    local_78 = _e273;
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
    uint _e300[2] = out_;
    local_16 = _e300;
    local_17 = uint(int(7));
    uint _e306[2] = local_16;
    local_81 = _e306;
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
        uint _e344[2] = out_;
        local_19 = _e344;
        local_20 = uint(int(8));
        uint _e349[2] = local_19;
        local_84 = _e349;
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
    uint _e374[2] = out_;
    local_21 = _e374;
    local_22 = uint(int(9));
    uint _e379[2] = local_21;
    local_87 = _e379;
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
        uint _e410[2] = out_;
        local_23 = _e410;
        local_24 = uint(int(10));
        uint _e415[2] = local_23;
        local_90 = _e415;
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
    uint _e435[2] = out_;
    local_25 = _e435;
    local_26 = uint(int(11));
    uint _e440[2] = local_25;
    local_93 = _e440;
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
    int _e461 = seed;
    next = _e461;
    int _e463 = next;
    mixed[int(0)] = _e463;
    int _e466 = seed;
    seed = asint(asuint(_e466) + asuint(int(1)));
    mixed[int(1)] = _e466;
    int _e473 = mixed[int(0)];
    int _e478 = mixed[int(1)];
    uint _e481[2] = out_;
    local_27 = _e481;
    local_28 = uint(int(12));
    uint _e486[2] = local_27;
    local_96 = _e486;
    uint _e487 = local_28;
    uint _e489 = local_96[1];
    local_96[1] = (_e489 + _e487);
    uint _e493 = local_96[0];
    local_97 = uint(_e493);
    uint _e497 = local_96[1];
    local_98 = uint(_e497);
    uint _e500 = local_98;
    out_1.Store(_e500*4, asuint(asint(asuint(asint(asuint(_e473) * asuint(int(10)))) + asuint(_e478))));
    int _e502 = seed;
    uint _e504[2] = out_;
    local_29 = _e504;
    local_30 = uint(int(13));
    uint _e509[2] = local_29;
    local_99 = _e509;
    uint _e510 = local_30;
    uint _e512 = local_99[1];
    local_99[1] = (_e512 + _e510);
    uint _e516 = local_99[0];
    local_100 = uint(_e516);
    uint _e520 = local_99[1];
    local_101 = uint(_e520);
    uint _e523 = local_101;
    out_1.Store(_e523*4, asuint(_e502));
    reset_total = int(0);
    {
        i = int(0);
        uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                int _e550 = i;
                i = asint(asuint(_e550) + asuint(int(1)));
            }
            loop_init_1 = false;
            int _e529 = i;
            if ((_e529 < int(3))) {
            } else {
                break;
            }
            reset = ZeroValuearray2_int_();
            int _e534 = i;
            if ((_e534 == int(1))) {
                reset[int(0)] = int(90);
                continue;
            }
            int _e542 = reset[int(0)];
            int _e543 = i;
            int _e545 = reset_total;
            reset_total = asint(asuint(_e545) + asuint(asint(asuint(_e542) + asuint(_e543))));
            reset[int(0)] = int(99);
        }
    }
    int _e553 = reset_total;
    uint _e555[2] = out_;
    local_31 = _e555;
    local_32 = uint(int(14));
    uint _e560[2] = local_31;
    local_102 = _e560;
    uint _e561 = local_32;
    uint _e563 = local_102[1];
    local_102[1] = (_e563 + _e561);
    uint _e567 = local_102[0];
    local_103 = uint(_e567);
    uint _e571 = local_102[1];
    local_104 = uint(_e571);
    uint _e574 = local_104;
    out_1.Store(_e574*4, asuint(_e553));
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
                int _e606 = j;
                j = asint(asuint(_e606) + asuint(int(1)));
            }
            loop_init_2 = false;
            int _e582 = j;
            if ((_e582 < int(3))) {
            } else {
                break;
            }
            int _e585 = j;
            int _e589 = scratch[min(uint(naga_mod(_e585, int(2))), 1u)];
            scratch[min(uint(naga_mod(_e585, int(2))), 1u)] = asint(asuint(_e589) + asuint(int(1)));
            int _e592 = j;
            if ((_e592 == int(1))) {
                continue;
            }
            int _e597 = scratch[int(0)];
            int _e602 = scratch[int(1)];
            int _e604 = total;
            total = asint(asuint(_e604) + asuint(asint(asuint(asint(asuint(_e597) * asuint(int(10)))) + asuint(_e602))));
        }
    }
    int _e609 = total;
    uint _e611[2] = out_;
    local_33 = _e611;
    local_34 = uint(int(15));
    uint _e616[2] = local_33;
    local_105 = _e616;
    uint _e617 = local_34;
    uint _e619 = local_105[1];
    local_105[1] = (_e619 + _e617);
    uint _e623 = local_105[0];
    local_106 = uint(_e623);
    uint _e627 = local_105[1];
    local_107 = uint(_e627);
    uint _e630 = local_107;
    out_1.Store(_e630*4, asuint(_e609));
    zero_samples = ZeroValuearray2_float_();
    float _e638 = zero_samples[int(0)];
    float _e639 = zero_samples[int(1)];
    uint _e643[2] = out_;
    local_35 = _e643;
    local_36 = uint(int(16));
    uint _e648[2] = local_35;
    local_108 = _e648;
    uint _e649 = local_36;
    uint _e651 = local_108[1];
    local_108[1] = (_e651 + _e649);
    uint _e655 = local_108[0];
    local_109 = uint(_e655);
    uint _e659 = local_108[1];
    local_110 = uint(_e659);
    uint _e662 = local_110;
    out_1.Store(_e662*4, asuint(naga_f2i32((_e638 + _e639))));
    left = ZeroValuearray2_int_();
    right = ZeroValuearray2_int_();
    left[int(0)] = int(5);
    left[int(1)] = int(7);
    right[int(0)] = int(11);
    right[int(1)] = int(13);
    int _e684 = left[int(0)];
    int _e685 = right[int(0)];
    uint _e688[2] = out_;
    local_37 = _e688;
    local_38 = uint(int(17));
    uint _e693[2] = local_37;
    local_111 = _e693;
    uint _e694 = local_38;
    uint _e696 = local_111[1];
    local_111[1] = (_e696 + _e694);
    uint _e700 = local_111[0];
    local_112 = uint(_e700);
    uint _e704 = local_111[1];
    local_113 = uint(_e704);
    uint _e707 = local_113;
    out_1.Store(_e707*4, asuint(asint(asuint(_e684) + asuint(_e685))));
    {
        temporary = ZeroValuearray2_int_();
        int _e711 = seed;
        temporary[int(0)] = _e711;
        {
            temporary_1 = ZeroValuearray2_int_();
            temporary_1[int(1)] = int(3);
            int _e723 = temporary_1[int(0)];
            int _e724 = temporary_1[int(1)];
            uint _e727[2] = out_;
            local_39 = _e727;
            local_40 = uint(int(18));
            uint _e732[2] = local_39;
            local_114 = _e732;
            uint _e733 = local_40;
            uint _e735 = local_114[1];
            local_114[1] = (_e735 + _e733);
            uint _e739 = local_114[0];
            local_115 = uint(_e739);
            uint _e743 = local_114[1];
            local_116 = uint(_e743);
            uint _e746 = local_116;
            out_1.Store(_e746*4, asuint(asint(asuint(_e723) + asuint(_e724))));
        }
        int _e750 = temporary[int(0)];
        uint _e752[2] = out_;
        local_41 = _e752;
        local_42 = uint(int(19));
        uint _e757[2] = local_41;
        local_117 = _e757;
        uint _e758 = local_42;
        uint _e760 = local_117[1];
        local_117[1] = (_e760 + _e758);
        uint _e764 = local_117[0];
        local_118 = uint(_e764);
        uint _e768 = local_117[1];
        local_119 = uint(_e768);
        uint _e771 = local_119;
        out_1.Store(_e771*4, asuint(_e750));
    }
    int _e773 = seed;
    choose = ((_e773 & int(1)) == int(0));
    index = int(0);
    rhs = int(20);
    int _e783 = rhs;
    rhs = asint(asuint(_e783) + asuint(int(1)));
    int _e786 = rhs;
    bool _e787 = choose;
    if (_e787) {
        int _e788 = index;
        index = asint(asuint(_e788) + asuint(int(1)));
        int _e792 = left[min(uint(_e788), 1u)];
        left[min(uint(_e788), 1u)] = asint(asuint(_e792) + asuint(_e786));
        int _e794 = left[min(uint(_e788), 1u)];
        local_45 = _e794;
    } else {
        int _e796 = index;
        index = asint(asuint(_e796) + asuint(int(1)));
        int _e800 = right[min(uint(_e796), 1u)];
        right[min(uint(_e796), 1u)] = asint(asuint(_e800) + asuint(_e786));
        int _e802 = right[min(uint(_e796), 1u)];
        local_45 = _e802;
    }
    int _e805 = local_45;
    uint _e807[2] = out_;
    local_43 = _e807;
    local_44 = uint(int(20));
    uint _e812[2] = local_43;
    local_120 = _e812;
    uint _e813 = local_44;
    uint _e815 = local_120[1];
    local_120[1] = (_e815 + _e813);
    uint _e819 = local_120[0];
    local_121 = uint(_e819);
    uint _e823 = local_120[1];
    local_122 = uint(_e823);
    uint _e826 = local_122;
    out_1.Store(_e826*4, asuint(_e805));
    int _e828 = index;
    uint _e830[2] = out_;
    local_46 = _e830;
    local_47 = uint(int(21));
    uint _e835[2] = local_46;
    local_123 = _e835;
    uint _e836 = local_47;
    uint _e838 = local_123[1];
    local_123[1] = (_e838 + _e836);
    uint _e842 = local_123[0];
    local_124 = uint(_e842);
    uint _e846 = local_123[1];
    local_125 = uint(_e846);
    uint _e849 = local_125;
    out_1.Store(_e849*4, asuint(_e828));
    int _e853 = left[int(0)];
    int _e858 = right[int(0)];
    uint _e861[2] = out_;
    local_48 = _e861;
    local_49 = uint(int(22));
    uint _e866[2] = local_48;
    local_126 = _e866;
    uint _e867 = local_49;
    uint _e869 = local_126[1];
    local_126[1] = (_e869 + _e867);
    uint _e873 = local_126[0];
    local_127 = uint(_e873);
    uint _e877 = local_126[1];
    local_128 = uint(_e877);
    uint _e880 = local_128;
    out_1.Store(_e880*4, asuint(asint(asuint(asint(asuint(_e853) * asuint(int(100)))) + asuint(_e858))));
    bool _e882 = choose;
    if (_e882) {
        right[int(1)] = int(9);
        int _e886 = right[int(1)];
        right[int(1)] = asint(asuint(_e886) + asuint(int(1)));
        local_52 = _e886;
    } else {
        left[int(1)] = int(9);
        int _e893 = left[int(1)];
        left[int(1)] = asint(asuint(_e893) + asuint(int(1)));
        local_52 = _e893;
    }
    int _e898 = local_52;
    uint _e900[2] = out_;
    local_50 = _e900;
    local_51 = uint(int(23));
    uint _e905[2] = local_50;
    local_129 = _e905;
    uint _e906 = local_51;
    uint _e908 = local_129[1];
    local_129[1] = (_e908 + _e906);
    uint _e912 = local_129[0];
    local_130 = uint(_e912);
    uint _e916 = local_129[1];
    local_131 = uint(_e916);
    uint _e919 = local_131;
    out_1.Store(_e919*4, asuint(_e898));
    int _e923 = left[int(1)];
    int _e928 = right[int(1)];
    uint _e931[2] = out_;
    local_53 = _e931;
    local_54 = uint(int(24));
    uint _e936[2] = local_53;
    local_132 = _e936;
    uint _e937 = local_54;
    uint _e939 = local_132[1];
    local_132[1] = (_e939 + _e937);
    uint _e943 = local_132[0];
    local_133 = uint(_e943);
    uint _e947 = local_132[1];
    local_134 = uint(_e947);
    uint _e950 = local_134;
    out_1.Store(_e950*4, asuint(asint(asuint(asint(asuint(_e923) * asuint(int(100)))) + asuint(_e928))));
}
