// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

struct Record_cuda_record_0_ {
    int x;
    int y;
};
typedef uint type_2[1];
typedef int type_3[1];
struct float3_ {
    float x;
    float y;
    float z;
};
struct dim3_ {
    uint x;
    uint y;
    uint z;
};
struct type_7 {
    uint inner[2];
};

int kind(
    int value_2
) {
    return 1;
}

int kind_1(
    uint value_3
) {
    return 2;
}

int selected(
    int value_4
) {
    return as_type<int>(as_type<uint>(10) + as_type<uint>(value_4));
}

uint default_value_unsigned(
) {
    return static_cast<uint>(7);
}

uint self_named_unsigned(
) {
    return static_cast<uint>(9);
}

int deduced_kind_int(
    int value_5
) {
    int _e1 = kind(value_5);
    return _e1;
}

int deduced_kind_unsigned(
    uint value_6
) {
    int _e1 = kind_1(value_6);
    return _e1;
}

uint converted_unsigned_int(
    int value_7
) {
    return static_cast<uint>(value_7);
}

int converted_int_unsigned(
    uint value_8
) {
    return static_cast<int>(value_8);
}

int selected_unsigned(
    uint value_9
) {
    return as_type<int>(as_type<uint>(20) + as_type<uint>(static_cast<int>(value_9)));
}

int selected_int(
    int value_10
) {
    return as_type<int>(as_type<uint>(20) + as_type<uint>(value_10));
}

int frozen_cv_const_u0020_int(
) {
    int value_11 = {};
    int local_141 = {};
    value_11 = 7;
    local_141 = 4;
    int _e3 = local_141;
    return _e3;
}

int frozen_cv_int(
) {
    int value_12 = {};
    int local_142 = {};
    value_12 = 7;
    local_142 = 3;
    int _e3 = local_142;
    return _e3;
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int vector_value_float3_(
) {
    float3_ value_13 = {};
    value_13.x = 1.0;
    value_13.y = 2.0;
    value_13.z = 3.0;
    float _e8 = value_13.z;
    return naga_f2i32(_e8);
}

int record_value_Record(
) {
    Record_cuda_record_0_ value_14 = {};
    value_14.x = 4;
    value_14.y = 5;
    int _e7 = value_14.x;
    int _e8 = value_14.y;
    return as_type<int>(as_type<uint>(_e7) + as_type<uint>(_e8));
}

uint shape_value_dim3_(
) {
    dim3_ value_15 = {};
    value_15 = dim3_ {1u, 1u, 1u};
    uint _e8 = value_15.y;
    uint _e10 = value_15.x;
    uint _e14 = value_15.z;
    return (_e10 + (10u * _e8)) + (100u * _e14);
}

void null_value_decltype_u0028_nullptr_u0029_(
) {
    return;
}

struct default_template_argumentsInput {
};
kernel void default_template_arguments(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2& output_1 [[buffer(0)]]
, device type_3 const& input_2 [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    type_7 output = {};
    type_7 input = {};
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
    uint local_26 = {};
    type_7 local_27 = {};
    uint local_28 = {};
    type_7 local_29 = {};
    uint local_30 = {};
    type_7 local_31 = {};
    uint local_32 = {};
    type_7 local_33 = {};
    uint local_34 = {};
    type_7 local_35 = {};
    uint local_36 = {};
    int value = {};
    type_7 local_37 = {};
    uint local_38 = {};
    type_7 local_39 = {};
    uint local_40 = {};
    bool local_41 = {};
    int local_42 = {};
    bool local_43 = {};
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
    type_7 input_1 = {};
    type_7 local_55 = {};
    type_7 value_1 = {};
    type_7 local_56 = {};
    uint local_57 = {};
    int local_58 = {};
    int amount = {};
    int old = {};
    int amount_1 = {};
    int old_1 = {};
    int amount_2 = {};
    int old_2 = {};
    int local_59 = {};
    int local_60 = {};
    int amount_3 = {};
    int old_3 = {};
    int local_61 = {};
    int local_62 = {};
    int amount_4 = {};
    int old_4 = {};
    int amount_5 = {};
    int old_5 = {};
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
    type_7 local_129 = {};
    uint local_130 = {};
    uint local_131 = {};
    type_7 local_132 = {};
    uint local_133 = {};
    uint local_134 = {};
    type_7 local_135 = {};
    uint local_136 = {};
    uint local_137 = {};
    type_7 local_138 = {};
    uint local_139 = {};
    uint local_140 = {};
    output = type_7 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    input = type_7 {};
    input.inner[0] = 3u;
    input.inner[1] = 0u;
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 24u);
    uint _e18 = default_value_unsigned();
    type_7 _e20 = output;
    local = _e20;
    type_7 _e22 = local;
    local_63 = _e22;
    uint _e25 = local_63.inner[1];
    local_63.inner[1] = _e25 + base;
    uint _e29 = local_63.inner[0];
    local_64 = static_cast<uint>(_e29);
    uint _e33 = local_63.inner[1];
    local_65 = static_cast<uint>(_e33);
    uint _e36 = local_65;
    output_1[_e36] = _e18;
    uint _e39 = default_value_unsigned();
    type_7 _e40 = output;
    local_1 = _e40;
    local_2 = static_cast<uint>(base + 1u);
    type_7 _e46 = local_1;
    local_66 = _e46;
    uint _e48 = local_2;
    uint _e50 = local_66.inner[1];
    local_66.inner[1] = _e50 + _e48;
    uint _e54 = local_66.inner[0];
    local_67 = static_cast<uint>(_e54);
    uint _e58 = local_66.inner[1];
    local_68 = static_cast<uint>(_e58);
    uint _e61 = local_68;
    output_1[_e61] = _e39;
    uint _e63 = default_value_unsigned();
    type_7 _e64 = output;
    local_3 = _e64;
    local_4 = static_cast<uint>(base + 2u);
    type_7 _e70 = local_3;
    local_69 = _e70;
    uint _e72 = local_4;
    uint _e74 = local_69.inner[1];
    local_69.inner[1] = _e74 + _e72;
    uint _e78 = local_69.inner[0];
    local_70 = static_cast<uint>(_e78);
    uint _e82 = local_69.inner[1];
    local_71 = static_cast<uint>(_e82);
    uint _e85 = local_71;
    output_1[_e85] = _e63;
    uint _e87 = self_named_unsigned();
    type_7 _e88 = output;
    local_5 = _e88;
    local_6 = static_cast<uint>(base + 3u);
    type_7 _e94 = local_5;
    local_72 = _e94;
    uint _e96 = local_6;
    uint _e98 = local_72.inner[1];
    local_72.inner[1] = _e98 + _e96;
    uint _e102 = local_72.inner[0];
    local_73 = static_cast<uint>(_e102);
    uint _e106 = local_72.inner[1];
    local_74 = static_cast<uint>(_e106);
    uint _e109 = local_74;
    output_1[_e109] = _e87;
    int _e112 = deduced_kind_int(1);
    type_7 _e114 = output;
    local_7 = _e114;
    local_8 = static_cast<uint>(base + 4u);
    type_7 _e120 = local_7;
    local_75 = _e120;
    uint _e122 = local_8;
    uint _e124 = local_75.inner[1];
    local_75.inner[1] = _e124 + _e122;
    uint _e128 = local_75.inner[0];
    local_76 = static_cast<uint>(_e128);
    uint _e132 = local_75.inner[1];
    local_77 = static_cast<uint>(_e132);
    uint _e135 = local_77;
    output_1[_e135] = static_cast<uint>(_e112);
    int _e138 = deduced_kind_unsigned(1u);
    type_7 _e140 = output;
    local_9 = _e140;
    local_10 = static_cast<uint>(base + 5u);
    type_7 _e146 = local_9;
    local_78 = _e146;
    uint _e148 = local_10;
    uint _e150 = local_78.inner[1];
    local_78.inner[1] = _e150 + _e148;
    uint _e154 = local_78.inner[0];
    local_79 = static_cast<uint>(_e154);
    uint _e158 = local_78.inner[1];
    local_80 = static_cast<uint>(_e158);
    uint _e161 = local_80;
    output_1[_e161] = static_cast<uint>(_e138);
    uint _e164 = converted_unsigned_int(3);
    int _e165 = kind_1(_e164);
    type_7 _e167 = output;
    local_11 = _e167;
    local_12 = static_cast<uint>(base + 6u);
    type_7 _e173 = local_11;
    local_81 = _e173;
    uint _e175 = local_12;
    uint _e177 = local_81.inner[1];
    local_81.inner[1] = _e177 + _e175;
    uint _e181 = local_81.inner[0];
    local_82 = static_cast<uint>(_e181);
    uint _e185 = local_81.inner[1];
    local_83 = static_cast<uint>(_e185);
    uint _e188 = local_83;
    output_1[_e188] = static_cast<uint>(_e165);
    int _e191 = converted_int_unsigned(3u);
    int _e192 = kind(_e191);
    type_7 _e194 = output;
    local_13 = _e194;
    local_14 = static_cast<uint>(base + 7u);
    type_7 _e200 = local_13;
    local_84 = _e200;
    uint _e202 = local_14;
    uint _e204 = local_84.inner[1];
    local_84.inner[1] = _e204 + _e202;
    uint _e208 = local_84.inner[0];
    local_85 = static_cast<uint>(_e208);
    uint _e212 = local_84.inner[1];
    local_86 = static_cast<uint>(_e212);
    uint _e215 = local_86;
    output_1[_e215] = static_cast<uint>(_e192);
    int _e218 = selected(1);
    type_7 _e220 = output;
    local_15 = _e220;
    local_16 = static_cast<uint>(base + 8u);
    type_7 _e226 = local_15;
    local_87 = _e226;
    uint _e228 = local_16;
    uint _e230 = local_87.inner[1];
    local_87.inner[1] = _e230 + _e228;
    uint _e234 = local_87.inner[0];
    local_88 = static_cast<uint>(_e234);
    uint _e238 = local_87.inner[1];
    local_89 = static_cast<uint>(_e238);
    uint _e241 = local_89;
    output_1[_e241] = static_cast<uint>(_e218);
    int _e244 = selected_unsigned(1u);
    type_7 _e246 = output;
    local_17 = _e246;
    local_18 = static_cast<uint>(base + 9u);
    type_7 _e252 = local_17;
    local_90 = _e252;
    uint _e254 = local_18;
    uint _e256 = local_90.inner[1];
    local_90.inner[1] = _e256 + _e254;
    uint _e260 = local_90.inner[0];
    local_91 = static_cast<uint>(_e260);
    uint _e264 = local_90.inner[1];
    local_92 = static_cast<uint>(_e264);
    uint _e267 = local_92;
    output_1[_e267] = static_cast<uint>(_e244);
    int _e270 = selected_int(1);
    type_7 _e272 = output;
    local_19 = _e272;
    local_20 = static_cast<uint>(base + 10u);
    type_7 _e278 = local_19;
    local_93 = _e278;
    uint _e280 = local_20;
    uint _e282 = local_93.inner[1];
    local_93.inner[1] = _e282 + _e280;
    uint _e286 = local_93.inner[0];
    local_94 = static_cast<uint>(_e286);
    uint _e290 = local_93.inner[1];
    local_95 = static_cast<uint>(_e290);
    uint _e293 = local_95;
    output_1[_e293] = static_cast<uint>(_e270);
    int _e295 = frozen_cv_const_u0020_int();
    type_7 _e297 = output;
    local_21 = _e297;
    local_22 = static_cast<uint>(base + 11u);
    type_7 _e303 = local_21;
    local_96 = _e303;
    uint _e305 = local_22;
    uint _e307 = local_96.inner[1];
    local_96.inner[1] = _e307 + _e305;
    uint _e311 = local_96.inner[0];
    local_97 = static_cast<uint>(_e311);
    uint _e315 = local_96.inner[1];
    local_98 = static_cast<uint>(_e315);
    uint _e318 = local_98;
    output_1[_e318] = static_cast<uint>(_e295);
    int _e320 = frozen_cv_int();
    type_7 _e322 = output;
    local_23 = _e322;
    local_24 = static_cast<uint>(base + 12u);
    type_7 _e328 = local_23;
    local_99 = _e328;
    uint _e330 = local_24;
    uint _e332 = local_99.inner[1];
    local_99.inner[1] = _e332 + _e330;
    uint _e336 = local_99.inner[0];
    local_100 = static_cast<uint>(_e336);
    uint _e340 = local_99.inner[1];
    local_101 = static_cast<uint>(_e340);
    uint _e343 = local_101;
    output_1[_e343] = static_cast<uint>(_e320);
    int _e345 = vector_value_float3_();
    type_7 _e347 = output;
    local_25 = _e347;
    local_26 = static_cast<uint>(base + 13u);
    type_7 _e353 = local_25;
    local_102 = _e353;
    uint _e355 = local_26;
    uint _e357 = local_102.inner[1];
    local_102.inner[1] = _e357 + _e355;
    uint _e361 = local_102.inner[0];
    local_103 = static_cast<uint>(_e361);
    uint _e365 = local_102.inner[1];
    local_104 = static_cast<uint>(_e365);
    uint _e368 = local_104;
    output_1[_e368] = static_cast<uint>(_e345);
    int _e370 = record_value_Record();
    type_7 _e372 = output;
    local_27 = _e372;
    local_28 = static_cast<uint>(base + 14u);
    type_7 _e378 = local_27;
    local_105 = _e378;
    uint _e380 = local_28;
    uint _e382 = local_105.inner[1];
    local_105.inner[1] = _e382 + _e380;
    uint _e386 = local_105.inner[0];
    local_106 = static_cast<uint>(_e386);
    uint _e390 = local_105.inner[1];
    local_107 = static_cast<uint>(_e390);
    uint _e393 = local_107;
    output_1[_e393] = static_cast<uint>(_e370);
    uint _e395 = shape_value_dim3_();
    type_7 _e396 = output;
    local_29 = _e396;
    local_30 = static_cast<uint>(base + 15u);
    type_7 _e402 = local_29;
    local_108 = _e402;
    uint _e404 = local_30;
    uint _e406 = local_108.inner[1];
    local_108.inner[1] = _e406 + _e404;
    uint _e410 = local_108.inner[0];
    local_109 = static_cast<uint>(_e410);
    uint _e414 = local_108.inner[1];
    local_110 = static_cast<uint>(_e414);
    uint _e417 = local_110;
    output_1[_e417] = _e395;
    null_value_decltype_u0028_nullptr_u0029_();
    type_7 _e421 = output;
    local_31 = _e421;
    local_32 = static_cast<uint>(base + 16u);
    type_7 _e427 = local_31;
    local_111 = _e427;
    uint _e429 = local_32;
    uint _e431 = local_111.inner[1];
    local_111.inner[1] = _e431 + _e429;
    uint _e435 = local_111.inner[0];
    local_112 = static_cast<uint>(_e435);
    uint _e439 = local_111.inner[1];
    local_113 = static_cast<uint>(_e439);
    uint _e442 = local_113;
    output_1[_e442] = static_cast<uint>(true);
    type_7 _e445 = input;
    local_35 = _e445;
    local_36 = static_cast<uint>(1);
    local_57 = uint {};
    local_58 = int {};
    type_7 _e454 = local_35;
    input_1 = _e454;
    uint _e456 = local_36;
    uint _e458 = input_1.inner[1];
    input_1.inner[1] = _e458 + _e456;
    type_7 _e462 = input_1;
    local_55 = _e462;
    type_7 _e464 = local_55;
    value_1 = _e464;
    type_7 _e467 = value_1;
    local_56 = _e467;
    local_57 = static_cast<uint>(0);
    type_7 _e472 = local_56;
    local_114 = _e472;
    uint _e474 = local_57;
    uint _e476 = local_114.inner[1];
    local_114.inner[1] = _e476 + _e474;
    uint _e480 = local_114.inner[0];
    local_115 = static_cast<uint>(_e480);
    uint _e484 = local_114.inner[1];
    local_116 = static_cast<uint>(_e484);
    uint _e487 = local_116;
    int _e490 = input_2[_e487];
    local_58 = _e490;
    int _e492 = local_58;
    type_7 _e494 = output;
    local_33 = _e494;
    local_34 = static_cast<uint>(base + 17u);
    type_7 _e500 = local_33;
    local_117 = _e500;
    uint _e502 = local_34;
    uint _e504 = local_117.inner[1];
    local_117.inner[1] = _e504 + _e502;
    uint _e508 = local_117.inner[0];
    local_118 = static_cast<uint>(_e508);
    uint _e512 = local_117.inner[1];
    local_119 = static_cast<uint>(_e512);
    uint _e515 = local_119;
    output_1[_e515] = static_cast<uint>(_e492);
    value = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    amount = int {};
    old = int {};
    amount = 2;
    int _e527 = value;
    old = _e527;
    int _e529 = amount;
    int _e530 = value;
    value = as_type<int>(as_type<uint>(_e530) + as_type<uint>(_e529));
    int _e532 = old;
    type_7 _e534 = output;
    local_37 = _e534;
    local_38 = static_cast<uint>(base + 18u);
    type_7 _e540 = local_37;
    local_120 = _e540;
    uint _e542 = local_38;
    uint _e544 = local_120.inner[1];
    local_120.inner[1] = _e544 + _e542;
    uint _e548 = local_120.inner[0];
    local_121 = static_cast<uint>(_e548);
    uint _e552 = local_120.inner[1];
    local_122 = static_cast<uint>(_e552);
    uint _e555 = local_122;
    output_1[_e555] = static_cast<uint>(_e532);
    amount_1 = int {};
    old_1 = int {};
    amount_1 = 3;
    int _e563 = value;
    old_1 = _e563;
    int _e565 = amount_1;
    int _e566 = value;
    value = as_type<int>(as_type<uint>(_e566) + as_type<uint>(_e565));
    int _e568 = old_1;
    type_7 _e570 = output;
    local_39 = _e570;
    local_40 = static_cast<uint>(base + 19u);
    type_7 _e576 = local_39;
    local_123 = _e576;
    uint _e578 = local_40;
    uint _e580 = local_123.inner[1];
    local_123.inner[1] = _e580 + _e578;
    uint _e584 = local_123.inner[0];
    local_124 = static_cast<uint>(_e584);
    uint _e588 = local_123.inner[1];
    local_125 = static_cast<uint>(_e588);
    uint _e591 = local_125;
    output_1[_e591] = static_cast<uint>(_e568);
    local_41 = false;
    if (false) {
        amount_2 = int {};
        old_2 = int {};
        amount_2 = 2;
        int _e601 = value;
        local_59 = _e601;
        int _e603 = local_59;
        old_2 = _e603;
        int _e605 = amount_2;
        int _e606 = value;
        local_60 = _e606;
        int _e608 = local_60;
        value = as_type<int>(as_type<uint>(_e608) + as_type<uint>(_e605));
        int _e610 = old_2;
        local_42 = _e610;
        int _e612 = local_42;
        local_41 = _e612 != 0;
    }
    local_43 = true;
    if (true) {
    } else {
        amount_3 = int {};
        old_3 = int {};
        amount_3 = 2;
        int _e623 = value;
        local_61 = _e623;
        int _e625 = local_61;
        old_3 = _e625;
        int _e627 = amount_3;
        int _e628 = value;
        local_62 = _e628;
        int _e630 = local_62;
        value = as_type<int>(as_type<uint>(_e630) + as_type<uint>(_e627));
        int _e632 = old_3;
        local_44 = _e632;
        int _e634 = local_44;
        local_43 = _e634 != 0;
    }
    amount_4 = int {};
    old_4 = int {};
    amount_4 = 2;
    int _e643 = value;
    old_4 = _e643;
    int _e645 = amount_4;
    int _e646 = value;
    value = as_type<int>(as_type<uint>(_e646) + as_type<uint>(_e645));
    int _e648 = value;
    type_7 _e650 = output;
    local_45 = _e650;
    local_46 = static_cast<uint>(base + 20u);
    type_7 _e656 = local_45;
    local_126 = _e656;
    uint _e658 = local_46;
    uint _e660 = local_126.inner[1];
    local_126.inner[1] = _e660 + _e658;
    uint _e664 = local_126.inner[0];
    local_127 = static_cast<uint>(_e664);
    uint _e668 = local_126.inner[1];
    local_128 = static_cast<uint>(_e668);
    uint _e671 = local_128;
    output_1[_e671] = static_cast<uint>(_e648);
    uint _e673 = default_value_unsigned();
    int _e674 = kind_1(_e673);
    type_7 _e676 = output;
    local_47 = _e676;
    local_48 = static_cast<uint>(base + 21u);
    type_7 _e682 = local_47;
    local_129 = _e682;
    uint _e684 = local_48;
    uint _e686 = local_129.inner[1];
    local_129.inner[1] = _e686 + _e684;
    uint _e690 = local_129.inner[0];
    local_130 = static_cast<uint>(_e690);
    uint _e694 = local_129.inner[1];
    local_131 = static_cast<uint>(_e694);
    uint _e697 = local_131;
    output_1[_e697] = static_cast<uint>(_e674);
    type_7 _e699 = input;
    local_51 = _e699;
    local_52 = static_cast<uint>(0);
    type_7 _e704 = local_51;
    local_132 = _e704;
    uint _e706 = local_52;
    uint _e708 = local_132.inner[1];
    local_132.inner[1] = _e708 + _e706;
    uint _e712 = local_132.inner[0];
    local_133 = static_cast<uint>(_e712);
    uint _e716 = local_132.inner[1];
    local_134 = static_cast<uint>(_e716);
    uint _e719 = local_134;
    int _e721 = input_2[_e719];
    amount_5 = int {};
    old_5 = int {};
    amount_5 = _e721;
    int _e727 = value;
    old_5 = _e727;
    int _e729 = amount_5;
    int _e730 = value;
    value = as_type<int>(as_type<uint>(_e730) + as_type<uint>(_e729));
    int _e732 = old_5;
    type_7 _e734 = output;
    local_49 = _e734;
    local_50 = static_cast<uint>(base + 22u);
    type_7 _e740 = local_49;
    local_135 = _e740;
    uint _e742 = local_50;
    uint _e744 = local_135.inner[1];
    local_135.inner[1] = _e744 + _e742;
    uint _e748 = local_135.inner[0];
    local_136 = static_cast<uint>(_e748);
    uint _e752 = local_135.inner[1];
    local_137 = static_cast<uint>(_e752);
    uint _e755 = local_137;
    output_1[_e755] = static_cast<uint>(_e732);
    int _e757 = value;
    type_7 _e759 = output;
    local_53 = _e759;
    local_54 = static_cast<uint>(base + 23u);
    type_7 _e765 = local_53;
    local_138 = _e765;
    uint _e767 = local_54;
    uint _e769 = local_138.inner[1];
    local_138.inner[1] = _e769 + _e767;
    uint _e773 = local_138.inner[0];
    local_139 = static_cast<uint>(_e773);
    uint _e777 = local_138.inner[1];
    local_140 = static_cast<uint>(_e777);
    uint _e780 = local_140;
    output_1[_e780] = static_cast<uint>(_e757);
}
