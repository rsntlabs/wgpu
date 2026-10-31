struct type_3 {
    value: i32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<i32>;
@group(0) @binding(1)
var<uniform> value_1: type_3;

@compute @workgroup_size(1, 1, 1)
fn updates(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var out: array<u32, 2>;
    var value: i32;
    var previous: i32;
    var local: array<u32, 2>;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: i32;
    var local_5: array<u32, 2>;
    var local_6: u32;
    var local_7: u32;
    var local_8: i32;
    var local_9: array<u32, 2>;
    var local_10: u32;
    var local_11: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    let _e10 = value_1.value;
    value = _e10;
    let _e12 = value;
    value = (_e12 + 1i);
    previous = _e12;
    let _e16 = previous;
    let _e19 = out;
    local = _e19;
    local_1 = u32(threadIdx.x);
    let _e24 = local;
    local_5 = _e24;
    let _e25 = local_1;
    let _e27 = local_5[1];
    local_5[1] = (_e27 + _e25);
    let _e31 = local_5[0];
    local_6 = u32(_e31);
    let _e35 = local_5[1];
    local_7 = u32(_e35);
    let _e39 = local_7;
    let _e41 = out_1[_e39];
    local_8 = _e41;
    let _e42 = local_8;
    local_4 = _e42;
    let _e44 = local_4;
    let _e46 = local_7;
    out_1[_e46] = (_e44 + _e16);
    let _e48 = value;
    value = (_e48 + 1i);
    let _e51 = value;
    let _e53 = out;
    local_2 = _e53;
    local_3 = u32(threadIdx.x);
    let _e58 = local_2;
    local_9 = _e58;
    let _e59 = local_3;
    let _e61 = local_9[1];
    local_9[1] = (_e61 + _e59);
    let _e65 = local_9[0];
    local_10 = u32(_e65);
    let _e69 = local_9[1];
    local_11 = u32(_e69);
    let _e72 = local_11;
    out_1[_e72] = _e51;
}
