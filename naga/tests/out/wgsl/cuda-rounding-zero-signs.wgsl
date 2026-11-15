@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_floorf(input_bits: u32) -> u32 {
    let _e5 = (input_bits & 2147483647u);
    let _e6 = (input_bits & 2147483648u);
    let _e14 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e15 = (_e14 - 1u);
    let _e19 = (input_bits & ~(_e15));
    return select(select(select(select(_e19, (_e19 + _e14), ((_e6 != 0u) && ((input_bits & _e15) != 0u))), select((_e6 | ((_e6 >> 31u) * 1065353216u)), input_bits, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

fn floor_value(value: f32) -> f32 {
    let _e2 = gen__naga_floorf(bitcast<u32>(value));
    return bitcast<f32>(_e2);
}

fn gen__naga_ceilf(input_bits_1: u32) -> u32 {
    let _e5 = (input_bits_1 & 2147483647u);
    let _e6 = (input_bits_1 & 2147483648u);
    let _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e14 = (_e13 - 1u);
    let _e18 = (input_bits_1 & ~(_e14));
    return select(select(select(select(_e18, (_e18 + _e13), ((_e6 == 0u) && ((input_bits_1 & _e14) != 0u))), select((_e6 | ((1u - (_e6 >> 31u)) * 1065353216u)), input_bits_1, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits_1, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

fn ceil_value(value_1: f32) -> f32 {
    let _e2 = gen__naga_ceilf(bitcast<u32>(value_1));
    return bitcast<f32>(_e2);
}

@compute @workgroup_size(12, 1, 1)
fn rounding_zero_signs(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var cursor: i32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;

    let index = threadIdx.x;
    let bits = input[index];
    let base = (4u + (index * 14u));
    let _e11 = gen__naga_floorf(bitcast<u32>(bitcast<f32>(bits)));
    output[base] = bitcast<u32>(bitcast<f32>(_e11));
    let _e18 = gen__naga_ceilf(bitcast<u32>(bitcast<f32>(bits)));
    local = u32((base + 1u));
    let _e25 = local;
    output[_e25] = bitcast<u32>(bitcast<f32>(_e18));
    let _e28 = floor_value(bitcast<f32>(bits));
    local_1 = u32((base + 2u));
    let _e34 = local_1;
    output[_e34] = bitcast<u32>(_e28);
    let _e37 = ceil_value(bitcast<f32>(bits));
    local_2 = u32((base + 3u));
    let _e43 = local_2;
    output[_e43] = bitcast<u32>(_e37);
    let _e47 = gen__naga_floorf(bitcast<u32>(0f));
    local_3 = u32((base + 4u));
    let _e54 = local_3;
    output[_e54] = bitcast<u32>(bitcast<f32>(_e47));
    let _e59 = gen__naga_floorf(bitcast<u32>(-(0f)));
    local_4 = u32((base + 5u));
    let _e66 = local_4;
    output[_e66] = bitcast<u32>(bitcast<f32>(_e59));
    let _e70 = gen__naga_ceilf(bitcast<u32>(0f));
    local_5 = u32((base + 6u));
    let _e77 = local_5;
    output[_e77] = bitcast<u32>(bitcast<f32>(_e70));
    let _e82 = gen__naga_ceilf(bitcast<u32>(-(0f)));
    local_6 = u32((base + 7u));
    let _e89 = local_6;
    output[_e89] = bitcast<u32>(bitcast<f32>(_e82));
    let _e93 = gen__naga_floorf(bitcast<u32>(0.25f));
    local_7 = u32((base + 8u));
    let _e100 = local_7;
    output[_e100] = bitcast<u32>(bitcast<f32>(_e93));
    let _e105 = gen__naga_ceilf(bitcast<u32>(-(0.25f)));
    local_8 = u32((base + 9u));
    let _e112 = local_8;
    output[_e112] = bitcast<u32>(bitcast<f32>(_e105));
    cursor = 0i;
    let _e116 = cursor;
    cursor = (_e116 + 1i);
    local_10 = u32((index + u32(_e116)));
    let _e123 = local_10;
    let _e125 = input[_e123];
    let _e127 = floor_value(bitcast<f32>(_e125));
    local_9 = u32((base + 10u));
    let _e133 = local_9;
    output[_e133] = bitcast<u32>(_e127);
    let _e135 = cursor;
    cursor = (_e135 + 1i);
    let _e139 = ceil_value(f32(_e135));
    local_11 = u32((base + 11u));
    let _e145 = local_11;
    output[_e145] = bitcast<u32>(_e139);
    let _e147 = cursor;
    local_12 = u32((base + 12u));
    let _e155 = local_12;
    output[_e155] = u32((_e147 - 1i));
    let _e157 = cursor;
    local_13 = u32((base + 13u));
    let _e163 = local_13;
    output[_e163] = u32(_e157);
}
