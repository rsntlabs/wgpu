// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_1 {
    int inner[2];
};
struct Sample_cuda_record_0_ {
    int value;
    type_1 payload;
};
typedef uint type_4[1];
struct type_7 {
    uint inner[2];
};

Sample_cuda_record_0_ operator_u0026_u0026_(
    Sample_cuda_record_0_ left_1,
    Sample_cuda_record_0_ right_1
) {
    Sample_cuda_record_0_ left_2 = {};
    Sample_cuda_record_0_ right_2 = {};
    left_2 = left_1;
    right_2 = right_1;
    int _e7 = left_2.value;
    int _e10 = right_2.value;
    left_2.value = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e7) * as_type<uint>(10))) + as_type<uint>(_e10));
    int _e18 = right_2.payload.inner[0];
    int _e19 = left_2.payload.inner[1];
    left_2.payload.inner[1] = as_type<int>(as_type<uint>(_e19) + as_type<uint>(_e18));
    Sample_cuda_record_0_ _e21 = left_2;
    return _e21;
}

Sample_cuda_record_0_ operator_u007c_u007c(
    Sample_cuda_record_0_ left_3,
    Sample_cuda_record_0_ right_3
) {
    Sample_cuda_record_0_ left_4 = {};
    Sample_cuda_record_0_ right_4 = {};
    left_4 = left_3;
    right_4 = right_3;
    int _e7 = left_4.value;
    int _e10 = right_4.value;
    left_4.value = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e7) * as_type<uint>(100))) + as_type<uint>(_e10));
    int _e18 = right_4.payload.inner[1];
    int _e19 = left_4.payload.inner[0];
    left_4.payload.inner[0] = as_type<int>(as_type<uint>(_e19) + as_type<uint>(_e18));
    Sample_cuda_record_0_ _e21 = left_4;
    return _e21;
}

int operator_u0026_u0026_1(
    Sample_cuda_record_0_ left_5,
    int right_5
) {
    Sample_cuda_record_0_ left_6 = {};
    left_6 = left_5;
    int _e4 = left_6.value;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e4) * as_type<uint>(10))) + as_type<uint>(right_5));
}

int operator_u007c_u007c_1(
    int left_7,
    Sample_cuda_record_0_ right_6
) {
    Sample_cuda_record_0_ right_7 = {};
    right_7 = right_6;
    int _e6 = right_7.value;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(left_7) * as_type<uint>(100))) + as_type<uint>(_e6));
}

metal::int2 operator_u0026_u0026_2(
    metal::int2 left_8,
    metal::int2 right_8
) {
    metal::int2 left_9 = {};
    metal::int2 right_9 = {};
    left_9 = left_8;
    right_9 = right_8;
    int _e6 = left_9.x;
    int _e9 = right_9.x;
    int _e13 = left_9.y;
    int _e16 = right_9.y;
    return metal::int2(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e6) * as_type<uint>(10))) + as_type<uint>(_e9)), as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e13) * as_type<uint>(10))) + as_type<uint>(_e16)));
}

metal::int2 operator_u007c_u007c_2(
    metal::int2 left_10,
    metal::int2 right_10
) {
    metal::int2 left_11 = {};
    metal::int2 right_11 = {};
    left_11 = left_10;
    right_11 = right_10;
    int _e6 = left_11.x;
    int _e9 = right_11.x;
    int _e13 = left_11.y;
    int _e16 = right_11.y;
    return metal::int2(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e6) * as_type<uint>(100))) + as_type<uint>(_e9)), as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e13) * as_type<uint>(100))) + as_type<uint>(_e16)));
}

struct logical_operatorsInput {
};
kernel void logical_operators(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_4& out_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_7 out = {};
    Sample_cuda_record_0_ left = {};
    Sample_cuda_record_0_ right = {};
    Sample_cuda_record_0_ both = {};
    Sample_cuda_record_0_ either = {};
    type_7 local = {};
    uint local_1 = {};
    type_7 local_2 = {};
    uint local_3 = {};
    type_7 local_4 = {};
    uint local_5 = {};
    type_7 local_6 = {};
    uint local_7 = {};
    type_7 local_8 = {};
    uint local_9 = {};
    type_7 local_10 = {};
    uint local_11 = {};
    type_7 local_12 = {};
    uint local_13 = {};
    type_7 local_14 = {};
    uint local_15 = {};
    type_7 local_16 = {};
    uint local_17 = {};
    type_7 local_18 = {};
    uint local_19 = {};
    metal::int2 first = {};
    metal::int2 second = {};
    type_7 local_20 = {};
    uint local_21 = {};
    type_7 local_22 = {};
    uint local_23 = {};
    type_7 local_24 = {};
    uint local_25 = {};
    type_7 local_26 = {};
    uint local_27 = {};
    type_7 local_28 = {};
    uint local_29 = {};
    type_7 local_30 = {};
    uint local_31 = {};
    Sample_cuda_record_0_ local_32 = {};
    type_7 local_33 = {};
    uint local_34 = {};
    Sample_cuda_record_0_ local_35 = {};
    int counter = {};
    Sample_cuda_record_0_ evaluated = {};
    Sample_cuda_record_0_ local_36 = {};
    Sample_cuda_record_0_ local_37 = {};
    Sample_cuda_record_0_ local_38 = {};
    type_7 local_39 = {};
    uint local_40 = {};
    type_7 local_41 = {};
    uint local_42 = {};
    type_7 local_43 = {};
    uint local_44 = {};
    bool local_45 = {};
    type_7 local_46 = {};
    uint local_47 = {};
    bool local_48 = {};
    type_7 local_49 = {};
    uint local_50 = {};
    bool local_51 = {};
    type_7 local_52 = {};
    uint local_53 = {};
    bool local_54 = {};
    type_7 local_55 = {};
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
    type_7 local_123 = {};
    uint local_124 = {};
    uint local_125 = {};
    type_7 local_126 = {};
    uint local_127 = {};
    uint local_128 = {};
    out = type_7 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    uint base = threadIdx.x * 24u;
    left.value = 2;
    left.payload.inner[0] = 3;
    left.payload.inner[1] = 4;
    right.value = 5;
    right.payload.inner[0] = 6;
    right.payload.inner[1] = 7;
    Sample_cuda_record_0_ _e26 = left;
    Sample_cuda_record_0_ _e27 = right;
    Sample_cuda_record_0_ _e28 = operator_u0026_u0026_(_e26, _e27);
    both = _e28;
    Sample_cuda_record_0_ _e30 = left;
    Sample_cuda_record_0_ _e31 = right;
    Sample_cuda_record_0_ _e32 = operator_u007c_u007c(_e30, _e31);
    either = _e32;
    int _e35 = both.value;
    type_7 _e37 = out;
    local = _e37;
    local_1 = static_cast<uint>(base + 0u);
    type_7 _e44 = local;
    local_57 = _e44;
    uint _e46 = local_1;
    uint _e48 = local_57.inner[1];
    local_57.inner[1] = _e48 + _e46;
    uint _e52 = local_57.inner[0];
    local_58 = static_cast<uint>(_e52);
    uint _e56 = local_57.inner[1];
    local_59 = static_cast<uint>(_e56);
    uint _e59 = local_59;
    out_1[_e59] = static_cast<uint>(_e35);
    int _e65 = both.payload.inner[1];
    type_7 _e66 = out;
    local_2 = _e66;
    local_3 = static_cast<uint>(base + 1u);
    type_7 _e73 = local_2;
    local_60 = _e73;
    uint _e75 = local_3;
    uint _e77 = local_60.inner[1];
    local_60.inner[1] = _e77 + _e75;
    uint _e81 = local_60.inner[0];
    local_61 = static_cast<uint>(_e81);
    uint _e85 = local_60.inner[1];
    local_62 = static_cast<uint>(_e85);
    uint _e88 = local_62;
    out_1[_e88] = static_cast<uint>(_e65);
    int _e91 = either.value;
    type_7 _e92 = out;
    local_4 = _e92;
    local_5 = static_cast<uint>(base + 2u);
    type_7 _e99 = local_4;
    local_63 = _e99;
    uint _e101 = local_5;
    uint _e103 = local_63.inner[1];
    local_63.inner[1] = _e103 + _e101;
    uint _e107 = local_63.inner[0];
    local_64 = static_cast<uint>(_e107);
    uint _e111 = local_63.inner[1];
    local_65 = static_cast<uint>(_e111);
    uint _e114 = local_65;
    out_1[_e114] = static_cast<uint>(_e91);
    int _e119 = either.payload.inner[0];
    type_7 _e120 = out;
    local_6 = _e120;
    local_7 = static_cast<uint>(base + 3u);
    type_7 _e127 = local_6;
    local_66 = _e127;
    uint _e129 = local_7;
    uint _e131 = local_66.inner[1];
    local_66.inner[1] = _e131 + _e129;
    uint _e135 = local_66.inner[0];
    local_67 = static_cast<uint>(_e135);
    uint _e139 = local_66.inner[1];
    local_68 = static_cast<uint>(_e139);
    uint _e142 = local_68;
    out_1[_e142] = static_cast<uint>(_e119);
    int _e145 = left.value;
    type_7 _e146 = out;
    local_8 = _e146;
    local_9 = static_cast<uint>(base + 4u);
    type_7 _e153 = local_8;
    local_69 = _e153;
    uint _e155 = local_9;
    uint _e157 = local_69.inner[1];
    local_69.inner[1] = _e157 + _e155;
    uint _e161 = local_69.inner[0];
    local_70 = static_cast<uint>(_e161);
    uint _e165 = local_69.inner[1];
    local_71 = static_cast<uint>(_e165);
    uint _e168 = local_71;
    out_1[_e168] = static_cast<uint>(_e145);
    int _e173 = left.payload.inner[1];
    type_7 _e174 = out;
    local_10 = _e174;
    local_11 = static_cast<uint>(base + 5u);
    type_7 _e181 = local_10;
    local_72 = _e181;
    uint _e183 = local_11;
    uint _e185 = local_72.inner[1];
    local_72.inner[1] = _e185 + _e183;
    uint _e189 = local_72.inner[0];
    local_73 = static_cast<uint>(_e189);
    uint _e193 = local_72.inner[1];
    local_74 = static_cast<uint>(_e193);
    uint _e196 = local_74;
    out_1[_e196] = static_cast<uint>(_e173);
    Sample_cuda_record_0_ _e198 = left;
    int _e200 = operator_u0026_u0026_1(_e198, 9);
    type_7 _e201 = out;
    local_12 = _e201;
    local_13 = static_cast<uint>(base + 6u);
    type_7 _e208 = local_12;
    local_75 = _e208;
    uint _e210 = local_13;
    uint _e212 = local_75.inner[1];
    local_75.inner[1] = _e212 + _e210;
    uint _e216 = local_75.inner[0];
    local_76 = static_cast<uint>(_e216);
    uint _e220 = local_75.inner[1];
    local_77 = static_cast<uint>(_e220);
    uint _e223 = local_77;
    out_1[_e223] = static_cast<uint>(_e200);
    Sample_cuda_record_0_ _e225 = right;
    int _e227 = operator_u007c_u007c_1(0, _e225);
    type_7 _e228 = out;
    local_14 = _e228;
    local_15 = static_cast<uint>(base + 7u);
    type_7 _e235 = local_14;
    local_78 = _e235;
    uint _e237 = local_15;
    uint _e239 = local_78.inner[1];
    local_78.inner[1] = _e239 + _e237;
    uint _e243 = local_78.inner[0];
    local_79 = static_cast<uint>(_e243);
    uint _e247 = local_78.inner[1];
    local_80 = static_cast<uint>(_e247);
    uint _e250 = local_80;
    out_1[_e250] = static_cast<uint>(_e227);
    Sample_cuda_record_0_ _e252 = left;
    Sample_cuda_record_0_ _e253 = right;
    Sample_cuda_record_0_ _e254 = operator_u0026_u0026_(_e252, _e253);
    type_7 _e256 = out;
    local_16 = _e256;
    local_17 = static_cast<uint>(base + 8u);
    type_7 _e263 = local_16;
    local_81 = _e263;
    uint _e265 = local_17;
    uint _e267 = local_81.inner[1];
    local_81.inner[1] = _e267 + _e265;
    uint _e271 = local_81.inner[0];
    local_82 = static_cast<uint>(_e271);
    uint _e275 = local_81.inner[1];
    local_83 = static_cast<uint>(_e275);
    uint _e278 = local_83;
    out_1[_e278] = static_cast<uint>(_e254.value);
    Sample_cuda_record_0_ _e280 = left;
    Sample_cuda_record_0_ _e281 = right;
    Sample_cuda_record_0_ _e282 = operator_u007c_u007c(_e280, _e281);
    type_7 _e286 = out;
    local_18 = _e286;
    local_19 = static_cast<uint>(base + 9u);
    type_7 _e293 = local_18;
    local_84 = _e293;
    uint _e295 = local_19;
    uint _e297 = local_84.inner[1];
    local_84.inner[1] = _e297 + _e295;
    uint _e301 = local_84.inner[0];
    local_85 = static_cast<uint>(_e301);
    uint _e305 = local_84.inner[1];
    local_86 = static_cast<uint>(_e305);
    uint _e308 = local_86;
    out_1[_e308] = static_cast<uint>(_e282.payload.inner[0]);
    first = metal::int2(2, 3);
    second = metal::int2(4, 5);
    metal::int2 _e318 = first;
    metal::int2 _e319 = second;
    metal::int2 _e320 = operator_u0026_u0026_2(_e318, _e319);
    type_7 _e322 = out;
    local_20 = _e322;
    local_21 = static_cast<uint>(base + 10u);
    type_7 _e329 = local_20;
    local_87 = _e329;
    uint _e331 = local_21;
    uint _e333 = local_87.inner[1];
    local_87.inner[1] = _e333 + _e331;
    uint _e337 = local_87.inner[0];
    local_88 = static_cast<uint>(_e337);
    uint _e341 = local_87.inner[1];
    local_89 = static_cast<uint>(_e341);
    uint _e344 = local_89;
    out_1[_e344] = static_cast<uint>(_e320.x);
    metal::int2 _e346 = first;
    metal::int2 _e347 = second;
    metal::int2 _e348 = operator_u007c_u007c_2(_e346, _e347);
    type_7 _e350 = out;
    local_22 = _e350;
    local_23 = static_cast<uint>(base + 11u);
    type_7 _e357 = local_22;
    local_90 = _e357;
    uint _e359 = local_23;
    uint _e361 = local_90.inner[1];
    local_90.inner[1] = _e361 + _e359;
    uint _e365 = local_90.inner[0];
    local_91 = static_cast<uint>(_e365);
    uint _e369 = local_90.inner[1];
    local_92 = static_cast<uint>(_e369);
    uint _e372 = local_92;
    out_1[_e372] = static_cast<uint>(_e348.y);
    metal::int2 _e374 = first;
    metal::int2 _e375 = second;
    metal::int2 _e376 = operator_u0026_u0026_2(_e374, _e375);
    metal::int2 _e377 = first;
    metal::int2 _e378 = operator_u0026_u0026_2(_e376, _e377);
    type_7 _e380 = out;
    local_24 = _e380;
    local_25 = static_cast<uint>(base + 12u);
    type_7 _e387 = local_24;
    local_93 = _e387;
    uint _e389 = local_25;
    uint _e391 = local_93.inner[1];
    local_93.inner[1] = _e391 + _e389;
    uint _e395 = local_93.inner[0];
    local_94 = static_cast<uint>(_e395);
    uint _e399 = local_93.inner[1];
    local_95 = static_cast<uint>(_e399);
    uint _e402 = local_95;
    out_1[_e402] = static_cast<uint>(_e378.x);
    metal::int2 _e404 = first;
    metal::int2 _e405 = second;
    metal::int2 _e406 = first;
    metal::int2 _e407 = operator_u0026_u0026_2(_e405, _e406);
    metal::int2 _e408 = operator_u007c_u007c_2(_e404, _e407);
    type_7 _e410 = out;
    local_26 = _e410;
    local_27 = static_cast<uint>(base + 13u);
    type_7 _e417 = local_26;
    local_96 = _e417;
    uint _e419 = local_27;
    uint _e421 = local_96.inner[1];
    local_96.inner[1] = _e421 + _e419;
    uint _e425 = local_96.inner[0];
    local_97 = static_cast<uint>(_e425);
    uint _e429 = local_96.inner[1];
    local_98 = static_cast<uint>(_e429);
    uint _e432 = local_98;
    out_1[_e432] = static_cast<uint>(_e408.y);
    metal::int2 _e434 = first;
    metal::int2 _e435 = second;
    metal::int2 _e436 = operator_u007c_u007c_2(_e434, _e435);
    metal::int2 _e437 = first;
    metal::int2 _e438 = operator_u0026_u0026_2(_e436, _e437);
    type_7 _e440 = out;
    local_28 = _e440;
    local_29 = static_cast<uint>(base + 14u);
    type_7 _e447 = local_28;
    local_99 = _e447;
    uint _e449 = local_29;
    uint _e451 = local_99.inner[1];
    local_99.inner[1] = _e451 + _e449;
    uint _e455 = local_99.inner[0];
    local_100 = static_cast<uint>(_e455);
    uint _e459 = local_99.inner[1];
    local_101 = static_cast<uint>(_e459);
    uint _e462 = local_101;
    out_1[_e462] = static_cast<uint>(_e438.x);
    if (true) {
        Sample_cuda_record_0_ _e465 = left;
        local_32 = _e465;
    } else {
        Sample_cuda_record_0_ _e467 = right;
        local_32 = _e467;
    }
    Sample_cuda_record_0_ _e470 = local_32;
    int _e472 = operator_u0026_u0026_1(_e470, 1);
    type_7 _e473 = out;
    local_30 = _e473;
    local_31 = static_cast<uint>(base + 15u);
    type_7 _e480 = local_30;
    local_102 = _e480;
    uint _e482 = local_31;
    uint _e484 = local_102.inner[1];
    local_102.inner[1] = _e484 + _e482;
    uint _e488 = local_102.inner[0];
    local_103 = static_cast<uint>(_e488);
    uint _e492 = local_102.inner[1];
    local_104 = static_cast<uint>(_e492);
    uint _e495 = local_104;
    out_1[_e495] = static_cast<uint>(_e472);
    if (true) {
        Sample_cuda_record_0_ _e498 = left;
        Sample_cuda_record_0_ _e499 = right;
        Sample_cuda_record_0_ _e500 = operator_u0026_u0026_(_e498, _e499);
        local_35 = _e500;
    } else {
        Sample_cuda_record_0_ _e502 = right;
        Sample_cuda_record_0_ _e503 = left;
        Sample_cuda_record_0_ _e504 = operator_u007c_u007c(_e502, _e503);
        local_35 = _e504;
    }
    Sample_cuda_record_0_ _e507 = local_35;
    type_7 _e509 = out;
    local_33 = _e509;
    local_34 = static_cast<uint>(base + 16u);
    type_7 _e516 = local_33;
    local_105 = _e516;
    uint _e518 = local_34;
    uint _e520 = local_105.inner[1];
    local_105.inner[1] = _e520 + _e518;
    uint _e524 = local_105.inner[0];
    local_106 = static_cast<uint>(_e524);
    uint _e528 = local_105.inner[1];
    local_107 = static_cast<uint>(_e528);
    uint _e531 = local_107;
    out_1[_e531] = static_cast<uint>(_e507.value);
    counter = 0;
    if (false) {
        int _e536 = counter;
        counter = as_type<int>(as_type<uint>(_e536) + as_type<uint>(1));
        local_36.value = _e536;
        local_36.payload.inner[0] = 1;
        local_36.payload.inner[1] = 2;
        Sample_cuda_record_0_ _e546 = local_36;
        Sample_cuda_record_0_ _e547 = right;
        Sample_cuda_record_0_ _e548 = operator_u0026_u0026_(_e546, _e547);
        local_38 = _e548;
    } else {
        Sample_cuda_record_0_ _e550 = left;
        int _e551 = counter;
        counter = as_type<int>(as_type<uint>(_e551) + as_type<uint>(1));
        local_37.value = _e551;
        local_37.payload.inner[0] = 1;
        local_37.payload.inner[1] = 2;
        Sample_cuda_record_0_ _e561 = local_37;
        Sample_cuda_record_0_ _e562 = operator_u007c_u007c(_e550, _e561);
        local_38 = _e562;
    }
    Sample_cuda_record_0_ _e565 = local_38;
    evaluated = _e565;
    int _e568 = evaluated.value;
    type_7 _e569 = out;
    local_39 = _e569;
    local_40 = static_cast<uint>(base + 17u);
    type_7 _e576 = local_39;
    local_108 = _e576;
    uint _e578 = local_40;
    uint _e580 = local_108.inner[1];
    local_108.inner[1] = _e580 + _e578;
    uint _e584 = local_108.inner[0];
    local_109 = static_cast<uint>(_e584);
    uint _e588 = local_108.inner[1];
    local_110 = static_cast<uint>(_e588);
    uint _e591 = local_110;
    out_1[_e591] = static_cast<uint>(_e568);
    int _e593 = counter;
    type_7 _e594 = out;
    local_41 = _e594;
    local_42 = static_cast<uint>(base + 18u);
    type_7 _e601 = local_41;
    local_111 = _e601;
    uint _e603 = local_42;
    uint _e605 = local_111.inner[1];
    local_111.inner[1] = _e605 + _e603;
    uint _e609 = local_111.inner[0];
    local_112 = static_cast<uint>(_e609);
    uint _e613 = local_111.inner[1];
    local_113 = static_cast<uint>(_e613);
    uint _e616 = local_113;
    out_1[_e616] = static_cast<uint>(_e593);
    local_45 = false;
    if (false) {
        Sample_cuda_record_0_ _e620 = left;
        Sample_cuda_record_0_ _e621 = right;
        Sample_cuda_record_0_ _e622 = operator_u0026_u0026_(_e620, _e621);
        local_45 = _e622.value != 0;
    }
    bool _e626 = local_45;
    type_7 _e627 = out;
    local_43 = _e627;
    local_44 = static_cast<uint>(base + 19u);
    type_7 _e634 = local_43;
    local_114 = _e634;
    uint _e636 = local_44;
    uint _e638 = local_114.inner[1];
    local_114.inner[1] = _e638 + _e636;
    uint _e642 = local_114.inner[0];
    local_115 = static_cast<uint>(_e642);
    uint _e646 = local_114.inner[1];
    local_116 = static_cast<uint>(_e646);
    uint _e649 = local_116;
    out_1[_e649] = static_cast<uint>(_e626);
    local_48 = true;
    if (true) {
    } else {
        Sample_cuda_record_0_ _e653 = left;
        Sample_cuda_record_0_ _e654 = right;
        Sample_cuda_record_0_ _e655 = operator_u007c_u007c(_e653, _e654);
        local_48 = _e655.value != 0;
    }
    bool _e659 = local_48;
    type_7 _e660 = out;
    local_46 = _e660;
    local_47 = static_cast<uint>(base + 20u);
    type_7 _e667 = local_46;
    local_117 = _e667;
    uint _e669 = local_47;
    uint _e671 = local_117.inner[1];
    local_117.inner[1] = _e671 + _e669;
    uint _e675 = local_117.inner[0];
    local_118 = static_cast<uint>(_e675);
    uint _e679 = local_117.inner[1];
    local_119 = static_cast<uint>(_e679);
    uint _e682 = local_119;
    out_1[_e682] = static_cast<uint>(_e659);
    bool _e686 = 2 != 0;
    local_51 = _e686;
    if (_e686) {
        local_51 = 3 != 0;
    }
    bool _e691 = local_51;
    type_7 _e692 = out;
    local_49 = _e692;
    local_50 = static_cast<uint>(base + 21u);
    type_7 _e699 = local_49;
    local_120 = _e699;
    uint _e701 = local_50;
    uint _e703 = local_120.inner[1];
    local_120.inner[1] = _e703 + _e701;
    uint _e707 = local_120.inner[0];
    local_121 = static_cast<uint>(_e707);
    uint _e711 = local_120.inner[1];
    local_122 = static_cast<uint>(_e711);
    uint _e714 = local_122;
    out_1[_e714] = static_cast<uint>(_e691);
    bool _e718 = 0 != 0;
    local_54 = _e718;
    if (_e718) {
    } else {
        local_54 = 4 != 0;
    }
    bool _e723 = local_54;
    type_7 _e724 = out;
    local_52 = _e724;
    local_53 = static_cast<uint>(base + 22u);
    type_7 _e731 = local_52;
    local_123 = _e731;
    uint _e733 = local_53;
    uint _e735 = local_123.inner[1];
    local_123.inner[1] = _e735 + _e733;
    uint _e739 = local_123.inner[0];
    local_124 = static_cast<uint>(_e739);
    uint _e743 = local_123.inner[1];
    local_125 = static_cast<uint>(_e743);
    uint _e746 = local_125;
    out_1[_e746] = static_cast<uint>(_e723);
    type_7 _e749 = out;
    local_55 = _e749;
    local_56 = static_cast<uint>(base + 23u);
    type_7 _e755 = local_55;
    local_126 = _e755;
    uint _e757 = local_56;
    uint _e759 = local_126.inner[1];
    local_126.inner[1] = _e759 + _e757;
    uint _e763 = local_126.inner[0];
    local_127 = static_cast<uint>(_e763);
    uint _e767 = local_126.inner[1];
    local_128 = static_cast<uint>(_e767);
    uint _e770 = local_128;
    out_1[_e770] = threadIdx.x;
}
