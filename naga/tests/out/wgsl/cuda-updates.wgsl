struct type_3 {
    value: i32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<i32>;
@group(0) @binding(1)
var<uniform> value_1: type_3;

@compute @workgroup_size(1, 1, 1)
fn updates(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var value: i32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;

    let _e3 = value_1.value;
    value = _e3;
    let previous = value;
    value = (previous + 1i);
    local = u32(threadIdx.x);
    let _e11 = local;
    local_2 = u32(_e11);
    let _e14 = local_2;
    let _e17 = out[_e14];
    let _e19 = local_2;
    out[_e19] = (_e17 + previous);
    let _e21 = value;
    value = (_e21 + 1i);
    let _e24 = value;
    local_1 = u32(threadIdx.x);
    let _e28 = local_1;
    local_3 = u32(_e28);
    let _e31 = local_3;
    out[_e31] = _e24;
}
