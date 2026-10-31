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
    let _e9 = value_1.value;
    value = _e9;
    let previous = value;
    value = (previous + 1i);
    let _e15 = out;
    local = _e15;
    local_1 = u32(threadIdx.x);
    let _e20 = local;
    local_5 = _e20;
    let _e22 = local_1;
    let _e24 = local_5[1];
    local_5[1] = (_e24 + _e22);
    let _e28 = local_5[0];
    local_6 = u32(_e28);
    let _e32 = local_5[1];
    local_7 = u32(_e32);
    let _e35 = local_7;
    let _e38 = out_1[_e35];
    local_8 = _e38;
    let _e40 = local_8;
    local_4 = _e40;
    let _e42 = local_4;
    let _e44 = local_7;
    out_1[_e44] = (_e42 + previous);
    let _e46 = value;
    value = (_e46 + 1i);
    let _e49 = value;
    let _e50 = out;
    local_2 = _e50;
    local_3 = u32(threadIdx.x);
    let _e55 = local_2;
    local_9 = _e55;
    let _e57 = local_3;
    let _e59 = local_9[1];
    local_9[1] = (_e59 + _e57);
    let _e63 = local_9[0];
    local_10 = u32(_e63);
    let _e67 = local_9[1];
    local_11 = u32(_e67);
    let _e70 = local_11;
    out_1[_e70] = _e49;
}
