struct One_cuda_record_0_ {
    x: i32,
}

struct Two_cuda_record_1_ {
    x: u32,
    y: f32,
}

struct Trio_cuda_record_2_ {
    x: i32,
    y: u32,
    z: f32,
}

struct Four_cuda_record_3_ {
    x: i32,
    y: u32,
    z: f32,
    w: u32,
}

struct Twin_cuda_record_4_ {
    x: i32,
    y: u32,
    z: f32,
}

struct type_4 {
    value: One_cuda_record_0_,
}

struct type_5 {
    value: Two_cuda_record_1_,
}

struct type_6 {
    value: Trio_cuda_record_2_,
}

struct type_7 {
    value: Four_cuda_record_3_,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<uniform> one_1: type_4;
@group(0) @binding(2)
var<uniform> two_1: type_5;
@group(0) @binding(3)
var<uniform> three_1: type_6;
@group(0) @binding(4)
var<uniform> four_1: type_7;
@group(0) @binding(5)
var<storage> input: array<Trio_cuda_record_2_>;

fn kind(param: Trio_cuda_record_2_) -> u32 {
    return 11u;
}

fn kind_1(param_1: Twin_cuda_record_4_) -> u32 {
    return 22u;
}

@compute @workgroup_size(4, 1, 1)
fn record_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var one: One_cuda_record_0_;
    var two: Two_cuda_record_1_;
    var three: Trio_cuda_record_2_;
    var four: Four_cuda_record_3_;
    var original: Trio_cuda_record_2_;
    var changed: Four_cuda_record_3_;
    var other: Twin_cuda_record_4_;
    var stored: Trio_cuda_record_2_;
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
    var local_11: Trio_cuda_record_2_;
    var local_12: Trio_cuda_record_2_;

    let _e4 = one_1.value;
    one = _e4;
    let _e8 = two_1.value;
    two = _e8;
    let _e12 = three_1.value;
    three = _e12;
    let _e16 = four_1.value;
    four = _e16;
    let lane_1 = (threadIdx.x + (blockIdx.x * 4u));
    if (lane_1 >= 4u) {
        return;
    }
    let base = (4u + (lane_1 * 12u));
    let _e29 = three;
    original = _e29;
    let _e33 = one.x;
    one.x = (_e33 + i32(lane_1));
    lane = u32();
    lane = lane_1;
    let _e38 = lane;
    let _e40 = three.y;
    three.y = (_e40 + _e38);
    let _e45 = three.x;
    three.x = (_e45 - i32(lane_1));
    let _e47 = four;
    changed = _e47;
    let _e51 = changed.x;
    changed.x = (_e51 + i32(lane_1));
    let _e54 = changed.y;
    changed.y = (_e54 + 1u);
    let _e58 = changed.z;
    changed.z = (_e58 * 2f);
    let _e61 = changed;
    four = _e61;
    let _e63 = original.x;
    other.x = _e63;
    let _e67 = original.y;
    other.y = _e67;
    let _e70 = original.z;
    other.z = _e70;
    let _e74 = input[lane_1];
    local_12 = _e74;
    let _e76 = local_12;
    local_11 = _e76;
    let _e78 = local_11;
    stored = _e78;
    let _e81 = one.x;
    output[base] = u32((_e81 + 10i));
    let _e88 = two.x;
    local = u32((base + 1u));
    let _e93 = local;
    output[_e93] = _e88;
    let _e96 = two.y;
    local_1 = u32((base + 2u));
    let _e102 = local_1;
    output[_e102] = bitcast<u32>(_e96);
    let _e105 = three.x;
    local_2 = u32((base + 3u));
    let _e113 = local_2;
    output[_e113] = u32((_e105 + 20i));
    let _e116 = three.y;
    local_3 = u32((base + 4u));
    let _e121 = local_3;
    output[_e121] = _e116;
    let _e124 = three.z;
    local_4 = u32((base + 5u));
    let _e130 = local_4;
    output[_e130] = bitcast<u32>(_e124);
    let _e133 = four.x;
    local_5 = u32((base + 6u));
    let _e141 = local_5;
    output[_e141] = u32((_e133 + 20i));
    let _e144 = four.y;
    local_6 = u32((base + 7u));
    let _e149 = local_6;
    output[_e149] = _e144;
    let _e152 = four.z;
    local_7 = u32((base + 8u));
    let _e158 = local_7;
    output[_e158] = bitcast<u32>(_e152);
    let _e161 = four.w;
    local_8 = u32((base + 9u));
    let _e166 = local_8;
    output[_e166] = _e161;
    let _e169 = original.y;
    local_9 = u32((base + 10u));
    let _e174 = local_9;
    output[_e174] = _e169;
    let _e176 = three;
    let _e177 = kind(_e176);
    let _e178 = other;
    let _e179 = kind_1(_e178);
    let _e182 = stored.x;
    let _e186 = stored.y;
    let _e189 = stored.z;
    local_10 = u32((base + 11u));
    let _e196 = local_10;
    output[_e196] = ((((_e177 + _e179) + u32(_e182)) + _e186) + u32(_e189));
}
