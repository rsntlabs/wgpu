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
        local_1 = i;
        local_2 = i;
        let _e13 = local_1;
        local_5 = _e13;
        let _e15 = local_5;
        let _e18 = a[_e15];
        local_6 = _e18;
        let _e20 = local_6;
        local_3 = _e20;
        let _e22 = local_3;
        let _e23 = local_2;
        local_7 = _e23;
        let _e25 = local_7;
        let _e28 = b[_e25];
        local_8 = _e28;
        let _e30 = local_8;
        local_4 = _e30;
        let _e32 = local_4;
        local = i;
        let _e35 = local;
        local_9 = _e35;
        let _e37 = local_9;
        out[_e37] = (_e22 + _e32);
    }
}
