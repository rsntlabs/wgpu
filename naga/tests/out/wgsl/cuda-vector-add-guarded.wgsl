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
var<uniform> n_1: type_3;

@compute @workgroup_size(64, 1, 1)
fn add(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var local_2: array<u32, 2>;
    var n: u32;
    var i: u32;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: f32;
    var local_10: f32;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: u32;
    var local_14: f32;
    var local_15: array<u32, 2>;
    var local_16: u32;
    var local_17: u32;
    var local_18: f32;
    var local_19: array<u32, 2>;
    var local_20: u32;
    var local_21: u32;

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = array<u32, 2>();
    local_1[0] = 1u;
    local_1[1] = 0u;
    local_2 = array<u32, 2>();
    local_2[0] = 2u;
    local_2[1] = 0u;
    let _e25 = n_1.value;
    n = _e25;
    i = ((blockIdx.x * 64u) + threadIdx.x);
    let _e33 = i;
    let _e34 = n;
    if (_e33 < _e34) {
        let _e38 = local;
        local_5 = _e38;
        let _e39 = i;
        local_6 = u32(_e39);
        let _e44 = local_1;
        local_7 = _e44;
        let _e45 = i;
        local_8 = u32(_e45);
        let _e49 = local_7;
        local_11 = _e49;
        let _e50 = local_8;
        let _e52 = local_11[1];
        local_11[1] = (_e52 + _e50);
        let _e56 = local_11[0];
        local_12 = u32(_e56);
        let _e60 = local_11[1];
        local_13 = u32(_e60);
        let _e64 = local_13;
        let _e66 = b[_e64];
        local_14 = _e66;
        let _e67 = local_14;
        local_9 = _e67;
        let _e69 = local_9;
        let _e73 = local_5;
        local_15 = _e73;
        let _e74 = local_6;
        let _e76 = local_15[1];
        local_15[1] = (_e76 + _e74);
        let _e80 = local_15[0];
        local_16 = u32(_e80);
        let _e84 = local_15[1];
        local_17 = u32(_e84);
        let _e88 = local_17;
        let _e90 = a[_e88];
        local_18 = _e90;
        let _e91 = local_18;
        local_10 = _e91;
        let _e93 = local_10;
        let _e97 = local_2;
        local_3 = _e97;
        let _e98 = i;
        local_4 = u32(_e98);
        let _e102 = local_3;
        local_19 = _e102;
        let _e103 = local_4;
        let _e105 = local_19[1];
        local_19[1] = (_e105 + _e103);
        let _e109 = local_19[0];
        local_20 = u32(_e109);
        let _e113 = local_19[1];
        local_21 = u32(_e113);
        let _e116 = local_21;
        out[_e116] = (_e93 + (_e69 * 2f));
    }
}
