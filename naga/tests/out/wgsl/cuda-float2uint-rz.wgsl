struct type_4 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_4;

fn forward(value: f32) -> f32 {
    return value;
}

@compute @workgroup_size(4, 1, 1)
fn convert_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: f32;
    var local_5: f32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: i32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: f32;
    var local_16: u32;
    var local_17: f32;
    var extra: i32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 10u));
    let _e17 = input[index];
    let value_1 = bitcast<f32>(_e17);
    counter = 0u;
    output[base] = u32(value_1);
    let _e24 = forward(value_1);
    local = u32((base + 1u));
    let _e30 = local;
    output[_e30] = u32(_e24);
    let _e32 = counter;
    counter = (_e32 + u32(1i));
    local_1 = u32((base + 2u));
    let _e41 = local_1;
    output[_e41] = u32(value_1);
    let _e43 = counter;
    local_2 = u32((base + 3u));
    let _e48 = local_2;
    output[_e48] = _e43;
    if ((index & 1u) != 0u) {
        let _e54 = counter;
        local_14 = _e54;
        let _e56 = local_14;
        counter = (_e56 + u32(1i));
        local_15 = value_1;
        let _e61 = local_15;
        local_4 = _e61;
        let _e63 = local_4;
        local_6 = u32(_e63);
    } else {
        let _e66 = counter;
        local_16 = _e66;
        let _e68 = local_16;
        counter = (_e68 + u32(1i));
        local_17 = value_1;
        let _e73 = local_17;
        local_5 = _e73;
        let _e75 = local_5;
        local_6 = u32(_e75);
    }
    let _e79 = local_6;
    local_3 = u32((base + 4u));
    let _e84 = local_3;
    output[_e84] = _e79;
    let _e86 = counter;
    local_7 = u32((base + 5u));
    let _e91 = local_7;
    output[_e91] = _e86;
    local_8 = u32((base + 6u));
    let _e100 = local_8;
    output[_e100] = u32(f32(16777217u));
    local_9 = u32((base + 7u));
    let _e109 = local_9;
    output[_e109] = u32(f32(2147483649u));
    local_10 = u32((base + 8u));
    let _e118 = local_10;
    output[_e118] = u32(f32(true));
    local_11 = 7i;
    extra = i32();
    extra = 3i;
    let _e126 = local_11;
    let _e127 = extra;
    local_13 = u32((_e126 + _e127));
    let _e131 = local_13;
    local_12 = u32((base + 9u));
    let _e136 = local_12;
    output[_e136] = _e131;
}
