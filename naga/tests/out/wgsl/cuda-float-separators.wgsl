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
        local = _e14;
        let _e16 = local;
        local_14 = _e16;
        let _e18 = local_14;
        out[_e18] = 1024.5f;
        let _e22 = base;
        local_1 = u32((_e22 + 1u));
        let _e27 = local_1;
        local_15 = _e27;
        let _e29 = local_15;
        out[_e29] = 0.125f;
        let _e32 = base;
        local_2 = u32((_e32 + 2u));
        let _e37 = local_2;
        local_16 = _e37;
        let _e39 = local_16;
        out[_e39] = 12f;
        let _e42 = base;
        local_3 = u32((_e42 + 3u));
        let _e47 = local_3;
        local_17 = _e47;
        let _e49 = local_17;
        out[_e49] = 25f;
        let _e52 = base;
        local_4 = u32((_e52 + 4u));
        let _e57 = local_4;
        local_18 = _e57;
        let _e59 = local_18;
        out[_e59] = 0.5f;
        let _e62 = base;
        local_5 = u32((_e62 + 5u));
        let _e67 = local_5;
        local_19 = _e67;
        let _e69 = local_19;
        out[_e69] = 6.25f;
        let _e74 = base;
        local_6 = u32((_e74 + 6u));
        let _e79 = local_6;
        local_20 = _e79;
        let _e81 = local_20;
        out[_e81] = -(1024.5f);
        let _e83 = base;
        local_7 = u32((_e83 + 7u));
        let _e88 = local_7;
        local_21 = _e88;
        let _e90 = local_21;
        out[_e90] = 0.125f;
        let _e93 = base;
        local_8 = u32((_e93 + 8u));
        let _e98 = local_8;
        local_22 = _e98;
        let _e100 = local_22;
        out[_e100] = 3.1415927f;
        let _e103 = base;
        local_9 = u32((_e103 + 9u));
        let _e108 = local_9;
        local_23 = _e108;
        let _e110 = local_23;
        out[_e110] = 1f;
        let _e113 = base;
        local_10 = u32((_e113 + 10u));
        let _e118 = local_10;
        local_24 = _e118;
        let _e120 = local_24;
        out[_e120] = 1.0000002f;
        local_12 = i;
        let _e124 = local_12;
        local_25 = _e124;
        let _e126 = local_25;
        let _e129 = input[_e126];
        local_26 = _e129;
        let _e131 = local_26;
        local_13 = _e131;
        let _e133 = local_13;
        let _e138 = base;
        local_11 = u32((_e138 + 11u));
        let _e143 = local_11;
        local_27 = _e143;
        let _e145 = local_27;
        out[_e145] = ((_e133 * 0.25f) + 10f);
    }
}
