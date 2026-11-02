struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;
@group(0) @binding(1)
var<storage> input: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_3;
@group(0) @binding(0)
var<storage, read_write> output_1: array<f32>;
@group(0) @binding(1)
var<storage> input_1: array<f32>;
@group(0) @binding(2)
var<uniform> count_1: type_3;

fn copied_unsigned(value: u32) -> u32 {
    return value;
}

fn copied_float(value_1: f32) -> f32 {
    return value_1;
}

@compute @workgroup_size(4, 1, 1)
fn copy_typed_unsigned(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;

    let count_2 = count.value;
    let index = ((blockIdx.x * 4u) + threadIdx.x);
    if (index < count_2) {
        local_1 = index;
        let _e12 = local_1;
        local_3 = _e12;
        let _e14 = local_3;
        let _e17 = input[_e14];
        local_4 = _e17;
        let _e19 = local_4;
        local_2 = _e19;
        let _e21 = local_2;
        let _e22 = copied_unsigned(_e21);
        local = index;
        let _e24 = local;
        local_5 = _e24;
        let _e26 = local_5;
        output[_e26] = _e22;
    }
}

@compute @workgroup_size(4, 1, 1)
fn copy_typed_float(@builtin(workgroup_id) blockIdx_1: vec3<u32>, @builtin(local_invocation_id) threadIdx_1: vec3<u32>) {
    var local_6: u32;
    var local_7: u32;
    var local_8: f32;
    var local_9: u32;
    var local_10: f32;
    var local_11: u32;

    let count_3 = count_1.value;
    let index_1 = ((blockIdx_1.x * 4u) + threadIdx_1.x);
    if (index_1 < count_3) {
        local_7 = index_1;
        let _e12 = local_7;
        local_9 = _e12;
        let _e14 = local_9;
        let _e17 = input_1[_e14];
        local_10 = _e17;
        let _e19 = local_10;
        local_8 = _e19;
        let _e21 = local_8;
        let _e22 = copied_float(_e21);
        local_6 = index_1;
        let _e24 = local_6;
        local_11 = _e24;
        let _e26 = local_11;
        output_1[_e26] = _e22;
    }
}
