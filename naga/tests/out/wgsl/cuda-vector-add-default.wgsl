@group(0) @binding(0)
var<storage> a: array<f32>;
@group(0) @binding(1)
var<storage> b: array<f32>;
@group(0) @binding(2)
var<storage, read_write> out: array<f32>;

@compute @workgroup_size(1, 1, 1)
fn add(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: f32;
    var local_4: f32;
    var local_5: u32;
    var local_6: f32;
    var local_7: u32;
    var local_8: f32;
    var local_9: u32;

    let i = ((blockIdx.x * 1u) + threadIdx.x);
    local_1 = u32(i);
    local_2 = u32(i);
    let _e11 = local_2;
    local_5 = u32(_e11);
    let _e14 = local_5;
    let _e17 = b[_e14];
    local_6 = _e17;
    let _e19 = local_6;
    local_3 = _e19;
    let _e21 = local_3;
    let _e24 = local_1;
    local_7 = u32(_e24);
    let _e27 = local_7;
    let _e30 = a[_e27];
    local_8 = _e30;
    let _e32 = local_8;
    local_4 = _e32;
    let _e34 = local_4;
    local = u32(i);
    let _e38 = local;
    local_9 = u32(_e38);
    let _e41 = local_9;
    out[_e41] = (_e34 + (_e21 * 2f));
}
