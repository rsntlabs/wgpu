struct type_2 {
    value: u32,
}

@group(0) @binding(0)
var<storage> input: array<u32>;
@group(0) @binding(1)
var<storage, read_write> output: array<u32>;
@group(0) @binding(2)
var<uniform> count: type_2;

fn forward(value: u32) -> u32 {
    return value;
}

@compute @workgroup_size(4, 1, 1)
fn convert_values(@builtin(local_invocation_id) threadIdx: vec3<u32>, @builtin(workgroup_id) blockIdx: vec3<u32>) {
    var counter: u32;
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
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 9u));
    let value_1 = input[index];
    counter = 0u;
    let _e24 = (31u - countLeadingZeros((value_1 | 1u)));
    let _e26 = min(_e24, 23u);
    let _e28 = (_e24 - _e26);
    let _e30 = ((value_1 << (23u - _e26)) >> _e28);
    let _e37 = (1u << _e28);
    output[base] = bitcast<u32>(bitcast<f32>(select(0u, ((((_e24 + 127u) << 23u) | (_e30 & 8388607u)) + select(0u, 1u, ((((value_1 & (_e37 - 1u)) << 1u) | (_e30 & 1u)) > _e37))), (value_1 != 0u))));
    let _e53 = forward(value_1);
    let _e58 = (31u - countLeadingZeros((_e53 | 1u)));
    let _e60 = min(_e58, 23u);
    let _e62 = (_e58 - _e60);
    let _e64 = ((_e53 << (23u - _e60)) >> _e62);
    let _e71 = (1u << _e62);
    local = u32((base + 1u));
    let _e89 = local;
    output[_e89] = bitcast<u32>(bitcast<f32>(select(0u, ((((_e58 + 127u) << 23u) | (_e64 & 8388607u)) + select(0u, 1u, ((((_e53 & (_e71 - 1u)) << 1u) | (_e64 & 1u)) > _e71))), (_e53 != 0u))));
    let _e91 = counter;
    counter = (_e91 + u32(1i));
    let _e99 = (31u - countLeadingZeros((value_1 | 1u)));
    let _e101 = min(_e99, 23u);
    let _e103 = (_e99 - _e101);
    let _e105 = ((value_1 << (23u - _e101)) >> _e103);
    let _e112 = (1u << _e103);
    local_1 = u32((base + 2u));
    let _e130 = local_1;
    output[_e130] = bitcast<u32>(bitcast<f32>(select(0u, ((((_e99 + 127u) << 23u) | (_e105 & 8388607u)) + select(0u, 1u, ((((value_1 & (_e112 - 1u)) << 1u) | (_e105 & 1u)) > _e112))), (value_1 != 0u))));
    let _e132 = counter;
    local_2 = u32((base + 3u));
    let _e137 = local_2;
    output[_e137] = _e132;
    if ((index & 1u) != 0u) {
        let _e143 = counter;
        local_11 = _e143;
        let _e145 = local_11;
        counter = (_e145 + u32(1i));
        local_12 = value_1;
        let _e150 = local_12;
        local_4 = _e150;
        let _e152 = local_4;
        let _e157 = (31u - countLeadingZeros((_e152 | 1u)));
        let _e159 = min(_e157, 23u);
        let _e161 = (_e157 - _e159);
        let _e163 = ((_e152 << (23u - _e159)) >> _e161);
        let _e170 = (1u << _e161);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((((_e157 + 127u) << 23u) | (_e163 & 8388607u)) + select(0u, 1u, ((((_e152 & (_e170 - 1u)) << 1u) | (_e163 & 1u)) > _e170))), (_e152 != 0u))));
    } else {
        let _e185 = counter;
        local_13 = _e185;
        let _e187 = local_13;
        counter = (_e187 + u32(1i));
        local_14 = value_1;
        let _e192 = local_14;
        local_5 = _e192;
        let _e194 = local_5;
        let _e199 = (31u - countLeadingZeros((_e194 | 1u)));
        let _e201 = min(_e199, 23u);
        let _e203 = (_e199 - _e201);
        let _e205 = ((_e194 << (23u - _e201)) >> _e203);
        let _e212 = (1u << _e203);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((((_e199 + 127u) << 23u) | (_e205 & 8388607u)) + select(0u, 1u, ((((_e194 & (_e212 - 1u)) << 1u) | (_e205 & 1u)) > _e212))), (_e194 != 0u))));
    }
    let _e228 = local_6;
    local_3 = u32((base + 4u));
    let _e233 = local_3;
    output[_e233] = _e228;
    let _e235 = counter;
    local_7 = u32((base + 5u));
    let _e240 = local_7;
    output[_e240] = _e235;
    let _e244 = u32(-(1i));
    let _e249 = (31u - countLeadingZeros((_e244 | 1u)));
    let _e251 = min(_e249, 23u);
    let _e253 = (_e249 - _e251);
    let _e255 = ((_e244 << (23u - _e251)) >> _e253);
    let _e262 = (1u << _e253);
    local_8 = u32((base + 6u));
    let _e280 = local_8;
    output[_e280] = bitcast<u32>(bitcast<f32>(select(0u, ((((_e249 + 127u) << 23u) | (_e255 & 8388607u)) + select(0u, 1u, ((((_e244 & (_e262 - 1u)) << 1u) | (_e255 & 1u)) > _e262))), (_e244 != 0u))));
    let _e283 = u32(3.5f);
    let _e288 = (31u - countLeadingZeros((_e283 | 1u)));
    let _e290 = min(_e288, 23u);
    let _e292 = (_e288 - _e290);
    let _e294 = ((_e283 << (23u - _e290)) >> _e292);
    let _e301 = (1u << _e292);
    local_9 = u32((base + 7u));
    let _e319 = local_9;
    output[_e319] = bitcast<u32>(bitcast<f32>(select(0u, ((((_e288 + 127u) << 23u) | (_e294 & 8388607u)) + select(0u, 1u, ((((_e283 & (_e301 - 1u)) << 1u) | (_e294 & 1u)) > _e301))), (_e283 != 0u))));
    let _e325 = (31u - countLeadingZeros((value_1 | 1u)));
    let _e327 = min(_e325, 23u);
    local_10 = u32((base + 8u));
    let _e347 = local_10;
    output[_e347] = bitcast<u32>(bitcast<f32>(select(0u, (((_e325 + 127u) << 23u) | (((value_1 << (23u - _e327)) >> (_e325 - _e327)) & 8388607u)), (value_1 != 0u))));
}
