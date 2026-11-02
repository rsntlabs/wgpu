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
    int _pad2_0;
    int2 pair;
};

struct uint3_ {
    uint x;
    uint y;
    uint z;
};

RWByteAddressBuffer output : register(u0);

dim3_ Constructdim3_(uint arg0, uint arg1, uint arg2) {
    dim3_ ret = (dim3_)0;
    ret.x = arg0;
    ret.y = arg1;
    ret.z = arg2;
    return ret;
}

Leaf_cuda_record_0_ ConstructLeaf_cuda_record_0_(uint arg0[2], dim3_ arg1) {
    Leaf_cuda_record_0_ ret = (Leaf_cuda_record_0_)0;
    ret.values = arg0;
    ret.shape = arg1;
    return ret;
}

Record_cuda_record_1_ ConstructRecord_cuda_record_1_(uint arg0, Leaf_cuda_record_0_ arg1[2], int2 arg2) {
    Record_cuda_record_1_ ret = (Record_cuda_record_1_)0;
    ret.tag = arg0;
    ret.leaves = arg1;
    ret.pair = arg2;
    return ret;
}

int2 ZeroValueint2() {
    return (int2)0;
}

uint3_ ZeroValueuint3_() {
    return (uint3_)0;
}

typedef uint ret_ZeroValuearray2_uint_[2];
ret_ZeroValuearray2_uint_ ZeroValuearray2_uint_() {
    return (uint[2])0;
}

uint ZeroValueuint() {
    return (uint)0;
}

Record_cuda_record_1_ ZeroValueRecord_cuda_record_1_() {
    return (Record_cuda_record_1_)0;
}

typedef Leaf_cuda_record_0_ ret_ZeroValuearray2_Leaf_cuda_record_0__[2];
ret_ZeroValuearray2_Leaf_cuda_record_0__ ZeroValuearray2_Leaf_cuda_record_0__() {
    return (Leaf_cuda_record_0_[2])0;
}

[numthreads(1, 1, 1)]
void class_value_construction()
{
    int2 pair_source = (int2)0;
    int2 pair_functional = (int2)0;
    int2 pair_named = (int2)0;
    int2 pair_c_style = (int2)0;
    int2 pair_empty = (int2)0;
    uint3_ triple_source = (uint3_)0;
    uint3_ triple_functional = (uint3_)0;
    uint3_ triple_named = (uint3_)0;
    uint3_ triple_c_style = (uint3_)0;
    uint3_ triple_empty = (uint3_)0;
    Record_cuda_record_1_ record_source = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ record_functional = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ record_named = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ record_c_style = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ record_empty = (Record_cuda_record_1_)0;
    Leaf_cuda_record_0_ local[2] = (Leaf_cuda_record_0_[2])0;
    uint local_1 = (uint)0;
    uint counter = (uint)0;
    Record_cuda_record_1_ first = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ local_2 = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ second = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ local_3 = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ third = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ local_4 = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ fourth = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ local_5 = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ first_snapshot = (Record_cuda_record_1_)0;
    int2 effect_pair = (int2)0;
    int2 local_6 = (int2)0;
    Record_cuda_record_1_ local_7 = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ local_8 = (Record_cuda_record_1_)0;
    Record_cuda_record_1_ local_9 = (Record_cuda_record_1_)0;
    int2 local_10 = (int2)0;
    int2 local_11 = (int2)0;
    int2 local_12 = (int2)0;
    uint3_ local_13 = (uint3_)0;
    uint3_ local_14 = (uint3_)0;
    uint3_ local_15 = (uint3_)0;
    Record_cuda_record_1_ value = (Record_cuda_record_1_)0;
    Leaf_cuda_record_0_ local_16[2] = (Leaf_cuda_record_0_[2])0;
    uint local_17 = (uint)0;
    Record_cuda_record_1_ value_1 = (Record_cuda_record_1_)0;
    Leaf_cuda_record_0_ local_18[2] = (Leaf_cuda_record_0_[2])0;
    uint local_19 = (uint)0;
    Record_cuda_record_1_ value_2 = (Record_cuda_record_1_)0;
    Leaf_cuda_record_0_ local_20[2] = (Leaf_cuda_record_0_[2])0;
    uint local_21 = (uint)0;
    Record_cuda_record_1_ value_3 = (Record_cuda_record_1_)0;
    Leaf_cuda_record_0_ local_22[2] = (Leaf_cuda_record_0_[2])0;
    uint local_23 = (uint)0;
    int2 value_4 = (int2)0;
    uint local_24 = (uint)0;
    uint local_25 = (uint)0;
    uint local_26 = (uint)0;
    uint local_27 = (uint)0;
    uint local_28 = (uint)0;
    uint local_29 = (uint)0;
    uint local_30 = (uint)0;
    uint local_31 = (uint)0;
    uint local_32 = (uint)0;
    uint local_33 = (uint)0;
    uint local_34 = (uint)0;
    uint local_35 = (uint)0;

    pair_source.x = int(61);
    pair_source.y = int(67);
    int2 _e5 = pair_source;
    pair_functional = _e5;
    int2 _e7 = pair_source;
    pair_named = _e7;
    int2 _e9 = pair_source;
    pair_c_style = _e9;
    pair_empty = ZeroValueint2();
    pair_functional.x = int(71);
    pair_named.y = int(73);
    pair_c_style.x = int(79);
    triple_source.x = 83u;
    triple_source.y = 89u;
    triple_source.z = 97u;
    uint3_ _e26 = triple_source;
    triple_functional = _e26;
    uint3_ _e28 = triple_source;
    triple_named = _e28;
    uint3_ _e30 = triple_source;
    triple_c_style = _e30;
    triple_empty = ZeroValueuint3_();
    triple_functional.x = 101u;
    triple_named.y = 103u;
    triple_c_style.z = 107u;
    record_source.tag = 3u;
    record_source.leaves[0].values[0] = 5u;
    record_source.leaves[0].values[1] = 7u;
    record_source.leaves[0].shape = Constructdim3_(11u, 13u, 17u);
    record_source.leaves[1].values[0] = 19u;
    record_source.leaves[1].values[1] = 23u;
    record_source.leaves[1].shape = Constructdim3_(29u, 31u, 37u);
    record_source.pair.x = int(41);
    record_source.pair.y = int(43);
    Record_cuda_record_1_ _e71 = record_source;
    record_functional = _e71;
    Record_cuda_record_1_ _e73 = record_source;
    record_named = _e73;
    Record_cuda_record_1_ _e75 = record_source;
    record_c_style = _e75;
    local_1 = 0u;
    uint2 loop_bound = uint2(4294967295u, 4294967295u);
    bool loop_init = true;
    while(true) {
        if (all(loop_bound == uint2(0u, 0u))) { break; }
        loop_bound -= uint2(loop_bound.y == 0u, 1u);
        if (!loop_init) {
            uint _e90 = local_1;
            local_1 = (_e90 + 1u);
        }
        loop_init = false;
        uint _e85 = local_1;
        if ((_e85 >= 2u)) {
            break;
        }
        local[min(uint(_e85), 1u)] = ConstructLeaf_cuda_record_0_(ZeroValuearray2_uint_(), Constructdim3_(1u, 1u, 1u));
    }
    Leaf_cuda_record_0_ _e94[2] = local;
    record_empty = ConstructRecord_cuda_record_1_(ZeroValueuint(), _e94, ZeroValueint2());
    record_functional.leaves[int(0)].values[int(0)] = 47u;
    record_named.leaves[int(1)].shape.y = 53u;
    record_c_style.leaves[int(0)].shape.x = 59u;
    counter = 0u;
    value = ZeroValueRecord_cuda_record_1_();
    local_16 = ZeroValuearray2_Leaf_cuda_record_0__();
    local_17 = ZeroValueuint();
    uint _e126 = counter;
    counter = (_e126 + uint(int(1)));
    local_17 = 0u;
    uint2 loop_bound_1 = uint2(4294967295u, 4294967295u);
    bool loop_init_1 = true;
    while(true) {
        if (all(loop_bound_1 == uint2(0u, 0u))) { break; }
        loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
        if (!loop_init_1) {
            uint _e143 = local_17;
            local_17 = (_e143 + 1u);
        }
        loop_init_1 = false;
        uint _e138 = local_17;
        if ((_e138 >= 2u)) {
            break;
        }
        local_16[min(uint(_e138), 1u)] = ConstructLeaf_cuda_record_0_(ZeroValuearray2_uint_(), Constructdim3_(1u, 1u, 1u));
    }
    Leaf_cuda_record_0_ _e147[2] = local_16;
    value = ConstructRecord_cuda_record_1_(ZeroValueuint(), _e147, ZeroValueint2());
    uint _e152 = counter;
    value.tag = _e152;
    uint _e154 = counter;
    value.leaves[int(0)].values[int(0)] = (_e154 + 10u);
    Record_cuda_record_1_ _e163 = value;
    local_2 = _e163;
    Record_cuda_record_1_ _e165 = local_2;
    first = _e165;
    uint _e167 = counter;
    counter = (_e167 + uint(int(1)));
    value_1 = ZeroValueRecord_cuda_record_1_();
    local_18 = ZeroValuearray2_Leaf_cuda_record_0__();
    local_19 = ZeroValueuint();
    uint _e177 = counter;
    counter = (_e177 + uint(int(1)));
    local_19 = 0u;
    uint2 loop_bound_2 = uint2(4294967295u, 4294967295u);
    bool loop_init_2 = true;
    while(true) {
        if (all(loop_bound_2 == uint2(0u, 0u))) { break; }
        loop_bound_2 -= uint2(loop_bound_2.y == 0u, 1u);
        if (!loop_init_2) {
            uint _e194 = local_19;
            local_19 = (_e194 + 1u);
        }
        loop_init_2 = false;
        uint _e189 = local_19;
        if ((_e189 >= 2u)) {
            break;
        }
        local_18[min(uint(_e189), 1u)] = ConstructLeaf_cuda_record_0_(ZeroValuearray2_uint_(), Constructdim3_(1u, 1u, 1u));
    }
    Leaf_cuda_record_0_ _e198[2] = local_18;
    value_1 = ConstructRecord_cuda_record_1_(ZeroValueuint(), _e198, ZeroValueint2());
    uint _e203 = counter;
    value_1.tag = _e203;
    uint _e205 = counter;
    value_1.leaves[int(0)].values[int(0)] = (_e205 + 10u);
    Record_cuda_record_1_ _e214 = value_1;
    local_3 = _e214;
    Record_cuda_record_1_ _e216 = local_3;
    second = _e216;
    uint _e218 = counter;
    counter = (_e218 + uint(int(1)));
    value_2 = ZeroValueRecord_cuda_record_1_();
    local_20 = ZeroValuearray2_Leaf_cuda_record_0__();
    local_21 = ZeroValueuint();
    uint _e228 = counter;
    counter = (_e228 + uint(int(1)));
    local_21 = 0u;
    uint2 loop_bound_3 = uint2(4294967295u, 4294967295u);
    bool loop_init_3 = true;
    while(true) {
        if (all(loop_bound_3 == uint2(0u, 0u))) { break; }
        loop_bound_3 -= uint2(loop_bound_3.y == 0u, 1u);
        if (!loop_init_3) {
            uint _e245 = local_21;
            local_21 = (_e245 + 1u);
        }
        loop_init_3 = false;
        uint _e240 = local_21;
        if ((_e240 >= 2u)) {
            break;
        }
        local_20[min(uint(_e240), 1u)] = ConstructLeaf_cuda_record_0_(ZeroValuearray2_uint_(), Constructdim3_(1u, 1u, 1u));
    }
    Leaf_cuda_record_0_ _e249[2] = local_20;
    value_2 = ConstructRecord_cuda_record_1_(ZeroValueuint(), _e249, ZeroValueint2());
    uint _e254 = counter;
    value_2.tag = _e254;
    uint _e256 = counter;
    value_2.leaves[int(0)].values[int(0)] = (_e256 + 10u);
    Record_cuda_record_1_ _e265 = value_2;
    local_4 = _e265;
    Record_cuda_record_1_ _e267 = local_4;
    third = _e267;
    uint _e269 = counter;
    counter = (_e269 + uint(int(1)));
    value_3 = ZeroValueRecord_cuda_record_1_();
    local_22 = ZeroValuearray2_Leaf_cuda_record_0__();
    local_23 = ZeroValueuint();
    uint _e279 = counter;
    counter = (_e279 + uint(int(1)));
    local_23 = 0u;
    uint2 loop_bound_4 = uint2(4294967295u, 4294967295u);
    bool loop_init_4 = true;
    while(true) {
        if (all(loop_bound_4 == uint2(0u, 0u))) { break; }
        loop_bound_4 -= uint2(loop_bound_4.y == 0u, 1u);
        if (!loop_init_4) {
            uint _e296 = local_23;
            local_23 = (_e296 + 1u);
        }
        loop_init_4 = false;
        uint _e291 = local_23;
        if ((_e291 >= 2u)) {
            break;
        }
        local_22[min(uint(_e291), 1u)] = ConstructLeaf_cuda_record_0_(ZeroValuearray2_uint_(), Constructdim3_(1u, 1u, 1u));
    }
    Leaf_cuda_record_0_ _e300[2] = local_22;
    value_3 = ConstructRecord_cuda_record_1_(ZeroValueuint(), _e300, ZeroValueint2());
    uint _e305 = counter;
    value_3.tag = _e305;
    uint _e307 = counter;
    value_3.leaves[int(0)].values[int(0)] = (_e307 + 10u);
    Record_cuda_record_1_ _e316 = value_3;
    local_5 = _e316;
    Record_cuda_record_1_ _e318 = local_5;
    fourth = _e318;
    Record_cuda_record_1_ _e320 = first;
    first_snapshot = _e320;
    first.tag = 109u;
    first.leaves[int(0)].values[int(0)] = 113u;
    uint _e331 = counter;
    counter = (_e331 + uint(int(1)));
    value_4 = ZeroValueint2();
    uint _e337 = counter;
    counter = (_e337 + uint(int(1)));
    uint _e341 = counter;
    value_4.x = int(_e341);
    uint _e345 = counter;
    value_4.y = int((_e345 + 1u));
    int2 _e350 = value_4;
    local_6 = _e350;
    int2 _e352 = local_6;
    effect_pair = _e352;
    int _e355 = pair_source.x;
    output.Store(uint(int(0))*4, asuint(uint(_e355)));
    int _e362 = pair_functional.x;
    output.Store(uint(int(1))*4, asuint(uint(_e362)));
    int _e368 = pair_named.y;
    output.Store(uint(int(2))*4, asuint(uint(_e368)));
    int _e374 = pair_c_style.x;
    output.Store(uint(int(3))*4, asuint(uint(_e374)));
    int _e380 = pair_functional.y;
    output.Store(uint(int(4))*4, asuint(uint(_e380)));
    int _e387 = pair_empty.x;
    int _e388 = pair_empty.y;
    output.Store(uint(int(5))*4, asuint(uint(asint(asuint(_e387) + asuint(_e388)))));
    uint _e395 = triple_source.y;
    output.Store(uint(int(6))*4, asuint(_e395));
    uint _e400 = triple_functional.x;
    output.Store(uint(int(7))*4, asuint(_e400));
    uint _e405 = triple_named.y;
    output.Store(uint(int(8))*4, asuint(_e405));
    uint _e410 = triple_c_style.z;
    output.Store(uint(int(9))*4, asuint(_e410));
    uint _e415 = triple_functional.z;
    output.Store(uint(int(10))*4, asuint(_e415));
    uint _e421 = triple_empty.x;
    uint _e422 = triple_empty.y;
    uint _e425 = triple_empty.z;
    output.Store(uint(int(11))*4, asuint(((_e421 + _e422) + _e425)));
    uint _e436 = record_source.leaves[int(0)].values[int(0)];
    output.Store(uint(int(12))*4, asuint(_e436));
    uint _e446 = record_functional.leaves[int(0)].values[int(0)];
    output.Store(uint(int(13))*4, asuint(_e446));
    uint _e455 = record_named.leaves[int(1)].shape.y;
    output.Store(uint(int(14))*4, asuint(_e455));
    uint _e464 = record_c_style.leaves[int(0)].shape.x;
    output.Store(uint(int(15))*4, asuint(_e464));
    uint _e473 = record_source.leaves[int(1)].shape.y;
    output.Store(uint(int(16))*4, asuint(_e473));
    int _e479 = record_functional.pair.x;
    output.Store(uint(int(17))*4, asuint(uint(_e479)));
    uint _e491 = record_empty.tag;
    uint _e492 = record_empty.leaves[int(0)].values[int(0)];
    uint _e500 = record_empty.leaves[int(0)].values[int(1)];
    uint _e508 = record_empty.leaves[int(1)].values[int(0)];
    uint _e516 = record_empty.leaves[int(1)].values[int(1)];
    int _e520 = record_empty.pair.x;
    int _e525 = record_empty.pair.y;
    output.Store(uint(int(18))*4, asuint(((((((_e491 + _e492) + _e500) + _e508) + _e516) + uint(_e520)) + uint(_e525))));
    uint _e541 = record_empty.leaves[int(0)].shape.x;
    uint _e542 = record_empty.leaves[int(0)].shape.y;
    uint _e549 = record_empty.leaves[int(0)].shape.z;
    uint _e556 = record_empty.leaves[int(1)].shape.x;
    uint _e563 = record_empty.leaves[int(1)].shape.y;
    uint _e570 = record_empty.leaves[int(1)].shape.z;
    output.Store(uint(int(19))*4, asuint((((((_e541 + _e542) + _e549) + _e556) + _e563) + _e570)));
    uint _e576 = first_snapshot.tag;
    output.Store(uint(int(20))*4, asuint(_e576));
    uint _e581 = second.tag;
    output.Store(uint(int(21))*4, asuint(_e581));
    uint _e586 = third.tag;
    output.Store(uint(int(22))*4, asuint(_e586));
    uint _e591 = fourth.tag;
    output.Store(uint(int(23))*4, asuint(_e591));
    uint _e595 = counter;
    output.Store(uint(int(24))*4, asuint(_e595));
    uint _e605 = first_snapshot.leaves[int(0)].values[int(0)];
    output.Store(uint(int(25))*4, asuint(_e605));
    uint _e610 = first.tag;
    output.Store(uint(int(26))*4, asuint(_e610));
    uint _e620 = first.leaves[int(0)].values[int(0)];
    output.Store(uint(int(27))*4, asuint(_e620));
    int _e625 = effect_pair.x;
    output.Store(uint(int(28))*4, asuint(uint(_e625)));
    int _e631 = effect_pair.y;
    output.Store(uint(int(29))*4, asuint(uint(_e631)));
    Record_cuda_record_1_ _e636 = record_source;
    local_7 = _e636;
    local_24 = ZeroValueuint();
    local_24 = 13u;
    uint _e642 = local_24;
    Record_cuda_record_1_ _e643 = record_source;
    local_8 = _e643;
    local_25 = ZeroValueuint();
    local_25 = 13u;
    uint _e649 = local_25;
    Record_cuda_record_1_ _e651 = record_source;
    local_9 = _e651;
    local_26 = ZeroValueuint();
    local_26 = 13u;
    uint _e657 = local_26;
    output.Store(uint(int(30))*4, asuint(((_e642 + _e649) + _e657)));
    int2 _e662 = pair_source;
    local_10 = _e662;
    local_27 = ZeroValueuint();
    local_27 = 19u;
    uint _e668 = local_27;
    int2 _e669 = pair_source;
    local_11 = _e669;
    local_28 = ZeroValueuint();
    local_28 = 19u;
    uint _e675 = local_28;
    int2 _e677 = pair_source;
    local_12 = _e677;
    local_29 = ZeroValueuint();
    local_29 = 19u;
    uint _e683 = local_29;
    output.Store(uint(int(31))*4, asuint(((_e668 + _e675) + _e683)));
    uint3_ _e688 = triple_source;
    local_13 = _e688;
    local_30 = ZeroValueuint();
    local_30 = 29u;
    uint _e694 = local_30;
    uint3_ _e695 = triple_source;
    local_14 = _e695;
    local_31 = ZeroValueuint();
    local_31 = 29u;
    uint _e701 = local_31;
    uint3_ _e703 = triple_source;
    local_15 = _e703;
    local_32 = ZeroValueuint();
    local_32 = 29u;
    uint _e709 = local_32;
    output.Store(uint(int(32))*4, asuint(((_e694 + _e701) + _e709)));
    local_33 = ZeroValueuint();
    local_33 = 11u;
    uint _e718 = local_33;
    local_34 = ZeroValueuint();
    local_34 = 17u;
    uint _e723 = local_34;
    local_35 = ZeroValueuint();
    local_35 = 23u;
    uint _e729 = local_35;
    output.Store(uint(int(33))*4, asuint(((_e718 + _e723) + _e729)));
    uint _e739 = record_empty.leaves[int(0)].shape.x;
    output.Store(uint(int(34))*4, asuint(_e739));
    uint _e748 = record_empty.leaves[int(1)].shape.z;
    output.Store(uint(int(35))*4, asuint(_e748));
    uint _e753 = record_source.tag;
    output.Store(uint(int(36))*4, asuint(_e753));
    int _e759 = first_snapshot.pair.x;
    output.Store(uint(int(37))*4, asuint(uint(_e759)));
    uint _e769 = second.leaves[int(1)].shape.z;
    output.Store(uint(int(38))*4, asuint(_e769));
    uint _e779 = third.leaves[int(0)].values[int(1)];
    output.Store(uint(int(39))*4, asuint(_e779));
}
