struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input_1: array<f32>;
@group(0) @binding(1)
var<storage, read_write> output_1: array<f32>;
@group(0) @binding(2)
var<uniform> n_1: type_3;

@compute @workgroup_size(1, 1, 1)
fn convert(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var input: array<u32, 2>;
    var output: array<u32, 2>;
    var n: u32;
    var i: i32;
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
    let _e18 = n_1.value;
    n = _e18;
    i = i32(((blockIdx.x * 1u) + threadIdx.x));
    let _e27 = i;
    let _e29 = n;
    if (u32(_e27) < _e29) {
        let _e31 = i;
        offset = f32(_e31);
        let _e36 = input;
        local_2 = _e36;
        let _e37 = i;
        local_3 = u32(_e37);
        let _e41 = local_2;
        local_5 = _e41;
        let _e42 = local_3;
        let _e44 = local_5[1];
        local_5[1] = (_e44 + _e42);
        let _e48 = local_5[0];
        local_6 = u32(_e48);
        let _e52 = local_5[1];
        local_7 = u32(_e52);
        let _e56 = local_7;
        let _e58 = input_1[_e56];
        local_8 = _e58;
        let _e59 = local_8;
        local_4 = _e59;
        let _e61 = local_4;
        let _e62 = offset;
        let _e66 = output;
        local = _e66;
        let _e67 = i;
        local_1 = u32(_e67);
        let _e71 = local;
        local_9 = _e71;
        let _e72 = local_1;
        let _e74 = local_9[1];
        local_9[1] = (_e74 + _e72);
        let _e78 = local_9[0];
        local_10 = u32(_e78);
        let _e82 = local_9[1];
        local_11 = u32(_e82);
        let _e85 = local_11;
        output_1[_e85] = (_e61 + _e62);
    }
}
