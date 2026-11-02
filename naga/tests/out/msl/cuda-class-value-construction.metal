// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct type_1 {
    uint inner[2];
};
struct dim3_ {
    uint x;
    uint y;
    uint z;
};
struct Leaf_cuda_record_0_ {
    type_1 values;
    dim3_ shape;
};
struct type_2 {
    Leaf_cuda_record_0_ inner[2];
};
struct Record_cuda_record_1_ {
    uint tag;
    type_2 leaves;
    char _pad2[4];
    metal::int2 pair;
};
struct uint3_ {
    uint x;
    uint y;
    uint z;
};
typedef uint type_4[1];

kernel void class_value_construction(
  device type_4& output [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::int2 pair_source = {};
    metal::int2 pair_functional = {};
    metal::int2 pair_named = {};
    metal::int2 pair_c_style = {};
    metal::int2 pair_empty = {};
    uint3_ triple_source = {};
    uint3_ triple_functional = {};
    uint3_ triple_named = {};
    uint3_ triple_c_style = {};
    uint3_ triple_empty = {};
    Record_cuda_record_1_ record_source = {};
    Record_cuda_record_1_ record_functional = {};
    Record_cuda_record_1_ record_named = {};
    Record_cuda_record_1_ record_c_style = {};
    Record_cuda_record_1_ record_empty = {};
    type_2 local = {};
    uint local_1 = {};
    uint counter = {};
    Record_cuda_record_1_ first = {};
    Record_cuda_record_1_ local_2 = {};
    Record_cuda_record_1_ second = {};
    Record_cuda_record_1_ local_3 = {};
    Record_cuda_record_1_ third = {};
    Record_cuda_record_1_ local_4 = {};
    Record_cuda_record_1_ fourth = {};
    Record_cuda_record_1_ local_5 = {};
    Record_cuda_record_1_ first_snapshot = {};
    metal::int2 effect_pair = {};
    metal::int2 local_6 = {};
    Record_cuda_record_1_ local_7 = {};
    Record_cuda_record_1_ local_8 = {};
    Record_cuda_record_1_ local_9 = {};
    metal::int2 local_10 = {};
    metal::int2 local_11 = {};
    metal::int2 local_12 = {};
    uint3_ local_13 = {};
    uint3_ local_14 = {};
    uint3_ local_15 = {};
    Record_cuda_record_1_ value = {};
    type_2 local_16 = {};
    uint local_17 = {};
    Record_cuda_record_1_ value_1 = {};
    type_2 local_18 = {};
    uint local_19 = {};
    Record_cuda_record_1_ value_2 = {};
    type_2 local_20 = {};
    uint local_21 = {};
    Record_cuda_record_1_ value_3 = {};
    type_2 local_22 = {};
    uint local_23 = {};
    metal::int2 value_4 = {};
    uint local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    pair_source.x = 61;
    pair_source.y = 67;
    metal::int2 _e5 = pair_source;
    pair_functional = _e5;
    metal::int2 _e7 = pair_source;
    pair_named = _e7;
    metal::int2 _e9 = pair_source;
    pair_c_style = _e9;
    pair_empty = metal::int2 {};
    pair_functional.x = 71;
    pair_named.y = 73;
    pair_c_style.x = 79;
    triple_source.x = 83u;
    triple_source.y = 89u;
    triple_source.z = 97u;
    uint3_ _e26 = triple_source;
    triple_functional = _e26;
    uint3_ _e28 = triple_source;
    triple_named = _e28;
    uint3_ _e30 = triple_source;
    triple_c_style = _e30;
    triple_empty = uint3_ {};
    triple_functional.x = 101u;
    triple_named.y = 103u;
    triple_c_style.z = 107u;
    record_source.tag = 3u;
    record_source.leaves.inner[0].values.inner[0] = 5u;
    record_source.leaves.inner[0].values.inner[1] = 7u;
    record_source.leaves.inner[0].shape = dim3_ {11u, 13u, 17u};
    record_source.leaves.inner[1].values.inner[0] = 19u;
    record_source.leaves.inner[1].values.inner[1] = 23u;
    record_source.leaves.inner[1].shape = dim3_ {29u, 31u, 37u};
    record_source.pair.x = 41;
    record_source.pair.y = 43;
    Record_cuda_record_1_ _e71 = record_source;
    record_functional = _e71;
    Record_cuda_record_1_ _e73 = record_source;
    record_named = _e73;
    Record_cuda_record_1_ _e75 = record_source;
    record_c_style = _e75;
    local_1 = 0u;
    uint2 loop_bound = uint2(4294967295u);
    bool loop_init = true;
    while(true) {
        if (metal::all(loop_bound == uint2(0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e90 = local_1;
            local_1 = _e90 + 1u;
        }
        loop_init = false;
        uint _e85 = local_1;
        if (_e85 >= 2u) {
            break;
        }
        local.inner[_e85] = Leaf_cuda_record_0_ {type_1 {}, dim3_ {1u, 1u, 1u}};
    }
    type_2 _e94 = local;
    record_empty = Record_cuda_record_1_ {uint {}, _e94, {}, metal::int2 {}};
    record_functional.leaves.inner[0].values.inner[0] = 47u;
    record_named.leaves.inner[1].shape.y = 53u;
    record_c_style.leaves.inner[0].shape.x = 59u;
    counter = 0u;
    value = Record_cuda_record_1_ {};
    local_16 = type_2 {};
    local_17 = uint {};
    uint _e126 = counter;
    counter = _e126 + static_cast<uint>(1);
    local_17 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (metal::all(loop_bound_1 == uint2(0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e143 = local_17;
            local_17 = _e143 + 1u;
        }
        loop_init_1 = false;
        uint _e138 = local_17;
        if (_e138 >= 2u) {
            break;
        }
        local_16.inner[_e138] = Leaf_cuda_record_0_ {type_1 {}, dim3_ {1u, 1u, 1u}};
    }
    type_2 _e147 = local_16;
    value = Record_cuda_record_1_ {uint {}, _e147, {}, metal::int2 {}};
    uint _e152 = counter;
    value.tag = _e152;
    uint _e154 = counter;
    value.leaves.inner[0].values.inner[0] = _e154 + 10u;
    Record_cuda_record_1_ _e163 = value;
    local_2 = _e163;
    Record_cuda_record_1_ _e165 = local_2;
    first = _e165;
    uint _e167 = counter;
    counter = _e167 + static_cast<uint>(1);
    value_1 = Record_cuda_record_1_ {};
    local_18 = type_2 {};
    local_19 = uint {};
    uint _e177 = counter;
    counter = _e177 + static_cast<uint>(1);
    local_19 = 0u;
    uint2 loop_bound_2 = uint2(4294967295u);
    bool loop_init_2 = true;
    while(true) {
        if (metal::all(loop_bound_2 == uint2(0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_2) {
            uint _e194 = local_19;
            local_19 = _e194 + 1u;
        }
        loop_init_2 = false;
        uint _e189 = local_19;
        if (_e189 >= 2u) {
            break;
        }
        local_18.inner[_e189] = Leaf_cuda_record_0_ {type_1 {}, dim3_ {1u, 1u, 1u}};
    }
    type_2 _e198 = local_18;
    value_1 = Record_cuda_record_1_ {uint {}, _e198, {}, metal::int2 {}};
    uint _e203 = counter;
    value_1.tag = _e203;
    uint _e205 = counter;
    value_1.leaves.inner[0].values.inner[0] = _e205 + 10u;
    Record_cuda_record_1_ _e214 = value_1;
    local_3 = _e214;
    Record_cuda_record_1_ _e216 = local_3;
    second = _e216;
    uint _e218 = counter;
    counter = _e218 + static_cast<uint>(1);
    value_2 = Record_cuda_record_1_ {};
    local_20 = type_2 {};
    local_21 = uint {};
    uint _e228 = counter;
    counter = _e228 + static_cast<uint>(1);
    local_21 = 0u;
    uint2 loop_bound_3 = uint2(4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (metal::all(loop_bound_3 == uint2(0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e245 = local_21;
            local_21 = _e245 + 1u;
        }
        loop_init_3 = false;
        uint _e240 = local_21;
        if (_e240 >= 2u) {
            break;
        }
        local_20.inner[_e240] = Leaf_cuda_record_0_ {type_1 {}, dim3_ {1u, 1u, 1u}};
    }
    type_2 _e249 = local_20;
    value_2 = Record_cuda_record_1_ {uint {}, _e249, {}, metal::int2 {}};
    uint _e254 = counter;
    value_2.tag = _e254;
    uint _e256 = counter;
    value_2.leaves.inner[0].values.inner[0] = _e256 + 10u;
    Record_cuda_record_1_ _e265 = value_2;
    local_4 = _e265;
    Record_cuda_record_1_ _e267 = local_4;
    third = _e267;
    uint _e269 = counter;
    counter = _e269 + static_cast<uint>(1);
    value_3 = Record_cuda_record_1_ {};
    local_22 = type_2 {};
    local_23 = uint {};
    uint _e279 = counter;
    counter = _e279 + static_cast<uint>(1);
    local_23 = 0u;
    uint2 loop_bound_4 = uint2(4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (metal::all(loop_bound_4 == uint2(0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e296 = local_23;
            local_23 = _e296 + 1u;
        }
        loop_init_4 = false;
        uint _e291 = local_23;
        if (_e291 >= 2u) {
            break;
        }
        local_22.inner[_e291] = Leaf_cuda_record_0_ {type_1 {}, dim3_ {1u, 1u, 1u}};
    }
    type_2 _e300 = local_22;
    value_3 = Record_cuda_record_1_ {uint {}, _e300, {}, metal::int2 {}};
    uint _e305 = counter;
    value_3.tag = _e305;
    uint _e307 = counter;
    value_3.leaves.inner[0].values.inner[0] = _e307 + 10u;
    Record_cuda_record_1_ _e316 = value_3;
    local_5 = _e316;
    Record_cuda_record_1_ _e318 = local_5;
    fourth = _e318;
    Record_cuda_record_1_ _e320 = first;
    first_snapshot = _e320;
    first.tag = 109u;
    first.leaves.inner[0].values.inner[0] = 113u;
    uint _e331 = counter;
    counter = _e331 + static_cast<uint>(1);
    value_4 = metal::int2 {};
    uint _e337 = counter;
    counter = _e337 + static_cast<uint>(1);
    uint _e341 = counter;
    value_4.x = static_cast<int>(_e341);
    uint _e345 = counter;
    value_4.y = static_cast<int>(_e345 + 1u);
    metal::int2 _e350 = value_4;
    local_6 = _e350;
    metal::int2 _e352 = local_6;
    effect_pair = _e352;
    int _e355 = pair_source.x;
    output[static_cast<uint>(0)] = static_cast<uint>(_e355);
    int _e362 = pair_functional.x;
    output[static_cast<uint>(1)] = static_cast<uint>(_e362);
    int _e368 = pair_named.y;
    output[static_cast<uint>(2)] = static_cast<uint>(_e368);
    int _e374 = pair_c_style.x;
    output[static_cast<uint>(3)] = static_cast<uint>(_e374);
    int _e380 = pair_functional.y;
    output[static_cast<uint>(4)] = static_cast<uint>(_e380);
    int _e387 = pair_empty.x;
    int _e388 = pair_empty.y;
    output[static_cast<uint>(5)] = static_cast<uint>(as_type<int>(as_type<uint>(_e387) + as_type<uint>(_e388)));
    uint _e395 = triple_source.y;
    output[static_cast<uint>(6)] = _e395;
    uint _e400 = triple_functional.x;
    output[static_cast<uint>(7)] = _e400;
    uint _e405 = triple_named.y;
    output[static_cast<uint>(8)] = _e405;
    uint _e410 = triple_c_style.z;
    output[static_cast<uint>(9)] = _e410;
    uint _e415 = triple_functional.z;
    output[static_cast<uint>(10)] = _e415;
    uint _e421 = triple_empty.x;
    uint _e422 = triple_empty.y;
    uint _e425 = triple_empty.z;
    output[static_cast<uint>(11)] = (_e421 + _e422) + _e425;
    uint _e436 = record_source.leaves.inner[0].values.inner[0];
    output[static_cast<uint>(12)] = _e436;
    uint _e446 = record_functional.leaves.inner[0].values.inner[0];
    output[static_cast<uint>(13)] = _e446;
    uint _e455 = record_named.leaves.inner[1].shape.y;
    output[static_cast<uint>(14)] = _e455;
    uint _e464 = record_c_style.leaves.inner[0].shape.x;
    output[static_cast<uint>(15)] = _e464;
    uint _e473 = record_source.leaves.inner[1].shape.y;
    output[static_cast<uint>(16)] = _e473;
    int _e479 = record_functional.pair.x;
    output[static_cast<uint>(17)] = static_cast<uint>(_e479);
    uint _e491 = record_empty.tag;
    uint _e492 = record_empty.leaves.inner[0].values.inner[0];
    uint _e500 = record_empty.leaves.inner[0].values.inner[1];
    uint _e508 = record_empty.leaves.inner[1].values.inner[0];
    uint _e516 = record_empty.leaves.inner[1].values.inner[1];
    int _e520 = record_empty.pair.x;
    int _e525 = record_empty.pair.y;
    output[static_cast<uint>(18)] = (((((_e491 + _e492) + _e500) + _e508) + _e516) + static_cast<uint>(_e520)) + static_cast<uint>(_e525);
    uint _e541 = record_empty.leaves.inner[0].shape.x;
    uint _e542 = record_empty.leaves.inner[0].shape.y;
    uint _e549 = record_empty.leaves.inner[0].shape.z;
    uint _e556 = record_empty.leaves.inner[1].shape.x;
    uint _e563 = record_empty.leaves.inner[1].shape.y;
    uint _e570 = record_empty.leaves.inner[1].shape.z;
    output[static_cast<uint>(19)] = ((((_e541 + _e542) + _e549) + _e556) + _e563) + _e570;
    uint _e576 = first_snapshot.tag;
    output[static_cast<uint>(20)] = _e576;
    uint _e581 = second.tag;
    output[static_cast<uint>(21)] = _e581;
    uint _e586 = third.tag;
    output[static_cast<uint>(22)] = _e586;
    uint _e591 = fourth.tag;
    output[static_cast<uint>(23)] = _e591;
    uint _e595 = counter;
    output[static_cast<uint>(24)] = _e595;
    uint _e605 = first_snapshot.leaves.inner[0].values.inner[0];
    output[static_cast<uint>(25)] = _e605;
    uint _e610 = first.tag;
    output[static_cast<uint>(26)] = _e610;
    uint _e620 = first.leaves.inner[0].values.inner[0];
    output[static_cast<uint>(27)] = _e620;
    int _e625 = effect_pair.x;
    output[static_cast<uint>(28)] = static_cast<uint>(_e625);
    int _e631 = effect_pair.y;
    output[static_cast<uint>(29)] = static_cast<uint>(_e631);
    Record_cuda_record_1_ _e636 = record_source;
    local_7 = _e636;
    local_24 = uint {};
    local_24 = 13u;
    uint _e642 = local_24;
    Record_cuda_record_1_ _e643 = record_source;
    local_8 = _e643;
    local_25 = uint {};
    local_25 = 13u;
    uint _e649 = local_25;
    Record_cuda_record_1_ _e651 = record_source;
    local_9 = _e651;
    local_26 = uint {};
    local_26 = 13u;
    uint _e657 = local_26;
    output[static_cast<uint>(30)] = (_e642 + _e649) + _e657;
    metal::int2 _e662 = pair_source;
    local_10 = _e662;
    local_27 = uint {};
    local_27 = 19u;
    uint _e668 = local_27;
    metal::int2 _e669 = pair_source;
    local_11 = _e669;
    local_28 = uint {};
    local_28 = 19u;
    uint _e675 = local_28;
    metal::int2 _e677 = pair_source;
    local_12 = _e677;
    local_29 = uint {};
    local_29 = 19u;
    uint _e683 = local_29;
    output[static_cast<uint>(31)] = (_e668 + _e675) + _e683;
    uint3_ _e688 = triple_source;
    local_13 = _e688;
    local_30 = uint {};
    local_30 = 29u;
    uint _e694 = local_30;
    uint3_ _e695 = triple_source;
    local_14 = _e695;
    local_31 = uint {};
    local_31 = 29u;
    uint _e701 = local_31;
    uint3_ _e703 = triple_source;
    local_15 = _e703;
    local_32 = uint {};
    local_32 = 29u;
    uint _e709 = local_32;
    output[static_cast<uint>(32)] = (_e694 + _e701) + _e709;
    local_33 = uint {};
    local_33 = 11u;
    uint _e718 = local_33;
    local_34 = uint {};
    local_34 = 17u;
    uint _e723 = local_34;
    local_35 = uint {};
    local_35 = 23u;
    uint _e729 = local_35;
    output[static_cast<uint>(33)] = (_e718 + _e723) + _e729;
    uint _e739 = record_empty.leaves.inner[0].shape.x;
    output[static_cast<uint>(34)] = _e739;
    uint _e748 = record_empty.leaves.inner[1].shape.z;
    output[static_cast<uint>(35)] = _e748;
    uint _e753 = record_source.tag;
    output[static_cast<uint>(36)] = _e753;
    int _e759 = first_snapshot.pair.x;
    output[static_cast<uint>(37)] = static_cast<uint>(_e759);
    uint _e769 = second.leaves.inner[1].shape.z;
    output[static_cast<uint>(38)] = _e769;
    uint _e779 = third.leaves.inner[0].values.inner[1];
    output[static_cast<uint>(39)] = _e779;
}
