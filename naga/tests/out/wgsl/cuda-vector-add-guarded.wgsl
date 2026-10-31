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
var<uniform> n: type_3;

@compute @workgroup_size(64, 1, 1)
fn add(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var a: array<u32, 2>;
    var b: array<u32, 2>;
    var out: array<u32, 2>;
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
    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        let _e30 = a;
        local_2 = _e30;
        local_3 = u32(i);
        let _e35 = b;
        local_4 = _e35;
        local_5 = u32(i);
        let _e39 = local_4;
        local_8 = _e39;
        let _e41 = local_5;
        let _e43 = local_8[1];
        local_8[1] = (_e43 + _e41);
        let _e47 = local_8[0];
        local_9 = u32(_e47);
        let _e51 = local_8[1];
        local_10 = u32(_e51);
        let _e54 = local_10;
        let _e57 = b_1[_e54];
        local_11 = _e57;
        let _e59 = local_11;
        local_6 = _e59;
        let _e61 = local_6;
        let _e64 = local_2;
        local_12 = _e64;
        let _e66 = local_3;
        let _e68 = local_12[1];
        local_12[1] = (_e68 + _e66);
        let _e72 = local_12[0];
        local_13 = u32(_e72);
        let _e76 = local_12[1];
        local_14 = u32(_e76);
        let _e79 = local_14;
        let _e82 = a_1[_e79];
        local_15 = _e82;
        let _e84 = local_15;
        local_7 = _e84;
        let _e86 = local_7;
        let _e89 = out;
        local = _e89;
        local_1 = u32(i);
        let _e93 = local;
        local_16 = _e93;
        let _e95 = local_1;
        let _e97 = local_16[1];
        local_16[1] = (_e97 + _e95);
        let _e101 = local_16[0];
        local_17 = u32(_e101);
        let _e105 = local_16[1];
        local_18 = u32(_e105);
        let _e108 = local_18;
        out_1[_e108] = (_e86 + (_e61 * 2f));
    }
}
