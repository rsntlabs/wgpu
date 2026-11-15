@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;

fn copied(value: f32, sign_: f32) -> f32 {
    return bitcast<f32>(((bitcast<u32>(value) & 2147483647u) | (bitcast<u32>(sign_) & 2147483648u)));
}

fn copysignf(value_1: bool, sign_1: bool) -> i32 {
    var local_22: i32;

    if value_1 {
        local_22 = 7i;
    } else {
        local_22 = 9i;
    }
    let _e6 = local_22;
    return _e6;
}

fn gen__naga_fabsf(input_bits: u32) -> u32 {
    let _e2 = (input_bits & 2147483647u);
    return select(_e2, 2143289344u, (_e2 > 2139095040u));
}

@compute @workgroup_size(32, 1, 1)
fn copy_signs(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var cursor: i32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var run: bool;
    var local_15: bool;
    var local_16: bool;
    var local_17: u32;
    var local_18: u32;
    var local_19: f32;
    var local_20: u32;
    var local_21: u32;

    let index = (threadIdx.x + (blockIdx.x * 32u));
    if (index >= 912u) {
        return;
    }
    let base = (4u + (index * 14u));
    local = u32((index * 2u));
    let _e17 = local;
    let _e20 = input[_e17];
    let value_2 = bitcast<f32>(_e20);
    local_1 = u32(((index * 2u) + 1u));
    let _e28 = local_1;
    let _e30 = input[_e28];
    let sign_2 = bitcast<f32>(_e30);
    output[base] = bitcast<u32>(bitcast<f32>(((bitcast<u32>(value_2) & 2147483647u) | (bitcast<u32>(sign_2) & 2147483648u))));
    let _e43 = copied(value_2, sign_2);
    local_2 = u32((base + 1u));
    let _e49 = local_2;
    output[_e49] = bitcast<u32>(_e43);
    local_3 = u32((base + 2u));
    let _e67 = local_3;
    output[_e67] = bitcast<u32>(bitcast<f32>(((bitcast<u32>(0f) & 2147483647u) | (bitcast<u32>(-(0f)) & 2147483648u))));
    local_4 = u32((base + 3u));
    let _e85 = local_4;
    output[_e85] = bitcast<u32>(bitcast<f32>(((bitcast<u32>(-(0f)) & 2147483647u) | (bitcast<u32>(0f) & 2147483648u))));
    local_6 = 4286578689u;
    let _e89 = local_6;
    local_5 = u32((base + 4u));
    let _e105 = local_5;
    output[_e105] = bitcast<u32>(bitcast<f32>(((bitcast<u32>(bitcast<f32>(_e89)) & 2147483647u) | (bitcast<u32>(0f) & 2147483648u))));
    local_8 = 2143363909u;
    let _e109 = local_8;
    local_7 = u32((base + 5u));
    let _e126 = local_7;
    output[_e126] = bitcast<u32>(bitcast<f32>(((bitcast<u32>(bitcast<f32>(_e109)) & 2147483647u) | (bitcast<u32>(-(0f)) & 2147483648u))));
    let _e133 = copied(f32(-(3i)), f32(0u));
    local_9 = u32((base + 6u));
    let _e139 = local_9;
    output[_e139] = bitcast<u32>(_e133);
    let _e146 = copied(f32(5u), f32(-(1i)));
    local_10 = u32((base + 7u));
    let _e152 = local_10;
    output[_e152] = bitcast<u32>(_e146);
    let _e156 = copysignf(true, false);
    local_11 = u32((base + 8u));
    let _e162 = local_11;
    output[_e162] = u32(_e156);
    cursor = 0i;
    let _e168 = cursor;
    cursor = (_e168 + 1i);
    local_13 = u32(((index * 2u) + u32(_e168)));
    let _e175 = local_13;
    let _e177 = input[_e175];
    let _e181 = cursor;
    cursor = (_e181 + 1i);
    local_14 = u32(((index * 2u) + u32(_e181)));
    let _e188 = local_14;
    let _e190 = input[_e188];
    let _e192 = copied(bitcast<f32>(_e177), bitcast<f32>(_e190));
    local_12 = u32((base + 9u));
    let _e198 = local_12;
    output[_e198] = bitcast<u32>(_e192);
    run = false;
    let _e202 = run;
    local_15 = _e202;
    if _e202 {
        let _e204 = cursor;
        cursor = (_e204 + 1i);
        let _e217 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(((bitcast<u32>(f32(_e204)) & 2147483647u) | (bitcast<u32>(sign_2) & 2147483648u)))));
        local_15 = (_e217 != 0u);
    }
    run = true;
    let _e221 = run;
    local_16 = _e221;
    if _e221 {
    } else {
        let _e223 = cursor;
        cursor = (_e223 + 1i);
        let _e236 = gen__naga_fabsf(bitcast<u32>(bitcast<f32>(((bitcast<u32>(f32(_e223)) & 2147483647u) | (bitcast<u32>(sign_2) & 2147483648u)))));
        local_16 = (_e236 != 0u);
    }
    let _e239 = cursor;
    local_17 = u32((base + 10u));
    let _e245 = local_17;
    output[_e245] = u32(_e239);
    let _e247 = run;
    if _e247 {
        local_19 = bitcast<f32>(((bitcast<u32>(value_2) & 2147483647u) | (bitcast<u32>(sign_2) & 2147483648u)));
    } else {
        let _e257 = cursor;
        cursor = (_e257 + 1i);
        local_19 = bitcast<f32>(((bitcast<u32>(f32(_e257)) & 2147483647u) | (bitcast<u32>(sign_2) & 2147483648u)));
    }
    let _e271 = local_19;
    local_18 = u32((base + 11u));
    let _e277 = local_18;
    output[_e277] = bitcast<u32>(_e271);
    let _e283 = copied(f32(true), -(1f));
    local_20 = u32((base + 12u));
    let _e289 = local_20;
    output[_e289] = bitcast<u32>(_e283);
    let _e291 = cursor;
    local_21 = u32((base + 13u));
    let _e297 = local_21;
    output[_e297] = u32(_e291);
}
