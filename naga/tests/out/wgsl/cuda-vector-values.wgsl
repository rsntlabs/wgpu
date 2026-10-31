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

    local = u32(0i);
    let _e3 = local;
    let seed = out[_e3];
    f2_ = vec2<f32>(f32(seed), 1.5f);
    f3_ = float3_(1f, 2f, 3f);
    f4_ = vec4<f32>(f32(1i), f32(2i), f32(3i), f32(4i));
    i2_ = vec2<i32>(seed, -(2i));
    i3_ = int3_(1i, 2i, 3i);
    i4_ = vec4<i32>(1i, 2i, 3i, 4i);
    u2_ = vec2<u32>(u32(-(1i)), u32(2i));
    u3_ = uint3_(u32(1i), u32(2i), u32(3i));
    u4_ = vec4<u32>(u32(1i), u32(2i), u32(3i), u32(4i));
    let _e68 = f2_.x;
    let _e69 = f2_.y;
    local_1 = u32(0i);
    let _e75 = local_1;
    out[_e75] = i32((_e68 + _e69));
    let _e79 = f3_.x;
    let _e80 = f3_.y;
    let _e83 = f3_.z;
    local_2 = u32(1i);
    let _e89 = local_2;
    out[_e89] = i32(((_e79 + _e80) + _e83));
    let _e92 = f4_.w;
    local_3 = u32(2i);
    let _e97 = local_3;
    out[_e97] = i32(_e92);
    let _e101 = i2_.x;
    let _e102 = i2_.y;
    local_4 = u32(3i);
    let _e107 = local_4;
    out[_e107] = (_e101 + _e102);
    let _e110 = i3_.z;
    local_5 = u32(4i);
    let _e114 = local_5;
    out[_e114] = _e110;
    let _e118 = i4_.x;
    let _e119 = i4_.w;
    local_6 = u32(5i);
    let _e124 = local_6;
    out[_e124] = (_e118 + _e119);
    let _e127 = u2_.x;
    local_7 = u32(6i);
    let _e134 = local_7;
    out[_e134] = i32((_e127 == 4294967295u));
    let _e138 = u3_.x;
    let _e139 = u3_.z;
    local_8 = u32(7i);
    let _e145 = local_8;
    out[_e145] = i32((_e138 + _e139));
    let _e148 = u4_.w;
    local_9 = u32(8i);
    let _e153 = local_9;
    out[_e153] = i32(_e148);
    let _e155 = f3_;
    frozen = _e155;
    let _e157 = frozen;
    copied = _e157;
    copied.x = 9f;
    let _e162 = frozen.x;
    let _e166 = copied.x;
    local_10 = u32(9i);
    let _e172 = local_10;
    out[_e172] = i32(((_e162 * 10f) + _e166));
    let _e174 = i3_;
    let _e175 = bump(_e174);
    changed = _e175;
    let _e178 = changed.y;
    let _e182 = i3_.y;
    local_11 = u32(10i);
    let _e187 = local_11;
    out[_e187] = ((_e178 * 10i) + _e182);
    let _e189 = f3_;
    let _e190 = shift(_e189);
    local_12 = u32(11i);
    let _e196 = local_12;
    out[_e196] = i32(_e190.z);
    let _e198 = i2_;
    let _e199 = choose(_e198);
    let _e200 = u3_;
    let _e201 = choose_1(_e200);
    let _e203 = f4_;
    let _e204 = choose_2(_e203);
    local_13 = u32(12i);
    let _e209 = local_13;
    out[_e209] = ((_e199 + _e201) + _e204);
    let _e211 = f3_;
    samples[0i] = _e211;
    samples[1i] = float3_(f32(5i), f32(6i), f32(7i));
    index = 0i;
    let _e226 = index;
    index = (_e226 + 1i);
    let _e229 = index;
    let _e230 = index;
    index = (_e230 + 1i);
    let _e235 = samples[_e230].x;
    samples[_e230].x = (_e235 + f32(_e229));
    let _e238 = samples[_e230].x;
    local_14 = u32(13i);
    let _e243 = local_14;
    out[_e243] = i32(_e238);
    let _e245 = index;
    let _e251 = samples[0i].x;
    let _e259 = samples[1i].x;
    local_15 = u32(14i);
    let _e265 = local_15;
    out[_e265] = (((_e245 * 100i) + (i32(_e251) * 10i)) + i32(_e259));
    choose_first = false;
    let _e269 = choose_first;
    if _e269 {
        let _e273 = samples[0i].y;
        samples[0i].y = (_e273 + f32(1i));
        local_17 = _e273;
    } else {
        let _e281 = samples[1i].y;
        samples[1i].y = (_e281 + f32(1i));
        local_17 = _e281;
    }
    let _e287 = local_17;
    local_16 = u32(15i);
    let _e292 = local_16;
    out[_e292] = i32(_e287);
    let _e297 = samples[1i].y;
    local_18 = u32(16i);
    let _e302 = local_18;
    out[_e302] = i32(_e297);
    let _e304 = f3_;
    let _e305 = choose_first;
    if _e305 {
        samples[0i] = _e304;
        let _e309 = samples[0i].z;
        local_20 = _e309;
    } else {
        samples[1i] = _e304;
        let _e314 = samples[1i].z;
        local_20 = _e314;
    }
    let _e317 = local_20;
    local_19 = u32(17i);
    let _e322 = local_19;
    out[_e322] = i32(_e317);
    if true {
        local_22 = float3_(f32(7i), f32(8i), f32(9i));
    } else {
        let _e333 = f3_;
        local_22 = _e333;
    }
    let _e336 = local_22;
    local_21 = u32(18i);
    let _e342 = local_21;
    out[_e342] = i32(_e336.y);
    {
        local_23 = (seed + 2i);
        let _e347 = local_23;
        local_24 = u32(19i);
        let _e351 = local_24;
        local_29 = _e351;
        let _e353 = local_29;
        out[_e353] = _e347;
    }
    argument = 3i;
    let _e357 = argument;
    let _e358 = argument;
    argument = (_e358 + 1i);
    let _e361 = argument;
    captured = int3_(_e357, _e358, _e361);
    let _e365 = captured.x;
    let _e369 = captured.y;
    let _e374 = captured.z;
    local_25 = u32(20i);
    let _e379 = local_25;
    out[_e379] = (((_e365 * 100i) + (_e369 * 10i)) + _e374);
    let _e381 = argument;
    local_26 = u32(21i);
    let _e385 = local_26;
    out[_e385] = _e381;
    let _e387 = f3_;
    f3_.x = 9f;
    let _e391 = pair(_e387, 4i);
    local_27 = u32(22i);
    let _e395 = local_27;
    out[_e395] = _e391;
    let _e398 = f3_.x;
    local_28 = u32(23i);
    let _e403 = local_28;
    out[_e403] = i32(_e398);
}
