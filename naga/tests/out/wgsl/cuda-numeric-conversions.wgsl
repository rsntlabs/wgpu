struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<f32>;
@group(0) @binding(1)
var<storage, read_write> output: array<f32>;
@group(0) @binding(2)
var<uniform> n_1: type_3;

@compute @workgroup_size(1, 1, 1)
fn convert(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: array<u32, 2>;
    var local_1: array<u32, 2>;
    var n: u32;
    var i: i32;
    var offset: f32;
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

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    local_1 = array<u32, 2>();
    local_1[0] = 1u;
    local_1[1] = 0u;
    let _e18 = n_1.value;
    n = _e18;
    i = i32(((blockIdx.x * 1u) + threadIdx.x));
    let _e27 = i;
    let _e29 = n;
    if (u32(_e27) < _e29) {
        let _e31 = i;
        offset = f32(_e31);
        let _e36 = local;
        local_4 = _e36;
        let _e37 = i;
        local_5 = u32(_e37);
        let _e41 = local_4;
        local_7 = _e41;
        let _e42 = local_5;
        let _e44 = local_7[1];
        local_7[1] = (_e44 + _e42);
        let _e48 = local_7[0];
        local_8 = u32(_e48);
        let _e52 = local_7[1];
        local_9 = u32(_e52);
        let _e56 = local_9;
        let _e58 = input[_e56];
        local_10 = _e58;
        let _e59 = local_10;
        local_6 = _e59;
        let _e61 = local_6;
        let _e62 = offset;
        let _e66 = local_1;
        local_2 = _e66;
        let _e67 = i;
        local_3 = u32(_e67);
        let _e71 = local_2;
        local_11 = _e71;
        let _e72 = local_3;
        let _e74 = local_11[1];
        local_11[1] = (_e74 + _e72);
        let _e78 = local_11[0];
        local_12 = u32(_e78);
        let _e82 = local_11[1];
        local_13 = u32(_e82);
        let _e85 = local_13;
        output[_e85] = (_e61 + _e62);
    }
}
