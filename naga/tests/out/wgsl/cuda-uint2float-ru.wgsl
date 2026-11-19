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
    var local_15: u32;

    let count_1 = count.value;
    let index = (threadIdx.x + (blockIdx.x * 4u));
    if (index >= count_1) {
        return;
    }
    let base = (4u + (index * 10u));
    let value_1 = input[index];
    counter = 0u;
    let _e24 = (31u - countLeadingZeros((value_1 | 1u)));
    let _e26 = min(_e24, 23u);
    let _e28 = (_e24 - _e26);
    output[base] = bitcast<u32>(bitcast<f32>(select(0u, ((((_e24 + 127u) << 23u) | (((value_1 << (23u - _e26)) >> _e28) & 8388607u)) + select(0u, 1u, ((value_1 & ((1u << _e28) - 1u)) != 0u))), (value_1 != 0u))));
    let _e50 = forward(value_1);
    let _e55 = (31u - countLeadingZeros((_e50 | 1u)));
    let _e57 = min(_e55, 23u);
    let _e59 = (_e55 - _e57);
    local = u32((base + 1u));
    let _e83 = local;
    output[_e83] = bitcast<u32>(bitcast<f32>(select(0u, ((((_e55 + 127u) << 23u) | (((_e50 << (23u - _e57)) >> _e59) & 8388607u)) + select(0u, 1u, ((_e50 & ((1u << _e59) - 1u)) != 0u))), (_e50 != 0u))));
    let _e85 = counter;
    counter = (_e85 + u32(1i));
    let _e93 = (31u - countLeadingZeros((value_1 | 1u)));
    let _e95 = min(_e93, 23u);
    let _e97 = (_e93 - _e95);
    local_1 = u32((base + 2u));
    let _e121 = local_1;
    output[_e121] = bitcast<u32>(bitcast<f32>(select(0u, ((((_e93 + 127u) << 23u) | (((value_1 << (23u - _e95)) >> _e97) & 8388607u)) + select(0u, 1u, ((value_1 & ((1u << _e97) - 1u)) != 0u))), (value_1 != 0u))));
    let _e123 = counter;
    local_2 = u32((base + 3u));
    let _e128 = local_2;
    output[_e128] = _e123;
    if ((index & 1u) != 0u) {
        let _e134 = counter;
        local_12 = _e134;
        let _e136 = local_12;
        counter = (_e136 + u32(1i));
        local_13 = value_1;
        let _e141 = local_13;
        local_4 = _e141;
        let _e143 = local_4;
        let _e148 = (31u - countLeadingZeros((_e143 | 1u)));
        let _e150 = min(_e148, 23u);
        let _e152 = (_e148 - _e150);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((((_e148 + 127u) << 23u) | (((_e143 << (23u - _e150)) >> _e152) & 8388607u)) + select(0u, 1u, ((_e143 & ((1u << _e152) - 1u)) != 0u))), (_e143 != 0u))));
    } else {
        let _e173 = counter;
        local_14 = _e173;
        let _e175 = local_14;
        counter = (_e175 + u32(1i));
        local_15 = value_1;
        let _e180 = local_15;
        local_5 = _e180;
        let _e182 = local_5;
        let _e187 = (31u - countLeadingZeros((_e182 | 1u)));
        let _e189 = min(_e187, 23u);
        let _e191 = (_e187 - _e189);
        local_6 = bitcast<u32>(bitcast<f32>(select(0u, ((((_e187 + 127u) << 23u) | (((_e182 << (23u - _e189)) >> _e191) & 8388607u)) + select(0u, 1u, ((_e182 & ((1u << _e191) - 1u)) != 0u))), (_e182 != 0u))));
    }
    let _e213 = local_6;
    local_3 = u32((base + 4u));
    let _e218 = local_3;
    output[_e218] = _e213;
    let _e220 = counter;
    local_7 = u32((base + 5u));
    let _e225 = local_7;
    output[_e225] = _e220;
    let _e229 = u32(-(1i));
    let _e234 = (31u - countLeadingZeros((_e229 | 1u)));
    let _e236 = min(_e234, 23u);
    let _e238 = (_e234 - _e236);
    local_8 = u32((base + 6u));
    let _e262 = local_8;
    output[_e262] = bitcast<u32>(bitcast<f32>(select(0u, ((((_e234 + 127u) << 23u) | (((_e229 << (23u - _e236)) >> _e238) & 8388607u)) + select(0u, 1u, ((_e229 & ((1u << _e238) - 1u)) != 0u))), (_e229 != 0u))));
    let _e265 = u32(3.5f);
    let _e270 = (31u - countLeadingZeros((_e265 | 1u)));
    let _e272 = min(_e270, 23u);
    let _e274 = (_e270 - _e272);
    local_9 = u32((base + 7u));
    let _e298 = local_9;
    output[_e298] = bitcast<u32>(bitcast<f32>(select(0u, ((((_e270 + 127u) << 23u) | (((_e265 << (23u - _e272)) >> _e274) & 8388607u)) + select(0u, 1u, ((_e265 & ((1u << _e274) - 1u)) != 0u))), (_e265 != 0u))));
    let _e304 = (31u - countLeadingZeros((value_1 | 1u)));
    let _e306 = min(_e304, 23u);
    local_10 = u32((base + 8u));
    let _e326 = local_10;
    output[_e326] = bitcast<u32>(bitcast<f32>(select(0u, (((_e304 + 127u) << 23u) | (((value_1 << (23u - _e306)) >> (_e304 - _e306)) & 8388607u)), (value_1 != 0u))));
    let _e332 = (31u - countLeadingZeros((value_1 | 1u)));
    let _e334 = min(_e332, 23u);
    let _e336 = (_e332 - _e334);
    let _e338 = ((value_1 << (23u - _e334)) >> _e336);
    let _e345 = (1u << _e336);
    local_11 = u32((base + 9u));
    let _e363 = local_11;
    output[_e363] = bitcast<u32>(bitcast<f32>(select(0u, ((((_e332 + 127u) << 23u) | (_e338 & 8388607u)) + select(0u, 1u, ((((value_1 & (_e345 - 1u)) << 1u) | (_e338 & 1u)) > _e345))), (value_1 != 0u))));
}
