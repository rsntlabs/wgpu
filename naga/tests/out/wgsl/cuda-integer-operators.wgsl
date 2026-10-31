struct type_3 {
    value: i32,
}

struct type_4 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;
@group(0) @binding(1)
var<uniform> value: type_3;
@group(0) @binding(2)
var<uniform> amount: type_4;

@compute @workgroup_size(1, 1, 1)
fn integer_ops(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var bits: u32;
    var local: u32;
    var local_1: u32;

    let value_1 = value.value;
    let amount_1 = amount.value;
    let remainder = (value_1 % -(3i));
    bits = (u32(remainder) & 15u);
    let _e14 = bits;
    bits = (_e14 | 8u);
    let _e17 = bits;
    bits = (_e17 ^ 1u);
    let _e20 = bits;
    bits = (_e20 << amount_1);
    let _e22 = bits;
    bits = (_e22 >> 1u);
    let _e25 = bits;
    bits = (_e25 % 97u);
    let _e28 = bits;
    bits = (_e28 & 255u);
    let _e31 = bits;
    local = u32(threadIdx.x);
    let _e36 = local;
    local_1 = u32(_e36);
    let _e39 = local_1;
    out[_e39] = ~(_e31);
}
