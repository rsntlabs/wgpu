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
    var local_12: i32;
    var local_13: u32;
    var local_14: i32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 9u));
    let value_1 = input[index];
    counter = 0u;
    let _e20 = bitcast<u32>(value_1);
    let _e22 = (_e20 >> 31u);
    let _e28 = ((_e20 ^ select(0u, 4294967295u, (_e22 != 0u))) + _e22);
    let _e32 = (31u - countLeadingZeros((_e28 | 1u)));
    let _e34 = min(_e32, 23u);
    let _e36 = (_e32 - _e34);
    let _e38 = ((_e28 << (23u - _e34)) >> _e36);
    let _e46 = (1u << _e36);
    output[base] = bitcast<u32>(bitcast<f32>(select(0u, ((_e22 << 31u) | ((((_e32 + 127u) << 23u) | (_e38 & 8388607u)) + select(0u, 1u, ((((_e28 & (_e46 - 1u)) << 1u) | (_e38 & 1u)) > _e46)))), (_e28 != 0u))));
    let _e62 = forward(value_1);
    let _e63 = bitcast<u32>(_e62);
    let _e65 = (_e63 >> 31u);
    let _e71 = ((_e63 ^ select(0u, 4294967295u, (_e65 != 0u))) + _e65);
    let _e75 = (31u - countLeadingZeros((_e71 | 1u)));
    let _e77 = min(_e75, 23u);
    let _e79 = (_e75 - _e77);
    let _e81 = ((_e71 << (23u - _e77)) >> _e79);
    let _e89 = (1u << _e79);
    local = u32((base + 1u));
    let _e107 = local;
    output[_e107] = bitcast<u32>(bitcast<f32>(select(0u, ((_e65 << 31u) | ((((_e75 + 127u) << 23u) | (_e81 & 8388607u)) + select(0u, 1u, ((((_e71 & (_e89 - 1u)) << 1u) | (_e81 & 1u)) > _e89)))), (_e71 != 0u))));
    let _e109 = counter;
    counter = (_e109 + u32(1i));
    let _e113 = bitcast<u32>(value_1);
    let _e115 = (_e113 >> 31u);
    let _e121 = ((_e113 ^ select(0u, 4294967295u, (_e115 != 0u))) + _e115);
    let _e125 = (31u - countLeadingZeros((_e121 | 1u)));
    let _e127 = min(_e125, 23u);
    let _e129 = (_e125 - _e127);
    let _e131 = ((_e121 << (23u - _e127)) >> _e129);
    let _e139 = (1u << _e129);
    local_1 = u32((base + 2u));
    let _e157 = local_1;
    output[_e157] = bitcast<u32>(bitcast<f32>(select(0u, ((_e115 << 31u) | ((((_e125 + 127u) << 23u) | (_e131 & 8388607u)) + select(0u, 1u, ((((_e121 & (_e139 - 1u)) << 1u) | (_e131 & 1u)) > _e139)))), (_e121 != 0u))));
    let _e159 = counter;
    local_2 = u32((base + 3u));
    let _e164 = local_2;
    output[_e164] = _e159;
    if ((index & 1u) != 0u) {
        let _e170 = counter;
        local_11 = _e170;
        let _e172 = local_11;
        counter = (_e172 + u32(1i));
        local_12 = value_1;
        let _e177 = local_12;
        local_4 = _e177;
        let _e179 = local_4;
        let _e180 = bitcast<u32>(_e179);
        let _e182 = (_e180 >> 31u);
        let _e188 = ((_e180 ^ select(0u, 4294967295u, (_e182 != 0u))) + _e182);
        let _e192 = (31u - countLeadingZeros((_e188 | 1u)));
        let _e194 = min(_e192, 23u);
        let _e196 = (_e192 - _e194);
        let _e198 = ((_e188 << (23u - _e194)) >> _e196);
        let _e206 = (1u << _e196);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((_e182 << 31u) | ((((_e192 + 127u) << 23u) | (_e198 & 8388607u)) + select(0u, 1u, ((((_e188 & (_e206 - 1u)) << 1u) | (_e198 & 1u)) > _e206)))), (_e188 != 0u))));
    } else {
        let _e221 = counter;
        local_13 = _e221;
        let _e223 = local_13;
        counter = (_e223 + u32(1i));
        local_14 = value_1;
        let _e228 = local_14;
        local_5 = _e228;
        let _e230 = local_5;
        let _e231 = bitcast<u32>(_e230);
        let _e233 = (_e231 >> 31u);
        let _e239 = ((_e231 ^ select(0u, 4294967295u, (_e233 != 0u))) + _e233);
        let _e243 = (31u - countLeadingZeros((_e239 | 1u)));
        let _e245 = min(_e243, 23u);
        let _e247 = (_e243 - _e245);
        let _e249 = ((_e239 << (23u - _e245)) >> _e247);
        let _e257 = (1u << _e247);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((_e233 << 31u) | ((((_e243 + 127u) << 23u) | (_e249 & 8388607u)) + select(0u, 1u, ((((_e239 & (_e257 - 1u)) << 1u) | (_e249 & 1u)) > _e257)))), (_e239 != 0u))));
    }
    let _e273 = local_6;
    local_3 = u32((base + 4u));
    let _e278 = local_3;
    output[_e278] = _e273;
    let _e280 = counter;
    local_7 = u32((base + 5u));
    let _e285 = local_7;
    output[_e285] = _e280;
    let _e289 = bitcast<u32>(i32(4294967295u));
    let _e291 = (_e289 >> 31u);
    let _e297 = ((_e289 ^ select(0u, 4294967295u, (_e291 != 0u))) + _e291);
    let _e301 = (31u - countLeadingZeros((_e297 | 1u)));
    let _e303 = min(_e301, 23u);
    let _e305 = (_e301 - _e303);
    let _e307 = ((_e297 << (23u - _e303)) >> _e305);
    let _e315 = (1u << _e305);
    local_8 = u32((base + 6u));
    let _e333 = local_8;
    output[_e333] = bitcast<u32>(bitcast<f32>(select(0u, ((_e291 << 31u) | ((((_e301 + 127u) << 23u) | (_e307 & 8388607u)) + select(0u, 1u, ((((_e297 & (_e315 - 1u)) << 1u) | (_e307 & 1u)) > _e315)))), (_e297 != 0u))));
    let _e338 = bitcast<u32>(i32(-(3.5f)));
    let _e340 = (_e338 >> 31u);
    let _e346 = ((_e338 ^ select(0u, 4294967295u, (_e340 != 0u))) + _e340);
    let _e350 = (31u - countLeadingZeros((_e346 | 1u)));
    let _e352 = min(_e350, 23u);
    let _e354 = (_e350 - _e352);
    let _e356 = ((_e346 << (23u - _e352)) >> _e354);
    let _e364 = (1u << _e354);
    local_9 = u32((base + 7u));
    let _e382 = local_9;
    output[_e382] = bitcast<u32>(bitcast<f32>(select(0u, ((_e340 << 31u) | ((((_e350 + 127u) << 23u) | (_e356 & 8388607u)) + select(0u, 1u, ((((_e346 & (_e364 - 1u)) << 1u) | (_e356 & 1u)) > _e364)))), (_e346 != 0u))));
    let _e384 = bitcast<u32>(value_1);
    let _e386 = (_e384 >> 31u);
    let _e392 = ((_e384 ^ select(0u, 4294967295u, (_e386 != 0u))) + _e386);
    let _e396 = (31u - countLeadingZeros((_e392 | 1u)));
    let _e398 = min(_e396, 23u);
    local_10 = u32((base + 8u));
    let _e419 = local_10;
    output[_e419] = bitcast<u32>(bitcast<f32>(select(0u, ((_e386 << 31u) | (((_e396 + 127u) << 23u) | (((_e392 << (23u - _e398)) >> (_e396 - _e398)) & 8388607u))), (_e392 != 0u))));
}
