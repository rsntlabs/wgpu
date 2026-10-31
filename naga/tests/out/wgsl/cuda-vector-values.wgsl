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
    var local_29: u32;
    var local_30: u32;
    var local_31: u32;
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

    local = u32(0i);
    let _e3 = local;
    local_29 = u32(_e3);
    let _e6 = local_29;
    let seed = out[_e6];
    f2_ = vec2<f32>(f32(seed), 1.5f);
    f3_ = float3_(1f, 2f, 3f);
    f4_ = vec4<f32>(f32(1i), f32(2i), f32(3i), f32(4i));
    i2_ = vec2<i32>(seed, -(2i));
    i3_ = int3_(1i, 2i, 3i);
    i4_ = vec4<i32>(1i, 2i, 3i, 4i);
    u2_ = vec2<u32>(u32(-(1i)), u32(2i));
    u3_ = uint3_(u32(1i), u32(2i), u32(3i));
    u4_ = vec4<u32>(u32(1i), u32(2i), u32(3i), u32(4i));
    let _e71 = f2_.x;
    let _e72 = f2_.y;
    local_1 = u32(0i);
    let _e78 = local_1;
    local_30 = u32(_e78);
    let _e81 = local_30;
    out[_e81] = i32((_e71 + _e72));
    let _e85 = f3_.x;
    let _e86 = f3_.y;
    let _e89 = f3_.z;
    local_2 = u32(1i);
    let _e95 = local_2;
    local_31 = u32(_e95);
    let _e98 = local_31;
    out[_e98] = i32(((_e85 + _e86) + _e89));
    let _e101 = f4_.w;
    local_3 = u32(2i);
    let _e106 = local_3;
    local_32 = u32(_e106);
    let _e109 = local_32;
    out[_e109] = i32(_e101);
    let _e113 = i2_.x;
    let _e114 = i2_.y;
    local_4 = u32(3i);
    let _e119 = local_4;
    local_33 = u32(_e119);
    let _e122 = local_33;
    out[_e122] = (_e113 + _e114);
    let _e125 = i3_.z;
    local_5 = u32(4i);
    let _e129 = local_5;
    local_34 = u32(_e129);
    let _e132 = local_34;
    out[_e132] = _e125;
    let _e136 = i4_.x;
    let _e137 = i4_.w;
    local_6 = u32(5i);
    let _e142 = local_6;
    local_35 = u32(_e142);
    let _e145 = local_35;
    out[_e145] = (_e136 + _e137);
    let _e148 = u2_.x;
    local_7 = u32(6i);
    let _e155 = local_7;
    local_36 = u32(_e155);
    let _e158 = local_36;
    out[_e158] = i32((_e148 == 4294967295u));
    let _e162 = u3_.x;
    let _e163 = u3_.z;
    local_8 = u32(7i);
    let _e169 = local_8;
    local_37 = u32(_e169);
    let _e172 = local_37;
    out[_e172] = i32((_e162 + _e163));
    let _e175 = u4_.w;
    local_9 = u32(8i);
    let _e180 = local_9;
    local_38 = u32(_e180);
    let _e183 = local_38;
    out[_e183] = i32(_e175);
    let _e185 = f3_;
    frozen = _e185;
    let _e187 = frozen;
    copied = _e187;
    copied.x = 9f;
    let _e192 = frozen.x;
    let _e196 = copied.x;
    local_10 = u32(9i);
    let _e202 = local_10;
    local_39 = u32(_e202);
    let _e205 = local_39;
    out[_e205] = i32(((_e192 * 10f) + _e196));
    let _e207 = i3_;
    let _e208 = bump(_e207);
    changed = _e208;
    let _e211 = changed.y;
    let _e215 = i3_.y;
    local_11 = u32(10i);
    let _e220 = local_11;
    local_40 = u32(_e220);
    let _e223 = local_40;
    out[_e223] = ((_e211 * 10i) + _e215);
    let _e225 = f3_;
    let _e226 = shift(_e225);
    local_12 = u32(11i);
    let _e232 = local_12;
    local_41 = u32(_e232);
    let _e235 = local_41;
    out[_e235] = i32(_e226.z);
    let _e237 = i2_;
    let _e238 = choose(_e237);
    let _e239 = u3_;
    let _e240 = choose_1(_e239);
    let _e242 = f4_;
    let _e243 = choose_2(_e242);
    local_13 = u32(12i);
    let _e248 = local_13;
    local_42 = u32(_e248);
    let _e251 = local_42;
    out[_e251] = ((_e238 + _e240) + _e243);
    let _e253 = f3_;
    samples[0i] = _e253;
    samples[1i] = float3_(f32(5i), f32(6i), f32(7i));
    index = 0i;
    let _e268 = index;
    index = (_e268 + 1i);
    let _e271 = index;
    let _e272 = index;
    index = (_e272 + 1i);
    let _e277 = samples[_e272].x;
    samples[_e272].x = (_e277 + f32(_e271));
    let _e280 = samples[_e272].x;
    local_14 = u32(13i);
    let _e285 = local_14;
    local_43 = u32(_e285);
    let _e288 = local_43;
    out[_e288] = i32(_e280);
    let _e290 = index;
    let _e296 = samples[0i].x;
    let _e304 = samples[1i].x;
    local_15 = u32(14i);
    let _e310 = local_15;
    local_44 = u32(_e310);
    let _e313 = local_44;
    out[_e313] = (((_e290 * 100i) + (i32(_e296) * 10i)) + i32(_e304));
    choose_first = false;
    let _e317 = choose_first;
    if _e317 {
        let _e321 = samples[0i].y;
        samples[0i].y = (_e321 + f32(1i));
        local_17 = _e321;
    } else {
        let _e329 = samples[1i].y;
        samples[1i].y = (_e329 + f32(1i));
        local_17 = _e329;
    }
    let _e335 = local_17;
    local_16 = u32(15i);
    let _e340 = local_16;
    local_45 = u32(_e340);
    let _e343 = local_45;
    out[_e343] = i32(_e335);
    let _e348 = samples[1i].y;
    local_18 = u32(16i);
    let _e353 = local_18;
    local_46 = u32(_e353);
    let _e356 = local_46;
    out[_e356] = i32(_e348);
    let _e358 = f3_;
    let _e359 = choose_first;
    if _e359 {
        samples[0i] = _e358;
        let _e363 = samples[0i].z;
        local_20 = _e363;
    } else {
        samples[1i] = _e358;
        let _e368 = samples[1i].z;
        local_20 = _e368;
    }
    let _e371 = local_20;
    local_19 = u32(17i);
    let _e376 = local_19;
    local_47 = u32(_e376);
    let _e379 = local_47;
    out[_e379] = i32(_e371);
    if true {
        local_22 = float3_(f32(7i), f32(8i), f32(9i));
    } else {
        let _e390 = f3_;
        local_22 = _e390;
    }
    let _e393 = local_22;
    local_21 = u32(18i);
    let _e399 = local_21;
    local_48 = u32(_e399);
    let _e402 = local_48;
    out[_e402] = i32(_e393.y);
    {
        local_23 = (seed + 2i);
        let _e407 = local_23;
        local_24 = u32(19i);
        let _e411 = local_24;
        local_49 = u32(_e411);
        let _e414 = local_49;
        out[_e414] = _e407;
    }
    argument = 3i;
    let _e418 = argument;
    let _e419 = argument;
    argument = (_e419 + 1i);
    let _e422 = argument;
    captured = int3_(_e418, _e419, _e422);
    let _e426 = captured.x;
    let _e430 = captured.y;
    let _e435 = captured.z;
    local_25 = u32(20i);
    let _e440 = local_25;
    local_50 = u32(_e440);
    let _e443 = local_50;
    out[_e443] = (((_e426 * 100i) + (_e430 * 10i)) + _e435);
    let _e445 = argument;
    local_26 = u32(21i);
    let _e449 = local_26;
    local_51 = u32(_e449);
    let _e452 = local_51;
    out[_e452] = _e445;
    let _e454 = f3_;
    f3_.x = 9f;
    let _e458 = pair(_e454, 4i);
    local_27 = u32(22i);
    let _e462 = local_27;
    local_52 = u32(_e462);
    let _e465 = local_52;
    out[_e465] = _e458;
    let _e468 = f3_.x;
    local_28 = u32(23i);
    let _e473 = local_28;
    local_53 = u32(_e473);
    let _e476 = local_53;
    out[_e476] = i32(_e468);
}
