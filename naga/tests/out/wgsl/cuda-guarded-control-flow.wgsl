struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage> a_1: array<f32>;
@group(0) @binding(1)
var<storage> b_1: array<f32>;
@group(0) @binding(2)
var<storage, read_write> out_1: array<f32>;
@group(0) @binding(3)
var<uniform> n_1: type_3;

@compute @workgroup_size(1, 1, 1)
fn add(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var a: array<u32, 2>;
    var b: array<u32, 2>;
    var out: array<u32, 2>;
    var n: u32;
    var i: u32;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: f32;
    var local_7: f32;
    var local_8: array<u32, 2>;
    var local_9: u32;
    var local_10: u32;
    var local_11: f32;
    var local_12: array<u32, 2>;
    var local_13: u32;
    var local_14: u32;
    var local_15: f32;
    var local_16: array<u32, 2>;
    var local_17: u32;
    var local_18: u32;

    a = array<u32, 2>();
    a[0] = 0u;
    a[1] = 0u;
    b = array<u32, 2>();
    b[0] = 1u;
    b[1] = 0u;
    out = array<u32, 2>();
    out[0] = 2u;
    out[1] = 0u;
    let _e25 = n_1.value;
    n = _e25;
    i = ((blockIdx.x * 1u) + threadIdx.x);
    let _e33 = i;
    let _e34 = n;
    if (_e33 < _e34) {
        let _e38 = a;
        local_2 = _e38;
        let _e39 = i;
        local_3 = u32(_e39);
        let _e44 = b;
        local_4 = _e44;
        let _e45 = i;
        local_5 = u32(_e45);
        let _e49 = local_2;
        local_8 = _e49;
        let _e50 = local_3;
        let _e52 = local_8[1];
        local_8[1] = (_e52 + _e50);
        let _e56 = local_8[0];
        local_9 = u32(_e56);
        let _e60 = local_8[1];
        local_10 = u32(_e60);
        let _e64 = local_10;
        let _e66 = a_1[_e64];
        local_11 = _e66;
        let _e67 = local_11;
        local_6 = _e67;
        let _e69 = local_6;
        let _e71 = local_4;
        local_12 = _e71;
        let _e72 = local_5;
        let _e74 = local_12[1];
        local_12[1] = (_e74 + _e72);
        let _e78 = local_12[0];
        local_13 = u32(_e78);
        let _e82 = local_12[1];
        local_14 = u32(_e82);
        let _e86 = local_14;
        let _e88 = b_1[_e86];
        local_15 = _e88;
        let _e89 = local_15;
        local_7 = _e89;
        let _e91 = local_7;
        let _e95 = out;
        local = _e95;
        let _e96 = i;
        local_1 = u32(_e96);
        let _e100 = local;
        local_16 = _e100;
        let _e101 = local_1;
        let _e103 = local_16[1];
        local_16[1] = (_e103 + _e101);
        let _e107 = local_16[0];
        local_17 = u32(_e107);
        let _e111 = local_16[1];
        local_18 = u32(_e111);
        let _e114 = local_18;
        out_1[_e114] = (_e69 + _e91);
    }
}
