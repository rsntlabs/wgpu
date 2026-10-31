struct type_1 {
    value: f32,
}

@group(0) @binding(0)
var<uniform> factor_1: type_1;
@group(0) @binding(1)
var<storage> input: array<f32>;
@group(0) @binding(2)
var<storage, read_write> output: array<f32>;

@compute @workgroup_size(1, 1, 1)
fn scale(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var factor: f32;
    var local: u32;
    var local_1: u32;

    let _e3 = factor_1.value;
    factor = _e3;
    let _e5 = factor;
    factor = (_e5 * 2f);
    local_1 = u32(threadIdx.x);
    let _e11 = local_1;
    let _e14 = input[_e11];
    let _e15 = factor;
    local = u32(threadIdx.x);
    let _e20 = local;
    output[_e20] = (_e14 * _e15);
}
