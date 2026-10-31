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
    var local_2: f32;
    var local_3: u32;
    var local_4: f32;
    var local_5: u32;

    let _e3 = factor_1.value;
    factor = _e3;
    let _e5 = factor;
    factor = (_e5 * 2f);
    local_1 = u32(threadIdx.x);
    let _e12 = local_1;
    local_3 = u32(_e12);
    let _e16 = local_3;
    let _e18 = input[_e16];
    local_4 = _e18;
    let _e19 = local_4;
    local_2 = _e19;
    let _e21 = local_2;
    let _e22 = factor;
    local = u32(threadIdx.x);
    let _e28 = local;
    local_5 = u32(_e28);
    let _e31 = local_5;
    output[_e31] = (_e21 * _e22);
}
