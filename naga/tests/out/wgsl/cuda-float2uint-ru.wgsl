struct type_4 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_4;

fn forward(value: f32) -> f32 {
    return value;
}

fn gen__naga_ceilf(input_bits: u32) -> u32 {
    let _e5 = (input_bits & 2147483647u);
    let _e6 = (input_bits & 2147483648u);
    let _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e14 = (_e13 - 1u);
    let _e18 = (input_bits & ~(_e14));
    return select(select(select(select(_e18, (_e18 + _e13), ((_e6 == 0u) && ((input_bits & _e14) != 0u))), select((_e6 | ((1u - (_e6 >> 31u)) * 1065353216u)), input_bits, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

@compute @workgroup_size(4, 1, 1)
fn convert_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: f32;
    var local_5: f32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: i32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: f32;
    var local_14: u32;
    var local_15: f32;
    var extra: i32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 8u));
    let _e17 = input[index];
    let value_1 = bitcast<f32>(_e17);
    counter = 0u;
    let _e22 = gen__naga_ceilf(bitcast<u32>(value_1));
    output[base] = u32(bitcast<f32>(_e22));
    let _e27 = forward(value_1);
    let _e29 = gen__naga_ceilf(bitcast<u32>(_e27));
    local = u32((base + 1u));
    let _e36 = local;
    output[_e36] = u32(bitcast<f32>(_e29));
    let _e38 = counter;
    counter = (_e38 + u32(1i));
    let _e43 = gen__naga_ceilf(bitcast<u32>(value_1));
    local_1 = u32((base + 2u));
    let _e50 = local_1;
    output[_e50] = u32(bitcast<f32>(_e43));
    let _e52 = counter;
    local_2 = u32((base + 3u));
    let _e59 = local_2;
    output[_e59] = u32(i32(_e52));
    if ((index & 1u) != 0u) {
        let _e65 = counter;
        local_12 = _e65;
        let _e67 = local_12;
        counter = (_e67 + u32(1i));
        local_13 = value_1;
        let _e72 = local_13;
        local_4 = _e72;
        let _e74 = local_4;
        let _e76 = gen__naga_ceilf(bitcast<u32>(_e74));
        local_6 = u32(bitcast<f32>(_e76));
    } else {
        let _e80 = counter;
        local_14 = _e80;
        let _e82 = local_14;
        counter = (_e82 + u32(1i));
        local_15 = value_1;
        let _e87 = local_15;
        local_5 = _e87;
        let _e89 = local_5;
        let _e91 = gen__naga_ceilf(bitcast<u32>(_e89));
        local_6 = u32(bitcast<f32>(_e91));
    }
    let _e96 = local_6;
    local_3 = u32((base + 4u));
    let _e101 = local_3;
    output[_e101] = _e96;
    let _e103 = counter;
    local_7 = u32((base + 5u));
    let _e110 = local_7;
    output[_e110] = u32(i32(_e103));
    let _e115 = gen__naga_ceilf(bitcast<u32>(f32(16777217u)));
    local_8 = u32((base + 6u));
    let _e122 = local_8;
    output[_e122] = u32(bitcast<f32>(_e115));
    local_9 = 7i;
    extra = i32();
    extra = 3i;
    let _e130 = local_9;
    let _e131 = extra;
    local_11 = u32((_e130 + _e131));
    let _e135 = local_11;
    local_10 = u32((base + 7u));
    let _e140 = local_10;
    output[_e140] = _e135;
}
