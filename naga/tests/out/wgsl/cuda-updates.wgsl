struct type_3 {
    value: i32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<uniform> value_1: type_3;

@compute @workgroup_size(1, 1, 1)
fn updates(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: array<u32, 2>;
    var value: i32;
    var previous: i32;
    var local_1: array<u32, 2>;
    var local_2: u32;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: i32;
    var local_6: array<u32, 2>;
    var local_7: u32;
    var local_8: u32;
    var local_9: i32;
    var local_10: array<u32, 2>;
    var local_11: u32;
    var local_12: u32;

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    let _e10 = value_1.value;
    value = _e10;
    let _e12 = value;
    value = (_e12 + 1i);
    previous = _e12;
    let _e16 = previous;
    let _e19 = local;
    local_1 = _e19;
    local_2 = u32(threadIdx.x);
    let _e24 = local_1;
    local_6 = _e24;
    let _e25 = local_2;
    let _e27 = local_6[1];
    local_6[1] = (_e27 + _e25);
    let _e31 = local_6[0];
    local_7 = u32(_e31);
    let _e35 = local_6[1];
    local_8 = u32(_e35);
    let _e39 = local_8;
    let _e41 = out[_e39];
    local_9 = _e41;
    let _e42 = local_9;
    local_5 = _e42;
    let _e44 = local_5;
    let _e46 = local_8;
    out[_e46] = (_e44 + _e16);
    let _e48 = value;
    value = (_e48 + 1i);
    let _e51 = value;
    let _e53 = local;
    local_3 = _e53;
    local_4 = u32(threadIdx.x);
    let _e58 = local_3;
    local_10 = _e58;
    let _e59 = local_4;
    let _e61 = local_10[1];
    local_10[1] = (_e61 + _e59);
    let _e65 = local_10[0];
    local_11 = u32(_e65);
    let _e69 = local_10[1];
    local_12 = u32(_e69);
    let _e72 = local_12;
    out[_e72] = _e51;
}
