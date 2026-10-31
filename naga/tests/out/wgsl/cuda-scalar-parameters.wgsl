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
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: f32;
    var local_7: array<u32, 2>;
    var local_8: u32;
    var local_9: u32;
    var local_10: f32;
    var local_11: array<u32, 2>;
    var local_12: u32;
    var local_13: u32;

    let _e3 = factor_1.value;
    factor = _e3;
    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = array<u32, 2>();
    local_1[0] = 1u;
    local_1[1] = 0u;
    let _e19 = factor;
    factor = (_e19 * 2f);
    let _e24 = local;
    local_4 = _e24;
    local_5 = u32(threadIdx.x);
    let _e29 = local_4;
    local_7 = _e29;
    let _e30 = local_5;
    let _e32 = local_7[1];
    local_7[1] = (_e32 + _e30);
    let _e36 = local_7[0];
    local_8 = u32(_e36);
    let _e40 = local_7[1];
    local_9 = u32(_e40);
    let _e44 = local_9;
    let _e46 = input[_e44];
    local_10 = _e46;
    let _e47 = local_10;
    local_6 = _e47;
    let _e49 = local_6;
    let _e50 = factor;
    let _e54 = local_1;
    local_2 = _e54;
    local_3 = u32(threadIdx.x);
    let _e59 = local_2;
    local_11 = _e59;
    let _e60 = local_3;
    let _e62 = local_11[1];
    local_11[1] = (_e62 + _e60);
    let _e66 = local_11[0];
    local_12 = u32(_e66);
    let _e70 = local_11[1];
    local_13 = u32(_e70);
    let _e73 = local_13;
    output[_e73] = (_e49 * _e50);
}
