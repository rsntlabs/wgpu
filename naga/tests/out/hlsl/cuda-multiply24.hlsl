RWByteAddressBuffer out_1 : register(u0);

int naga_extractBits(
    int e,
    uint offset,
    uint count
) {
    uint w = 32;
    uint o = min(offset, w);
    uint c = min(count, w - o);
    return (c == 0 ? 0 : (e << (w - c - o)) >> (w - c));
}
int naga_f2i32(float value) {
    return int(clamp(value, -2147483600.0, 2147483500.0));
}

int signed_conversion(float first_1, float second_1)
{
    return asint((asuint(naga_extractBits(naga_f2i32(first_1), 0u, 24u)) * asuint(naga_extractBits(naga_f2i32(second_1), 0u, 24u))));
}

uint naga_extractBits(
    uint e,
    uint offset,
    uint count
) {
    uint w = 32;
    uint o = min(offset, w);
    uint c = min(count, w - o);
    return (c == 0 ? 0 : (e << (w - c - o)) >> (w - c));
}
uint naga_f2u32(float value) {
    return uint(clamp(value, 0.0, 4294967000.0));
}

uint unsigned_conversion(float first_2, float second_2)
{
    return (naga_extractBits(naga_f2u32(first_2), 0u, 24u) * naga_extractBits(naga_f2u32(second_2), 0u, 24u));
}

int _mul24_(bool first_3, bool second_3)
{
    int local_162 = (int)0;
    int local_163 = (int)0;

    if (first_3) {
        if (second_3) {
            local_162 = int(71);
        } else {
            local_162 = int(73);
        }
        int _e7 = local_162;
        local_163 = _e7;
    } else {
        local_163 = int(79);
    }
    int _e12 = local_163;
    return _e12;
}

int _mul24_1(float first_4, float second_4)
{
    return naga_f2i32(((first_4 * 10.0) + second_4));
}

uint _umul24_(int first_5, int second_5)
{
    return uint(asint(asuint(asint(asuint(first_5) + asuint(second_5))) + asuint(int(100))));
}

int signed_pair(int first_6, int second_6)
{
    return asint((asuint(naga_extractBits(first_6, 0u, 24u)) * asuint(naga_extractBits(second_6, 0u, 24u))));
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

typedef int ret_ZeroValuearray2_int_[2];
ret_ZeroValuearray2_int_ ZeroValuearray2_int_() {
    return (int[2])0;
}

[numthreads(1, 1, 1)]
void multiply24_()
{
    uint out_[2] = (uint[2])0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    uint local_2[2] = (uint[2])0;
    uint local_3 = (uint)0;
    uint local_4[2] = (uint[2])0;
    uint local_5 = (uint)0;
    uint local_6[2] = (uint[2])0;
    uint local_7 = (uint)0;
    uint local_8[2] = (uint[2])0;
    uint local_9 = (uint)0;
    uint local_10[2] = (uint[2])0;
    uint local_11 = (uint)0;
    uint local_12[2] = (uint[2])0;
    uint local_13 = (uint)0;
    uint local_14[2] = (uint[2])0;
    uint local_15 = (uint)0;
    uint local_16[2] = (uint[2])0;
    uint local_17 = (uint)0;
    uint local_18[2] = (uint[2])0;
    uint local_19 = (uint)0;
    uint local_20[2] = (uint[2])0;
    uint local_21 = (uint)0;
    uint local_22[2] = (uint[2])0;
    uint local_23 = (uint)0;
    uint local_24[2] = (uint[2])0;
    uint local_25 = (uint)0;
    uint local_26[2] = (uint[2])0;
    uint local_27 = (uint)0;
    uint local_28[2] = (uint[2])0;
    uint local_29 = (uint)0;
    uint local_30[2] = (uint[2])0;
    uint local_31 = (uint)0;
    uint local_32[2] = (uint[2])0;
    uint local_33 = (uint)0;
    uint local_34[2] = (uint[2])0;
    uint local_35 = (uint)0;
    uint local_36[2] = (uint[2])0;
    uint local_37 = (uint)0;
    uint local_38[2] = (uint[2])0;
    uint local_39 = (uint)0;
    int first = (int)0;
    uint second = (uint)0;
    uint local_40[2] = (uint[2])0;
    uint local_41 = (uint)0;
    uint local_42[2] = (uint[2])0;
    uint local_43 = (uint)0;
    uint local_44[2] = (uint[2])0;
    uint local_45 = (uint)0;
    uint local_46[2] = (uint[2])0;
    uint local_47 = (uint)0;
    uint local_48[2] = (uint[2])0;
    uint local_49 = (uint)0;
    int local_50 = (int)0;
    int values[2] = (int[2])0;
    uint local_51[2] = (uint[2])0;
    uint local_52 = (uint)0;
    int Count = (int)0;
    int local_53 = (int)0;
    int scratch[2] = (int[2])0;
    uint local_54[2] = (uint[2])0;
    uint local_55 = (uint)0;
    int counter = (int)0;
    uint local_56[2] = (uint[2])0;
    uint local_57 = (uint)0;
    uint local_58[2] = (uint[2])0;
    uint local_59 = (uint)0;
    int total = (int)0;
    int index = (int)0;
    uint local_60[2] = (uint[2])0;
    uint local_61 = (uint)0;
    uint local_62[2] = (uint[2])0;
    uint local_63 = (uint)0;
    uint local_64[2] = (uint[2])0;
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
    uint local_159[2] = (uint[2])0;
    uint local_160 = (uint)0;
    uint local_161 = (uint)0;

    out_ = ZeroValuearray2_uint_();
    out_[0] = 0u;
    out_[1] = 0u;
    uint _e20[2] = out_;
    local = _e20;
    local_1 = uint(int(0));
    uint _e25[2] = local;
    local_66 = _e25;
    uint _e26 = local_1;
    uint _e28 = local_66[1];
    local_66[1] = (_e28 + _e26);
    uint _e32 = local_66[0];
    local_67 = uint(_e32);
    uint _e36 = local_66[1];
    local_68 = uint(_e36);
    uint _e39 = local_68;
    out_1.Store(_e39*4, asuint(uint(asint((asuint(naga_extractBits(int(8388608), 0u, 24u)) * asuint(naga_extractBits(int(1), 0u, 24u)))))));
    uint _e49[2] = out_;
    local_2 = _e49;
    local_3 = uint(int(1));
    uint _e54[2] = local_2;
    local_69 = _e54;
    uint _e55 = local_3;
    uint _e57 = local_69[1];
    local_69[1] = (_e57 + _e55);
    uint _e61 = local_69[0];
    local_70 = uint(_e61);
    uint _e65 = local_69[1];
    local_71 = uint(_e65);
    uint _e68 = local_71;
    out_1.Store(_e68*4, asuint((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(16777215u, 0u, 24u))));
    uint _e82[2] = out_;
    local_4 = _e82;
    local_5 = uint(int(2));
    uint _e87[2] = local_4;
    local_72 = _e87;
    uint _e88 = local_5;
    uint _e90 = local_72[1];
    local_72[1] = (_e90 + _e88);
    uint _e94 = local_72[0];
    local_73 = uint(_e94);
    uint _e98 = local_72[1];
    local_74 = uint(_e98);
    uint _e101 = local_74;
    out_1.Store(_e101*4, asuint(uint(asint((asuint(naga_extractBits(int(8388607), 0u, 24u)) * asuint(naga_extractBits(int(8388607), 0u, 24u)))))));
    uint _e111[2] = out_;
    local_6 = _e111;
    local_7 = uint(int(3));
    uint _e116[2] = local_6;
    local_75 = _e116;
    uint _e117 = local_7;
    uint _e119 = local_75[1];
    local_75[1] = (_e119 + _e117);
    uint _e123 = local_75[0];
    local_76 = uint(_e123);
    uint _e127 = local_75[1];
    local_77 = uint(_e127);
    uint _e130 = local_77;
    out_1.Store(_e130*4, asuint((naga_extractBits(16777216u, 0u, 24u) * naga_extractBits(13u, 0u, 24u))));
    const int _e135 = signed_conversion(3.75, -(2.75));
    uint _e138[2] = out_;
    local_8 = _e138;
    local_9 = uint(int(4));
    uint _e143[2] = local_8;
    local_78 = _e143;
    uint _e144 = local_9;
    uint _e146 = local_78[1];
    local_78[1] = (_e146 + _e144);
    uint _e150 = local_78[0];
    local_79 = uint(_e150);
    uint _e154 = local_78[1];
    local_80 = uint(_e154);
    uint _e157 = local_80;
    out_1.Store(_e157*4, asuint(uint(_e135)));
    const int _e162 = signed_conversion(-(3.75), 2.75);
    uint _e165[2] = out_;
    local_10 = _e165;
    local_11 = uint(int(5));
    uint _e170[2] = local_10;
    local_81 = _e170;
    uint _e171 = local_11;
    uint _e173 = local_81[1];
    local_81[1] = (_e173 + _e171);
    uint _e177 = local_81[0];
    local_82 = uint(_e177);
    uint _e181 = local_81[1];
    local_83 = uint(_e181);
    uint _e184 = local_83;
    out_1.Store(_e184*4, asuint(uint(_e162)));
    const uint _e188 = unsigned_conversion(3.75, 2.75);
    uint _e190[2] = out_;
    local_12 = _e190;
    local_13 = uint(int(6));
    uint _e195[2] = local_12;
    local_84 = _e195;
    uint _e196 = local_13;
    uint _e198 = local_84[1];
    local_84[1] = (_e198 + _e196);
    uint _e202 = local_84[0];
    local_85 = uint(_e202);
    uint _e206 = local_84[1];
    local_86 = uint(_e206);
    uint _e209 = local_86;
    out_1.Store(_e209*4, asuint(_e188));
    const uint _e213 = unsigned_conversion(16777215.0, 1.0);
    uint _e215[2] = out_;
    local_14 = _e215;
    local_15 = uint(int(7));
    uint _e220[2] = local_14;
    local_87 = _e220;
    uint _e221 = local_15;
    uint _e223 = local_87[1];
    local_87[1] = (_e223 + _e221);
    uint _e227 = local_87[0];
    local_88 = uint(_e227);
    uint _e231 = local_87[1];
    local_89 = uint(_e231);
    uint _e234 = local_89;
    out_1.Store(_e234*4, asuint(_e213));
    const int _e238 = _mul24_(true, true);
    uint _e241[2] = out_;
    local_16 = _e241;
    local_17 = uint(int(8));
    uint _e246[2] = local_16;
    local_90 = _e246;
    uint _e247 = local_17;
    uint _e249 = local_90[1];
    local_90[1] = (_e249 + _e247);
    uint _e253 = local_90[0];
    local_91 = uint(_e253);
    uint _e257 = local_90[1];
    local_92 = uint(_e257);
    uint _e260 = local_92;
    out_1.Store(_e260*4, asuint(uint(_e238)));
    const int _e264 = _mul24_(false, true);
    uint _e267[2] = out_;
    local_18 = _e267;
    local_19 = uint(int(9));
    uint _e272[2] = local_18;
    local_93 = _e272;
    uint _e273 = local_19;
    uint _e275 = local_93[1];
    local_93[1] = (_e275 + _e273);
    uint _e279 = local_93[0];
    local_94 = uint(_e279);
    uint _e283 = local_93[1];
    local_95 = uint(_e283);
    uint _e286 = local_95;
    out_1.Store(_e286*4, asuint(uint(_e264)));
    uint _e301[2] = out_;
    local_20 = _e301;
    local_21 = uint(int(10));
    uint _e306[2] = local_20;
    local_96 = _e306;
    uint _e307 = local_21;
    uint _e309 = local_96[1];
    local_96[1] = (_e309 + _e307);
    uint _e313 = local_96[0];
    local_97 = uint(_e313);
    uint _e317 = local_96[1];
    local_98 = uint(_e317);
    uint _e320 = local_98;
    out_1.Store(_e320*4, asuint(uint(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(true), 0u, 24u)))))));
    uint _e335[2] = out_;
    local_22 = _e335;
    local_23 = uint(int(11));
    uint _e340[2] = local_22;
    local_99 = _e340;
    uint _e341 = local_23;
    uint _e343 = local_99[1];
    local_99[1] = (_e343 + _e341);
    uint _e347 = local_99[0];
    local_100 = uint(_e347);
    uint _e351 = local_99[1];
    local_101 = uint(_e351);
    uint _e354 = local_101;
    out_1.Store(_e354*4, asuint(uint(asint((asuint(naga_extractBits(int(true), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
    const int _e358 = _mul24_1(3.75, 2.0);
    uint _e361[2] = out_;
    local_24 = _e361;
    local_25 = uint(int(12));
    uint _e366[2] = local_24;
    local_102 = _e366;
    uint _e367 = local_25;
    uint _e369 = local_102[1];
    local_102[1] = (_e369 + _e367);
    uint _e373 = local_102[0];
    local_103 = uint(_e373);
    uint _e377 = local_102[1];
    local_104 = uint(_e377);
    uint _e380 = local_104;
    out_1.Store(_e380*4, asuint(uint(_e358)));
    const uint _e384 = _umul24_(int(3), int(4));
    uint _e386[2] = out_;
    local_26 = _e386;
    local_27 = uint(int(13));
    uint _e391[2] = local_26;
    local_105 = _e391;
    uint _e392 = local_27;
    uint _e394 = local_105[1];
    local_105[1] = (_e394 + _e392);
    uint _e398 = local_105[0];
    local_106 = uint(_e398);
    uint _e402 = local_105[1];
    local_107 = uint(_e402);
    uint _e405 = local_107;
    out_1.Store(_e405*4, asuint(_e384));
    uint _e415[2] = out_;
    local_28 = _e415;
    local_29 = uint(int(14));
    uint _e420[2] = local_28;
    local_108 = _e420;
    uint _e421 = local_29;
    uint _e423 = local_108[1];
    local_108[1] = (_e423 + _e421);
    uint _e427 = local_108[0];
    local_109 = uint(_e427);
    uint _e431 = local_108[1];
    local_110 = uint(_e431);
    uint _e434 = local_110;
    out_1.Store(_e434*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(4u, 0u, 24u))));
    const uint _e440 = _umul24_(int(true), int(true));
    uint _e442[2] = out_;
    local_30 = _e442;
    local_31 = uint(int(15));
    uint _e447[2] = local_30;
    local_111 = _e447;
    uint _e448 = local_31;
    uint _e450 = local_111[1];
    local_111[1] = (_e450 + _e448);
    uint _e454 = local_111[0];
    local_112 = uint(_e454);
    uint _e458 = local_111[1];
    local_113 = uint(_e458);
    uint _e461 = local_113;
    out_1.Store(_e461*4, asuint(_e440));
    uint _e472[2] = out_;
    local_32 = _e472;
    local_33 = uint(int(16));
    uint _e477[2] = local_32;
    local_114 = _e477;
    uint _e478 = local_33;
    uint _e480 = local_114[1];
    local_114[1] = (_e480 + _e478);
    uint _e484 = local_114[0];
    local_115 = uint(_e484);
    uint _e488 = local_114[1];
    local_116 = uint(_e488);
    uint _e491 = local_116;
    out_1.Store(_e491*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(uint(int(4)), 0u, 24u))));
    const int _e496 = signed_pair(naga_neg(int(7)), int(3));
    uint _e499[2] = out_;
    local_34 = _e499;
    local_35 = uint(int(17));
    uint _e504[2] = local_34;
    local_117 = _e504;
    uint _e505 = local_35;
    uint _e507 = local_117[1];
    local_117[1] = (_e507 + _e505);
    uint _e511 = local_117[0];
    local_118 = uint(_e511);
    uint _e515 = local_117[1];
    local_119 = uint(_e515);
    uint _e518 = local_119;
    out_1.Store(_e518*4, asuint(uint(_e496)));
    uint _e541[2] = out_;
    local_36 = _e541;
    local_37 = uint(int(18));
    uint _e546[2] = local_36;
    local_120 = _e546;
    uint _e547 = local_37;
    uint _e549 = local_120[1];
    local_120[1] = (_e549 + _e547);
    uint _e553 = local_120[0];
    local_121 = uint(_e553);
    uint _e557 = local_120[1];
    local_122 = uint(_e557);
    uint _e560 = local_122;
    out_1.Store(_e560*4, asuint(uint(asint((asuint(naga_extractBits(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u)))), 0u, 24u)) * asuint(naga_extractBits(int(5), 0u, 24u)))))));
    uint _e576[2] = out_;
    local_38 = _e576;
    local_39 = uint(int(19));
    uint _e581[2] = local_38;
    local_123 = _e581;
    uint _e582 = local_39;
    uint _e584 = local_123[1];
    local_123[1] = (_e584 + _e582);
    uint _e588 = local_123[0];
    local_124 = uint(_e588);
    uint _e592 = local_123[1];
    local_125 = uint(_e592);
    uint _e595 = local_125;
    out_1.Store(_e595*4, asuint((naga_extractBits((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(2u, 0u, 24u)), 0u, 24u) * naga_extractBits(2u, 0u, 24u))));
    first = int(-3);
    second = 5u;
    int _e601 = first;
    uint _e602 = second;
    uint _e614[2] = out_;
    local_40 = _e614;
    local_41 = uint(int(20));
    uint _e619[2] = local_40;
    local_126 = _e619;
    uint _e620 = local_41;
    uint _e622 = local_126[1];
    local_126[1] = (_e622 + _e620);
    uint _e626 = local_126[0];
    local_127 = uint(_e626);
    uint _e630 = local_126[1];
    local_128 = uint(_e630);
    uint _e633 = local_128;
    out_1.Store(_e633*4, asuint(uint(asint((asuint(naga_extractBits(_e601, 0u, 24u)) * asuint(naga_extractBits(int(_e602), 0u, 24u)))))));
    int _e635 = first;
    uint _e637 = second;
    uint _e644[2] = out_;
    local_42 = _e644;
    local_43 = uint(int(21));
    uint _e649[2] = local_42;
    local_129 = _e649;
    uint _e650 = local_43;
    uint _e652 = local_129[1];
    local_129[1] = (_e652 + _e650);
    uint _e656 = local_129[0];
    local_130 = uint(_e656);
    uint _e660 = local_129[1];
    local_131 = uint(_e660);
    uint _e663 = local_131;
    out_1.Store(_e663*4, asuint((naga_extractBits(uint(_e635), 0u, 24u) * naga_extractBits(_e637, 0u, 24u))));
    uint _e677[2] = out_;
    local_44 = _e677;
    local_45 = uint(int(22));
    uint _e682[2] = local_44;
    local_132 = _e682;
    uint _e683 = local_45;
    uint _e685 = local_132[1];
    local_132[1] = (_e685 + _e683);
    uint _e689 = local_132[0];
    local_133 = uint(_e689);
    uint _e693 = local_132[1];
    local_134 = uint(_e693);
    uint _e696 = local_134;
    out_1.Store(_e696*4, asuint(uint(asint((asuint(naga_extractBits(int(25165824), 0u, 24u)) * asuint(naga_extractBits(int(16777217), 0u, 24u)))))));
    uint _e706[2] = out_;
    local_46 = _e706;
    local_47 = uint(int(23));
    uint _e711[2] = local_46;
    local_135 = _e711;
    uint _e712 = local_47;
    uint _e714 = local_135[1];
    local_135[1] = (_e714 + _e712);
    uint _e718 = local_135[0];
    local_136 = uint(_e718);
    uint _e722 = local_135[1];
    local_137 = uint(_e722);
    uint _e725 = local_137;
    out_1.Store(_e725*4, asuint((naga_extractBits(4286578688u, 0u, 24u) * naga_extractBits(4278190081u, 0u, 24u))));
    if (true) {
        local_50 = asint((asuint(naga_extractBits(naga_neg(int(3)), 0u, 24u)) * asuint(naga_extractBits(int(7), 0u, 24u))));
    } else {
        local_50 = asint((asuint(naga_extractBits(int(0), 0u, 24u)) * asuint(naga_extractBits(int(0), 0u, 24u))));
    }
    int _e752 = local_50;
    uint _e755[2] = out_;
    local_48 = _e755;
    local_49 = uint(int(24));
    uint _e760[2] = local_48;
    local_138 = _e760;
    uint _e761 = local_49;
    uint _e763 = local_138[1];
    local_138[1] = (_e763 + _e761);
    uint _e767 = local_138[0];
    local_139 = uint(_e767);
    uint _e771 = local_138[1];
    local_140 = uint(_e771);
    uint _e774 = local_140;
    out_1.Store(_e774*4, asuint(uint(_e752)));
    values[0] = asint((asuint(naga_extractBits(int(2), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u))));
    values[1] = asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u))));
    int _e803 = values[int(0)];
    int _e804 = values[int(1)];
    uint _e808[2] = out_;
    local_51 = _e808;
    local_52 = uint(int(25));
    uint _e813[2] = local_51;
    local_141 = _e813;
    uint _e814 = local_52;
    uint _e816 = local_141[1];
    local_141[1] = (_e816 + _e814);
    uint _e820 = local_141[0];
    local_142 = uint(_e820);
    uint _e824 = local_141[1];
    local_143 = uint(_e824);
    uint _e827 = local_143;
    out_1.Store(_e827*4, asuint(uint(asint(asuint(_e803) + asuint(_e804)))));
    Count = int(2);
    scratch = ZeroValuearray2_int_();
    int _e835 = Count;
    int _e836 = scratch[int(0)];
    uint _e840[2] = out_;
    local_54 = _e840;
    local_55 = uint(int(26));
    uint _e845[2] = local_54;
    local_144 = _e845;
    uint _e846 = local_55;
    uint _e848 = local_144[1];
    local_144[1] = (_e848 + _e846);
    uint _e852 = local_144[0];
    local_145 = uint(_e852);
    uint _e856 = local_144[1];
    local_146 = uint(_e856);
    uint _e859 = local_146;
    out_1.Store(_e859*4, asuint(uint(asint(asuint(_e835) + asuint(_e836)))));
    counter = int(2);
    int _e863 = counter;
    counter = asint(asuint(_e863) + asuint(int(1)));
    int _e866 = counter;
    counter = asint(asuint(_e866) + asuint(int(1)));
    uint _e879[2] = out_;
    local_56 = _e879;
    local_57 = uint(int(27));
    uint _e884[2] = local_56;
    local_147 = _e884;
    uint _e885 = local_57;
    uint _e887 = local_147[1];
    local_147[1] = (_e887 + _e885);
    uint _e891 = local_147[0];
    local_148 = uint(_e891);
    uint _e895 = local_147[1];
    local_149 = uint(_e895);
    uint _e898 = local_149;
    out_1.Store(_e898*4, asuint(uint(asint((asuint(naga_extractBits(_e863, 0u, 24u)) * asuint(naga_extractBits(_e866, 0u, 24u)))))));
    int _e900 = counter;
    uint _e903[2] = out_;
    local_58 = _e903;
    local_59 = uint(int(28));
    uint _e908[2] = local_58;
    local_150 = _e908;
    uint _e909 = local_59;
    uint _e911 = local_150[1];
    local_150[1] = (_e911 + _e909);
    uint _e915 = local_150[0];
    local_151 = uint(_e915);
    uint _e919 = local_150[1];
    local_152 = uint(_e919);
    uint _e922 = local_152;
    out_1.Store(_e922*4, asuint(uint(_e900)));
    total = int(0);
    {
        index = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e945 = index;
                index = asint(asuint(_e945) + asuint(int(1)));
            }
            loop_init = false;
            int _e928 = index;
            if ((_e928 < int(3))) {
            } else {
                break;
            }
            int _e931 = index;
            int _e943 = total;
            total = asint(asuint(_e943) + asuint(asint((asuint(naga_extractBits(asint(asuint(_e931) + asuint(int(1))), 0u, 24u)) * asuint(naga_extractBits(int(2), 0u, 24u))))));
        }
    }
    int _e948 = total;
    uint _e951[2] = out_;
    local_60 = _e951;
    local_61 = uint(int(29));
    uint _e956[2] = local_60;
    local_153 = _e956;
    uint _e957 = local_61;
    uint _e959 = local_153[1];
    local_153[1] = (_e959 + _e957);
    uint _e963 = local_153[0];
    local_154 = uint(_e963);
    uint _e967 = local_153[1];
    local_155 = uint(_e967);
    uint _e970 = local_155;
    out_1.Store(_e970*4, asuint(uint(_e948)));
    {
        uint _e976[2] = out_;
        local_62 = _e976;
        local_63 = uint(int(30));
        uint _e981[2] = local_62;
        local_156 = _e981;
        uint _e982 = local_63;
        uint _e984 = local_156[1];
        local_156[1] = (_e984 + _e982);
        uint _e988 = local_156[0];
        local_157 = uint(_e988);
        uint _e992 = local_156[1];
        local_158 = uint(_e992);
        uint _e995 = local_158;
        out_1.Store(_e995*4, asuint(uint(naga_f2i32(9.75))));
    }
    uint _e1009[2] = out_;
    local_64 = _e1009;
    local_65 = uint(int(31));
    uint _e1014[2] = local_64;
    local_159 = _e1014;
    uint _e1015 = local_65;
    uint _e1017 = local_159[1];
    local_159[1] = (_e1017 + _e1015);
    uint _e1021 = local_159[0];
    local_160 = uint(_e1021);
    uint _e1025 = local_159[1];
    local_161 = uint(_e1025);
    uint _e1028 = local_161;
    out_1.Store(_e1028*4, asuint(uint(asint((asuint(naga_extractBits(int(16777215), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
}
