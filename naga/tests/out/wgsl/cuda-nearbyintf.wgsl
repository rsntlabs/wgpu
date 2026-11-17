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

fn nearby_value(value: f32) -> f32 {
    let _e2 = gen__naga_rintf(bitcast<u32>(value));
    return bitcast<f32>(_e2);
}

fn nearbyintf(value_1: bool) -> i32 {
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
fn nearby_integers(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var cursor: i32;
    var local_2: u32;
    var local_3: u32;
    var local_4: bool;
    var local_5: bool;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: f32;
    var local_14: u32;

    let index = (threadIdx.x + (blockIdx.x * 32u));
    if (index >= 32u) {
        return;
    }
    let base = (4u + (index * 12u));
    let _e15 = input[index];
    let value_2 = bitcast<f32>(_e15);
    let _e18 = gen__naga_rintf(bitcast<u32>(value_2));
    output[base] = bitcast<u32>(bitcast<f32>(_e18));
    let _e24 = gen__naga_rintf(bitcast<u32>(value_2));
    local = u32((base + 1u));
    let _e31 = local;
    output[_e31] = bitcast<u32>(bitcast<f32>(_e24));
    let _e33 = nearby_value(value_2);
    local_1 = u32((base + 2u));
    let _e39 = local_1;
    output[_e39] = bitcast<u32>(_e33);
    cursor = 0i;
    let _e43 = cursor;
    cursor = (_e43 + 1i);
    local_3 = u32((index + u32(_e43)));
    let _e50 = local_3;
    let _e52 = input[_e50];
    let _e54 = nearby_value(bitcast<f32>(_e52));
    local_2 = u32((base + 3u));
    let _e60 = local_2;
    output[_e60] = bitcast<u32>(_e54);
    local_4 = false;
    if false {
        let _e64 = cursor;
        cursor = (_e64 + 1i);
        let _e69 = gen__naga_rintf(bitcast<u32>(f32(_e64)));
        let _e72 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e69)));
        local_4 = (_e72 != 0u);
    }
    local_5 = true;
    if true {
    } else {
        let _e77 = cursor;
        cursor = (_e77 + 1i);
        let _e82 = gen__naga_rintf(bitcast<u32>(f32(_e77)));
        let _e85 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(_e82)));
        local_5 = (_e85 != 0u);
    }
    let _e88 = cursor;
    local_6 = u32((base + 4u));
    let _e94 = local_6;
    output[_e94] = u32(_e88);
    let _e99 = gen__naga_rintf(bitcast<u32>(-(0.5f)));
    local_7 = u32((base + 5u));
    let _e106 = local_7;
    output[_e106] = bitcast<u32>(bitcast<f32>(_e99));
    let _e110 = gen__naga_rintf(bitcast<u32>(2.5f));
    local_8 = u32((base + 6u));
    let _e117 = local_8;
    output[_e117] = bitcast<u32>(bitcast<f32>(_e110));
    let _e121 = gen__naga_roundf(bitcast<u32>(2.5f));
    local_9 = u32((base + 7u));
    let _e128 = local_9;
    output[_e128] = bitcast<u32>(bitcast<f32>(_e121));
    let _e132 = nearby_value(f32(3u));
    local_10 = u32((base + 8u));
    let _e138 = local_10;
    output[_e138] = bitcast<u32>(_e132);
    let _e141 = nearbyintf(true);
    local_11 = u32((base + 9u));
    let _e147 = local_11;
    output[_e147] = u32(_e141);
    if true {
        let _e151 = gen__naga_rintf(bitcast<u32>(value_2));
        let _e154 = gen__naga_rintf(bitcast<u32>(bitcast<f32>(_e151)));
        local_13 = bitcast<f32>(_e154);
    } else {
        let _e157 = cursor;
        cursor = (_e157 + 1i);
        let _e162 = gen__naga_rintf(bitcast<u32>(f32(_e157)));
        local_13 = bitcast<f32>(_e162);
    }
    let _e166 = local_13;
    local_12 = u32((base + 10u));
    let _e172 = local_12;
    output[_e172] = bitcast<u32>(_e166);
    let _e174 = cursor;
    local_14 = u32((base + 11u));
    let _e180 = local_14;
    output[_e180] = u32(_e174);
}
