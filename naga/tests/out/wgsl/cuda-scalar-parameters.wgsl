struct type_1 {
    value: f32,
}

@group(0) @binding(0)
var<uniform> factor_1: type_1;
@group(0) @binding(1)
var<storage> input: array<f32>;
@group(0) @binding(2)
var<storage, read_write> output: array<f32>;

@compute @workgroup_size(1, 1, 1)
fn scale(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var factor: f32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: f32;
    var local_10: u32;

    let _e3 = factor_1.value;
    factor = _e3;
    local = 0u;
    local_1 = 0u;
    let _e9 = factor;
    factor = (_e9 * 2f);
    let _e12 = local;
    local_5 = _e12;
    let _e14 = local_5;
    local_6 = u32(_e14);
    local_7 = u32(threadIdx.x);
    let _e21 = local_6;
    let _e22 = local_7;
    local_8 = u32((_e21 + _e22));
    let _e27 = local_8;
    let _e29 = input[_e27];
    local_9 = _e29;
    let _e30 = local_9;
    let _e31 = factor;
    let _e33 = local_1;
    local_2 = _e33;
    let _e35 = local_2;
    local_3 = u32(_e35);
    local_4 = u32(threadIdx.x);
    let _e42 = local_3;
    let _e43 = local_4;
    local_10 = u32((_e42 + _e43));
    let _e47 = local_10;
    output[_e47] = (_e30 * _e31);
}
