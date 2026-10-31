RWByteAddressBuffer out_ : register(u0);

int case_chain(int selector)
{
    int selector_1 = (int)0;
    int result = (int)0;

    selector_1 = selector;
    result = int(0);
    int _e4 = selector_1;
    switch(_e4) {
        case -1: {
            {
                int _e6 = result;
                result = asint(asuint(_e6) + asuint(int(1)));
            }
            {
                int _e9 = result;
                result = asint(asuint(_e9) + asuint(int(10)));
            }
            {
                int _e12 = result;
                result = asint(asuint(_e12) + asuint(int(100)));
                break;
            }
        }
        case 0: {
            {
                int _e9 = result;
                result = asint(asuint(_e9) + asuint(int(10)));
            }
            {
                int _e12 = result;
                result = asint(asuint(_e12) + asuint(int(100)));
                break;
            }
        }
        case 1: {
            int _e12 = result;
            result = asint(asuint(_e12) + asuint(int(100)));
            break;
        }
        default: {
            {
                int _e15 = result;
                result = asint(asuint(_e15) + asuint(int(1000)));
            }
            {
                int _e18 = result;
                result = asint(asuint(_e18) + asuint(int(10000)));
                break;
            }
        }
        case 2: {
            int _e18 = result;
            result = asint(asuint(_e18) + asuint(int(10000)));
            break;
        }
    }
    int _e20 = result;
    return _e20;
}

int grouped_labels(uint selector_2)
{
    uint selector_3 = (uint)0;
    int result_1 = (int)0;

    selector_3 = selector_2;
    result_1 = int(0);
    uint _e4 = selector_3;
    switch(_e4) {
        case 0u:
        case 1u: {
            {
                int _e6 = result_1;
                result_1 = asint(asuint(_e6) + asuint(int(3)));
            }
            {
                int _e9 = result_1;
                result_1 = asint(asuint(_e9) + asuint(int(5)));
                break;
            }
        }
        case 2u: {
            int _e9 = result_1;
            result_1 = asint(asuint(_e9) + asuint(int(5)));
            break;
        }
        default: {
            result_1 = int(7);
            break;
        }
    }
    int _e12 = result_1;
    return _e12;
}

int nested_switches(int outer, int inner)
{
    int outer_1 = (int)0;
    int inner_1 = (int)0;
    int result_2 = (int)0;

    outer_1 = outer;
    inner_1 = inner;
    result_2 = int(0);
    int _e6 = outer_1;
    switch(_e6) {
        case 0: {
            {
                int _e8 = result_2;
                result_2 = asint(asuint(_e8) + asuint(int(1)));
                int _e10 = inner_1;
                switch(_e10) {
                    case 0: {
                        {
                            int _e12 = result_2;
                            result_2 = asint(asuint(_e12) + asuint(int(10)));
                        }
                        {
                            int _e15 = result_2;
                            result_2 = asint(asuint(_e15) + asuint(int(20)));
                            break;
                        }
                    }
                    default: {
                        int _e15 = result_2;
                        result_2 = asint(asuint(_e15) + asuint(int(20)));
                        break;
                    }
                }
            }
            {
                int _e18 = result_2;
                result_2 = asint(asuint(_e18) + asuint(int(100)));
                break;
            }
        }
        case 1: {
            int _e18 = result_2;
            result_2 = asint(asuint(_e18) + asuint(int(100)));
            break;
        }
        default: {
            result_2 = int(900);
            break;
        }
    }
    int _e21 = result_2;
    return _e21;
}

int loop_jumps(int selector_4)
{
    int selector_5 = (int)0;
    int result_3 = (int)0;
    int iteration = (int)0;

    selector_5 = selector_4;
    result_3 = int(0);
    {
        iteration = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e9 = iteration;
                iteration = asint(asuint(_e9) + asuint(int(1)));
            }
            loop_init = false;
            int _e7 = iteration;
            if ((_e7 < int(4))) {
            } else {
                break;
            }
            int _e12 = selector_5;
            bool should_continue = false;
            switch(_e12) {
                case 0: {
                    {
                        int _e14 = iteration;
                        if ((_e14 == int(1))) {
                            should_continue = true;
                            break;
                        }
                        int _e17 = iteration;
                        int _e19 = result_3;
                        result_3 = asint(asuint(_e19) + asuint(asint(asuint(_e17) + asuint(int(1)))));
                    }
                    {
                        int _e22 = iteration;
                        if ((_e22 == int(2))) {
                            break;
                        }
                        int _e25 = result_3;
                        result_3 = asint(asuint(_e25) + asuint(int(10)));
                        break;
                    }
                }
                case 1: {
                    int _e22 = iteration;
                    if ((_e22 == int(2))) {
                        break;
                    }
                    int _e25 = result_3;
                    result_3 = asint(asuint(_e25) + asuint(int(10)));
                    break;
                }
                default: {
                    int _e28 = result_3;
                    result_3 = asint(asuint(_e28) + asuint(int(100)));
                    should_continue = true;
                    break;
                }
            }
            if (should_continue) {
                continue;
            }
            int _e31 = result_3;
            result_3 = asint(asuint(_e31) + asuint(int(1000)));
        }
    }
    int _e33 = result_3;
    return _e33;
}

int terminal_paths(int selector_6, int flag)
{
    int selector_7 = (int)0;
    int flag_1 = (int)0;
    int result_4 = (int)0;

    selector_7 = selector_6;
    flag_1 = flag;
    result_4 = int(0);
    int _e6 = selector_7;
    switch(_e6) {
        case 0: {
            {
                int _e8 = flag_1;
                if ((_e8 != int(0))) {
                    return int(3);
                }
                int _e12 = result_4;
                result_4 = asint(asuint(_e12) + asuint(int(1)));
            }
            {
                int _e15 = result_4;
                return asint(asuint(_e15) + asuint(int(5)));
            }
        }
        case 1: {
            int _e15 = result_4;
            return asint(asuint(_e15) + asuint(int(5)));
        }
        default: {
            {
                result_4 = int(9);
            }
            {
                {
                    int _e19 = result_4;
                    return asint(asuint(_e19) + asuint(int(10)));
                }
            }
            break;
        }
        case 2: {
            {
                int _e19 = result_4;
                return asint(asuint(_e19) + asuint(int(10)));
            }
            break;
        }
    }
}

int update_value(int value, int token)
{
    int value_1 = (int)0;
    int token_1 = (int)0;

    value_1 = value;
    token_1 = token;
    int _e4 = value_1;
    int _e5 = token_1;
    return asint(asuint(_e4) + asuint(_e5));
}

int2 call_results(int selector_8, int counter_1)
{
    int selector_9 = (int)0;
    int counter_2 = (int)0;
    int result_5 = (int)0;
    int named_value = (int)0;
    int named_value_1 = (int)0;
    int named_value_2 = (int)0;

    selector_9 = selector_8;
    counter_2 = counter_1;
    result_5 = int(2);
    int _e6 = selector_9;
    switch(_e6) {
        case 0: {
            {
                {
                    int _e8 = result_5;
                    int _e9 = counter_2;
                    counter_2 = asint(asuint(_e9) + asuint(int(1)));
                    int _e12 = counter_2;
                    const int _e13 = update_value(_e8, _e12);
                    named_value = _e13;
                    int _e14 = named_value;
                    int _e15 = named_value;
                    result_5 = asint(asuint(_e14) + asuint(_e15));
                }
            }
            {
                {
                    int _e18 = result_5;
                    int _e19 = counter_2;
                    counter_2 = asint(asuint(_e19) + asuint(int(1)));
                    int _e22 = counter_2;
                    const int _e23 = update_value(_e18, _e22);
                    named_value_1 = _e23;
                    int _e24 = named_value_1;
                    int _e25 = named_value_1;
                    result_5 = asint(asuint(_e24) * asuint(_e25));
                }
            }
            {
                {
                    int _e28 = result_5;
                    int _e29 = counter_2;
                    counter_2 = asint(asuint(_e29) + asuint(int(1)));
                    int _e32 = counter_2;
                    const int _e33 = update_value(_e28, _e32);
                    named_value_2 = _e33;
                    int _e34 = named_value_2;
                    int _e35 = named_value_2;
                    result_5 = asint(asuint(_e34) + asuint(_e35));
                    break;
                }
            }
            break;
        }
        case 1: {
            {
                {
                    int _e18 = result_5;
                    int _e19 = counter_2;
                    counter_2 = asint(asuint(_e19) + asuint(int(1)));
                    int _e22 = counter_2;
                    const int _e23 = update_value(_e18, _e22);
                    named_value_1 = _e23;
                    int _e24 = named_value_1;
                    int _e25 = named_value_1;
                    result_5 = asint(asuint(_e24) * asuint(_e25));
                }
            }
            {
                {
                    int _e28 = result_5;
                    int _e29 = counter_2;
                    counter_2 = asint(asuint(_e29) + asuint(int(1)));
                    int _e32 = counter_2;
                    const int _e33 = update_value(_e28, _e32);
                    named_value_2 = _e33;
                    int _e34 = named_value_2;
                    int _e35 = named_value_2;
                    result_5 = asint(asuint(_e34) + asuint(_e35));
                    break;
                }
            }
            break;
        }
        default: {
            {
                int _e28 = result_5;
                int _e29 = counter_2;
                counter_2 = asint(asuint(_e29) + asuint(int(1)));
                int _e32 = counter_2;
                const int _e33 = update_value(_e28, _e32);
                named_value_2 = _e33;
                int _e34 = named_value_2;
                int _e35 = named_value_2;
                result_5 = asint(asuint(_e34) + asuint(_e35));
                break;
            }
            break;
        }
    }
    int _e37 = result_5;
    int _e38 = counter_2;
    return int2(_e37, _e38);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(1, 1, 1)]
void switches()
{
    uint local[2] = (uint[2])0;
    uint local_1[2] = (uint[2])0;
    uint local_2 = (uint)0;
    uint local_3[2] = (uint[2])0;
    uint local_4 = (uint)0;
    uint local_5[2] = (uint[2])0;
    uint local_6 = (uint)0;
    uint local_7[2] = (uint[2])0;
    uint local_8 = (uint)0;
    uint local_9[2] = (uint[2])0;
    uint local_10 = (uint)0;
    uint local_11[2] = (uint[2])0;
    uint local_12 = (uint)0;
    uint local_13[2] = (uint[2])0;
    uint local_14 = (uint)0;
    uint local_15[2] = (uint[2])0;
    uint local_16 = (uint)0;
    uint local_17[2] = (uint[2])0;
    uint local_18 = (uint)0;
    uint local_19[2] = (uint[2])0;
    uint local_20 = (uint)0;
    uint local_21[2] = (uint[2])0;
    uint local_22 = (uint)0;
    uint local_23[2] = (uint[2])0;
    uint local_24 = (uint)0;
    uint local_25[2] = (uint[2])0;
    uint local_26 = (uint)0;
    uint local_27[2] = (uint[2])0;
    uint local_28 = (uint)0;
    uint local_29[2] = (uint[2])0;
    uint local_30 = (uint)0;
    uint local_31[2] = (uint[2])0;
    uint local_32 = (uint)0;
    uint local_33[2] = (uint[2])0;
    uint local_34 = (uint)0;
    uint local_35[2] = (uint[2])0;
    uint local_36 = (uint)0;
    uint local_37[2] = (uint[2])0;
    uint local_38 = (uint)0;
    uint local_39[2] = (uint[2])0;
    uint local_40 = (uint)0;
    uint local_41[2] = (uint[2])0;
    uint local_42 = (uint)0;
    int counter = (int)0;
    uint local_43[2] = (uint[2])0;
    uint local_44 = (uint)0;
    uint local_45[2] = (uint[2])0;
    uint local_46 = (uint)0;
    uint local_47[2] = (uint[2])0;
    uint local_48 = (uint)0;
    uint local_49[2] = (uint[2])0;
    uint local_50 = (uint)0;
    int2 first = (int2)0;
    int2 second = (int2)0;
    int2 third = (int2)0;
    uint local_51[2] = (uint[2])0;
    uint local_52 = (uint)0;
    uint local_53[2] = (uint[2])0;
    uint local_54 = (uint)0;
    uint local_55[2] = (uint[2])0;
    uint local_56 = (uint)0;
    uint local_57[2] = (uint[2])0;
    uint local_58 = (uint)0;
    uint local_59[2] = (uint[2])0;
    uint local_60 = (uint)0;
    uint local_61[2] = (uint[2])0;
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
    uint local_135[2] = (uint[2])0;
    uint local_136 = (uint)0;
    uint local_137 = (uint)0;
    uint local_138[2] = (uint[2])0;
    uint local_139 = (uint)0;
    uint local_140 = (uint)0;
    uint local_141[2] = (uint[2])0;
    uint local_142 = (uint)0;
    uint local_143 = (uint)0;
    uint local_144[2] = (uint[2])0;
    uint local_145 = (uint)0;
    uint local_146 = (uint)0;
    uint local_147[2] = (uint[2])0;
    uint local_148 = (uint)0;
    uint local_149 = (uint)0;
    uint local_150[2] = (uint[2])0;
    uint local_151 = (uint)0;
    uint local_152 = (uint)0;
    uint local_153[2] = (uint[2])0;
    uint local_154 = (uint)0;
    uint local_155 = (uint)0;
    uint local_156[2] = (uint[2])0;
    uint local_157 = (uint)0;
    uint local_158 = (uint)0;

    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
    const int _e9 = case_chain(naga_neg(int(1)));
    uint _e12[2] = local;
    local_1 = _e12;
    local_2 = uint(int(0));
    uint _e17[2] = local_1;
    local_63 = _e17;
    uint _e18 = local_2;
    uint _e20 = local_63[1];
    local_63[1] = (_e20 + _e18);
    uint _e24 = local_63[0];
    local_64 = uint(_e24);
    uint _e28 = local_63[1];
    local_65 = uint(_e28);
    uint _e31 = local_65;
    out_.Store(_e31*4, asuint(_e9));
    const int _e34 = case_chain(int(0));
    uint _e36[2] = local;
    local_3 = _e36;
    local_4 = uint(int(1));
    uint _e41[2] = local_3;
    local_66 = _e41;
    uint _e42 = local_4;
    uint _e44 = local_66[1];
    local_66[1] = (_e44 + _e42);
    uint _e48 = local_66[0];
    local_67 = uint(_e48);
    uint _e52 = local_66[1];
    local_68 = uint(_e52);
    uint _e55 = local_68;
    out_.Store(_e55*4, asuint(_e34));
    const int _e58 = case_chain(int(1));
    uint _e60[2] = local;
    local_5 = _e60;
    local_6 = uint(int(2));
    uint _e65[2] = local_5;
    local_69 = _e65;
    uint _e66 = local_6;
    uint _e68 = local_69[1];
    local_69[1] = (_e68 + _e66);
    uint _e72 = local_69[0];
    local_70 = uint(_e72);
    uint _e76 = local_69[1];
    local_71 = uint(_e76);
    uint _e79 = local_71;
    out_.Store(_e79*4, asuint(_e58));
    const int _e82 = case_chain(int(2));
    uint _e84[2] = local;
    local_7 = _e84;
    local_8 = uint(int(3));
    uint _e89[2] = local_7;
    local_72 = _e89;
    uint _e90 = local_8;
    uint _e92 = local_72[1];
    local_72[1] = (_e92 + _e90);
    uint _e96 = local_72[0];
    local_73 = uint(_e96);
    uint _e100 = local_72[1];
    local_74 = uint(_e100);
    uint _e103 = local_74;
    out_.Store(_e103*4, asuint(_e82));
    const int _e106 = case_chain(int(8));
    uint _e108[2] = local;
    local_9 = _e108;
    local_10 = uint(int(4));
    uint _e113[2] = local_9;
    local_75 = _e113;
    uint _e114 = local_10;
    uint _e116 = local_75[1];
    local_75[1] = (_e116 + _e114);
    uint _e120 = local_75[0];
    local_76 = uint(_e120);
    uint _e124 = local_75[1];
    local_77 = uint(_e124);
    uint _e127 = local_77;
    out_.Store(_e127*4, asuint(_e106));
    const int _e130 = grouped_labels(0u);
    uint _e132[2] = local;
    local_11 = _e132;
    local_12 = uint(int(5));
    uint _e137[2] = local_11;
    local_78 = _e137;
    uint _e138 = local_12;
    uint _e140 = local_78[1];
    local_78[1] = (_e140 + _e138);
    uint _e144 = local_78[0];
    local_79 = uint(_e144);
    uint _e148 = local_78[1];
    local_80 = uint(_e148);
    uint _e151 = local_80;
    out_.Store(_e151*4, asuint(_e130));
    const int _e154 = grouped_labels(1u);
    uint _e156[2] = local;
    local_13 = _e156;
    local_14 = uint(int(6));
    uint _e161[2] = local_13;
    local_81 = _e161;
    uint _e162 = local_14;
    uint _e164 = local_81[1];
    local_81[1] = (_e164 + _e162);
    uint _e168 = local_81[0];
    local_82 = uint(_e168);
    uint _e172 = local_81[1];
    local_83 = uint(_e172);
    uint _e175 = local_83;
    out_.Store(_e175*4, asuint(_e154));
    const int _e178 = grouped_labels(2u);
    uint _e180[2] = local;
    local_15 = _e180;
    local_16 = uint(int(7));
    uint _e185[2] = local_15;
    local_84 = _e185;
    uint _e186 = local_16;
    uint _e188 = local_84[1];
    local_84[1] = (_e188 + _e186);
    uint _e192 = local_84[0];
    local_85 = uint(_e192);
    uint _e196 = local_84[1];
    local_86 = uint(_e196);
    uint _e199 = local_86;
    out_.Store(_e199*4, asuint(_e178));
    const int _e202 = grouped_labels(8u);
    uint _e204[2] = local;
    local_17 = _e204;
    local_18 = uint(int(8));
    uint _e209[2] = local_17;
    local_87 = _e209;
    uint _e210 = local_18;
    uint _e212 = local_87[1];
    local_87[1] = (_e212 + _e210);
    uint _e216 = local_87[0];
    local_88 = uint(_e216);
    uint _e220 = local_87[1];
    local_89 = uint(_e220);
    uint _e223 = local_89;
    out_.Store(_e223*4, asuint(_e202));
    const int _e227 = nested_switches(int(0), int(0));
    uint _e229[2] = local;
    local_19 = _e229;
    local_20 = uint(int(9));
    uint _e234[2] = local_19;
    local_90 = _e234;
    uint _e235 = local_20;
    uint _e237 = local_90[1];
    local_90[1] = (_e237 + _e235);
    uint _e241 = local_90[0];
    local_91 = uint(_e241);
    uint _e245 = local_90[1];
    local_92 = uint(_e245);
    uint _e248 = local_92;
    out_.Store(_e248*4, asuint(_e227));
    const int _e252 = nested_switches(int(0), int(8));
    uint _e254[2] = local;
    local_21 = _e254;
    local_22 = uint(int(10));
    uint _e259[2] = local_21;
    local_93 = _e259;
    uint _e260 = local_22;
    uint _e262 = local_93[1];
    local_93[1] = (_e262 + _e260);
    uint _e266 = local_93[0];
    local_94 = uint(_e266);
    uint _e270 = local_93[1];
    local_95 = uint(_e270);
    uint _e273 = local_95;
    out_.Store(_e273*4, asuint(_e252));
    const int _e277 = nested_switches(int(1), int(0));
    uint _e279[2] = local;
    local_23 = _e279;
    local_24 = uint(int(11));
    uint _e284[2] = local_23;
    local_96 = _e284;
    uint _e285 = local_24;
    uint _e287 = local_96[1];
    local_96[1] = (_e287 + _e285);
    uint _e291 = local_96[0];
    local_97 = uint(_e291);
    uint _e295 = local_96[1];
    local_98 = uint(_e295);
    uint _e298 = local_98;
    out_.Store(_e298*4, asuint(_e277));
    const int _e302 = nested_switches(int(8), int(0));
    uint _e304[2] = local;
    local_25 = _e304;
    local_26 = uint(int(12));
    uint _e309[2] = local_25;
    local_99 = _e309;
    uint _e310 = local_26;
    uint _e312 = local_99[1];
    local_99[1] = (_e312 + _e310);
    uint _e316 = local_99[0];
    local_100 = uint(_e316);
    uint _e320 = local_99[1];
    local_101 = uint(_e320);
    uint _e323 = local_101;
    out_.Store(_e323*4, asuint(_e302));
    const int _e326 = loop_jumps(int(0));
    uint _e328[2] = local;
    local_27 = _e328;
    local_28 = uint(int(13));
    uint _e333[2] = local_27;
    local_102 = _e333;
    uint _e334 = local_28;
    uint _e336 = local_102[1];
    local_102[1] = (_e336 + _e334);
    uint _e340 = local_102[0];
    local_103 = uint(_e340);
    uint _e344 = local_102[1];
    local_104 = uint(_e344);
    uint _e347 = local_104;
    out_.Store(_e347*4, asuint(_e326));
    const int _e350 = loop_jumps(int(1));
    uint _e352[2] = local;
    local_29 = _e352;
    local_30 = uint(int(14));
    uint _e357[2] = local_29;
    local_105 = _e357;
    uint _e358 = local_30;
    uint _e360 = local_105[1];
    local_105[1] = (_e360 + _e358);
    uint _e364 = local_105[0];
    local_106 = uint(_e364);
    uint _e368 = local_105[1];
    local_107 = uint(_e368);
    uint _e371 = local_107;
    out_.Store(_e371*4, asuint(_e350));
    const int _e374 = loop_jumps(int(8));
    uint _e376[2] = local;
    local_31 = _e376;
    local_32 = uint(int(15));
    uint _e381[2] = local_31;
    local_108 = _e381;
    uint _e382 = local_32;
    uint _e384 = local_108[1];
    local_108[1] = (_e384 + _e382);
    uint _e388 = local_108[0];
    local_109 = uint(_e388);
    uint _e392 = local_108[1];
    local_110 = uint(_e392);
    uint _e395 = local_110;
    out_.Store(_e395*4, asuint(_e374));
    const int _e399 = terminal_paths(int(0), int(1));
    uint _e401[2] = local;
    local_33 = _e401;
    local_34 = uint(int(16));
    uint _e406[2] = local_33;
    local_111 = _e406;
    uint _e407 = local_34;
    uint _e409 = local_111[1];
    local_111[1] = (_e409 + _e407);
    uint _e413 = local_111[0];
    local_112 = uint(_e413);
    uint _e417 = local_111[1];
    local_113 = uint(_e417);
    uint _e420 = local_113;
    out_.Store(_e420*4, asuint(_e399));
    const int _e424 = terminal_paths(int(0), int(0));
    uint _e426[2] = local;
    local_35 = _e426;
    local_36 = uint(int(17));
    uint _e431[2] = local_35;
    local_114 = _e431;
    uint _e432 = local_36;
    uint _e434 = local_114[1];
    local_114[1] = (_e434 + _e432);
    uint _e438 = local_114[0];
    local_115 = uint(_e438);
    uint _e442 = local_114[1];
    local_116 = uint(_e442);
    uint _e445 = local_116;
    out_.Store(_e445*4, asuint(_e424));
    const int _e449 = terminal_paths(int(1), int(1));
    uint _e451[2] = local;
    local_37 = _e451;
    local_38 = uint(int(18));
    uint _e456[2] = local_37;
    local_117 = _e456;
    uint _e457 = local_38;
    uint _e459 = local_117[1];
    local_117[1] = (_e459 + _e457);
    uint _e463 = local_117[0];
    local_118 = uint(_e463);
    uint _e467 = local_117[1];
    local_119 = uint(_e467);
    uint _e470 = local_119;
    out_.Store(_e470*4, asuint(_e449));
    const int _e474 = terminal_paths(int(8), int(0));
    uint _e476[2] = local;
    local_39 = _e476;
    local_40 = uint(int(19));
    uint _e481[2] = local_39;
    local_120 = _e481;
    uint _e482 = local_40;
    uint _e484 = local_120[1];
    local_120[1] = (_e484 + _e482);
    uint _e488 = local_120[0];
    local_121 = uint(_e488);
    uint _e492 = local_120[1];
    local_122 = uint(_e492);
    uint _e495 = local_122;
    out_.Store(_e495*4, asuint(_e474));
    const int _e499 = terminal_paths(int(2), int(0));
    uint _e501[2] = local;
    local_41 = _e501;
    local_42 = uint(int(20));
    uint _e506[2] = local_41;
    local_123 = _e506;
    uint _e507 = local_42;
    uint _e509 = local_123[1];
    local_123[1] = (_e509 + _e507);
    uint _e513 = local_123[0];
    local_124 = uint(_e513);
    uint _e517 = local_123[1];
    local_125 = uint(_e517);
    uint _e520 = local_125;
    out_.Store(_e520*4, asuint(_e499));
    counter = int(0);
    int _e524 = counter;
    counter = asint(asuint(_e524) + asuint(int(1)));
    switch(_e524) {
        case 0: {
            int _e527 = counter;
            uint _e529[2] = local;
            local_43 = _e529;
            local_44 = uint(int(21));
            uint _e534[2] = local_43;
            local_126 = _e534;
            uint _e535 = local_44;
            uint _e537 = local_126[1];
            local_126[1] = (_e537 + _e535);
            uint _e541 = local_126[0];
            local_127 = uint(_e541);
            uint _e545 = local_126[1];
            local_128 = uint(_e545);
            uint _e548 = local_128;
            out_.Store(_e548*4, asuint(_e527));
            int _e550 = counter;
            uint _e554[2] = local;
            local_45 = _e554;
            local_46 = uint(int(22));
            uint _e559[2] = local_45;
            local_129 = _e559;
            uint _e560 = local_46;
            uint _e562 = local_129[1];
            local_129[1] = (_e562 + _e560);
            uint _e566 = local_129[0];
            local_130 = uint(_e566);
            uint _e570 = local_129[1];
            local_131 = uint(_e570);
            uint _e573 = local_131;
            out_.Store(_e573*4, asuint(asint(asuint(_e550) + asuint(int(1)))));
            break;
        }
        case 1: {
            int _e575 = counter;
            uint _e579[2] = local;
            local_45 = _e579;
            local_46 = uint(int(22));
            uint _e584[2] = local_45;
            local_132 = _e584;
            uint _e585 = local_46;
            uint _e587 = local_132[1];
            local_132[1] = (_e587 + _e585);
            uint _e591 = local_132[0];
            local_133 = uint(_e591);
            uint _e595 = local_132[1];
            local_134 = uint(_e595);
            uint _e598 = local_134;
            out_.Store(_e598*4, asuint(asint(asuint(_e575) + asuint(int(1)))));
            break;
        }
        default: {
            uint _e601[2] = local;
            local_47 = _e601;
            local_48 = uint(int(21));
            uint _e606[2] = local_47;
            local_135 = _e606;
            uint _e607 = local_48;
            uint _e609 = local_135[1];
            local_135[1] = (_e609 + _e607);
            uint _e613 = local_135[0];
            local_136 = uint(_e613);
            uint _e617 = local_135[1];
            local_137 = uint(_e617);
            uint _e621 = local_137;
            out_.Store(_e621*4, asuint(int(99)));
            break;
        }
    }
    int _e623 = counter;
    uint _e625[2] = local;
    local_49 = _e625;
    local_50 = uint(int(23));
    uint _e630[2] = local_49;
    local_138 = _e630;
    uint _e631 = local_50;
    uint _e633 = local_138[1];
    local_138[1] = (_e633 + _e631);
    uint _e637 = local_138[0];
    local_139 = uint(_e637);
    uint _e641 = local_138[1];
    local_140 = uint(_e641);
    uint _e644 = local_140;
    out_.Store(_e644*4, asuint(_e623));
    const int2 _e648 = call_results(int(0), int(0));
    first = _e648;
    int _e651 = first.y;
    const int2 _e653 = call_results(int(1), _e651);
    second = _e653;
    int _e656 = second.y;
    const int2 _e658 = call_results(int(8), _e656);
    third = _e658;
    int _e661 = first.x;
    uint _e663[2] = local;
    local_51 = _e663;
    local_52 = uint(int(24));
    uint _e668[2] = local_51;
    local_141 = _e668;
    uint _e669 = local_52;
    uint _e671 = local_141[1];
    local_141[1] = (_e671 + _e669);
    uint _e675 = local_141[0];
    local_142 = uint(_e675);
    uint _e679 = local_141[1];
    local_143 = uint(_e679);
    uint _e682 = local_143;
    out_.Store(_e682*4, asuint(_e661));
    int _e685 = second.x;
    uint _e687[2] = local;
    local_53 = _e687;
    local_54 = uint(int(25));
    uint _e692[2] = local_53;
    local_144 = _e692;
    uint _e693 = local_54;
    uint _e695 = local_144[1];
    local_144[1] = (_e695 + _e693);
    uint _e699 = local_144[0];
    local_145 = uint(_e699);
    uint _e703 = local_144[1];
    local_146 = uint(_e703);
    uint _e706 = local_146;
    out_.Store(_e706*4, asuint(_e685));
    int _e709 = third.x;
    uint _e711[2] = local;
    local_55 = _e711;
    local_56 = uint(int(26));
    uint _e716[2] = local_55;
    local_147 = _e716;
    uint _e717 = local_56;
    uint _e719 = local_147[1];
    local_147[1] = (_e719 + _e717);
    uint _e723 = local_147[0];
    local_148 = uint(_e723);
    uint _e727 = local_147[1];
    local_149 = uint(_e727);
    uint _e730 = local_149;
    out_.Store(_e730*4, asuint(_e709));
    int _e733 = third.y;
    uint _e735[2] = local;
    local_57 = _e735;
    local_58 = uint(int(27));
    uint _e740[2] = local_57;
    local_150 = _e740;
    uint _e741 = local_58;
    uint _e743 = local_150[1];
    local_150[1] = (_e743 + _e741);
    uint _e747 = local_150[0];
    local_151 = uint(_e747);
    uint _e751 = local_150[1];
    local_152 = uint(_e751);
    uint _e754 = local_152;
    out_.Store(_e754*4, asuint(_e733));
    int _e757 = third.y;
    counter = _e757;
    int _e759 = third.x;
    int _e760 = counter;
    counter = asint(asuint(_e760) + asuint(int(1)));
    int _e763 = counter;
    const int _e764 = update_value(_e759, _e763);
    uint _e766[2] = local;
    local_59 = _e766;
    local_60 = uint(int(28));
    uint _e771[2] = local_59;
    local_153 = _e771;
    uint _e772 = local_60;
    uint _e774 = local_153[1];
    local_153[1] = (_e774 + _e772);
    uint _e778 = local_153[0];
    local_154 = uint(_e778);
    uint _e782 = local_153[1];
    local_155 = uint(_e782);
    uint _e785 = local_155;
    out_.Store(_e785*4, asuint(_e764));
    int _e787 = counter;
    uint _e789[2] = local;
    local_61 = _e789;
    local_62 = uint(int(29));
    uint _e794[2] = local_61;
    local_156 = _e794;
    uint _e795 = local_62;
    uint _e797 = local_156[1];
    local_156[1] = (_e797 + _e795);
    uint _e801 = local_156[0];
    local_157 = uint(_e801);
    uint _e805 = local_156[1];
    local_158 = uint(_e805);
    uint _e808 = local_158;
    out_.Store(_e808*4, asuint(_e787));
}
