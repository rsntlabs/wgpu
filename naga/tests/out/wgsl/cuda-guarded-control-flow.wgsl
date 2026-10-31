struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage> a: array<f32>;
@group(0) @binding(1)
var<storage> b: array<f32>;
@group(0) @binding(2)
var<storage, read_write> out: array<f32>;
@group(0) @binding(3)
var<uniform> n: type_3;

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

    let n_1 = n.value;
    let i = ((blockIdx.x * 1u) + threadIdx.x);
    if (i < n_1) {
        local_1 = u32(i);
        local_2 = u32(i);
        let _e15 = local_1;
        local_5 = u32(_e15);
        let _e18 = local_5;
        let _e21 = a[_e18];
        local_6 = _e21;
        let _e23 = local_6;
        local_3 = _e23;
        let _e25 = local_3;
        let _e26 = local_2;
        local_7 = u32(_e26);
        let _e29 = local_7;
        let _e32 = b[_e29];
        local_8 = _e32;
        let _e34 = local_8;
        local_4 = _e34;
        let _e36 = local_4;
        local = u32(i);
        let _e40 = local;
        local_9 = u32(_e40);
        let _e43 = local_9;
        out[_e43] = (_e25 + _e36);
    }
}
