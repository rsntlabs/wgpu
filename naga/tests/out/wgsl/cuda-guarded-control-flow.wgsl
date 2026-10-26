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

@compute @workgroup_size(1, 1, 1)
fn add(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var n: u32;
    var i: u32;
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
    var local_15: f32;
    var local_16: u32;

    local = 0u;
    local_1 = 0u;
    local_2 = 0u;
    let _e10 = n_1.value;
    n = _e10;
    i = ((blockIdx.x * 1u) + threadIdx.x);
    let _e18 = i;
    let _e19 = n;
    if (_e18 < _e19) {
        let _e21 = local;
        local_6 = _e21;
        let _e23 = local_6;
        local_7 = u32(_e23);
        let _e26 = i;
        local_8 = u32(_e26);
        let _e29 = local_1;
        local_9 = _e29;
        let _e31 = local_9;
        local_10 = u32(_e31);
        let _e34 = i;
        local_11 = u32(_e34);
        let _e38 = local_7;
        let _e39 = local_8;
        local_12 = u32((_e38 + _e39));
        let _e44 = local_12;
        let _e46 = a[_e44];
        local_13 = _e46;
        let _e47 = local_13;
        let _e49 = local_10;
        let _e50 = local_11;
        local_14 = u32((_e49 + _e50));
        let _e55 = local_14;
        let _e57 = b[_e55];
        local_15 = _e57;
        let _e58 = local_15;
        let _e60 = local_2;
        local_3 = _e60;
        let _e62 = local_3;
        local_4 = u32(_e62);
        let _e65 = i;
        local_5 = u32(_e65);
        let _e69 = local_4;
        let _e70 = local_5;
        local_16 = u32((_e69 + _e70));
        let _e74 = local_16;
        out[_e74] = (_e47 + _e58);
    }
}
