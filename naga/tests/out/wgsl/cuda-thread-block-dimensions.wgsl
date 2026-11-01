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

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

fn kind(value: dim3_) -> u32 {
    var value_1: dim3_;

    value_1 = value;
    return 11u;
}

fn kind_1(value_2: uint3_) -> u32 {
    var value_3: uint3_;

    value_3 = value_2;
    return 22u;
}

@compute @workgroup_size(4, 3, 2)
fn dimensions(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: dim3_;
    var block: dim3_;
    var extent: dim3_;
    var legacy: dim3_;
    var copied: dim3_;
    var packed: uint3_;
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
    var local_14: u32;
    var local_15: u32;

    local = dim3_(threadIdx.x, threadIdx.y, threadIdx.z);
    block = dim3_(blockIdx.x, blockIdx.y, blockIdx.z);
    extent = dim3_(4u, 3u, 2u);
    legacy = dim3_(4u, 3u, 2u);
    let _e22 = local;
    copied = _e22;
    let _e25 = copied.x;
    copied.x = (_e25 + u32(1i));
    let _e29 = extent;
    packed = uint3_(_e29.x, _e29.y, _e29.z);
    let local_index = (threadIdx.x + (4u * (threadIdx.y + (3u * threadIdx.z))));
    let block_index = (blockIdx.x + (2u * (blockIdx.y + (2u * blockIdx.z))));
    let offset = (((block_index * 24u) + local_index) * 16u);
    let _e59 = local.x;
    output[offset] = _e59;
    let _e63 = local.y;
    local_1 = u32((offset + 1u));
    let _e68 = local_1;
    output[_e68] = _e63;
    let _e71 = local.z;
    local_2 = u32((offset + 2u));
    let _e76 = local_2;
    output[_e76] = _e71;
    let _e79 = block.x;
    local_3 = u32((offset + 3u));
    let _e84 = local_3;
    output[_e84] = _e79;
    let _e87 = block.y;
    local_4 = u32((offset + 4u));
    let _e92 = local_4;
    output[_e92] = _e87;
    let _e95 = block.z;
    local_5 = u32((offset + 5u));
    let _e100 = local_5;
    output[_e100] = _e95;
    let _e103 = extent.x;
    local_6 = u32((offset + 6u));
    let _e108 = local_6;
    output[_e108] = _e103;
    let _e111 = extent.y;
    local_7 = u32((offset + 7u));
    let _e116 = local_7;
    output[_e116] = _e111;
    let _e119 = extent.z;
    local_8 = u32((offset + 8u));
    let _e124 = local_8;
    output[_e124] = _e119;
    let _e127 = legacy.x;
    local_9 = u32((offset + 9u));
    let _e132 = local_9;
    output[_e132] = _e127;
    let _e135 = legacy.y;
    local_10 = u32((offset + 10u));
    let _e140 = local_10;
    output[_e140] = _e135;
    let _e143 = legacy.z;
    local_11 = u32((offset + 11u));
    let _e148 = local_11;
    output[_e148] = _e143;
    let _e150 = local;
    let _e151 = kind(_e150);
    let _e152 = packed;
    let _e153 = kind_1(_e152);
    local_12 = u32((offset + 12u));
    let _e159 = local_12;
    output[_e159] = (_e151 + _e153);
    let _e162 = copied.x;
    local_13 = u32((offset + 13u));
    let _e167 = local_13;
    output[_e167] = _e162;
    local_14 = u32((offset + 14u));
    let _e178 = local_14;
    output[_e178] = dim3_(threadIdx.x, threadIdx.y, threadIdx.z).x;
    let _e181 = packed.z;
    local_15 = u32((offset + 15u));
    let _e186 = local_15;
    output[_e186] = _e181;
}
