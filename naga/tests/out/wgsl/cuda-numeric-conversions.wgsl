struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<f32>;
@group(0) @binding(1)
var<storage, read_write> output: array<f32>;
@group(0) @binding(2)
var<uniform> n: type_3;

@compute @workgroup_size(1, 1, 1)
fn convert(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var offset: f32;
    var local: u32;
    var local_1: u32;
    var local_2: f32;
    var local_3: u32;
    var local_4: f32;
    var local_5: u32;

    let n_1 = n.value;
    let i = i32(((blockIdx.x * 1u) + threadIdx.x));
    if (u32(i) < n_1) {
        offset = f32(i);
        local_1 = u32(i);
        let _e17 = local_1;
        local_3 = u32(_e17);
        let _e20 = local_3;
        let _e23 = input[_e20];
        local_4 = _e23;
        let _e25 = local_4;
        local_2 = _e25;
        let _e27 = local_2;
        let _e28 = offset;
        local = u32(i);
        let _e32 = local;
        local_5 = u32(_e32);
        let _e35 = local_5;
        output[_e35] = (_e27 + _e28);
    }
}
