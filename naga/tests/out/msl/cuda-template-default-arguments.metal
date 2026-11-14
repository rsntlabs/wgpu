// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_4[1];
typedef int type_5[1];
struct type_7 {
    uint inner[2];
};
constant int Frozen_1 = 3;

int choose_template_default(
    bool value_3,
    int bias_1
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(400) + as_type<uint>(static_cast<int>(value_3)))) + as_type<uint>(bias_1));
}

int tied_template_default(
    int value_4,
    int bias_2
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(400) + as_type<uint>(value_4))) + as_type<uint>(bias_2));
}

int inner_template_default(
    int value_5,
    int extra
) {
    return as_type<int>(as_type<uint>(value_5) + as_type<uint>(extra));
}

int add_template_default_int(
    int renamed,
    int other
) {
    return as_type<int>(as_type<uint>(renamed) + as_type<uint>(other));
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int converted_template_default_int(
    int value_6,
    int bias_3,
    bool enabled,
    float scale
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(value_6) + as_type<uint>(bias_3))) + as_type<uint>(static_cast<int>(enabled)))) + as_type<uint>(naga_f2i32(scale)));
}

uint wrapped_template_default_int(
    uint value_7
) {
    return value_7;
}

int choose_template_default_int(
    int value_8,
    int bias_4
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(300) + as_type<uint>(value_8))) + as_type<uint>(bias_4));
}

int choose_template_default_bool(
    bool value_9,
    int bias_5
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(300) + as_type<uint>(static_cast<int>(value_9)))) + as_type<uint>(bias_5));
}

int tied_template_default_unsigned(
    uint value_10,
    int bias_6
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(500) + as_type<uint>(static_cast<int>(value_10)))) + as_type<uint>(bias_6));
}

int erased_template_default_5_(
    int result
) {
    return as_type<int>(as_type<uint>(result) + as_type<uint>(5));
}

int add_template_default_unsigned(
    uint renamed_1,
    int other_1
) {
    return as_type<int>(as_type<uint>(static_cast<int>(renamed_1)) + as_type<uint>(other_1));
}

int conditional_template_default_int(
    int value_11,
    int count
) {
    return as_type<int>(as_type<uint>(value_11) + as_type<uint>(count));
}

int casted_template_default_int(
    int value_12,
    int count_1
) {
    return as_type<int>(as_type<uint>(value_12) + as_type<uint>(count_1));
}

int explicit_value_template_default_3_(
    int bias_7
) {
    int _e2 = inner_template_default(bias_7, 2);
    return as_type<int>(as_type<uint>(_e2) + as_type<uint>(3));
}

struct template_default_argumentsInput {
};
kernel void template_default_arguments(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4& output_1 [[buffer(0)]]
, device type_5 const& input_3 [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    type_7 output = {};
    type_7 input = {};
    int value = {};
    int Frozen = {};
    type_7 local = {};
    type_7 local_1 = {};
    uint local_2 = {};
    type_7 local_3 = {};
    uint local_4 = {};
    type_7 local_5 = {};
    uint local_6 = {};
    type_7 local_7 = {};
    uint local_8 = {};
    type_7 local_9 = {};
    uint local_10 = {};
    type_7 local_11 = {};
    uint local_12 = {};
    type_7 local_13 = {};
    uint local_14 = {};
    type_7 local_15 = {};
    int local_16 = {};
    type_7 local_17 = {};
    uint local_18 = {};
    type_7 local_19 = {};
    int local_20 = {};
    type_7 local_21 = {};
    uint local_22 = {};
    type_7 local_23 = {};
    uint local_24 = {};
    type_7 local_25 = {};
    uint local_26 = {};
    type_7 local_27 = {};
    uint local_28 = {};
    type_7 local_29 = {};
    uint local_30 = {};
    type_7 local_31 = {};
    type_7 local_32 = {};
    uint local_33 = {};
    int index = {};
    type_7 local_34 = {};
    uint local_35 = {};
    type_7 local_36 = {};
    uint local_37 = {};
    bool local_38 = {};
    int local_39 = {};
    bool local_40 = {};
    int local_41 = {};
    int local_42 = {};
    int local_43 = {};
    int local_44 = {};
    type_7 local_45 = {};
    uint local_46 = {};
    type_7 local_47 = {};
    uint local_48 = {};
    type_7 local_49 = {};
    uint local_50 = {};
    type_7 local_51 = {};
    uint local_52 = {};
    type_7 local_53 = {};
    uint local_54 = {};
    type_7 local_55 = {};
    uint local_56 = {};
    type_7 local_57 = {};
    uint local_58 = {};
    type_7 value_1 = {};
    type_7 local_59 = {};
    int local_60 = {};
    type_7 value_2 = {};
    int bias = {};
    type_7 local_61 = {};
    int local_62 = {};
    int step = {};
    int old = {};
    int step_1 = {};
    int old_1 = {};
    type_7 input_1 = {};
    int index_1 = {};
    type_7 local_63 = {};
    uint local_64 = {};
    int local_65 = {};
    type_7 input_2 = {};
    int index_2 = {};
    type_7 local_66 = {};
    uint local_67 = {};
    int local_68 = {};
    int step_2 = {};
    int old_2 = {};
    int local_69 = {};
    int local_70 = {};
    int step_3 = {};
    int old_3 = {};
    int local_71 = {};
    int local_72 = {};
    int step_4 = {};
    int old_4 = {};
    int local_73 = {};
    int local_74 = {};
    int step_5 = {};
    int old_5 = {};
    int local_75 = {};
    int local_76 = {};
    int step_6 = {};
    int old_6 = {};
    type_7 local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    type_7 local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    type_7 local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    type_7 local_86 = {};
    uint local_87 = {};
    uint local_88 = {};
    type_7 local_89 = {};
    uint local_90 = {};
    uint local_91 = {};
    type_7 local_92 = {};
    uint local_93 = {};
    uint local_94 = {};
    type_7 local_95 = {};
    uint local_96 = {};
    uint local_97 = {};
    type_7 local_98 = {};
    uint local_99 = {};
    uint local_100 = {};
    type_7 local_101 = {};
    uint local_102 = {};
    uint local_103 = {};
    type_7 local_104 = {};
    uint local_105 = {};
    uint local_106 = {};
    type_7 local_107 = {};
    uint local_108 = {};
    uint local_109 = {};
    type_7 local_110 = {};
    uint local_111 = {};
    uint local_112 = {};
    type_7 local_113 = {};
    uint local_114 = {};
    uint local_115 = {};
    type_7 local_116 = {};
    uint local_117 = {};
    uint local_118 = {};
    type_7 local_119 = {};
    uint local_120 = {};
    uint local_121 = {};
    type_7 local_122 = {};
    uint local_123 = {};
    uint local_124 = {};
    type_7 local_125 = {};
    uint local_126 = {};
    uint local_127 = {};
    type_7 local_128 = {};
    uint local_129 = {};
    uint local_130 = {};
    type_7 local_131 = {};
    uint local_132 = {};
    uint local_133 = {};
    type_7 local_134 = {};
    uint local_135 = {};
    uint local_136 = {};
    type_7 local_137 = {};
    uint local_138 = {};
    uint local_139 = {};
    type_7 local_140 = {};
    uint local_141 = {};
    uint local_142 = {};
    type_7 local_143 = {};
    uint local_144 = {};
    uint local_145 = {};
    type_7 local_146 = {};
    uint local_147 = {};
    uint local_148 = {};
    type_7 local_149 = {};
    uint local_150 = {};
    uint local_151 = {};
    type_7 local_152 = {};
    uint local_153 = {};
    uint local_154 = {};
    type_7 local_155 = {};
    uint local_156 = {};
    uint local_157 = {};
    output = type_7 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    input = type_7 {};
    input.inner[0] = 3u;
    input.inner[1] = 0u;
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 23u);
    value = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    Frozen = 99;
    int _e24 = value;
    int _e26 = add_template_default_int(_e24, 3);
    type_7 _e29 = output;
    local = _e29;
    type_7 _e31 = local;
    local_77 = _e31;
    uint _e34 = local_77.inner[1];
    local_77.inner[1] = _e34 + base;
    uint _e38 = local_77.inner[0];
    local_78 = static_cast<uint>(_e38);
    uint _e42 = local_77.inner[1];
    local_79 = static_cast<uint>(_e42);
    uint _e45 = local_79;
    output_1[_e45] = static_cast<uint>(_e26);
    int _e48 = value;
    int _e50 = add_template_default_int(_e48, 9);
    type_7 _e52 = output;
    local_1 = _e52;
    local_2 = static_cast<uint>(base + 1u);
    type_7 _e58 = local_1;
    local_80 = _e58;
    uint _e60 = local_2;
    uint _e62 = local_80.inner[1];
    local_80.inner[1] = _e62 + _e60;
    uint _e66 = local_80.inner[0];
    local_81 = static_cast<uint>(_e66);
    uint _e70 = local_80.inner[1];
    local_82 = static_cast<uint>(_e70);
    uint _e73 = local_82;
    output_1[_e73] = static_cast<uint>(_e50);
    int _e75 = value;
    int _e79 = converted_template_default_int(_e75, 3, true, 2.0);
    type_7 _e81 = output;
    local_3 = _e81;
    local_4 = static_cast<uint>(base + 2u);
    type_7 _e87 = local_3;
    local_83 = _e87;
    uint _e89 = local_4;
    uint _e91 = local_83.inner[1];
    local_83.inner[1] = _e91 + _e89;
    uint _e95 = local_83.inner[0];
    local_84 = static_cast<uint>(_e95);
    uint _e99 = local_83.inner[1];
    local_85 = static_cast<uint>(_e99);
    uint _e102 = local_85;
    output_1[_e102] = static_cast<uint>(_e79);
    uint _e105 = wrapped_template_default_int(4294967295u);
    type_7 _e106 = output;
    local_5 = _e106;
    local_6 = static_cast<uint>(base + 3u);
    type_7 _e112 = local_5;
    local_86 = _e112;
    uint _e114 = local_6;
    uint _e116 = local_86.inner[1];
    local_86.inner[1] = _e116 + _e114;
    uint _e120 = local_86.inner[0];
    local_87 = static_cast<uint>(_e120);
    uint _e124 = local_86.inner[1];
    local_88 = static_cast<uint>(_e124);
    uint _e127 = local_88;
    output_1[_e127] = _e105;
    int _e131 = choose_template_default(true, 4);
    type_7 _e133 = output;
    local_7 = _e133;
    local_8 = static_cast<uint>(base + 4u);
    type_7 _e139 = local_7;
    local_89 = _e139;
    uint _e141 = local_8;
    uint _e143 = local_89.inner[1];
    local_89.inner[1] = _e143 + _e141;
    uint _e147 = local_89.inner[0];
    local_90 = static_cast<uint>(_e147);
    uint _e151 = local_89.inner[1];
    local_91 = static_cast<uint>(_e151);
    uint _e154 = local_91;
    output_1[_e154] = static_cast<uint>(_e131);
    int _e158 = choose_template_default_int(1, 3);
    type_7 _e160 = output;
    local_9 = _e160;
    local_10 = static_cast<uint>(base + 5u);
    type_7 _e166 = local_9;
    local_92 = _e166;
    uint _e168 = local_10;
    uint _e170 = local_92.inner[1];
    local_92.inner[1] = _e170 + _e168;
    uint _e174 = local_92.inner[0];
    local_93 = static_cast<uint>(_e174);
    uint _e178 = local_92.inner[1];
    local_94 = static_cast<uint>(_e178);
    uint _e181 = local_94;
    output_1[_e181] = static_cast<uint>(_e158);
    int _e185 = choose_template_default_bool(true, 3);
    type_7 _e187 = output;
    local_11 = _e187;
    local_12 = static_cast<uint>(base + 6u);
    type_7 _e193 = local_11;
    local_95 = _e193;
    uint _e195 = local_12;
    uint _e197 = local_95.inner[1];
    local_95.inner[1] = _e197 + _e195;
    uint _e201 = local_95.inner[0];
    local_96 = static_cast<uint>(_e201);
    uint _e205 = local_95.inner[1];
    local_97 = static_cast<uint>(_e205);
    uint _e208 = local_97;
    output_1[_e208] = static_cast<uint>(_e185);
    type_7 _e211 = input;
    local_15 = _e211;
    local_60 = int {};
    type_7 _e215 = local_15;
    value_1 = _e215;
    type_7 _e218 = value_1;
    local_59 = _e218;
    type_7 _e220 = local_59;
    local_98 = _e220;
    uint _e223 = local_98.inner[0];
    local_99 = static_cast<uint>(_e223);
    uint _e227 = local_98.inner[1];
    local_100 = static_cast<uint>(_e227);
    uint _e230 = local_100;
    int _e233 = input_3[_e230];
    local_60 = _e233;
    int _e235 = local_60;
    local_16 = as_type<int>(as_type<uint>(200) + as_type<uint>(_e235));
    int _e239 = local_16;
    type_7 _e241 = output;
    local_13 = _e241;
    local_14 = static_cast<uint>(base + 7u);
    type_7 _e247 = local_13;
    local_101 = _e247;
    uint _e249 = local_14;
    uint _e251 = local_101.inner[1];
    local_101.inner[1] = _e251 + _e249;
    uint _e255 = local_101.inner[0];
    local_102 = static_cast<uint>(_e255);
    uint _e259 = local_101.inner[1];
    local_103 = static_cast<uint>(_e259);
    uint _e262 = local_103;
    output_1[_e262] = static_cast<uint>(_e239);
    type_7 _e264 = input;
    local_19 = _e264;
    bias = int {};
    local_62 = int {};
    type_7 _e270 = local_19;
    value_2 = _e270;
    bias = 4;
    type_7 _e275 = value_2;
    local_61 = _e275;
    type_7 _e277 = local_61;
    local_104 = _e277;
    uint _e280 = local_104.inner[0];
    local_105 = static_cast<uint>(_e280);
    uint _e284 = local_104.inner[1];
    local_106 = static_cast<uint>(_e284);
    uint _e287 = local_106;
    int _e289 = input_3[_e287];
    local_62 = _e289;
    int _e291 = local_62;
    int _e294 = bias;
    local_20 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(200) + as_type<uint>(_e291))) + as_type<uint>(_e294));
    int _e297 = local_20;
    type_7 _e299 = output;
    local_17 = _e299;
    local_18 = static_cast<uint>(base + 8u);
    type_7 _e305 = local_17;
    local_107 = _e305;
    uint _e307 = local_18;
    uint _e309 = local_107.inner[1];
    local_107.inner[1] = _e309 + _e307;
    uint _e313 = local_107.inner[0];
    local_108 = static_cast<uint>(_e313);
    uint _e317 = local_107.inner[1];
    local_109 = static_cast<uint>(_e317);
    uint _e320 = local_109;
    output_1[_e320] = static_cast<uint>(_e297);
    int _e324 = tied_template_default(1, 2);
    type_7 _e326 = output;
    local_21 = _e326;
    local_22 = static_cast<uint>(base + 9u);
    type_7 _e332 = local_21;
    local_110 = _e332;
    uint _e334 = local_22;
    uint _e336 = local_110.inner[1];
    local_110.inner[1] = _e336 + _e334;
    uint _e340 = local_110.inner[0];
    local_111 = static_cast<uint>(_e340);
    uint _e344 = local_110.inner[1];
    local_112 = static_cast<uint>(_e344);
    uint _e347 = local_112;
    output_1[_e347] = static_cast<uint>(_e324);
    int _e351 = tied_template_default_unsigned(1u, 3);
    type_7 _e353 = output;
    local_23 = _e353;
    local_24 = static_cast<uint>(base + 10u);
    type_7 _e359 = local_23;
    local_113 = _e359;
    uint _e361 = local_24;
    uint _e363 = local_113.inner[1];
    local_113.inner[1] = _e363 + _e361;
    uint _e367 = local_113.inner[0];
    local_114 = static_cast<uint>(_e367);
    uint _e371 = local_113.inner[1];
    local_115 = static_cast<uint>(_e371);
    uint _e374 = local_115;
    output_1[_e374] = static_cast<uint>(_e351);
    step = int {};
    old = int {};
    step = 2;
    int _e382 = value;
    old = _e382;
    int _e384 = step;
    int _e385 = value;
    value = as_type<int>(as_type<uint>(_e385) + as_type<uint>(_e384));
    int _e387 = old;
    type_7 _e389 = output;
    local_25 = _e389;
    local_26 = static_cast<uint>(base + 11u);
    type_7 _e395 = local_25;
    local_116 = _e395;
    uint _e397 = local_26;
    uint _e399 = local_116.inner[1];
    local_116.inner[1] = _e399 + _e397;
    uint _e403 = local_116.inner[0];
    local_117 = static_cast<uint>(_e403);
    uint _e407 = local_116.inner[1];
    local_118 = static_cast<uint>(_e407);
    uint _e410 = local_118;
    output_1[_e410] = static_cast<uint>(_e387);
    step_1 = int {};
    old_1 = int {};
    step_1 = 5;
    int _e418 = value;
    old_1 = _e418;
    int _e420 = step_1;
    int _e421 = value;
    value = as_type<int>(as_type<uint>(_e421) + as_type<uint>(_e420));
    int _e423 = old_1;
    type_7 _e425 = output;
    local_27 = _e425;
    local_28 = static_cast<uint>(base + 12u);
    type_7 _e431 = local_27;
    local_119 = _e431;
    uint _e433 = local_28;
    uint _e435 = local_119.inner[1];
    local_119.inner[1] = _e435 + _e433;
    uint _e439 = local_119.inner[0];
    local_120 = static_cast<uint>(_e439);
    uint _e443 = local_119.inner[1];
    local_121 = static_cast<uint>(_e443);
    uint _e446 = local_121;
    output_1[_e446] = static_cast<uint>(_e423);
    type_7 _e448 = input;
    local_31 = _e448;
    index_1 = int {};
    local_64 = uint {};
    local_65 = int {};
    type_7 _e456 = local_31;
    input_1 = _e456;
    index_1 = 1;
    type_7 _e461 = input_1;
    local_63 = _e461;
    int _e463 = index_1;
    local_64 = static_cast<uint>(_e463);
    type_7 _e466 = local_63;
    local_122 = _e466;
    uint _e468 = local_64;
    uint _e470 = local_122.inner[1];
    local_122.inner[1] = _e470 + _e468;
    uint _e474 = local_122.inner[0];
    local_123 = static_cast<uint>(_e474);
    uint _e478 = local_122.inner[1];
    local_124 = static_cast<uint>(_e478);
    uint _e481 = local_124;
    int _e483 = input_3[_e481];
    local_65 = _e483;
    int _e485 = local_65;
    type_7 _e487 = output;
    local_29 = _e487;
    local_30 = static_cast<uint>(base + 13u);
    type_7 _e493 = local_29;
    local_125 = _e493;
    uint _e495 = local_30;
    uint _e497 = local_125.inner[1];
    local_125.inner[1] = _e497 + _e495;
    uint _e501 = local_125.inner[0];
    local_126 = static_cast<uint>(_e501);
    uint _e505 = local_125.inner[1];
    local_127 = static_cast<uint>(_e505);
    uint _e508 = local_127;
    output_1[_e508] = static_cast<uint>(_e485);
    int _e511 = erased_template_default_5_(7);
    type_7 _e513 = output;
    local_32 = _e513;
    local_33 = static_cast<uint>(base + 14u);
    type_7 _e519 = local_32;
    local_128 = _e519;
    uint _e521 = local_33;
    uint _e523 = local_128.inner[1];
    local_128.inner[1] = _e523 + _e521;
    uint _e527 = local_128.inner[0];
    local_129 = static_cast<uint>(_e527);
    uint _e531 = local_128.inner[1];
    local_130 = static_cast<uint>(_e531);
    uint _e534 = local_130;
    output_1[_e534] = static_cast<uint>(_e511);
    index = 0;
    type_7 _e538 = input;
    local_36 = _e538;
    int _e540 = index;
    index = as_type<int>(as_type<uint>(_e540) + as_type<uint>(1));
    local_37 = static_cast<uint>(_e540);
    index_2 = int {};
    local_67 = uint {};
    local_68 = int {};
    type_7 _e551 = local_36;
    input_2 = _e551;
    uint _e553 = local_37;
    uint _e555 = input_2.inner[1];
    input_2.inner[1] = _e555 + _e553;
    index_2 = 1;
    type_7 _e561 = input_2;
    local_66 = _e561;
    int _e563 = index_2;
    local_67 = static_cast<uint>(_e563);
    type_7 _e566 = local_66;
    local_131 = _e566;
    uint _e568 = local_67;
    uint _e570 = local_131.inner[1];
    local_131.inner[1] = _e570 + _e568;
    uint _e574 = local_131.inner[0];
    local_132 = static_cast<uint>(_e574);
    uint _e578 = local_131.inner[1];
    local_133 = static_cast<uint>(_e578);
    uint _e581 = local_133;
    int _e583 = input_3[_e581];
    local_68 = _e583;
    int _e585 = local_68;
    type_7 _e587 = output;
    local_34 = _e587;
    local_35 = static_cast<uint>(base + 15u);
    type_7 _e593 = local_34;
    local_134 = _e593;
    uint _e595 = local_35;
    uint _e597 = local_134.inner[1];
    local_134.inner[1] = _e597 + _e595;
    uint _e601 = local_134.inner[0];
    local_135 = static_cast<uint>(_e601);
    uint _e605 = local_134.inner[1];
    local_136 = static_cast<uint>(_e605);
    uint _e608 = local_136;
    output_1[_e608] = static_cast<uint>(_e585);
    local_38 = false;
    if (false) {
        step_2 = int {};
        old_2 = int {};
        step_2 = 2;
        int _e618 = value;
        local_69 = _e618;
        int _e620 = local_69;
        old_2 = _e620;
        int _e622 = step_2;
        int _e623 = value;
        local_70 = _e623;
        int _e625 = local_70;
        value = as_type<int>(as_type<uint>(_e625) + as_type<uint>(_e622));
        int _e627 = old_2;
        local_39 = _e627;
        int _e629 = local_39;
        local_38 = _e629 != 0;
    }
    local_40 = true;
    if (true) {
    } else {
        step_3 = int {};
        old_3 = int {};
        step_3 = 2;
        int _e640 = value;
        local_71 = _e640;
        int _e642 = local_71;
        old_3 = _e642;
        int _e644 = step_3;
        int _e645 = value;
        local_72 = _e645;
        int _e647 = local_72;
        value = as_type<int>(as_type<uint>(_e647) + as_type<uint>(_e644));
        int _e649 = old_3;
        local_41 = _e649;
        int _e651 = local_41;
        local_40 = _e651 != 0;
    }
    if ((lane & 1u) == 0u) {
        step_4 = int {};
        old_4 = int {};
        step_4 = 2;
        int _e664 = value;
        local_73 = _e664;
        int _e666 = local_73;
        old_4 = _e666;
        int _e668 = step_4;
        int _e669 = value;
        local_74 = _e669;
        int _e671 = local_74;
        value = as_type<int>(as_type<uint>(_e671) + as_type<uint>(_e668));
        int _e673 = old_4;
        local_42 = _e673;
        int _e675 = local_42;
        local_44 = _e675;
    } else {
        step_5 = int {};
        old_5 = int {};
        step_5 = 3;
        int _e683 = value;
        local_75 = _e683;
        int _e685 = local_75;
        old_5 = _e685;
        int _e687 = step_5;
        int _e688 = value;
        local_76 = _e688;
        int _e690 = local_76;
        value = as_type<int>(as_type<uint>(_e690) + as_type<uint>(_e687));
        int _e692 = old_5;
        local_43 = _e692;
        int _e694 = local_43;
        local_44 = _e694;
    }
    step_6 = int {};
    old_6 = int {};
    step_6 = 2;
    int _e702 = value;
    old_6 = _e702;
    int _e704 = step_6;
    int _e705 = value;
    value = as_type<int>(as_type<uint>(_e705) + as_type<uint>(_e704));
    int _e707 = value;
    type_7 _e709 = output;
    local_45 = _e709;
    local_46 = static_cast<uint>(base + 16u);
    type_7 _e715 = local_45;
    local_137 = _e715;
    uint _e717 = local_46;
    uint _e719 = local_137.inner[1];
    local_137.inner[1] = _e719 + _e717;
    uint _e723 = local_137.inner[0];
    local_138 = static_cast<uint>(_e723);
    uint _e727 = local_137.inner[1];
    local_139 = static_cast<uint>(_e727);
    uint _e730 = local_139;
    output_1[_e730] = static_cast<uint>(_e707);
    int _e732 = index;
    type_7 _e734 = output;
    local_47 = _e734;
    local_48 = static_cast<uint>(base + 17u);
    type_7 _e740 = local_47;
    local_140 = _e740;
    uint _e742 = local_48;
    uint _e744 = local_140.inner[1];
    local_140.inner[1] = _e744 + _e742;
    uint _e748 = local_140.inner[0];
    local_141 = static_cast<uint>(_e748);
    uint _e752 = local_140.inner[1];
    local_142 = static_cast<uint>(_e752);
    uint _e755 = local_142;
    output_1[_e755] = static_cast<uint>(_e732);
    int _e759 = add_template_default_int(0, 3);
    type_7 _e761 = output;
    local_49 = _e761;
    local_50 = static_cast<uint>(base + 18u);
    type_7 _e767 = local_49;
    local_143 = _e767;
    uint _e769 = local_50;
    uint _e771 = local_143.inner[1];
    local_143.inner[1] = _e771 + _e769;
    uint _e775 = local_143.inner[0];
    local_144 = static_cast<uint>(_e775);
    uint _e779 = local_143.inner[1];
    local_145 = static_cast<uint>(_e779);
    uint _e782 = local_145;
    output_1[_e782] = static_cast<uint>(_e759);
    int _e786 = add_template_default_unsigned(2u, 3);
    type_7 _e788 = output;
    local_51 = _e788;
    local_52 = static_cast<uint>(base + 19u);
    type_7 _e794 = local_51;
    local_146 = _e794;
    uint _e796 = local_52;
    uint _e798 = local_146.inner[1];
    local_146.inner[1] = _e798 + _e796;
    uint _e802 = local_146.inner[0];
    local_147 = static_cast<uint>(_e802);
    uint _e806 = local_146.inner[1];
    local_148 = static_cast<uint>(_e806);
    uint _e809 = local_148;
    output_1[_e809] = static_cast<uint>(_e786);
    int _e813 = conditional_template_default_int(1, 2);
    type_7 _e815 = output;
    local_53 = _e815;
    local_54 = static_cast<uint>(base + 20u);
    type_7 _e821 = local_53;
    local_149 = _e821;
    uint _e823 = local_54;
    uint _e825 = local_149.inner[1];
    local_149.inner[1] = _e825 + _e823;
    uint _e829 = local_149.inner[0];
    local_150 = static_cast<uint>(_e829);
    uint _e833 = local_149.inner[1];
    local_151 = static_cast<uint>(_e833);
    uint _e836 = local_151;
    output_1[_e836] = static_cast<uint>(_e813);
    int _e840 = casted_template_default_int(1, 3);
    type_7 _e842 = output;
    local_55 = _e842;
    local_56 = static_cast<uint>(base + 21u);
    type_7 _e848 = local_55;
    local_152 = _e848;
    uint _e850 = local_56;
    uint _e852 = local_152.inner[1];
    local_152.inner[1] = _e852 + _e850;
    uint _e856 = local_152.inner[0];
    local_153 = static_cast<uint>(_e856);
    uint _e860 = local_152.inner[1];
    local_154 = static_cast<uint>(_e860);
    uint _e863 = local_154;
    output_1[_e863] = static_cast<uint>(_e840);
    int _e866 = explicit_value_template_default_3_(7);
    type_7 _e868 = output;
    local_57 = _e868;
    local_58 = static_cast<uint>(base + 22u);
    type_7 _e874 = local_57;
    local_155 = _e874;
    uint _e876 = local_58;
    uint _e878 = local_155.inner[1];
    local_155.inner[1] = _e878 + _e876;
    uint _e882 = local_155.inner[0];
    local_156 = static_cast<uint>(_e882);
    uint _e886 = local_155.inner[1];
    local_157 = static_cast<uint>(_e886);
    uint _e889 = local_157;
    output_1[_e889] = static_cast<uint>(_e866);
}
