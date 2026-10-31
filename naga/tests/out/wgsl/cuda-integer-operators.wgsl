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
    var local: array<u32, 2>;
    var value: i32;
    var amount: u32;
    var remainder: i32;
    var bits: u32;
    var local_1: u32;
    var local_2: array<u32, 2>;
    var local_3: u32;
    var local_4: array<u32, 2>;
    var local_5: u32;
    var local_6: u32;

    local = array<u32, 2>();
    local[0] = 0u;
    local[1] = 0u;
    let _e10 = value_1.value;
    value = _e10;
    let _e14 = amount_1.value;
    amount = _e14;
    let _e18 = value;
    remainder = (_e18 % -(3i));
    let _e21 = remainder;
    bits = (u32(_e21) & 15u);
    let _e26 = bits;
    bits = (_e26 | 8u);
    let _e29 = bits;
    bits = (_e29 ^ 1u);
    let _e32 = amount;
    let _e33 = bits;
    local_1 = _e32;
    let _e35 = local_1;
    bits = (_e33 << _e35);
    let _e37 = bits;
    bits = (_e37 >> 1u);
    let _e40 = bits;
    bits = (_e40 % 97u);
    let _e43 = bits;
    bits = (_e43 & 255u);
    let _e46 = bits;
    let _e50 = local;
    local_2 = _e50;
    local_3 = u32(threadIdx.x);
    let _e55 = local_2;
    local_4 = _e55;
    let _e56 = local_3;
    let _e58 = local_4[1];
    local_4[1] = (_e58 + _e56);
    let _e62 = local_4[0];
    local_5 = u32(_e62);
    let _e66 = local_4[1];
    local_6 = u32(_e66);
    let _e69 = local_6;
    out[_e69] = ~(_e46);
}
