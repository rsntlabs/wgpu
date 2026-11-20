struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<i32>;
@group(0) @binding(2)
var<uniform> count: type_5;

fn forward(value: f32) -> f32 {
    return value;
}

fn gen__naga_floorf(input_bits: u32) -> u32 {
    let _e5 = (input_bits & 2147483647u);
    let _e6 = (input_bits & 2147483648u);
    let _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e15 = (_e14 - 1u);
    let _e19 = (input_bits & ~(_e15));
    return select(select(select(select(_e19, (_e19 + _e14), ((_e6 != 0u) && ((input_bits & _e15) != 0u))), select((_e6 | ((_e6 >> 31u) * 1065353216u)), input_bits, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
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
    var local_6: i32;
    var local_7: u32;
    var local_8: u32;
    var local_9: i32;
    var local_10: u32;
    var local_11: i32;
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
    let _e22 = gen__naga_floorf(bitcast<u32>(value_1));
    output[base] = i32(bitcast<f32>(_e22));
    let _e27 = forward(value_1);
    let _e29 = gen__naga_floorf(bitcast<u32>(_e27));
    local = u32((base + 1u));
    let _e36 = local;
    output[_e36] = i32(bitcast<f32>(_e29));
    let _e38 = counter;
    counter = (_e38 + u32(1i));
    let _e43 = gen__naga_floorf(bitcast<u32>(value_1));
    local_1 = u32((base + 2u));
    let _e50 = local_1;
    output[_e50] = i32(bitcast<f32>(_e43));
    let _e52 = counter;
    local_2 = u32((base + 3u));
    let _e58 = local_2;
    output[_e58] = i32(_e52);
    if ((index & 1u) != 0u) {
        let _e64 = counter;
        local_12 = _e64;
        let _e66 = local_12;
        counter = (_e66 + u32(1i));
        local_13 = value_1;
        let _e71 = local_13;
        local_4 = _e71;
        let _e73 = local_4;
        let _e75 = gen__naga_floorf(bitcast<u32>(_e73));
        local_6 = i32(bitcast<f32>(_e75));
    } else {
        let _e79 = counter;
        local_14 = _e79;
        let _e81 = local_14;
        counter = (_e81 + u32(1i));
        local_15 = value_1;
        let _e86 = local_15;
        local_5 = _e86;
        let _e88 = local_5;
        let _e90 = gen__naga_floorf(bitcast<u32>(_e88));
        local_6 = i32(bitcast<f32>(_e90));
    }
    let _e95 = local_6;
    local_3 = u32((base + 4u));
    let _e100 = local_3;
    output[_e100] = _e95;
    let _e102 = counter;
    local_7 = u32((base + 5u));
    let _e108 = local_7;
    output[_e108] = i32(_e102);
    let _e113 = gen__naga_floorf(bitcast<u32>(f32(16777217i)));
    local_8 = u32((base + 6u));
    let _e120 = local_8;
    output[_e120] = i32(bitcast<f32>(_e113));
    local_9 = 7i;
    extra = i32();
    extra = 3i;
    let _e128 = local_9;
    let _e129 = extra;
    local_11 = (_e128 + _e129);
    let _e132 = local_11;
    local_10 = u32((base + 7u));
    let _e137 = local_10;
    output[_e137] = _e132;
}
