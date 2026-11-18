// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef int type_2[1];
typedef uint type_3[1];
struct type_6 {
    uint inner[2];
};

uint _naga_fabsf(
    uint input_bits
) {
    uint _e2 = input_bits & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}

struct while_conditionsInput {
};
kernel void while_conditions(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_2 const& input_4 [[buffer(0)]]
, device type_3& output_1 [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    type_6 input = {};
    type_6 output = {};
    int cursor = {};
    int total = {};
    int entry = {};
    type_6 local = {};
    int local_1 = {};
    type_6 local_2 = {};
    type_6 local_3 = {};
    uint local_4 = {};
    int inferred_cursor = {};
    int inferred_total = {};
    type_6 local_5 = {};
    int local_6 = {};
    int entry_1 = {};
    type_6 local_7 = {};
    uint local_8 = {};
    type_6 local_9 = {};
    uint local_10 = {};
    int early_cursor = {};
    int first = {};
    type_6 local_11 = {};
    int local_12 = {};
    int entry_2 = {};
    type_6 local_13 = {};
    uint local_14 = {};
    type_6 local_15 = {};
    uint local_16 = {};
    int repeat = {};
    int fixed = {};
    type_6 local_17 = {};
    uint local_18 = {};
    int entry_3 = {};
    int nested = {};
    type_6 local_19 = {};
    uint local_20 = {};
    int entry_4 = {};
    int entry_5 = {};
    type_6 local_21 = {};
    uint local_22 = {};
    type_6 local_23 = {};
    uint local_24 = {};
    int false_count = {};
    int stopped = {};
    type_6 local_25 = {};
    uint local_26 = {};
    float fraction = {};
    type_6 local_27 = {};
    uint local_28 = {};
    type_6 local_29 = {};
    uint local_30 = {};
    type_6 input_1 = {};
    uint offset = {};
    type_6 local_31 = {};
    uint local_32 = {};
    int local_33 = {};
    int local_34 = {};
    int local_35 = {};
    type_6 input_2 = {};
    uint offset_1 = {};
    type_6 local_36 = {};
    uint local_37 = {};
    int local_38 = {};
    int local_39 = {};
    int local_40 = {};
    type_6 input_3 = {};
    uint offset_2 = {};
    type_6 local_41 = {};
    uint local_42 = {};
    int local_43 = {};
    int local_44 = {};
    int local_45 = {};
    int local_46 = {};
    type_6 local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    int local_50 = {};
    type_6 local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    type_6 local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    type_6 local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    int local_60 = {};
    type_6 local_61 = {};
    uint local_62 = {};
    uint local_63 = {};
    type_6 local_64 = {};
    uint local_65 = {};
    uint local_66 = {};
    type_6 local_67 = {};
    uint local_68 = {};
    uint local_69 = {};
    int local_70 = {};
    type_6 local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    type_6 local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    type_6 local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    type_6 local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    int local_83 = {};
    type_6 local_84 = {};
    uint local_85 = {};
    uint local_86 = {};
    type_6 local_87 = {};
    uint local_88 = {};
    uint local_89 = {};
    type_6 local_90 = {};
    uint local_91 = {};
    uint local_92 = {};
    type_6 local_93 = {};
    uint local_94 = {};
    uint local_95 = {};
    type_6 local_96 = {};
    uint local_97 = {};
    uint local_98 = {};
    input = type_6 {};
    input.inner[0] = 2u;
    input.inner[1] = 0u;
    output = type_6 {};
    output.inner[0] = 3u;
    output.inner[1] = 0u;
    uint lane = threadIdx.x + (blockIdx.x * 4u);
    if (lane >= 4u) {
        return;
    }
    uint offset_3 = lane * 4u;
    uint base = 4u + (lane * 12u);
    cursor = 0;
    total = 0;
    uint2 loop_bound = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        type_6 _e32 = input;
        local = _e32;
        offset = uint {};
        local_32 = uint {};
        local_33 = int {};
        type_6 _e40 = local;
        input_1 = _e40;
        offset = offset_3;
        type_6 _e44 = input_1;
        local_31 = _e44;
        int _e46 = cursor;
        local_34 = _e46;
        int _e48 = local_34;
        cursor = as_type<int>(as_type<uint>(_e48) + as_type<uint>(1));
        uint _e52 = offset;
        local_32 = static_cast<uint>(_e52 + static_cast<uint>(_e48));
        type_6 _e56 = local_31;
        local_47 = _e56;
        uint _e58 = local_32;
        uint _e60 = local_47.inner[1];
        local_47.inner[1] = _e60 + _e58;
        uint _e64 = local_47.inner[0];
        local_48 = static_cast<uint>(_e64);
        uint _e68 = local_47.inner[1];
        local_49 = static_cast<uint>(_e68);
        uint _e71 = local_49;
        int _e74 = input_4[_e71];
        local_50 = _e74;
        int _e76 = local_50;
        local_35 = _e76;
        int _e78 = local_35;
        local_33 = _e78;
        int _e80 = local_33;
        local_1 = _e80;
        int _e82 = local_1;
        entry = _e82;
        int _e84 = entry;
        if (_e84 != 0) {
        } else {
            break;
        }
        {
            int _e87 = entry;
            if (_e87 == 1) {
                entry = 99;
                continue;
            }
            int _e91 = entry;
            int _e92 = total;
            total = as_type<int>(as_type<uint>(_e92) + as_type<uint>(_e91));
        }
    }
    int _e94 = total;
    type_6 _e97 = output;
    local_2 = _e97;
    type_6 _e99 = local_2;
    local_51 = _e99;
    uint _e102 = local_51.inner[1];
    local_51.inner[1] = _e102 + base;
    uint _e106 = local_51.inner[0];
    local_52 = static_cast<uint>(_e106);
    uint _e110 = local_51.inner[1];
    local_53 = static_cast<uint>(_e110);
    uint _e113 = local_53;
    output_1[_e113] = static_cast<uint>(_e94);
    int _e116 = cursor;
    type_6 _e118 = output;
    local_3 = _e118;
    local_4 = static_cast<uint>(base + 1u);
    type_6 _e124 = local_3;
    local_54 = _e124;
    uint _e126 = local_4;
    uint _e128 = local_54.inner[1];
    local_54.inner[1] = _e128 + _e126;
    uint _e132 = local_54.inner[0];
    local_55 = static_cast<uint>(_e132);
    uint _e136 = local_54.inner[1];
    local_56 = static_cast<uint>(_e136);
    uint _e139 = local_56;
    output_1[_e139] = static_cast<uint>(_e116);
    inferred_cursor = 0;
    inferred_total = 0;
    uint2 loop_bound_1 = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        type_6 _e146 = input;
        local_5 = _e146;
        offset_1 = uint {};
        local_37 = uint {};
        local_38 = int {};
        type_6 _e154 = local_5;
        input_2 = _e154;
        offset_1 = offset_3;
        type_6 _e158 = input_2;
        local_36 = _e158;
        int _e160 = inferred_cursor;
        local_39 = _e160;
        int _e162 = local_39;
        inferred_cursor = as_type<int>(as_type<uint>(_e162) + as_type<uint>(1));
        uint _e166 = offset_1;
        local_37 = static_cast<uint>(_e166 + static_cast<uint>(_e162));
        type_6 _e170 = local_36;
        local_57 = _e170;
        uint _e172 = local_37;
        uint _e174 = local_57.inner[1];
        local_57.inner[1] = _e174 + _e172;
        uint _e178 = local_57.inner[0];
        local_58 = static_cast<uint>(_e178);
        uint _e182 = local_57.inner[1];
        local_59 = static_cast<uint>(_e182);
        uint _e185 = local_59;
        int _e188 = input_4[_e185];
        local_60 = _e188;
        int _e190 = local_60;
        local_40 = _e190;
        int _e192 = local_40;
        local_38 = _e192;
        int _e194 = local_38;
        local_6 = _e194;
        int _e196 = local_6;
        entry_1 = _e196;
        int _e198 = entry_1;
        if (_e198 != 0) {
        } else {
            break;
        }
        {
            int _e201 = entry_1;
            switch(_e201) {
                case 1: {
                    entry_1 = 77;
                    continue;
                }
                default: {
                    int _e203 = entry_1;
                    int _e204 = inferred_total;
                    inferred_total = as_type<int>(as_type<uint>(_e204) + as_type<uint>(_e203));
                    break;
                }
            }
        }
    }
    int _e206 = inferred_total;
    type_6 _e208 = output;
    local_7 = _e208;
    local_8 = static_cast<uint>(base + 2u);
    type_6 _e214 = local_7;
    local_61 = _e214;
    uint _e216 = local_8;
    uint _e218 = local_61.inner[1];
    local_61.inner[1] = _e218 + _e216;
    uint _e222 = local_61.inner[0];
    local_62 = static_cast<uint>(_e222);
    uint _e226 = local_61.inner[1];
    local_63 = static_cast<uint>(_e226);
    uint _e229 = local_63;
    output_1[_e229] = static_cast<uint>(_e206);
    int _e231 = inferred_cursor;
    type_6 _e233 = output;
    local_9 = _e233;
    local_10 = static_cast<uint>(base + 3u);
    type_6 _e239 = local_9;
    local_64 = _e239;
    uint _e241 = local_10;
    uint _e243 = local_64.inner[1];
    local_64.inner[1] = _e243 + _e241;
    uint _e247 = local_64.inner[0];
    local_65 = static_cast<uint>(_e247);
    uint _e251 = local_64.inner[1];
    local_66 = static_cast<uint>(_e251);
    uint _e254 = local_66;
    output_1[_e254] = static_cast<uint>(_e231);
    early_cursor = 0;
    first = 0;
    uint2 loop_bound_2 = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound_2 == uint2(0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        type_6 _e261 = input;
        local_11 = _e261;
        offset_2 = uint {};
        local_42 = uint {};
        local_43 = int {};
        type_6 _e269 = local_11;
        input_3 = _e269;
        offset_2 = offset_3;
        type_6 _e273 = input_3;
        local_41 = _e273;
        int _e275 = early_cursor;
        local_44 = _e275;
        int _e277 = local_44;
        early_cursor = as_type<int>(as_type<uint>(_e277) + as_type<uint>(1));
        uint _e281 = offset_2;
        local_42 = static_cast<uint>(_e281 + static_cast<uint>(_e277));
        type_6 _e285 = local_41;
        local_67 = _e285;
        uint _e287 = local_42;
        uint _e289 = local_67.inner[1];
        local_67.inner[1] = _e289 + _e287;
        uint _e293 = local_67.inner[0];
        local_68 = static_cast<uint>(_e293);
        uint _e297 = local_67.inner[1];
        local_69 = static_cast<uint>(_e297);
        uint _e300 = local_69;
        int _e303 = input_4[_e300];
        local_70 = _e303;
        int _e305 = local_70;
        local_45 = _e305;
        int _e307 = local_45;
        local_43 = _e307;
        int _e309 = local_43;
        local_12 = _e309;
        int _e311 = local_12;
        entry_2 = _e311;
        int _e313 = entry_2;
        if (_e313 != 0) {
        } else {
            break;
        }
        {
            int _e316 = entry_2;
            first = _e316;
            break;
        }
    }
    int _e317 = first;
    type_6 _e319 = output;
    local_13 = _e319;
    local_14 = static_cast<uint>(base + 4u);
    type_6 _e325 = local_13;
    local_71 = _e325;
    uint _e327 = local_14;
    uint _e329 = local_71.inner[1];
    local_71.inner[1] = _e329 + _e327;
    uint _e333 = local_71.inner[0];
    local_72 = static_cast<uint>(_e333);
    uint _e337 = local_71.inner[1];
    local_73 = static_cast<uint>(_e337);
    uint _e340 = local_73;
    output_1[_e340] = static_cast<uint>(_e317);
    int _e342 = early_cursor;
    type_6 _e344 = output;
    local_15 = _e344;
    local_16 = static_cast<uint>(base + 5u);
    type_6 _e350 = local_15;
    local_74 = _e350;
    uint _e352 = local_16;
    uint _e354 = local_74.inner[1];
    local_74.inner[1] = _e354 + _e352;
    uint _e358 = local_74.inner[0];
    local_75 = static_cast<uint>(_e358);
    uint _e362 = local_74.inner[1];
    local_76 = static_cast<uint>(_e362);
    uint _e365 = local_76;
    output_1[_e365] = static_cast<uint>(_e342);
    repeat = 0;
    uint2 loop_bound_3 = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound_3 == uint2(0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        fixed = 1;
        int _e371 = fixed;
        if (_e371 != 0) {
        } else {
            break;
        }
        {
            int _e374 = fixed;
            int _e375 = repeat;
            repeat = as_type<int>(as_type<uint>(_e375) + as_type<uint>(_e374));
            int _e377 = repeat;
            if (_e377 == 2) {
                break;
            }
        }
    }
    int _e380 = repeat;
    type_6 _e382 = output;
    local_17 = _e382;
    local_18 = static_cast<uint>(base + 6u);
    type_6 _e388 = local_17;
    local_77 = _e388;
    uint _e390 = local_18;
    uint _e392 = local_77.inner[1];
    local_77.inner[1] = _e392 + _e390;
    uint _e396 = local_77.inner[0];
    local_78 = static_cast<uint>(_e396);
    uint _e400 = local_77.inner[1];
    local_79 = static_cast<uint>(_e400);
    uint _e403 = local_79;
    output_1[_e403] = static_cast<uint>(_e380);
    entry_3 = 50;
    nested = 0;
    uint2 loop_bound_4 = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound_4 == uint2(0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        type_6 _e410 = input;
        local_19 = _e410;
        local_20 = offset_3;
        type_6 _e413 = local_19;
        local_80 = _e413;
        uint _e415 = local_20;
        uint _e417 = local_80.inner[1];
        local_80.inner[1] = _e417 + _e415;
        uint _e421 = local_80.inner[0];
        local_81 = static_cast<uint>(_e421);
        uint _e425 = local_80.inner[1];
        local_82 = static_cast<uint>(_e425);
        uint _e428 = local_82;
        int _e431 = input_4[_e428];
        local_83 = _e431;
        int _e433 = local_83;
        local_46 = _e433;
        int _e435 = local_46;
        entry_4 = _e435;
        int _e437 = entry_4;
        if (_e437 != 0) {
        } else {
            break;
        }
        {
            {
                entry_5 = 9;
                int _e442 = entry_5;
                int _e443 = nested;
                nested = as_type<int>(as_type<uint>(_e443) + as_type<uint>(_e442));
            }
            int _e445 = entry_4;
            int _e446 = nested;
            nested = as_type<int>(as_type<uint>(_e446) + as_type<uint>(_e445));
            break;
        }
    }
    int _e448 = nested;
    type_6 _e450 = output;
    local_21 = _e450;
    local_22 = static_cast<uint>(base + 7u);
    type_6 _e456 = local_21;
    local_84 = _e456;
    uint _e458 = local_22;
    uint _e460 = local_84.inner[1];
    local_84.inner[1] = _e460 + _e458;
    uint _e464 = local_84.inner[0];
    local_85 = static_cast<uint>(_e464);
    uint _e468 = local_84.inner[1];
    local_86 = static_cast<uint>(_e468);
    uint _e471 = local_86;
    output_1[_e471] = static_cast<uint>(_e448);
    int _e473 = entry_3;
    type_6 _e475 = output;
    local_23 = _e475;
    local_24 = static_cast<uint>(base + 8u);
    type_6 _e481 = local_23;
    local_87 = _e481;
    uint _e483 = local_24;
    uint _e485 = local_87.inner[1];
    local_87.inner[1] = _e485 + _e483;
    uint _e489 = local_87.inner[0];
    local_88 = static_cast<uint>(_e489);
    uint _e493 = local_87.inner[1];
    local_89 = static_cast<uint>(_e493);
    uint _e496 = local_89;
    output_1[_e496] = static_cast<uint>(_e473);
    false_count = 0;
    uint2 loop_bound_5 = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound_5 == uint2(0u))) { break; }
        loop_bound_5 -= uint2(loop_bound_5.y == 0u, 1u);
        int _e500 = false_count;
        false_count = as_type<int>(as_type<uint>(_e500) + as_type<uint>(1));
        stopped = 0;
        int _e505 = stopped;
        if (_e505 != 0) {
        } else {
            break;
        }
        {
            int _e508 = total;
            total = as_type<int>(as_type<uint>(_e508) + as_type<uint>(1));
        }
    }
    int _e511 = false_count;
    type_6 _e513 = output;
    local_25 = _e513;
    local_26 = static_cast<uint>(base + 9u);
    type_6 _e519 = local_25;
    local_90 = _e519;
    uint _e521 = local_26;
    uint _e523 = local_90.inner[1];
    local_90.inner[1] = _e523 + _e521;
    uint _e527 = local_90.inner[0];
    local_91 = static_cast<uint>(_e527);
    uint _e531 = local_90.inner[1];
    local_92 = static_cast<uint>(_e531);
    uint _e534 = local_92;
    output_1[_e534] = static_cast<uint>(_e511);
    uint2 loop_bound_6 = uint2(4294967295u);
    while(true) {
        if (metal::all(loop_bound_6 == uint2(0u))) { break; }
        loop_bound_6 -= uint2(loop_bound_6.y == 0u, 1u);
        fraction = 0.5;
        float _e538 = fraction;
        uint _e540 = _naga_fabsf(as_type<uint>(_e538));
        if (_e540 != 0u) {
        } else {
            break;
        }
        {
            int _e543 = total;
            total = as_type<int>(as_type<uint>(_e543) + as_type<uint>(1));
            break;
        }
    }
    int _e546 = total;
    type_6 _e548 = output;
    local_27 = _e548;
    local_28 = static_cast<uint>(base + 10u);
    type_6 _e554 = local_27;
    local_93 = _e554;
    uint _e556 = local_28;
    uint _e558 = local_93.inner[1];
    local_93.inner[1] = _e558 + _e556;
    uint _e562 = local_93.inner[0];
    local_94 = static_cast<uint>(_e562);
    uint _e566 = local_93.inner[1];
    local_95 = static_cast<uint>(_e566);
    uint _e569 = local_95;
    output_1[_e569] = static_cast<uint>(_e546);
    int _e571 = cursor;
    int _e572 = inferred_cursor;
    int _e574 = early_cursor;
    int _e576 = false_count;
    type_6 _e579 = output;
    local_29 = _e579;
    local_30 = static_cast<uint>(base + 11u);
    type_6 _e585 = local_29;
    local_96 = _e585;
    uint _e587 = local_30;
    uint _e589 = local_96.inner[1];
    local_96.inner[1] = _e589 + _e587;
    uint _e593 = local_96.inner[0];
    local_97 = static_cast<uint>(_e593);
    uint _e597 = local_96.inner[1];
    local_98 = static_cast<uint>(_e597);
    uint _e600 = local_98;
    output_1[_e600] = static_cast<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e571) + as_type<uint>(_e572))) + as_type<uint>(_e574))) + as_type<uint>(_e576)));
}
