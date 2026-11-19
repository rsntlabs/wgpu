struct dim3_ {
    x: u32,
    y: u32,
    z: u32,
}

struct uint3_ {
    x: u32,
    y: u32,
    z: u32,
}

struct type_2 {
    value: dim3_,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<uniform> shape_1: type_2;
@group(0) @binding(2)
var<uniform> fixed_1: type_2;

fn kind(param: dim3_) -> u32 {
    return 11u;
}

fn kind_1(param_1: uint3_) -> u32 {
    return 22u;
}

@compute @workgroup_size(4, 1, 1)
fn dim3_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var shape: dim3_;
    var fixed: dim3_;
    var original: dim3_;
    var packed: uint3_;
    var restored: dim3_;
    var local: dim3_;
    var partial: dim3_;
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
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var lane: u32;

    let _e4 = shape_1.value;
    shape = _e4;
    let _e8 = fixed_1.value;
    fixed = _e8;
    let lane_1 = (threadIdx.x + (blockIdx.x * 4u));
    if (lane_1 >= 4u) {
        return;
    }
    let base = (4u + (lane_1 * 14u));
    let _e21 = shape;
    original = _e21;
    let _e23 = original;
    packed = uint3_(_e23.x, _e23.y, _e23.z);
    let _e29 = packed;
    restored = dim3_(_e29.x, _e29.y, _e29.z);
    lane = u32();
    lane = lane_1;
    let _e38 = lane;
    let _e40 = shape.x;
    shape.x = (_e40 + _e38);
    let _e44 = shape.y;
    shape.y = (_e44 + 2u);
    let _e49 = shape.x;
    let _e51 = shape.y;
    shape = dim3_(_e49, _e51, 1u);
    local = dim3_(1u, 1u, 1u);
    partial = dim3_(2u, 1u, 1u);
    let _e65 = original.x;
    output[base] = _e65;
    let _e69 = original.y;
    local_1 = u32((base + 1u));
    let _e74 = local_1;
    output[_e74] = _e69;
    let _e77 = original.z;
    local_2 = u32((base + 2u));
    let _e82 = local_2;
    output[_e82] = _e77;
    let _e85 = shape.x;
    local_3 = u32((base + 3u));
    let _e90 = local_3;
    output[_e90] = _e85;
    let _e93 = shape.y;
    local_4 = u32((base + 4u));
    let _e98 = local_4;
    output[_e98] = _e93;
    let _e101 = shape.z;
    local_5 = u32((base + 5u));
    let _e106 = local_5;
    output[_e106] = _e101;
    let _e110 = local.x;
    let _e111 = local.y;
    let _e114 = local.z;
    local_6 = u32((base + 6u));
    let _e120 = local_6;
    output[_e120] = ((_e110 + _e111) + _e114);
    let _e123 = fixed.x;
    local_7 = u32((base + 7u));
    let _e128 = local_7;
    output[_e128] = _e123;
    let _e131 = fixed.y;
    local_8 = u32((base + 8u));
    let _e136 = local_8;
    output[_e136] = _e131;
    let _e139 = fixed.z;
    local_9 = u32((base + 9u));
    let _e144 = local_9;
    output[_e144] = _e139;
    let _e146 = shape;
    let _e147 = kind(_e146);
    let _e148 = packed;
    let _e149 = kind_1(_e148);
    local_10 = u32((base + 10u));
    let _e155 = local_10;
    output[_e155] = (_e147 + _e149);
    let _e159 = restored.x;
    let _e160 = restored.y;
    let _e163 = restored.z;
    local_11 = u32((base + 11u));
    let _e169 = local_11;
    output[_e169] = ((_e159 ^ _e160) ^ _e163);
    local_12 = u32((base + 12u));
    let _e175 = local_12;
    output[_e175] = 4u;
    let _e180 = partial.y;
    let _e181 = partial.z;
    local_13 = u32((base + 13u));
    let _e187 = local_13;
    output[_e187] = (_e180 + _e181);
}
