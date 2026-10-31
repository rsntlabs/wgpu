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

    value_19 = value_18;
    int _e4 = value_19.value;
    value_19.value = asint(asuint(_e4) * asuint(factor));
    int _e9 = value_19.history[int(1)];
    value_19.history[int(1)] = asint(asuint(_e9) + asuint(factor));
    Record_cuda_record_0_ _e11 = value_19;
    const Record_cuda_record_0_ record_cuda_record_0_2 = _e11;
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
    uint base = (threadIdx.x * 36u);
    uint _e17[2] = input;
    local = _e17;
    local_1 = uint(threadIdx.x);
    uint _e22[2] = local;
    local_76 = _e22;
    uint _e24 = local_1;
    uint _e26 = local_76[1];
    local_76[1] = (_e26 + _e24);
    uint _e30 = local_76[0];
    local_77 = uint(_e30);
    uint _e34 = local_76[1];
    local_78 = uint(_e34);
    uint _e37 = local_78;
    int2 _e40 = asint(input_1.Load2(_e37*8));
    local_79 = _e40;
    int2 _e42 = local_79;
    local_75 = _e42;
    int2 _e44 = local_75;
    left = _e44;
    right = int2(int(3), int(2));
    int2 _e50 = left;
    const int2 _e51 = operator_u002b(_e50);
    uint _e54[2] = out_;
    local_2 = _e54;
    local_3 = uint((base + 0u));
    uint _e61[2] = local_2;
    local_80 = _e61;
    uint _e63 = local_3;
    uint _e65 = local_80[1];
    local_80[1] = (_e65 + _e63);
    uint _e69 = local_80[0];
    local_81 = uint(_e69);
    uint _e73 = local_80[1];
    local_82 = uint(_e73);
    uint _e76 = local_82;
    out_1.Store(_e76*4, asuint(uint(_e51.x)));
    int2 _e79 = left;
    const int2 _e80 = operator_u002d(_e79);
    uint _e82[2] = out_;
    local_4 = _e82;
    local_5 = uint((base + 1u));
    uint _e89[2] = local_4;
    local_83 = _e89;
    uint _e91 = local_5;
    uint _e93 = local_83[1];
    local_83[1] = (_e93 + _e91);
    uint _e97 = local_83[0];
    local_84 = uint(_e97);
    uint _e101 = local_83[1];
    local_85 = uint(_e101);
    uint _e104 = local_85;
    out_1.Store(_e104*4, asuint(uint(_e80.y)));
    int2 _e106 = left;
    const int2 _e107 = operator_u007e(_e106);
    uint _e109[2] = out_;
    local_6 = _e109;
    local_7 = uint((base + 2u));
    uint _e116[2] = local_6;
    local_86 = _e116;
    uint _e118 = local_7;
    uint _e120 = local_86[1];
    local_86[1] = (_e120 + _e118);
    uint _e124 = local_86[0];
    local_87 = uint(_e124);
    uint _e128 = local_86[1];
    local_88 = uint(_e128);
    uint _e131 = local_88;
    out_1.Store(_e131*4, asuint(uint(_e107.x)));
    int2 _e133 = left;
    const bool _e134 = operator_u0021_(_e133);
    uint _e135[2] = out_;
    local_8 = _e135;
    local_9 = uint((base + 3u));
    uint _e142[2] = local_8;
    local_89 = _e142;
    uint _e144 = local_9;
    uint _e146 = local_89[1];
    local_89[1] = (_e146 + _e144);
    uint _e150 = local_89[0];
    local_90 = uint(_e150);
    uint _e154 = local_89[1];
    local_91 = uint(_e154);
    uint _e157 = local_91;
    out_1.Store(_e157*4, asuint(uint(_e134)));
    int2 _e159 = left;
    const int _e160 = operator_u002a(_e159);
    uint _e161[2] = out_;
    local_10 = _e161;
    local_11 = uint((base + 4u));
    uint _e168[2] = local_10;
    local_92 = _e168;
    uint _e170 = local_11;
    uint _e172 = local_92[1];
    local_92[1] = (_e172 + _e170);
    uint _e176 = local_92[0];
    local_93 = uint(_e176);
    uint _e180 = local_92[1];
    local_94 = uint(_e180);
    uint _e183 = local_94;
    out_1.Store(_e183*4, asuint(uint(_e160)));
    int2 _e185 = left;
    const int2 _e186 = operator_u0026_(_e185);
    uint _e188[2] = out_;
    local_12 = _e188;
    local_13 = uint((base + 5u));
    uint _e195[2] = local_12;
    local_95 = _e195;
    uint _e197 = local_13;
    uint _e199 = local_95[1];
    local_95[1] = (_e199 + _e197);
    uint _e203 = local_95[0];
    local_96 = uint(_e203);
    uint _e207 = local_95[1];
    local_97 = uint(_e207);
    uint _e210 = local_97;
    out_1.Store(_e210*4, asuint(uint(_e186.x)));
    int2 _e212 = left;
    int2 _e213 = right;
    const int2 _e214 = operator_u002b_1(_e212, _e213);
    uint _e216[2] = out_;
    local_14 = _e216;
    local_15 = uint((base + 6u));
    uint _e223[2] = local_14;
    local_98 = _e223;
    uint _e225 = local_15;
    uint _e227 = local_98[1];
    local_98[1] = (_e227 + _e225);
    uint _e231 = local_98[0];
    local_99 = uint(_e231);
    uint _e235 = local_98[1];
    local_100 = uint(_e235);
    uint _e238 = local_100;
    out_1.Store(_e238*4, asuint(uint(_e214.x)));
    int2 _e240 = left;
    int2 _e241 = right;
    const int2 _e242 = operator_u002d_1(_e240, _e241);
    uint _e244[2] = out_;
    local_16 = _e244;
    local_17 = uint((base + 7u));
    uint _e251[2] = local_16;
    local_101 = _e251;
    uint _e253 = local_17;
    uint _e255 = local_101[1];
    local_101[1] = (_e255 + _e253);
    uint _e259 = local_101[0];
    local_102 = uint(_e259);
    uint _e263 = local_101[1];
    local_103 = uint(_e263);
    uint _e266 = local_103;
    out_1.Store(_e266*4, asuint(uint(_e242.y)));
    int2 _e268 = left;
    int2 _e269 = right;
    const int2 _e270 = operator_u002a_1(_e268, _e269);
    uint _e272[2] = out_;
    local_18 = _e272;
    local_19 = uint((base + 8u));
    uint _e279[2] = local_18;
    local_104 = _e279;
    uint _e281 = local_19;
    uint _e283 = local_104[1];
    local_104[1] = (_e283 + _e281);
    uint _e287 = local_104[0];
    local_105 = uint(_e287);
    uint _e291 = local_104[1];
    local_106 = uint(_e291);
    uint _e294 = local_106;
    out_1.Store(_e294*4, asuint(uint(_e270.x)));
    int2 _e296 = left;
    int2 _e297 = right;
    const int2 _e298 = operator_u002f(_e296, _e297);
    uint _e300[2] = out_;
    local_20 = _e300;
    local_21 = uint((base + 9u));
    uint _e307[2] = local_20;
    local_107 = _e307;
    uint _e309 = local_21;
    uint _e311 = local_107[1];
    local_107[1] = (_e311 + _e309);
    uint _e315 = local_107[0];
    local_108 = uint(_e315);
    uint _e319 = local_107[1];
    local_109 = uint(_e319);
    uint _e322 = local_109;
    out_1.Store(_e322*4, asuint(uint(_e298.y)));
    int2 _e324 = left;
    int2 _e325 = right;
    const int2 _e326 = operator_u0025_(_e324, _e325);
    uint _e328[2] = out_;
    local_22 = _e328;
    local_23 = uint((base + 10u));
    uint _e335[2] = local_22;
    local_110 = _e335;
    uint _e337 = local_23;
    uint _e339 = local_110[1];
    local_110[1] = (_e339 + _e337);
    uint _e343 = local_110[0];
    local_111 = uint(_e343);
    uint _e347 = local_110[1];
    local_112 = uint(_e347);
    uint _e350 = local_112;
    out_1.Store(_e350*4, asuint(uint(_e326.y)));
    int2 _e352 = left;
    int2 _e353 = right;
    const int2 _e354 = operator_u0026_1(_e352, _e353);
    uint _e356[2] = out_;
    local_24 = _e356;
    local_25 = uint((base + 11u));
    uint _e363[2] = local_24;
    local_113 = _e363;
    uint _e365 = local_25;
    uint _e367 = local_113[1];
    local_113[1] = (_e367 + _e365);
    uint _e371 = local_113[0];
    local_114 = uint(_e371);
    uint _e375 = local_113[1];
    local_115 = uint(_e375);
    uint _e378 = local_115;
    out_1.Store(_e378*4, asuint(uint(_e354.x)));
    int2 _e380 = left;
    int2 _e381 = right;
    const int2 _e382 = operator_u007c(_e380, _e381);
    uint _e384[2] = out_;
    local_26 = _e384;
    local_27 = uint((base + 12u));
    uint _e391[2] = local_26;
    local_116 = _e391;
    uint _e393 = local_27;
    uint _e395 = local_116[1];
    local_116[1] = (_e395 + _e393);
    uint _e399 = local_116[0];
    local_117 = uint(_e399);
    uint _e403 = local_116[1];
    local_118 = uint(_e403);
    uint _e406 = local_118;
    out_1.Store(_e406*4, asuint(uint(_e382.y)));
    int2 _e408 = left;
    int2 _e409 = right;
    const int2 _e410 = operator_u005e(_e408, _e409);
    uint _e412[2] = out_;
    local_28 = _e412;
    local_29 = uint((base + 13u));
    uint _e419[2] = local_28;
    local_119 = _e419;
    uint _e421 = local_29;
    uint _e423 = local_119[1];
    local_119[1] = (_e423 + _e421);
    uint _e427 = local_119[0];
    local_120 = uint(_e427);
    uint _e431 = local_119[1];
    local_121 = uint(_e431);
    uint _e434 = local_121;
    out_1.Store(_e434*4, asuint(uint(_e410.x)));
    int2 _e436 = left;
    int2 _e437 = right;
    const int2 _e438 = operator_(_e436, _e437);
    uint _e440[2] = out_;
    local_30 = _e440;
    local_31 = uint((base + 14u));
    uint _e447[2] = local_30;
    local_122 = _e447;
    uint _e449 = local_31;
    uint _e451 = local_122[1];
    local_122[1] = (_e451 + _e449);
    uint _e455 = local_122[0];
    local_123 = uint(_e455);
    uint _e459 = local_122[1];
    local_124 = uint(_e459);
    uint _e462 = local_124;
    out_1.Store(_e462*4, asuint(uint(_e438.x)));
    int2 _e464 = left;
    int2 _e465 = right;
    const int2 _e466 = operator_1(_e464, _e465);
    uint _e468[2] = out_;
    local_32 = _e468;
    local_33 = uint((base + 15u));
    uint _e475[2] = local_32;
    local_125 = _e475;
    uint _e477 = local_33;
    uint _e479 = local_125[1];
    local_125[1] = (_e479 + _e477);
    uint _e483 = local_125[0];
    local_126 = uint(_e483);
    uint _e487 = local_125[1];
    local_127 = uint(_e487);
    uint _e490 = local_127;
    out_1.Store(_e490*4, asuint(uint(_e466.y)));
    int2 _e492 = left;
    const int2 _e493 = operator_u002b(_e492);
    uint _e495[2] = out_;
    local_34 = _e495;
    local_35 = uint((base + 16u));
    uint _e502[2] = local_34;
    local_128 = _e502;
    uint _e504 = local_35;
    uint _e506 = local_128[1];
    local_128[1] = (_e506 + _e504);
    uint _e510 = local_128[0];
    local_129 = uint(_e510);
    uint _e514 = local_128[1];
    local_130 = uint(_e514);
    uint _e517 = local_130;
    out_1.Store(_e517*4, asuint(uint(_e493.y)));
    int2 _e519 = left;
    int2 _e520 = right;
    const int2 _e521 = operator_u002d_1(_e519, _e520);
    uint _e523[2] = out_;
    local_36 = _e523;
    local_37 = uint((base + 17u));
    uint _e530[2] = local_36;
    local_131 = _e530;
    uint _e532 = local_37;
    uint _e534 = local_131[1];
    local_131[1] = (_e534 + _e532);
    uint _e538 = local_131[0];
    local_132 = uint(_e538);
    uint _e542 = local_131[1];
    local_133 = uint(_e542);
    uint _e545 = local_133;
    out_1.Store(_e545*4, asuint(uint(_e521.x)));
    int2 _e547 = left;
    const int _e548 = operator_u002a(_e547);
    uint _e549[2] = out_;
    local_38 = _e549;
    local_39 = uint((base + 18u));
    uint _e556[2] = local_38;
    local_134 = _e556;
    uint _e558 = local_39;
    uint _e560 = local_134[1];
    local_134[1] = (_e560 + _e558);
    uint _e564 = local_134[0];
    local_135 = uint(_e564);
    uint _e568 = local_134[1];
    local_136 = uint(_e568);
    uint _e571 = local_136;
    out_1.Store(_e571*4, asuint(uint(_e548)));
    int2 _e573 = left;
    int2 _e574 = right;
    const int2 _e575 = operator_u0026_1(_e573, _e574);
    uint _e577[2] = out_;
    local_40 = _e577;
    local_41 = uint((base + 19u));
    uint _e584[2] = local_40;
    local_137 = _e584;
    uint _e586 = local_41;
    uint _e588 = local_137[1];
    local_137[1] = (_e588 + _e586);
    uint _e592 = local_137[0];
    local_138 = uint(_e592);
    uint _e596 = local_137[1];
    local_139 = uint(_e596);
    uint _e599 = local_139;
    out_1.Store(_e599*4, asuint(uint(_e575.y)));
    int2 _e601 = left;
    const int2 _e602 = operator_u0026_(_e601);
    const int _e603 = operator_u002a(_e602);
    uint _e604[2] = out_;
    local_42 = _e604;
    local_43 = uint((base + 20u));
    uint _e611[2] = local_42;
    local_140 = _e611;
    uint _e613 = local_43;
    uint _e615 = local_140[1];
    local_140[1] = (_e615 + _e613);
    uint _e619 = local_140[0];
    local_141 = uint(_e619);
    uint _e623 = local_140[1];
    local_142 = uint(_e623);
    uint _e626 = local_142;
    out_1.Store(_e626*4, asuint(uint(_e603)));
    int2 _e628 = left;
    const int2 _e629 = operator_u0026_(_e628);
    const int2 _e630 = operator_u0026_(_e629);
    uint _e632[2] = out_;
    local_44 = _e632;
    local_45 = uint((base + 21u));
    uint _e639[2] = local_44;
    local_143 = _e639;
    uint _e641 = local_45;
    uint _e643 = local_143[1];
    local_143[1] = (_e643 + _e641);
    uint _e647 = local_143[0];
    local_144 = uint(_e647);
    uint _e651 = local_143[1];
    local_145 = uint(_e651);
    uint _e654 = local_145;
    out_1.Store(_e654*4, asuint(uint(_e630.x)));
    int2 _e656 = left;
    int2 _e657 = right;
    int2 _e658 = right;
    const int2 _e659 = operator_u002a_1(_e657, _e658);
    const int2 _e660 = operator_u002b_1(_e656, _e659);
    uint _e662[2] = out_;
    local_46 = _e662;
    local_47 = uint((base + 22u));
    uint _e669[2] = local_46;
    local_146 = _e669;
    uint _e671 = local_47;
    uint _e673 = local_146[1];
    local_146[1] = (_e673 + _e671);
    uint _e677 = local_146[0];
    local_147 = uint(_e677);
    uint _e681 = local_146[1];
    local_148 = uint(_e681);
    uint _e684 = local_148;
    out_1.Store(_e684*4, asuint(uint(_e660.x)));
    int2 _e686 = left;
    int2 _e687 = right;
    const int2 _e691 = operator_u002b_1(_e687, int2(int(1), int(1)));
    const int2 _e692 = operator_(_e686, _e691);
    uint _e694[2] = out_;
    local_48 = _e694;
    local_49 = uint((base + 23u));
    uint _e701[2] = local_48;
    local_149 = _e701;
    uint _e703 = local_49;
    uint _e705 = local_149[1];
    local_149[1] = (_e705 + _e703);
    uint _e709 = local_149[0];
    local_150 = uint(_e709);
    uint _e713 = local_149[1];
    local_151 = uint(_e713);
    uint _e716 = local_151;
    out_1.Store(_e716*4, asuint(uint(_e692.x)));
    int2 _e718 = left;
    int2 _e719 = right;
    const int2 _e723 = operator_u0026_1(_e719, int2(int(1), int(1)));
    const int2 _e724 = operator_u007c(_e718, _e723);
    uint _e726[2] = out_;
    local_50 = _e726;
    local_51 = uint((base + 24u));
    uint _e733[2] = local_50;
    local_152 = _e733;
    uint _e735 = local_51;
    uint _e737 = local_152[1];
    local_152[1] = (_e737 + _e735);
    uint _e741 = local_152[0];
    local_153 = uint(_e741);
    uint _e745 = local_152[1];
    local_154 = uint(_e745);
    uint _e748 = local_154;
    out_1.Store(_e748*4, asuint(uint(_e724.y)));
    int2 _e750 = left;
    int2 _e751 = right;
    const int2 _e752 = operator_u002d_1(_e750, _e751);
    int2 _e753 = right;
    const int2 _e754 = operator_u002d_1(_e752, _e753);
    uint _e756[2] = out_;
    local_52 = _e756;
    local_53 = uint((base + 25u));
    uint _e763[2] = local_52;
    local_155 = _e763;
    uint _e765 = local_53;
    uint _e767 = local_155[1];
    local_155[1] = (_e767 + _e765);
    uint _e771 = local_155[0];
    local_156 = uint(_e771);
    uint _e775 = local_155[1];
    local_157 = uint(_e775);
    uint _e778 = local_157;
    out_1.Store(_e778*4, asuint(uint(_e754.x)));
    original.value = int(9);
    original.history[0] = int(1);
    original.history[1] = int(2);
    Record_cuda_record_0_ _e788 = original;
    const Record_cuda_record_0_ _e790 = operator_u002a_3(_e788, int(3));
    scaled = _e790;
    local_56.value = int(9);
    local_56.history[0] = int(1);
    local_56.history[1] = int(2);
    Record_cuda_record_0_ _e800 = local_56;
    const int _e801 = operator_u0026_2(_e800);
    uint _e802[2] = out_;
    local_54 = _e802;
    local_55 = uint((base + 26u));
    uint _e809[2] = local_54;
    local_158 = _e809;
    uint _e811 = local_55;
    uint _e813 = local_158[1];
    local_158[1] = (_e813 + _e811);
    uint _e817 = local_158[0];
    local_159 = uint(_e817);
    uint _e821 = local_158[1];
    local_160 = uint(_e821);
    uint _e824 = local_160;
    out_1.Store(_e824*4, asuint(uint(_e801)));
    Record_cuda_record_0_ _e826 = original;
    const Record_cuda_record_0_ _e827 = operator_u002a_2(_e826);
    const int _e828 = operator_u0026_2(_e827);
    uint _e829[2] = out_;
    local_57 = _e829;
    local_58 = uint((base + 27u));
    uint _e836[2] = local_57;
    local_161 = _e836;
    uint _e838 = local_58;
    uint _e840 = local_161[1];
    local_161[1] = (_e840 + _e838);
    uint _e844 = local_161[0];
    local_162 = uint(_e844);
    uint _e848 = local_161[1];
    local_163 = uint(_e848);
    uint _e851 = local_163;
    out_1.Store(_e851*4, asuint(uint(_e828)));
    int _e854 = scaled.value;
    uint _e855[2] = out_;
    local_59 = _e855;
    local_60 = uint((base + 28u));
    uint _e862[2] = local_59;
    local_164 = _e862;
    uint _e864 = local_60;
    uint _e866 = local_164[1];
    local_164[1] = (_e866 + _e864);
    uint _e870 = local_164[0];
    local_165 = uint(_e870);
    uint _e874 = local_164[1];
    local_166 = uint(_e874);
    uint _e877 = local_166;
    out_1.Store(_e877*4, asuint(uint(_e854)));
    int _e882 = scaled.history[int(1)];
    uint _e883[2] = out_;
    local_61 = _e883;
    local_62 = uint((base + 29u));
    uint _e890[2] = local_61;
    local_167 = _e890;
    uint _e892 = local_62;
    uint _e894 = local_167[1];
    local_167[1] = (_e894 + _e892);
    uint _e898 = local_167[0];
    local_168 = uint(_e898);
    uint _e902 = local_167[1];
    local_169 = uint(_e902);
    uint _e905 = local_169;
    out_1.Store(_e905*4, asuint(uint(_e882)));
    int _e908 = original.value;
    uint _e909[2] = out_;
    local_63 = _e909;
    local_64 = uint((base + 30u));
    uint _e916[2] = local_63;
    local_170 = _e916;
    uint _e918 = local_64;
    uint _e920 = local_170[1];
    local_170[1] = (_e920 + _e918);
    uint _e924 = local_170[0];
    local_171 = uint(_e924);
    uint _e928 = local_170[1];
    local_172 = uint(_e928);
    uint _e931 = local_172;
    out_1.Store(_e931*4, asuint(uint(_e908)));
    int _e936 = original.history[int(1)];
    uint _e937[2] = out_;
    local_65 = _e937;
    local_66 = uint((base + 31u));
    uint _e944[2] = local_65;
    local_173 = _e944;
    uint _e946 = local_66;
    uint _e948 = local_173[1];
    local_173[1] = (_e948 + _e946);
    uint _e952 = local_173[0];
    local_174 = uint(_e952);
    uint _e956 = local_173[1];
    local_175 = uint(_e956);
    uint _e959 = local_175;
    out_1.Store(_e959*4, asuint(uint(_e936)));
    Record_cuda_record_0_ _e961 = original;
    const Record_cuda_record_0_ _e962 = operator_u002d_2(_e961);
    uint _e964[2] = out_;
    local_67 = _e964;
    local_68 = uint((base + 32u));
    uint _e971[2] = local_67;
    local_176 = _e971;
    uint _e973 = local_68;
    uint _e975 = local_176[1];
    local_176[1] = (_e975 + _e973);
    uint _e979 = local_176[0];
    local_177 = uint(_e979);
    uint _e983 = local_176[1];
    local_178 = uint(_e983);
    uint _e986 = local_178;
    out_1.Store(_e986*4, asuint(uint(_e962.value)));
    Record_cuda_record_0_ _e988 = original;
    const Record_cuda_record_0_ _e990 = operator_u002a_3(_e988, int(2));
    uint _e992[2] = out_;
    local_69 = _e992;
    local_70 = uint((base + 33u));
    uint _e999[2] = local_69;
    local_179 = _e999;
    uint _e1001 = local_70;
    uint _e1003 = local_179[1];
    local_179[1] = (_e1003 + _e1001);
    uint _e1007 = local_179[0];
    local_180 = uint(_e1007);
    uint _e1011 = local_179[1];
    local_181 = uint(_e1011);
    uint _e1014 = local_181;
    out_1.Store(_e1014*4, asuint(uint(_e990.value)));
    Record_cuda_record_0_ _e1016 = original;
    const Record_cuda_record_0_ _e1017 = operator_u002a_2(_e1016);
    const int _e1018 = operator_u0026_2(_e1017);
    uint _e1019[2] = out_;
    local_71 = _e1019;
    local_72 = uint((base + 34u));
    uint _e1026[2] = local_71;
    local_182 = _e1026;
    uint _e1028 = local_72;
    uint _e1030 = local_182[1];
    local_182[1] = (_e1030 + _e1028);
    uint _e1034 = local_182[0];
    local_183 = uint(_e1034);
    uint _e1038 = local_182[1];
    local_184 = uint(_e1038);
    uint _e1041 = local_184;
    out_1.Store(_e1041*4, asuint(uint(_e1018)));
    const bool _e1046 = operator_u0021_(int2(int(0), int(0)));
    uint _e1047[2] = out_;
    local_73 = _e1047;
    local_74 = uint((base + 35u));
    uint _e1054[2] = local_73;
    local_185 = _e1054;
    uint _e1056 = local_74;
    uint _e1058 = local_185[1];
    local_185[1] = (_e1058 + _e1056);
    uint _e1062 = local_185[0];
    local_186 = uint(_e1062);
    uint _e1066 = local_185[1];
    local_187 = uint(_e1066);
    uint _e1069 = local_187;
    out_1.Store(_e1069*4, asuint(uint(_e1046)));
}
