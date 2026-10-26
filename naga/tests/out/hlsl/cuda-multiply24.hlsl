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
    int local_131 = (int)0;
    int local_132 = (int)0;

    first_6 = first_5;
    second_6 = second_5;
    bool _e4 = first_6;
    if (_e4) {
        bool _e5 = second_6;
        if (_e5) {
            local_131 = int(71);
        } else {
            local_131 = int(73);
        }
        int _e9 = local_131;
        local_132 = _e9;
    } else {
        local_132 = int(79);
    }
    int _e12 = local_132;
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

typedef int ret_ZeroValuearray2_int_[2];
ret_ZeroValuearray2_int_ ZeroValuearray2_int_() {
    return (int[2])0;
}

[numthreads(1, 1, 1)]
void multiply24_()
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    uint local_5 = (uint)0;
    uint local_6 = (uint)0;
    uint local_7 = (uint)0;
    uint local_8 = (uint)0;
    uint local_9 = (uint)0;
    uint local_10 = (uint)0;
    uint local_11 = (uint)0;
    uint local_12 = (uint)0;
    uint local_13 = (uint)0;
    uint local_14 = (uint)0;
    uint local_15 = (uint)0;
    uint local_16 = (uint)0;
    uint local_17 = (uint)0;
    uint local_18 = (uint)0;
    uint local_19 = (uint)0;
    uint local_20 = (uint)0;
    uint local_21 = (uint)0;
    uint local_22 = (uint)0;
    uint local_23 = (uint)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;
    uint local_36 = (uint)0;
    uint local_37 = (uint)0;
    uint local_38 = (uint)0;
    uint local_39 = (uint)0;
    uint local_40 = (uint)0;
    uint local_41 = (uint)0;
    uint local_42 = (uint)0;
    uint local_43 = (uint)0;
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
    uint local_56 = (uint)0;
    uint local_57 = (uint)0;
    uint local_58 = (uint)0;
    uint local_59 = (uint)0;
    uint local_60 = (uint)0;
    int first = (int)0;
    uint second = (uint)0;
    uint local_61 = (uint)0;
    uint local_62 = (uint)0;
    uint local_63 = (uint)0;
    uint local_64 = (uint)0;
    uint local_65 = (uint)0;
    uint local_66 = (uint)0;
    uint local_67 = (uint)0;
    uint local_68 = (uint)0;
    uint local_69 = (uint)0;
    uint local_70 = (uint)0;
    uint local_71 = (uint)0;
    uint local_72 = (uint)0;
    uint local_73 = (uint)0;
    uint local_74 = (uint)0;
    uint local_75 = (uint)0;
    int local_76 = (int)0;
    int values[2] = (int[2])0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    int Count = (int)0;
    int local_80 = (int)0;
    int scratch[2] = (int[2])0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    uint local_83 = (uint)0;
    int counter = (int)0;
    uint local_84 = (uint)0;
    uint local_85 = (uint)0;
    uint local_86 = (uint)0;
    uint local_87 = (uint)0;
    uint local_88 = (uint)0;
    uint local_89 = (uint)0;
    int total = (int)0;
    int index = (int)0;
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
    uint local_109 = (uint)0;
    uint local_110 = (uint)0;
    uint local_111 = (uint)0;
    uint local_112 = (uint)0;
    uint local_113 = (uint)0;
    uint local_114 = (uint)0;
    uint local_115 = (uint)0;
    uint local_116 = (uint)0;
    uint local_117 = (uint)0;
    uint local_118 = (uint)0;
    uint local_119 = (uint)0;
    uint local_120 = (uint)0;
    uint local_121 = (uint)0;
    uint local_122 = (uint)0;
    uint local_123 = (uint)0;
    uint local_124 = (uint)0;
    uint local_125 = (uint)0;
    uint local_126 = (uint)0;
    uint local_127 = (uint)0;
    uint local_128 = (uint)0;
    uint local_129 = (uint)0;
    uint local_130 = (uint)0;

    local = 0u;
    uint _e13 = local;
    local_1 = _e13;
    uint _e15 = local_1;
    local_2 = uint(_e15);
    local_3 = uint(int(0));
    uint _e22 = local_2;
    uint _e23 = local_3;
    local_99 = uint((_e22 + _e23));
    uint _e27 = local_99;
    out_.Store(_e27*4, asuint(uint(asint((asuint(naga_extractBits(int(8388608), 0u, 24u)) * asuint(naga_extractBits(int(1), 0u, 24u)))))));
    uint _e36 = local;
    local_4 = _e36;
    uint _e38 = local_4;
    local_5 = uint(_e38);
    local_6 = uint(int(1));
    uint _e44 = local_5;
    uint _e45 = local_6;
    local_100 = uint((_e44 + _e45));
    uint _e49 = local_100;
    out_.Store(_e49*4, asuint((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(16777215u, 0u, 24u))));
    uint _e62 = local;
    local_7 = _e62;
    uint _e64 = local_7;
    local_8 = uint(_e64);
    local_9 = uint(int(2));
    uint _e70 = local_8;
    uint _e71 = local_9;
    local_101 = uint((_e70 + _e71));
    uint _e75 = local_101;
    out_.Store(_e75*4, asuint(uint(asint((asuint(naga_extractBits(int(8388607), 0u, 24u)) * asuint(naga_extractBits(int(8388607), 0u, 24u)))))));
    uint _e84 = local;
    local_10 = _e84;
    uint _e86 = local_10;
    local_11 = uint(_e86);
    local_12 = uint(int(3));
    uint _e92 = local_11;
    uint _e93 = local_12;
    local_102 = uint((_e92 + _e93));
    uint _e97 = local_102;
    out_.Store(_e97*4, asuint((naga_extractBits(16777216u, 0u, 24u) * naga_extractBits(13u, 0u, 24u))));
    const int _e102 = signed_conversion(3.75, -(2.75));
    uint _e104 = local;
    local_13 = _e104;
    uint _e106 = local_13;
    local_14 = uint(_e106);
    local_15 = uint(int(4));
    uint _e112 = local_14;
    uint _e113 = local_15;
    local_103 = uint((_e112 + _e113));
    uint _e117 = local_103;
    out_.Store(_e117*4, asuint(uint(_e102)));
    const int _e122 = signed_conversion(-(3.75), 2.75);
    uint _e124 = local;
    local_16 = _e124;
    uint _e126 = local_16;
    local_17 = uint(_e126);
    local_18 = uint(int(5));
    uint _e132 = local_17;
    uint _e133 = local_18;
    local_104 = uint((_e132 + _e133));
    uint _e137 = local_104;
    out_.Store(_e137*4, asuint(uint(_e122)));
    const uint _e141 = unsigned_conversion(3.75, 2.75);
    uint _e142 = local;
    local_19 = _e142;
    uint _e144 = local_19;
    local_20 = uint(_e144);
    local_21 = uint(int(6));
    uint _e150 = local_20;
    uint _e151 = local_21;
    local_105 = uint((_e150 + _e151));
    uint _e155 = local_105;
    out_.Store(_e155*4, asuint(_e141));
    const uint _e159 = unsigned_conversion(16777215.0, 1.0);
    uint _e160 = local;
    local_22 = _e160;
    uint _e162 = local_22;
    local_23 = uint(_e162);
    local_24 = uint(int(7));
    uint _e168 = local_23;
    uint _e169 = local_24;
    local_106 = uint((_e168 + _e169));
    uint _e173 = local_106;
    out_.Store(_e173*4, asuint(_e159));
    const int _e177 = _mul24_(true, true);
    uint _e179 = local;
    local_25 = _e179;
    uint _e181 = local_25;
    local_26 = uint(_e181);
    local_27 = uint(int(8));
    uint _e187 = local_26;
    uint _e188 = local_27;
    local_107 = uint((_e187 + _e188));
    uint _e192 = local_107;
    out_.Store(_e192*4, asuint(uint(_e177)));
    const int _e196 = _mul24_(false, true);
    uint _e198 = local;
    local_28 = _e198;
    uint _e200 = local_28;
    local_29 = uint(_e200);
    local_30 = uint(int(9));
    uint _e206 = local_29;
    uint _e207 = local_30;
    local_108 = uint((_e206 + _e207));
    uint _e211 = local_108;
    out_.Store(_e211*4, asuint(uint(_e196)));
    uint _e225 = local;
    local_31 = _e225;
    uint _e227 = local_31;
    local_32 = uint(_e227);
    local_33 = uint(int(10));
    uint _e233 = local_32;
    uint _e234 = local_33;
    local_109 = uint((_e233 + _e234));
    uint _e238 = local_109;
    out_.Store(_e238*4, asuint(uint(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(true), 0u, 24u)))))));
    uint _e252 = local;
    local_34 = _e252;
    uint _e254 = local_34;
    local_35 = uint(_e254);
    local_36 = uint(int(11));
    uint _e260 = local_35;
    uint _e261 = local_36;
    local_110 = uint((_e260 + _e261));
    uint _e265 = local_110;
    out_.Store(_e265*4, asuint(uint(asint((asuint(naga_extractBits(int(true), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
    const int _e269 = _mul24_1(3.75, 2.0);
    uint _e271 = local;
    local_37 = _e271;
    uint _e273 = local_37;
    local_38 = uint(_e273);
    local_39 = uint(int(12));
    uint _e279 = local_38;
    uint _e280 = local_39;
    local_111 = uint((_e279 + _e280));
    uint _e284 = local_111;
    out_.Store(_e284*4, asuint(uint(_e269)));
    const uint _e288 = _umul24_(int(3), int(4));
    uint _e289 = local;
    local_40 = _e289;
    uint _e291 = local_40;
    local_41 = uint(_e291);
    local_42 = uint(int(13));
    uint _e297 = local_41;
    uint _e298 = local_42;
    local_112 = uint((_e297 + _e298));
    uint _e302 = local_112;
    out_.Store(_e302*4, asuint(_e288));
    uint _e311 = local;
    local_43 = _e311;
    uint _e313 = local_43;
    local_44 = uint(_e313);
    local_45 = uint(int(14));
    uint _e319 = local_44;
    uint _e320 = local_45;
    local_113 = uint((_e319 + _e320));
    uint _e324 = local_113;
    out_.Store(_e324*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(4u, 0u, 24u))));
    const uint _e330 = _umul24_(int(true), int(true));
    uint _e331 = local;
    local_46 = _e331;
    uint _e333 = local_46;
    local_47 = uint(_e333);
    local_48 = uint(int(15));
    uint _e339 = local_47;
    uint _e340 = local_48;
    local_114 = uint((_e339 + _e340));
    uint _e344 = local_114;
    out_.Store(_e344*4, asuint(_e330));
    uint _e354 = local;
    local_49 = _e354;
    uint _e356 = local_49;
    local_50 = uint(_e356);
    local_51 = uint(int(16));
    uint _e362 = local_50;
    uint _e363 = local_51;
    local_115 = uint((_e362 + _e363));
    uint _e367 = local_115;
    out_.Store(_e367*4, asuint((naga_extractBits(3u, 0u, 24u) * naga_extractBits(uint(int(4)), 0u, 24u))));
    const int _e372 = signed_pair(naga_neg(int(7)), int(3));
    uint _e374 = local;
    local_52 = _e374;
    uint _e376 = local_52;
    local_53 = uint(_e376);
    local_54 = uint(int(17));
    uint _e382 = local_53;
    uint _e383 = local_54;
    local_116 = uint((_e382 + _e383));
    uint _e387 = local_116;
    out_.Store(_e387*4, asuint(uint(_e372)));
    uint _e409 = local;
    local_55 = _e409;
    uint _e411 = local_55;
    local_56 = uint(_e411);
    local_57 = uint(int(18));
    uint _e417 = local_56;
    uint _e418 = local_57;
    local_117 = uint((_e417 + _e418));
    uint _e422 = local_117;
    out_.Store(_e422*4, asuint(uint(asint((asuint(naga_extractBits(asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u)))), 0u, 24u)) * asuint(naga_extractBits(int(5), 0u, 24u)))))));
    uint _e437 = local;
    local_58 = _e437;
    uint _e439 = local_58;
    local_59 = uint(_e439);
    local_60 = uint(int(19));
    uint _e445 = local_59;
    uint _e446 = local_60;
    local_118 = uint((_e445 + _e446));
    uint _e450 = local_118;
    out_.Store(_e450*4, asuint((naga_extractBits((naga_extractBits(16777215u, 0u, 24u) * naga_extractBits(2u, 0u, 24u)), 0u, 24u) * naga_extractBits(2u, 0u, 24u))));
    first = int(-3);
    second = 5u;
    int _e456 = first;
    uint _e457 = second;
    uint _e468 = local;
    local_61 = _e468;
    uint _e470 = local_61;
    local_62 = uint(_e470);
    local_63 = uint(int(20));
    uint _e476 = local_62;
    uint _e477 = local_63;
    local_119 = uint((_e476 + _e477));
    uint _e481 = local_119;
    out_.Store(_e481*4, asuint(uint(asint((asuint(naga_extractBits(_e456, 0u, 24u)) * asuint(naga_extractBits(int(_e457), 0u, 24u)))))));
    int _e483 = first;
    uint _e485 = second;
    uint _e491 = local;
    local_64 = _e491;
    uint _e493 = local_64;
    local_65 = uint(_e493);
    local_66 = uint(int(21));
    uint _e499 = local_65;
    uint _e500 = local_66;
    local_120 = uint((_e499 + _e500));
    uint _e504 = local_120;
    out_.Store(_e504*4, asuint((naga_extractBits(uint(_e483), 0u, 24u) * naga_extractBits(_e485, 0u, 24u))));
    uint _e517 = local;
    local_67 = _e517;
    uint _e519 = local_67;
    local_68 = uint(_e519);
    local_69 = uint(int(22));
    uint _e525 = local_68;
    uint _e526 = local_69;
    local_121 = uint((_e525 + _e526));
    uint _e530 = local_121;
    out_.Store(_e530*4, asuint(uint(asint((asuint(naga_extractBits(int(25165824), 0u, 24u)) * asuint(naga_extractBits(int(16777217), 0u, 24u)))))));
    uint _e539 = local;
    local_70 = _e539;
    uint _e541 = local_70;
    local_71 = uint(_e541);
    local_72 = uint(int(23));
    uint _e547 = local_71;
    uint _e548 = local_72;
    local_122 = uint((_e547 + _e548));
    uint _e552 = local_122;
    out_.Store(_e552*4, asuint((naga_extractBits(4286578688u, 0u, 24u) * naga_extractBits(4278190081u, 0u, 24u))));
    if (true) {
        local_76 = asint((asuint(naga_extractBits(naga_neg(int(3)), 0u, 24u)) * asuint(naga_extractBits(int(7), 0u, 24u))));
    } else {
        local_76 = asint((asuint(naga_extractBits(int(0), 0u, 24u)) * asuint(naga_extractBits(int(0), 0u, 24u))));
    }
    int _e579 = local_76;
    uint _e581 = local;
    local_73 = _e581;
    uint _e583 = local_73;
    local_74 = uint(_e583);
    local_75 = uint(int(24));
    uint _e589 = local_74;
    uint _e590 = local_75;
    local_123 = uint((_e589 + _e590));
    uint _e594 = local_123;
    out_.Store(_e594*4, asuint(uint(_e579)));
    values[0] = asint((asuint(naga_extractBits(int(2), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u))));
    values[1] = asint((asuint(naga_extractBits(int(3), 0u, 24u)) * asuint(naga_extractBits(int(4), 0u, 24u))));
    int _e623 = values[int(0)];
    int _e624 = values[int(1)];
    uint _e627 = local;
    local_77 = _e627;
    uint _e629 = local_77;
    local_78 = uint(_e629);
    local_79 = uint(int(25));
    uint _e635 = local_78;
    uint _e636 = local_79;
    local_124 = uint((_e635 + _e636));
    uint _e640 = local_124;
    out_.Store(_e640*4, asuint(uint(asint(asuint(_e623) + asuint(_e624)))));
    Count = int(2);
    scratch = ZeroValuearray2_int_();
    int _e648 = Count;
    int _e649 = scratch[int(0)];
    uint _e652 = local;
    local_81 = _e652;
    uint _e654 = local_81;
    local_82 = uint(_e654);
    local_83 = uint(int(26));
    uint _e660 = local_82;
    uint _e661 = local_83;
    local_125 = uint((_e660 + _e661));
    uint _e665 = local_125;
    out_.Store(_e665*4, asuint(uint(asint(asuint(_e648) + asuint(_e649)))));
    counter = int(2);
    int _e669 = counter;
    counter = asint(asuint(_e669) + asuint(int(1)));
    int _e672 = counter;
    counter = asint(asuint(_e672) + asuint(int(1)));
    uint _e684 = local;
    local_84 = _e684;
    uint _e686 = local_84;
    local_85 = uint(_e686);
    local_86 = uint(int(27));
    uint _e692 = local_85;
    uint _e693 = local_86;
    local_126 = uint((_e692 + _e693));
    uint _e697 = local_126;
    out_.Store(_e697*4, asuint(uint(asint((asuint(naga_extractBits(_e669, 0u, 24u)) * asuint(naga_extractBits(_e672, 0u, 24u)))))));
    int _e699 = counter;
    uint _e701 = local;
    local_87 = _e701;
    uint _e703 = local_87;
    local_88 = uint(_e703);
    local_89 = uint(int(28));
    uint _e709 = local_88;
    uint _e710 = local_89;
    local_127 = uint((_e709 + _e710));
    uint _e714 = local_127;
    out_.Store(_e714*4, asuint(uint(_e699)));
    total = int(0);
    {
        index = int(0);
        uint2 loop_bound = uint2(4294967295u, 4294967295u);
        bool loop_init = true;
        while(true) {
            if (all(loop_bound == uint2(0u, 0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                int _e737 = index;
                index = asint(asuint(_e737) + asuint(int(1)));
            }
            loop_init = false;
            int _e720 = index;
            if ((_e720 < int(3))) {
            } else {
                break;
            }
            int _e723 = index;
            int _e735 = total;
            total = asint(asuint(_e735) + asuint(asint((asuint(naga_extractBits(asint(asuint(_e723) + asuint(int(1))), 0u, 24u)) * asuint(naga_extractBits(int(2), 0u, 24u))))));
        }
    }
    int _e740 = total;
    uint _e742 = local;
    local_90 = _e742;
    uint _e744 = local_90;
    local_91 = uint(_e744);
    local_92 = uint(int(29));
    uint _e750 = local_91;
    uint _e751 = local_92;
    local_128 = uint((_e750 + _e751));
    uint _e755 = local_128;
    out_.Store(_e755*4, asuint(uint(_e740)));
    {
        uint _e760 = local;
        local_93 = _e760;
        uint _e762 = local_93;
        local_94 = uint(_e762);
        local_95 = uint(int(30));
        uint _e768 = local_94;
        uint _e769 = local_95;
        local_129 = uint((_e768 + _e769));
        uint _e773 = local_129;
        out_.Store(_e773*4, asuint(uint(naga_f2i32(9.75))));
    }
    uint _e786 = local;
    local_96 = _e786;
    uint _e788 = local_96;
    local_97 = uint(_e788);
    local_98 = uint(int(31));
    uint _e794 = local_97;
    uint _e795 = local_98;
    local_130 = uint((_e794 + _e795));
    uint _e799 = local_130;
    out_.Store(_e799*4, asuint(uint(asint((asuint(naga_extractBits(int(16777215), 0u, 24u)) * asuint(naga_extractBits(int(3), 0u, 24u)))))));
}
