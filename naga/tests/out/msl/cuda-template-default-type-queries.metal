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
struct QueryRecord_cuda_record_0_ {
    int value;
    type_1 pair;
};
struct type_3 {
    int inner[3];
};
struct type_4 {
    type_3 inner[2];
};
typedef uint type_6[1];
typedef int type_7[1];
struct type_9 {
    uint inner[2];
};
constant int Item_2 = 7;

int scalar_query_int(
    int unused_6,
    int value_7,
    int bytes_9
) {
    return bytes_9;
}

int own_query_3_(
    int value_8
) {
    return as_type<int>(as_type<uint>(value_8) + as_type<uint>(3));
}

int vector_query_int(
    int unused_7,
    metal::float2 item_2,
    int bytes_10,
    int element_5
) {
    metal::float2 item_3 = {};
    item_3 = item_2;
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(bytes_10) * as_type<uint>(10))) + as_type<uint>(element_5));
}

int null_query_int(
    int unused_8,
    int bytes_11
) {
    return bytes_11;
}

int frozen_query_int(
    int renamed,
    metal::float2 other,
    int width
) {
    metal::float2 other_1 = {};
    other_1 = other;
    return width;
}

int shadow_query_int(
    int unused_9,
    metal::float2 Item,
    int bytes_12
) {
    metal::float2 Item_1 = {};
    Item_1 = Item;
    return bytes_12;
}

int alias_query_int(
    int unused_10,
    int Alias,
    int bytes_13
) {
    return bytes_13;
}

struct template_default_type_queriesInput {
};
kernel void template_default_type_queries(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_6& output_1 [[buffer(0)]]
, device type_7 const& input_1 [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    type_9 output = {};
    type_9 input = {};
    int value = {};
    int original = {};
    QueryRecord_cuda_record_0_ item = {};
    metal::float2 pair = {};
    type_3 row = {};
    type_4 grid = {};
    type_9 local = {};
    type_9 local_1 = {};
    uint local_2 = {};
    type_9 local_3 = {};
    uint local_4 = {};
    type_9 local_5 = {};
    uint local_6 = {};
    type_9 local_7 = {};
    uint local_8 = {};
    type_9 local_9 = {};
    uint local_10 = {};
    type_9 local_11 = {};
    int local_12 = {};
    type_9 local_13 = {};
    uint local_14 = {};
    type_9 local_15 = {};
    int local_16 = {};
    type_9 local_17 = {};
    uint local_18 = {};
    int local_19 = {};
    type_9 local_20 = {};
    uint local_21 = {};
    type_9 local_22 = {};
    uint local_23 = {};
    type_9 local_24 = {};
    uint local_25 = {};
    type_9 local_26 = {};
    uint local_27 = {};
    type_9 local_28 = {};
    uint local_29 = {};
    type_9 local_30 = {};
    uint local_31 = {};
    int index = {};
    type_9 local_32 = {};
    uint local_33 = {};
    type_9 local_34 = {};
    uint local_35 = {};
    int local_36 = {};
    type_9 local_37 = {};
    uint local_38 = {};
    type_9 local_39 = {};
    uint local_40 = {};
    type_9 local_41 = {};
    uint local_42 = {};
    int local_43 = {};
    type_9 local_44 = {};
    uint local_45 = {};
    int local_46 = {};
    type_9 local_47 = {};
    uint local_48 = {};
    int local_49 = {};
    int unused = {};
    int bytes = {};
    int unused_1 = {};
    type_9 value_1 = {};
    int bytes_1 = {};
    int element = {};
    int unused_2 = {};
    type_9 value_2 = {};
    int bytes_2 = {};
    int element_1 = {};
    int unused_3 = {};
    int bytes_3 = {};
    int pair_1 = {};
    int element_2 = {};
    int unused_4 = {};
    type_9 item_1 = {};
    int bytes_4 = {};
    int unused_5 = {};
    type_9 value_3 = {};
    int bytes_5 = {};
    int element_3 = {};
    type_9 value_4 = {};
    int bytes_6 = {};
    int element_4 = {};
    type_9 value_5 = {};
    int bytes_7 = {};
    int row_1 = {};
    type_9 value_6 = {};
    int bytes_8 = {};
    int row_2 = {};
    type_9 local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    type_9 local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    type_9 local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    type_9 local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    type_9 local_62 = {};
    uint local_63 = {};
    uint local_64 = {};
    type_9 local_65 = {};
    uint local_66 = {};
    uint local_67 = {};
    type_9 local_68 = {};
    uint local_69 = {};
    uint local_70 = {};
    type_9 local_71 = {};
    uint local_72 = {};
    uint local_73 = {};
    type_9 local_74 = {};
    uint local_75 = {};
    uint local_76 = {};
    type_9 local_77 = {};
    uint local_78 = {};
    uint local_79 = {};
    type_9 local_80 = {};
    uint local_81 = {};
    uint local_82 = {};
    type_9 local_83 = {};
    uint local_84 = {};
    uint local_85 = {};
    type_9 local_86 = {};
    uint local_87 = {};
    uint local_88 = {};
    type_9 local_89 = {};
    uint local_90 = {};
    uint local_91 = {};
    type_9 local_92 = {};
    uint local_93 = {};
    uint local_94 = {};
    type_9 local_95 = {};
    uint local_96 = {};
    uint local_97 = {};
    type_9 local_98 = {};
    uint local_99 = {};
    uint local_100 = {};
    type_9 local_101 = {};
    uint local_102 = {};
    uint local_103 = {};
    type_9 local_104 = {};
    uint local_105 = {};
    uint local_106 = {};
    type_9 local_107 = {};
    uint local_108 = {};
    uint local_109 = {};
    output = type_9 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    input = type_9 {};
    input.inner[0] = 3u;
    input.inner[1] = 0u;
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 19u);
    value = as_type<int>(as_type<uint>(static_cast<int>(lane)) + as_type<uint>(1));
    original = 99;
    item.value = 1;
    item.pair.inner[0] = 2;
    item.pair.inner[1] = 3;
    pair = metal::float2(1.0, 2.0);
    row.inner[0] = 1;
    row.inner[1] = 2;
    row.inner[2] = 3;
    grid.inner[0].inner[0] = 4;
    grid.inner[0].inner[1] = 5;
    grid.inner[0].inner[2] = 6;
    grid.inner[1].inner[0] = 7;
    grid.inner[1].inner[1] = 8;
    grid.inner[1].inner[2] = 9;
    int _e58 = value;
    value = as_type<int>(as_type<uint>(_e58) + as_type<uint>(1));
    int _e63 = scalar_query_int(1, _e58, 4);
    type_9 _e66 = output;
    local = _e66;
    type_9 _e68 = local;
    local_50 = _e68;
    uint _e71 = local_50.inner[1];
    local_50.inner[1] = _e71 + base;
    uint _e75 = local_50.inner[0];
    local_51 = static_cast<uint>(_e75);
    uint _e79 = local_50.inner[1];
    local_52 = static_cast<uint>(_e79);
    uint _e82 = local_52;
    output_1[_e82] = static_cast<uint>(_e63);
    int _e85 = value;
    value = as_type<int>(as_type<uint>(_e85) + as_type<uint>(1));
    int _e90 = scalar_query_int(1, _e85, 9);
    type_9 _e92 = output;
    local_1 = _e92;
    local_2 = static_cast<uint>(base + 1u);
    type_9 _e98 = local_1;
    local_53 = _e98;
    uint _e100 = local_2;
    uint _e102 = local_53.inner[1];
    local_53.inner[1] = _e102 + _e100;
    uint _e106 = local_53.inner[0];
    local_54 = static_cast<uint>(_e106);
    uint _e110 = local_53.inner[1];
    local_55 = static_cast<uint>(_e110);
    uint _e113 = local_55;
    output_1[_e113] = static_cast<uint>(_e90);
    int _e115 = value;
    type_9 _e117 = output;
    local_3 = _e117;
    local_4 = static_cast<uint>(base + 2u);
    type_9 _e123 = local_3;
    local_56 = _e123;
    uint _e125 = local_4;
    uint _e127 = local_56.inner[1];
    local_56.inner[1] = _e127 + _e125;
    uint _e131 = local_56.inner[0];
    local_57 = static_cast<uint>(_e131);
    uint _e135 = local_56.inner[1];
    local_58 = static_cast<uint>(_e135);
    uint _e138 = local_58;
    output_1[_e138] = static_cast<uint>(_e115);
    int _e141 = own_query_3_(4);
    type_9 _e143 = output;
    local_5 = _e143;
    local_6 = static_cast<uint>(base + 3u);
    type_9 _e149 = local_5;
    local_59 = _e149;
    uint _e151 = local_6;
    uint _e153 = local_59.inner[1];
    local_59.inner[1] = _e153 + _e151;
    uint _e157 = local_59.inner[0];
    local_60 = static_cast<uint>(_e157);
    uint _e161 = local_59.inner[1];
    local_61 = static_cast<uint>(_e161);
    uint _e164 = local_61;
    output_1[_e164] = static_cast<uint>(_e141);
    unused = int {};
    bytes = int {};
    unused = 1;
    bytes = 4;
    int _e174 = bytes;
    type_9 _e176 = output;
    local_7 = _e176;
    local_8 = static_cast<uint>(base + 4u);
    type_9 _e182 = local_7;
    local_62 = _e182;
    uint _e184 = local_8;
    uint _e186 = local_62.inner[1];
    local_62.inner[1] = _e186 + _e184;
    uint _e190 = local_62.inner[0];
    local_63 = static_cast<uint>(_e190);
    uint _e194 = local_62.inner[1];
    local_64 = static_cast<uint>(_e194);
    uint _e197 = local_64;
    output_1[_e197] = static_cast<uint>(_e174);
    type_9 _e200 = input;
    local_11 = _e200;
    unused_1 = int {};
    bytes_1 = int {};
    element = int {};
    unused_1 = 1;
    type_9 _e210 = local_11;
    value_1 = _e210;
    bytes_1 = 8;
    element = 4;
    int _e216 = bytes_1;
    int _e219 = element;
    local_12 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e216) * as_type<uint>(100))) + as_type<uint>(_e219));
    int _e222 = local_12;
    type_9 _e224 = output;
    local_9 = _e224;
    local_10 = static_cast<uint>(base + 5u);
    type_9 _e230 = local_9;
    local_65 = _e230;
    uint _e232 = local_10;
    uint _e234 = local_65.inner[1];
    local_65.inner[1] = _e234 + _e232;
    uint _e238 = local_65.inner[0];
    local_66 = static_cast<uint>(_e238);
    uint _e242 = local_65.inner[1];
    local_67 = static_cast<uint>(_e242);
    uint _e245 = local_67;
    output_1[_e245] = static_cast<uint>(_e222);
    type_9 _e247 = input;
    local_15 = _e247;
    unused_2 = int {};
    bytes_2 = int {};
    element_1 = int {};
    unused_2 = 1;
    type_9 _e257 = local_15;
    value_2 = _e257;
    bytes_2 = 8;
    element_1 = 4;
    int _e263 = bytes_2;
    int _e266 = element_1;
    local_16 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e263) * as_type<uint>(100))) + as_type<uint>(_e266));
    int _e269 = local_16;
    type_9 _e271 = output;
    local_13 = _e271;
    local_14 = static_cast<uint>(base + 6u);
    type_9 _e277 = local_13;
    local_68 = _e277;
    uint _e279 = local_14;
    uint _e281 = local_68.inner[1];
    local_68.inner[1] = _e281 + _e279;
    uint _e285 = local_68.inner[0];
    local_69 = static_cast<uint>(_e285);
    uint _e289 = local_68.inner[1];
    local_70 = static_cast<uint>(_e289);
    uint _e292 = local_70;
    output_1[_e292] = static_cast<uint>(_e269);
    unused_3 = int {};
    bytes_3 = int {};
    pair_1 = int {};
    element_2 = int {};
    unused_3 = 1;
    bytes_3 = 12;
    pair_1 = 8;
    element_2 = 4;
    int _e310 = bytes_3;
    int _e313 = pair_1;
    int _e317 = element_2;
    local_19 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e310) * as_type<uint>(100))) + as_type<uint>(as_type<int>(as_type<uint>(_e313) * as_type<uint>(10))))) + as_type<uint>(_e317));
    int _e320 = local_19;
    type_9 _e322 = output;
    local_17 = _e322;
    local_18 = static_cast<uint>(base + 7u);
    type_9 _e328 = local_17;
    local_71 = _e328;
    uint _e330 = local_18;
    uint _e332 = local_71.inner[1];
    local_71.inner[1] = _e332 + _e330;
    uint _e336 = local_71.inner[0];
    local_72 = static_cast<uint>(_e336);
    uint _e340 = local_71.inner[1];
    local_73 = static_cast<uint>(_e340);
    uint _e343 = local_73;
    output_1[_e343] = static_cast<uint>(_e320);
    metal::float2 _e345 = pair;
    int _e349 = vector_query_int(1, _e345, 8, 4);
    type_9 _e351 = output;
    local_20 = _e351;
    local_21 = static_cast<uint>(base + 8u);
    type_9 _e357 = local_20;
    local_74 = _e357;
    uint _e359 = local_21;
    uint _e361 = local_74.inner[1];
    local_74.inner[1] = _e361 + _e359;
    uint _e365 = local_74.inner[0];
    local_75 = static_cast<uint>(_e365);
    uint _e369 = local_74.inner[1];
    local_76 = static_cast<uint>(_e369);
    uint _e372 = local_76;
    output_1[_e372] = static_cast<uint>(_e349);
    unused_4 = int {};
    bytes_4 = int {};
    unused_4 = 1;
    item_1 = type_9 {};
    item_1.inner[0] = 4u;
    item_1.inner[1] = 0u;
    bytes_4 = 8;
    int _e388 = bytes_4;
    type_9 _e390 = output;
    local_22 = _e390;
    local_23 = static_cast<uint>(base + 9u);
    type_9 _e396 = local_22;
    local_77 = _e396;
    uint _e398 = local_23;
    uint _e400 = local_77.inner[1];
    local_77.inner[1] = _e400 + _e398;
    uint _e404 = local_77.inner[0];
    local_78 = static_cast<uint>(_e404);
    uint _e408 = local_77.inner[1];
    local_79 = static_cast<uint>(_e408);
    uint _e411 = local_79;
    output_1[_e411] = static_cast<uint>(_e388);
    int _e415 = null_query_int(1, 8);
    type_9 _e417 = output;
    local_24 = _e417;
    local_25 = static_cast<uint>(base + 10u);
    type_9 _e423 = local_24;
    local_80 = _e423;
    uint _e425 = local_25;
    uint _e427 = local_80.inner[1];
    local_80.inner[1] = _e427 + _e425;
    uint _e431 = local_80.inner[0];
    local_81 = static_cast<uint>(_e431);
    uint _e435 = local_80.inner[1];
    local_82 = static_cast<uint>(_e435);
    uint _e438 = local_82;
    output_1[_e438] = static_cast<uint>(_e415);
    metal::float2 _e440 = pair;
    int _e443 = frozen_query_int(1, _e440, 8);
    type_9 _e445 = output;
    local_26 = _e445;
    local_27 = static_cast<uint>(base + 11u);
    type_9 _e451 = local_26;
    local_83 = _e451;
    uint _e453 = local_27;
    uint _e455 = local_83.inner[1];
    local_83.inner[1] = _e455 + _e453;
    uint _e459 = local_83.inner[0];
    local_84 = static_cast<uint>(_e459);
    uint _e463 = local_83.inner[1];
    local_85 = static_cast<uint>(_e463);
    uint _e466 = local_85;
    output_1[_e466] = static_cast<uint>(_e443);
    metal::float2 _e468 = pair;
    int _e471 = shadow_query_int(1, _e468, 8);
    type_9 _e473 = output;
    local_28 = _e473;
    local_29 = static_cast<uint>(base + 12u);
    type_9 _e479 = local_28;
    local_86 = _e479;
    uint _e481 = local_29;
    uint _e483 = local_86.inner[1];
    local_86.inner[1] = _e483 + _e481;
    uint _e487 = local_86.inner[0];
    local_87 = static_cast<uint>(_e487);
    uint _e491 = local_86.inner[1];
    local_88 = static_cast<uint>(_e491);
    uint _e494 = local_88;
    output_1[_e494] = static_cast<uint>(_e471);
    int _e499 = alias_query_int(1, 9, 4);
    type_9 _e501 = output;
    local_30 = _e501;
    local_31 = static_cast<uint>(base + 13u);
    type_9 _e507 = local_30;
    local_89 = _e507;
    uint _e509 = local_31;
    uint _e511 = local_89.inner[1];
    local_89.inner[1] = _e511 + _e509;
    uint _e515 = local_89.inner[0];
    local_90 = static_cast<uint>(_e515);
    uint _e519 = local_89.inner[1];
    local_91 = static_cast<uint>(_e519);
    uint _e522 = local_91;
    output_1[_e522] = static_cast<uint>(_e499);
    index = 0;
    type_9 _e526 = input;
    local_34 = _e526;
    int _e528 = index;
    index = as_type<int>(as_type<uint>(_e528) + as_type<uint>(1));
    local_35 = static_cast<uint>(_e528);
    unused_5 = int {};
    bytes_5 = int {};
    element_3 = int {};
    unused_5 = 1;
    type_9 _e541 = local_34;
    value_3 = _e541;
    uint _e543 = local_35;
    uint _e545 = value_3.inner[1];
    value_3.inner[1] = _e545 + _e543;
    bytes_5 = 8;
    element_3 = 4;
    int _e552 = bytes_5;
    int _e555 = element_3;
    local_36 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e552) * as_type<uint>(100))) + as_type<uint>(_e555));
    int _e558 = local_36;
    type_9 _e560 = output;
    local_32 = _e560;
    local_33 = static_cast<uint>(base + 14u);
    type_9 _e566 = local_32;
    local_92 = _e566;
    uint _e568 = local_33;
    uint _e570 = local_92.inner[1];
    local_92.inner[1] = _e570 + _e568;
    uint _e574 = local_92.inner[0];
    local_93 = static_cast<uint>(_e574);
    uint _e578 = local_92.inner[1];
    local_94 = static_cast<uint>(_e578);
    uint _e581 = local_94;
    output_1[_e581] = static_cast<uint>(_e558);
    type_9 _e583 = input;
    local_39 = _e583;
    local_40 = static_cast<uint>(0);
    int _e588 = index;
    type_9 _e589 = local_39;
    local_95 = _e589;
    uint _e591 = local_40;
    uint _e593 = local_95.inner[1];
    local_95.inner[1] = _e593 + _e591;
    uint _e597 = local_95.inner[0];
    local_96 = static_cast<uint>(_e597);
    uint _e601 = local_95.inner[1];
    local_97 = static_cast<uint>(_e601);
    uint _e604 = local_97;
    int _e607 = input_1[_e604];
    type_9 _e610 = output;
    local_37 = _e610;
    local_38 = static_cast<uint>(base + 15u);
    type_9 _e616 = local_37;
    local_98 = _e616;
    uint _e618 = local_38;
    uint _e620 = local_98.inner[1];
    local_98.inner[1] = _e620 + _e618;
    uint _e624 = local_98.inner[0];
    local_99 = static_cast<uint>(_e624);
    uint _e628 = local_98.inner[1];
    local_100 = static_cast<uint>(_e628);
    uint _e631 = local_100;
    output_1[_e631] = static_cast<uint>(as_type<int>(as_type<uint>(_e588) + as_type<uint>(_e607)));
    bytes_6 = int {};
    element_4 = int {};
    value_4 = type_9 {};
    value_4.inner[0] = 5u;
    value_4.inner[1] = 0u;
    bytes_6 = 8;
    element_4 = 4;
    int _e647 = bytes_6;
    int _e648 = element_4;
    local_43 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e647) + as_type<uint>(_e648))) + as_type<uint>(0));
    int _e653 = local_43;
    type_9 _e655 = output;
    local_41 = _e655;
    local_42 = static_cast<uint>(base + 16u);
    type_9 _e661 = local_41;
    local_101 = _e661;
    uint _e663 = local_42;
    uint _e665 = local_101.inner[1];
    local_101.inner[1] = _e665 + _e663;
    uint _e669 = local_101.inner[0];
    local_102 = static_cast<uint>(_e669);
    uint _e673 = local_101.inner[1];
    local_103 = static_cast<uint>(_e673);
    uint _e676 = local_103;
    output_1[_e676] = static_cast<uint>(_e653);
    bytes_7 = int {};
    row_1 = int {};
    value_5 = type_9 {};
    value_5.inner[0] = 6u;
    value_5.inner[1] = 0u;
    bytes_7 = 8;
    row_1 = 12;
    int _e692 = bytes_7;
    int _e693 = row_1;
    local_46 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e692) + as_type<uint>(_e693))) + as_type<uint>(0));
    int _e698 = local_46;
    type_9 _e700 = output;
    local_44 = _e700;
    local_45 = static_cast<uint>(base + 17u);
    type_9 _e706 = local_44;
    local_104 = _e706;
    uint _e708 = local_45;
    uint _e710 = local_104.inner[1];
    local_104.inner[1] = _e710 + _e708;
    uint _e714 = local_104.inner[0];
    local_105 = static_cast<uint>(_e714);
    uint _e718 = local_104.inner[1];
    local_106 = static_cast<uint>(_e718);
    uint _e721 = local_106;
    output_1[_e721] = static_cast<uint>(_e698);
    bytes_8 = int {};
    row_2 = int {};
    value_6 = type_9 {};
    value_6.inner[0] = 7u;
    value_6.inner[1] = 0u;
    bytes_8 = 8;
    row_2 = 12;
    int _e737 = bytes_8;
    int _e738 = row_2;
    local_49 = as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(_e737) + as_type<uint>(_e738))) + as_type<uint>(0));
    int _e743 = local_49;
    type_9 _e745 = output;
    local_47 = _e745;
    local_48 = static_cast<uint>(base + 18u);
    type_9 _e751 = local_47;
    local_107 = _e751;
    uint _e753 = local_48;
    uint _e755 = local_107.inner[1];
    local_107.inner[1] = _e755 + _e753;
    uint _e759 = local_107.inner[0];
    local_108 = static_cast<uint>(_e759);
    uint _e763 = local_107.inner[1];
    local_109 = static_cast<uint>(_e763);
    uint _e766 = local_109;
    output_1[_e766] = static_cast<uint>(_e743);
}
