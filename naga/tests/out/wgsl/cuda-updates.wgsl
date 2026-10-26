struct type_3 {
    value: i32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<uniform> value_1: type_3;

@compute @workgroup_size(1, 1, 1)
fn updates(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var value: i32;
    var previous: i32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: i32;
    var local_9: u32;

    local = 0u;
    let _e5 = value_1.value;
    value = _e5;
    let _e7 = value;
    value = (_e7 + 1i);
    previous = _e7;
    let _e11 = previous;
    let _e12 = local;
    local_1 = _e12;
    let _e14 = local_1;
    local_2 = u32(_e14);
    local_3 = u32(threadIdx.x);
    let _e21 = local_2;
    let _e22 = local_3;
    local_7 = u32((_e21 + _e22));
    let _e27 = local_7;
    let _e29 = out[_e27];
    local_8 = _e29;
    let _e30 = local_8;
    let _e32 = local_7;
    out[_e32] = (_e30 + _e11);
    let _e34 = value;
    value = (_e34 + 1i);
    let _e37 = value;
    let _e38 = local;
    local_4 = _e38;
    let _e40 = local_4;
    local_5 = u32(_e40);
    local_6 = u32(threadIdx.x);
    let _e46 = local_5;
    let _e47 = local_6;
    local_9 = u32((_e46 + _e47));
    let _e51 = local_9;
    out[_e51] = _e37;
}
