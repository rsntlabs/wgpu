@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn gen__naga_rintf(input_bits: u32) -> u32 {
    let _e5 = (input_bits & 2147483647u);
    let _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e14 = (_e13 - 1u);
    let _e15 = (input_bits & _e14);
    let _e18 = (input_bits & ~(_e14));
    let _e20 = (_e13 >> 1u);
    return select(select(select(select(_e18, (_e18 + _e13), (((_e15 > _e20) || ((_e15 == _e20) && ((_e18 & _e13) != 0u))) && (_e15 != 0u))), select(((input_bits & 2147483648u) | (select(0u, 1u, (_e5 > 1056964608u)) * 1065353216u)), input_bits, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

fn rounded_even(value: f32) -> f32 {
    let _e2 = gen__naga_rintf(bitcast<u32>(value));
    return bitcast<f32>(_e2);
}

fn rintf(value_1: bool) -> i32 {
    var local_17: i32;

    if value_1 {
        local_17 = 7i;
    } else {
        local_17 = 9i;
    }
    let _e6 = local_17;
    return _e6;
}

fn gen__naga_fabsf(input_bits_1: u32) -> u32 {
    let _e2 = (input_bits_1 & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

fn gen__naga_roundf(input_bits_2: u32) -> u32 {
    let _e5 = (input_bits_2 & 2147483647u);
    let _e6 = (input_bits_2 & 2147483648u);
    let _e13 = (1u << ((150u - (_e5 >> 23u)) & 31u));
    let _e14 = (_e13 - 1u);
    let _e15 = (input_bits_2 & _e14);
    let _e18 = (input_bits_2 & ~(_e14));
    return select(select(select(select(_e18, (_e18 + _e13), ((_e15 >= (_e13 >> 1u)) && (_e15 != 0u))), select(select(_e6, (_e6 | 1065353216u), (_e5 >= 1056964608u)), input_bits_2, (_e5 == 0u)), (_e5 < 1065353216u)), input_bits_2, (_e5 >= 1258291200u)), 2143289344u, (_e5 > 2139095040u));
}

@compute @workgroup_size(32, 1, 1)
fn nearest_even(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
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
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: f32;
    var local_16: u32;

    let index = (threadIdx.x + (blockIdx.x * 32u));
    if (index >= 4096u) {
        return;
    }
    let base = (4u + (index * 14u));
    let _e15 = input[index];
    let value_2 = bitcast<f32>(_e15);
    let _e18 = gen__naga_rintf(bitcast<u32>(value_2));
    output[base] = bitcast<u32>(bitcast<f32>(_e18));
    let _e23 = rounded_even(value_2);
    local = u32((base + 1u));
    let _e29 = local;
    output[_e29] = bitcast<u32>(_e23);
    cursor = 0i;
    let _e33 = cursor;
    cursor = (_e33 + 1i);
    local_2 = u32((index + u32(_e33)));
    let _e40 = local_2;
    let _e42 = input[_e40];
    let _e44 = rounded_even(bitcast<f32>(_e42));
    local_1 = u32((base + 2u));
    let _e50 = local_1;
    output[_e50] = bitcast<u32>(_e44);
    local_3 = false;
    if false {
        let _e54 = cursor;
        cursor = (_e54 + 1i);
        let _e59 = gen__naga_rintf(bitcast<u32>(f32(_e54)));
        let _e62 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e59)));
        local_3 = (_e62 != 0u);
    }
    local_4 = true;
    if true {
    } else {
        let _e67 = cursor;
        cursor = (_e67 + 1i);
        let _e72 = gen__naga_rintf(bitcast<u32>(f32(_e67)));
        let _e75 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e72)));
        local_4 = (_e75 != 0u);
    }
    let _e78 = cursor;
    local_5 = u32((base + 3u));
    let _e84 = local_5;
    output[_e84] = u32(_e78);
    let _e89 = gen__naga_rintf(bitcast<u32>(-(0.5f)));
    local_6 = u32((base + 4u));
    let _e96 = local_6;
    output[_e96] = bitcast<u32>(bitcast<f32>(_e89));
    let _e100 = gen__naga_rintf(bitcast<u32>(0.5f));
    local_7 = u32((base + 5u));
    let _e107 = local_7;
    output[_e107] = bitcast<u32>(bitcast<f32>(_e100));
    let _e111 = gen__naga_rintf(bitcast<u32>(2.5f));
    local_8 = u32((base + 6u));
    let _e118 = local_8;
    output[_e118] = bitcast<u32>(bitcast<f32>(_e111));
    let _e122 = gen__naga_roundf(bitcast<u32>(2.5f));
    local_9 = u32((base + 7u));
    let _e129 = local_9;
    output[_e129] = bitcast<u32>(bitcast<f32>(_e122));
    let _e134 = gen__naga_rintf(bitcast<u32>(-(2.5f)));
    local_10 = u32((base + 8u));
    let _e141 = local_10;
    output[_e141] = bitcast<u32>(bitcast<f32>(_e134));
    let _e146 = gen__naga_roundf(bitcast<u32>(-(2.5f)));
    local_11 = u32((base + 9u));
    let _e153 = local_11;
    output[_e153] = bitcast<u32>(bitcast<f32>(_e146));
    let _e157 = rounded_even(f32(3u));
    local_12 = u32((base + 10u));
    let _e163 = local_12;
    output[_e163] = bitcast<u32>(_e157);
    let _e166 = rintf(true);
    local_13 = u32((base + 11u));
    let _e172 = local_13;
    output[_e172] = u32(_e166);
    if true {
        let _e176 = gen__naga_rintf(bitcast<u32>(value_2));
        let _e179 = gen__naga_rintf(bitcast<u32>(bitcast<f32>(_e176)));
        local_15 = bitcast<f32>(_e179);
    } else {
        let _e182 = cursor;
        cursor = (_e182 + 1i);
        let _e187 = gen__naga_rintf(bitcast<u32>(f32(_e182)));
        local_15 = bitcast<f32>(_e187);
    }
    let _e191 = local_15;
    local_14 = u32((base + 12u));
    let _e197 = local_14;
    output[_e197] = bitcast<u32>(_e191);
    let _e199 = cursor;
    local_16 = u32((base + 13u));
    let _e205 = local_16;
    output[_e205] = u32(_e199);
}
