struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input_1: array<f32>;
@group(0) @binding(1)
var<storage, read_write> output_1: array<f32>;
@group(0) @binding(2)
var<uniform> n: type_3;

@compute @workgroup_size(1, 1, 1)
fn convert(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var input: array<u32, 2>;
    var output: array<u32, 2>;
    var offset: f32;
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

    input = array<u32, 2>();
    input[0] = 0u;
    input[1] = 0u;
    output = array<u32, 2>();
    output[0] = 1u;
    output[1] = 0u;
    let n_1 = n.value;
    let i = i32(((blockIdx.x * 1u) + threadIdx.x));
    if (u32(i) < n_1) {
        offset = f32(i);
        let _e28 = input;
        local_2 = _e28;
        local_3 = u32(i);
        let _e32 = local_2;
        local_5 = _e32;
        let _e34 = local_3;
        let _e36 = local_5[1];
        local_5[1] = (_e36 + _e34);
        let _e40 = local_5[0];
        local_6 = u32(_e40);
        let _e44 = local_5[1];
        local_7 = u32(_e44);
        let _e47 = local_7;
        let _e50 = input_1[_e47];
        local_8 = _e50;
        let _e52 = local_8;
        local_4 = _e52;
        let _e54 = local_4;
        let _e55 = offset;
        let _e58 = output;
        local = _e58;
        local_1 = u32(i);
        let _e62 = local;
        local_9 = _e62;
        let _e64 = local_1;
        let _e66 = local_9[1];
        local_9[1] = (_e66 + _e64);
        let _e70 = local_9[0];
        local_10 = u32(_e70);
        let _e74 = local_9[1];
        local_11 = u32(_e74);
        let _e77 = local_11;
        output_1[_e77] = (_e54 + _e55);
    }
}
