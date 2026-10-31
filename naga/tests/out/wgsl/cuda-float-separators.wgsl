struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<f32>;
@group(0) @binding(1)
var<storage> input: array<f32>;
@group(0) @binding(2)
var<uniform> n: type_3;

@compute @workgroup_size(64, 1, 1)
fn float_separators(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var base: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: f32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: u32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;
    var local_24: u32;
    var local_25: u32;
    var local_26: f32;
    var local_27: u32;

    let n_1 = n.value;
    let i = ((blockIdx.x * 64u) + threadIdx.x);
    if (i < n_1) {
        base = (i * 12u);
        let _e14 = base;
        local = u32(_e14);
        let _e17 = local;
        local_14 = u32(_e17);
        let _e20 = local_14;
        out[_e20] = 1024.5f;
        let _e24 = base;
        local_1 = u32((_e24 + 1u));
        let _e29 = local_1;
        local_15 = u32(_e29);
        let _e32 = local_15;
        out[_e32] = 0.125f;
        let _e35 = base;
        local_2 = u32((_e35 + 2u));
        let _e40 = local_2;
        local_16 = u32(_e40);
        let _e43 = local_16;
        out[_e43] = 12f;
        let _e46 = base;
        local_3 = u32((_e46 + 3u));
        let _e51 = local_3;
        local_17 = u32(_e51);
        let _e54 = local_17;
        out[_e54] = 25f;
        let _e57 = base;
        local_4 = u32((_e57 + 4u));
        let _e62 = local_4;
        local_18 = u32(_e62);
        let _e65 = local_18;
        out[_e65] = 0.5f;
        let _e68 = base;
        local_5 = u32((_e68 + 5u));
        let _e73 = local_5;
        local_19 = u32(_e73);
        let _e76 = local_19;
        out[_e76] = 6.25f;
        let _e81 = base;
        local_6 = u32((_e81 + 6u));
        let _e86 = local_6;
        local_20 = u32(_e86);
        let _e89 = local_20;
        out[_e89] = -(1024.5f);
        let _e91 = base;
        local_7 = u32((_e91 + 7u));
        let _e96 = local_7;
        local_21 = u32(_e96);
        let _e99 = local_21;
        out[_e99] = 0.125f;
        let _e102 = base;
        local_8 = u32((_e102 + 8u));
        let _e107 = local_8;
        local_22 = u32(_e107);
        let _e110 = local_22;
        out[_e110] = 3.1415927f;
        let _e113 = base;
        local_9 = u32((_e113 + 9u));
        let _e118 = local_9;
        local_23 = u32(_e118);
        let _e121 = local_23;
        out[_e121] = 1f;
        let _e124 = base;
        local_10 = u32((_e124 + 10u));
        let _e129 = local_10;
        local_24 = u32(_e129);
        let _e132 = local_24;
        out[_e132] = 1.0000002f;
        local_12 = u32(i);
        let _e137 = local_12;
        local_25 = u32(_e137);
        let _e140 = local_25;
        let _e143 = input[_e140];
        local_26 = _e143;
        let _e145 = local_26;
        local_13 = _e145;
        let _e147 = local_13;
        let _e152 = base;
        local_11 = u32((_e152 + 11u));
        let _e157 = local_11;
        local_27 = u32(_e157);
        let _e160 = local_27;
        out[_e160] = ((_e147 * 0.25f) + 10f);
    }
}
