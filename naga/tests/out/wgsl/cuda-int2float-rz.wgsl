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
    var local_11: i32;
    var local_12: u32;
    var local_13: i32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 8u));
    let value_1 = input[index];
    counter = 0u;
    let _e20 = bitcast<u32>(value_1);
    let _e22 = (_e20 >> 31u);
    let _e28 = ((_e20 ^ select(0u, 4294967295u, (_e22 != 0u))) + _e22);
    let _e32 = (31u - countLeadingZeros((_e28 | 1u)));
    let _e34 = min(_e32, 23u);
    output[base] = bitcast<u32>(bitcast<f32>(select(0u, ((_e22 << 31u) | (((_e32 + 127u) << 23u) | (((_e28 << (23u - _e34)) >> (_e32 - _e34)) & 8388607u))), (_e28 != 0u))));
    let _e53 = forward(value_1);
    let _e54 = bitcast<u32>(_e53);
    let _e56 = (_e54 >> 31u);
    let _e62 = ((_e54 ^ select(0u, 4294967295u, (_e56 != 0u))) + _e56);
    let _e66 = (31u - countLeadingZeros((_e62 | 1u)));
    let _e68 = min(_e66, 23u);
    local = u32((base + 1u));
    let _e89 = local;
    output[_e89] = bitcast<u32>(bitcast<f32>(select(0u, ((_e56 << 31u) | (((_e66 + 127u) << 23u) | (((_e62 << (23u - _e68)) >> (_e66 - _e68)) & 8388607u))), (_e62 != 0u))));
    let _e91 = counter;
    counter = (_e91 + u32(1i));
    let _e95 = bitcast<u32>(value_1);
    let _e97 = (_e95 >> 31u);
    let _e103 = ((_e95 ^ select(0u, 4294967295u, (_e97 != 0u))) + _e97);
    let _e107 = (31u - countLeadingZeros((_e103 | 1u)));
    let _e109 = min(_e107, 23u);
    local_1 = u32((base + 2u));
    let _e130 = local_1;
    output[_e130] = bitcast<u32>(bitcast<f32>(select(0u, ((_e97 << 31u) | (((_e107 + 127u) << 23u) | (((_e103 << (23u - _e109)) >> (_e107 - _e109)) & 8388607u))), (_e103 != 0u))));
    let _e132 = counter;
    local_2 = u32((base + 3u));
    let _e137 = local_2;
    output[_e137] = _e132;
    if ((index & 1u) != 0u) {
        let _e143 = counter;
        local_10 = _e143;
        let _e145 = local_10;
        counter = (_e145 + u32(1i));
        local_11 = value_1;
        let _e150 = local_11;
        local_4 = _e150;
        let _e152 = local_4;
        let _e153 = bitcast<u32>(_e152);
        let _e155 = (_e153 >> 31u);
        let _e161 = ((_e153 ^ select(0u, 4294967295u, (_e155 != 0u))) + _e155);
        let _e165 = (31u - countLeadingZeros((_e161 | 1u)));
        let _e167 = min(_e165, 23u);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((_e155 << 31u) | (((_e165 + 127u) << 23u) | (((_e161 << (23u - _e167)) >> (_e165 - _e167)) & 8388607u))), (_e161 != 0u))));
    } else {
        let _e185 = counter;
        local_12 = _e185;
        let _e187 = local_12;
        counter = (_e187 + u32(1i));
        local_13 = value_1;
        let _e192 = local_13;
        local_5 = _e192;
        let _e194 = local_5;
        let _e195 = bitcast<u32>(_e194);
        let _e197 = (_e195 >> 31u);
        let _e203 = ((_e195 ^ select(0u, 4294967295u, (_e197 != 0u))) + _e197);
        let _e207 = (31u - countLeadingZeros((_e203 | 1u)));
        let _e209 = min(_e207, 23u);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((_e197 << 31u) | (((_e207 + 127u) << 23u) | (((_e203 << (23u - _e209)) >> (_e207 - _e209)) & 8388607u))), (_e203 != 0u))));
    }
    let _e228 = local_6;
    local_3 = u32((base + 4u));
    let _e233 = local_3;
    output[_e233] = _e228;
    let _e235 = counter;
    local_7 = u32((base + 5u));
    let _e240 = local_7;
    output[_e240] = _e235;
    let _e244 = bitcast<u32>(i32(4294967295u));
    let _e246 = (_e244 >> 31u);
    let _e252 = ((_e244 ^ select(0u, 4294967295u, (_e246 != 0u))) + _e246);
    let _e256 = (31u - countLeadingZeros((_e252 | 1u)));
    let _e258 = min(_e256, 23u);
    local_8 = u32((base + 6u));
    let _e279 = local_8;
    output[_e279] = bitcast<u32>(bitcast<f32>(select(0u, ((_e246 << 31u) | (((_e256 + 127u) << 23u) | (((_e252 << (23u - _e258)) >> (_e256 - _e258)) & 8388607u))), (_e252 != 0u))));
    let _e284 = bitcast<u32>(i32(-(3.5f)));
    let _e286 = (_e284 >> 31u);
    let _e292 = ((_e284 ^ select(0u, 4294967295u, (_e286 != 0u))) + _e286);
    let _e296 = (31u - countLeadingZeros((_e292 | 1u)));
    let _e298 = min(_e296, 23u);
    local_9 = u32((base + 7u));
    let _e319 = local_9;
    output[_e319] = bitcast<u32>(bitcast<f32>(select(0u, ((_e286 << 31u) | (((_e296 + 127u) << 23u) | (((_e292 << (23u - _e298)) >> (_e296 - _e298)) & 8388607u))), (_e292 != 0u))));
}
