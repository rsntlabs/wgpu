RWByteAddressBuffer out_ : register(u0);

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
    float first_2 = (float)0;
    float second_2 = (float)0;

    first_2 = first_1;
    second_2 = second_1;
    float _e4 = first_2;
    float _e5 = second_2;
    return asint((asuint(naga_extractBits(naga_f2i32(_e4), 0u, 24u)) * asuint(naga_extractBits(naga_f2i32(_e5), 0u, 24u))));
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

uint unsigned_conversion(float first_3, float second_3)
{
    float first_4 = (float)0;
    float second_4 = (float)0;

    first_4 = first_3;
    second_4 = second_3;
    float _e4 = first_4;
    float _e5 = second_4;
    return (naga_extractBits(naga_f2u32(_e4), 0u, 24u) * naga_extractBits(naga_f2u32(_e5), 0u, 24u));
}

int _mul24_(bool first_5, bool second_5)
{
    bool first_6 = (bool)0;
    bool second_6 = (bool)0;
    int local_163 = (int)0;
    int local_164 = (int)0;

    first_6 = first_5;
    second_6 = second_5;
    bool _e4 = first_6;
    if (_e4) {
        bool _e5 = second_6;
        if (_e5) {
            local_163 = int(71);
        } else {
            local_163 = int(73);
        }
        int _e9 = local_163;
        local_164 = _e9;
    } else {
        local_164 = int(79);
    }
    int _e12 = local_164;
    return _e12;
}

int _mul24_1(float first_7, float second_7)
{
    float first_8 = (float)0;
    float second_8 = (float)0;

    first_8 = first_7;
    second_8 = second_7;
    float _e5 = first_8;
    float _e7 = second_8;
    return naga_f2i32(((_e5 * 10.0) + _e7));
}

uint _umul24_(int first_9, int second_9)
{
    int first_10 = (int)0;
    int second_10 = (int)0;

    first_10 = first_9;
    second_10 = second_9;
    int _e4 = first_10;
    int _e5 = second_10;
    return uint(asint(asuint(asint(asuint(_e4) + asuint(_e5))) + asuint(int(100))));
}

int signed_pair(int first_11, int second_11)
{
    int first_12 = (int)0;
    int second_12 = (int)0;

    first_12 = first_11;
    second_12 = second_11;
    int _e4 = first_12;
    int _e5 = second_12;
    return asint((asuint(naga_extractBits(_e4, 0u, 24u)) * asuint(naga_extractBits(_e5, 0u, 24u))));
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
    int first = (int)0;
    uint second = (uint)0;
    uint local_41[2] = (uint[2])0;
    uint local_42 = (uint)0;
    uint local_43[2] = (uint[2])0;
    uint local_44 = (uint)0;
    uint local_45[2] = (uint[2])0;
    uint local_46 = (uint)0;
    uint local_47[2] = (uint[2])0;
    uint local_48 = (uint)0;
    uint local_49[2] = (uint[2])0;
    uint local_50 = (uint)0;
    int local_51 = (int)0;
    int values[2] = (int[2])0;
    uint local_52[2] = (uint[2])0;
    uint local_53 = (uint)0;
    int Count = (int)0;
    int local_54 = (int)0;
    int scratch[2] = (int[2])0;
    uint local_55[2] = (uint[2])0;
    uint local_56 = (uint)0;
    int counter = (int)0;
    uint local_57[2] = (uint[2])0;
    uint local_58 = (uint)0;
    uint local_59[2] = (uint[2])0;
    uint local_60 = (uint)0;
    int total = (int)0;
    int index = (int)0;
    uint local_61[2] = (uint[2])0;
    uint local_62 = (uint)0;
    uint local_63[2] = (uint[2])0;
    uint local_64 = (uint)0;
    uint local_65[2] = (uint[2])0;
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
    uint local_136[2] = (uint[2])0;
    uint local_137 = (uint)0;
    uint local_138 = (uint)0;
    uint local_139[2] = (uint[2])0;
    uint local_140 = (uint)0;
    uint local_141 = (uint)0;
    uint local_142[2] = (uint[2])0;
    uint local_143 = (uint)0;
    uint local_144 = (uint)0;
    uint local_145[2] = (uint[2])0;
    uint local_146 = (uint)0;
    uint local_147 = (uint)0;
    uint local_148[2] = (uint[2])0;
    uint local_149 = (uint)0;
    uint local_150 = (uint)0;
    uint local_151[2] = (uint[2])0;
    uint local_152 = (uint)0;
    uint local_153 = (uint)0;
    uint local_154[2] = (uint[2])0;
    uint local_155 = (uint)0;
    uint local_156 = (uint)0;
    uint local_157[2] = (uint[2])0;
    uint local_158 = (uint)0;
    uint local_159 = (uint)0;
    uint local_160[2] = (uint[2])0;
    uint local_161 = (uint)0;
    uint local_162 = (uint)0;

    local = ZeroValuearray2_uint_();
    local[0] = 0u;
    local[1] = 0u;
    uint _e20[2] = local;
    local_1 = _e20;
    local_2 = uint(int(0));
    uint _e25[2] = local_1;
    local_67 = _e25;
    uint _e26 = local_2;
    uint _e28 = local_67[1];
    local_67[1] = (_e28 + _e26);
    uint _e32 = local_67[0];
    local_68 = uint(_e32);
    uint _e36 = local_67[1];
    local_69 = uint(_e36);
    uint _e39 = local_69;
    out_.Store(_e39*4, asuint(uint(asint((asuint(naga_extractBits(int(8388608), 0u, 24u)) * asuint(naga_extractBits(int(1), 0u, 24u)))))));
    uint _e49[2] = local;
    local_3 = _e49;
    local_4 = uint(int(1));
    uint _e54[2] = local_3;
    local_70 = _e54;
    uint _e55 = local_4;
    uint _e57 = local_70[1];
    local_70[1] = (_e57 + _e55);
    uint _e61 = local_70[0];
    local_71 = uint(_e61);
    uint _e65 = local_70[1];
    local_72 = uint(_e65);
    uint _e68 = local_72;
    out_.Store(_e68*4, asuint((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(16777215u, 0u, 24u))));
    uint _e82[2] = local;
    local_5 = _e82;
    local_6 = uint(int(2));
    uint _e87[2] = local_5;
    local_73 = _e87;
    uint _e88 = local_6;
    uint _e90 = local_73[1];
    local_73[1] = (_e90 + _e88);
    uint _e94 = local_73[0];
    local_74 = uint(_e94);
    uint _e98 = local_73[1];
    local_75 = uint(_e98);
    uint _e101 = local_75;
    out_.Store(_e101*4, asuint(uint(asint((asuint(naga_extractBits(int(8388607), 0u, 24u)) * asuint(naga_extractBits(int(8388607), 0u, 24u)))))));
    uint _e111[2] = local;
    local_7 = _e111;
    local_8 = uint(int(3));
    uint _e116[2] = local_7;
    local_76 = _e116;
    uint _e117 = local_8;
    uint _e119 = local_76[1];
    local_76[1] = (_e119 + _e117);
    uint _e123 = local_76[0];
    local_77 = uint(_e123);
    uint _e127 = local_76[1];
    local_78 = uint(_e127);
    uint _e130 = local_78;
    out_.Store(_e130*4, asuint((naga_extractBits(16777216u, 0u, 24u) * naga_extractBits(13u, 0u, 24u))));
    const int _e135 = signed_conversion(3.75, -(2.75));
    uint _e138[2] = local;
    local_9 = _e138;
    local_10 = uint(int(4));
    uint _e143[2] = local_9;
    local_79 = _e143;
    uint _e144 = local_10;
    uint _e146 = local_79[1];
    local_79[1] = (_e146 + _e144);
    uint _e150 = local_79[0];
    local_80 = uint(_e150);
    uint _e154 = local_79[1];
    local_81 = uint(_e154);
    uint _e157 = local_81;
    out_.Store(_e157*4, asuint(uint(_e135)));
    const int _e162 = signed_conversion(-(3.75), 2.75);
    uint _e165[2] = local;
    local_11 = _e165;
    local_12 = uint(int(5));
    uint _e170[2] = local_11;
    local_82 = _e170;
    uint _e171 = local_12;
    uint _e173 = local_82[1];
    local_82[1] = (_e173 + _e171);
    uint _e177 = local_82[0];
    local_83 = uint(_e177);
    uint _e181 = local_82[1];
    local_84 = uint(_e181);
    uint _e184 = local_84;
    out_.Store(_e184*4, asuint(uint(_e162)));
    const uint _e188 = unsigned_conversion(3.75, 2.75);
    uint _e190[2] = local;
    local_13 = _e190;
    local_14 = uint(int(6));
    uint _e195[2] = local_13;
    local_85 = _e195;
    uint _e196 = local_14;
    uint _e198 = local_85[1];
    local_85[1] = (_e198 + _e196);
    uint _e202 = local_85[0];
    local_86 = uint(_e202);
    uint _e206 = local_85[1];
    local_87 = uint(_e206);
    uint _e209 = local_87;
    out_.Store(_e209*4, asuint(_e188));
    const uint _e213 = unsigned_conversion(16777215.0, 1.0);
    uint _e215[2] = local;
    local_15 = _e215;
    local_16 = uint(int(7));
    uint _e220[2] = local_15;
    local_88 = _e220;
    uint _e221 = local_16;
    uint _e223 = local_88[1];
    local_88[1] = (_e223 + _e221);
    uint _e227 = local_88[0];
    local_89 = uint(_e227);
    uint _e231 = local_88[1];
    local_90 = uint(_e231);
    uint _e234 = local_90;
    out_.Store(_e234*4, asuint(_e213));
    const int _e238 = _mul24_(true, true);
    uint _e241[2] = local;
    local_17 = _e241;
    local_18 = uint(int(8));
    uint _e246[2] = local_17;
    local_91 = _e246;
    uint _e247 = local_18;
    uint _e249 = local_91[1];
    local_91[1] = (_e249 + _e247);
    uint _e253 = local_91[0];
    local_92 = uint(_e253);
    uint _e257 = local_91[1];
    local_93 = uint(_e257);
    uint _e260 = local_93;
    out_.Store(_e260*4, asuint(uint(_e238)));
    const int _e264 = _mul24_(false, true);
    uint _e267[2] = local;
    local_19 = _e267;
    local_20 = uint(int(9));
    uint _e272[2] = local_19;
    local_94 = _e272;
    uint _e273 = local_20;
    uint _e275 = local_94[1];
    local_94[1] = (_e275 + _e273);
    uint _e279 = local_94[0];
    local_95 = uint(_e279);
    uint _e283 = local_94[1];
    local_96 = uint(_e283);
    uint _e286 = local_96;
    out_.Store(_e286*4, asuint(uint(_e264)));
    uint _e301[2] = local;
    local_21 = _e301;
    local_22 = uint(int(10));
    uint _e306[2] = local_21;
    local_97 = _e306;
    uint _e307 = local_22;
    uint _e309 = local_97[1];
    local_97[1] = (_e309 + _e307);
    uint _e313 = local_97[0];
    local_98 = uint(_e313);
    uint _e317 = local_97[1];
    local_99 = uint(_e317);
    uint _e320 = local_99;
    out_.Store(_e320*4, asuint(uint(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(true), 0u, 24u)))))));
    uint _e335[2] = local;
    local_23 = _e335;
    local_24 = uint(int(11));
    uint _e340[2] = local_23;
    local_100 = _e340;
    uint _e341 = local_24;
    uint _e343 = local_100[1];
    local_100[1] = (_e343 + _e341);
    uint _e347 = local_100[0];
    local_101 = uint(_e347);
    uint _e351 = local_100[1];
    local_102 = uint(_e351);
    uint _e354 = local_102;
    out_.Store(_e354*4, asuint(uint(asint((asuint(naga_extractBits(int(true), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
    const int _e358 = _mul24_1(3.75, 2.0);
    uint _e361[2] = local;
    local_25 = _e361;
    local_26 = uint(int(12));
    uint _e366[2] = local_25;
    local_103 = _e366;
    uint _e367 = local_26;
    uint _e369 = local_103[1];
    local_103[1] = (_e369 + _e367);
    uint _e373 = local_103[0];
    local_104 = uint(_e373);
    uint _e377 = local_103[1];
    local_105 = uint(_e377);
    uint _e380 = local_105;
    out_.Store(_e380*4, asuint(uint(_e358)));
    const uint _e384 = _umul24_(int(3), int(4));
    uint _e386[2] = local;
    local_27 = _e386;
    local_28 = uint(int(13));
    uint _e391[2] = local_27;
    local_106 = _e391;
    uint _e392 = local_28;
    uint _e394 = local_106[1];
    local_106[1] = (_e394 + _e392);
    uint _e398 = local_106[0];
    local_107 = uint(_e398);
    uint _e402 = local_106[1];
    local_108 = uint(_e402);
    uint _e405 = local_108;
    out_.Store(_e405*4, asuint(_e384));
    uint _e415[2] = local;
    local_29 = _e415;
    local_30 = uint(int(14));
    uint _e420[2] = local_29;
    local_109 = _e420;
    uint _e421 = local_30;
    uint _e423 = local_109[1];
    local_109[1] = (_e423 + _e421);
    uint _e427 = local_109[0];
    local_110 = uint(_e427);
    uint _e431 = local_109[1];
    local_111 = uint(_e431);
    uint _e434 = local_111;
    out_.Store(_e434*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(4u, 0u, 24u))));
    const uint _e440 = _umul24_(int(true), int(true));
    uint _e442[2] = local;
    local_31 = _e442;
    local_32 = uint(int(15));
    uint _e447[2] = local_31;
    local_112 = _e447;
    uint _e448 = local_32;
    uint _e450 = local_112[1];
    local_112[1] = (_e450 + _e448);
    uint _e454 = local_112[0];
    local_113 = uint(_e454);
    uint _e458 = local_112[1];
    local_114 = uint(_e458);
    uint _e461 = local_114;
    out_.Store(_e461*4, asuint(_e440));
    uint _e472[2] = local;
    local_33 = _e472;
    local_34 = uint(int(16));
    uint _e477[2] = local_33;
    local_115 = _e477;
    uint _e478 = local_34;
    uint _e480 = local_115[1];
    local_115[1] = (_e480 + _e478);
    uint _e484 = local_115[0];
    local_116 = uint(_e484);
    uint _e488 = local_115[1];
    local_117 = uint(_e488);
    uint _e491 = local_117;
    out_.Store(_e491*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(uint(int(4)), 0u, 24u))));
    const int _e496 = signed_pair(naga_neg(int(7)), int(3));
    uint _e499[2] = local;
    local_35 = _e499;
    local_36 = uint(int(17));
    uint _e504[2] = local_35;
    local_118 = _e504;
    uint _e505 = local_36;
    uint _e507 = local_118[1];
    local_118[1] = (_e507 + _e505);
    uint _e511 = local_118[0];
    local_119 = uint(_e511);
    uint _e515 = local_118[1];
    local_120 = uint(_e515);
    uint _e518 = local_120;
    out_.Store(_e518*4, asuint(uint(_e496)));
    uint _e541[2] = local;
    local_37 = _e541;
    local_38 = uint(int(18));
    uint _e546[2] = local_37;
    local_121 = _e546;
    uint _e547 = local_38;
    uint _e549 = local_121[1];
    local_121[1] = (_e549 + _e547);
    uint _e553 = local_121[0];
    local_122 = uint(_e553);
    uint _e557 = local_121[1];
    local_123 = uint(_e557);
    uint _e560 = local_123;
    out_.Store(_e560*4, asuint(uint(asint((asuint(naga_extractBits(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u)))), 0u, 24u)) * asuint(naga_extractBits(int(5), 0u, 24u)))))));
    uint _e576[2] = local;
    local_39 = _e576;
    local_40 = uint(int(19));
    uint _e581[2] = local_39;
    local_124 = _e581;
    uint _e582 = local_40;
    uint _e584 = local_124[1];
    local_124[1] = (_e584 + _e582);
    uint _e588 = local_124[0];
    local_125 = uint(_e588);
    uint _e592 = local_124[1];
    local_126 = uint(_e592);
    uint _e595 = local_126;
    out_.Store(_e595*4, asuint((naga_extractBits((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(2u, 0u, 24u)), 0u, 24u) * naga_extractBits(2u, 0u, 24u))));
    first = int(-3);
    second = 5u;
    int _e601 = first;
    uint _e602 = second;
    uint _e614[2] = local;
    local_41 = _e614;
    local_42 = uint(int(20));
    uint _e619[2] = local_41;
    local_127 = _e619;
    uint _e620 = local_42;
    uint _e622 = local_127[1];
    local_127[1] = (_e622 + _e620);
    uint _e626 = local_127[0];
    local_128 = uint(_e626);
    uint _e630 = local_127[1];
    local_129 = uint(_e630);
    uint _e633 = local_129;
    out_.Store(_e633*4, asuint(uint(asint((asuint(naga_extractBits(_e601, 0u, 24u)) * asuint(naga_extractBits(int(_e602), 0u, 24u)))))));
    int _e635 = first;
    uint _e637 = second;
    uint _e644[2] = local;
    local_43 = _e644;
    local_44 = uint(int(21));
    uint _e649[2] = local_43;
    local_130 = _e649;
    uint _e650 = local_44;
    uint _e652 = local_130[1];
    local_130[1] = (_e652 + _e650);
    uint _e656 = local_130[0];
    local_131 = uint(_e656);
    uint _e660 = local_130[1];
    local_132 = uint(_e660);
    uint _e663 = local_132;
    out_.Store(_e663*4, asuint((naga_extractBits(uint(_e635), 0u, 24u) * naga_extractBits(_e637, 0u, 24u))));
    uint _e677[2] = local;
    local_45 = _e677;
    local_46 = uint(int(22));
    uint _e682[2] = local_45;
    local_133 = _e682;
    uint _e683 = local_46;
    uint _e685 = local_133[1];
    local_133[1] = (_e685 + _e683);
    uint _e689 = local_133[0];
    local_134 = uint(_e689);
    uint _e693 = local_133[1];
    local_135 = uint(_e693);
    uint _e696 = local_135;
    out_.Store(_e696*4, asuint(uint(asint((asuint(naga_extractBits(int(25165824), 0u, 24u)) * asuint(naga_extractBits(int(16777217), 0u, 24u)))))));
    uint _e706[2] = local;
    local_47 = _e706;
    local_48 = uint(int(23));
    uint _e711[2] = local_47;
    local_136 = _e711;
    uint _e712 = local_48;
    uint _e714 = local_136[1];
    local_136[1] = (_e714 + _e712);
    uint _e718 = local_136[0];
    local_137 = uint(_e718);
    uint _e722 = local_136[1];
    local_138 = uint(_e722);
    uint _e725 = local_138;
    out_.Store(_e725*4, asuint((naga_extractBits(4286578688u, 0u, 24u) * naga_extractBits(4278190081u, 0u, 24u))));
    if (true) {
        local_51 = asint((asuint(naga_extractBits(naga_neg(int(3)), 0u, 24u)) * asuint(naga_extractBits(int(7), 0u, 24u))));
    } else {
        local_51 = asint((asuint(naga_extractBits(int(0), 0u, 24u)) * asuint(naga_extractBits(int(0), 0u, 24u))));
    }
    int _e752 = local_51;
    uint _e755[2] = local;
    local_49 = _e755;
    local_50 = uint(int(24));
    uint _e760[2] = local_49;
    local_139 = _e760;
    uint _e761 = local_50;
    uint _e763 = local_139[1];
    local_139[1] = (_e763 + _e761);
    uint _e767 = local_139[0];
    local_140 = uint(_e767);
    uint _e771 = local_139[1];
    local_141 = uint(_e771);
    uint _e774 = local_141;
    out_.Store(_e774*4, asuint(uint(_e752)));
    values[0] = asint((asuint(naga_extractBits(int(2), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u))));
    values[1] = asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u))));
    int _e803 = values[int(0)];
    int _e804 = values[int(1)];
    uint _e808[2] = local;
    local_52 = _e808;
    local_53 = uint(int(25));
    uint _e813[2] = local_52;
    local_142 = _e813;
    uint _e814 = local_53;
    uint _e816 = local_142[1];
    local_142[1] = (_e816 + _e814);
    uint _e820 = local_142[0];
    local_143 = uint(_e820);
    uint _e824 = local_142[1];
    local_144 = uint(_e824);
    uint _e827 = local_144;
    out_.Store(_e827*4, asuint(uint(asint(asuint(_e803) + asuint(_e804)))));
    Count = int(2);
    scratch = ZeroValuearray2_int_();
    int _e835 = Count;
    int _e836 = scratch[int(0)];
    uint _e840[2] = local;
    local_55 = _e840;
    local_56 = uint(int(26));
    uint _e845[2] = local_55;
    local_145 = _e845;
    uint _e846 = local_56;
    uint _e848 = local_145[1];
    local_145[1] = (_e848 + _e846);
    uint _e852 = local_145[0];
    local_146 = uint(_e852);
    uint _e856 = local_145[1];
    local_147 = uint(_e856);
    uint _e859 = local_147;
    out_.Store(_e859*4, asuint(uint(asint(asuint(_e835) + asuint(_e836)))));
    counter = int(2);
    int _e863 = counter;
    counter = asint(asuint(_e863) + asuint(int(1)));
    int _e866 = counter;
    counter = asint(asuint(_e866) + asuint(int(1)));
    uint _e879[2] = local;
    local_57 = _e879;
    local_58 = uint(int(27));
    uint _e884[2] = local_57;
    local_148 = _e884;
    uint _e885 = local_58;
    uint _e887 = local_148[1];
    local_148[1] = (_e887 + _e885);
    uint _e891 = local_148[0];
    local_149 = uint(_e891);
    uint _e895 = local_148[1];
    local_150 = uint(_e895);
    uint _e898 = local_150;
    out_.Store(_e898*4, asuint(uint(asint((asuint(naga_extractBits(_e863, 0u, 24u)) * asuint(naga_extractBits(_e866, 0u, 24u)))))));
    int _e900 = counter;
    uint _e903[2] = local;
    local_59 = _e903;
    local_60 = uint(int(28));
    uint _e908[2] = local_59;
    local_151 = _e908;
    uint _e909 = local_60;
    uint _e911 = local_151[1];
    local_151[1] = (_e911 + _e909);
    uint _e915 = local_151[0];
    local_152 = uint(_e915);
    uint _e919 = local_151[1];
    local_153 = uint(_e919);
    uint _e922 = local_153;
    out_.Store(_e922*4, asuint(uint(_e900)));
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
    uint _e951[2] = local;
    local_61 = _e951;
    local_62 = uint(int(29));
    uint _e956[2] = local_61;
    local_154 = _e956;
    uint _e957 = local_62;
    uint _e959 = local_154[1];
    local_154[1] = (_e959 + _e957);
    uint _e963 = local_154[0];
    local_155 = uint(_e963);
    uint _e967 = local_154[1];
    local_156 = uint(_e967);
    uint _e970 = local_156;
    out_.Store(_e970*4, asuint(uint(_e948)));
    {
        uint _e976[2] = local;
        local_63 = _e976;
        local_64 = uint(int(30));
        uint _e981[2] = local_63;
        local_157 = _e981;
        uint _e982 = local_64;
        uint _e984 = local_157[1];
        local_157[1] = (_e984 + _e982);
        uint _e988 = local_157[0];
        local_158 = uint(_e988);
        uint _e992 = local_157[1];
        local_159 = uint(_e992);
        uint _e995 = local_159;
        out_.Store(_e995*4, asuint(uint(naga_f2i32(9.75))));
    }
    uint _e1009[2] = local;
    local_65 = _e1009;
    local_66 = uint(int(31));
    uint _e1014[2] = local_65;
    local_160 = _e1014;
    uint _e1015 = local_66;
    uint _e1017 = local_160[1];
    local_160[1] = (_e1017 + _e1015);
    uint _e1021 = local_160[0];
    local_161 = uint(_e1021);
    uint _e1025 = local_160[1];
    local_162 = uint(_e1025);
    uint _e1028 = local_162;
    out_.Store(_e1028*4, asuint(uint(asint((asuint(naga_extractBits(int(16777215), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
}
