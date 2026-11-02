#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct dim3_ {
    uint x;
    uint y;
    uint z;
};
struct Leaf_cuda_record_0_ {
    uint values[2];
    dim3_ shape;
};
struct Record_cuda_record_1_ {
    uint tag;
    Leaf_cuda_record_0_ leaves[2];
    ivec2 pair;
};
struct uint3_ {
    uint x;
    uint y;
    uint z;
};
layout(std430) buffer type_4_block_0Compute { uint _group_0_binding_0_cs[]; };


void main() {
    ivec2 pair_source = ivec2(0);
    ivec2 pair_functional = ivec2(0);
    ivec2 pair_named = ivec2(0);
    ivec2 pair_c_style = ivec2(0);
    ivec2 pair_empty = ivec2(0);
    uint3_ triple_source = uint3_(0u, 0u, 0u);
    uint3_ triple_functional = uint3_(0u, 0u, 0u);
    uint3_ triple_named = uint3_(0u, 0u, 0u);
    uint3_ triple_c_style = uint3_(0u, 0u, 0u);
    uint3_ triple_empty = uint3_(0u, 0u, 0u);
    Record_cuda_record_1_ record_source = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ record_functional = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ record_named = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ record_c_style = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ record_empty = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Leaf_cuda_record_0_ local[2] = Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)));
    uint local_1 = 0u;
    uint counter = 0u;
    Record_cuda_record_1_ first = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ local_2 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ second = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ local_3 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ third = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ local_4 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ fourth = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ local_5 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ first_snapshot = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    ivec2 effect_pair = ivec2(0);
    ivec2 local_6 = ivec2(0);
    Record_cuda_record_1_ local_7 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ local_8 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Record_cuda_record_1_ local_9 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    ivec2 local_10 = ivec2(0);
    ivec2 local_11 = ivec2(0);
    ivec2 local_12 = ivec2(0);
    uint3_ local_13 = uint3_(0u, 0u, 0u);
    uint3_ local_14 = uint3_(0u, 0u, 0u);
    uint3_ local_15 = uint3_(0u, 0u, 0u);
    Record_cuda_record_1_ value = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Leaf_cuda_record_0_ local_16[2] = Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)));
    uint local_17 = 0u;
    Record_cuda_record_1_ value_1 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Leaf_cuda_record_0_ local_18[2] = Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)));
    uint local_19 = 0u;
    Record_cuda_record_1_ value_2 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Leaf_cuda_record_0_ local_20[2] = Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)));
    uint local_21 = 0u;
    Record_cuda_record_1_ value_3 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    Leaf_cuda_record_0_ local_22[2] = Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)));
    uint local_23 = 0u;
    ivec2 value_4 = ivec2(0);
    uint local_24 = 0u;
    uint local_25 = 0u;
    uint local_26 = 0u;
    uint local_27 = 0u;
    uint local_28 = 0u;
    uint local_29 = 0u;
    uint local_30 = 0u;
    uint local_31 = 0u;
    uint local_32 = 0u;
    uint local_33 = 0u;
    uint local_34 = 0u;
    uint local_35 = 0u;
    pair_source.x = 61;
    pair_source.y = 67;
    ivec2 _e5 = pair_source;
    pair_functional = _e5;
    ivec2 _e7 = pair_source;
    pair_named = _e7;
    ivec2 _e9 = pair_source;
    pair_c_style = _e9;
    pair_empty = ivec2(0);
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
    triple_empty = uint3_(0u, 0u, 0u);
    triple_functional.x = 101u;
    triple_named.y = 103u;
    triple_c_style.z = 107u;
    record_source.tag = 3u;
    record_source.leaves[0].values[0] = 5u;
    record_source.leaves[0].values[1] = 7u;
    record_source.leaves[0].shape = dim3_(11u, 13u, 17u);
    record_source.leaves[1].values[0] = 19u;
    record_source.leaves[1].values[1] = 23u;
    record_source.leaves[1].shape = dim3_(29u, 31u, 37u);
    record_source.pair.x = 41;
    record_source.pair.y = 43;
    Record_cuda_record_1_ _e71 = record_source;
    record_functional = _e71;
    Record_cuda_record_1_ _e73 = record_source;
    record_named = _e73;
    Record_cuda_record_1_ _e75 = record_source;
    record_c_style = _e75;
    local_1 = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e90 = local_1;
            local_1 = (_e90 + 1u);
        }
        loop_init = false;
        uint _e85 = local_1;
        if ((_e85 >= 2u)) {
            break;
        }
        local[_e85] = Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(1u, 1u, 1u));
    }
    Leaf_cuda_record_0_ _e94[2] = local;
    record_empty = Record_cuda_record_1_(0u, _e94, ivec2(0));
    record_functional.leaves[0].values[0] = 47u;
    record_named.leaves[1].shape.y = 53u;
    record_c_style.leaves[0].shape.x = 59u;
    counter = 0u;
    value = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    local_16 = Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)));
    local_17 = 0u;
    uint _e126 = counter;
    counter = (_e126 + uint(1));
    local_17 = 0u;
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            uint _e143 = local_17;
            local_17 = (_e143 + 1u);
        }
        loop_init_1 = false;
        uint _e138 = local_17;
        if ((_e138 >= 2u)) {
            break;
        }
        local_16[_e138] = Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(1u, 1u, 1u));
    }
    Leaf_cuda_record_0_ _e147[2] = local_16;
    value = Record_cuda_record_1_(0u, _e147, ivec2(0));
    uint _e152 = counter;
    value.tag = _e152;
    uint _e154 = counter;
    value.leaves[0].values[0] = (_e154 + 10u);
    Record_cuda_record_1_ _e163 = value;
    local_2 = _e163;
    Record_cuda_record_1_ _e165 = local_2;
    first = _e165;
    uint _e167 = counter;
    counter = (_e167 + uint(1));
    value_1 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    local_18 = Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)));
    local_19 = 0u;
    uint _e177 = counter;
    counter = (_e177 + uint(1));
    local_19 = 0u;
    bool loop_init_2 = true;
    while(true) {
        if (!loop_init_2) {
            uint _e194 = local_19;
            local_19 = (_e194 + 1u);
        }
        loop_init_2 = false;
        uint _e189 = local_19;
        if ((_e189 >= 2u)) {
            break;
        }
        local_18[_e189] = Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(1u, 1u, 1u));
    }
    Leaf_cuda_record_0_ _e198[2] = local_18;
    value_1 = Record_cuda_record_1_(0u, _e198, ivec2(0));
    uint _e203 = counter;
    value_1.tag = _e203;
    uint _e205 = counter;
    value_1.leaves[0].values[0] = (_e205 + 10u);
    Record_cuda_record_1_ _e214 = value_1;
    local_3 = _e214;
    Record_cuda_record_1_ _e216 = local_3;
    second = _e216;
    uint _e218 = counter;
    counter = (_e218 + uint(1));
    value_2 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    local_20 = Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)));
    local_21 = 0u;
    uint _e228 = counter;
    counter = (_e228 + uint(1));
    local_21 = 0u;
    bool loop_init_3 = true;
    while(true) {
        if (!loop_init_3) {
            uint _e245 = local_21;
            local_21 = (_e245 + 1u);
        }
        loop_init_3 = false;
        uint _e240 = local_21;
        if ((_e240 >= 2u)) {
            break;
        }
        local_20[_e240] = Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(1u, 1u, 1u));
    }
    Leaf_cuda_record_0_ _e249[2] = local_20;
    value_2 = Record_cuda_record_1_(0u, _e249, ivec2(0));
    uint _e254 = counter;
    value_2.tag = _e254;
    uint _e256 = counter;
    value_2.leaves[0].values[0] = (_e256 + 10u);
    Record_cuda_record_1_ _e265 = value_2;
    local_4 = _e265;
    Record_cuda_record_1_ _e267 = local_4;
    third = _e267;
    uint _e269 = counter;
    counter = (_e269 + uint(1));
    value_3 = Record_cuda_record_1_(0u, Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u))), ivec2(0));
    local_22 = Leaf_cuda_record_0_[2](Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)), Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(0u, 0u, 0u)));
    local_23 = 0u;
    uint _e279 = counter;
    counter = (_e279 + uint(1));
    local_23 = 0u;
    bool loop_init_4 = true;
    while(true) {
        if (!loop_init_4) {
            uint _e296 = local_23;
            local_23 = (_e296 + 1u);
        }
        loop_init_4 = false;
        uint _e291 = local_23;
        if ((_e291 >= 2u)) {
            break;
        }
        local_22[_e291] = Leaf_cuda_record_0_(uint[2](0u, 0u), dim3_(1u, 1u, 1u));
    }
    Leaf_cuda_record_0_ _e300[2] = local_22;
    value_3 = Record_cuda_record_1_(0u, _e300, ivec2(0));
    uint _e305 = counter;
    value_3.tag = _e305;
    uint _e307 = counter;
    value_3.leaves[0].values[0] = (_e307 + 10u);
    Record_cuda_record_1_ _e316 = value_3;
    local_5 = _e316;
    Record_cuda_record_1_ _e318 = local_5;
    fourth = _e318;
    Record_cuda_record_1_ _e320 = first;
    first_snapshot = _e320;
    first.tag = 109u;
    first.leaves[0].values[0] = 113u;
    uint _e331 = counter;
    counter = (_e331 + uint(1));
    value_4 = ivec2(0);
    uint _e337 = counter;
    counter = (_e337 + uint(1));
    uint _e341 = counter;
    value_4.x = int(_e341);
    uint _e345 = counter;
    value_4.y = int((_e345 + 1u));
    ivec2 _e350 = value_4;
    local_6 = _e350;
    ivec2 _e352 = local_6;
    effect_pair = _e352;
    int _e355 = pair_source.x;
    _group_0_binding_0_cs[uint(0)] = uint(_e355);
    int _e362 = pair_functional.x;
    _group_0_binding_0_cs[uint(1)] = uint(_e362);
    int _e368 = pair_named.y;
    _group_0_binding_0_cs[uint(2)] = uint(_e368);
    int _e374 = pair_c_style.x;
    _group_0_binding_0_cs[uint(3)] = uint(_e374);
    int _e380 = pair_functional.y;
    _group_0_binding_0_cs[uint(4)] = uint(_e380);
    int _e387 = pair_empty.x;
    int _e388 = pair_empty.y;
    _group_0_binding_0_cs[uint(5)] = uint((_e387 + _e388));
    uint _e395 = triple_source.y;
    _group_0_binding_0_cs[uint(6)] = _e395;
    uint _e400 = triple_functional.x;
    _group_0_binding_0_cs[uint(7)] = _e400;
    uint _e405 = triple_named.y;
    _group_0_binding_0_cs[uint(8)] = _e405;
    uint _e410 = triple_c_style.z;
    _group_0_binding_0_cs[uint(9)] = _e410;
    uint _e415 = triple_functional.z;
    _group_0_binding_0_cs[uint(10)] = _e415;
    uint _e421 = triple_empty.x;
    uint _e422 = triple_empty.y;
    uint _e425 = triple_empty.z;
    _group_0_binding_0_cs[uint(11)] = ((_e421 + _e422) + _e425);
    uint _e436 = record_source.leaves[0].values[0];
    _group_0_binding_0_cs[uint(12)] = _e436;
    uint _e446 = record_functional.leaves[0].values[0];
    _group_0_binding_0_cs[uint(13)] = _e446;
    uint _e455 = record_named.leaves[1].shape.y;
    _group_0_binding_0_cs[uint(14)] = _e455;
    uint _e464 = record_c_style.leaves[0].shape.x;
    _group_0_binding_0_cs[uint(15)] = _e464;
    uint _e473 = record_source.leaves[1].shape.y;
    _group_0_binding_0_cs[uint(16)] = _e473;
    int _e479 = record_functional.pair.x;
    _group_0_binding_0_cs[uint(17)] = uint(_e479);
    uint _e491 = record_empty.tag;
    uint _e492 = record_empty.leaves[0].values[0];
    uint _e500 = record_empty.leaves[0].values[1];
    uint _e508 = record_empty.leaves[1].values[0];
    uint _e516 = record_empty.leaves[1].values[1];
    int _e520 = record_empty.pair.x;
    int _e525 = record_empty.pair.y;
    _group_0_binding_0_cs[uint(18)] = ((((((_e491 + _e492) + _e500) + _e508) + _e516) + uint(_e520)) + uint(_e525));
    uint _e541 = record_empty.leaves[0].shape.x;
    uint _e542 = record_empty.leaves[0].shape.y;
    uint _e549 = record_empty.leaves[0].shape.z;
    uint _e556 = record_empty.leaves[1].shape.x;
    uint _e563 = record_empty.leaves[1].shape.y;
    uint _e570 = record_empty.leaves[1].shape.z;
    _group_0_binding_0_cs[uint(19)] = (((((_e541 + _e542) + _e549) + _e556) + _e563) + _e570);
    uint _e576 = first_snapshot.tag;
    _group_0_binding_0_cs[uint(20)] = _e576;
    uint _e581 = second.tag;
    _group_0_binding_0_cs[uint(21)] = _e581;
    uint _e586 = third.tag;
    _group_0_binding_0_cs[uint(22)] = _e586;
    uint _e591 = fourth.tag;
    _group_0_binding_0_cs[uint(23)] = _e591;
    uint _e595 = counter;
    _group_0_binding_0_cs[uint(24)] = _e595;
    uint _e605 = first_snapshot.leaves[0].values[0];
    _group_0_binding_0_cs[uint(25)] = _e605;
    uint _e610 = first.tag;
    _group_0_binding_0_cs[uint(26)] = _e610;
    uint _e620 = first.leaves[0].values[0];
    _group_0_binding_0_cs[uint(27)] = _e620;
    int _e625 = effect_pair.x;
    _group_0_binding_0_cs[uint(28)] = uint(_e625);
    int _e631 = effect_pair.y;
    _group_0_binding_0_cs[uint(29)] = uint(_e631);
    Record_cuda_record_1_ _e636 = record_source;
    local_7 = _e636;
    local_24 = 0u;
    local_24 = 13u;
    uint _e642 = local_24;
    Record_cuda_record_1_ _e643 = record_source;
    local_8 = _e643;
    local_25 = 0u;
    local_25 = 13u;
    uint _e649 = local_25;
    Record_cuda_record_1_ _e651 = record_source;
    local_9 = _e651;
    local_26 = 0u;
    local_26 = 13u;
    uint _e657 = local_26;
    _group_0_binding_0_cs[uint(30)] = ((_e642 + _e649) + _e657);
    ivec2 _e662 = pair_source;
    local_10 = _e662;
    local_27 = 0u;
    local_27 = 19u;
    uint _e668 = local_27;
    ivec2 _e669 = pair_source;
    local_11 = _e669;
    local_28 = 0u;
    local_28 = 19u;
    uint _e675 = local_28;
    ivec2 _e677 = pair_source;
    local_12 = _e677;
    local_29 = 0u;
    local_29 = 19u;
    uint _e683 = local_29;
    _group_0_binding_0_cs[uint(31)] = ((_e668 + _e675) + _e683);
    uint3_ _e688 = triple_source;
    local_13 = _e688;
    local_30 = 0u;
    local_30 = 29u;
    uint _e694 = local_30;
    uint3_ _e695 = triple_source;
    local_14 = _e695;
    local_31 = 0u;
    local_31 = 29u;
    uint _e701 = local_31;
    uint3_ _e703 = triple_source;
    local_15 = _e703;
    local_32 = 0u;
    local_32 = 29u;
    uint _e709 = local_32;
    _group_0_binding_0_cs[uint(32)] = ((_e694 + _e701) + _e709);
    local_33 = 0u;
    local_33 = 11u;
    uint _e718 = local_33;
    local_34 = 0u;
    local_34 = 17u;
    uint _e723 = local_34;
    local_35 = 0u;
    local_35 = 23u;
    uint _e729 = local_35;
    _group_0_binding_0_cs[uint(33)] = ((_e718 + _e723) + _e729);
    uint _e739 = record_empty.leaves[0].shape.x;
    _group_0_binding_0_cs[uint(34)] = _e739;
    uint _e748 = record_empty.leaves[1].shape.z;
    _group_0_binding_0_cs[uint(35)] = _e748;
    uint _e753 = record_source.tag;
    _group_0_binding_0_cs[uint(36)] = _e753;
    int _e759 = first_snapshot.pair.x;
    _group_0_binding_0_cs[uint(37)] = uint(_e759);
    uint _e769 = second.leaves[1].shape.z;
    _group_0_binding_0_cs[uint(38)] = _e769;
    uint _e779 = third.leaves[0].values[1];
    _group_0_binding_0_cs[uint(39)] = _e779;
}

