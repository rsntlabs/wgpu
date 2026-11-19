struct Five_cuda_record_0_ {
    a: i32,
    b: u32,
    c: f32,
    d: u32,
    e: i32,
}

struct Six_cuda_record_1_ {
    a: i32,
    b: u32,
    c: f32,
    d: u32,
    e: i32,
    f: u32,
}

struct Seven_cuda_record_2_ {
    a: i32,
    b: u32,
    c: f32,
    d: u32,
    e: i32,
    f: u32,
    g: f32,
}

struct Eight_cuda_record_3_ {
    a: i32,
    b: u32,
    c: f32,
    d: u32,
    e: i32,
    f: u32,
    g: f32,
    h: u32,
}

struct Small_cuda_record_4_ {
    value: u32,
}

struct type_4 {
    value: Five_cuda_record_0_,
}

struct type_5 {
    value: Six_cuda_record_1_,
}

struct type_6 {
    value: Seven_cuda_record_2_,
}

struct type_7 {
    value: Eight_cuda_record_3_,
}

struct type_8 {
    value: Small_cuda_record_4_,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<uniform> five_1: type_4;
@group(0) @binding(2)
var<uniform> six_1: type_5;
@group(0) @binding(3)
var<uniform> seven_1: type_6;
@group(0) @binding(4)
var<uniform> eight_1: type_7;
@group(0) @binding(5)
var<uniform> small_1: type_8;
@group(0) @binding(6)
var<storage> input: array<Five_cuda_record_0_>;

@compute @workgroup_size(4, 1, 1)
fn record32_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var five: Five_cuda_record_0_;
    var six: Six_cuda_record_1_;
    var seven: Seven_cuda_record_2_;
    var eight: Eight_cuda_record_3_;
    var small: Small_cuda_record_4_;
    var original: Five_cuda_record_0_;
    var saved: Seven_cuda_record_2_;
    var changed: Eight_cuda_record_3_;
    var stored: Five_cuda_record_0_;
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
    var lane: u32;
    var local_11: Five_cuda_record_0_;
    var local_12: Five_cuda_record_0_;

    let _e4 = five_1.value;
    five = _e4;
    let _e8 = six_1.value;
    six = _e8;
    let _e12 = seven_1.value;
    seven = _e12;
    let _e16 = eight_1.value;
    eight = _e16;
    let _e20 = small_1.value;
    small = _e20;
    let lane_1 = (threadIdx.x + (blockIdx.x * 4u));
    if (lane_1 >= 4u) {
        return;
    }
    let base = (4u + (lane_1 * 12u));
    let _e33 = five;
    original = _e33;
    let _e35 = seven;
    saved = _e35;
    lane = u32();
    lane = lane_1;
    let _e40 = lane;
    let _e43 = five.e;
    five.e = (_e43 + i32(_e40));
    let _e48 = seven.g;
    seven.g = (_e48 + f32(lane_1));
    let _e50 = eight;
    changed = _e50;
    let _e53 = changed.h;
    changed.h = (_e53 + lane_1);
    let _e55 = changed;
    eight = _e55;
    let _e58 = input[lane_1];
    local_12 = _e58;
    let _e60 = local_12;
    local_11 = _e60;
    let _e62 = local_11;
    stored = _e62;
    let _e65 = original.e;
    output[base] = u32((_e65 + 30i));
    let _e72 = five.e;
    local = u32((base + 1u));
    let _e80 = local;
    output[_e80] = u32((_e72 + 30i));
    let _e83 = six.e;
    local_1 = u32((base + 2u));
    let _e91 = local_1;
    output[_e91] = u32((_e83 + 30i));
    let _e94 = six.f;
    local_2 = u32((base + 3u));
    let _e99 = local_2;
    output[_e99] = _e94;
    let _e102 = seven.g;
    local_3 = u32((base + 4u));
    let _e108 = local_3;
    output[_e108] = bitcast<u32>(_e102);
    let _e111 = saved.g;
    local_4 = u32((base + 5u));
    let _e117 = local_4;
    output[_e117] = bitcast<u32>(_e111);
    let _e120 = eight.h;
    local_5 = u32((base + 6u));
    let _e125 = local_5;
    output[_e125] = _e120;
    let _e128 = eight.f;
    local_6 = u32((base + 7u));
    let _e133 = local_6;
    output[_e133] = _e128;
    let _e136 = eight.g;
    local_7 = u32((base + 8u));
    let _e142 = local_7;
    output[_e142] = bitcast<u32>(_e136);
    let _e145 = eight.e;
    local_8 = u32((base + 9u));
    let _e153 = local_8;
    output[_e153] = u32((_e145 + 30i));
    let _e156 = small.value;
    local_9 = u32((base + 10u));
    let _e161 = local_9;
    output[_e161] = _e156;
    let _e165 = stored.a;
    let _e166 = stored.e;
    let _e170 = stored.b;
    let _e173 = stored.d;
    let _e176 = stored.c;
    local_10 = u32((base + 11u));
    let _e183 = local_10;
    output[_e183] = (((u32((_e165 + _e166)) + _e170) + _e173) + u32(_e176));
}
