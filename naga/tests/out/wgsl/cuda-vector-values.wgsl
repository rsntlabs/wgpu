struct uint3_ {
    x: u32,
    y: u32,
    z: u32,
}

struct int3_ {
    x: i32,
    y: i32,
    z: i32,
}

struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;

fn choose(value: vec2<i32>) -> i32 {
    var value_1: vec2<i32>;

    value_1 = value;
    let _e4 = value_1.x;
    let _e7 = value_1.y;
    return ((_e4 * 10i) + _e7);
}

fn choose_1(value_2: uint3_) -> i32 {
    var value_3: uint3_;

    value_3 = value_2;
    let _e3 = value_3.z;
    return i32(_e3);
}

fn choose_2(value_4: vec4<f32>) -> i32 {
    var value_5: vec4<f32>;

    value_5 = value_4;
    let _e3 = value_5.w;
    return i32(_e3);
}

fn bump(value_6: int3_) -> int3_ {
    var value_7: int3_;

    value_7 = value_6;
    let _e4 = value_7.y;
    value_7.y = (_e4 + 1i);
    let _e6 = value_7;
    return _e6;
}

fn shift(value_8: float3_) -> float3_ {
    var value_9: float3_;

    value_9 = value_8;
    let _e4 = value_9.x;
    value_9.x = (_e4 + 2f);
    let _e9 = value_9.x;
    let _e10 = value_9.y;
    value_9.z = (_e9 + _e10);
    let _e12 = value_9;
    return _e12;
}

fn pair(first: float3_, second: i32) -> i32 {
    var first_1: float3_;

    first_1 = first;
    let _e4 = first_1.x;
    return ((i32(_e4) * 10i) + second);
}

@compute @workgroup_size(1, 1, 1)
fn vector_values() {
    var local: u32;
    var f2_: vec2<f32>;
    var f3_: float3_;
    var f4_: vec4<f32>;
    var i2_: vec2<i32>;
    var i3_: int3_;
    var i4_: vec4<i32>;
    var u2_: vec2<u32>;
    var u3_: uint3_;
    var u4_: vec4<u32>;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var frozen: float3_;
    var copied: float3_;
    var local_10: u32;
    var changed: int3_;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var samples: array<float3_, 2>;
    var index: i32;
    var local_14: u32;
    var local_15: u32;
    var choose_first: bool;
    var local_16: u32;
    var local_17: f32;
    var local_18: u32;
    var local_19: u32;
    var local_20: f32;
    var local_21: u32;
    var local_22: float3_;
    var local_23: i32;
    var local_24: u32;
    var argument: i32;
    var captured: int3_;
    var local_25: u32;
    var local_26: u32;
    var local_27: u32;
    var local_28: u32;
    var local_29: i32;
    var local_30: u32;
    var local_31: i32;
    var local_32: u32;
    var local_33: u32;
    var local_34: u32;
    var local_35: u32;
    var local_36: u32;
    var local_37: u32;
    var local_38: u32;
    var local_39: u32;
    var local_40: u32;
    var local_41: u32;
    var local_42: u32;
    var local_43: u32;
    var local_44: u32;
    var local_45: u32;
    var local_46: u32;
    var local_47: u32;
    var local_48: u32;
    var local_49: u32;
    var local_50: u32;
    var local_51: u32;
    var local_52: u32;
    var local_53: u32;
    var local_54: u32;
    var local_55: u32;

    local = u32(0i);
    let _e3 = local;
    local_30 = u32(_e3);
    let _e6 = local_30;
    let _e9 = out[_e6];
    local_31 = _e9;
    let _e11 = local_31;
    local_29 = _e11;
    let seed = local_29;
    f2_ = vec2<f32>(f32(seed), 1.5f);
    f3_ = float3_(1f, 2f, 3f);
    f4_ = vec4<f32>(f32(1i), f32(2i), f32(3i), f32(4i));
    i2_ = vec2<i32>(seed, -(2i));
    i3_ = int3_(1i, 2i, 3i);
    i4_ = vec4<i32>(1i, 2i, 3i, 4i);
    u2_ = vec2<u32>(u32(-(1i)), u32(2i));
    u3_ = uint3_(u32(1i), u32(2i), u32(3i));
    u4_ = vec4<u32>(u32(1i), u32(2i), u32(3i), u32(4i));
    let _e75 = f2_.x;
    let _e76 = f2_.y;
    local_1 = u32(0i);
    let _e82 = local_1;
    local_32 = u32(_e82);
    let _e85 = local_32;
    out[_e85] = i32((_e75 + _e76));
    let _e89 = f3_.x;
    let _e90 = f3_.y;
    let _e93 = f3_.z;
    local_2 = u32(1i);
    let _e99 = local_2;
    local_33 = u32(_e99);
    let _e102 = local_33;
    out[_e102] = i32(((_e89 + _e90) + _e93));
    let _e105 = f4_.w;
    local_3 = u32(2i);
    let _e110 = local_3;
    local_34 = u32(_e110);
    let _e113 = local_34;
    out[_e113] = i32(_e105);
    let _e117 = i2_.x;
    let _e118 = i2_.y;
    local_4 = u32(3i);
    let _e123 = local_4;
    local_35 = u32(_e123);
    let _e126 = local_35;
    out[_e126] = (_e117 + _e118);
    let _e129 = i3_.z;
    local_5 = u32(4i);
    let _e133 = local_5;
    local_36 = u32(_e133);
    let _e136 = local_36;
    out[_e136] = _e129;
    let _e140 = i4_.x;
    let _e141 = i4_.w;
    local_6 = u32(5i);
    let _e146 = local_6;
    local_37 = u32(_e146);
    let _e149 = local_37;
    out[_e149] = (_e140 + _e141);
    let _e152 = u2_.x;
    local_7 = u32(6i);
    let _e159 = local_7;
    local_38 = u32(_e159);
    let _e162 = local_38;
    out[_e162] = i32((_e152 == 4294967295u));
    let _e166 = u3_.x;
    let _e167 = u3_.z;
    local_8 = u32(7i);
    let _e173 = local_8;
    local_39 = u32(_e173);
    let _e176 = local_39;
    out[_e176] = i32((_e166 + _e167));
    let _e179 = u4_.w;
    local_9 = u32(8i);
    let _e184 = local_9;
    local_40 = u32(_e184);
    let _e187 = local_40;
    out[_e187] = i32(_e179);
    let _e189 = f3_;
    frozen = _e189;
    let _e191 = frozen;
    copied = _e191;
    copied.x = 9f;
    let _e196 = frozen.x;
    let _e200 = copied.x;
    local_10 = u32(9i);
    let _e206 = local_10;
    local_41 = u32(_e206);
    let _e209 = local_41;
    out[_e209] = i32(((_e196 * 10f) + _e200));
    let _e211 = i3_;
    let _e212 = bump(_e211);
    changed = _e212;
    let _e215 = changed.y;
    let _e219 = i3_.y;
    local_11 = u32(10i);
    let _e224 = local_11;
    local_42 = u32(_e224);
    let _e227 = local_42;
    out[_e227] = ((_e215 * 10i) + _e219);
    let _e229 = f3_;
    let _e230 = shift(_e229);
    local_12 = u32(11i);
    let _e236 = local_12;
    local_43 = u32(_e236);
    let _e239 = local_43;
    out[_e239] = i32(_e230.z);
    let _e241 = i2_;
    let _e242 = choose(_e241);
    let _e243 = u3_;
    let _e244 = choose_1(_e243);
    let _e246 = f4_;
    let _e247 = choose_2(_e246);
    local_13 = u32(12i);
    let _e252 = local_13;
    local_44 = u32(_e252);
    let _e255 = local_44;
    out[_e255] = ((_e242 + _e244) + _e247);
    let _e257 = f3_;
    samples[0i] = _e257;
    samples[1i] = float3_(f32(5i), f32(6i), f32(7i));
    index = 0i;
    let _e272 = index;
    index = (_e272 + 1i);
    let _e275 = index;
    let _e276 = index;
    index = (_e276 + 1i);
    let _e281 = samples[_e276].x;
    samples[_e276].x = (_e281 + f32(_e275));
    let _e284 = samples[_e276].x;
    local_14 = u32(13i);
    let _e289 = local_14;
    local_45 = u32(_e289);
    let _e292 = local_45;
    out[_e292] = i32(_e284);
    let _e294 = index;
    let _e300 = samples[0i].x;
    let _e308 = samples[1i].x;
    local_15 = u32(14i);
    let _e314 = local_15;
    local_46 = u32(_e314);
    let _e317 = local_46;
    out[_e317] = (((_e294 * 100i) + (i32(_e300) * 10i)) + i32(_e308));
    choose_first = false;
    let _e321 = choose_first;
    if _e321 {
        let _e325 = samples[0i].y;
        samples[0i].y = (_e325 + f32(1i));
        local_17 = _e325;
    } else {
        let _e333 = samples[1i].y;
        samples[1i].y = (_e333 + f32(1i));
        local_17 = _e333;
    }
    let _e339 = local_17;
    local_16 = u32(15i);
    let _e344 = local_16;
    local_47 = u32(_e344);
    let _e347 = local_47;
    out[_e347] = i32(_e339);
    let _e352 = samples[1i].y;
    local_18 = u32(16i);
    let _e357 = local_18;
    local_48 = u32(_e357);
    let _e360 = local_48;
    out[_e360] = i32(_e352);
    let _e362 = f3_;
    let _e363 = choose_first;
    if _e363 {
        samples[0i] = _e362;
        let _e367 = samples[0i].z;
        local_20 = _e367;
    } else {
        samples[1i] = _e362;
        let _e372 = samples[1i].z;
        local_20 = _e372;
    }
    let _e375 = local_20;
    local_19 = u32(17i);
    let _e380 = local_19;
    local_49 = u32(_e380);
    let _e383 = local_49;
    out[_e383] = i32(_e375);
    if true {
        local_22 = float3_(f32(7i), f32(8i), f32(9i));
    } else {
        let _e394 = f3_;
        local_22 = _e394;
    }
    let _e397 = local_22;
    local_21 = u32(18i);
    let _e403 = local_21;
    local_50 = u32(_e403);
    let _e406 = local_50;
    out[_e406] = i32(_e397.y);
    {
        local_23 = (seed + 2i);
        let _e411 = local_23;
        local_24 = u32(19i);
        let _e415 = local_24;
        local_51 = u32(_e415);
        let _e418 = local_51;
        out[_e418] = _e411;
    }
    argument = 3i;
    let _e422 = argument;
    let _e423 = argument;
    argument = (_e423 + 1i);
    let _e426 = argument;
    captured = int3_(_e422, _e423, _e426);
    let _e430 = captured.x;
    let _e434 = captured.y;
    let _e439 = captured.z;
    local_25 = u32(20i);
    let _e444 = local_25;
    local_52 = u32(_e444);
    let _e447 = local_52;
    out[_e447] = (((_e430 * 100i) + (_e434 * 10i)) + _e439);
    let _e449 = argument;
    local_26 = u32(21i);
    let _e453 = local_26;
    local_53 = u32(_e453);
    let _e456 = local_53;
    out[_e456] = _e449;
    let _e458 = f3_;
    f3_.x = 9f;
    let _e462 = pair(_e458, 4i);
    local_27 = u32(22i);
    let _e466 = local_27;
    local_54 = u32(_e466);
    let _e469 = local_54;
    out[_e469] = _e462;
    let _e472 = f3_.x;
    local_28 = u32(23i);
    let _e477 = local_28;
    local_55 = u32(_e477);
    let _e480 = local_55;
    out[_e480] = i32(_e472);
}
