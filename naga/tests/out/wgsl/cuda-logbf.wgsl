struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_3;

fn kind(value_1: f32) -> u32 {
    return 1u;
}

@compute @workgroup_size(4, 1, 1)
fn exponent_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
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
    let _e38 = (_e23 > 2139095040u);
    local = select(select(bitcast<u32>(f32(select((i32(_e25) - 127i), (-118i - i32(countLeadingZeros(_e23))), (_e25 == 0u)))), 2139095040u, (_e23 == 2139095040u)), select(4286578688u, 2143289344u, _e38), ((_e23 == 0u) || _e38));
    let _e50 = local;
    output[base] = bitcast<u32>(bitcast<f32>(_e50));
    value = f32();
    value = value_2;
    let _e58 = counter;
    counter = (_e58 + u32(1i));
    let _e62 = value;
    let _e65 = (bitcast<u32>(_e62) & 2147483647u);
    let _e67 = (_e65 >> 23u);
    let _e80 = (_e65 > 2139095040u);
    local_2 = select(select(bitcast<u32>(f32(select((i32(_e67) - 127i), (-118i - i32(countLeadingZeros(_e65))), (_e67 == 0u)))), 2139095040u, (_e65 == 2139095040u)), select(4286578688u, 2143289344u, _e80), ((_e65 == 0u) || _e80));
    let _e92 = local_2;
    local_1 = u32((base + 1u));
    let _e99 = local_1;
    output[_e99] = bitcast<u32>(bitcast<f32>(_e92));
    let _e101 = counter;
    local_3 = u32((base + 2u));
    let _e106 = local_3;
    output[_e106] = _e101;
    let _e110 = (bitcast<u32>(value_2) & 2147483647u);
    let _e112 = (_e110 >> 23u);
    let _e125 = (_e110 > 2139095040u);
    local_5 = select(select(bitcast<u32>(f32(select((i32(_e112) - 127i), (-118i - i32(countLeadingZeros(_e110))), (_e112 == 0u)))), 2139095040u, (_e110 == 2139095040u)), select(4286578688u, 2143289344u, _e125), ((_e110 == 0u) || _e125));
    let _e137 = local_5;
    let _e139 = kind(bitcast<f32>(_e137));
    local_4 = u32((base + 3u));
    let _e144 = local_4;
    output[_e144] = _e139;
}
