struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<i32>;
@group(0) @binding(2)
var<uniform> count: type_5;

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
    var local_6: i32;
    var local_7: u32;
    var local_8: u32;
    var local_9: i32;
    var local_10: u32;
    var local_11: i32;
    var local_12: u32;
    var local_13: f32;
    var local_14: u32;
    var local_15: f32;
    var extra: i32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 8u));
    let _e17 = input[index];
    let value_1 = bitcast<f32>(_e17);
    counter = 0u;
    output[base] = i32(value_1);
    let _e24 = forward(value_1);
    local = u32((base + 1u));
    let _e30 = local;
    output[_e30] = i32(_e24);
    let _e32 = counter;
    counter = (_e32 + u32(1i));
    local_1 = u32((base + 2u));
    let _e41 = local_1;
    output[_e41] = i32(value_1);
    let _e43 = counter;
    local_2 = u32((base + 3u));
    let _e49 = local_2;
    output[_e49] = i32(_e43);
    if ((index & 1u) != 0u) {
        let _e55 = counter;
        local_12 = _e55;
        let _e57 = local_12;
        counter = (_e57 + u32(1i));
        local_13 = value_1;
        let _e62 = local_13;
        local_4 = _e62;
        let _e64 = local_4;
        local_6 = i32(_e64);
    } else {
        let _e67 = counter;
        local_14 = _e67;
        let _e69 = local_14;
        counter = (_e69 + u32(1i));
        local_15 = value_1;
        let _e74 = local_15;
        local_5 = _e74;
        let _e76 = local_5;
        local_6 = i32(_e76);
    }
    let _e80 = local_6;
    local_3 = u32((base + 4u));
    let _e85 = local_3;
    output[_e85] = _e80;
    let _e87 = counter;
    local_7 = u32((base + 5u));
    let _e93 = local_7;
    output[_e93] = i32(_e87);
    local_8 = u32((base + 6u));
    let _e102 = local_8;
    output[_e102] = i32(f32(16777217i));
    local_9 = 7i;
    extra = i32();
    extra = 3i;
    let _e110 = local_9;
    let _e111 = extra;
    local_11 = (_e110 + _e111);
    let _e114 = local_11;
    local_10 = u32((base + 7u));
    let _e119 = local_10;
    output[_e119] = _e114;
}
