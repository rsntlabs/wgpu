struct type_5 {
    value: vec2<i32>,
}

struct type_7 {
    value: vec2<u32>,
}

struct type_9 {
    value: vec2<f32>,
}

struct type_10 {
    value: vec4<i32>,
}

struct type_12 {
    value: vec4<u32>,
}

struct type_14 {
    value: vec4<f32>,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<uniform> signed2_1: type_5;
@group(0) @binding(2)
var<uniform> unsigned2_1: type_7;
@group(0) @binding(3)
var<uniform> real2_1: type_9;
@group(0) @binding(4)
var<uniform> signed4_1: type_10;
@group(0) @binding(5)
var<uniform> unsigned4_1: type_12;
@group(0) @binding(6)
var<uniform> real4_1: type_14;

fn sum_pair(value: vec4<i32>) -> i32 {
    var value_1: vec4<i32>;

    value_1 = value;
    let _e4 = value_1.x;
    let _e5 = value_1.y;
    return (_e4 + _e5);
}

@compute @workgroup_size(4, 1, 1)
fn vector_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var signed2_: vec2<i32>;
    var unsigned2_: vec2<u32>;
    var real2_: vec2<f32>;
    var signed4_: vec4<i32>;
    var unsigned4_: vec4<u32>;
    var real4_: vec4<f32>;
    var original_signed: vec2<i32>;
    var original_real: vec2<f32>;
    var original_unsigned: vec4<u32>;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;

    let _e4 = signed2_1.value;
    signed2_ = _e4;
    let _e8 = unsigned2_1.value;
    unsigned2_ = _e8;
    let _e12 = real2_1.value;
    real2_ = _e12;
    let _e16 = signed4_1.value;
    signed4_ = _e16;
    let _e20 = unsigned4_1.value;
    unsigned4_ = _e20;
    let _e24 = real4_1.value;
    real4_ = _e24;
    let lane = (threadIdx.x + (blockIdx.x * 4u));
    if (lane >= 4u) {
        return;
    }
    let base = (4u + (lane * 12u));
    let _e37 = signed2_;
    original_signed = _e37;
    let _e39 = real2_;
    original_real = _e39;
    let _e41 = unsigned4_;
    original_unsigned = _e41;
    let _e45 = signed2_.x;
    signed2_.x = (_e45 + i32(lane));
    let _e49 = signed2_.y;
    signed2_.y = (_e49 - i32(lane));
    let _e52 = unsigned2_.x;
    unsigned2_.x = (_e52 + lane);
    let _e55 = unsigned2_.y;
    unsigned2_.y = (_e55 + 2u);
    let _e60 = real2_.x;
    real2_.x = (_e60 + f32(lane));
    let _e63 = real2_.y;
    real2_.y = (_e63 * 2f);
    let _e67 = signed4_.x;
    let _e69 = signed4_.y;
    let _e72 = signed4_.z;
    let _e74 = signed4_;
    let _e75 = sum_pair(_e74);
    signed4_ = vec4<i32>(_e67, _e69, (_e72 + i32(lane)), _e75);
    let _e78 = unsigned4_.y;
    unsigned4_.x = (_e78 + 1u);
    let _e83 = unsigned4_.w;
    unsigned4_.w = (_e83 + lane);
    let _e86 = signed2_.x;
    output[base] = u32((_e86 + 10i));
    let _e93 = signed2_.y;
    local = u32((base + 1u));
    let _e99 = local;
    output[_e99] = u32(_e93);
    let _e103 = unsigned2_.x;
    let _e104 = unsigned2_.y;
    local_1 = u32((base + 2u));
    let _e110 = local_1;
    output[_e110] = (_e103 + _e104);
    let _e113 = real2_.x;
    local_2 = u32((base + 3u));
    let _e119 = local_2;
    output[_e119] = bitcast<u32>(_e113);
    let _e122 = real2_.y;
    local_3 = u32((base + 4u));
    let _e128 = local_3;
    output[_e128] = bitcast<u32>(_e122);
    let _e131 = signed4_.z;
    local_4 = u32((base + 5u));
    let _e139 = local_4;
    output[_e139] = u32((_e131 + 10i));
    let _e142 = signed4_.w;
    local_5 = u32((base + 6u));
    let _e148 = local_5;
    output[_e148] = u32(_e142);
    let _e152 = unsigned4_.x;
    let _e153 = unsigned4_.w;
    local_6 = u32((base + 7u));
    let _e159 = local_6;
    output[_e159] = (_e152 + _e153);
    let _e163 = real4_.x;
    let _e164 = real4_.y;
    let _e167 = real4_.z;
    let _e170 = real4_.w;
    local_7 = u32((base + 8u));
    let _e177 = local_7;
    output[_e177] = bitcast<u32>((((_e163 + _e164) + _e167) + _e170));
    let _e180 = original_signed.x;
    local_8 = u32((base + 9u));
    let _e188 = local_8;
    output[_e188] = u32((_e180 + 10i));
    let _e191 = original_real.x;
    local_9 = u32((base + 10u));
    let _e197 = local_9;
    output[_e197] = bitcast<u32>(_e191);
    let _e201 = original_unsigned.x;
    let _e202 = original_unsigned.w;
    local_10 = u32((base + 11u));
    let _e208 = local_10;
    output[_e208] = (_e201 + _e202);
}
