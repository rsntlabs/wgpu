struct int3_ {
    x: i32,
    y: i32,
    z: i32,
}

struct int1_ {
    x: i32,
}

struct type_3 {
    value: int1_,
}

struct uint1_ {
    x: u32,
}

struct type_4 {
    value: uint1_,
}

struct float1_ {
    x: f32,
}

struct type_6 {
    value: float1_,
}

struct type_7 {
    value: int3_,
}

struct uint3_ {
    x: u32,
    y: u32,
    z: u32,
}

struct type_8 {
    value: uint3_,
}

struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

struct type_9 {
    value: float3_,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<uniform> signed1_1: type_3;
@group(0) @binding(2)
var<uniform> unsigned1_1: type_4;
@group(0) @binding(3)
var<uniform> real1_1: type_6;
@group(0) @binding(4)
var<uniform> signed3_1: type_7;
@group(0) @binding(5)
var<uniform> unsigned3_1: type_8;
@group(0) @binding(6)
var<uniform> real3_1: type_9;
@group(0) @binding(7)
var<storage> input: array<float3_>;

fn sum_pair(value: int3_) -> i32 {
    var value_1: int3_;

    value_1 = value;
    let _e4 = value_1.x;
    let _e5 = value_1.y;
    return (_e4 + _e5);
}

@compute @workgroup_size(4, 1, 1)
fn named_vectors(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var signed1_: int1_;
    var unsigned1_: uint1_;
    var real1_: float1_;
    var signed3_: int3_;
    var unsigned3_: uint3_;
    var real3_: float3_;
    var original_signed: int1_;
    var original_real: float1_;
    var original_unsigned: uint3_;
    var stored: float3_;
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
    var local_11: float3_;
    var local_12: float3_;

    let _e4 = signed1_1.value;
    signed1_ = _e4;
    let _e8 = unsigned1_1.value;
    unsigned1_ = _e8;
    let _e12 = real1_1.value;
    real1_ = _e12;
    let _e16 = signed3_1.value;
    signed3_ = _e16;
    let _e20 = unsigned3_1.value;
    unsigned3_ = _e20;
    let _e24 = real3_1.value;
    real3_ = _e24;
    let lane = (threadIdx.x + (blockIdx.x * 4u));
    if (lane >= 4u) {
        return;
    }
    let base = (4u + (lane * 12u));
    let _e37 = signed1_;
    original_signed = _e37;
    let _e39 = real1_;
    original_real = _e39;
    let _e41 = unsigned3_;
    original_unsigned = _e41;
    let _e45 = signed1_.x;
    signed1_.x = (_e45 + i32(lane));
    let _e48 = unsigned1_.x;
    unsigned1_.x = (_e48 + lane);
    let _e52 = real1_.x;
    real1_.x = (_e52 + f32(lane));
    let _e55 = signed3_.x;
    let _e57 = signed3_.y;
    let _e60 = signed3_.z;
    signed3_ = int3_(_e55, _e57, (_e60 + i32(lane)));
    let _e64 = unsigned3_.y;
    unsigned3_.x = (_e64 + 1u);
    let _e69 = unsigned3_.z;
    unsigned3_.z = (_e69 + lane);
    let _e73 = input[lane];
    local_12 = _e73;
    let _e75 = local_12;
    local_11 = _e75;
    let _e77 = local_11;
    stored = _e77;
    let _e80 = signed1_.x;
    output[base] = u32((_e80 + 10i));
    let _e87 = unsigned1_.x;
    local = u32((base + 1u));
    let _e92 = local;
    output[_e92] = _e87;
    let _e95 = real1_.x;
    local_1 = u32((base + 2u));
    let _e101 = local_1;
    output[_e101] = bitcast<u32>(_e95);
    let _e104 = signed3_.z;
    local_2 = u32((base + 3u));
    let _e112 = local_2;
    output[_e112] = u32((_e104 + 10i));
    let _e114 = signed3_;
    let _e115 = sum_pair(_e114);
    local_3 = u32((base + 4u));
    let _e121 = local_3;
    output[_e121] = u32(_e115);
    let _e125 = unsigned3_.x;
    let _e126 = unsigned3_.z;
    local_4 = u32((base + 5u));
    let _e132 = local_4;
    output[_e132] = (_e125 + _e126);
    let _e136 = real3_.x;
    let _e137 = real3_.y;
    let _e140 = real3_.z;
    local_5 = u32((base + 6u));
    let _e147 = local_5;
    output[_e147] = bitcast<u32>(((_e136 + _e137) + _e140));
    let _e150 = original_signed.x;
    local_6 = u32((base + 7u));
    let _e158 = local_6;
    output[_e158] = u32((_e150 + 10i));
    let _e162 = original_unsigned.x;
    let _e163 = original_unsigned.z;
    local_7 = u32((base + 8u));
    let _e169 = local_7;
    output[_e169] = (_e162 + _e163);
    let _e172 = original_real.x;
    local_8 = u32((base + 9u));
    let _e178 = local_8;
    output[_e178] = bitcast<u32>(_e172);
    let _e181 = stored.z;
    local_9 = u32((base + 10u));
    let _e187 = local_9;
    output[_e187] = bitcast<u32>(_e181);
    let _e191 = stored.x;
    let _e192 = real3_.x;
    local_10 = u32((base + 11u));
    let _e199 = local_10;
    output[_e199] = bitcast<u32>((_e191 + _e192));
}
