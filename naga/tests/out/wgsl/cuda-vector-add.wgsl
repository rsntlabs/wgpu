@group(0) @binding(0)
var<storage> a: array<f32>;
@group(0) @binding(1)
var<storage> b: array<f32>;
@group(0) @binding(2)
var<storage, read_write> out: array<f32>;

@compute @workgroup_size(64, 1, 1)
fn add(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;

    let i = ((blockIdx.x * 64u) + threadIdx.x);
    local_1 = u32(i);
    local_2 = u32(i);
    let _e11 = local_2;
    local_3 = u32(_e11);
    let _e14 = local_3;
    let _e17 = b[_e14];
    let _e20 = local_1;
    local_4 = u32(_e20);
    let _e23 = local_4;
    let _e26 = a[_e23];
    local = u32(i);
    let _e30 = local;
    local_5 = u32(_e30);
    let _e33 = local_5;
    out[_e33] = (_e26 + (_e17 * 2f));
}
