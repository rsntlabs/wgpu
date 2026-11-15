// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

struct R_cuda_record_0_ {
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
struct int1_ {
    int x;
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
    int value
) {
    return 1;
}

int kind_1(
    uint value_1
) {
    return 2;
}

uint chain_unsigned_unsigned_const_u0020_unsigned(
) {
    uint value_2 = {};
    value_2 = 7u;
    uint _e2 = value_2;
    return _e2;
}

int selected_int_int(
    int input_2
) {
    int _e1 = kind(input_2);
    return _e1;
}

int selected_unsigned_unsigned(
    uint input_3
) {
    int _e1 = kind_1(input_3);
    return _e1;
}

int cv_value_int_const_u0020_int(
) {
    int value_3 = {};
    int local_123 = {};
    value_3 = 7;
    local_123 = 4;
    int _e3 = local_123;
    return _e3;
}

int cv_value_int_int(
) {
    int value_4 = {};
    int local_124 = {};
    value_4 = 7;
    local_124 = 3;
    int _e3 = local_124;
    return _e3;
}

uint merged_unsigned_unsigned(
    uint input_4
) {
    return input_4;
}

int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int vector3_float3_float3_(
    float3_ input_5
) {
    float3_ input_6 = {};
    float3_ value_5 = {};
    input_6 = input_5;
    float3_ _e3 = input_6;
    value_5 = _e3;
    float _e5 = value_5.z;
    return naga_f2i32(_e5);
}

int vector1_int1_int1_(
    int1_ input_7
) {
    int1_ input_8 = {};
    int1_ value_6 = {};
    input_8 = input_7;
    int1_ _e3 = input_8;
    value_6 = _e3;
    int _e5 = value_6.x;
    return _e5;
}

int record_value_R_R(
) {
    R_cuda_record_0_ value_7 = {};
    value_7.x = 4;
    value_7.y = 5;
    int _e7 = value_7.x;
    int _e8 = value_7.y;
    return as_type<int>(as_type<uint>(_e7) + as_type<uint>(_e8));
}

uint shape_dim3_dim3_(
) {
    dim3_ value_8 = {};
    value_8 = dim3_ {1u, 1u, 1u};
    uint _e7 = value_8.x;
    uint _e8 = value_8.y;
    uint _e11 = value_8.z;
    return (_e7 + _e8) + _e11;
}

void null_value_decltype_u0028_nullptr_u0029_decltype_u0028_nullptr_u0029_(
) {
    return;
}

struct dependent_type_defaultsInput {
};
kernel void dependent_type_defaults(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2& output_1 [[buffer(0)]]
, device type_3 const& input_9 [[buffer(1)]]
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
    float3_ vector = {};
    int1_ one = {};
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
    int local_25 = {};
    type_7 local_26 = {};
    uint local_27 = {};
    type_7 local_28 = {};
    uint local_29 = {};
    int state = {};
    type_7 local_30 = {};
    uint local_31 = {};
    type_7 local_32 = {};
    uint local_33 = {};
    bool local_34 = {};
    int local_35 = {};
    bool local_36 = {};
    int local_37 = {};
    int index = {};
    type_7 local_38 = {};
    uint local_39 = {};
    type_7 local_40 = {};
    uint local_41 = {};
    type_7 local_42 = {};
    uint local_43 = {};
    type_7 local_44 = {};
    uint local_45 = {};
    type_7 input_1 = {};
    type_7 local_46 = {};
    type_7 pointer = {};
    type_7 local_47 = {};
    type_7 local_48 = {};
    int local_49 = {};
    int amount = {};
    int copy = {};
    int old = {};
    uint amount_1 = {};
    uint copy_1 = {};
    int old_1 = {};
    int amount_2 = {};
    int copy_2 = {};
    int old_2 = {};
    int local_50 = {};
    int local_51 = {};
    int amount_3 = {};
    int copy_3 = {};
    int old_3 = {};
    int local_52 = {};
    int local_53 = {};
    int amount_4 = {};
    int copy_4 = {};
    int old_4 = {};
    type_7 local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    type_7 local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    type_7 local_60 = {};
    uint local_61 = {};
    uint local_62 = {};
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
    output = type_7 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    input = type_7 {};
    input.inner[0] = 3u;
    input.inner[1] = 0u;
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 20u);
    uint _e18 = chain_unsigned_unsigned_const_u0020_unsigned();
    type_7 _e20 = output;
    local = _e20;
    type_7 _e22 = local;
    local_54 = _e22;
    uint _e25 = local_54.inner[1];
    local_54.inner[1] = _e25 + base;
    uint _e29 = local_54.inner[0];
    local_55 = static_cast<uint>(_e29);
    uint _e33 = local_54.inner[1];
    local_56 = static_cast<uint>(_e33);
    uint _e36 = local_56;
    output_1[_e36] = _e18;
    uint _e39 = chain_unsigned_unsigned_const_u0020_unsigned();
    type_7 _e40 = output;
    local_1 = _e40;
    local_2 = static_cast<uint>(base + 1u);
    type_7 _e46 = local_1;
    local_57 = _e46;
    uint _e48 = local_2;
    uint _e50 = local_57.inner[1];
    local_57.inner[1] = _e50 + _e48;
    uint _e54 = local_57.inner[0];
    local_58 = static_cast<uint>(_e54);
    uint _e58 = local_57.inner[1];
    local_59 = static_cast<uint>(_e58);
    uint _e61 = local_59;
    output_1[_e61] = _e39;
    uint _e63 = chain_unsigned_unsigned_const_u0020_unsigned();
    type_7 _e64 = output;
    local_3 = _e64;
    local_4 = static_cast<uint>(base + 2u);
    type_7 _e70 = local_3;
    local_60 = _e70;
    uint _e72 = local_4;
    uint _e74 = local_60.inner[1];
    local_60.inner[1] = _e74 + _e72;
    uint _e78 = local_60.inner[0];
    local_61 = static_cast<uint>(_e78);
    uint _e82 = local_60.inner[1];
    local_62 = static_cast<uint>(_e82);
    uint _e85 = local_62;
    output_1[_e85] = _e63;
    int _e88 = selected_int_int(1);
    type_7 _e90 = output;
    local_5 = _e90;
    local_6 = static_cast<uint>(base + 3u);
    type_7 _e96 = local_5;
    local_63 = _e96;
    uint _e98 = local_6;
    uint _e100 = local_63.inner[1];
    local_63.inner[1] = _e100 + _e98;
    uint _e104 = local_63.inner[0];
    local_64 = static_cast<uint>(_e104);
    uint _e108 = local_63.inner[1];
    local_65 = static_cast<uint>(_e108);
    uint _e111 = local_65;
    output_1[_e111] = static_cast<uint>(_e88);
    int _e114 = selected_unsigned_unsigned(1u);
    type_7 _e116 = output;
    local_7 = _e116;
    local_8 = static_cast<uint>(base + 4u);
    type_7 _e122 = local_7;
    local_66 = _e122;
    uint _e124 = local_8;
    uint _e126 = local_66.inner[1];
    local_66.inner[1] = _e126 + _e124;
    uint _e130 = local_66.inner[0];
    local_67 = static_cast<uint>(_e130);
    uint _e134 = local_66.inner[1];
    local_68 = static_cast<uint>(_e134);
    uint _e137 = local_68;
    output_1[_e137] = static_cast<uint>(_e114);
    int _e139 = cv_value_int_const_u0020_int();
    type_7 _e141 = output;
    local_9 = _e141;
    local_10 = static_cast<uint>(base + 5u);
    type_7 _e147 = local_9;
    local_69 = _e147;
    uint _e149 = local_10;
    uint _e151 = local_69.inner[1];
    local_69.inner[1] = _e151 + _e149;
    uint _e155 = local_69.inner[0];
    local_70 = static_cast<uint>(_e155);
    uint _e159 = local_69.inner[1];
    local_71 = static_cast<uint>(_e159);
    uint _e162 = local_71;
    output_1[_e162] = static_cast<uint>(_e139);
    int _e164 = cv_value_int_int();
    type_7 _e166 = output;
    local_11 = _e166;
    local_12 = static_cast<uint>(base + 6u);
    type_7 _e172 = local_11;
    local_72 = _e172;
    uint _e174 = local_12;
    uint _e176 = local_72.inner[1];
    local_72.inner[1] = _e176 + _e174;
    uint _e180 = local_72.inner[0];
    local_73 = static_cast<uint>(_e180);
    uint _e184 = local_72.inner[1];
    local_74 = static_cast<uint>(_e184);
    uint _e187 = local_74;
    output_1[_e187] = static_cast<uint>(_e164);
    uint _e190 = merged_unsigned_unsigned(8u);
    type_7 _e191 = output;
    local_13 = _e191;
    local_14 = static_cast<uint>(base + 7u);
    type_7 _e197 = local_13;
    local_75 = _e197;
    uint _e199 = local_14;
    uint _e201 = local_75.inner[1];
    local_75.inner[1] = _e201 + _e199;
    uint _e205 = local_75.inner[0];
    local_76 = static_cast<uint>(_e205);
    uint _e209 = local_75.inner[1];
    local_77 = static_cast<uint>(_e209);
    uint _e212 = local_77;
    output_1[_e212] = _e190;
    vector.x = static_cast<float>(1);
    vector.y = static_cast<float>(2);
    vector.z = static_cast<float>(3);
    one.x = 7;
    float3_ _e227 = vector;
    int _e228 = vector3_float3_float3_(_e227);
    type_7 _e230 = output;
    local_15 = _e230;
    local_16 = static_cast<uint>(base + 8u);
    type_7 _e236 = local_15;
    local_78 = _e236;
    uint _e238 = local_16;
    uint _e240 = local_78.inner[1];
    local_78.inner[1] = _e240 + _e238;
    uint _e244 = local_78.inner[0];
    local_79 = static_cast<uint>(_e244);
    uint _e248 = local_78.inner[1];
    local_80 = static_cast<uint>(_e248);
    uint _e251 = local_80;
    output_1[_e251] = static_cast<uint>(_e228);
    int1_ _e253 = one;
    int _e254 = vector1_int1_int1_(_e253);
    type_7 _e256 = output;
    local_17 = _e256;
    local_18 = static_cast<uint>(base + 9u);
    type_7 _e262 = local_17;
    local_81 = _e262;
    uint _e264 = local_18;
    uint _e266 = local_81.inner[1];
    local_81.inner[1] = _e266 + _e264;
    uint _e270 = local_81.inner[0];
    local_82 = static_cast<uint>(_e270);
    uint _e274 = local_81.inner[1];
    local_83 = static_cast<uint>(_e274);
    uint _e277 = local_83;
    output_1[_e277] = static_cast<uint>(_e254);
    int _e279 = record_value_R_R();
    type_7 _e281 = output;
    local_19 = _e281;
    local_20 = static_cast<uint>(base + 10u);
    type_7 _e287 = local_19;
    local_84 = _e287;
    uint _e289 = local_20;
    uint _e291 = local_84.inner[1];
    local_84.inner[1] = _e291 + _e289;
    uint _e295 = local_84.inner[0];
    local_85 = static_cast<uint>(_e295);
    uint _e299 = local_84.inner[1];
    local_86 = static_cast<uint>(_e299);
    uint _e302 = local_86;
    output_1[_e302] = static_cast<uint>(_e279);
    uint _e304 = shape_dim3_dim3_();
    type_7 _e305 = output;
    local_21 = _e305;
    local_22 = static_cast<uint>(base + 11u);
    type_7 _e311 = local_21;
    local_87 = _e311;
    uint _e313 = local_22;
    uint _e315 = local_87.inner[1];
    local_87.inner[1] = _e315 + _e313;
    uint _e319 = local_87.inner[0];
    local_88 = static_cast<uint>(_e319);
    uint _e323 = local_87.inner[1];
    local_89 = static_cast<uint>(_e323);
    uint _e326 = local_89;
    output_1[_e326] = _e304;
    null_value_decltype_u0028_nullptr_u0029_decltype_u0028_nullptr_u0029_();
    type_7 _e330 = output;
    local_23 = _e330;
    local_24 = static_cast<uint>(base + 12u);
    type_7 _e336 = local_23;
    local_90 = _e336;
    uint _e338 = local_24;
    uint _e340 = local_90.inner[1];
    local_90.inner[1] = _e340 + _e338;
    uint _e344 = local_90.inner[0];
    local_91 = static_cast<uint>(_e344);
    uint _e348 = local_90.inner[1];
    local_92 = static_cast<uint>(_e348);
    uint _e351 = local_92;
    output_1[_e351] = static_cast<uint>(true);
    local_25 = 0;
    local_49 = int {};
    input_1 = type_7 {};
    input_1.inner[0] = 4u;
    input_1.inner[1] = 0u;
    type_7 _e364 = input_1;
    local_46 = _e364;
    type_7 _e366 = local_46;
    pointer = _e366;
    type_7 _e369 = pointer;
    local_47 = _e369;
    type_7 _e371 = local_47;
    local_93 = _e371;
    uint _e374 = local_93.inner[0];
    local_94 = static_cast<uint>(_e374);
    uint _e378 = local_93.inner[1];
    local_95 = static_cast<uint>(_e378);
    local_25 = 9;
    type_7 _e382 = pointer;
    local_48 = _e382;
    type_7 _e384 = local_48;
    local_96 = _e384;
    uint _e387 = local_96.inner[0];
    local_97 = static_cast<uint>(_e387);
    uint _e391 = local_96.inner[1];
    local_98 = static_cast<uint>(_e391);
    int _e394 = local_25;
    local_49 = _e394;
    int _e396 = local_49;
    type_7 _e398 = output;
    local_26 = _e398;
    local_27 = static_cast<uint>(base + 13u);
    type_7 _e404 = local_26;
    local_99 = _e404;
    uint _e406 = local_27;
    uint _e408 = local_99.inner[1];
    local_99.inner[1] = _e408 + _e406;
    uint _e412 = local_99.inner[0];
    local_100 = static_cast<uint>(_e412);
    uint _e416 = local_99.inner[1];
    local_101 = static_cast<uint>(_e416);
    uint _e419 = local_101;
    output_1[_e419] = static_cast<uint>(_e396);
    int _e421 = local_25;
    type_7 _e423 = output;
    local_28 = _e423;
    local_29 = static_cast<uint>(base + 14u);
    type_7 _e429 = local_28;
    local_102 = _e429;
    uint _e431 = local_29;
    uint _e433 = local_102.inner[1];
    local_102.inner[1] = _e433 + _e431;
    uint _e437 = local_102.inner[0];
    local_103 = static_cast<uint>(_e437);
    uint _e441 = local_102.inner[1];
    local_104 = static_cast<uint>(_e441);
    uint _e444 = local_104;
    output_1[_e444] = static_cast<uint>(_e421);
    state = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    amount = int {};
    copy = int {};
    old = int {};
    amount = 2;
    int _e458 = amount;
    copy = _e458;
    int _e460 = state;
    old = _e460;
    int _e462 = copy;
    int _e463 = state;
    state = as_type<int>(as_type<uint>(_e463) + as_type<uint>(_e462));
    int _e465 = old;
    type_7 _e467 = output;
    local_30 = _e467;
    local_31 = static_cast<uint>(base + 15u);
    type_7 _e473 = local_30;
    local_105 = _e473;
    uint _e475 = local_31;
    uint _e477 = local_105.inner[1];
    local_105.inner[1] = _e477 + _e475;
    uint _e481 = local_105.inner[0];
    local_106 = static_cast<uint>(_e481);
    uint _e485 = local_105.inner[1];
    local_107 = static_cast<uint>(_e485);
    uint _e488 = local_107;
    output_1[_e488] = static_cast<uint>(_e465);
    amount_1 = uint {};
    copy_1 = uint {};
    old_1 = int {};
    amount_1 = 3u;
    uint _e498 = amount_1;
    copy_1 = _e498;
    int _e500 = state;
    old_1 = _e500;
    uint _e502 = copy_1;
    int _e504 = state;
    state = as_type<int>(as_type<uint>(_e504) + as_type<uint>(static_cast<int>(_e502)));
    int _e506 = old_1;
    type_7 _e508 = output;
    local_32 = _e508;
    local_33 = static_cast<uint>(base + 16u);
    type_7 _e514 = local_32;
    local_108 = _e514;
    uint _e516 = local_33;
    uint _e518 = local_108.inner[1];
    local_108.inner[1] = _e518 + _e516;
    uint _e522 = local_108.inner[0];
    local_109 = static_cast<uint>(_e522);
    uint _e526 = local_108.inner[1];
    local_110 = static_cast<uint>(_e526);
    uint _e529 = local_110;
    output_1[_e529] = static_cast<uint>(_e506);
    local_34 = false;
    if (false) {
        amount_2 = int {};
        copy_2 = int {};
        old_2 = int {};
        amount_2 = 99;
        int _e541 = amount_2;
        copy_2 = _e541;
        int _e543 = state;
        local_50 = _e543;
        int _e545 = local_50;
        old_2 = _e545;
        int _e547 = copy_2;
        int _e548 = state;
        local_51 = _e548;
        int _e550 = local_51;
        state = as_type<int>(as_type<uint>(_e550) + as_type<uint>(_e547));
        int _e552 = old_2;
        local_35 = _e552;
        int _e554 = local_35;
        local_34 = _e554 != 0;
    }
    local_36 = true;
    if (true) {
    } else {
        amount_3 = int {};
        copy_3 = int {};
        old_3 = int {};
        amount_3 = 99;
        int _e567 = amount_3;
        copy_3 = _e567;
        int _e569 = state;
        local_52 = _e569;
        int _e571 = local_52;
        old_3 = _e571;
        int _e573 = copy_3;
        int _e574 = state;
        local_53 = _e574;
        int _e576 = local_53;
        state = as_type<int>(as_type<uint>(_e576) + as_type<uint>(_e573));
        int _e578 = old_3;
        local_37 = _e578;
        int _e580 = local_37;
        local_36 = _e580 != 0;
    }
    index = 0;
    type_7 _e586 = input;
    local_38 = _e586;
    int _e588 = index;
    index = as_type<int>(as_type<uint>(_e588) + as_type<uint>(1));
    local_39 = static_cast<uint>(_e588);
    type_7 _e593 = local_38;
    local_111 = _e593;
    uint _e595 = local_39;
    uint _e597 = local_111.inner[1];
    local_111.inner[1] = _e597 + _e595;
    uint _e601 = local_111.inner[0];
    local_112 = static_cast<uint>(_e601);
    uint _e605 = local_111.inner[1];
    local_113 = static_cast<uint>(_e605);
    uint _e608 = local_113;
    int _e611 = input_9[_e608];
    amount_4 = int {};
    copy_4 = int {};
    old_4 = int {};
    amount_4 = _e611;
    int _e619 = amount_4;
    copy_4 = _e619;
    int _e621 = state;
    old_4 = _e621;
    int _e623 = copy_4;
    int _e624 = state;
    state = as_type<int>(as_type<uint>(_e624) + as_type<uint>(_e623));
    int _e626 = state;
    type_7 _e628 = output;
    local_40 = _e628;
    local_41 = static_cast<uint>(base + 17u);
    type_7 _e634 = local_40;
    local_114 = _e634;
    uint _e636 = local_41;
    uint _e638 = local_114.inner[1];
    local_114.inner[1] = _e638 + _e636;
    uint _e642 = local_114.inner[0];
    local_115 = static_cast<uint>(_e642);
    uint _e646 = local_114.inner[1];
    local_116 = static_cast<uint>(_e646);
    uint _e649 = local_116;
    output_1[_e649] = static_cast<uint>(_e626);
    int _e651 = index;
    type_7 _e653 = output;
    local_42 = _e653;
    local_43 = static_cast<uint>(base + 18u);
    type_7 _e659 = local_42;
    local_117 = _e659;
    uint _e661 = local_43;
    uint _e663 = local_117.inner[1];
    local_117.inner[1] = _e663 + _e661;
    uint _e667 = local_117.inner[0];
    local_118 = static_cast<uint>(_e667);
    uint _e671 = local_117.inner[1];
    local_119 = static_cast<uint>(_e671);
    uint _e674 = local_119;
    output_1[_e674] = static_cast<uint>(_e651);
    uint _e677 = merged_unsigned_unsigned(1u);
    int _e678 = kind_1(_e677);
    type_7 _e680 = output;
    local_44 = _e680;
    local_45 = static_cast<uint>(base + 19u);
    type_7 _e686 = local_44;
    local_120 = _e686;
    uint _e688 = local_45;
    uint _e690 = local_120.inner[1];
    local_120.inner[1] = _e690 + _e688;
    uint _e694 = local_120.inner[0];
    local_121 = static_cast<uint>(_e694);
    uint _e698 = local_120.inner[1];
    local_122 = static_cast<uint>(_e698);
    uint _e701 = local_122;
    output_1[_e701] = static_cast<uint>(_e678);
}
