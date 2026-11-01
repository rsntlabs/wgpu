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
    var f2_: vec2<f32>;
    var f3_: float3_;
    var f4_: vec4<f32>;
    var i2_: vec2<i32>;
    var i3_: int3_;
    var i4_: vec4<i32>;
    var u2_: vec2<u32>;
    var u3_: uint3_;
    var u4_: vec4<u32>;
    var frozen: float3_;
    var copied: float3_;
    var changed: int3_;
    var samples: array<float3_, 2>;
    var index: i32;
    var choose_first: bool;
    var local: f32;
    var local_1: f32;
    var local_2: float3_;
    var local_3: i32;
    var local_4: u32;
    var argument: i32;
    var captured: int3_;
    var local_5: u32;

    let seed = out[u32(0i)];
    f2_ = vec2<f32>(f32(seed), 1.5f);
    f3_ = float3_(1f, 2f, 3f);
    f4_ = vec4<f32>(f32(1i), f32(2i), f32(3i), f32(4i));
    i2_ = vec2<i32>(seed, -(2i));
    i3_ = int3_(1i, 2i, 3i);
    i4_ = vec4<i32>(1i, 2i, 3i, 4i);
    u2_ = vec2<u32>(u32(-(1i)), u32(2i));
    u3_ = uint3_(u32(1i), u32(2i), u32(3i));
    u4_ = vec4<u32>(u32(1i), u32(2i), u32(3i), u32(4i));
    let _e66 = f2_.x;
    let _e67 = f2_.y;
    out[u32(0i)] = i32((_e66 + _e67));
    let _e75 = f3_.x;
    let _e76 = f3_.y;
    let _e79 = f3_.z;
    out[u32(1i)] = i32(((_e75 + _e76) + _e79));
    let _e86 = f4_.w;
    out[u32(2i)] = i32(_e86);
    let _e93 = i2_.x;
    let _e94 = i2_.y;
    out[u32(3i)] = (_e93 + _e94);
    let _e100 = i3_.z;
    out[u32(4i)] = _e100;
    let _e106 = i4_.x;
    let _e107 = i4_.w;
    out[u32(5i)] = (_e106 + _e107);
    let _e113 = u2_.x;
    out[u32(6i)] = i32((_e113 == 4294967295u));
    let _e122 = u3_.x;
    let _e123 = u3_.z;
    out[u32(7i)] = i32((_e122 + _e123));
    let _e130 = u4_.w;
    out[u32(8i)] = i32(_e130);
    let _e135 = f3_;
    frozen = _e135;
    let _e137 = frozen;
    copied = _e137;
    copied.x = 9f;
    let _e142 = frozen.x;
    let _e146 = copied.x;
    out[u32(9i)] = i32(((_e142 * 10f) + _e146));
    let _e152 = i3_;
    let _e153 = bump(_e152);
    changed = _e153;
    let _e156 = changed.y;
    let _e160 = i3_.y;
    out[u32(10i)] = ((_e156 * 10i) + _e160);
    let _e165 = f3_;
    let _e166 = shift(_e165);
    out[u32(11i)] = i32(_e166.z);
    let _e172 = i2_;
    let _e173 = choose(_e172);
    let _e174 = u3_;
    let _e175 = choose_1(_e174);
    let _e177 = f4_;
    let _e178 = choose_2(_e177);
    out[u32(12i)] = ((_e173 + _e175) + _e178);
    let _e183 = f3_;
    samples[0i] = _e183;
    samples[1i] = float3_(f32(5i), f32(6i), f32(7i));
    index = 0i;
    let _e198 = index;
    index = (_e198 + 1i);
    let _e201 = index;
    let _e202 = index;
    index = (_e202 + 1i);
    let _e207 = samples[_e202].x;
    samples[_e202].x = (_e207 + f32(_e201));
    let _e210 = samples[_e202].x;
    out[u32(13i)] = i32(_e210);
    let _e215 = index;
    let _e221 = samples[0i].x;
    let _e229 = samples[1i].x;
    out[u32(14i)] = (((_e215 * 100i) + (i32(_e221) * 10i)) + i32(_e229));
    choose_first = false;
    let _e237 = choose_first;
    if _e237 {
        let _e241 = samples[0i].y;
        samples[0i].y = (_e241 + f32(1i));
        local = _e241;
    } else {
        let _e249 = samples[1i].y;
        samples[1i].y = (_e249 + f32(1i));
        local = _e249;
    }
    let _e255 = local;
    out[u32(15i)] = i32(_e255);
    let _e263 = samples[1i].y;
    out[u32(16i)] = i32(_e263);
    let _e268 = f3_;
    let _e269 = choose_first;
    if _e269 {
        samples[0i] = _e268;
        let _e273 = samples[0i].z;
        local_1 = _e273;
    } else {
        samples[1i] = _e268;
        let _e278 = samples[1i].z;
        local_1 = _e278;
    }
    let _e281 = local_1;
    out[u32(17i)] = i32(_e281);
    if true {
        local_2 = float3_(f32(7i), f32(8i), f32(9i));
    } else {
        let _e295 = f3_;
        local_2 = _e295;
    }
    let _e298 = local_2;
    out[u32(18i)] = i32(_e298.y);
    {
        local_3 = (seed + 2i);
        let _e307 = local_3;
        local_4 = u32(19i);
        let _e311 = local_4;
        local_5 = _e311;
        let _e313 = local_5;
        out[_e313] = _e307;
    }
    argument = 3i;
    let _e317 = argument;
    let _e318 = argument;
    argument = (_e318 + 1i);
    let _e321 = argument;
    captured = int3_(_e317, _e318, _e321);
    let _e325 = captured.x;
    let _e329 = captured.y;
    let _e334 = captured.z;
    out[u32(20i)] = (((_e325 * 100i) + (_e329 * 10i)) + _e334);
    let _e339 = argument;
    out[u32(21i)] = _e339;
    let _e343 = f3_;
    f3_.x = 9f;
    let _e347 = pair(_e343, 4i);
    out[u32(22i)] = _e347;
    let _e352 = f3_.x;
    out[u32(23i)] = i32(_e352);
}
