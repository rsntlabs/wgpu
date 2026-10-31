struct Record_cuda_record_0_ {
    int value;
    int history[2];
};

ByteAddressBuffer input_1 : register(t0);
RWByteAddressBuffer out_1 : register(u1);

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
    bool local_188 = (bool)0;

    value_7 = value_6;
    int _e4 = value_7.x;
    bool _e5 = (_e4 == int(0));
    local_188 = _e5;
    if (_e5) {
        int _e9 = value_7.y;
        local_188 = (_e9 == int(0));
    }
    bool _e11 = local_188;
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
    uint local_189 = (uint)0;
    uint local_190 = (uint)0;

    left_18 = left_17;
    right_18 = right_17;
    int _e5 = left_18.x;
    int _e7 = right_18.x;
    local_189 = uint(_e7);
    uint _e10 = local_189;
    int _e13 = left_18.y;
    int _e15 = right_18.y;
    local_190 = uint(_e15);
    uint _e18 = local_190;
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

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

[numthreads(2, 1, 1)]
void operator_functions(uint3 threadIdx : SV_GroupThreadID)
{
    uint input[2] = (uint[2])0;
    uint out_[2] = (uint[2])0;
    uint base = (uint)0;
    int2 left = (int2)0;
    uint local[2] = (uint[2])0;
    uint local_1 = (uint)0;
    int2 right = (int2)0;
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
    uint local_50[2] = (uint[2])0;
    uint local_51 = (uint)0;
    uint local_52[2] = (uint[2])0;
    uint local_53 = (uint)0;
    Record_cuda_record_0_ original = (Record_cuda_record_0_)0;
    Record_cuda_record_0_ scaled = (Record_cuda_record_0_)0;
    uint local_54[2] = (uint[2])0;
    uint local_55 = (uint)0;
    Record_cuda_record_0_ local_56 = (Record_cuda_record_0_)0;
    uint local_57[2] = (uint[2])0;
    uint local_58 = (uint)0;
    uint local_59[2] = (uint[2])0;
    uint local_60 = (uint)0;
    uint local_61[2] = (uint[2])0;
    uint local_62 = (uint)0;
    uint local_63[2] = (uint[2])0;
    uint local_64 = (uint)0;
    uint local_65[2] = (uint[2])0;
    uint local_66 = (uint)0;
    uint local_67[2] = (uint[2])0;
    uint local_68 = (uint)0;
    uint local_69[2] = (uint[2])0;
    uint local_70 = (uint)0;
    uint local_71[2] = (uint[2])0;
    uint local_72 = (uint)0;
    uint local_73[2] = (uint[2])0;
    uint local_74 = (uint)0;
    int2 local_75 = (int2)0;
    uint local_76[2] = (uint[2])0;
    uint local_77 = (uint)0;
    uint local_78 = (uint)0;
    int2 local_79 = (int2)0;
    uint local_80[2] = (uint[2])0;
    uint local_81 = (uint)0;
    uint local_82 = (uint)0;
    uint local_83[2] = (uint[2])0;
    uint local_84 = (uint)0;
    uint local_85 = (uint)0;
    uint local_86[2] = (uint[2])0;
    uint local_87 = (uint)0;
    uint local_88 = (uint)0;
    uint local_89[2] = (uint[2])0;
    uint local_90 = (uint)0;
    uint local_91 = (uint)0;
    uint local_92[2] = (uint[2])0;
    uint local_93 = (uint)0;
    uint local_94 = (uint)0;
    uint local_95[2] = (uint[2])0;
    uint local_96 = (uint)0;
    uint local_97 = (uint)0;
    uint local_98[2] = (uint[2])0;
    uint local_99 = (uint)0;
    uint local_100 = (uint)0;
    uint local_101[2] = (uint[2])0;
    uint local_102 = (uint)0;
    uint local_103 = (uint)0;
    uint local_104[2] = (uint[2])0;
    uint local_105 = (uint)0;
    uint local_106 = (uint)0;
    uint local_107[2] = (uint[2])0;
    uint local_108 = (uint)0;
    uint local_109 = (uint)0;
    uint local_110[2] = (uint[2])0;
    uint local_111 = (uint)0;
    uint local_112 = (uint)0;
    uint local_113[2] = (uint[2])0;
    uint local_114 = (uint)0;
    uint local_115 = (uint)0;
    uint local_116[2] = (uint[2])0;
    uint local_117 = (uint)0;
    uint local_118 = (uint)0;
    uint local_119[2] = (uint[2])0;
    uint local_120 = (uint)0;
    uint local_121 = (uint)0;
    uint local_122[2] = (uint[2])0;
    uint local_123 = (uint)0;
    uint local_124 = (uint)0;
    uint local_125[2] = (uint[2])0;
    uint local_126 = (uint)0;
    uint local_127 = (uint)0;
    uint local_128[2] = (uint[2])0;
    uint local_129 = (uint)0;
    uint local_130 = (uint)0;
    uint local_131[2] = (uint[2])0;
    uint local_132 = (uint)0;
    uint local_133 = (uint)0;
    uint local_134[2] = (uint[2])0;
    uint local_135 = (uint)0;
    uint local_136 = (uint)0;
    uint local_137[2] = (uint[2])0;
    uint local_138 = (uint)0;
    uint local_139 = (uint)0;
    uint local_140[2] = (uint[2])0;
    uint local_141 = (uint)0;
    uint local_142 = (uint)0;
    uint local_143[2] = (uint[2])0;
    uint local_144 = (uint)0;
    uint local_145 = (uint)0;
    uint local_146[2] = (uint[2])0;
    uint local_147 = (uint)0;
    uint local_148 = (uint)0;
    uint local_149[2] = (uint[2])0;
    uint local_150 = (uint)0;
    uint local_151 = (uint)0;
    uint local_152[2] = (uint[2])0;
    uint local_153 = (uint)0;
    uint local_154 = (uint)0;
    uint local_155[2] = (uint[2])0;
    uint local_156 = (uint)0;
    uint local_157 = (uint)0;
    uint local_158[2] = (uint[2])0;
    uint local_159 = (uint)0;
    uint local_160 = (uint)0;
    uint local_161[2] = (uint[2])0;
    uint local_162 = (uint)0;
    uint local_163 = (uint)0;
    uint local_164[2] = (uint[2])0;
    uint local_165 = (uint)0;
    uint local_166 = (uint)0;
    uint local_167[2] = (uint[2])0;
    uint local_168 = (uint)0;
    uint local_169 = (uint)0;
    uint local_170[2] = (uint[2])0;
    uint local_171 = (uint)0;
    uint local_172 = (uint)0;
    uint local_173[2] = (uint[2])0;
    uint local_174 = (uint)0;
    uint local_175 = (uint)0;
    uint local_176[2] = (uint[2])0;
    uint local_177 = (uint)0;
    uint local_178 = (uint)0;
    uint local_179[2] = (uint[2])0;
    uint local_180 = (uint)0;
    uint local_181 = (uint)0;
    uint local_182[2] = (uint[2])0;
    uint local_183 = (uint)0;
    uint local_184 = (uint)0;
    uint local_185[2] = (uint[2])0;
    uint local_186 = (uint)0;
    uint local_187 = (uint)0;

    input = ZeroValuearray2_uint_();
    input[0] = 0u;
    input[1] = 0u;
    out_ = ZeroValuearray2_uint_();
    out_[0] = 1u;
    out_[1] = 0u;
    base = (threadIdx.x * 36u);
    uint _e21[2] = input;
    local = _e21;
    local_1 = uint(threadIdx.x);
    uint _e26[2] = local;
    local_76 = _e26;
    uint _e27 = local_1;
    uint _e29 = local_76[1];
    local_76[1] = (_e29 + _e27);
    uint _e33 = local_76[0];
    local_77 = uint(_e33);
    uint _e37 = local_76[1];
    local_78 = uint(_e37);
    uint _e41 = local_78;
    int2 _e43 = asint(input_1.Load2(_e41*8));
    local_79 = _e43;
    int2 _e44 = local_79;
    local_75 = _e44;
    int2 _e46 = local_75;
    left = _e46;
    right = int2(int(3), int(2));
    int2 _e52 = left;
    const int2 _e53 = operator_u002b(_e52);
    uint _e57[2] = out_;
    local_2 = _e57;
    uint _e58 = base;
    local_3 = uint((_e58 + 0u));
    uint _e65[2] = local_2;
    local_80 = _e65;
    uint _e66 = local_3;
    uint _e68 = local_80[1];
    local_80[1] = (_e68 + _e66);
    uint _e72 = local_80[0];
    local_81 = uint(_e72);
    uint _e76 = local_80[1];
    local_82 = uint(_e76);
    uint _e79 = local_82;
    out_1.Store(_e79*4, asuint(uint(_e53.x)));
    int2 _e81 = left;
    const int2 _e82 = operator_u002d(_e81);
    uint _e85[2] = out_;
    local_4 = _e85;
    uint _e86 = base;
    local_5 = uint((_e86 + 1u));
    uint _e93[2] = local_4;
    local_83 = _e93;
    uint _e94 = local_5;
    uint _e96 = local_83[1];
    local_83[1] = (_e96 + _e94);
    uint _e100 = local_83[0];
    local_84 = uint(_e100);
    uint _e104 = local_83[1];
    local_85 = uint(_e104);
    uint _e107 = local_85;
    out_1.Store(_e107*4, asuint(uint(_e82.y)));
    int2 _e109 = left;
    const int2 _e110 = operator_u007e(_e109);
    uint _e113[2] = out_;
    local_6 = _e113;
    uint _e114 = base;
    local_7 = uint((_e114 + 2u));
    uint _e121[2] = local_6;
    local_86 = _e121;
    uint _e122 = local_7;
    uint _e124 = local_86[1];
    local_86[1] = (_e124 + _e122);
    uint _e128 = local_86[0];
    local_87 = uint(_e128);
    uint _e132 = local_86[1];
    local_88 = uint(_e132);
    uint _e135 = local_88;
    out_1.Store(_e135*4, asuint(uint(_e110.x)));
    int2 _e137 = left;
    const bool _e138 = operator_u0021_(_e137);
    uint _e140[2] = out_;
    local_8 = _e140;
    uint _e141 = base;
    local_9 = uint((_e141 + 3u));
    uint _e148[2] = local_8;
    local_89 = _e148;
    uint _e149 = local_9;
    uint _e151 = local_89[1];
    local_89[1] = (_e151 + _e149);
    uint _e155 = local_89[0];
    local_90 = uint(_e155);
    uint _e159 = local_89[1];
    local_91 = uint(_e159);
    uint _e162 = local_91;
    out_1.Store(_e162*4, asuint(uint(_e138)));
    int2 _e164 = left;
    const int _e165 = operator_u002a(_e164);
    uint _e167[2] = out_;
    local_10 = _e167;
    uint _e168 = base;
    local_11 = uint((_e168 + 4u));
    uint _e175[2] = local_10;
    local_92 = _e175;
    uint _e176 = local_11;
    uint _e178 = local_92[1];
    local_92[1] = (_e178 + _e176);
    uint _e182 = local_92[0];
    local_93 = uint(_e182);
    uint _e186 = local_92[1];
    local_94 = uint(_e186);
    uint _e189 = local_94;
    out_1.Store(_e189*4, asuint(uint(_e165)));
    int2 _e191 = left;
    const int2 _e192 = operator_u0026_(_e191);
    uint _e195[2] = out_;
    local_12 = _e195;
    uint _e196 = base;
    local_13 = uint((_e196 + 5u));
    uint _e203[2] = local_12;
    local_95 = _e203;
    uint _e204 = local_13;
    uint _e206 = local_95[1];
    local_95[1] = (_e206 + _e204);
    uint _e210 = local_95[0];
    local_96 = uint(_e210);
    uint _e214 = local_95[1];
    local_97 = uint(_e214);
    uint _e217 = local_97;
    out_1.Store(_e217*4, asuint(uint(_e192.x)));
    int2 _e219 = left;
    int2 _e220 = right;
    const int2 _e221 = operator_u002b_1(_e219, _e220);
    uint _e224[2] = out_;
    local_14 = _e224;
    uint _e225 = base;
    local_15 = uint((_e225 + 6u));
    uint _e232[2] = local_14;
    local_98 = _e232;
    uint _e233 = local_15;
    uint _e235 = local_98[1];
    local_98[1] = (_e235 + _e233);
    uint _e239 = local_98[0];
    local_99 = uint(_e239);
    uint _e243 = local_98[1];
    local_100 = uint(_e243);
    uint _e246 = local_100;
    out_1.Store(_e246*4, asuint(uint(_e221.x)));
    int2 _e248 = left;
    int2 _e249 = right;
    const int2 _e250 = operator_u002d_1(_e248, _e249);
    uint _e253[2] = out_;
    local_16 = _e253;
    uint _e254 = base;
    local_17 = uint((_e254 + 7u));
    uint _e261[2] = local_16;
    local_101 = _e261;
    uint _e262 = local_17;
    uint _e264 = local_101[1];
    local_101[1] = (_e264 + _e262);
    uint _e268 = local_101[0];
    local_102 = uint(_e268);
    uint _e272 = local_101[1];
    local_103 = uint(_e272);
    uint _e275 = local_103;
    out_1.Store(_e275*4, asuint(uint(_e250.y)));
    int2 _e277 = left;
    int2 _e278 = right;
    const int2 _e279 = operator_u002a_1(_e277, _e278);
    uint _e282[2] = out_;
    local_18 = _e282;
    uint _e283 = base;
    local_19 = uint((_e283 + 8u));
    uint _e290[2] = local_18;
    local_104 = _e290;
    uint _e291 = local_19;
    uint _e293 = local_104[1];
    local_104[1] = (_e293 + _e291);
    uint _e297 = local_104[0];
    local_105 = uint(_e297);
    uint _e301 = local_104[1];
    local_106 = uint(_e301);
    uint _e304 = local_106;
    out_1.Store(_e304*4, asuint(uint(_e279.x)));
    int2 _e306 = left;
    int2 _e307 = right;
    const int2 _e308 = operator_u002f(_e306, _e307);
    uint _e311[2] = out_;
    local_20 = _e311;
    uint _e312 = base;
    local_21 = uint((_e312 + 9u));
    uint _e319[2] = local_20;
    local_107 = _e319;
    uint _e320 = local_21;
    uint _e322 = local_107[1];
    local_107[1] = (_e322 + _e320);
    uint _e326 = local_107[0];
    local_108 = uint(_e326);
    uint _e330 = local_107[1];
    local_109 = uint(_e330);
    uint _e333 = local_109;
    out_1.Store(_e333*4, asuint(uint(_e308.y)));
    int2 _e335 = left;
    int2 _e336 = right;
    const int2 _e337 = operator_u0025_(_e335, _e336);
    uint _e340[2] = out_;
    local_22 = _e340;
    uint _e341 = base;
    local_23 = uint((_e341 + 10u));
    uint _e348[2] = local_22;
    local_110 = _e348;
    uint _e349 = local_23;
    uint _e351 = local_110[1];
    local_110[1] = (_e351 + _e349);
    uint _e355 = local_110[0];
    local_111 = uint(_e355);
    uint _e359 = local_110[1];
    local_112 = uint(_e359);
    uint _e362 = local_112;
    out_1.Store(_e362*4, asuint(uint(_e337.y)));
    int2 _e364 = left;
    int2 _e365 = right;
    const int2 _e366 = operator_u0026_1(_e364, _e365);
    uint _e369[2] = out_;
    local_24 = _e369;
    uint _e370 = base;
    local_25 = uint((_e370 + 11u));
    uint _e377[2] = local_24;
    local_113 = _e377;
    uint _e378 = local_25;
    uint _e380 = local_113[1];
    local_113[1] = (_e380 + _e378);
    uint _e384 = local_113[0];
    local_114 = uint(_e384);
    uint _e388 = local_113[1];
    local_115 = uint(_e388);
    uint _e391 = local_115;
    out_1.Store(_e391*4, asuint(uint(_e366.x)));
    int2 _e393 = left;
    int2 _e394 = right;
    const int2 _e395 = operator_u007c(_e393, _e394);
    uint _e398[2] = out_;
    local_26 = _e398;
    uint _e399 = base;
    local_27 = uint((_e399 + 12u));
    uint _e406[2] = local_26;
    local_116 = _e406;
    uint _e407 = local_27;
    uint _e409 = local_116[1];
    local_116[1] = (_e409 + _e407);
    uint _e413 = local_116[0];
    local_117 = uint(_e413);
    uint _e417 = local_116[1];
    local_118 = uint(_e417);
    uint _e420 = local_118;
    out_1.Store(_e420*4, asuint(uint(_e395.y)));
    int2 _e422 = left;
    int2 _e423 = right;
    const int2 _e424 = operator_u005e(_e422, _e423);
    uint _e427[2] = out_;
    local_28 = _e427;
    uint _e428 = base;
    local_29 = uint((_e428 + 13u));
    uint _e435[2] = local_28;
    local_119 = _e435;
    uint _e436 = local_29;
    uint _e438 = local_119[1];
    local_119[1] = (_e438 + _e436);
    uint _e442 = local_119[0];
    local_120 = uint(_e442);
    uint _e446 = local_119[1];
    local_121 = uint(_e446);
    uint _e449 = local_121;
    out_1.Store(_e449*4, asuint(uint(_e424.x)));
    int2 _e451 = left;
    int2 _e452 = right;
    const int2 _e453 = operator_(_e451, _e452);
    uint _e456[2] = out_;
    local_30 = _e456;
    uint _e457 = base;
    local_31 = uint((_e457 + 14u));
    uint _e464[2] = local_30;
    local_122 = _e464;
    uint _e465 = local_31;
    uint _e467 = local_122[1];
    local_122[1] = (_e467 + _e465);
    uint _e471 = local_122[0];
    local_123 = uint(_e471);
    uint _e475 = local_122[1];
    local_124 = uint(_e475);
    uint _e478 = local_124;
    out_1.Store(_e478*4, asuint(uint(_e453.x)));
    int2 _e480 = left;
    int2 _e481 = right;
    const int2 _e482 = operator_1(_e480, _e481);
    uint _e485[2] = out_;
    local_32 = _e485;
    uint _e486 = base;
    local_33 = uint((_e486 + 15u));
    uint _e493[2] = local_32;
    local_125 = _e493;
    uint _e494 = local_33;
    uint _e496 = local_125[1];
    local_125[1] = (_e496 + _e494);
    uint _e500 = local_125[0];
    local_126 = uint(_e500);
    uint _e504 = local_125[1];
    local_127 = uint(_e504);
    uint _e507 = local_127;
    out_1.Store(_e507*4, asuint(uint(_e482.y)));
    int2 _e509 = left;
    const int2 _e510 = operator_u002b(_e509);
    uint _e513[2] = out_;
    local_34 = _e513;
    uint _e514 = base;
    local_35 = uint((_e514 + 16u));
    uint _e521[2] = local_34;
    local_128 = _e521;
    uint _e522 = local_35;
    uint _e524 = local_128[1];
    local_128[1] = (_e524 + _e522);
    uint _e528 = local_128[0];
    local_129 = uint(_e528);
    uint _e532 = local_128[1];
    local_130 = uint(_e532);
    uint _e535 = local_130;
    out_1.Store(_e535*4, asuint(uint(_e510.y)));
    int2 _e537 = left;
    int2 _e538 = right;
    const int2 _e539 = operator_u002d_1(_e537, _e538);
    uint _e542[2] = out_;
    local_36 = _e542;
    uint _e543 = base;
    local_37 = uint((_e543 + 17u));
    uint _e550[2] = local_36;
    local_131 = _e550;
    uint _e551 = local_37;
    uint _e553 = local_131[1];
    local_131[1] = (_e553 + _e551);
    uint _e557 = local_131[0];
    local_132 = uint(_e557);
    uint _e561 = local_131[1];
    local_133 = uint(_e561);
    uint _e564 = local_133;
    out_1.Store(_e564*4, asuint(uint(_e539.x)));
    int2 _e566 = left;
    const int _e567 = operator_u002a(_e566);
    uint _e569[2] = out_;
    local_38 = _e569;
    uint _e570 = base;
    local_39 = uint((_e570 + 18u));
    uint _e577[2] = local_38;
    local_134 = _e577;
    uint _e578 = local_39;
    uint _e580 = local_134[1];
    local_134[1] = (_e580 + _e578);
    uint _e584 = local_134[0];
    local_135 = uint(_e584);
    uint _e588 = local_134[1];
    local_136 = uint(_e588);
    uint _e591 = local_136;
    out_1.Store(_e591*4, asuint(uint(_e567)));
    int2 _e593 = left;
    int2 _e594 = right;
    const int2 _e595 = operator_u0026_1(_e593, _e594);
    uint _e598[2] = out_;
    local_40 = _e598;
    uint _e599 = base;
    local_41 = uint((_e599 + 19u));
    uint _e606[2] = local_40;
    local_137 = _e606;
    uint _e607 = local_41;
    uint _e609 = local_137[1];
    local_137[1] = (_e609 + _e607);
    uint _e613 = local_137[0];
    local_138 = uint(_e613);
    uint _e617 = local_137[1];
    local_139 = uint(_e617);
    uint _e620 = local_139;
    out_1.Store(_e620*4, asuint(uint(_e595.y)));
    int2 _e622 = left;
    const int2 _e623 = operator_u0026_(_e622);
    const int _e624 = operator_u002a(_e623);
    uint _e626[2] = out_;
    local_42 = _e626;
    uint _e627 = base;
    local_43 = uint((_e627 + 20u));
    uint _e634[2] = local_42;
    local_140 = _e634;
    uint _e635 = local_43;
    uint _e637 = local_140[1];
    local_140[1] = (_e637 + _e635);
    uint _e641 = local_140[0];
    local_141 = uint(_e641);
    uint _e645 = local_140[1];
    local_142 = uint(_e645);
    uint _e648 = local_142;
    out_1.Store(_e648*4, asuint(uint(_e624)));
    int2 _e650 = left;
    const int2 _e651 = operator_u0026_(_e650);
    const int2 _e652 = operator_u0026_(_e651);
    uint _e655[2] = out_;
    local_44 = _e655;
    uint _e656 = base;
    local_45 = uint((_e656 + 21u));
    uint _e663[2] = local_44;
    local_143 = _e663;
    uint _e664 = local_45;
    uint _e666 = local_143[1];
    local_143[1] = (_e666 + _e664);
    uint _e670 = local_143[0];
    local_144 = uint(_e670);
    uint _e674 = local_143[1];
    local_145 = uint(_e674);
    uint _e677 = local_145;
    out_1.Store(_e677*4, asuint(uint(_e652.x)));
    int2 _e679 = left;
    int2 _e680 = right;
    int2 _e681 = right;
    const int2 _e682 = operator_u002a_1(_e680, _e681);
    const int2 _e683 = operator_u002b_1(_e679, _e682);
    uint _e686[2] = out_;
    local_46 = _e686;
    uint _e687 = base;
    local_47 = uint((_e687 + 22u));
    uint _e694[2] = local_46;
    local_146 = _e694;
    uint _e695 = local_47;
    uint _e697 = local_146[1];
    local_146[1] = (_e697 + _e695);
    uint _e701 = local_146[0];
    local_147 = uint(_e701);
    uint _e705 = local_146[1];
    local_148 = uint(_e705);
    uint _e708 = local_148;
    out_1.Store(_e708*4, asuint(uint(_e683.x)));
    int2 _e710 = left;
    int2 _e711 = right;
    const int2 _e715 = operator_u002b_1(_e711, int2(int(1), int(1)));
    const int2 _e716 = operator_(_e710, _e715);
    uint _e719[2] = out_;
    local_48 = _e719;
    uint _e720 = base;
    local_49 = uint((_e720 + 23u));
    uint _e727[2] = local_48;
    local_149 = _e727;
    uint _e728 = local_49;
    uint _e730 = local_149[1];
    local_149[1] = (_e730 + _e728);
    uint _e734 = local_149[0];
    local_150 = uint(_e734);
    uint _e738 = local_149[1];
    local_151 = uint(_e738);
    uint _e741 = local_151;
    out_1.Store(_e741*4, asuint(uint(_e716.x)));
    int2 _e743 = left;
    int2 _e744 = right;
    const int2 _e748 = operator_u0026_1(_e744, int2(int(1), int(1)));
    const int2 _e749 = operator_u007c(_e743, _e748);
    uint _e752[2] = out_;
    local_50 = _e752;
    uint _e753 = base;
    local_51 = uint((_e753 + 24u));
    uint _e760[2] = local_50;
    local_152 = _e760;
    uint _e761 = local_51;
    uint _e763 = local_152[1];
    local_152[1] = (_e763 + _e761);
    uint _e767 = local_152[0];
    local_153 = uint(_e767);
    uint _e771 = local_152[1];
    local_154 = uint(_e771);
    uint _e774 = local_154;
    out_1.Store(_e774*4, asuint(uint(_e749.y)));
    int2 _e776 = left;
    int2 _e777 = right;
    const int2 _e778 = operator_u002d_1(_e776, _e777);
    int2 _e779 = right;
    const int2 _e780 = operator_u002d_1(_e778, _e779);
    uint _e783[2] = out_;
    local_52 = _e783;
    uint _e784 = base;
    local_53 = uint((_e784 + 25u));
    uint _e791[2] = local_52;
    local_155 = _e791;
    uint _e792 = local_53;
    uint _e794 = local_155[1];
    local_155[1] = (_e794 + _e792);
    uint _e798 = local_155[0];
    local_156 = uint(_e798);
    uint _e802 = local_155[1];
    local_157 = uint(_e802);
    uint _e805 = local_157;
    out_1.Store(_e805*4, asuint(uint(_e780.x)));
    original.value = int(9);
    original.history[0] = int(1);
    original.history[1] = int(2);
    Record_cuda_record_0_ _e815 = original;
    const Record_cuda_record_0_ _e817 = operator_u002a_3(_e815, int(3));
    scaled = _e817;
    local_56.value = int(9);
    local_56.history[0] = int(1);
    local_56.history[1] = int(2);
    Record_cuda_record_0_ _e827 = local_56;
    const int _e828 = operator_u0026_2(_e827);
    uint _e830[2] = out_;
    local_54 = _e830;
    uint _e831 = base;
    local_55 = uint((_e831 + 26u));
    uint _e838[2] = local_54;
    local_158 = _e838;
    uint _e839 = local_55;
    uint _e841 = local_158[1];
    local_158[1] = (_e841 + _e839);
    uint _e845 = local_158[0];
    local_159 = uint(_e845);
    uint _e849 = local_158[1];
    local_160 = uint(_e849);
    uint _e852 = local_160;
    out_1.Store(_e852*4, asuint(uint(_e828)));
    Record_cuda_record_0_ _e854 = original;
    const Record_cuda_record_0_ _e855 = operator_u002a_2(_e854);
    const int _e856 = operator_u0026_2(_e855);
    uint _e858[2] = out_;
    local_57 = _e858;
    uint _e859 = base;
    local_58 = uint((_e859 + 27u));
    uint _e866[2] = local_57;
    local_161 = _e866;
    uint _e867 = local_58;
    uint _e869 = local_161[1];
    local_161[1] = (_e869 + _e867);
    uint _e873 = local_161[0];
    local_162 = uint(_e873);
    uint _e877 = local_161[1];
    local_163 = uint(_e877);
    uint _e880 = local_163;
    out_1.Store(_e880*4, asuint(uint(_e856)));
    int _e883 = scaled.value;
    uint _e885[2] = out_;
    local_59 = _e885;
    uint _e886 = base;
    local_60 = uint((_e886 + 28u));
    uint _e893[2] = local_59;
    local_164 = _e893;
    uint _e894 = local_60;
    uint _e896 = local_164[1];
    local_164[1] = (_e896 + _e894);
    uint _e900 = local_164[0];
    local_165 = uint(_e900);
    uint _e904 = local_164[1];
    local_166 = uint(_e904);
    uint _e907 = local_166;
    out_1.Store(_e907*4, asuint(uint(_e883)));
    int _e912 = scaled.history[int(1)];
    uint _e914[2] = out_;
    local_61 = _e914;
    uint _e915 = base;
    local_62 = uint((_e915 + 29u));
    uint _e922[2] = local_61;
    local_167 = _e922;
    uint _e923 = local_62;
    uint _e925 = local_167[1];
    local_167[1] = (_e925 + _e923);
    uint _e929 = local_167[0];
    local_168 = uint(_e929);
    uint _e933 = local_167[1];
    local_169 = uint(_e933);
    uint _e936 = local_169;
    out_1.Store(_e936*4, asuint(uint(_e912)));
    int _e939 = original.value;
    uint _e941[2] = out_;
    local_63 = _e941;
    uint _e942 = base;
    local_64 = uint((_e942 + 30u));
    uint _e949[2] = local_63;
    local_170 = _e949;
    uint _e950 = local_64;
    uint _e952 = local_170[1];
    local_170[1] = (_e952 + _e950);
    uint _e956 = local_170[0];
    local_171 = uint(_e956);
    uint _e960 = local_170[1];
    local_172 = uint(_e960);
    uint _e963 = local_172;
    out_1.Store(_e963*4, asuint(uint(_e939)));
    int _e968 = original.history[int(1)];
    uint _e970[2] = out_;
    local_65 = _e970;
    uint _e971 = base;
    local_66 = uint((_e971 + 31u));
    uint _e978[2] = local_65;
    local_173 = _e978;
    uint _e979 = local_66;
    uint _e981 = local_173[1];
    local_173[1] = (_e981 + _e979);
    uint _e985 = local_173[0];
    local_174 = uint(_e985);
    uint _e989 = local_173[1];
    local_175 = uint(_e989);
    uint _e992 = local_175;
    out_1.Store(_e992*4, asuint(uint(_e968)));
    Record_cuda_record_0_ _e994 = original;
    const Record_cuda_record_0_ _e995 = operator_u002d_2(_e994);
    uint _e998[2] = out_;
    local_67 = _e998;
    uint _e999 = base;
    local_68 = uint((_e999 + 32u));
    uint _e1006[2] = local_67;
    local_176 = _e1006;
    uint _e1007 = local_68;
    uint _e1009 = local_176[1];
    local_176[1] = (_e1009 + _e1007);
    uint _e1013 = local_176[0];
    local_177 = uint(_e1013);
    uint _e1017 = local_176[1];
    local_178 = uint(_e1017);
    uint _e1020 = local_178;
    out_1.Store(_e1020*4, asuint(uint(_e995.value)));
    Record_cuda_record_0_ _e1022 = original;
    const Record_cuda_record_0_ _e1024 = operator_u002a_3(_e1022, int(2));
    uint _e1027[2] = out_;
    local_69 = _e1027;
    uint _e1028 = base;
    local_70 = uint((_e1028 + 33u));
    uint _e1035[2] = local_69;
    local_179 = _e1035;
    uint _e1036 = local_70;
    uint _e1038 = local_179[1];
    local_179[1] = (_e1038 + _e1036);
    uint _e1042 = local_179[0];
    local_180 = uint(_e1042);
    uint _e1046 = local_179[1];
    local_181 = uint(_e1046);
    uint _e1049 = local_181;
    out_1.Store(_e1049*4, asuint(uint(_e1024.value)));
    Record_cuda_record_0_ _e1051 = original;
    const Record_cuda_record_0_ _e1052 = operator_u002a_2(_e1051);
    const int _e1053 = operator_u0026_2(_e1052);
    uint _e1055[2] = out_;
    local_71 = _e1055;
    uint _e1056 = base;
    local_72 = uint((_e1056 + 34u));
    uint _e1063[2] = local_71;
    local_182 = _e1063;
    uint _e1064 = local_72;
    uint _e1066 = local_182[1];
    local_182[1] = (_e1066 + _e1064);
    uint _e1070 = local_182[0];
    local_183 = uint(_e1070);
    uint _e1074 = local_182[1];
    local_184 = uint(_e1074);
    uint _e1077 = local_184;
    out_1.Store(_e1077*4, asuint(uint(_e1053)));
    const bool _e1082 = operator_u0021_(int2(int(0), int(0)));
    uint _e1084[2] = out_;
    local_73 = _e1084;
    uint _e1085 = base;
    local_74 = uint((_e1085 + 35u));
    uint _e1092[2] = local_73;
    local_185 = _e1092;
    uint _e1093 = local_74;
    uint _e1095 = local_185[1];
    local_185[1] = (_e1095 + _e1093);
    uint _e1099 = local_185[0];
    local_186 = uint(_e1099);
    uint _e1103 = local_185[1];
    local_187 = uint(_e1103);
    uint _e1106 = local_187;
    out_1.Store(_e1106*4, asuint(uint(_e1082)));
}
