struct type_3 {
    value: i32,
}

struct type_4 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out_1: array<u32>;
@group(0) @binding(1)
var<uniform> value: type_3;
@group(0) @binding(2)
var<uniform> amount: type_4;

@compute @workgroup_size(1, 1, 1)
fn integer_ops(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var out: array<u32, 2>;
    var bits: u32;
    var local: u32;
    var local_1: array<u32, 2>;
    var local_2: u32;
    var local_3: array<u32, 2>;
    var local_4: u32;
    var local_5: u32;

    out = array<u32, 2>();
    out[0] = 0u;
    out[1] = 0u;
    let value_1 = value.value;
    let amount_1 = amount.value;
    let remainder = (value_1 % -(3i));
    bits = (u32(remainder) & 15u);
    let _e20 = bits;
    bits = (_e20 | 8u);
    let _e23 = bits;
    bits = (_e23 ^ 1u);
    let _e26 = bits;
    local = amount_1;
    let _e28 = local;
    bits = (_e26 << _e28);
    let _e30 = bits;
    bits = (_e30 >> 1u);
    let _e33 = bits;
    bits = (_e33 % 97u);
    let _e36 = bits;
    bits = (_e36 & 255u);
    let _e39 = bits;
    let _e42 = out;
    local_1 = _e42;
    local_2 = u32(threadIdx.x);
    let _e47 = local_1;
    local_3 = _e47;
    let _e49 = local_2;
    let _e51 = local_3[1];
    local_3[1] = (_e51 + _e49);
    let _e55 = local_3[0];
    local_4 = u32(_e55);
    let _e59 = local_3[1];
    local_5 = u32(_e59);
    let _e62 = local_5;
    out_1[_e62] = ~(_e39);
}
