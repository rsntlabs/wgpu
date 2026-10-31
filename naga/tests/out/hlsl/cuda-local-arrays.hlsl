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
    uint local[2] = (uint[2])0;
    int seed = (int)0;
    uint local_1[2] = (uint[2])0;
    uint local_2 = (uint)0;
    int signed_values[3] = (int[3])0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint words[2] = (uint[2])0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    float samples[2] = (float[2])0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    bool flags[3] = (bool[3])0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    int zeros[2] = (int[2])0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13[2] = (uint[2])0;
    uint local_14 = (uint)0;
    uint local_15[2] = (uint[2])0;
    uint local_16 = (uint)0;
    bool zero_flags[2] = (bool[2])0;
    uint local_17[2] = (uint[2])0;
    uint local_18 = (uint)0;
    bool local_19 = (bool)0;
    uint bank[2] = (uint[2])0;
    float bank_1[2] = (float[2])0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    int signed_values_1[2] = (int[2])0;
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    int mixed[2] = (int[2])0;
    int next = (int)0;
    uint local_28[2] = (uint[2])0;
    uint local_29 = (uint)0;
    uint local_30[2] = (uint[2])0;
    uint local_31 = (uint)0;
    int reset_total = (int)0;
    int i = (int)0;
    int reset[2] = (int[2])0;
    uint local_32[2] = (uint[2])0;
    uint local_33 = (uint)0;
    int total = (int)0;
    int scratch[2] = (int[2])0;
    int j = (int)0;
    uint local_34[2] = (uint[2])0;
    uint local_35 = (uint)0;
    float zero_samples[2] = (float[2])0;
    uint local_36[2] = (uint[2])0;
    uint local_37 = (uint)0;
    int left[2] = (int[2])0;
    int right[2] = (int[2])0;
    uint local_38[2] = (uint[2])0;
    uint local_39 = (uint)0;
    int temporary[2] = (int[2])0;
    int temporary_1[2] = (int[2])0;
    uint local_40[2] = (uint[2])0;
    uint local_41 = (uint)0;
    uint local_42[2] = (uint[2])0;
    uint local_43 = (uint)0;
    bool choose = (bool)0;
    int index = (int)0;
    int rhs = (int)0;
    uint local_44[2] = (uint[2])0;
    uint local_45 = (uint)0;
    int local_46 = (int)0;
    uint local_47[2] = (uint[2])0;
    uint local_48 = (uint)0;
    uint local_49[2] = (uint[2])0;
    uint local_50 = (uint)0;
    uint local_51[2] = (uint[2])0;
    uint local_52 = (uint)0;
    int local_53 = (int)0;
    uint local_54[2] = (uint[2])0;
    uint local_55 = (uint)0;
    int local_56 = (int)0;
    uint local_57[2] = (uint[2])0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    int local_60 = (int)0;
    uint local_61[2] = (uint[2])0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64[2] = (uint[2])0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67[2] = (uint[2])0;
    uint local_68 = (uint)0;
    uint local_69 = (uint)0;
    uint local_70[2] = (uint[2])0;
    uint local_71 = (uint)0;
    uint local_72 = (uint)0;
    uint local_73[2] = (uint[2])0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    uint local_76[2] = (uint[2])0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    uint local_79[2] = (uint[2])0;
    uint local_80 = (uint)0;
    uint local_81 = (uint)0;
    uint local_82[2] = (uint[2])0;
    uint local_83 = (uint)0;
    uint local_84 = (uint)0;
    uint local_85[2] = (uint[2])0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;
    uint local_88[2] = (uint[2])0;
    uint local_89 = (uint)0;
    uint local_90 = (uint)0;
    uint local_91[2] = (uint[2])0;
    uint local_92 = (uint)0;
    uint local_93 = (uint)0;
    uint local_94[2] = (uint[2])0;
    uint local_95 = (uint)0;
    uint local_96 = (uint)0;
    uint local_97[2] = (uint[2])0;
    uint local_98 = (uint)0;
    uint local_99 = (uint)0;
    uint local_100[2] = (uint[2])0;
    uint local_101 = (uint)0;
    uint local_102 = (uint)0;
    uint local_103[2] = (uint[2])0;
    uint local_104 = (uint)0;
    uint local_105 = (uint)0;
    uint local_106[2] = (uint[2])0;
    uint local_107 = (uint)0;
    uint local_108 = (uint)0;
    uint local_109[2] = (uint[2])0;
    uint local_110 = (uint)0;
    uint local_111 = (uint)0;
    uint local_112[2] = (uint[2])0;
    uint local_113 = (uint)0;
    uint local_114 = (uint)0;
    uint local_115[2] = (uint[2])0;
    uint local_116 = (uint)0;
    uint local_117 = (uint)0;
    uint local_118[2] = (uint[2])0;
    uint local_119 = (uint)0;
    uint local_120 = (uint)0;
    uint local_121[2] = (uint[2])0;
    uint local_122 = (uint)0;
    uint local_123 = (uint)0;
    uint local_124[2] = (uint[2])0;
    uint local_125 = (uint)0;
    uint local_126 = (uint)0;
    uint local_127[2] = (uint[2])0;
    uint local_128 = (uint)0;
    uint local_129 = (uint)0;
    uint local_130[2] = (uint[2])0;
    uint local_131 = (uint)0;
    uint local_132 = (uint)0;
    uint local_133[2] = (uint[2])0;
    uint local_134 = (uint)0;
    uint local_135 = (uint)0;

    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
    uint _e9[2] = local;
    local_1 = _e9;
    local_2 = uint(int(0));
    uint _e14[2] = local_1;
    local_57 = _e14;
    uint _e15 = local_2;
    uint _e17 = local_57[1];
    local_57[1] = (_e17 + _e15);
    uint _e21 = local_57[0];
    local_58 = uint(_e21);
    uint _e25 = local_57[1];
    local_59 = uint(_e25);
    uint _e29 = local_59;
    int _e31 = asint(out_.Load(_e29*4));
    local_60 = _e31;
    int _e32 = local_60;
    local_56 = _e32;
    int _e34 = local_56;
    seed = _e34;
    int _e36 = seed;
    signed_values[int(0)] = _e36;
    signed_values[int(1)] = naga_neg(int(2));
    signed_values[int(2)] = int(4);
    int _e51 = signed_values[int(0)];
    int _e52 = signed_values[int(1)];
    int _e56 = signed_values[int(2)];
    uint _e59[2] = local;
    local_3 = _e59;
    local_4 = uint(int(0));
    uint _e64[2] = local_3;
    local_61 = _e64;
    uint _e65 = local_4;
    uint _e67 = local_61[1];
    local_61[1] = (_e67 + _e65);
    uint _e71 = local_61[0];
    local_62 = uint(_e71);
    uint _e75 = local_61[1];
    local_63 = uint(_e75);
    uint _e78 = local_63;
    out_.Store(_e78*4, asuint(asint(asuint(asint(asuint(_e51) + asuint(_e52))) + asuint(_e56))));
    words = ZeroValuearray2_uint_();
    words[int(0)] = 4294967295u;
    words[int(1)] = 1u;
    uint _e92 = words[int(0)];
    uint _e93 = words[int(1)];
    uint _e98[2] = local;
    local_5 = _e98;
    local_6 = uint(int(1));
    uint _e104[2] = local_5;
    local_64 = _e104;
    uint _e105 = local_6;
    uint _e107 = local_64[1];
    local_64[1] = (_e107 + _e105);
    uint _e111 = local_64[0];
    local_65 = uint(_e111);
    uint _e115 = local_64[1];
    local_66 = uint(_e115);
    uint _e118 = local_66;
    out_.Store(_e118*4, asuint(int(((_e92 + _e93) == 0u))));
    samples = ZeroValuearray2_float_();
    samples[int(0)] = 1.5;
    samples[int(1)] = 2.25;
    float _e132 = samples[int(0)];
    float _e133 = samples[int(1)];
    uint _e139[2] = local;
    local_7 = _e139;
    local_8 = uint(int(2));
    uint _e144[2] = local_7;
    local_67 = _e144;
    uint _e145 = local_8;
    uint _e147 = local_67[1];
    local_67[1] = (_e147 + _e145);
    uint _e151 = local_67[0];
    local_68 = uint(_e151);
    uint _e155 = local_67[1];
    local_69 = uint(_e155);
    uint _e158 = local_69;
    out_.Store(_e158*4, asuint(naga_f2i32(((_e132 + _e133) * 4.0))));
    flags = ZeroValuearray3_bool_();
    int _e162 = seed;
    flags[int(0)] = (_e162 != int(0));
    flags[int(2)] = true;
    bool _e172 = flags[int(0)];
    bool _e178 = flags[int(1)];
    bool _e185 = flags[int(2)];
    uint _e189[2] = local;
    local_9 = _e189;
    local_10 = uint(int(3));
    uint _e194[2] = local_9;
    local_70 = _e194;
    uint _e195 = local_10;
    uint _e197 = local_70[1];
    local_70[1] = (_e197 + _e195);
    uint _e201 = local_70[0];
    local_71 = uint(_e201);
    uint _e205 = local_70[1];
    local_72 = uint(_e205);
    uint _e208 = local_72;
    out_.Store(_e208*4, asuint(asint(asuint(asint(asuint(asint(asuint(int(_e172)) * asuint(int(100)))) + asuint(asint(asuint(int(_e178)) * asuint(int(10)))))) + asuint(int(_e185)))));
    zeros = ZeroValuearray2_int_();
    int _e216 = zeros[int(0)];
    int _e217 = zeros[int(1)];
    uint _e220[2] = local;
    local_11 = _e220;
    local_12 = uint(int(4));
    uint _e225[2] = local_11;
    local_73 = _e225;
    uint _e226 = local_12;
    uint _e228 = local_73[1];
    local_73[1] = (_e228 + _e226);
    uint _e232 = local_73[0];
    local_74 = uint(_e232);
    uint _e236 = local_73[1];
    local_75 = uint(_e236);
    uint _e239 = local_75;
    out_.Store(_e239*4, asuint(asint(asuint(_e216) + asuint(_e217))));
    int _e241 = seed;
    const int _e242 = local_sum(_e241);
    uint _e244[2] = local;
    local_13 = _e244;
    local_14 = uint(int(5));
    uint _e249[2] = local_13;
    local_76 = _e249;
    uint _e250 = local_14;
    uint _e252 = local_76[1];
    local_76[1] = (_e252 + _e250);
    uint _e256 = local_76[0];
    local_77 = uint(_e256);
    uint _e260 = local_76[1];
    local_78 = uint(_e260);
    uint _e263 = local_78;
    out_.Store(_e263*4, asuint(_e242));
    const int _e266 = reset_sum(int(3));
    uint _e268[2] = local;
    local_15 = _e268;
    local_16 = uint(int(6));
    uint _e273[2] = local_15;
    local_79 = _e273;
    uint _e274 = local_16;
    uint _e276 = local_79[1];
    local_79[1] = (_e276 + _e274);
    uint _e280 = local_79[0];
    local_80 = uint(_e280);
    uint _e284 = local_79[1];
    local_81 = uint(_e284);
    uint _e287 = local_81;
    out_.Store(_e287*4, asuint(_e266));
    zero_flags = ZeroValuearray2_bool_();
    bool _e293 = zero_flags[int(0)];
    local_19 = _e293;
    if (_e293) {
    } else {
        bool _e297 = zero_flags[int(1)];
        local_19 = _e297;
    }
    bool _e298 = local_19;
    uint _e300[2] = local;
    local_17 = _e300;
    local_18 = uint(int(7));
    uint _e306[2] = local_17;
    local_82 = _e306;
    uint _e307 = local_18;
    uint _e309 = local_82[1];
    local_82[1] = (_e309 + _e307);
    uint _e313 = local_82[0];
    local_83 = uint(_e313);
    uint _e317 = local_82[1];
    local_84 = uint(_e317);
    uint _e320 = local_84;
    out_.Store(_e320*4, asuint(int(_e298)));
    bank = ZeroValuearray2_uint_();
    bank[int(0)] = 3u;
    bank[int(1)] = 4u;
    {
        bank_1 = ZeroValuearray2_float_();
        bank_1[int(1)] = 6.5;
        float _e339 = bank_1[int(0)];
        float _e340 = bank_1[int(1)];
        uint _e344[2] = local;
        local_20 = _e344;
        local_21 = uint(int(8));
        uint _e349[2] = local_20;
        local_85 = _e349;
        uint _e350 = local_21;
        uint _e352 = local_85[1];
        local_85[1] = (_e352 + _e350);
        uint _e356 = local_85[0];
        local_86 = uint(_e356);
        uint _e360 = local_85[1];
        local_87 = uint(_e360);
        uint _e363 = local_87;
        out_.Store(_e363*4, asuint(naga_f2i32((_e339 + _e340))));
    }
    uint _e369 = bank[int(0)];
    uint _e370 = bank[int(1)];
    uint _e374[2] = local;
    local_22 = _e374;
    local_23 = uint(int(9));
    uint _e379[2] = local_22;
    local_88 = _e379;
    uint _e380 = local_23;
    uint _e382 = local_88[1];
    local_88[1] = (_e382 + _e380);
    uint _e386 = local_88[0];
    local_89 = uint(_e386);
    uint _e390 = local_88[1];
    local_90 = uint(_e390);
    uint _e393 = local_90;
    out_.Store(_e393*4, asuint(int((_e369 + _e370))));
    {
        int _e395 = seed;
        signed_values_1[int(0)] = _e395;
        int _e399 = seed;
        signed_values_1[int(1)] = _e399;
        int _e406 = signed_values_1[int(0)];
        int _e407 = signed_values_1[int(1)];
        uint _e410[2] = local;
        local_24 = _e410;
        local_25 = uint(int(10));
        uint _e415[2] = local_24;
        local_91 = _e415;
        uint _e416 = local_25;
        uint _e418 = local_91[1];
        local_91[1] = (_e418 + _e416);
        uint _e422 = local_91[0];
        local_92 = uint(_e422);
        uint _e426 = local_91[1];
        local_93 = uint(_e426);
        uint _e429 = local_93;
        out_.Store(_e429*4, asuint(asint(asuint(_e406) + asuint(_e407))));
    }
    int _e433 = signed_values[int(0)];
    uint _e435[2] = local;
    local_26 = _e435;
    local_27 = uint(int(11));
    uint _e440[2] = local_26;
    local_94 = _e440;
    uint _e441 = local_27;
    uint _e443 = local_94[1];
    local_94[1] = (_e443 + _e441);
    uint _e447 = local_94[0];
    local_95 = uint(_e447);
    uint _e451 = local_94[1];
    local_96 = uint(_e451);
    uint _e454 = local_96;
    out_.Store(_e454*4, asuint(_e433));
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
    uint _e481[2] = local;
    local_28 = _e481;
    local_29 = uint(int(12));
    uint _e486[2] = local_28;
    local_97 = _e486;
    uint _e487 = local_29;
    uint _e489 = local_97[1];
    local_97[1] = (_e489 + _e487);
    uint _e493 = local_97[0];
    local_98 = uint(_e493);
    uint _e497 = local_97[1];
    local_99 = uint(_e497);
    uint _e500 = local_99;
    out_.Store(_e500*4, asuint(asint(asuint(asint(asuint(_e473) * asuint(int(10)))) + asuint(_e478))));
    int _e502 = seed;
    uint _e504[2] = local;
    local_30 = _e504;
    local_31 = uint(int(13));
    uint _e509[2] = local_30;
    local_100 = _e509;
    uint _e510 = local_31;
    uint _e512 = local_100[1];
    local_100[1] = (_e512 + _e510);
    uint _e516 = local_100[0];
    local_101 = uint(_e516);
    uint _e520 = local_100[1];
    local_102 = uint(_e520);
    uint _e523 = local_102;
    out_.Store(_e523*4, asuint(_e502));
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
    uint _e555[2] = local;
    local_32 = _e555;
    local_33 = uint(int(14));
    uint _e560[2] = local_32;
    local_103 = _e560;
    uint _e561 = local_33;
    uint _e563 = local_103[1];
    local_103[1] = (_e563 + _e561);
    uint _e567 = local_103[0];
    local_104 = uint(_e567);
    uint _e571 = local_103[1];
    local_105 = uint(_e571);
    uint _e574 = local_105;
    out_.Store(_e574*4, asuint(_e553));
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
    uint _e611[2] = local;
    local_34 = _e611;
    local_35 = uint(int(15));
    uint _e616[2] = local_34;
    local_106 = _e616;
    uint _e617 = local_35;
    uint _e619 = local_106[1];
    local_106[1] = (_e619 + _e617);
    uint _e623 = local_106[0];
    local_107 = uint(_e623);
    uint _e627 = local_106[1];
    local_108 = uint(_e627);
    uint _e630 = local_108;
    out_.Store(_e630*4, asuint(_e609));
    zero_samples = ZeroValuearray2_float_();
    float _e638 = zero_samples[int(0)];
    float _e639 = zero_samples[int(1)];
    uint _e643[2] = local;
    local_36 = _e643;
    local_37 = uint(int(16));
    uint _e648[2] = local_36;
    local_109 = _e648;
    uint _e649 = local_37;
    uint _e651 = local_109[1];
    local_109[1] = (_e651 + _e649);
    uint _e655 = local_109[0];
    local_110 = uint(_e655);
    uint _e659 = local_109[1];
    local_111 = uint(_e659);
    uint _e662 = local_111;
    out_.Store(_e662*4, asuint(naga_f2i32((_e638 + _e639))));
    left = ZeroValuearray2_int_();
    right = ZeroValuearray2_int_();
    left[int(0)] = int(5);
    left[int(1)] = int(7);
    right[int(0)] = int(11);
    right[int(1)] = int(13);
    int _e684 = left[int(0)];
    int _e685 = right[int(0)];
    uint _e688[2] = local;
    local_38 = _e688;
    local_39 = uint(int(17));
    uint _e693[2] = local_38;
    local_112 = _e693;
    uint _e694 = local_39;
    uint _e696 = local_112[1];
    local_112[1] = (_e696 + _e694);
    uint _e700 = local_112[0];
    local_113 = uint(_e700);
    uint _e704 = local_112[1];
    local_114 = uint(_e704);
    uint _e707 = local_114;
    out_.Store(_e707*4, asuint(asint(asuint(_e684) + asuint(_e685))));
    {
        temporary = ZeroValuearray2_int_();
        int _e711 = seed;
        temporary[int(0)] = _e711;
        {
            temporary_1 = ZeroValuearray2_int_();
            temporary_1[int(1)] = int(3);
            int _e723 = temporary_1[int(0)];
            int _e724 = temporary_1[int(1)];
            uint _e727[2] = local;
            local_40 = _e727;
            local_41 = uint(int(18));
            uint _e732[2] = local_40;
            local_115 = _e732;
            uint _e733 = local_41;
            uint _e735 = local_115[1];
            local_115[1] = (_e735 + _e733);
            uint _e739 = local_115[0];
            local_116 = uint(_e739);
            uint _e743 = local_115[1];
            local_117 = uint(_e743);
            uint _e746 = local_117;
            out_.Store(_e746*4, asuint(asint(asuint(_e723) + asuint(_e724))));
        }
        int _e750 = temporary[int(0)];
        uint _e752[2] = local;
        local_42 = _e752;
        local_43 = uint(int(19));
        uint _e757[2] = local_42;
        local_118 = _e757;
        uint _e758 = local_43;
        uint _e760 = local_118[1];
        local_118[1] = (_e760 + _e758);
        uint _e764 = local_118[0];
        local_119 = uint(_e764);
        uint _e768 = local_118[1];
        local_120 = uint(_e768);
        uint _e771 = local_120;
        out_.Store(_e771*4, asuint(_e750));
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
        local_46 = _e794;
    } else {
        int _e796 = index;
        index = asint(asuint(_e796) + asuint(int(1)));
        int _e800 = right[min(uint(_e796), 1u)];
        right[min(uint(_e796), 1u)] = asint(asuint(_e800) + asuint(_e786));
        int _e802 = right[min(uint(_e796), 1u)];
        local_46 = _e802;
    }
    int _e805 = local_46;
    uint _e807[2] = local;
    local_44 = _e807;
    local_45 = uint(int(20));
    uint _e812[2] = local_44;
    local_121 = _e812;
    uint _e813 = local_45;
    uint _e815 = local_121[1];
    local_121[1] = (_e815 + _e813);
    uint _e819 = local_121[0];
    local_122 = uint(_e819);
    uint _e823 = local_121[1];
    local_123 = uint(_e823);
    uint _e826 = local_123;
    out_.Store(_e826*4, asuint(_e805));
    int _e828 = index;
    uint _e830[2] = local;
    local_47 = _e830;
    local_48 = uint(int(21));
    uint _e835[2] = local_47;
    local_124 = _e835;
    uint _e836 = local_48;
    uint _e838 = local_124[1];
    local_124[1] = (_e838 + _e836);
    uint _e842 = local_124[0];
    local_125 = uint(_e842);
    uint _e846 = local_124[1];
    local_126 = uint(_e846);
    uint _e849 = local_126;
    out_.Store(_e849*4, asuint(_e828));
    int _e853 = left[int(0)];
    int _e858 = right[int(0)];
    uint _e861[2] = local;
    local_49 = _e861;
    local_50 = uint(int(22));
    uint _e866[2] = local_49;
    local_127 = _e866;
    uint _e867 = local_50;
    uint _e869 = local_127[1];
    local_127[1] = (_e869 + _e867);
    uint _e873 = local_127[0];
    local_128 = uint(_e873);
    uint _e877 = local_127[1];
    local_129 = uint(_e877);
    uint _e880 = local_129;
    out_.Store(_e880*4, asuint(asint(asuint(asint(asuint(_e853) * asuint(int(100)))) + asuint(_e858))));
    bool _e882 = choose;
    if (_e882) {
        right[int(1)] = int(9);
        int _e886 = right[int(1)];
        right[int(1)] = asint(asuint(_e886) + asuint(int(1)));
        local_53 = _e886;
    } else {
        left[int(1)] = int(9);
        int _e893 = left[int(1)];
        left[int(1)] = asint(asuint(_e893) + asuint(int(1)));
        local_53 = _e893;
    }
    int _e898 = local_53;
    uint _e900[2] = local;
    local_51 = _e900;
    local_52 = uint(int(23));
    uint _e905[2] = local_51;
    local_130 = _e905;
    uint _e906 = local_52;
    uint _e908 = local_130[1];
    local_130[1] = (_e908 + _e906);
    uint _e912 = local_130[0];
    local_131 = uint(_e912);
    uint _e916 = local_130[1];
    local_132 = uint(_e916);
    uint _e919 = local_132;
    out_.Store(_e919*4, asuint(_e898));
    int _e923 = left[int(1)];
    int _e928 = right[int(1)];
    uint _e931[2] = local;
    local_54 = _e931;
    local_55 = uint(int(24));
    uint _e936[2] = local_54;
    local_133 = _e936;
    uint _e937 = local_55;
    uint _e939 = local_133[1];
    local_133[1] = (_e939 + _e937);
    uint _e943 = local_133[0];
    local_134 = uint(_e943);
    uint _e947 = local_133[1];
    local_135 = uint(_e947);
    uint _e950 = local_135;
    out_.Store(_e950*4, asuint(asint(asuint(asint(asuint(_e923) * asuint(int(100)))) + asuint(_e928))));
}
