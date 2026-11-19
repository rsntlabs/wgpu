struct type_4 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<i32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_4;

fn forward(value: i32) -> i32 {
    return value;
}

@compute @workgroup_size(4, 1, 1)
fn convert_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: u32;
    var local: u32;
    var local_1: u32;
    var local_2: u32;
    var local_3: u32;
    var local_4: i32;
    var local_5: i32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: i32;
    var local_14: u32;
    var local_15: i32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 10u));
    let value_1 = input[index];
    counter = 0u;
    let _e20 = bitcast<u32>(value_1);
    let _e22 = (_e20 >> 31u);
    let _e28 = ((_e20 ^ select(0u, 4294967295u, (_e22 != 0u))) + _e22);
    let _e32 = (31u - countLeadingZeros((_e28 | 1u)));
    let _e34 = min(_e32, 23u);
    let _e36 = (_e32 - _e34);
    output[base] = bitcast<u32>(bitcast<f32>(select(0u, ((_e22 << 31u) | ((((_e32 + 127u) << 23u) | (((_e28 << (23u - _e34)) >> _e36) & 8388607u)) + select(0u, (1u - _e22), ((_e28 & ((1u << _e36) - 1u)) != 0u)))), (_e28 != 0u))));
    let _e60 = forward(value_1);
    let _e61 = bitcast<u32>(_e60);
    let _e63 = (_e61 >> 31u);
    let _e69 = ((_e61 ^ select(0u, 4294967295u, (_e63 != 0u))) + _e63);
    let _e73 = (31u - countLeadingZeros((_e69 | 1u)));
    let _e75 = min(_e73, 23u);
    let _e77 = (_e73 - _e75);
    local = u32((base + 1u));
    let _e103 = local;
    output[_e103] = bitcast<u32>(bitcast<f32>(select(0u, ((_e63 << 31u) | ((((_e73 + 127u) << 23u) | (((_e69 << (23u - _e75)) >> _e77) & 8388607u)) + select(0u, (1u - _e63), ((_e69 & ((1u << _e77) - 1u)) != 0u)))), (_e69 != 0u))));
    let _e105 = counter;
    counter = (_e105 + u32(1i));
    let _e109 = bitcast<u32>(value_1);
    let _e111 = (_e109 >> 31u);
    let _e117 = ((_e109 ^ select(0u, 4294967295u, (_e111 != 0u))) + _e111);
    let _e121 = (31u - countLeadingZeros((_e117 | 1u)));
    let _e123 = min(_e121, 23u);
    let _e125 = (_e121 - _e123);
    local_1 = u32((base + 2u));
    let _e151 = local_1;
    output[_e151] = bitcast<u32>(bitcast<f32>(select(0u, ((_e111 << 31u) | ((((_e121 + 127u) << 23u) | (((_e117 << (23u - _e123)) >> _e125) & 8388607u)) + select(0u, (1u - _e111), ((_e117 & ((1u << _e125) - 1u)) != 0u)))), (_e117 != 0u))));
    let _e153 = counter;
    local_2 = u32((base + 3u));
    let _e158 = local_2;
    output[_e158] = _e153;
    if ((index & 1u) != 0u) {
        let _e164 = counter;
        local_12 = _e164;
        let _e166 = local_12;
        counter = (_e166 + u32(1i));
        local_13 = value_1;
        let _e171 = local_13;
        local_4 = _e171;
        let _e173 = local_4;
        let _e174 = bitcast<u32>(_e173);
        let _e176 = (_e174 >> 31u);
        let _e182 = ((_e174 ^ select(0u, 4294967295u, (_e176 != 0u))) + _e176);
        let _e186 = (31u - countLeadingZeros((_e182 | 1u)));
        let _e188 = min(_e186, 23u);
        let _e190 = (_e186 - _e188);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((_e176 << 31u) | ((((_e186 + 127u) << 23u) | (((_e182 << (23u - _e188)) >> _e190) & 8388607u)) + select(0u, (1u - _e176), ((_e182 & ((1u << _e190) - 1u)) != 0u)))), (_e182 != 0u))));
    } else {
        let _e213 = counter;
        local_14 = _e213;
        let _e215 = local_14;
        counter = (_e215 + u32(1i));
        local_15 = value_1;
        let _e220 = local_15;
        local_5 = _e220;
        let _e222 = local_5;
        let _e223 = bitcast<u32>(_e222);
        let _e225 = (_e223 >> 31u);
        let _e231 = ((_e223 ^ select(0u, 4294967295u, (_e225 != 0u))) + _e225);
        let _e235 = (31u - countLeadingZeros((_e231 | 1u)));
        let _e237 = min(_e235, 23u);
        let _e239 = (_e235 - _e237);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((_e225 << 31u) | ((((_e235 + 127u) << 23u) | (((_e231 << (23u - _e237)) >> _e239) & 8388607u)) + select(0u, (1u - _e225), ((_e231 & ((1u << _e239) - 1u)) != 0u)))), (_e231 != 0u))));
    }
    let _e263 = local_6;
    local_3 = u32((base + 4u));
    let _e268 = local_3;
    output[_e268] = _e263;
    let _e270 = counter;
    local_7 = u32((base + 5u));
    let _e275 = local_7;
    output[_e275] = _e270;
    let _e279 = bitcast<u32>(i32(4294967295u));
    let _e281 = (_e279 >> 31u);
    let _e287 = ((_e279 ^ select(0u, 4294967295u, (_e281 != 0u))) + _e281);
    let _e291 = (31u - countLeadingZeros((_e287 | 1u)));
    let _e293 = min(_e291, 23u);
    let _e295 = (_e291 - _e293);
    local_8 = u32((base + 6u));
    let _e321 = local_8;
    output[_e321] = bitcast<u32>(bitcast<f32>(select(0u, ((_e281 << 31u) | ((((_e291 + 127u) << 23u) | (((_e287 << (23u - _e293)) >> _e295) & 8388607u)) + select(0u, (1u - _e281), ((_e287 & ((1u << _e295) - 1u)) != 0u)))), (_e287 != 0u))));
    let _e326 = bitcast<u32>(i32(-(3.5f)));
    let _e328 = (_e326 >> 31u);
    let _e334 = ((_e326 ^ select(0u, 4294967295u, (_e328 != 0u))) + _e328);
    let _e338 = (31u - countLeadingZeros((_e334 | 1u)));
    let _e340 = min(_e338, 23u);
    let _e342 = (_e338 - _e340);
    local_9 = u32((base + 7u));
    let _e368 = local_9;
    output[_e368] = bitcast<u32>(bitcast<f32>(select(0u, ((_e328 << 31u) | ((((_e338 + 127u) << 23u) | (((_e334 << (23u - _e340)) >> _e342) & 8388607u)) + select(0u, (1u - _e328), ((_e334 & ((1u << _e342) - 1u)) != 0u)))), (_e334 != 0u))));
    let _e370 = bitcast<u32>(value_1);
    let _e372 = (_e370 >> 31u);
    let _e378 = ((_e370 ^ select(0u, 4294967295u, (_e372 != 0u))) + _e372);
    let _e382 = (31u - countLeadingZeros((_e378 | 1u)));
    let _e384 = min(_e382, 23u);
    local_10 = u32((base + 8u));
    let _e405 = local_10;
    output[_e405] = bitcast<u32>(bitcast<f32>(select(0u, ((_e372 << 31u) | (((_e382 + 127u) << 23u) | (((_e378 << (23u - _e384)) >> (_e382 - _e384)) & 8388607u))), (_e378 != 0u))));
    let _e407 = bitcast<u32>(value_1);
    let _e409 = (_e407 >> 31u);
    let _e415 = ((_e407 ^ select(0u, 4294967295u, (_e409 != 0u))) + _e409);
    let _e419 = (31u - countLeadingZeros((_e415 | 1u)));
    let _e421 = min(_e419, 23u);
    let _e423 = (_e419 - _e421);
    let _e425 = ((_e415 << (23u - _e421)) >> _e423);
    let _e433 = (1u << _e423);
    local_11 = u32((base + 9u));
    let _e451 = local_11;
    output[_e451] = bitcast<u32>(bitcast<f32>(select(0u, ((_e409 << 31u) | ((((_e419 + 127u) << 23u) | (_e425 & 8388607u)) + select(0u, 1u, ((((_e415 & (_e433 - 1u)) << 1u) | (_e425 & 1u)) > _e433)))), (_e415 != 0u))));
}
