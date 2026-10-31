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
    bool local_188 = {};
    value_7 = value_6;
    int _e4 = value_7.x;
    bool _e5 = _e4 == 0;
    local_188 = _e5;
    if (_e5) {
        int _e9 = value_7.y;
        local_188 = _e9 == 0;
    }
    bool _e11 = local_188;
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
    uint local_189 = {};
    uint local_190 = {};
    left_18 = left_17;
    right_18 = right_17;
    int _e5 = left_18.x;
    int _e7 = right_18.x;
    local_189 = static_cast<uint>(_e7);
    uint _e10 = local_189;
    int _e13 = left_18.y;
    int _e15 = right_18.y;
    local_190 = static_cast<uint>(_e15);
    uint _e18 = local_190;
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
    value_19 = value_18;
    int _e4 = value_19.value;
    value_19.value = as_type<int>(as_type<uint>(_e4) * as_type<uint>(factor));
    int _e9 = value_19.history.inner[1];
    value_19.history.inner[1] = as_type<int>(as_type<uint>(_e9) + as_type<uint>(factor));
    Record_cuda_record_0_ _e11 = value_19;
    return _e11;
}

struct operator_functionsInput {
};
kernel void operator_functions(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4 const& input_1 [[user(fake0)]]
, device type_6& out_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_8 input = {};
    type_8 out = {};
    metal::int2 left = {};
    type_8 local = {};
    uint local_1 = {};
    metal::int2 right = {};
    type_8 local_2 = {};
    uint local_3 = {};
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
    Record_cuda_record_0_ original = {};
    Record_cuda_record_0_ scaled = {};
    type_8 local_54 = {};
    uint local_55 = {};
    Record_cuda_record_0_ local_56 = {};
    type_8 local_57 = {};
    uint local_58 = {};
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
    metal::int2 local_75 = {};
    type_8 local_76 = {};
    uint local_77 = {};
    uint local_78 = {};
    metal::int2 local_79 = {};
    type_8 local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    type_8 local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    type_8 local_86 = {};
    uint local_87 = {};
    uint local_88 = {};
    type_8 local_89 = {};
    uint local_90 = {};
    uint local_91 = {};
    type_8 local_92 = {};
    uint local_93 = {};
    uint local_94 = {};
    type_8 local_95 = {};
    uint local_96 = {};
    uint local_97 = {};
    type_8 local_98 = {};
    uint local_99 = {};
    uint local_100 = {};
    type_8 local_101 = {};
    uint local_102 = {};
    uint local_103 = {};
    type_8 local_104 = {};
    uint local_105 = {};
    uint local_106 = {};
    type_8 local_107 = {};
    uint local_108 = {};
    uint local_109 = {};
    type_8 local_110 = {};
    uint local_111 = {};
    uint local_112 = {};
    type_8 local_113 = {};
    uint local_114 = {};
    uint local_115 = {};
    type_8 local_116 = {};
    uint local_117 = {};
    uint local_118 = {};
    type_8 local_119 = {};
    uint local_120 = {};
    uint local_121 = {};
    type_8 local_122 = {};
    uint local_123 = {};
    uint local_124 = {};
    type_8 local_125 = {};
    uint local_126 = {};
    uint local_127 = {};
    type_8 local_128 = {};
    uint local_129 = {};
    uint local_130 = {};
    type_8 local_131 = {};
    uint local_132 = {};
    uint local_133 = {};
    type_8 local_134 = {};
    uint local_135 = {};
    uint local_136 = {};
    type_8 local_137 = {};
    uint local_138 = {};
    uint local_139 = {};
    type_8 local_140 = {};
    uint local_141 = {};
    uint local_142 = {};
    type_8 local_143 = {};
    uint local_144 = {};
    uint local_145 = {};
    type_8 local_146 = {};
    uint local_147 = {};
    uint local_148 = {};
    type_8 local_149 = {};
    uint local_150 = {};
    uint local_151 = {};
    type_8 local_152 = {};
    uint local_153 = {};
    uint local_154 = {};
    type_8 local_155 = {};
    uint local_156 = {};
    uint local_157 = {};
    type_8 local_158 = {};
    uint local_159 = {};
    uint local_160 = {};
    type_8 local_161 = {};
    uint local_162 = {};
    uint local_163 = {};
    type_8 local_164 = {};
    uint local_165 = {};
    uint local_166 = {};
    type_8 local_167 = {};
    uint local_168 = {};
    uint local_169 = {};
    type_8 local_170 = {};
    uint local_171 = {};
    uint local_172 = {};
    type_8 local_173 = {};
    uint local_174 = {};
    uint local_175 = {};
    type_8 local_176 = {};
    uint local_177 = {};
    uint local_178 = {};
    type_8 local_179 = {};
    uint local_180 = {};
    uint local_181 = {};
    type_8 local_182 = {};
    uint local_183 = {};
    uint local_184 = {};
    type_8 local_185 = {};
    uint local_186 = {};
    uint local_187 = {};
    input = type_8 {};
    input.inner[0] = 0u;
    input.inner[1] = 0u;
    out = type_8 {};
    out.inner[0] = 1u;
    out.inner[1] = 0u;
    uint base = threadIdx.x * 36u;
    type_8 _e17 = input;
    local = _e17;
    local_1 = static_cast<uint>(threadIdx.x);
    type_8 _e22 = local;
    local_76 = _e22;
    uint _e24 = local_1;
    uint _e26 = local_76.inner[1];
    local_76.inner[1] = _e26 + _e24;
    uint _e30 = local_76.inner[0];
    local_77 = static_cast<uint>(_e30);
    uint _e34 = local_76.inner[1];
    local_78 = static_cast<uint>(_e34);
    uint _e37 = local_78;
    metal::int2 _e40 = input_1[_e37];
    local_79 = _e40;
    metal::int2 _e42 = local_79;
    local_75 = _e42;
    metal::int2 _e44 = local_75;
    left = _e44;
    right = metal::int2(3, 2);
    metal::int2 _e50 = left;
    metal::int2 _e51 = operator_u002b(_e50);
    type_8 _e54 = out;
    local_2 = _e54;
    local_3 = static_cast<uint>(base + 0u);
    type_8 _e61 = local_2;
    local_80 = _e61;
    uint _e63 = local_3;
    uint _e65 = local_80.inner[1];
    local_80.inner[1] = _e65 + _e63;
    uint _e69 = local_80.inner[0];
    local_81 = static_cast<uint>(_e69);
    uint _e73 = local_80.inner[1];
    local_82 = static_cast<uint>(_e73);
    uint _e76 = local_82;
    out_1[_e76] = static_cast<uint>(_e51.x);
    metal::int2 _e79 = left;
    metal::int2 _e80 = operator_u002d(_e79);
    type_8 _e82 = out;
    local_4 = _e82;
    local_5 = static_cast<uint>(base + 1u);
    type_8 _e89 = local_4;
    local_83 = _e89;
    uint _e91 = local_5;
    uint _e93 = local_83.inner[1];
    local_83.inner[1] = _e93 + _e91;
    uint _e97 = local_83.inner[0];
    local_84 = static_cast<uint>(_e97);
    uint _e101 = local_83.inner[1];
    local_85 = static_cast<uint>(_e101);
    uint _e104 = local_85;
    out_1[_e104] = static_cast<uint>(_e80.y);
    metal::int2 _e106 = left;
    metal::int2 _e107 = operator_u007e(_e106);
    type_8 _e109 = out;
    local_6 = _e109;
    local_7 = static_cast<uint>(base + 2u);
    type_8 _e116 = local_6;
    local_86 = _e116;
    uint _e118 = local_7;
    uint _e120 = local_86.inner[1];
    local_86.inner[1] = _e120 + _e118;
    uint _e124 = local_86.inner[0];
    local_87 = static_cast<uint>(_e124);
    uint _e128 = local_86.inner[1];
    local_88 = static_cast<uint>(_e128);
    uint _e131 = local_88;
    out_1[_e131] = static_cast<uint>(_e107.x);
    metal::int2 _e133 = left;
    bool _e134 = operator_u0021_(_e133);
    type_8 _e135 = out;
    local_8 = _e135;
    local_9 = static_cast<uint>(base + 3u);
    type_8 _e142 = local_8;
    local_89 = _e142;
    uint _e144 = local_9;
    uint _e146 = local_89.inner[1];
    local_89.inner[1] = _e146 + _e144;
    uint _e150 = local_89.inner[0];
    local_90 = static_cast<uint>(_e150);
    uint _e154 = local_89.inner[1];
    local_91 = static_cast<uint>(_e154);
    uint _e157 = local_91;
    out_1[_e157] = static_cast<uint>(_e134);
    metal::int2 _e159 = left;
    int _e160 = operator_u002a(_e159);
    type_8 _e161 = out;
    local_10 = _e161;
    local_11 = static_cast<uint>(base + 4u);
    type_8 _e168 = local_10;
    local_92 = _e168;
    uint _e170 = local_11;
    uint _e172 = local_92.inner[1];
    local_92.inner[1] = _e172 + _e170;
    uint _e176 = local_92.inner[0];
    local_93 = static_cast<uint>(_e176);
    uint _e180 = local_92.inner[1];
    local_94 = static_cast<uint>(_e180);
    uint _e183 = local_94;
    out_1[_e183] = static_cast<uint>(_e160);
    metal::int2 _e185 = left;
    metal::int2 _e186 = operator_u0026_(_e185);
    type_8 _e188 = out;
    local_12 = _e188;
    local_13 = static_cast<uint>(base + 5u);
    type_8 _e195 = local_12;
    local_95 = _e195;
    uint _e197 = local_13;
    uint _e199 = local_95.inner[1];
    local_95.inner[1] = _e199 + _e197;
    uint _e203 = local_95.inner[0];
    local_96 = static_cast<uint>(_e203);
    uint _e207 = local_95.inner[1];
    local_97 = static_cast<uint>(_e207);
    uint _e210 = local_97;
    out_1[_e210] = static_cast<uint>(_e186.x);
    metal::int2 _e212 = left;
    metal::int2 _e213 = right;
    metal::int2 _e214 = operator_u002b_1(_e212, _e213);
    type_8 _e216 = out;
    local_14 = _e216;
    local_15 = static_cast<uint>(base + 6u);
    type_8 _e223 = local_14;
    local_98 = _e223;
    uint _e225 = local_15;
    uint _e227 = local_98.inner[1];
    local_98.inner[1] = _e227 + _e225;
    uint _e231 = local_98.inner[0];
    local_99 = static_cast<uint>(_e231);
    uint _e235 = local_98.inner[1];
    local_100 = static_cast<uint>(_e235);
    uint _e238 = local_100;
    out_1[_e238] = static_cast<uint>(_e214.x);
    metal::int2 _e240 = left;
    metal::int2 _e241 = right;
    metal::int2 _e242 = operator_u002d_1(_e240, _e241);
    type_8 _e244 = out;
    local_16 = _e244;
    local_17 = static_cast<uint>(base + 7u);
    type_8 _e251 = local_16;
    local_101 = _e251;
    uint _e253 = local_17;
    uint _e255 = local_101.inner[1];
    local_101.inner[1] = _e255 + _e253;
    uint _e259 = local_101.inner[0];
    local_102 = static_cast<uint>(_e259);
    uint _e263 = local_101.inner[1];
    local_103 = static_cast<uint>(_e263);
    uint _e266 = local_103;
    out_1[_e266] = static_cast<uint>(_e242.y);
    metal::int2 _e268 = left;
    metal::int2 _e269 = right;
    metal::int2 _e270 = operator_u002a_1(_e268, _e269);
    type_8 _e272 = out;
    local_18 = _e272;
    local_19 = static_cast<uint>(base + 8u);
    type_8 _e279 = local_18;
    local_104 = _e279;
    uint _e281 = local_19;
    uint _e283 = local_104.inner[1];
    local_104.inner[1] = _e283 + _e281;
    uint _e287 = local_104.inner[0];
    local_105 = static_cast<uint>(_e287);
    uint _e291 = local_104.inner[1];
    local_106 = static_cast<uint>(_e291);
    uint _e294 = local_106;
    out_1[_e294] = static_cast<uint>(_e270.x);
    metal::int2 _e296 = left;
    metal::int2 _e297 = right;
    metal::int2 _e298 = operator_u002f(_e296, _e297);
    type_8 _e300 = out;
    local_20 = _e300;
    local_21 = static_cast<uint>(base + 9u);
    type_8 _e307 = local_20;
    local_107 = _e307;
    uint _e309 = local_21;
    uint _e311 = local_107.inner[1];
    local_107.inner[1] = _e311 + _e309;
    uint _e315 = local_107.inner[0];
    local_108 = static_cast<uint>(_e315);
    uint _e319 = local_107.inner[1];
    local_109 = static_cast<uint>(_e319);
    uint _e322 = local_109;
    out_1[_e322] = static_cast<uint>(_e298.y);
    metal::int2 _e324 = left;
    metal::int2 _e325 = right;
    metal::int2 _e326 = operator_u0025_(_e324, _e325);
    type_8 _e328 = out;
    local_22 = _e328;
    local_23 = static_cast<uint>(base + 10u);
    type_8 _e335 = local_22;
    local_110 = _e335;
    uint _e337 = local_23;
    uint _e339 = local_110.inner[1];
    local_110.inner[1] = _e339 + _e337;
    uint _e343 = local_110.inner[0];
    local_111 = static_cast<uint>(_e343);
    uint _e347 = local_110.inner[1];
    local_112 = static_cast<uint>(_e347);
    uint _e350 = local_112;
    out_1[_e350] = static_cast<uint>(_e326.y);
    metal::int2 _e352 = left;
    metal::int2 _e353 = right;
    metal::int2 _e354 = operator_u0026_1(_e352, _e353);
    type_8 _e356 = out;
    local_24 = _e356;
    local_25 = static_cast<uint>(base + 11u);
    type_8 _e363 = local_24;
    local_113 = _e363;
    uint _e365 = local_25;
    uint _e367 = local_113.inner[1];
    local_113.inner[1] = _e367 + _e365;
    uint _e371 = local_113.inner[0];
    local_114 = static_cast<uint>(_e371);
    uint _e375 = local_113.inner[1];
    local_115 = static_cast<uint>(_e375);
    uint _e378 = local_115;
    out_1[_e378] = static_cast<uint>(_e354.x);
    metal::int2 _e380 = left;
    metal::int2 _e381 = right;
    metal::int2 _e382 = operator_u007c(_e380, _e381);
    type_8 _e384 = out;
    local_26 = _e384;
    local_27 = static_cast<uint>(base + 12u);
    type_8 _e391 = local_26;
    local_116 = _e391;
    uint _e393 = local_27;
    uint _e395 = local_116.inner[1];
    local_116.inner[1] = _e395 + _e393;
    uint _e399 = local_116.inner[0];
    local_117 = static_cast<uint>(_e399);
    uint _e403 = local_116.inner[1];
    local_118 = static_cast<uint>(_e403);
    uint _e406 = local_118;
    out_1[_e406] = static_cast<uint>(_e382.y);
    metal::int2 _e408 = left;
    metal::int2 _e409 = right;
    metal::int2 _e410 = operator_u005e(_e408, _e409);
    type_8 _e412 = out;
    local_28 = _e412;
    local_29 = static_cast<uint>(base + 13u);
    type_8 _e419 = local_28;
    local_119 = _e419;
    uint _e421 = local_29;
    uint _e423 = local_119.inner[1];
    local_119.inner[1] = _e423 + _e421;
    uint _e427 = local_119.inner[0];
    local_120 = static_cast<uint>(_e427);
    uint _e431 = local_119.inner[1];
    local_121 = static_cast<uint>(_e431);
    uint _e434 = local_121;
    out_1[_e434] = static_cast<uint>(_e410.x);
    metal::int2 _e436 = left;
    metal::int2 _e437 = right;
    metal::int2 _e438 = operator_(_e436, _e437);
    type_8 _e440 = out;
    local_30 = _e440;
    local_31 = static_cast<uint>(base + 14u);
    type_8 _e447 = local_30;
    local_122 = _e447;
    uint _e449 = local_31;
    uint _e451 = local_122.inner[1];
    local_122.inner[1] = _e451 + _e449;
    uint _e455 = local_122.inner[0];
    local_123 = static_cast<uint>(_e455);
    uint _e459 = local_122.inner[1];
    local_124 = static_cast<uint>(_e459);
    uint _e462 = local_124;
    out_1[_e462] = static_cast<uint>(_e438.x);
    metal::int2 _e464 = left;
    metal::int2 _e465 = right;
    metal::int2 _e466 = operator_1(_e464, _e465);
    type_8 _e468 = out;
    local_32 = _e468;
    local_33 = static_cast<uint>(base + 15u);
    type_8 _e475 = local_32;
    local_125 = _e475;
    uint _e477 = local_33;
    uint _e479 = local_125.inner[1];
    local_125.inner[1] = _e479 + _e477;
    uint _e483 = local_125.inner[0];
    local_126 = static_cast<uint>(_e483);
    uint _e487 = local_125.inner[1];
    local_127 = static_cast<uint>(_e487);
    uint _e490 = local_127;
    out_1[_e490] = static_cast<uint>(_e466.y);
    metal::int2 _e492 = left;
    metal::int2 _e493 = operator_u002b(_e492);
    type_8 _e495 = out;
    local_34 = _e495;
    local_35 = static_cast<uint>(base + 16u);
    type_8 _e502 = local_34;
    local_128 = _e502;
    uint _e504 = local_35;
    uint _e506 = local_128.inner[1];
    local_128.inner[1] = _e506 + _e504;
    uint _e510 = local_128.inner[0];
    local_129 = static_cast<uint>(_e510);
    uint _e514 = local_128.inner[1];
    local_130 = static_cast<uint>(_e514);
    uint _e517 = local_130;
    out_1[_e517] = static_cast<uint>(_e493.y);
    metal::int2 _e519 = left;
    metal::int2 _e520 = right;
    metal::int2 _e521 = operator_u002d_1(_e519, _e520);
    type_8 _e523 = out;
    local_36 = _e523;
    local_37 = static_cast<uint>(base + 17u);
    type_8 _e530 = local_36;
    local_131 = _e530;
    uint _e532 = local_37;
    uint _e534 = local_131.inner[1];
    local_131.inner[1] = _e534 + _e532;
    uint _e538 = local_131.inner[0];
    local_132 = static_cast<uint>(_e538);
    uint _e542 = local_131.inner[1];
    local_133 = static_cast<uint>(_e542);
    uint _e545 = local_133;
    out_1[_e545] = static_cast<uint>(_e521.x);
    metal::int2 _e547 = left;
    int _e548 = operator_u002a(_e547);
    type_8 _e549 = out;
    local_38 = _e549;
    local_39 = static_cast<uint>(base + 18u);
    type_8 _e556 = local_38;
    local_134 = _e556;
    uint _e558 = local_39;
    uint _e560 = local_134.inner[1];
    local_134.inner[1] = _e560 + _e558;
    uint _e564 = local_134.inner[0];
    local_135 = static_cast<uint>(_e564);
    uint _e568 = local_134.inner[1];
    local_136 = static_cast<uint>(_e568);
    uint _e571 = local_136;
    out_1[_e571] = static_cast<uint>(_e548);
    metal::int2 _e573 = left;
    metal::int2 _e574 = right;
    metal::int2 _e575 = operator_u0026_1(_e573, _e574);
    type_8 _e577 = out;
    local_40 = _e577;
    local_41 = static_cast<uint>(base + 19u);
    type_8 _e584 = local_40;
    local_137 = _e584;
    uint _e586 = local_41;
    uint _e588 = local_137.inner[1];
    local_137.inner[1] = _e588 + _e586;
    uint _e592 = local_137.inner[0];
    local_138 = static_cast<uint>(_e592);
    uint _e596 = local_137.inner[1];
    local_139 = static_cast<uint>(_e596);
    uint _e599 = local_139;
    out_1[_e599] = static_cast<uint>(_e575.y);
    metal::int2 _e601 = left;
    metal::int2 _e602 = operator_u0026_(_e601);
    int _e603 = operator_u002a(_e602);
    type_8 _e604 = out;
    local_42 = _e604;
    local_43 = static_cast<uint>(base + 20u);
    type_8 _e611 = local_42;
    local_140 = _e611;
    uint _e613 = local_43;
    uint _e615 = local_140.inner[1];
    local_140.inner[1] = _e615 + _e613;
    uint _e619 = local_140.inner[0];
    local_141 = static_cast<uint>(_e619);
    uint _e623 = local_140.inner[1];
    local_142 = static_cast<uint>(_e623);
    uint _e626 = local_142;
    out_1[_e626] = static_cast<uint>(_e603);
    metal::int2 _e628 = left;
    metal::int2 _e629 = operator_u0026_(_e628);
    metal::int2 _e630 = operator_u0026_(_e629);
    type_8 _e632 = out;
    local_44 = _e632;
    local_45 = static_cast<uint>(base + 21u);
    type_8 _e639 = local_44;
    local_143 = _e639;
    uint _e641 = local_45;
    uint _e643 = local_143.inner[1];
    local_143.inner[1] = _e643 + _e641;
    uint _e647 = local_143.inner[0];
    local_144 = static_cast<uint>(_e647);
    uint _e651 = local_143.inner[1];
    local_145 = static_cast<uint>(_e651);
    uint _e654 = local_145;
    out_1[_e654] = static_cast<uint>(_e630.x);
    metal::int2 _e656 = left;
    metal::int2 _e657 = right;
    metal::int2 _e658 = right;
    metal::int2 _e659 = operator_u002a_1(_e657, _e658);
    metal::int2 _e660 = operator_u002b_1(_e656, _e659);
    type_8 _e662 = out;
    local_46 = _e662;
    local_47 = static_cast<uint>(base + 22u);
    type_8 _e669 = local_46;
    local_146 = _e669;
    uint _e671 = local_47;
    uint _e673 = local_146.inner[1];
    local_146.inner[1] = _e673 + _e671;
    uint _e677 = local_146.inner[0];
    local_147 = static_cast<uint>(_e677);
    uint _e681 = local_146.inner[1];
    local_148 = static_cast<uint>(_e681);
    uint _e684 = local_148;
    out_1[_e684] = static_cast<uint>(_e660.x);
    metal::int2 _e686 = left;
    metal::int2 _e687 = right;
    metal::int2 _e691 = operator_u002b_1(_e687, metal::int2(1, 1));
    metal::int2 _e692 = operator_(_e686, _e691);
    type_8 _e694 = out;
    local_48 = _e694;
    local_49 = static_cast<uint>(base + 23u);
    type_8 _e701 = local_48;
    local_149 = _e701;
    uint _e703 = local_49;
    uint _e705 = local_149.inner[1];
    local_149.inner[1] = _e705 + _e703;
    uint _e709 = local_149.inner[0];
    local_150 = static_cast<uint>(_e709);
    uint _e713 = local_149.inner[1];
    local_151 = static_cast<uint>(_e713);
    uint _e716 = local_151;
    out_1[_e716] = static_cast<uint>(_e692.x);
    metal::int2 _e718 = left;
    metal::int2 _e719 = right;
    metal::int2 _e723 = operator_u0026_1(_e719, metal::int2(1, 1));
    metal::int2 _e724 = operator_u007c(_e718, _e723);
    type_8 _e726 = out;
    local_50 = _e726;
    local_51 = static_cast<uint>(base + 24u);
    type_8 _e733 = local_50;
    local_152 = _e733;
    uint _e735 = local_51;
    uint _e737 = local_152.inner[1];
    local_152.inner[1] = _e737 + _e735;
    uint _e741 = local_152.inner[0];
    local_153 = static_cast<uint>(_e741);
    uint _e745 = local_152.inner[1];
    local_154 = static_cast<uint>(_e745);
    uint _e748 = local_154;
    out_1[_e748] = static_cast<uint>(_e724.y);
    metal::int2 _e750 = left;
    metal::int2 _e751 = right;
    metal::int2 _e752 = operator_u002d_1(_e750, _e751);
    metal::int2 _e753 = right;
    metal::int2 _e754 = operator_u002d_1(_e752, _e753);
    type_8 _e756 = out;
    local_52 = _e756;
    local_53 = static_cast<uint>(base + 25u);
    type_8 _e763 = local_52;
    local_155 = _e763;
    uint _e765 = local_53;
    uint _e767 = local_155.inner[1];
    local_155.inner[1] = _e767 + _e765;
    uint _e771 = local_155.inner[0];
    local_156 = static_cast<uint>(_e771);
    uint _e775 = local_155.inner[1];
    local_157 = static_cast<uint>(_e775);
    uint _e778 = local_157;
    out_1[_e778] = static_cast<uint>(_e754.x);
    original.value = 9;
    original.history.inner[0] = 1;
    original.history.inner[1] = 2;
    Record_cuda_record_0_ _e788 = original;
    Record_cuda_record_0_ _e790 = operator_u002a_3(_e788, 3);
    scaled = _e790;
    local_56.value = 9;
    local_56.history.inner[0] = 1;
    local_56.history.inner[1] = 2;
    Record_cuda_record_0_ _e800 = local_56;
    int _e801 = operator_u0026_2(_e800);
    type_8 _e802 = out;
    local_54 = _e802;
    local_55 = static_cast<uint>(base + 26u);
    type_8 _e809 = local_54;
    local_158 = _e809;
    uint _e811 = local_55;
    uint _e813 = local_158.inner[1];
    local_158.inner[1] = _e813 + _e811;
    uint _e817 = local_158.inner[0];
    local_159 = static_cast<uint>(_e817);
    uint _e821 = local_158.inner[1];
    local_160 = static_cast<uint>(_e821);
    uint _e824 = local_160;
    out_1[_e824] = static_cast<uint>(_e801);
    Record_cuda_record_0_ _e826 = original;
    Record_cuda_record_0_ _e827 = operator_u002a_2(_e826);
    int _e828 = operator_u0026_2(_e827);
    type_8 _e829 = out;
    local_57 = _e829;
    local_58 = static_cast<uint>(base + 27u);
    type_8 _e836 = local_57;
    local_161 = _e836;
    uint _e838 = local_58;
    uint _e840 = local_161.inner[1];
    local_161.inner[1] = _e840 + _e838;
    uint _e844 = local_161.inner[0];
    local_162 = static_cast<uint>(_e844);
    uint _e848 = local_161.inner[1];
    local_163 = static_cast<uint>(_e848);
    uint _e851 = local_163;
    out_1[_e851] = static_cast<uint>(_e828);
    int _e854 = scaled.value;
    type_8 _e855 = out;
    local_59 = _e855;
    local_60 = static_cast<uint>(base + 28u);
    type_8 _e862 = local_59;
    local_164 = _e862;
    uint _e864 = local_60;
    uint _e866 = local_164.inner[1];
    local_164.inner[1] = _e866 + _e864;
    uint _e870 = local_164.inner[0];
    local_165 = static_cast<uint>(_e870);
    uint _e874 = local_164.inner[1];
    local_166 = static_cast<uint>(_e874);
    uint _e877 = local_166;
    out_1[_e877] = static_cast<uint>(_e854);
    int _e882 = scaled.history.inner[1];
    type_8 _e883 = out;
    local_61 = _e883;
    local_62 = static_cast<uint>(base + 29u);
    type_8 _e890 = local_61;
    local_167 = _e890;
    uint _e892 = local_62;
    uint _e894 = local_167.inner[1];
    local_167.inner[1] = _e894 + _e892;
    uint _e898 = local_167.inner[0];
    local_168 = static_cast<uint>(_e898);
    uint _e902 = local_167.inner[1];
    local_169 = static_cast<uint>(_e902);
    uint _e905 = local_169;
    out_1[_e905] = static_cast<uint>(_e882);
    int _e908 = original.value;
    type_8 _e909 = out;
    local_63 = _e909;
    local_64 = static_cast<uint>(base + 30u);
    type_8 _e916 = local_63;
    local_170 = _e916;
    uint _e918 = local_64;
    uint _e920 = local_170.inner[1];
    local_170.inner[1] = _e920 + _e918;
    uint _e924 = local_170.inner[0];
    local_171 = static_cast<uint>(_e924);
    uint _e928 = local_170.inner[1];
    local_172 = static_cast<uint>(_e928);
    uint _e931 = local_172;
    out_1[_e931] = static_cast<uint>(_e908);
    int _e936 = original.history.inner[1];
    type_8 _e937 = out;
    local_65 = _e937;
    local_66 = static_cast<uint>(base + 31u);
    type_8 _e944 = local_65;
    local_173 = _e944;
    uint _e946 = local_66;
    uint _e948 = local_173.inner[1];
    local_173.inner[1] = _e948 + _e946;
    uint _e952 = local_173.inner[0];
    local_174 = static_cast<uint>(_e952);
    uint _e956 = local_173.inner[1];
    local_175 = static_cast<uint>(_e956);
    uint _e959 = local_175;
    out_1[_e959] = static_cast<uint>(_e936);
    Record_cuda_record_0_ _e961 = original;
    Record_cuda_record_0_ _e962 = operator_u002d_2(_e961);
    type_8 _e964 = out;
    local_67 = _e964;
    local_68 = static_cast<uint>(base + 32u);
    type_8 _e971 = local_67;
    local_176 = _e971;
    uint _e973 = local_68;
    uint _e975 = local_176.inner[1];
    local_176.inner[1] = _e975 + _e973;
    uint _e979 = local_176.inner[0];
    local_177 = static_cast<uint>(_e979);
    uint _e983 = local_176.inner[1];
    local_178 = static_cast<uint>(_e983);
    uint _e986 = local_178;
    out_1[_e986] = static_cast<uint>(_e962.value);
    Record_cuda_record_0_ _e988 = original;
    Record_cuda_record_0_ _e990 = operator_u002a_3(_e988, 2);
    type_8 _e992 = out;
    local_69 = _e992;
    local_70 = static_cast<uint>(base + 33u);
    type_8 _e999 = local_69;
    local_179 = _e999;
    uint _e1001 = local_70;
    uint _e1003 = local_179.inner[1];
    local_179.inner[1] = _e1003 + _e1001;
    uint _e1007 = local_179.inner[0];
    local_180 = static_cast<uint>(_e1007);
    uint _e1011 = local_179.inner[1];
    local_181 = static_cast<uint>(_e1011);
    uint _e1014 = local_181;
    out_1[_e1014] = static_cast<uint>(_e990.value);
    Record_cuda_record_0_ _e1016 = original;
    Record_cuda_record_0_ _e1017 = operator_u002a_2(_e1016);
    int _e1018 = operator_u0026_2(_e1017);
    type_8 _e1019 = out;
    local_71 = _e1019;
    local_72 = static_cast<uint>(base + 34u);
    type_8 _e1026 = local_71;
    local_182 = _e1026;
    uint _e1028 = local_72;
    uint _e1030 = local_182.inner[1];
    local_182.inner[1] = _e1030 + _e1028;
    uint _e1034 = local_182.inner[0];
    local_183 = static_cast<uint>(_e1034);
    uint _e1038 = local_182.inner[1];
    local_184 = static_cast<uint>(_e1038);
    uint _e1041 = local_184;
    out_1[_e1041] = static_cast<uint>(_e1018);
    bool _e1046 = operator_u0021_(metal::int2(0, 0));
    type_8 _e1047 = out;
    local_73 = _e1047;
    local_74 = static_cast<uint>(base + 35u);
    type_8 _e1054 = local_73;
    local_185 = _e1054;
    uint _e1056 = local_74;
    uint _e1058 = local_185.inner[1];
    local_185.inner[1] = _e1058 + _e1056;
    uint _e1062 = local_185.inner[0];
    local_186 = static_cast<uint>(_e1062);
    uint _e1066 = local_185.inner[1];
    local_187 = static_cast<uint>(_e1066);
    uint _e1069 = local_187;
    out_1[_e1069] = static_cast<uint>(_e1046);
}
