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
    i = ((blockIdx.x * 1u) + threadIdx.x);
    let _e14 = local;
    local_6 = _e14;
    let _e16 = local_6;
    local_7 = u32(_e16);
    let _e19 = i;
    local_8 = u32(_e19);
    let _e22 = local_1;
    local_9 = _e22;
    let _e24 = local_9;
    local_10 = u32(_e24);
    let _e27 = i;
    local_11 = u32(_e27);
    let _e31 = local_10;
    let _e32 = local_11;
    local_12 = u32((_e31 + _e32));
    let _e37 = local_12;
    let _e39 = b[_e37];
    local_13 = _e39;
    let _e40 = local_13;
    let _e44 = local_7;
    let _e45 = local_8;
    local_14 = u32((_e44 + _e45));
    let _e50 = local_14;
    let _e52 = a[_e50];
    local_15 = _e52;
    let _e53 = local_15;
    let _e55 = local_2;
    local_3 = _e55;
    let _e57 = local_3;
    local_4 = u32(_e57);
    let _e60 = i;
    local_5 = u32(_e60);
    let _e64 = local_4;
    let _e65 = local_5;
    local_16 = u32((_e64 + _e65));
    let _e69 = local_16;
    out[_e69] = (_e53 + (_e40 * 2f));
}
