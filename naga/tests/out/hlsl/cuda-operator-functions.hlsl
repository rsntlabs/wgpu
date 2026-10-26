struct Record_cuda_record_0_ {
    int value;
    int history[2];
};

ByteAddressBuffer input : register(t0);
RWByteAddressBuffer out_ : register(u1);

int2 operator_u002b(int2 value)
{
    int2 value_1 = (int2)0;

    value_1 = value;
    int _e3 = value_1.x;
    int _e5 = value_1.y;
    return int2(_e3, _e5);
}

int naga_neg(int val) {
    return asint(-asuint(val));
}

int2 operator_u002d(int2 value_2)
{
    int2 value_3 = (int2)0;

    value_3 = value_2;
    int _e3 = value_3.x;
    int _e6 = value_3.y;
    return int2(naga_neg(_e3), naga_neg(_e6));
}

int2 operator_u007e(int2 value_4)
{
    int2 value_5 = (int2)0;

    value_5 = value_4;
    int _e3 = value_5.x;
    int _e6 = value_5.y;
    return int2(~(_e3), ~(_e6));
}

bool operator_u0021_(int2 value_6)
{
    int2 value_7 = (int2)0;
    bool local_152 = (bool)0;

    value_7 = value_6;
    int _e4 = value_7.x;
    bool _e5 = (_e4 == int(0));
    local_152 = _e5;
    if (_e5) {
        int _e9 = value_7.y;
        local_152 = (_e9 == int(0));
    }
    bool _e11 = local_152;
    return _e11;
}

int operator_u002a(int2 value_8)
{
    int2 value_9 = (int2)0;

    value_9 = value_8;
    int _e4 = value_9.x;
    int _e7 = value_9.y;
    return asint(asuint(asint(asuint(_e4) * asuint(int(10)))) + asuint(_e7));
}

int2 operator_u0026_(int2 value_10)
{
    int2 value_11 = (int2)0;

    value_11 = value_10;
    int _e3 = value_11.y;
    int _e5 = value_11.x;
    return int2(_e3, _e5);
}

int2 operator_u002b_1(int2 left_1, int2 right_1)
{
    int2 left_2 = (int2)0;
    int2 right_2 = (int2)0;

    left_2 = left_1;
    right_2 = right_1;
    int _e6 = left_2.x;
    int _e7 = right_2.x;
    int _e11 = left_2.y;
    int _e12 = right_2.y;
    return int2(asint(asuint(_e6) + asuint(_e7)), asint(asuint(_e11) + asuint(_e12)));
}

int2 operator_u002d_1(int2 left_3, int2 right_3)
{
    int2 left_4 = (int2)0;
    int2 right_4 = (int2)0;

    left_4 = left_3;
    right_4 = right_3;
    int _e6 = left_4.x;
    int _e7 = right_4.x;
    int _e11 = left_4.y;
    int _e12 = right_4.y;
    return int2(asint(asuint(_e6) - asuint(_e7)), asint(asuint(_e11) - asuint(_e12)));
}

int2 operator_u002a_1(int2 left_5, int2 right_5)
{
    int2 left_6 = (int2)0;
    int2 right_6 = (int2)0;

    left_6 = left_5;
    right_6 = right_5;
    int _e6 = left_6.x;
    int _e7 = right_6.x;
    int _e11 = left_6.y;
    int _e12 = right_6.y;
    return int2(asint(asuint(_e6) * asuint(_e7)), asint(asuint(_e11) * asuint(_e12)));
}

int naga_div(int lhs, int rhs) {
    return lhs / (((lhs == int(-2147483647 - 1) & rhs == -1) | (rhs == 0)) ? 1 : rhs);
}

int2 operator_u002f(int2 left_7, int2 right_7)
{
    int2 left_8 = (int2)0;
    int2 right_8 = (int2)0;

    left_8 = left_7;
    right_8 = right_7;
    int _e6 = left_8.x;
    int _e7 = right_8.x;
    int _e11 = left_8.y;
    int _e12 = right_8.y;
    return int2(naga_div(_e6, _e7), naga_div(_e11, _e12));
}

int naga_mod(int lhs, int rhs) {
    int divisor = ((lhs == int(-2147483647 - 1) & rhs == -1) | (rhs == 0)) ? 1 : rhs;
    return lhs - (lhs / divisor) * divisor;
}

int2 operator_u0025_(int2 left_9, int2 right_9)
{
    int2 left_10 = (int2)0;
    int2 right_10 = (int2)0;

    left_10 = left_9;
    right_10 = right_9;
    int _e6 = left_10.x;
    int _e7 = right_10.x;
    int _e11 = left_10.y;
    int _e12 = right_10.y;
    return int2(naga_mod(_e6, _e7), naga_mod(_e11, _e12));
}

int2 operator_u0026_1(int2 left_11, int2 right_11)
{
    int2 left_12 = (int2)0;
    int2 right_12 = (int2)0;

    left_12 = left_11;
    right_12 = right_11;
    int _e6 = left_12.x;
    int _e7 = right_12.x;
    int _e11 = left_12.y;
    int _e12 = right_12.y;
    return int2((_e6 & _e7), (_e11 & _e12));
}

int2 operator_u007c(int2 left_13, int2 right_13)
{
    int2 left_14 = (int2)0;
    int2 right_14 = (int2)0;

    left_14 = left_13;
    right_14 = right_13;
    int _e6 = left_14.x;
    int _e7 = right_14.x;
    int _e11 = left_14.y;
    int _e12 = right_14.y;
    return int2((_e6 | _e7), (_e11 | _e12));
}

int2 operator_u005e(int2 left_15, int2 right_15)
{
    int2 left_16 = (int2)0;
    int2 right_16 = (int2)0;

    left_16 = left_15;
    right_16 = right_15;
    int _e6 = left_16.x;
    int _e7 = right_16.x;
    int _e11 = left_16.y;
    int _e12 = right_16.y;
    return int2((_e6 ^ _e7), (_e11 ^ _e12));
}

int2 operator_(int2 left_17, int2 right_17)
{
    int2 left_18 = (int2)0;
    int2 right_18 = (int2)0;
    uint local_153 = (uint)0;
    uint local_154 = (uint)0;

    left_18 = left_17;
    right_18 = right_17;
    int _e5 = left_18.x;
    int _e7 = right_18.x;
    local_153 = uint(_e7);
    uint _e10 = local_153;
    int _e13 = left_18.y;
    int _e15 = right_18.y;
    local_154 = uint(_e15);
    uint _e18 = local_154;
    return int2((_e5 << _e10), (_e13 << _e18));
}

int2 operator_1(int2 left_19, int2 right_19)
{
    int2 left_20 = (int2)0;
    int2 right_20 = (int2)0;

    left_20 = left_19;
    right_20 = right_19;
    int _e5 = left_20.x;
    int _e7 = right_20.x;
    int _e11 = left_20.y;
    int _e13 = right_20.y;
    return int2((_e5 >> uint(_e7)), (_e11 >> uint(_e13)));
}

Record_cuda_record_0_ operator_u002a_2(Record_cuda_record_0_ value_12)
{
    Record_cuda_record_0_ value_13 = (Record_cuda_record_0_)0;

    value_13 = value_12;
    int _e3 = value_13.value;
    value_13.value = asint(asuint(_e3) + asuint(int(1)));
    Record_cuda_record_0_ _e6 = value_13;
    const Record_cuda_record_0_ record_cuda_record_0_ = _e6;
    return record_cuda_record_0_;
}

int operator_u0026_2(Record_cuda_record_0_ value_14)
{
    Record_cuda_record_0_ value_15 = (Record_cuda_record_0_)0;

    value_15 = value_14;
    int _e3 = value_15.value;
    return _e3;
}

Record_cuda_record_0_ operator_u002d_2(Record_cuda_record_0_ value_16)
{
    Record_cuda_record_0_ value_17 = (Record_cuda_record_0_)0;

    value_17 = value_16;
    int _e4 = value_17.value;
    value_17.value = naga_neg(_e4);
    Record_cuda_record_0_ _e6 = value_17;
    const Record_cuda_record_0_ record_cuda_record_0_1 = _e6;
    return record_cuda_record_0_1;
}

Record_cuda_record_0_ operator_u002a_3(Record_cuda_record_0_ value_18, int factor)
{
    Record_cuda_record_0_ value_19 = (Record_cuda_record_0_)0;
    int factor_1 = (int)0;

    value_19 = value_18;
    factor_1 = factor;
    int _e5 = factor_1;
    int _e6 = value_19.value;
    value_19.value = asint(asuint(_e6) * asuint(_e5));
    int _e11 = factor_1;
    int _e12 = value_19.history[int(1)];
    value_19.history[int(1)] = asint(asuint(_e12) + asuint(_e11));
    Record_cuda_record_0_ _e14 = value_19;
    const Record_cuda_record_0_ record_cuda_record_0_2 = _e14;
    return record_cuda_record_0_2;
}

[numthreads(2, 1, 1)]
void operator_functions(uint3 threadIdx : SV_GroupThreadID)
{
    uint local = (uint)0;
    uint local_1 = (uint)0;
    uint base = (uint)0;
    int2 left = (int2)0;
    uint local_2 = (uint)0;
    uint local_3 = (uint)0;
    uint local_4 = (uint)0;
    int2 right = (int2)0;
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
    uint local_76 = (uint)0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    uint local_79 = (uint)0;
    uint local_80 = (uint)0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    Record_cuda_record_0_ original = (Record_cuda_record_0_)0;
    Record_cuda_record_0_ scaled = (Record_cuda_record_0_)0;
    uint local_83 = (uint)0;
    uint local_84 = (uint)0;
    uint local_85 = (uint)0;
    Record_cuda_record_0_ local_86 = (Record_cuda_record_0_)0;
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
    uint local_109 = (uint)0;
    uint local_110 = (uint)0;
    uint local_111 = (uint)0;
    uint local_112 = (uint)0;
    uint local_113 = (uint)0;
    uint local_114 = (uint)0;
    int2 local_115 = (int2)0;
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
    uint local_131 = (uint)0;
    uint local_132 = (uint)0;
    uint local_133 = (uint)0;
    uint local_134 = (uint)0;
    uint local_135 = (uint)0;
    uint local_136 = (uint)0;
    uint local_137 = (uint)0;
    uint local_138 = (uint)0;
    uint local_139 = (uint)0;
    uint local_140 = (uint)0;
    uint local_141 = (uint)0;
    uint local_142 = (uint)0;
    uint local_143 = (uint)0;
    uint local_144 = (uint)0;
    uint local_145 = (uint)0;
    uint local_146 = (uint)0;
    uint local_147 = (uint)0;
    uint local_148 = (uint)0;
    uint local_149 = (uint)0;
    uint local_150 = (uint)0;
    uint local_151 = (uint)0;

    local = 0u;
    local_1 = 0u;
    base = (threadIdx.x * 36u);
    uint _e9 = local;
    local_2 = _e9;
    uint _e11 = local_2;
    local_3 = uint(_e11);
    local_4 = uint(threadIdx.x);
    uint _e18 = local_3;
    uint _e19 = local_4;
    local_114 = uint((_e18 + _e19));
    uint _e24 = local_114;
    int2 _e26 = asint(input.Load2(_e24*8));
    local_115 = _e26;
    int2 _e27 = local_115;
    left = _e27;
    right = int2(int(3), int(2));
    int2 _e33 = left;
    const int2 _e34 = operator_u002b(_e33);
    uint _e36 = local_1;
    local_5 = _e36;
    uint _e38 = local_5;
    local_6 = uint(_e38);
    uint _e41 = base;
    local_7 = uint((_e41 + 0u));
    uint _e48 = local_6;
    uint _e49 = local_7;
    local_116 = uint((_e48 + _e49));
    uint _e53 = local_116;
    out_.Store(_e53*4, asuint(uint(_e34.x)));
    int2 _e55 = left;
    const int2 _e56 = operator_u002d(_e55);
    uint _e58 = local_1;
    local_8 = _e58;
    uint _e60 = local_8;
    local_9 = uint(_e60);
    uint _e63 = base;
    local_10 = uint((_e63 + 1u));
    uint _e69 = local_9;
    uint _e70 = local_10;
    local_117 = uint((_e69 + _e70));
    uint _e74 = local_117;
    out_.Store(_e74*4, asuint(uint(_e56.y)));
    int2 _e76 = left;
    const int2 _e77 = operator_u007e(_e76);
    uint _e79 = local_1;
    local_11 = _e79;
    uint _e81 = local_11;
    local_12 = uint(_e81);
    uint _e84 = base;
    local_13 = uint((_e84 + 2u));
    uint _e90 = local_12;
    uint _e91 = local_13;
    local_118 = uint((_e90 + _e91));
    uint _e95 = local_118;
    out_.Store(_e95*4, asuint(uint(_e77.x)));
    int2 _e97 = left;
    const bool _e98 = operator_u0021_(_e97);
    uint _e99 = local_1;
    local_14 = _e99;
    uint _e101 = local_14;
    local_15 = uint(_e101);
    uint _e104 = base;
    local_16 = uint((_e104 + 3u));
    uint _e110 = local_15;
    uint _e111 = local_16;
    local_119 = uint((_e110 + _e111));
    uint _e115 = local_119;
    out_.Store(_e115*4, asuint(uint(_e98)));
    int2 _e117 = left;
    const int _e118 = operator_u002a(_e117);
    uint _e119 = local_1;
    local_17 = _e119;
    uint _e121 = local_17;
    local_18 = uint(_e121);
    uint _e124 = base;
    local_19 = uint((_e124 + 4u));
    uint _e130 = local_18;
    uint _e131 = local_19;
    local_120 = uint((_e130 + _e131));
    uint _e135 = local_120;
    out_.Store(_e135*4, asuint(uint(_e118)));
    int2 _e137 = left;
    const int2 _e138 = operator_u0026_(_e137);
    uint _e140 = local_1;
    local_20 = _e140;
    uint _e142 = local_20;
    local_21 = uint(_e142);
    uint _e145 = base;
    local_22 = uint((_e145 + 5u));
    uint _e151 = local_21;
    uint _e152 = local_22;
    local_121 = uint((_e151 + _e152));
    uint _e156 = local_121;
    out_.Store(_e156*4, asuint(uint(_e138.x)));
    int2 _e158 = left;
    int2 _e159 = right;
    const int2 _e160 = operator_u002b_1(_e158, _e159);
    uint _e162 = local_1;
    local_23 = _e162;
    uint _e164 = local_23;
    local_24 = uint(_e164);
    uint _e167 = base;
    local_25 = uint((_e167 + 6u));
    uint _e173 = local_24;
    uint _e174 = local_25;
    local_122 = uint((_e173 + _e174));
    uint _e178 = local_122;
    out_.Store(_e178*4, asuint(uint(_e160.x)));
    int2 _e180 = left;
    int2 _e181 = right;
    const int2 _e182 = operator_u002d_1(_e180, _e181);
    uint _e184 = local_1;
    local_26 = _e184;
    uint _e186 = local_26;
    local_27 = uint(_e186);
    uint _e189 = base;
    local_28 = uint((_e189 + 7u));
    uint _e195 = local_27;
    uint _e196 = local_28;
    local_123 = uint((_e195 + _e196));
    uint _e200 = local_123;
    out_.Store(_e200*4, asuint(uint(_e182.y)));
    int2 _e202 = left;
    int2 _e203 = right;
    const int2 _e204 = operator_u002a_1(_e202, _e203);
    uint _e206 = local_1;
    local_29 = _e206;
    uint _e208 = local_29;
    local_30 = uint(_e208);
    uint _e211 = base;
    local_31 = uint((_e211 + 8u));
    uint _e217 = local_30;
    uint _e218 = local_31;
    local_124 = uint((_e217 + _e218));
    uint _e222 = local_124;
    out_.Store(_e222*4, asuint(uint(_e204.x)));
    int2 _e224 = left;
    int2 _e225 = right;
    const int2 _e226 = operator_u002f(_e224, _e225);
    uint _e228 = local_1;
    local_32 = _e228;
    uint _e230 = local_32;
    local_33 = uint(_e230);
    uint _e233 = base;
    local_34 = uint((_e233 + 9u));
    uint _e239 = local_33;
    uint _e240 = local_34;
    local_125 = uint((_e239 + _e240));
    uint _e244 = local_125;
    out_.Store(_e244*4, asuint(uint(_e226.y)));
    int2 _e246 = left;
    int2 _e247 = right;
    const int2 _e248 = operator_u0025_(_e246, _e247);
    uint _e250 = local_1;
    local_35 = _e250;
    uint _e252 = local_35;
    local_36 = uint(_e252);
    uint _e255 = base;
    local_37 = uint((_e255 + 10u));
    uint _e261 = local_36;
    uint _e262 = local_37;
    local_126 = uint((_e261 + _e262));
    uint _e266 = local_126;
    out_.Store(_e266*4, asuint(uint(_e248.y)));
    int2 _e268 = left;
    int2 _e269 = right;
    const int2 _e270 = operator_u0026_1(_e268, _e269);
    uint _e272 = local_1;
    local_38 = _e272;
    uint _e274 = local_38;
    local_39 = uint(_e274);
    uint _e277 = base;
    local_40 = uint((_e277 + 11u));
    uint _e283 = local_39;
    uint _e284 = local_40;
    local_127 = uint((_e283 + _e284));
    uint _e288 = local_127;
    out_.Store(_e288*4, asuint(uint(_e270.x)));
    int2 _e290 = left;
    int2 _e291 = right;
    const int2 _e292 = operator_u007c(_e290, _e291);
    uint _e294 = local_1;
    local_41 = _e294;
    uint _e296 = local_41;
    local_42 = uint(_e296);
    uint _e299 = base;
    local_43 = uint((_e299 + 12u));
    uint _e305 = local_42;
    uint _e306 = local_43;
    local_128 = uint((_e305 + _e306));
    uint _e310 = local_128;
    out_.Store(_e310*4, asuint(uint(_e292.y)));
    int2 _e312 = left;
    int2 _e313 = right;
    const int2 _e314 = operator_u005e(_e312, _e313);
    uint _e316 = local_1;
    local_44 = _e316;
    uint _e318 = local_44;
    local_45 = uint(_e318);
    uint _e321 = base;
    local_46 = uint((_e321 + 13u));
    uint _e327 = local_45;
    uint _e328 = local_46;
    local_129 = uint((_e327 + _e328));
    uint _e332 = local_129;
    out_.Store(_e332*4, asuint(uint(_e314.x)));
    int2 _e334 = left;
    int2 _e335 = right;
    const int2 _e336 = operator_(_e334, _e335);
    uint _e338 = local_1;
    local_47 = _e338;
    uint _e340 = local_47;
    local_48 = uint(_e340);
    uint _e343 = base;
    local_49 = uint((_e343 + 14u));
    uint _e349 = local_48;
    uint _e350 = local_49;
    local_130 = uint((_e349 + _e350));
    uint _e354 = local_130;
    out_.Store(_e354*4, asuint(uint(_e336.x)));
    int2 _e356 = left;
    int2 _e357 = right;
    const int2 _e358 = operator_1(_e356, _e357);
    uint _e360 = local_1;
    local_50 = _e360;
    uint _e362 = local_50;
    local_51 = uint(_e362);
    uint _e365 = base;
    local_52 = uint((_e365 + 15u));
    uint _e371 = local_51;
    uint _e372 = local_52;
    local_131 = uint((_e371 + _e372));
    uint _e376 = local_131;
    out_.Store(_e376*4, asuint(uint(_e358.y)));
    int2 _e378 = left;
    const int2 _e379 = operator_u002b(_e378);
    uint _e381 = local_1;
    local_53 = _e381;
    uint _e383 = local_53;
    local_54 = uint(_e383);
    uint _e386 = base;
    local_55 = uint((_e386 + 16u));
    uint _e392 = local_54;
    uint _e393 = local_55;
    local_132 = uint((_e392 + _e393));
    uint _e397 = local_132;
    out_.Store(_e397*4, asuint(uint(_e379.y)));
    int2 _e399 = left;
    int2 _e400 = right;
    const int2 _e401 = operator_u002d_1(_e399, _e400);
    uint _e403 = local_1;
    local_56 = _e403;
    uint _e405 = local_56;
    local_57 = uint(_e405);
    uint _e408 = base;
    local_58 = uint((_e408 + 17u));
    uint _e414 = local_57;
    uint _e415 = local_58;
    local_133 = uint((_e414 + _e415));
    uint _e419 = local_133;
    out_.Store(_e419*4, asuint(uint(_e401.x)));
    int2 _e421 = left;
    const int _e422 = operator_u002a(_e421);
    uint _e423 = local_1;
    local_59 = _e423;
    uint _e425 = local_59;
    local_60 = uint(_e425);
    uint _e428 = base;
    local_61 = uint((_e428 + 18u));
    uint _e434 = local_60;
    uint _e435 = local_61;
    local_134 = uint((_e434 + _e435));
    uint _e439 = local_134;
    out_.Store(_e439*4, asuint(uint(_e422)));
    int2 _e441 = left;
    int2 _e442 = right;
    const int2 _e443 = operator_u0026_1(_e441, _e442);
    uint _e445 = local_1;
    local_62 = _e445;
    uint _e447 = local_62;
    local_63 = uint(_e447);
    uint _e450 = base;
    local_64 = uint((_e450 + 19u));
    uint _e456 = local_63;
    uint _e457 = local_64;
    local_135 = uint((_e456 + _e457));
    uint _e461 = local_135;
    out_.Store(_e461*4, asuint(uint(_e443.y)));
    int2 _e463 = left;
    const int2 _e464 = operator_u0026_(_e463);
    const int _e465 = operator_u002a(_e464);
    uint _e466 = local_1;
    local_65 = _e466;
    uint _e468 = local_65;
    local_66 = uint(_e468);
    uint _e471 = base;
    local_67 = uint((_e471 + 20u));
    uint _e477 = local_66;
    uint _e478 = local_67;
    local_136 = uint((_e477 + _e478));
    uint _e482 = local_136;
    out_.Store(_e482*4, asuint(uint(_e465)));
    int2 _e484 = left;
    const int2 _e485 = operator_u0026_(_e484);
    const int2 _e486 = operator_u0026_(_e485);
    uint _e488 = local_1;
    local_68 = _e488;
    uint _e490 = local_68;
    local_69 = uint(_e490);
    uint _e493 = base;
    local_70 = uint((_e493 + 21u));
    uint _e499 = local_69;
    uint _e500 = local_70;
    local_137 = uint((_e499 + _e500));
    uint _e504 = local_137;
    out_.Store(_e504*4, asuint(uint(_e486.x)));
    int2 _e506 = left;
    int2 _e507 = right;
    int2 _e508 = right;
    const int2 _e509 = operator_u002a_1(_e507, _e508);
    const int2 _e510 = operator_u002b_1(_e506, _e509);
    uint _e512 = local_1;
    local_71 = _e512;
    uint _e514 = local_71;
    local_72 = uint(_e514);
    uint _e517 = base;
    local_73 = uint((_e517 + 22u));
    uint _e523 = local_72;
    uint _e524 = local_73;
    local_138 = uint((_e523 + _e524));
    uint _e528 = local_138;
    out_.Store(_e528*4, asuint(uint(_e510.x)));
    int2 _e530 = left;
    int2 _e531 = right;
    const int2 _e535 = operator_u002b_1(_e531, int2(int(1), int(1)));
    const int2 _e536 = operator_(_e530, _e535);
    uint _e538 = local_1;
    local_74 = _e538;
    uint _e540 = local_74;
    local_75 = uint(_e540);
    uint _e543 = base;
    local_76 = uint((_e543 + 23u));
    uint _e549 = local_75;
    uint _e550 = local_76;
    local_139 = uint((_e549 + _e550));
    uint _e554 = local_139;
    out_.Store(_e554*4, asuint(uint(_e536.x)));
    int2 _e556 = left;
    int2 _e557 = right;
    const int2 _e561 = operator_u0026_1(_e557, int2(int(1), int(1)));
    const int2 _e562 = operator_u007c(_e556, _e561);
    uint _e564 = local_1;
    local_77 = _e564;
    uint _e566 = local_77;
    local_78 = uint(_e566);
    uint _e569 = base;
    local_79 = uint((_e569 + 24u));
    uint _e575 = local_78;
    uint _e576 = local_79;
    local_140 = uint((_e575 + _e576));
    uint _e580 = local_140;
    out_.Store(_e580*4, asuint(uint(_e562.y)));
    int2 _e582 = left;
    int2 _e583 = right;
    const int2 _e584 = operator_u002d_1(_e582, _e583);
    int2 _e585 = right;
    const int2 _e586 = operator_u002d_1(_e584, _e585);
    uint _e588 = local_1;
    local_80 = _e588;
    uint _e590 = local_80;
    local_81 = uint(_e590);
    uint _e593 = base;
    local_82 = uint((_e593 + 25u));
    uint _e599 = local_81;
    uint _e600 = local_82;
    local_141 = uint((_e599 + _e600));
    uint _e604 = local_141;
    out_.Store(_e604*4, asuint(uint(_e586.x)));
    original.value = int(9);
    original.history[0] = int(1);
    original.history[1] = int(2);
    Record_cuda_record_0_ _e614 = original;
    const Record_cuda_record_0_ _e616 = operator_u002a_3(_e614, int(3));
    scaled = _e616;
    local_86.value = int(9);
    local_86.history[0] = int(1);
    local_86.history[1] = int(2);
    Record_cuda_record_0_ _e626 = local_86;
    const int _e627 = operator_u0026_2(_e626);
    uint _e628 = local_1;
    local_83 = _e628;
    uint _e630 = local_83;
    local_84 = uint(_e630);
    uint _e633 = base;
    local_85 = uint((_e633 + 26u));
    uint _e639 = local_84;
    uint _e640 = local_85;
    local_142 = uint((_e639 + _e640));
    uint _e644 = local_142;
    out_.Store(_e644*4, asuint(uint(_e627)));
    Record_cuda_record_0_ _e646 = original;
    const Record_cuda_record_0_ _e647 = operator_u002a_2(_e646);
    const int _e648 = operator_u0026_2(_e647);
    uint _e649 = local_1;
    local_87 = _e649;
    uint _e651 = local_87;
    local_88 = uint(_e651);
    uint _e654 = base;
    local_89 = uint((_e654 + 27u));
    uint _e660 = local_88;
    uint _e661 = local_89;
    local_143 = uint((_e660 + _e661));
    uint _e665 = local_143;
    out_.Store(_e665*4, asuint(uint(_e648)));
    int _e668 = scaled.value;
    uint _e669 = local_1;
    local_90 = _e669;
    uint _e671 = local_90;
    local_91 = uint(_e671);
    uint _e674 = base;
    local_92 = uint((_e674 + 28u));
    uint _e680 = local_91;
    uint _e681 = local_92;
    local_144 = uint((_e680 + _e681));
    uint _e685 = local_144;
    out_.Store(_e685*4, asuint(uint(_e668)));
    int _e690 = scaled.history[int(1)];
    uint _e691 = local_1;
    local_93 = _e691;
    uint _e693 = local_93;
    local_94 = uint(_e693);
    uint _e696 = base;
    local_95 = uint((_e696 + 29u));
    uint _e702 = local_94;
    uint _e703 = local_95;
    local_145 = uint((_e702 + _e703));
    uint _e707 = local_145;
    out_.Store(_e707*4, asuint(uint(_e690)));
    int _e710 = original.value;
    uint _e711 = local_1;
    local_96 = _e711;
    uint _e713 = local_96;
    local_97 = uint(_e713);
    uint _e716 = base;
    local_98 = uint((_e716 + 30u));
    uint _e722 = local_97;
    uint _e723 = local_98;
    local_146 = uint((_e722 + _e723));
    uint _e727 = local_146;
    out_.Store(_e727*4, asuint(uint(_e710)));
    int _e732 = original.history[int(1)];
    uint _e733 = local_1;
    local_99 = _e733;
    uint _e735 = local_99;
    local_100 = uint(_e735);
    uint _e738 = base;
    local_101 = uint((_e738 + 31u));
    uint _e744 = local_100;
    uint _e745 = local_101;
    local_147 = uint((_e744 + _e745));
    uint _e749 = local_147;
    out_.Store(_e749*4, asuint(uint(_e732)));
    Record_cuda_record_0_ _e751 = original;
    const Record_cuda_record_0_ _e752 = operator_u002d_2(_e751);
    uint _e754 = local_1;
    local_102 = _e754;
    uint _e756 = local_102;
    local_103 = uint(_e756);
    uint _e759 = base;
    local_104 = uint((_e759 + 32u));
    uint _e765 = local_103;
    uint _e766 = local_104;
    local_148 = uint((_e765 + _e766));
    uint _e770 = local_148;
    out_.Store(_e770*4, asuint(uint(_e752.value)));
    Record_cuda_record_0_ _e772 = original;
    const Record_cuda_record_0_ _e774 = operator_u002a_3(_e772, int(2));
    uint _e776 = local_1;
    local_105 = _e776;
    uint _e778 = local_105;
    local_106 = uint(_e778);
    uint _e781 = base;
    local_107 = uint((_e781 + 33u));
    uint _e787 = local_106;
    uint _e788 = local_107;
    local_149 = uint((_e787 + _e788));
    uint _e792 = local_149;
    out_.Store(_e792*4, asuint(uint(_e774.value)));
    Record_cuda_record_0_ _e794 = original;
    const Record_cuda_record_0_ _e795 = operator_u002a_2(_e794);
    const int _e796 = operator_u0026_2(_e795);
    uint _e797 = local_1;
    local_108 = _e797;
    uint _e799 = local_108;
    local_109 = uint(_e799);
    uint _e802 = base;
    local_110 = uint((_e802 + 34u));
    uint _e808 = local_109;
    uint _e809 = local_110;
    local_150 = uint((_e808 + _e809));
    uint _e813 = local_150;
    out_.Store(_e813*4, asuint(uint(_e796)));
    const bool _e818 = operator_u0021_(int2(int(0), int(0)));
    uint _e819 = local_1;
    local_111 = _e819;
    uint _e821 = local_111;
    local_112 = uint(_e821);
    uint _e824 = base;
    local_113 = uint((_e824 + 35u));
    uint _e830 = local_112;
    uint _e831 = local_113;
    local_151 = uint((_e830 + _e831));
    uint _e835 = local_151;
    out_.Store(_e835*4, asuint(uint(_e818)));
}
