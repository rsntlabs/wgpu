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
    output[base] = bitcast<u32>(bitcast<f32>(select(0u, ((_e22 << 31u) | ((((_e32 + 127u) << 23u) | (((_e28 << (23u - _e34)) >> _e36) & 8388607u)) + select(0u, _e22, ((_e28 & ((1u << _e36) - 1u)) != 0u)))), (_e28 != 0u))));
    let _e59 = forward(value_1);
    let _e60 = bitcast<u32>(_e59);
    let _e62 = (_e60 >> 31u);
    let _e68 = ((_e60 ^ select(0u, 4294967295u, (_e62 != 0u))) + _e62);
    let _e72 = (31u - countLeadingZeros((_e68 | 1u)));
    let _e74 = min(_e72, 23u);
    let _e76 = (_e72 - _e74);
    local = u32((base + 1u));
    let _e101 = local;
    output[_e101] = bitcast<u32>(bitcast<f32>(select(0u, ((_e62 << 31u) | ((((_e72 + 127u) << 23u) | (((_e68 << (23u - _e74)) >> _e76) & 8388607u)) + select(0u, _e62, ((_e68 & ((1u << _e76) - 1u)) != 0u)))), (_e68 != 0u))));
    let _e103 = counter;
    counter = (_e103 + u32(1i));
    let _e107 = bitcast<u32>(value_1);
    let _e109 = (_e107 >> 31u);
    let _e115 = ((_e107 ^ select(0u, 4294967295u, (_e109 != 0u))) + _e109);
    let _e119 = (31u - countLeadingZeros((_e115 | 1u)));
    let _e121 = min(_e119, 23u);
    let _e123 = (_e119 - _e121);
    local_1 = u32((base + 2u));
    let _e148 = local_1;
    output[_e148] = bitcast<u32>(bitcast<f32>(select(0u, ((_e109 << 31u) | ((((_e119 + 127u) << 23u) | (((_e115 << (23u - _e121)) >> _e123) & 8388607u)) + select(0u, _e109, ((_e115 & ((1u << _e123) - 1u)) != 0u)))), (_e115 != 0u))));
    let _e150 = counter;
    local_2 = u32((base + 3u));
    let _e155 = local_2;
    output[_e155] = _e150;
    if ((index & 1u) != 0u) {
        let _e161 = counter;
        local_12 = _e161;
        let _e163 = local_12;
        counter = (_e163 + u32(1i));
        local_13 = value_1;
        let _e168 = local_13;
        local_4 = _e168;
        let _e170 = local_4;
        let _e171 = bitcast<u32>(_e170);
        let _e173 = (_e171 >> 31u);
        let _e179 = ((_e171 ^ select(0u, 4294967295u, (_e173 != 0u))) + _e173);
        let _e183 = (31u - countLeadingZeros((_e179 | 1u)));
        let _e185 = min(_e183, 23u);
        let _e187 = (_e183 - _e185);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((_e173 << 31u) | ((((_e183 + 127u) << 23u) | (((_e179 << (23u - _e185)) >> _e187) & 8388607u)) + select(0u, _e173, ((_e179 & ((1u << _e187) - 1u)) != 0u)))), (_e179 != 0u))));
    } else {
        let _e209 = counter;
        local_14 = _e209;
        let _e211 = local_14;
        counter = (_e211 + u32(1i));
        local_15 = value_1;
        let _e216 = local_15;
        local_5 = _e216;
        let _e218 = local_5;
        let _e219 = bitcast<u32>(_e218);
        let _e221 = (_e219 >> 31u);
        let _e227 = ((_e219 ^ select(0u, 4294967295u, (_e221 != 0u))) + _e221);
        let _e231 = (31u - countLeadingZeros((_e227 | 1u)));
        let _e233 = min(_e231, 23u);
        let _e235 = (_e231 - _e233);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((_e221 << 31u) | ((((_e231 + 127u) << 23u) | (((_e227 << (23u - _e233)) >> _e235) & 8388607u)) + select(0u, _e221, ((_e227 & ((1u << _e235) - 1u)) != 0u)))), (_e227 != 0u))));
    }
    let _e258 = local_6;
    local_3 = u32((base + 4u));
    let _e263 = local_3;
    output[_e263] = _e258;
    let _e265 = counter;
    local_7 = u32((base + 5u));
    let _e270 = local_7;
    output[_e270] = _e265;
    let _e274 = bitcast<u32>(i32(4294967295u));
    let _e276 = (_e274 >> 31u);
    let _e282 = ((_e274 ^ select(0u, 4294967295u, (_e276 != 0u))) + _e276);
    let _e286 = (31u - countLeadingZeros((_e282 | 1u)));
    let _e288 = min(_e286, 23u);
    let _e290 = (_e286 - _e288);
    local_8 = u32((base + 6u));
    let _e315 = local_8;
    output[_e315] = bitcast<u32>(bitcast<f32>(select(0u, ((_e276 << 31u) | ((((_e286 + 127u) << 23u) | (((_e282 << (23u - _e288)) >> _e290) & 8388607u)) + select(0u, _e276, ((_e282 & ((1u << _e290) - 1u)) != 0u)))), (_e282 != 0u))));
    let _e320 = bitcast<u32>(i32(-(3.5f)));
    let _e322 = (_e320 >> 31u);
    let _e328 = ((_e320 ^ select(0u, 4294967295u, (_e322 != 0u))) + _e322);
    let _e332 = (31u - countLeadingZeros((_e328 | 1u)));
    let _e334 = min(_e332, 23u);
    let _e336 = (_e332 - _e334);
    local_9 = u32((base + 7u));
    let _e361 = local_9;
    output[_e361] = bitcast<u32>(bitcast<f32>(select(0u, ((_e322 << 31u) | ((((_e332 + 127u) << 23u) | (((_e328 << (23u - _e334)) >> _e336) & 8388607u)) + select(0u, _e322, ((_e328 & ((1u << _e336) - 1u)) != 0u)))), (_e328 != 0u))));
    let _e363 = bitcast<u32>(value_1);
    let _e365 = (_e363 >> 31u);
    let _e371 = ((_e363 ^ select(0u, 4294967295u, (_e365 != 0u))) + _e365);
    let _e375 = (31u - countLeadingZeros((_e371 | 1u)));
    let _e377 = min(_e375, 23u);
    local_10 = u32((base + 8u));
    let _e398 = local_10;
    output[_e398] = bitcast<u32>(bitcast<f32>(select(0u, ((_e365 << 31u) | (((_e375 + 127u) << 23u) | (((_e371 << (23u - _e377)) >> (_e375 - _e377)) & 8388607u))), (_e371 != 0u))));
    let _e400 = bitcast<u32>(value_1);
    let _e402 = (_e400 >> 31u);
    let _e408 = ((_e400 ^ select(0u, 4294967295u, (_e402 != 0u))) + _e402);
    let _e412 = (31u - countLeadingZeros((_e408 | 1u)));
    let _e414 = min(_e412, 23u);
    let _e416 = (_e412 - _e414);
    let _e418 = ((_e408 << (23u - _e414)) >> _e416);
    let _e426 = (1u << _e416);
    local_11 = u32((base + 9u));
    let _e444 = local_11;
    output[_e444] = bitcast<u32>(bitcast<f32>(select(0u, ((_e402 << 31u) | ((((_e412 + 127u) << 23u) | (_e418 & 8388607u)) + select(0u, 1u, ((((_e408 & (_e426 - 1u)) << 1u) | (_e418 & 1u)) > _e426)))), (_e408 != 0u))));
}
