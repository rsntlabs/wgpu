struct type_4 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_4;

fn kind(value_1: i32) -> u32 {
    return 2u;
}

@compute @workgroup_size(4, 1, 1)
fn exponent_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var value: f32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 4u));
    let _e17 = input[index];
    let value_2 = bitcast<f32>(_e17);
    counter = 0u;
    let _e23 = (bitcast<u32>(value_2) & 2147483647u);
    let _e25 = (_e23 >> 23u);
    output[base] = u32(select(select(select((i32(_e25) - 127i), (-118i - i32(countLeadingZeros(_e23))), (_e25 == 0u)), 2147483647i, (_e23 == 2139095040u)), i32(-2147483648), ((_e23 == 0u) || (_e23 > 2139095040u))));
    value = f32();
    value = value_2;
    let _e51 = counter;
    counter = (_e51 + u32(1i));
    let _e55 = value;
    let _e58 = (bitcast<u32>(_e55) & 2147483647u);
    let _e60 = (_e58 >> 23u);
    local = u32((base + 1u));
    let _e85 = local;
    output[_e85] = u32(select(select(select((i32(_e60) - 127i), (-118i - i32(countLeadingZeros(_e58))), (_e60 == 0u)), 2147483647i, (_e58 == 2139095040u)), i32(-2147483648), ((_e58 == 0u) || (_e58 > 2139095040u))));
    let _e87 = counter;
    local_1 = u32((base + 2u));
    let _e92 = local_1;
    output[_e92] = _e87;
    let _e96 = (bitcast<u32>(value_2) & 2147483647u);
    let _e98 = (_e96 >> 23u);
    let _e118 = kind(select(select(select((i32(_e98) - 127i), (-118i - i32(countLeadingZeros(_e96))), (_e98 == 0u)), 2147483647i, (_e96 == 2139095040u)), i32(-2147483648), ((_e96 == 0u) || (_e96 > 2139095040u))));
    local_2 = u32((base + 3u));
    let _e123 = local_2;
    output[_e123] = _e118;
}
