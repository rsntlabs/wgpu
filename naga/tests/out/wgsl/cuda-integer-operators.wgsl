struct type_3 {
    value: i32,
}

struct type_4 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> out: array<u32>;
@group(0) @binding(1)
var<uniform> value_1: type_3;
@group(0) @binding(2)
var<uniform> amount_1: type_4;

@compute @workgroup_size(1, 1, 1)
fn integer_ops(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var value: i32;
    var amount: u32;
    var remainder: i32;
    var bits: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;

    local = 0u;
    let _e5 = value_1.value;
    value = _e5;
    let _e9 = amount_1.value;
    amount = _e9;
    let _e13 = value;
    remainder = (_e13 % -(3i));
    let _e16 = remainder;
    bits = (u32(_e16) & 15u);
    let _e21 = bits;
    bits = (_e21 | 8u);
    let _e24 = bits;
    bits = (_e24 ^ 1u);
    let _e27 = amount;
    let _e28 = bits;
    local_1 = _e27;
    let _e30 = local_1;
    bits = (_e28 << _e30);
    let _e32 = bits;
    bits = (_e32 >> 1u);
    let _e35 = bits;
    bits = (_e35 % 97u);
    let _e38 = bits;
    bits = (_e38 & 255u);
    let _e41 = bits;
    let _e43 = local;
    local_2 = _e43;
    let _e45 = local_2;
    local_3 = u32(_e45);
    local_4 = u32(threadIdx.x);
    let _e52 = local_3;
    let _e53 = local_4;
    local_5 = u32((_e52 + _e53));
    let _e57 = local_5;
    out[_e57] = ~(_e41);
}
