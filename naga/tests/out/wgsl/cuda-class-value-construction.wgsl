struct dim3_ {
    x: u32,
    y: u32,
    z: u32,
}

struct Leaf_cuda_record_0_ {
    values: array<u32, 2>,
    shape: dim3_,
}

struct Record_cuda_record_1_ {
    tag: u32,
    leaves: array<Leaf_cuda_record_0_, 2>,
    pair: vec2<i32>,
}

struct uint3_ {
    x: u32,
    y: u32,
    z: u32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

@compute @workgroup_size(1, 1, 1)
fn class_value_construction() {
    var pair_source: vec2<i32>;
    var pair_functional: vec2<i32>;
    var pair_named: vec2<i32>;
    var pair_c_style: vec2<i32>;
    var pair_empty: vec2<i32>;
    var triple_source: uint3_;
    var triple_functional: uint3_;
    var triple_named: uint3_;
    var triple_c_style: uint3_;
    var triple_empty: uint3_;
    var record_source: Record_cuda_record_1_;
    var record_functional: Record_cuda_record_1_;
    var record_named: Record_cuda_record_1_;
    var record_c_style: Record_cuda_record_1_;
    var record_empty: Record_cuda_record_1_;
    var local: array<Leaf_cuda_record_0_, 2>;
    var local_1: u32;
    var counter: u32;
    var first: Record_cuda_record_1_;
    var local_2: Record_cuda_record_1_;
    var second: Record_cuda_record_1_;
    var local_3: Record_cuda_record_1_;
    var third: Record_cuda_record_1_;
    var local_4: Record_cuda_record_1_;
    var fourth: Record_cuda_record_1_;
    var local_5: Record_cuda_record_1_;
    var first_snapshot: Record_cuda_record_1_;
    var effect_pair: vec2<i32>;
    var local_6: vec2<i32>;
    var local_7: Record_cuda_record_1_;
    var local_8: Record_cuda_record_1_;
    var local_9: Record_cuda_record_1_;
    var local_10: vec2<i32>;
    var local_11: vec2<i32>;
    var local_12: vec2<i32>;
    var local_13: uint3_;
    var local_14: uint3_;
    var local_15: uint3_;
    var value: Record_cuda_record_1_;
    var local_16: array<Leaf_cuda_record_0_, 2>;
    var local_17: u32;
    var value_1: Record_cuda_record_1_;
    var local_18: array<Leaf_cuda_record_0_, 2>;
    var local_19: u32;
    var value_2: Record_cuda_record_1_;
    var local_20: array<Leaf_cuda_record_0_, 2>;
    var local_21: u32;
    var value_3: Record_cuda_record_1_;
    var local_22: array<Leaf_cuda_record_0_, 2>;
    var local_23: u32;
    var value_4: vec2<i32>;
    var local_24: u32;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;

    pair_source.x = 61i;
    pair_source.y = 67i;
    let _e5 = pair_source;
    pair_functional = _e5;
    let _e7 = pair_source;
    pair_named = _e7;
    let _e9 = pair_source;
    pair_c_style = _e9;
    pair_empty = vec2<i32>();
    pair_functional.x = 71i;
    pair_named.y = 73i;
    pair_c_style.x = 79i;
    triple_source.x = 83u;
    triple_source.y = 89u;
    triple_source.z = 97u;
    let _e26 = triple_source;
    triple_functional = _e26;
    let _e28 = triple_source;
    triple_named = _e28;
    let _e30 = triple_source;
    triple_c_style = _e30;
    triple_empty = uint3_();
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
    record_source.pair.x = 41i;
    record_source.pair.y = 43i;
    let _e71 = record_source;
    record_functional = _e71;
    let _e73 = record_source;
    record_named = _e73;
    let _e75 = record_source;
    record_c_style = _e75;
    local_1 = 0u;
    loop {
        let _e85 = local_1;
        if (_e85 >= 2u) {
            break;
        }
        local[_e85] = Leaf_cuda_record_0_(array<u32, 2>(), dim3_(1u, 1u, 1u));
        continuing {
            let _e90 = local_1;
            local_1 = (_e90 + 1u);
        }
    }
    let _e94 = local;
    record_empty = Record_cuda_record_1_(u32(), _e94, vec2<i32>());
    record_functional.leaves[0i].values[0i] = 47u;
    record_named.leaves[1i].shape.y = 53u;
    record_c_style.leaves[0i].shape.x = 59u;
    counter = 0u;
    value = Record_cuda_record_1_();
    local_16 = array<Leaf_cuda_record_0_, 2>();
    local_17 = u32();
    let _e126 = counter;
    counter = (_e126 + u32(1i));
    local_17 = 0u;
    loop {
        let _e138 = local_17;
        if (_e138 >= 2u) {
            break;
        }
        local_16[_e138] = Leaf_cuda_record_0_(array<u32, 2>(), dim3_(1u, 1u, 1u));
        continuing {
            let _e143 = local_17;
            local_17 = (_e143 + 1u);
        }
    }
    let _e147 = local_16;
    value = Record_cuda_record_1_(u32(), _e147, vec2<i32>());
    let _e152 = counter;
    value.tag = _e152;
    let _e154 = counter;
    value.leaves[0i].values[0i] = (_e154 + 10u);
    let _e163 = value;
    local_2 = _e163;
    let _e165 = local_2;
    first = _e165;
    let _e167 = counter;
    counter = (_e167 + u32(1i));
    value_1 = Record_cuda_record_1_();
    local_18 = array<Leaf_cuda_record_0_, 2>();
    local_19 = u32();
    let _e177 = counter;
    counter = (_e177 + u32(1i));
    local_19 = 0u;
    loop {
        let _e189 = local_19;
        if (_e189 >= 2u) {
            break;
        }
        local_18[_e189] = Leaf_cuda_record_0_(array<u32, 2>(), dim3_(1u, 1u, 1u));
        continuing {
            let _e194 = local_19;
            local_19 = (_e194 + 1u);
        }
    }
    let _e198 = local_18;
    value_1 = Record_cuda_record_1_(u32(), _e198, vec2<i32>());
    let _e203 = counter;
    value_1.tag = _e203;
    let _e205 = counter;
    value_1.leaves[0i].values[0i] = (_e205 + 10u);
    let _e214 = value_1;
    local_3 = _e214;
    let _e216 = local_3;
    second = _e216;
    let _e218 = counter;
    counter = (_e218 + u32(1i));
    value_2 = Record_cuda_record_1_();
    local_20 = array<Leaf_cuda_record_0_, 2>();
    local_21 = u32();
    let _e228 = counter;
    counter = (_e228 + u32(1i));
    local_21 = 0u;
    loop {
        let _e240 = local_21;
        if (_e240 >= 2u) {
            break;
        }
        local_20[_e240] = Leaf_cuda_record_0_(array<u32, 2>(), dim3_(1u, 1u, 1u));
        continuing {
            let _e245 = local_21;
            local_21 = (_e245 + 1u);
        }
    }
    let _e249 = local_20;
    value_2 = Record_cuda_record_1_(u32(), _e249, vec2<i32>());
    let _e254 = counter;
    value_2.tag = _e254;
    let _e256 = counter;
    value_2.leaves[0i].values[0i] = (_e256 + 10u);
    let _e265 = value_2;
    local_4 = _e265;
    let _e267 = local_4;
    third = _e267;
    let _e269 = counter;
    counter = (_e269 + u32(1i));
    value_3 = Record_cuda_record_1_();
    local_22 = array<Leaf_cuda_record_0_, 2>();
    local_23 = u32();
    let _e279 = counter;
    counter = (_e279 + u32(1i));
    local_23 = 0u;
    loop {
        let _e291 = local_23;
        if (_e291 >= 2u) {
            break;
        }
        local_22[_e291] = Leaf_cuda_record_0_(array<u32, 2>(), dim3_(1u, 1u, 1u));
        continuing {
            let _e296 = local_23;
            local_23 = (_e296 + 1u);
        }
    }
    let _e300 = local_22;
    value_3 = Record_cuda_record_1_(u32(), _e300, vec2<i32>());
    let _e305 = counter;
    value_3.tag = _e305;
    let _e307 = counter;
    value_3.leaves[0i].values[0i] = (_e307 + 10u);
    let _e316 = value_3;
    local_5 = _e316;
    let _e318 = local_5;
    fourth = _e318;
    let _e320 = first;
    first_snapshot = _e320;
    first.tag = 109u;
    first.leaves[0i].values[0i] = 113u;
    let _e331 = counter;
    counter = (_e331 + u32(1i));
    value_4 = vec2<i32>();
    let _e337 = counter;
    counter = (_e337 + u32(1i));
    let _e341 = counter;
    value_4.x = i32(_e341);
    let _e345 = counter;
    value_4.y = i32((_e345 + 1u));
    let _e350 = value_4;
    local_6 = _e350;
    let _e352 = local_6;
    effect_pair = _e352;
    let _e355 = pair_source.x;
    output[u32(0i)] = u32(_e355);
    let _e362 = pair_functional.x;
    output[u32(1i)] = u32(_e362);
    let _e368 = pair_named.y;
    output[u32(2i)] = u32(_e368);
    let _e374 = pair_c_style.x;
    output[u32(3i)] = u32(_e374);
    let _e380 = pair_functional.y;
    output[u32(4i)] = u32(_e380);
    let _e387 = pair_empty.x;
    let _e388 = pair_empty.y;
    output[u32(5i)] = u32((_e387 + _e388));
    let _e395 = triple_source.y;
    output[u32(6i)] = _e395;
    let _e400 = triple_functional.x;
    output[u32(7i)] = _e400;
    let _e405 = triple_named.y;
    output[u32(8i)] = _e405;
    let _e410 = triple_c_style.z;
    output[u32(9i)] = _e410;
    let _e415 = triple_functional.z;
    output[u32(10i)] = _e415;
    let _e421 = triple_empty.x;
    let _e422 = triple_empty.y;
    let _e425 = triple_empty.z;
    output[u32(11i)] = ((_e421 + _e422) + _e425);
    let _e436 = record_source.leaves[0i].values[0i];
    output[u32(12i)] = _e436;
    let _e446 = record_functional.leaves[0i].values[0i];
    output[u32(13i)] = _e446;
    let _e455 = record_named.leaves[1i].shape.y;
    output[u32(14i)] = _e455;
    let _e464 = record_c_style.leaves[0i].shape.x;
    output[u32(15i)] = _e464;
    let _e473 = record_source.leaves[1i].shape.y;
    output[u32(16i)] = _e473;
    let _e479 = record_functional.pair.x;
    output[u32(17i)] = u32(_e479);
    let _e491 = record_empty.tag;
    let _e492 = record_empty.leaves[0i].values[0i];
    let _e500 = record_empty.leaves[0i].values[1i];
    let _e508 = record_empty.leaves[1i].values[0i];
    let _e516 = record_empty.leaves[1i].values[1i];
    let _e520 = record_empty.pair.x;
    let _e525 = record_empty.pair.y;
    output[u32(18i)] = ((((((_e491 + _e492) + _e500) + _e508) + _e516) + u32(_e520)) + u32(_e525));
    let _e541 = record_empty.leaves[0i].shape.x;
    let _e542 = record_empty.leaves[0i].shape.y;
    let _e549 = record_empty.leaves[0i].shape.z;
    let _e556 = record_empty.leaves[1i].shape.x;
    let _e563 = record_empty.leaves[1i].shape.y;
    let _e570 = record_empty.leaves[1i].shape.z;
    output[u32(19i)] = (((((_e541 + _e542) + _e549) + _e556) + _e563) + _e570);
    let _e576 = first_snapshot.tag;
    output[u32(20i)] = _e576;
    let _e581 = second.tag;
    output[u32(21i)] = _e581;
    let _e586 = third.tag;
    output[u32(22i)] = _e586;
    let _e591 = fourth.tag;
    output[u32(23i)] = _e591;
    let _e595 = counter;
    output[u32(24i)] = _e595;
    let _e605 = first_snapshot.leaves[0i].values[0i];
    output[u32(25i)] = _e605;
    let _e610 = first.tag;
    output[u32(26i)] = _e610;
    let _e620 = first.leaves[0i].values[0i];
    output[u32(27i)] = _e620;
    let _e625 = effect_pair.x;
    output[u32(28i)] = u32(_e625);
    let _e631 = effect_pair.y;
    output[u32(29i)] = u32(_e631);
    let _e636 = record_source;
    local_7 = _e636;
    local_24 = u32();
    local_24 = 13u;
    let _e642 = local_24;
    let _e643 = record_source;
    local_8 = _e643;
    local_25 = u32();
    local_25 = 13u;
    let _e649 = local_25;
    let _e651 = record_source;
    local_9 = _e651;
    local_26 = u32();
    local_26 = 13u;
    let _e657 = local_26;
    output[u32(30i)] = ((_e642 + _e649) + _e657);
    let _e662 = pair_source;
    local_10 = _e662;
    local_27 = u32();
    local_27 = 19u;
    let _e668 = local_27;
    let _e669 = pair_source;
    local_11 = _e669;
    local_28 = u32();
    local_28 = 19u;
    let _e675 = local_28;
    let _e677 = pair_source;
    local_12 = _e677;
    local_29 = u32();
    local_29 = 19u;
    let _e683 = local_29;
    output[u32(31i)] = ((_e668 + _e675) + _e683);
    let _e688 = triple_source;
    local_13 = _e688;
    local_30 = u32();
    local_30 = 29u;
    let _e694 = local_30;
    let _e695 = triple_source;
    local_14 = _e695;
    local_31 = u32();
    local_31 = 29u;
    let _e701 = local_31;
    let _e703 = triple_source;
    local_15 = _e703;
    local_32 = u32();
    local_32 = 29u;
    let _e709 = local_32;
    output[u32(32i)] = ((_e694 + _e701) + _e709);
    local_33 = u32();
    local_33 = 11u;
    let _e718 = local_33;
    local_34 = u32();
    local_34 = 17u;
    let _e723 = local_34;
    local_35 = u32();
    local_35 = 23u;
    let _e729 = local_35;
    output[u32(33i)] = ((_e718 + _e723) + _e729);
    let _e739 = record_empty.leaves[0i].shape.x;
    output[u32(34i)] = _e739;
    let _e748 = record_empty.leaves[1i].shape.z;
    output[u32(35i)] = _e748;
    let _e753 = record_source.tag;
    output[u32(36i)] = _e753;
    let _e759 = first_snapshot.pair.x;
    output[u32(37i)] = u32(_e759);
    let _e769 = second.leaves[1i].shape.z;
    output[u32(38i)] = _e769;
    let _e779 = third.leaves[0i].values[1i];
    output[u32(39i)] = _e779;
}
