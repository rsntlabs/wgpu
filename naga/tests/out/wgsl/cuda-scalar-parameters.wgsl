struct type_1 {
    value: f32,
}

@group(0) @binding(0)
var<uniform> factor_1: type_1;
@group(0) @binding(1)
var<storage> input_1: array<f32>;
@group(0) @binding(2)
var<storage, read_write> output_1: array<f32>;

@compute @workgroup_size(1, 1, 1)
fn scale(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var factor: f32;
    var input: array<u32, 2>;
    var output: array<u32, 2>;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: f32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var local_7: u32;
    var local_8: f32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var local_11: u32;

    let _e3 = factor_1.value;
    factor = _e3;
    input = array<u32, 2>();
    input[0] = 0u;
    input[1] = 0u;
    output = array<u32, 2>();
    output[0] = 1u;
    output[1] = 0u;
    let _e19 = factor;
    factor = (_e19 * 2f);
    let _e24 = input;
    local_2 = _e24;
    local_3 = u32(threadIdx.x);
    let _e29 = local_2;
    local_5 = _e29;
    let _e30 = local_3;
    let _e32 = local_5[1];
    local_5[1] = (_e32 + _e30);
    let _e36 = local_5[0];
    local_6 = u32(_e36);
    let _e40 = local_5[1];
    local_7 = u32(_e40);
    let _e44 = local_7;
    let _e46 = input_1[_e44];
    local_8 = _e46;
    let _e47 = local_8;
    local_4 = _e47;
    let _e49 = local_4;
    let _e50 = factor;
    let _e54 = output;
    local = _e54;
    local_1 = u32(threadIdx.x);
    let _e59 = local;
    local_9 = _e59;
    let _e60 = local_1;
    let _e62 = local_9[1];
    local_9[1] = (_e62 + _e60);
    let _e66 = local_9[0];
    local_10 = u32(_e66);
    let _e70 = local_9[1];
    local_11 = u32(_e70);
    let _e73 = local_11;
    output_1[_e73] = (_e49 * _e50);
}
