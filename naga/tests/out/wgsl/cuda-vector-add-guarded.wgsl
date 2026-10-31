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

@compute @workgroup_size(64, 1, 1)
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
    i = ((blockIdx.x * 64u) + threadIdx.x);
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
        let _e49 = local_4;
        local_8 = _e49;
        let _e50 = local_5;
        let _e52 = local_8[1];
        local_8[1] = (_e52 + _e50);
        let _e56 = local_8[0];
        local_9 = u32(_e56);
        let _e60 = local_8[1];
        local_10 = u32(_e60);
        let _e64 = local_10;
        let _e66 = b_1[_e64];
        local_11 = _e66;
        let _e67 = local_11;
        local_6 = _e67;
        let _e69 = local_6;
        let _e73 = local_2;
        local_12 = _e73;
        let _e74 = local_3;
        let _e76 = local_12[1];
        local_12[1] = (_e76 + _e74);
        let _e80 = local_12[0];
        local_13 = u32(_e80);
        let _e84 = local_12[1];
        local_14 = u32(_e84);
        let _e88 = local_14;
        let _e90 = a_1[_e88];
        local_15 = _e90;
        let _e91 = local_15;
        local_7 = _e91;
        let _e93 = local_7;
        let _e97 = out;
        local = _e97;
        let _e98 = i;
        local_1 = u32(_e98);
        let _e102 = local;
        local_16 = _e102;
        let _e103 = local_1;
        let _e105 = local_16[1];
        local_16[1] = (_e105 + _e103);
        let _e109 = local_16[0];
        local_17 = u32(_e109);
        let _e113 = local_16[1];
        local_18 = u32(_e113);
        let _e116 = local_18;
        out_1[_e116] = (_e93 + (_e69 * 2f));
    }
}
