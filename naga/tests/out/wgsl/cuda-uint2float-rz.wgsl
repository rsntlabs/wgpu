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

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 8u));
    let value_1 = input[index];
    counter = 0u;
    let _e24 = (31u - countLeadingZeros((value_1 | 1u)));
    let _e26 = min(_e24, 23u);
    output[base] = bitcast<u32>(bitcast<f32>(select(0u, (((_e24 + 127u) << 23u) | (((value_1 << (23u - _e26)) >> (_e24 - _e26)) & 8388607u)), (value_1 != 0u))));
    let _e44 = forward(value_1);
    let _e49 = (31u - countLeadingZeros((_e44 | 1u)));
    let _e51 = min(_e49, 23u);
    local = u32((base + 1u));
    let _e71 = local;
    output[_e71] = bitcast<u32>(bitcast<f32>(select(0u, (((_e49 + 127u) << 23u) | (((_e44 << (23u - _e51)) >> (_e49 - _e51)) & 8388607u)), (_e44 != 0u))));
    let _e73 = counter;
    counter = (_e73 + u32(1i));
    let _e81 = (31u - countLeadingZeros((value_1 | 1u)));
    let _e83 = min(_e81, 23u);
    local_1 = u32((base + 2u));
    let _e103 = local_1;
    output[_e103] = bitcast<u32>(bitcast<f32>(select(0u, (((_e81 + 127u) << 23u) | (((value_1 << (23u - _e83)) >> (_e81 - _e83)) & 8388607u)), (value_1 != 0u))));
    let _e105 = counter;
    local_2 = u32((base + 3u));
    let _e110 = local_2;
    output[_e110] = _e105;
    if ((index & 1u) != 0u) {
        let _e116 = counter;
        local_10 = _e116;
        let _e118 = local_10;
        counter = (_e118 + u32(1i));
        local_11 = value_1;
        let _e123 = local_11;
        local_4 = _e123;
        let _e125 = local_4;
        let _e130 = (31u - countLeadingZeros((_e125 | 1u)));
        let _e132 = min(_e130, 23u);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, (((_e130 + 127u) << 23u) | (((_e125 << (23u - _e132)) >> (_e130 - _e132)) & 8388607u)), (_e125 != 0u))));
    } else {
        let _e149 = counter;
        local_12 = _e149;
        let _e151 = local_12;
        counter = (_e151 + u32(1i));
        local_13 = value_1;
        let _e156 = local_13;
        local_5 = _e156;
        let _e158 = local_5;
        let _e163 = (31u - countLeadingZeros((_e158 | 1u)));
        let _e165 = min(_e163, 23u);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, (((_e163 + 127u) << 23u) | (((_e158 << (23u - _e165)) >> (_e163 - _e165)) & 8388607u)), (_e158 != 0u))));
    }
    let _e183 = local_6;
    local_3 = u32((base + 4u));
    let _e188 = local_3;
    output[_e188] = _e183;
    let _e190 = counter;
    local_7 = u32((base + 5u));
    let _e195 = local_7;
    output[_e195] = _e190;
    let _e199 = u32(-(1i));
    let _e204 = (31u - countLeadingZeros((_e199 | 1u)));
    let _e206 = min(_e204, 23u);
    local_8 = u32((base + 6u));
    let _e226 = local_8;
    output[_e226] = bitcast<u32>(bitcast<f32>(select(0u, (((_e204 + 127u) << 23u) | (((_e199 << (23u - _e206)) >> (_e204 - _e206)) & 8388607u)), (_e199 != 0u))));
    let _e229 = u32(3.5f);
    let _e234 = (31u - countLeadingZeros((_e229 | 1u)));
    let _e236 = min(_e234, 23u);
    local_9 = u32((base + 7u));
    let _e256 = local_9;
    output[_e256] = bitcast<u32>(bitcast<f32>(select(0u, (((_e234 + 127u) << 23u) | (((_e229 << (23u - _e236)) >> (_e234 - _e236)) & 8388607u)), (_e229 != 0u))));
}
