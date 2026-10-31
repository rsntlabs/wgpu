// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

struct type_1 {
    int inner[2];
};
struct Record_cuda_record_0_ {
    int value;
    type_1 history;
};
typedef metal::int2 type_4[1];
typedef uint type_6[1];
struct type_8 {
    uint inner[2];
};

metal::int2 operator_u002b(
    metal::int2 value
) {
    metal::int2 value_1 = {};
    value_1 = value;
    int _e3 = value_1.x;
    int _e5 = value_1.y;
    return metal::int2(_e3, _e5);
}

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

metal::int2 operator_u002d(
    metal::int2 value_2
) {
    metal::int2 value_3 = {};
    value_3 = value_2;
    int _e3 = value_3.x;
    int _e6 = value_3.y;
    return metal::int2(naga_neg(_e3), naga_neg(_e6));
}

metal::int2 operator_u007e(
    metal::int2 value_4
) {
    metal::int2 value_5 = {};
    value_5 = value_4;
    int _e3 = value_5.x;
    int _e6 = value_5.y;
    return metal::int2(~(_e3), ~(_e6));
}

bool operator_u0021_(
    metal::int2 value_6
) {
    metal::int2 value_7 = {};
    bool local_190 = {};
    value_7 = value_6;
    int _e4 = value_7.x;
    bool _e5 = _e4 == 0;
    local_190 = _e5;
    if (_e5) {
        int _e9 = value_7.y;
        local_190 = _e9 == 0;
    }
    bool _e11 = local_190;
    return _e11;
}

int operator_u002a(
    metal::int2 value_8
) {
    metal::int2 value_9 = {};
    value_9 = value_8;
    int _e4 = value_9.x;
    int _e7 = value_9.y;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e4) * as_type<uint>(10))) + as_type<uint>(_e7));
}

metal::int2 operator_u0026_(
    metal::int2 value_10
) {
    metal::int2 value_11 = {};
    value_11 = value_10;
    int _e3 = value_11.y;
    int _e5 = value_11.x;
    return metal::int2(_e3, _e5);
}

metal::int2 operator_u002b_1(
    metal::int2 left_1,
    metal::int2 right_1
) {
    metal::int2 left_2 = {};
    metal::int2 right_2 = {};
    left_2 = left_1;
    right_2 = right_1;
    int _e6 = left_2.x;
    int _e7 = right_2.x;
    int _e11 = left_2.y;
    int _e12 = right_2.y;
    return metal::int2(as_type<int>(as_type<uint>(_e6) + as_type<uint>(_e7)), as_type<int>(as_type<uint>(_e11) + as_type<uint>(_e12)));
}

metal::int2 operator_u002d_1(
    metal::int2 left_3,
    metal::int2 right_3
) {
    metal::int2 left_4 = {};
    metal::int2 right_4 = {};
    left_4 = left_3;
    right_4 = right_3;
    int _e6 = left_4.x;
    int _e7 = right_4.x;
    int _e11 = left_4.y;
    int _e12 = right_4.y;
    return metal::int2(as_type<int>(as_type<uint>(_e6) - as_type<uint>(_e7)), as_type<int>(as_type<uint>(_e11) - as_type<uint>(_e12)));
}

metal::int2 operator_u002a_1(
    metal::int2 left_5,
    metal::int2 right_5
) {
    metal::int2 left_6 = {};
    metal::int2 right_6 = {};
    left_6 = left_5;
    right_6 = right_5;
    int _e6 = left_6.x;
    int _e7 = right_6.x;
    int _e11 = left_6.y;
    int _e12 = right_6.y;
    return metal::int2(as_type<int>(as_type<uint>(_e6) * as_type<uint>(_e7)), as_type<int>(as_type<uint>(_e11) * as_type<uint>(_e12)));
}

int naga_div(int lhs, int rhs) {
    return lhs / metal::select(rhs, 1, (lhs == (-2147483647 - 1) & rhs == -1) | (rhs == 0));
}

metal::int2 operator_u002f(
    metal::int2 left_7,
    metal::int2 right_7
) {
    metal::int2 left_8 = {};
    metal::int2 right_8 = {};
    left_8 = left_7;
    right_8 = right_7;
    int _e6 = left_8.x;
    int _e7 = right_8.x;
    int _e11 = left_8.y;
    int _e12 = right_8.y;
    return metal::int2(naga_div(_e6, _e7), naga_div(_e11, _e12));
}

int naga_mod(int lhs, int rhs) {
    int divisor = metal::select(rhs, 1, (lhs == (-2147483647 - 1) & rhs == -1) | (rhs == 0));
    return lhs - (lhs / divisor) * divisor;
}

metal::int2 operator_u0025_(
    metal::int2 left_9,
    metal::int2 right_9
) {
    metal::int2 left_10 = {};
    metal::int2 right_10 = {};
    left_10 = left_9;
    right_10 = right_9;
    int _e6 = left_10.x;
    int _e7 = right_10.x;
    int _e11 = left_10.y;
    int _e12 = right_10.y;
    return metal::int2(naga_mod(_e6, _e7), naga_mod(_e11, _e12));
}

metal::int2 operator_u0026_1(
    metal::int2 left_11,
    metal::int2 right_11
) {
    metal::int2 left_12 = {};
    metal::int2 right_12 = {};
    left_12 = left_11;
    right_12 = right_11;
    int _e6 = left_12.x;
    int _e7 = right_12.x;
    int _e11 = left_12.y;
    int _e12 = right_12.y;
    return metal::int2(_e6 & _e7, _e11 & _e12);
}

metal::int2 operator_u007c(
    metal::int2 left_13,
    metal::int2 right_13
) {
    metal::int2 left_14 = {};
    metal::int2 right_14 = {};
    left_14 = left_13;
    right_14 = right_13;
    int _e6 = left_14.x;
    int _e7 = right_14.x;
    int _e11 = left_14.y;
    int _e12 = right_14.y;
    return metal::int2(_e6 | _e7, _e11 | _e12);
}

metal::int2 operator_u005e(
    metal::int2 left_15,
    metal::int2 right_15
) {
    metal::int2 left_16 = {};
    metal::int2 right_16 = {};
    left_16 = left_15;
    right_16 = right_15;
    int _e6 = left_16.x;
    int _e7 = right_16.x;
    int _e11 = left_16.y;
    int _e12 = right_16.y;
    return metal::int2(_e6 ^ _e7, _e11 ^ _e12);
}

metal::int2 operator_(
    metal::int2 left_17,
    metal::int2 right_17
) {
    metal::int2 left_18 = {};
    metal::int2 right_18 = {};
    uint local_191 = {};
    uint local_192 = {};
    left_18 = left_17;
    right_18 = right_17;
    int _e5 = left_18.x;
    int _e7 = right_18.x;
    local_191 = static_cast<uint>(_e7);
    uint _e10 = local_191;
    int _e13 = left_18.y;
    int _e15 = right_18.y;
    local_192 = static_cast<uint>(_e15);
    uint _e18 = local_192;
    return metal::int2(_e5 << _e10, _e13 << _e18);
}

metal::int2 operator_1(
    metal::int2 left_19,
    metal::int2 right_19
) {
    metal::int2 left_20 = {};
    metal::int2 right_20 = {};
    left_20 = left_19;
    right_20 = right_19;
    int _e5 = left_20.x;
    int _e7 = right_20.x;
    int _e11 = left_20.y;
    int _e13 = right_20.y;
    return metal::int2(_e5 >> static_cast<uint>(_e7), _e11 >> static_cast<uint>(_e13));
}

Record_cuda_record_0_ operator_u002a_2(
    Record_cuda_record_0_ value_12
) {
    Record_cuda_record_0_ value_13 = {};
    value_13 = value_12;
    int _e3 = value_13.value;
    value_13.value = as_type<int>(as_type<uint>(_e3) + as_type<uint>(1));
    Record_cuda_record_0_ _e6 = value_13;
    return _e6;
}

int operator_u0026_2(
    Record_cuda_record_0_ value_14
) {
    Record_cuda_record_0_ value_15 = {};
    value_15 = value_14;
    int _e3 = value_15.value;
    return _e3;
}

Record_cuda_record_0_ operator_u002d_2(
    Record_cuda_record_0_ value_16
) {
    Record_cuda_record_0_ value_17 = {};
    value_17 = value_16;
    int _e4 = value_17.value;
    value_17.value = naga_neg(_e4);
    Record_cuda_record_0_ _e6 = value_17;
    return _e6;
}

Record_cuda_record_0_ operator_u002a_3(
    Record_cuda_record_0_ value_18,
    int factor
) {
    Record_cuda_record_0_ value_19 = {};
    int factor_1 = {};
    value_19 = value_18;
    factor_1 = factor;
    int _e5 = factor_1;
    int _e6 = value_19.value;
    value_19.value = as_type<int>(as_type<uint>(_e6) * as_type<uint>(_e5));
    int _e11 = factor_1;
    int _e12 = value_19.history.inner[1];
    value_19.history.inner[1] = as_type<int>(as_type<uint>(_e12) + as_type<uint>(_e11));
    Record_cuda_record_0_ _e14 = value_19;
    return _e14;
}

struct operator_functionsInput {
};
kernel void operator_functions(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4 const& input [[user(fake0)]]
, device type_6& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_8 local = {};
    type_8 local_1 = {};
    uint base = {};
    metal::int2 left = {};
    type_8 local_2 = {};
    uint local_3 = {};
    metal::int2 right = {};
    type_8 local_4 = {};
    uint local_5 = {};
    type_8 local_6 = {};
    uint local_7 = {};
    type_8 local_8 = {};
    uint local_9 = {};
    type_8 local_10 = {};
    uint local_11 = {};
    type_8 local_12 = {};
    uint local_13 = {};
    type_8 local_14 = {};
    uint local_15 = {};
    type_8 local_16 = {};
    uint local_17 = {};
    type_8 local_18 = {};
    uint local_19 = {};
    type_8 local_20 = {};
    uint local_21 = {};
    type_8 local_22 = {};
    uint local_23 = {};
    type_8 local_24 = {};
    uint local_25 = {};
    type_8 local_26 = {};
    uint local_27 = {};
    type_8 local_28 = {};
    uint local_29 = {};
    type_8 local_30 = {};
    uint local_31 = {};
    type_8 local_32 = {};
    uint local_33 = {};
    type_8 local_34 = {};
    uint local_35 = {};
    type_8 local_36 = {};
    uint local_37 = {};
    type_8 local_38 = {};
    uint local_39 = {};
    type_8 local_40 = {};
    uint local_41 = {};
    type_8 local_42 = {};
    uint local_43 = {};
    type_8 local_44 = {};
    uint local_45 = {};
    type_8 local_46 = {};
    uint local_47 = {};
    type_8 local_48 = {};
    uint local_49 = {};
    type_8 local_50 = {};
    uint local_51 = {};
    type_8 local_52 = {};
    uint local_53 = {};
    type_8 local_54 = {};
    uint local_55 = {};
    Record_cuda_record_0_ original = {};
    Record_cuda_record_0_ scaled = {};
    type_8 local_56 = {};
    uint local_57 = {};
    Record_cuda_record_0_ local_58 = {};
    type_8 local_59 = {};
    uint local_60 = {};
    type_8 local_61 = {};
    uint local_62 = {};
    type_8 local_63 = {};
    uint local_64 = {};
    type_8 local_65 = {};
    uint local_66 = {};
    type_8 local_67 = {};
    uint local_68 = {};
    type_8 local_69 = {};
    uint local_70 = {};
    type_8 local_71 = {};
    uint local_72 = {};
    type_8 local_73 = {};
    uint local_74 = {};
    type_8 local_75 = {};
    uint local_76 = {};
    metal::int2 local_77 = {};
    type_8 local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    metal::int2 local_81 = {};
    type_8 local_82 = {};
    uint local_83 = {};
    uint local_84 = {};
    type_8 local_85 = {};
    uint local_86 = {};
    uint local_87 = {};
    type_8 local_88 = {};
    uint local_89 = {};
    uint local_90 = {};
    type_8 local_91 = {};
    uint local_92 = {};
    uint local_93 = {};
    type_8 local_94 = {};
    uint local_95 = {};
    uint local_96 = {};
    type_8 local_97 = {};
    uint local_98 = {};
    uint local_99 = {};
    type_8 local_100 = {};
    uint local_101 = {};
    uint local_102 = {};
    type_8 local_103 = {};
    uint local_104 = {};
    uint local_105 = {};
    type_8 local_106 = {};
    uint local_107 = {};
    uint local_108 = {};
    type_8 local_109 = {};
    uint local_110 = {};
    uint local_111 = {};
    type_8 local_112 = {};
    uint local_113 = {};
    uint local_114 = {};
    type_8 local_115 = {};
    uint local_116 = {};
    uint local_117 = {};
    type_8 local_118 = {};
    uint local_119 = {};
    uint local_120 = {};
    type_8 local_121 = {};
    uint local_122 = {};
    uint local_123 = {};
    type_8 local_124 = {};
    uint local_125 = {};
    uint local_126 = {};
    type_8 local_127 = {};
    uint local_128 = {};
    uint local_129 = {};
    type_8 local_130 = {};
    uint local_131 = {};
    uint local_132 = {};
    type_8 local_133 = {};
    uint local_134 = {};
    uint local_135 = {};
    type_8 local_136 = {};
    uint local_137 = {};
    uint local_138 = {};
    type_8 local_139 = {};
    uint local_140 = {};
    uint local_141 = {};
    type_8 local_142 = {};
    uint local_143 = {};
    uint local_144 = {};
    type_8 local_145 = {};
    uint local_146 = {};
    uint local_147 = {};
    type_8 local_148 = {};
    uint local_149 = {};
    uint local_150 = {};
    type_8 local_151 = {};
    uint local_152 = {};
    uint local_153 = {};
    type_8 local_154 = {};
    uint local_155 = {};
    uint local_156 = {};
    type_8 local_157 = {};
    uint local_158 = {};
    uint local_159 = {};
    type_8 local_160 = {};
    uint local_161 = {};
    uint local_162 = {};
    type_8 local_163 = {};
    uint local_164 = {};
    uint local_165 = {};
    type_8 local_166 = {};
    uint local_167 = {};
    uint local_168 = {};
    type_8 local_169 = {};
    uint local_170 = {};
    uint local_171 = {};
    type_8 local_172 = {};
    uint local_173 = {};
    uint local_174 = {};
    type_8 local_175 = {};
    uint local_176 = {};
    uint local_177 = {};
    type_8 local_178 = {};
    uint local_179 = {};
    uint local_180 = {};
    type_8 local_181 = {};
    uint local_182 = {};
    uint local_183 = {};
    type_8 local_184 = {};
    uint local_185 = {};
    uint local_186 = {};
    type_8 local_187 = {};
    uint local_188 = {};
    uint local_189 = {};
    local = type_8 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    local_1 = type_8 {};
    local_1.inner[0] = 1u;
    local_1.inner[1] = 0u;
    base = threadIdx.x * 36u;
    type_8 _e21 = local;
    local_2 = _e21;
    local_3 = static_cast<uint>(threadIdx.x);
    type_8 _e26 = local_2;
    local_78 = _e26;
    uint _e27 = local_3;
    uint _e29 = local_78.inner[1];
    local_78.inner[1] = _e29 + _e27;
    uint _e33 = local_78.inner[0];
    local_79 = static_cast<uint>(_e33);
    uint _e37 = local_78.inner[1];
    local_80 = static_cast<uint>(_e37);
    uint _e41 = local_80;
    metal::int2 _e43 = input[_e41];
    local_81 = _e43;
    metal::int2 _e44 = local_81;
    local_77 = _e44;
    metal::int2 _e46 = local_77;
    left = _e46;
    right = metal::int2(3, 2);
    metal::int2 _e52 = left;
    metal::int2 _e53 = operator_u002b(_e52);
    type_8 _e57 = local_1;
    local_4 = _e57;
    uint _e58 = base;
    local_5 = static_cast<uint>(_e58 + 0u);
    type_8 _e65 = local_4;
    local_82 = _e65;
    uint _e66 = local_5;
    uint _e68 = local_82.inner[1];
    local_82.inner[1] = _e68 + _e66;
    uint _e72 = local_82.inner[0];
    local_83 = static_cast<uint>(_e72);
    uint _e76 = local_82.inner[1];
    local_84 = static_cast<uint>(_e76);
    uint _e79 = local_84;
    out[_e79] = static_cast<uint>(_e53.x);
    metal::int2 _e81 = left;
    metal::int2 _e82 = operator_u002d(_e81);
    type_8 _e85 = local_1;
    local_6 = _e85;
    uint _e86 = base;
    local_7 = static_cast<uint>(_e86 + 1u);
    type_8 _e93 = local_6;
    local_85 = _e93;
    uint _e94 = local_7;
    uint _e96 = local_85.inner[1];
    local_85.inner[1] = _e96 + _e94;
    uint _e100 = local_85.inner[0];
    local_86 = static_cast<uint>(_e100);
    uint _e104 = local_85.inner[1];
    local_87 = static_cast<uint>(_e104);
    uint _e107 = local_87;
    out[_e107] = static_cast<uint>(_e82.y);
    metal::int2 _e109 = left;
    metal::int2 _e110 = operator_u007e(_e109);
    type_8 _e113 = local_1;
    local_8 = _e113;
    uint _e114 = base;
    local_9 = static_cast<uint>(_e114 + 2u);
    type_8 _e121 = local_8;
    local_88 = _e121;
    uint _e122 = local_9;
    uint _e124 = local_88.inner[1];
    local_88.inner[1] = _e124 + _e122;
    uint _e128 = local_88.inner[0];
    local_89 = static_cast<uint>(_e128);
    uint _e132 = local_88.inner[1];
    local_90 = static_cast<uint>(_e132);
    uint _e135 = local_90;
    out[_e135] = static_cast<uint>(_e110.x);
    metal::int2 _e137 = left;
    bool _e138 = operator_u0021_(_e137);
    type_8 _e140 = local_1;
    local_10 = _e140;
    uint _e141 = base;
    local_11 = static_cast<uint>(_e141 + 3u);
    type_8 _e148 = local_10;
    local_91 = _e148;
    uint _e149 = local_11;
    uint _e151 = local_91.inner[1];
    local_91.inner[1] = _e151 + _e149;
    uint _e155 = local_91.inner[0];
    local_92 = static_cast<uint>(_e155);
    uint _e159 = local_91.inner[1];
    local_93 = static_cast<uint>(_e159);
    uint _e162 = local_93;
    out[_e162] = static_cast<uint>(_e138);
    metal::int2 _e164 = left;
    int _e165 = operator_u002a(_e164);
    type_8 _e167 = local_1;
    local_12 = _e167;
    uint _e168 = base;
    local_13 = static_cast<uint>(_e168 + 4u);
    type_8 _e175 = local_12;
    local_94 = _e175;
    uint _e176 = local_13;
    uint _e178 = local_94.inner[1];
    local_94.inner[1] = _e178 + _e176;
    uint _e182 = local_94.inner[0];
    local_95 = static_cast<uint>(_e182);
    uint _e186 = local_94.inner[1];
    local_96 = static_cast<uint>(_e186);
    uint _e189 = local_96;
    out[_e189] = static_cast<uint>(_e165);
    metal::int2 _e191 = left;
    metal::int2 _e192 = operator_u0026_(_e191);
    type_8 _e195 = local_1;
    local_14 = _e195;
    uint _e196 = base;
    local_15 = static_cast<uint>(_e196 + 5u);
    type_8 _e203 = local_14;
    local_97 = _e203;
    uint _e204 = local_15;
    uint _e206 = local_97.inner[1];
    local_97.inner[1] = _e206 + _e204;
    uint _e210 = local_97.inner[0];
    local_98 = static_cast<uint>(_e210);
    uint _e214 = local_97.inner[1];
    local_99 = static_cast<uint>(_e214);
    uint _e217 = local_99;
    out[_e217] = static_cast<uint>(_e192.x);
    metal::int2 _e219 = left;
    metal::int2 _e220 = right;
    metal::int2 _e221 = operator_u002b_1(_e219, _e220);
    type_8 _e224 = local_1;
    local_16 = _e224;
    uint _e225 = base;
    local_17 = static_cast<uint>(_e225 + 6u);
    type_8 _e232 = local_16;
    local_100 = _e232;
    uint _e233 = local_17;
    uint _e235 = local_100.inner[1];
    local_100.inner[1] = _e235 + _e233;
    uint _e239 = local_100.inner[0];
    local_101 = static_cast<uint>(_e239);
    uint _e243 = local_100.inner[1];
    local_102 = static_cast<uint>(_e243);
    uint _e246 = local_102;
    out[_e246] = static_cast<uint>(_e221.x);
    metal::int2 _e248 = left;
    metal::int2 _e249 = right;
    metal::int2 _e250 = operator_u002d_1(_e248, _e249);
    type_8 _e253 = local_1;
    local_18 = _e253;
    uint _e254 = base;
    local_19 = static_cast<uint>(_e254 + 7u);
    type_8 _e261 = local_18;
    local_103 = _e261;
    uint _e262 = local_19;
    uint _e264 = local_103.inner[1];
    local_103.inner[1] = _e264 + _e262;
    uint _e268 = local_103.inner[0];
    local_104 = static_cast<uint>(_e268);
    uint _e272 = local_103.inner[1];
    local_105 = static_cast<uint>(_e272);
    uint _e275 = local_105;
    out[_e275] = static_cast<uint>(_e250.y);
    metal::int2 _e277 = left;
    metal::int2 _e278 = right;
    metal::int2 _e279 = operator_u002a_1(_e277, _e278);
    type_8 _e282 = local_1;
    local_20 = _e282;
    uint _e283 = base;
    local_21 = static_cast<uint>(_e283 + 8u);
    type_8 _e290 = local_20;
    local_106 = _e290;
    uint _e291 = local_21;
    uint _e293 = local_106.inner[1];
    local_106.inner[1] = _e293 + _e291;
    uint _e297 = local_106.inner[0];
    local_107 = static_cast<uint>(_e297);
    uint _e301 = local_106.inner[1];
    local_108 = static_cast<uint>(_e301);
    uint _e304 = local_108;
    out[_e304] = static_cast<uint>(_e279.x);
    metal::int2 _e306 = left;
    metal::int2 _e307 = right;
    metal::int2 _e308 = operator_u002f(_e306, _e307);
    type_8 _e311 = local_1;
    local_22 = _e311;
    uint _e312 = base;
    local_23 = static_cast<uint>(_e312 + 9u);
    type_8 _e319 = local_22;
    local_109 = _e319;
    uint _e320 = local_23;
    uint _e322 = local_109.inner[1];
    local_109.inner[1] = _e322 + _e320;
    uint _e326 = local_109.inner[0];
    local_110 = static_cast<uint>(_e326);
    uint _e330 = local_109.inner[1];
    local_111 = static_cast<uint>(_e330);
    uint _e333 = local_111;
    out[_e333] = static_cast<uint>(_e308.y);
    metal::int2 _e335 = left;
    metal::int2 _e336 = right;
    metal::int2 _e337 = operator_u0025_(_e335, _e336);
    type_8 _e340 = local_1;
    local_24 = _e340;
    uint _e341 = base;
    local_25 = static_cast<uint>(_e341 + 10u);
    type_8 _e348 = local_24;
    local_112 = _e348;
    uint _e349 = local_25;
    uint _e351 = local_112.inner[1];
    local_112.inner[1] = _e351 + _e349;
    uint _e355 = local_112.inner[0];
    local_113 = static_cast<uint>(_e355);
    uint _e359 = local_112.inner[1];
    local_114 = static_cast<uint>(_e359);
    uint _e362 = local_114;
    out[_e362] = static_cast<uint>(_e337.y);
    metal::int2 _e364 = left;
    metal::int2 _e365 = right;
    metal::int2 _e366 = operator_u0026_1(_e364, _e365);
    type_8 _e369 = local_1;
    local_26 = _e369;
    uint _e370 = base;
    local_27 = static_cast<uint>(_e370 + 11u);
    type_8 _e377 = local_26;
    local_115 = _e377;
    uint _e378 = local_27;
    uint _e380 = local_115.inner[1];
    local_115.inner[1] = _e380 + _e378;
    uint _e384 = local_115.inner[0];
    local_116 = static_cast<uint>(_e384);
    uint _e388 = local_115.inner[1];
    local_117 = static_cast<uint>(_e388);
    uint _e391 = local_117;
    out[_e391] = static_cast<uint>(_e366.x);
    metal::int2 _e393 = left;
    metal::int2 _e394 = right;
    metal::int2 _e395 = operator_u007c(_e393, _e394);
    type_8 _e398 = local_1;
    local_28 = _e398;
    uint _e399 = base;
    local_29 = static_cast<uint>(_e399 + 12u);
    type_8 _e406 = local_28;
    local_118 = _e406;
    uint _e407 = local_29;
    uint _e409 = local_118.inner[1];
    local_118.inner[1] = _e409 + _e407;
    uint _e413 = local_118.inner[0];
    local_119 = static_cast<uint>(_e413);
    uint _e417 = local_118.inner[1];
    local_120 = static_cast<uint>(_e417);
    uint _e420 = local_120;
    out[_e420] = static_cast<uint>(_e395.y);
    metal::int2 _e422 = left;
    metal::int2 _e423 = right;
    metal::int2 _e424 = operator_u005e(_e422, _e423);
    type_8 _e427 = local_1;
    local_30 = _e427;
    uint _e428 = base;
    local_31 = static_cast<uint>(_e428 + 13u);
    type_8 _e435 = local_30;
    local_121 = _e435;
    uint _e436 = local_31;
    uint _e438 = local_121.inner[1];
    local_121.inner[1] = _e438 + _e436;
    uint _e442 = local_121.inner[0];
    local_122 = static_cast<uint>(_e442);
    uint _e446 = local_121.inner[1];
    local_123 = static_cast<uint>(_e446);
    uint _e449 = local_123;
    out[_e449] = static_cast<uint>(_e424.x);
    metal::int2 _e451 = left;
    metal::int2 _e452 = right;
    metal::int2 _e453 = operator_(_e451, _e452);
    type_8 _e456 = local_1;
    local_32 = _e456;
    uint _e457 = base;
    local_33 = static_cast<uint>(_e457 + 14u);
    type_8 _e464 = local_32;
    local_124 = _e464;
    uint _e465 = local_33;
    uint _e467 = local_124.inner[1];
    local_124.inner[1] = _e467 + _e465;
    uint _e471 = local_124.inner[0];
    local_125 = static_cast<uint>(_e471);
    uint _e475 = local_124.inner[1];
    local_126 = static_cast<uint>(_e475);
    uint _e478 = local_126;
    out[_e478] = static_cast<uint>(_e453.x);
    metal::int2 _e480 = left;
    metal::int2 _e481 = right;
    metal::int2 _e482 = operator_1(_e480, _e481);
    type_8 _e485 = local_1;
    local_34 = _e485;
    uint _e486 = base;
    local_35 = static_cast<uint>(_e486 + 15u);
    type_8 _e493 = local_34;
    local_127 = _e493;
    uint _e494 = local_35;
    uint _e496 = local_127.inner[1];
    local_127.inner[1] = _e496 + _e494;
    uint _e500 = local_127.inner[0];
    local_128 = static_cast<uint>(_e500);
    uint _e504 = local_127.inner[1];
    local_129 = static_cast<uint>(_e504);
    uint _e507 = local_129;
    out[_e507] = static_cast<uint>(_e482.y);
    metal::int2 _e509 = left;
    metal::int2 _e510 = operator_u002b(_e509);
    type_8 _e513 = local_1;
    local_36 = _e513;
    uint _e514 = base;
    local_37 = static_cast<uint>(_e514 + 16u);
    type_8 _e521 = local_36;
    local_130 = _e521;
    uint _e522 = local_37;
    uint _e524 = local_130.inner[1];
    local_130.inner[1] = _e524 + _e522;
    uint _e528 = local_130.inner[0];
    local_131 = static_cast<uint>(_e528);
    uint _e532 = local_130.inner[1];
    local_132 = static_cast<uint>(_e532);
    uint _e535 = local_132;
    out[_e535] = static_cast<uint>(_e510.y);
    metal::int2 _e537 = left;
    metal::int2 _e538 = right;
    metal::int2 _e539 = operator_u002d_1(_e537, _e538);
    type_8 _e542 = local_1;
    local_38 = _e542;
    uint _e543 = base;
    local_39 = static_cast<uint>(_e543 + 17u);
    type_8 _e550 = local_38;
    local_133 = _e550;
    uint _e551 = local_39;
    uint _e553 = local_133.inner[1];
    local_133.inner[1] = _e553 + _e551;
    uint _e557 = local_133.inner[0];
    local_134 = static_cast<uint>(_e557);
    uint _e561 = local_133.inner[1];
    local_135 = static_cast<uint>(_e561);
    uint _e564 = local_135;
    out[_e564] = static_cast<uint>(_e539.x);
    metal::int2 _e566 = left;
    int _e567 = operator_u002a(_e566);
    type_8 _e569 = local_1;
    local_40 = _e569;
    uint _e570 = base;
    local_41 = static_cast<uint>(_e570 + 18u);
    type_8 _e577 = local_40;
    local_136 = _e577;
    uint _e578 = local_41;
    uint _e580 = local_136.inner[1];
    local_136.inner[1] = _e580 + _e578;
    uint _e584 = local_136.inner[0];
    local_137 = static_cast<uint>(_e584);
    uint _e588 = local_136.inner[1];
    local_138 = static_cast<uint>(_e588);
    uint _e591 = local_138;
    out[_e591] = static_cast<uint>(_e567);
    metal::int2 _e593 = left;
    metal::int2 _e594 = right;
    metal::int2 _e595 = operator_u0026_1(_e593, _e594);
    type_8 _e598 = local_1;
    local_42 = _e598;
    uint _e599 = base;
    local_43 = static_cast<uint>(_e599 + 19u);
    type_8 _e606 = local_42;
    local_139 = _e606;
    uint _e607 = local_43;
    uint _e609 = local_139.inner[1];
    local_139.inner[1] = _e609 + _e607;
    uint _e613 = local_139.inner[0];
    local_140 = static_cast<uint>(_e613);
    uint _e617 = local_139.inner[1];
    local_141 = static_cast<uint>(_e617);
    uint _e620 = local_141;
    out[_e620] = static_cast<uint>(_e595.y);
    metal::int2 _e622 = left;
    metal::int2 _e623 = operator_u0026_(_e622);
    int _e624 = operator_u002a(_e623);
    type_8 _e626 = local_1;
    local_44 = _e626;
    uint _e627 = base;
    local_45 = static_cast<uint>(_e627 + 20u);
    type_8 _e634 = local_44;
    local_142 = _e634;
    uint _e635 = local_45;
    uint _e637 = local_142.inner[1];
    local_142.inner[1] = _e637 + _e635;
    uint _e641 = local_142.inner[0];
    local_143 = static_cast<uint>(_e641);
    uint _e645 = local_142.inner[1];
    local_144 = static_cast<uint>(_e645);
    uint _e648 = local_144;
    out[_e648] = static_cast<uint>(_e624);
    metal::int2 _e650 = left;
    metal::int2 _e651 = operator_u0026_(_e650);
    metal::int2 _e652 = operator_u0026_(_e651);
    type_8 _e655 = local_1;
    local_46 = _e655;
    uint _e656 = base;
    local_47 = static_cast<uint>(_e656 + 21u);
    type_8 _e663 = local_46;
    local_145 = _e663;
    uint _e664 = local_47;
    uint _e666 = local_145.inner[1];
    local_145.inner[1] = _e666 + _e664;
    uint _e670 = local_145.inner[0];
    local_146 = static_cast<uint>(_e670);
    uint _e674 = local_145.inner[1];
    local_147 = static_cast<uint>(_e674);
    uint _e677 = local_147;
    out[_e677] = static_cast<uint>(_e652.x);
    metal::int2 _e679 = left;
    metal::int2 _e680 = right;
    metal::int2 _e681 = right;
    metal::int2 _e682 = operator_u002a_1(_e680, _e681);
    metal::int2 _e683 = operator_u002b_1(_e679, _e682);
    type_8 _e686 = local_1;
    local_48 = _e686;
    uint _e687 = base;
    local_49 = static_cast<uint>(_e687 + 22u);
    type_8 _e694 = local_48;
    local_148 = _e694;
    uint _e695 = local_49;
    uint _e697 = local_148.inner[1];
    local_148.inner[1] = _e697 + _e695;
    uint _e701 = local_148.inner[0];
    local_149 = static_cast<uint>(_e701);
    uint _e705 = local_148.inner[1];
    local_150 = static_cast<uint>(_e705);
    uint _e708 = local_150;
    out[_e708] = static_cast<uint>(_e683.x);
    metal::int2 _e710 = left;
    metal::int2 _e711 = right;
    metal::int2 _e715 = operator_u002b_1(_e711, metal::int2(1, 1));
    metal::int2 _e716 = operator_(_e710, _e715);
    type_8 _e719 = local_1;
    local_50 = _e719;
    uint _e720 = base;
    local_51 = static_cast<uint>(_e720 + 23u);
    type_8 _e727 = local_50;
    local_151 = _e727;
    uint _e728 = local_51;
    uint _e730 = local_151.inner[1];
    local_151.inner[1] = _e730 + _e728;
    uint _e734 = local_151.inner[0];
    local_152 = static_cast<uint>(_e734);
    uint _e738 = local_151.inner[1];
    local_153 = static_cast<uint>(_e738);
    uint _e741 = local_153;
    out[_e741] = static_cast<uint>(_e716.x);
    metal::int2 _e743 = left;
    metal::int2 _e744 = right;
    metal::int2 _e748 = operator_u0026_1(_e744, metal::int2(1, 1));
    metal::int2 _e749 = operator_u007c(_e743, _e748);
    type_8 _e752 = local_1;
    local_52 = _e752;
    uint _e753 = base;
    local_53 = static_cast<uint>(_e753 + 24u);
    type_8 _e760 = local_52;
    local_154 = _e760;
    uint _e761 = local_53;
    uint _e763 = local_154.inner[1];
    local_154.inner[1] = _e763 + _e761;
    uint _e767 = local_154.inner[0];
    local_155 = static_cast<uint>(_e767);
    uint _e771 = local_154.inner[1];
    local_156 = static_cast<uint>(_e771);
    uint _e774 = local_156;
    out[_e774] = static_cast<uint>(_e749.y);
    metal::int2 _e776 = left;
    metal::int2 _e777 = right;
    metal::int2 _e778 = operator_u002d_1(_e776, _e777);
    metal::int2 _e779 = right;
    metal::int2 _e780 = operator_u002d_1(_e778, _e779);
    type_8 _e783 = local_1;
    local_54 = _e783;
    uint _e784 = base;
    local_55 = static_cast<uint>(_e784 + 25u);
    type_8 _e791 = local_54;
    local_157 = _e791;
    uint _e792 = local_55;
    uint _e794 = local_157.inner[1];
    local_157.inner[1] = _e794 + _e792;
    uint _e798 = local_157.inner[0];
    local_158 = static_cast<uint>(_e798);
    uint _e802 = local_157.inner[1];
    local_159 = static_cast<uint>(_e802);
    uint _e805 = local_159;
    out[_e805] = static_cast<uint>(_e780.x);
    original.value = 9;
    original.history.inner[0] = 1;
    original.history.inner[1] = 2;
    Record_cuda_record_0_ _e815 = original;
    Record_cuda_record_0_ _e817 = operator_u002a_3(_e815, 3);
    scaled = _e817;
    local_58.value = 9;
    local_58.history.inner[0] = 1;
    local_58.history.inner[1] = 2;
    Record_cuda_record_0_ _e827 = local_58;
    int _e828 = operator_u0026_2(_e827);
    type_8 _e830 = local_1;
    local_56 = _e830;
    uint _e831 = base;
    local_57 = static_cast<uint>(_e831 + 26u);
    type_8 _e838 = local_56;
    local_160 = _e838;
    uint _e839 = local_57;
    uint _e841 = local_160.inner[1];
    local_160.inner[1] = _e841 + _e839;
    uint _e845 = local_160.inner[0];
    local_161 = static_cast<uint>(_e845);
    uint _e849 = local_160.inner[1];
    local_162 = static_cast<uint>(_e849);
    uint _e852 = local_162;
    out[_e852] = static_cast<uint>(_e828);
    Record_cuda_record_0_ _e854 = original;
    Record_cuda_record_0_ _e855 = operator_u002a_2(_e854);
    int _e856 = operator_u0026_2(_e855);
    type_8 _e858 = local_1;
    local_59 = _e858;
    uint _e859 = base;
    local_60 = static_cast<uint>(_e859 + 27u);
    type_8 _e866 = local_59;
    local_163 = _e866;
    uint _e867 = local_60;
    uint _e869 = local_163.inner[1];
    local_163.inner[1] = _e869 + _e867;
    uint _e873 = local_163.inner[0];
    local_164 = static_cast<uint>(_e873);
    uint _e877 = local_163.inner[1];
    local_165 = static_cast<uint>(_e877);
    uint _e880 = local_165;
    out[_e880] = static_cast<uint>(_e856);
    int _e883 = scaled.value;
    type_8 _e885 = local_1;
    local_61 = _e885;
    uint _e886 = base;
    local_62 = static_cast<uint>(_e886 + 28u);
    type_8 _e893 = local_61;
    local_166 = _e893;
    uint _e894 = local_62;
    uint _e896 = local_166.inner[1];
    local_166.inner[1] = _e896 + _e894;
    uint _e900 = local_166.inner[0];
    local_167 = static_cast<uint>(_e900);
    uint _e904 = local_166.inner[1];
    local_168 = static_cast<uint>(_e904);
    uint _e907 = local_168;
    out[_e907] = static_cast<uint>(_e883);
    int _e912 = scaled.history.inner[1];
    type_8 _e914 = local_1;
    local_63 = _e914;
    uint _e915 = base;
    local_64 = static_cast<uint>(_e915 + 29u);
    type_8 _e922 = local_63;
    local_169 = _e922;
    uint _e923 = local_64;
    uint _e925 = local_169.inner[1];
    local_169.inner[1] = _e925 + _e923;
    uint _e929 = local_169.inner[0];
    local_170 = static_cast<uint>(_e929);
    uint _e933 = local_169.inner[1];
    local_171 = static_cast<uint>(_e933);
    uint _e936 = local_171;
    out[_e936] = static_cast<uint>(_e912);
    int _e939 = original.value;
    type_8 _e941 = local_1;
    local_65 = _e941;
    uint _e942 = base;
    local_66 = static_cast<uint>(_e942 + 30u);
    type_8 _e949 = local_65;
    local_172 = _e949;
    uint _e950 = local_66;
    uint _e952 = local_172.inner[1];
    local_172.inner[1] = _e952 + _e950;
    uint _e956 = local_172.inner[0];
    local_173 = static_cast<uint>(_e956);
    uint _e960 = local_172.inner[1];
    local_174 = static_cast<uint>(_e960);
    uint _e963 = local_174;
    out[_e963] = static_cast<uint>(_e939);
    int _e968 = original.history.inner[1];
    type_8 _e970 = local_1;
    local_67 = _e970;
    uint _e971 = base;
    local_68 = static_cast<uint>(_e971 + 31u);
    type_8 _e978 = local_67;
    local_175 = _e978;
    uint _e979 = local_68;
    uint _e981 = local_175.inner[1];
    local_175.inner[1] = _e981 + _e979;
    uint _e985 = local_175.inner[0];
    local_176 = static_cast<uint>(_e985);
    uint _e989 = local_175.inner[1];
    local_177 = static_cast<uint>(_e989);
    uint _e992 = local_177;
    out[_e992] = static_cast<uint>(_e968);
    Record_cuda_record_0_ _e994 = original;
    Record_cuda_record_0_ _e995 = operator_u002d_2(_e994);
    type_8 _e998 = local_1;
    local_69 = _e998;
    uint _e999 = base;
    local_70 = static_cast<uint>(_e999 + 32u);
    type_8 _e1006 = local_69;
    local_178 = _e1006;
    uint _e1007 = local_70;
    uint _e1009 = local_178.inner[1];
    local_178.inner[1] = _e1009 + _e1007;
    uint _e1013 = local_178.inner[0];
    local_179 = static_cast<uint>(_e1013);
    uint _e1017 = local_178.inner[1];
    local_180 = static_cast<uint>(_e1017);
    uint _e1020 = local_180;
    out[_e1020] = static_cast<uint>(_e995.value);
    Record_cuda_record_0_ _e1022 = original;
    Record_cuda_record_0_ _e1024 = operator_u002a_3(_e1022, 2);
    type_8 _e1027 = local_1;
    local_71 = _e1027;
    uint _e1028 = base;
    local_72 = static_cast<uint>(_e1028 + 33u);
    type_8 _e1035 = local_71;
    local_181 = _e1035;
    uint _e1036 = local_72;
    uint _e1038 = local_181.inner[1];
    local_181.inner[1] = _e1038 + _e1036;
    uint _e1042 = local_181.inner[0];
    local_182 = static_cast<uint>(_e1042);
    uint _e1046 = local_181.inner[1];
    local_183 = static_cast<uint>(_e1046);
    uint _e1049 = local_183;
    out[_e1049] = static_cast<uint>(_e1024.value);
    Record_cuda_record_0_ _e1051 = original;
    Record_cuda_record_0_ _e1052 = operator_u002a_2(_e1051);
    int _e1053 = operator_u0026_2(_e1052);
    type_8 _e1055 = local_1;
    local_73 = _e1055;
    uint _e1056 = base;
    local_74 = static_cast<uint>(_e1056 + 34u);
    type_8 _e1063 = local_73;
    local_184 = _e1063;
    uint _e1064 = local_74;
    uint _e1066 = local_184.inner[1];
    local_184.inner[1] = _e1066 + _e1064;
    uint _e1070 = local_184.inner[0];
    local_185 = static_cast<uint>(_e1070);
    uint _e1074 = local_184.inner[1];
    local_186 = static_cast<uint>(_e1074);
    uint _e1077 = local_186;
    out[_e1077] = static_cast<uint>(_e1053);
    bool _e1082 = operator_u0021_(metal::int2(0, 0));
    type_8 _e1084 = local_1;
    local_75 = _e1084;
    uint _e1085 = base;
    local_76 = static_cast<uint>(_e1085 + 35u);
    type_8 _e1092 = local_75;
    local_187 = _e1092;
    uint _e1093 = local_76;
    uint _e1095 = local_187.inner[1];
    local_187.inner[1] = _e1095 + _e1093;
    uint _e1099 = local_187.inner[0];
    local_188 = static_cast<uint>(_e1099);
    uint _e1103 = local_187.inner[1];
    local_189 = static_cast<uint>(_e1103);
    uint _e1106 = local_189;
    out[_e1106] = static_cast<uint>(_e1082);
}
