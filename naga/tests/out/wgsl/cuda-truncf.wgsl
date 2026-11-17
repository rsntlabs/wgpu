@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_truncf(input_bits: u32) -> u32 {
    let _e4 = (input_bits & 2147483647u);
    return select(select(select((input_bits & ~(((1u << ((150u - (_e4 >> 23u)) & 31u)) - 1u))), (input_bits & 2147483648u), (_e4 < 1065353216u)), input_bits, (_e4 >= 1258291200u)), 2143289344u, (_e4 > 2139095040u));
}

fn truncated(value: f32) -> f32 {
    let _e2 = gen__naga_truncf(bitcast<u32>(value));
    return bitcast<f32>(_e2);
}

fn truncf(value_1: bool) -> i32 {
    var local_15: i32;

    if value_1 {
        local_15 = 7i;
    } else {
        local_15 = 9i;
    }
    let _e6 = local_15;
    return _e6;
}

fn gen__naga_fabsf(input_bits_1: u32) -> u32 {
    let _e2 = (input_bits_1 & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

@compute @workgroup_size(32, 1, 1)
fn truncations(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var cursor: i32;
    var local_1: u32;
    var local_2: u32;
    var local_3: bool;
    var local_4: bool;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: f32;
    var local_13: u32;
    var local_14: u32;

    let index = (threadIdx.x + (blockIdx.x * 32u));
    if (index >= 4096u) {
        return;
    }
    let base = (4u + (index * 12u));
    let _e15 = input[index];
    let value_2 = bitcast<f32>(_e15);
    let _e18 = gen__naga_truncf(bitcast<u32>(value_2));
    output[base] = bitcast<u32>(bitcast<f32>(_e18));
    let _e23 = truncated(value_2);
    local = u32((base + 1u));
    let _e29 = local;
    output[_e29] = bitcast<u32>(_e23);
    cursor = 0i;
    let _e33 = cursor;
    cursor = (_e33 + 1i);
    local_2 = u32((index + u32(_e33)));
    let _e40 = local_2;
    let _e42 = input[_e40];
    let _e44 = truncated(bitcast<f32>(_e42));
    local_1 = u32((base + 2u));
    let _e50 = local_1;
    output[_e50] = bitcast<u32>(_e44);
    local_3 = false;
    if false {
        let _e54 = cursor;
        cursor = (_e54 + 1i);
        let _e59 = gen__naga_truncf(bitcast<u32>(f32(_e54)));
        let _e62 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if true {
    } else {
        let _e67 = cursor;
        cursor = (_e67 + 1i);
        let _e72 = gen__naga_truncf(bitcast<u32>(f32(_e67)));
        let _e75 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e72)));
        local_4 = (_e75 != 0u);
    }
    let _e78 = cursor;
    local_5 = u32((base + 3u));
    let _e84 = local_5;
    output[_e84] = u32(_e78);
    let _e89 = gen__naga_truncf(bitcast<u32>(-(0f)));
    local_6 = u32((base + 4u));
    let _e96 = local_6;
    output[_e96] = bitcast<u32>(bitcast<f32>(_e89));
    let _e101 = gen__naga_truncf(bitcast<u32>(-(0.25f)));
    local_7 = u32((base + 5u));
    let _e108 = local_7;
    output[_e108] = bitcast<u32>(bitcast<f32>(_e101));
    let _e113 = gen__naga_truncf(bitcast<u32>(-(1.75f)));
    local_8 = u32((base + 6u));
    let _e120 = local_8;
    output[_e120] = bitcast<u32>(bitcast<f32>(_e113));
    let _e124 = truncated(f32(3u));
    local_9 = u32((base + 7u));
    let _e130 = local_9;
    output[_e130] = bitcast<u32>(_e124);
    let _e133 = truncf(true);
    local_10 = u32((base + 8u));
    let _e139 = local_10;
    output[_e139] = u32(_e133);
    if true {
        let _e143 = gen__naga_truncf(bitcast<u32>(value_2));
        local_12 = bitcast<f32>(_e143);
    } else {
        let _e146 = cursor;
        cursor = (_e146 + 1i);
        let _e151 = gen__naga_truncf(bitcast<u32>(f32(_e146)));
        local_12 = bitcast<f32>(_e151);
    }
    let _e155 = local_12;
    local_11 = u32((base + 9u));
    let _e161 = local_11;
    output[_e161] = bitcast<u32>(_e155);
    let _e164 = gen__naga_truncf(bitcast<u32>(value_2));
    let _e167 = gen__naga_truncf(bitcast<u32>(bitcast<f32>(_e164)));
    local_13 = u32((base + 10u));
    let _e174 = local_13;
    output[_e174] = bitcast<u32>(bitcast<f32>(_e167));
    let _e176 = cursor;
    local_14 = u32((base + 11u));
    let _e182 = local_14;
    output[_e182] = u32(_e176);
}
