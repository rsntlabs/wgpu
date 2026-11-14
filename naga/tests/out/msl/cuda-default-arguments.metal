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

int add_default(
    int value_1,
    int step_7
) {
    return as_type<int>(as_type<uint>(value_1) + as_type<uint>(step_7));
}

int combine_default(
    int first,
    int second
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(first) * as_type<uint>(10))) + as_type<uint>(second));
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int converted_default(
    int value_2,
    bool enabled,
    float scale
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(value_2) + as_type<uint>(static_cast<int>(enabled)))) + as_type<uint>(naga_f2i32(scale)));
}

uint wrapped_default(
    uint value_3
) {
    return value_3;
}

int choose_default(
    int value_4,
    int extra
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(100) + as_type<uint>(value_4))) + as_type<uint>(extra));
}

int choose_default_1(
    uint value_5,
    float extra_1
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(200) + as_type<uint>(static_cast<int>(value_5)))) + as_type<uint>(naga_f2i32(extra_1)));
}

int choose_default_2(
    bool value_6,
    int extra_2
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(300) + as_type<uint>(static_cast<int>(value_6)))) + as_type<uint>(extra_2));
}

int erased_default(
    int result
) {
    return result;
}

int ranked_default(
    int value_7,
    int extra_3
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(400) + as_type<uint>(value_7))) + as_type<uint>(extra_3));
}

int ranked_default_unsigned(
    uint value_8
) {
    return as_type<int>(as_type<uint>(500) + as_type<uint>(static_cast<int>(value_8)));
}

struct default_argumentsInput {
};
kernel void default_arguments(
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
    uint local_16 = {};
    type_7 local_17 = {};
    uint local_18 = {};
    type_7 local_19 = {};
    uint local_20 = {};
    type_7 local_21 = {};
    uint local_22 = {};
    type_7 local_23 = {};
    uint local_24 = {};
    type_7 local_25 = {};
    type_7 local_26 = {};
    uint local_27 = {};
    int index = {};
    type_7 local_28 = {};
    uint local_29 = {};
    type_7 local_30 = {};
    uint local_31 = {};
    bool local_32 = {};
    int local_33 = {};
    bool local_34 = {};
    int local_35 = {};
    int local_36 = {};
    int local_37 = {};
    int local_38 = {};
    type_7 local_39 = {};
    uint local_40 = {};
    type_7 local_41 = {};
    uint local_42 = {};
    type_7 local_43 = {};
    uint local_44 = {};
    type_7 local_45 = {};
    uint local_46 = {};
    type_7 local_47 = {};
    uint local_48 = {};
    int step = {};
    int old = {};
    int step_1 = {};
    int old_1 = {};
    type_7 input_1 = {};
    int index_1 = {};
    type_7 local_49 = {};
    uint local_50 = {};
    int local_51 = {};
    type_7 input_2 = {};
    int index_2 = {};
    type_7 local_52 = {};
    uint local_53 = {};
    int local_54 = {};
    int step_2 = {};
    int old_2 = {};
    int local_55 = {};
    int local_56 = {};
    int step_3 = {};
    int old_3 = {};
    int local_57 = {};
    int local_58 = {};
    int step_4 = {};
    int old_4 = {};
    int local_59 = {};
    int local_60 = {};
    int step_5 = {};
    int old_5 = {};
    int local_61 = {};
    int local_62 = {};
    int step_6 = {};
    int old_6 = {};
    type_7 local_63 = {};
    uint local_64 = {};
    uint local_65 = {};
    type_7 local_66 = {};
    uint local_67 = {};
    uint local_68 = {};
    type_7 local_69 = {};
    uint local_70 = {};
    uint local_71 = {};
    type_7 local_72 = {};
    uint local_73 = {};
    uint local_74 = {};
    type_7 local_75 = {};
    uint local_76 = {};
    uint local_77 = {};
    type_7 local_78 = {};
    uint local_79 = {};
    uint local_80 = {};
    type_7 local_81 = {};
    uint local_82 = {};
    uint local_83 = {};
    type_7 local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    type_7 local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    type_7 local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    type_7 local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    type_7 local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    type_7 local_99 = {};
    uint local_100 = {};
    uint local_101 = {};
    type_7 local_102 = {};
    uint local_103 = {};
    uint local_104 = {};
    type_7 local_105 = {};
    uint local_106 = {};
    uint local_107 = {};
    type_7 local_108 = {};
    uint local_109 = {};
    uint local_110 = {};
    type_7 local_111 = {};
    uint local_112 = {};
    uint local_113 = {};
    type_7 local_114 = {};
    uint local_115 = {};
    uint local_116 = {};
    type_7 local_117 = {};
    uint local_118 = {};
    uint local_119 = {};
    type_7 local_120 = {};
    uint local_121 = {};
    uint local_122 = {};
    type_7 local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    type_7 local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    output = type_7 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    input = type_7 {};
    input.inner[0] = 3u;
    input.inner[1] = 0u;
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 20u);
    value = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    Frozen = 99;
    int _e24 = value;
    int _e26 = add_default(_e24, 3);
    type_7 _e29 = output;
    local = _e29;
    type_7 _e31 = local;
    local_63 = _e31;
    uint _e34 = local_63.inner[1];
    local_63.inner[1] = _e34 + base;
    uint _e38 = local_63.inner[0];
    local_64 = static_cast<uint>(_e38);
    uint _e42 = local_63.inner[1];
    local_65 = static_cast<uint>(_e42);
    uint _e45 = local_65;
    output_1[_e45] = static_cast<uint>(_e26);
    int _e48 = value;
    int _e50 = add_default(_e48, 9);
    type_7 _e52 = output;
    local_1 = _e52;
    local_2 = static_cast<uint>(base + 1u);
    type_7 _e58 = local_1;
    local_66 = _e58;
    uint _e60 = local_2;
    uint _e62 = local_66.inner[1];
    local_66.inner[1] = _e62 + _e60;
    uint _e66 = local_66.inner[0];
    local_67 = static_cast<uint>(_e66);
    uint _e70 = local_66.inner[1];
    local_68 = static_cast<uint>(_e70);
    uint _e73 = local_68;
    output_1[_e73] = static_cast<uint>(_e50);
    int _e77 = combine_default(2, 1);
    type_7 _e79 = output;
    local_3 = _e79;
    local_4 = static_cast<uint>(base + 2u);
    type_7 _e85 = local_3;
    local_69 = _e85;
    uint _e87 = local_4;
    uint _e89 = local_69.inner[1];
    local_69.inner[1] = _e89 + _e87;
    uint _e93 = local_69.inner[0];
    local_70 = static_cast<uint>(_e93);
    uint _e97 = local_69.inner[1];
    local_71 = static_cast<uint>(_e97);
    uint _e100 = local_71;
    output_1[_e100] = static_cast<uint>(_e77);
    int _e104 = combine_default(4, 1);
    type_7 _e106 = output;
    local_5 = _e106;
    local_6 = static_cast<uint>(base + 3u);
    type_7 _e112 = local_5;
    local_72 = _e112;
    uint _e114 = local_6;
    uint _e116 = local_72.inner[1];
    local_72.inner[1] = _e116 + _e114;
    uint _e120 = local_72.inner[0];
    local_73 = static_cast<uint>(_e120);
    uint _e124 = local_72.inner[1];
    local_74 = static_cast<uint>(_e124);
    uint _e127 = local_74;
    output_1[_e127] = static_cast<uint>(_e104);
    int _e131 = combine_default(4, 5);
    type_7 _e133 = output;
    local_7 = _e133;
    local_8 = static_cast<uint>(base + 4u);
    type_7 _e139 = local_7;
    local_75 = _e139;
    uint _e141 = local_8;
    uint _e143 = local_75.inner[1];
    local_75.inner[1] = _e143 + _e141;
    uint _e147 = local_75.inner[0];
    local_76 = static_cast<uint>(_e147);
    uint _e151 = local_75.inner[1];
    local_77 = static_cast<uint>(_e151);
    uint _e154 = local_77;
    output_1[_e154] = static_cast<uint>(_e131);
    int _e159 = converted_default(3, true, 2.0);
    type_7 _e161 = output;
    local_9 = _e161;
    local_10 = static_cast<uint>(base + 5u);
    type_7 _e167 = local_9;
    local_78 = _e167;
    uint _e169 = local_10;
    uint _e171 = local_78.inner[1];
    local_78.inner[1] = _e171 + _e169;
    uint _e175 = local_78.inner[0];
    local_79 = static_cast<uint>(_e175);
    uint _e179 = local_78.inner[1];
    local_80 = static_cast<uint>(_e179);
    uint _e182 = local_80;
    output_1[_e182] = static_cast<uint>(_e159);
    uint _e185 = wrapped_default(4294967295u);
    type_7 _e186 = output;
    local_11 = _e186;
    local_12 = static_cast<uint>(base + 6u);
    type_7 _e192 = local_11;
    local_81 = _e192;
    uint _e194 = local_12;
    uint _e196 = local_81.inner[1];
    local_81.inner[1] = _e196 + _e194;
    uint _e200 = local_81.inner[0];
    local_82 = static_cast<uint>(_e200);
    uint _e204 = local_81.inner[1];
    local_83 = static_cast<uint>(_e204);
    uint _e207 = local_83;
    output_1[_e207] = _e185;
    int _e211 = choose_default(1, 1);
    type_7 _e213 = output;
    local_13 = _e213;
    local_14 = static_cast<uint>(base + 7u);
    type_7 _e219 = local_13;
    local_84 = _e219;
    uint _e221 = local_14;
    uint _e223 = local_84.inner[1];
    local_84.inner[1] = _e223 + _e221;
    uint _e227 = local_84.inner[0];
    local_85 = static_cast<uint>(_e227);
    uint _e231 = local_84.inner[1];
    local_86 = static_cast<uint>(_e231);
    uint _e234 = local_86;
    output_1[_e234] = static_cast<uint>(_e211);
    int _e238 = choose_default_1(1u, 2.0);
    type_7 _e240 = output;
    local_15 = _e240;
    local_16 = static_cast<uint>(base + 8u);
    type_7 _e246 = local_15;
    local_87 = _e246;
    uint _e248 = local_16;
    uint _e250 = local_87.inner[1];
    local_87.inner[1] = _e250 + _e248;
    uint _e254 = local_87.inner[0];
    local_88 = static_cast<uint>(_e254);
    uint _e258 = local_87.inner[1];
    local_89 = static_cast<uint>(_e258);
    uint _e261 = local_89;
    output_1[_e261] = static_cast<uint>(_e238);
    int _e265 = choose_default_2(true, 3);
    type_7 _e267 = output;
    local_17 = _e267;
    local_18 = static_cast<uint>(base + 9u);
    type_7 _e273 = local_17;
    local_90 = _e273;
    uint _e275 = local_18;
    uint _e277 = local_90.inner[1];
    local_90.inner[1] = _e277 + _e275;
    uint _e281 = local_90.inner[0];
    local_91 = static_cast<uint>(_e281);
    uint _e285 = local_90.inner[1];
    local_92 = static_cast<uint>(_e285);
    uint _e288 = local_92;
    output_1[_e288] = static_cast<uint>(_e265);
    step = int {};
    old = int {};
    step = 2;
    int _e296 = value;
    old = _e296;
    int _e298 = step;
    int _e299 = value;
    value = as_type<int>(as_type<uint>(_e299) + as_type<uint>(_e298));
    int _e301 = old;
    type_7 _e303 = output;
    local_19 = _e303;
    local_20 = static_cast<uint>(base + 10u);
    type_7 _e309 = local_19;
    local_93 = _e309;
    uint _e311 = local_20;
    uint _e313 = local_93.inner[1];
    local_93.inner[1] = _e313 + _e311;
    uint _e317 = local_93.inner[0];
    local_94 = static_cast<uint>(_e317);
    uint _e321 = local_93.inner[1];
    local_95 = static_cast<uint>(_e321);
    uint _e324 = local_95;
    output_1[_e324] = static_cast<uint>(_e301);
    step_1 = int {};
    old_1 = int {};
    step_1 = 5;
    int _e332 = value;
    old_1 = _e332;
    int _e334 = step_1;
    int _e335 = value;
    value = as_type<int>(as_type<uint>(_e335) + as_type<uint>(_e334));
    int _e337 = old_1;
    type_7 _e339 = output;
    local_21 = _e339;
    local_22 = static_cast<uint>(base + 11u);
    type_7 _e345 = local_21;
    local_96 = _e345;
    uint _e347 = local_22;
    uint _e349 = local_96.inner[1];
    local_96.inner[1] = _e349 + _e347;
    uint _e353 = local_96.inner[0];
    local_97 = static_cast<uint>(_e353);
    uint _e357 = local_96.inner[1];
    local_98 = static_cast<uint>(_e357);
    uint _e360 = local_98;
    output_1[_e360] = static_cast<uint>(_e337);
    type_7 _e363 = input;
    local_25 = _e363;
    index_1 = int {};
    local_50 = uint {};
    local_51 = int {};
    type_7 _e371 = local_25;
    input_1 = _e371;
    index_1 = 1;
    type_7 _e376 = input_1;
    local_49 = _e376;
    int _e378 = index_1;
    local_50 = static_cast<uint>(_e378);
    type_7 _e381 = local_49;
    local_99 = _e381;
    uint _e383 = local_50;
    uint _e385 = local_99.inner[1];
    local_99.inner[1] = _e385 + _e383;
    uint _e389 = local_99.inner[0];
    local_100 = static_cast<uint>(_e389);
    uint _e393 = local_99.inner[1];
    local_101 = static_cast<uint>(_e393);
    uint _e396 = local_101;
    int _e399 = input_3[_e396];
    local_51 = _e399;
    int _e401 = local_51;
    type_7 _e403 = output;
    local_23 = _e403;
    local_24 = static_cast<uint>(base + 12u);
    type_7 _e409 = local_23;
    local_102 = _e409;
    uint _e411 = local_24;
    uint _e413 = local_102.inner[1];
    local_102.inner[1] = _e413 + _e411;
    uint _e417 = local_102.inner[0];
    local_103 = static_cast<uint>(_e417);
    uint _e421 = local_102.inner[1];
    local_104 = static_cast<uint>(_e421);
    uint _e424 = local_104;
    output_1[_e424] = static_cast<uint>(_e401);
    int _e427 = erased_default(7);
    type_7 _e429 = output;
    local_26 = _e429;
    local_27 = static_cast<uint>(base + 13u);
    type_7 _e435 = local_26;
    local_105 = _e435;
    uint _e437 = local_27;
    uint _e439 = local_105.inner[1];
    local_105.inner[1] = _e439 + _e437;
    uint _e443 = local_105.inner[0];
    local_106 = static_cast<uint>(_e443);
    uint _e447 = local_105.inner[1];
    local_107 = static_cast<uint>(_e447);
    uint _e450 = local_107;
    output_1[_e450] = static_cast<uint>(_e427);
    index = 0;
    type_7 _e454 = input;
    local_30 = _e454;
    int _e456 = index;
    index = as_type<int>(as_type<uint>(_e456) + as_type<uint>(1));
    local_31 = static_cast<uint>(_e456);
    index_2 = int {};
    local_53 = uint {};
    local_54 = int {};
    type_7 _e467 = local_30;
    input_2 = _e467;
    uint _e469 = local_31;
    uint _e471 = input_2.inner[1];
    input_2.inner[1] = _e471 + _e469;
    index_2 = 1;
    type_7 _e477 = input_2;
    local_52 = _e477;
    int _e479 = index_2;
    local_53 = static_cast<uint>(_e479);
    type_7 _e482 = local_52;
    local_108 = _e482;
    uint _e484 = local_53;
    uint _e486 = local_108.inner[1];
    local_108.inner[1] = _e486 + _e484;
    uint _e490 = local_108.inner[0];
    local_109 = static_cast<uint>(_e490);
    uint _e494 = local_108.inner[1];
    local_110 = static_cast<uint>(_e494);
    uint _e497 = local_110;
    int _e499 = input_3[_e497];
    local_54 = _e499;
    int _e501 = local_54;
    type_7 _e503 = output;
    local_28 = _e503;
    local_29 = static_cast<uint>(base + 14u);
    type_7 _e509 = local_28;
    local_111 = _e509;
    uint _e511 = local_29;
    uint _e513 = local_111.inner[1];
    local_111.inner[1] = _e513 + _e511;
    uint _e517 = local_111.inner[0];
    local_112 = static_cast<uint>(_e517);
    uint _e521 = local_111.inner[1];
    local_113 = static_cast<uint>(_e521);
    uint _e524 = local_113;
    output_1[_e524] = static_cast<uint>(_e501);
    local_32 = false;
    if (false) {
        step_2 = int {};
        old_2 = int {};
        step_2 = 2;
        int _e534 = value;
        local_55 = _e534;
        int _e536 = local_55;
        old_2 = _e536;
        int _e538 = step_2;
        int _e539 = value;
        local_56 = _e539;
        int _e541 = local_56;
        value = as_type<int>(as_type<uint>(_e541) + as_type<uint>(_e538));
        int _e543 = old_2;
        local_33 = _e543;
        int _e545 = local_33;
        local_32 = _e545 != 0;
    }
    local_34 = true;
    if (true) {
    } else {
        step_3 = int {};
        old_3 = int {};
        step_3 = 2;
        int _e556 = value;
        local_57 = _e556;
        int _e558 = local_57;
        old_3 = _e558;
        int _e560 = step_3;
        int _e561 = value;
        local_58 = _e561;
        int _e563 = local_58;
        value = as_type<int>(as_type<uint>(_e563) + as_type<uint>(_e560));
        int _e565 = old_3;
        local_35 = _e565;
        int _e567 = local_35;
        local_34 = _e567 != 0;
    }
    if ((lane & 1u) == 0u) {
        step_4 = int {};
        old_4 = int {};
        step_4 = 2;
        int _e580 = value;
        local_59 = _e580;
        int _e582 = local_59;
        old_4 = _e582;
        int _e584 = step_4;
        int _e585 = value;
        local_60 = _e585;
        int _e587 = local_60;
        value = as_type<int>(as_type<uint>(_e587) + as_type<uint>(_e584));
        int _e589 = old_4;
        local_36 = _e589;
        int _e591 = local_36;
        local_38 = _e591;
    } else {
        step_5 = int {};
        old_5 = int {};
        step_5 = 3;
        int _e599 = value;
        local_61 = _e599;
        int _e601 = local_61;
        old_5 = _e601;
        int _e603 = step_5;
        int _e604 = value;
        local_62 = _e604;
        int _e606 = local_62;
        value = as_type<int>(as_type<uint>(_e606) + as_type<uint>(_e603));
        int _e608 = old_5;
        local_37 = _e608;
        int _e610 = local_37;
        local_38 = _e610;
    }
    step_6 = int {};
    old_6 = int {};
    step_6 = 2;
    int _e618 = value;
    old_6 = _e618;
    int _e620 = step_6;
    int _e621 = value;
    value = as_type<int>(as_type<uint>(_e621) + as_type<uint>(_e620));
    int _e623 = value;
    type_7 _e625 = output;
    local_39 = _e625;
    local_40 = static_cast<uint>(base + 15u);
    type_7 _e631 = local_39;
    local_114 = _e631;
    uint _e633 = local_40;
    uint _e635 = local_114.inner[1];
    local_114.inner[1] = _e635 + _e633;
    uint _e639 = local_114.inner[0];
    local_115 = static_cast<uint>(_e639);
    uint _e643 = local_114.inner[1];
    local_116 = static_cast<uint>(_e643);
    uint _e646 = local_116;
    output_1[_e646] = static_cast<uint>(_e623);
    int _e648 = index;
    type_7 _e650 = output;
    local_41 = _e650;
    local_42 = static_cast<uint>(base + 16u);
    type_7 _e656 = local_41;
    local_117 = _e656;
    uint _e658 = local_42;
    uint _e660 = local_117.inner[1];
    local_117.inner[1] = _e660 + _e658;
    uint _e664 = local_117.inner[0];
    local_118 = static_cast<uint>(_e664);
    uint _e668 = local_117.inner[1];
    local_119 = static_cast<uint>(_e668);
    uint _e671 = local_119;
    output_1[_e671] = static_cast<uint>(_e648);
    int _e675 = add_default(0, 3);
    type_7 _e677 = output;
    local_43 = _e677;
    local_44 = static_cast<uint>(base + 17u);
    type_7 _e683 = local_43;
    local_120 = _e683;
    uint _e685 = local_44;
    uint _e687 = local_120.inner[1];
    local_120.inner[1] = _e687 + _e685;
    uint _e691 = local_120.inner[0];
    local_121 = static_cast<uint>(_e691);
    uint _e695 = local_120.inner[1];
    local_122 = static_cast<uint>(_e695);
    uint _e698 = local_122;
    output_1[_e698] = static_cast<uint>(_e675);
    int _e702 = ranked_default(1, 2);
    type_7 _e704 = output;
    local_45 = _e704;
    local_46 = static_cast<uint>(base + 18u);
    type_7 _e710 = local_45;
    local_123 = _e710;
    uint _e712 = local_46;
    uint _e714 = local_123.inner[1];
    local_123.inner[1] = _e714 + _e712;
    uint _e718 = local_123.inner[0];
    local_124 = static_cast<uint>(_e718);
    uint _e722 = local_123.inner[1];
    local_125 = static_cast<uint>(_e722);
    uint _e725 = local_125;
    output_1[_e725] = static_cast<uint>(_e702);
    int _e728 = ranked_default_unsigned(1u);
    type_7 _e730 = output;
    local_47 = _e730;
    local_48 = static_cast<uint>(base + 19u);
    type_7 _e736 = local_47;
    local_126 = _e736;
    uint _e738 = local_48;
    uint _e740 = local_126.inner[1];
    local_126.inner[1] = _e740 + _e738;
    uint _e744 = local_126.inner[0];
    local_127 = static_cast<uint>(_e744);
    uint _e748 = local_126.inner[1];
    local_128 = static_cast<uint>(_e748);
    uint _e751 = local_128;
    output_1[_e751] = static_cast<uint>(_e728);
}
