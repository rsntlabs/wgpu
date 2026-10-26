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
    var local: u32;
    var local_1: u32;
    var n: u32;
    var i: i32;
    var offset: f32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: f32;
    var local_10: u32;

    local = 0u;
    local_1 = 0u;
    let _e8 = n_1.value;
    n = _e8;
    i = i32(((blockIdx.x * 1u) + threadIdx.x));
    let _e17 = i;
    let _e19 = n;
    if (u32(_e17) < _e19) {
        let _e21 = i;
        offset = f32(_e21);
        let _e24 = local;
        local_5 = _e24;
        let _e26 = local_5;
        local_6 = u32(_e26);
        let _e29 = i;
        local_7 = u32(_e29);
        let _e33 = local_6;
        let _e34 = local_7;
        local_8 = u32((_e33 + _e34));
        let _e39 = local_8;
        let _e41 = input[_e39];
        local_9 = _e41;
        let _e42 = local_9;
        let _e43 = offset;
        let _e45 = local_1;
        local_2 = _e45;
        let _e47 = local_2;
        local_3 = u32(_e47);
        let _e50 = i;
        local_4 = u32(_e50);
        let _e54 = local_3;
        let _e55 = local_4;
        local_10 = u32((_e54 + _e55));
        let _e59 = local_10;
        output[_e59] = (_e42 + _e43);
    }
}
