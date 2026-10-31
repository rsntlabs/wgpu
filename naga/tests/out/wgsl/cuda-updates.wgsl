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

    let _e3 = value_1.value;
    value = _e3;
    let previous = value;
    value = (previous + 1i);
    local = u32(threadIdx.x);
    let _e11 = local;
    let _e14 = out[_e11];
    out[_e11] = (_e14 + previous);
    let _e17 = value;
    value = (_e17 + 1i);
    let _e20 = value;
    local_1 = u32(threadIdx.x);
    let _e24 = local_1;
    out[_e24] = _e20;
}
