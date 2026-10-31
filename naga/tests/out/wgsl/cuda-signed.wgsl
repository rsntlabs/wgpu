struct Sample_cuda_record_0_ {
    value: i32,
    samples: array<i32, 2>,
}

@group(0) @binding(0)
var<storage, read_write> output: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i32>;

fn combine(first: i32, second: i32) -> i32 {
    return (first + second);
}

@compute @workgroup_size(1, 1, 1)
fn kernel() {
    var bias: i32;
    var Count: i32;
    var values: array<i32, 2>;
    var local: u32;
    var local_1: u32;
    var sample: Sample_cuda_record_0_;
    var local_2: u32;
    var local_3: u32;
    var local_4: u32;
    var local_5: u32;
    var local_6: u32;
    var local_7: u32;
    var local_8: u32;

    bias = 3i;
    Count = 2i;
    local = u32(0i);
    let _e9 = local;
    let _e12 = input[_e9];
    values[0] = _e12;
    local_1 = u32(1i);
    let _e17 = local_1;
    let _e19 = input[_e17];
    values[1] = _e19;
    let _e22 = values[0i];
    let _e23 = bias;
    let _e24 = combine(_e22, _e23);
    sample.value = _e24;
    let _e30 = values[1i];
    sample.samples[0] = _e30;
    sample.samples[1] = -(2i);
    let _e36 = sample.value;
    local_2 = u32(0i);
    let _e40 = local_2;
    output[_e40] = _e36;
    let _e49 = sample.samples[0i];
    let _e50 = sample.samples[1i];
    local_3 = u32(1i);
    let _e55 = local_3;
    output[_e55] = (_e49 + _e50);
    local_4 = u32(2i);
    let _e63 = local_4;
    output[_e63] = i32(-(3.75f));
    local_6 = u32(0i);
    let _e68 = local_6;
    let _e70 = input[_e68];
    local_5 = u32(3i);
    let _e78 = local_5;
    output[_e78] = i32((u32(_e70) < 1u));
    local_7 = u32(4i);
    let _e86 = local_7;
    output[_e86] = i32(-(2.75f));
    local_8 = u32(5i);
    let _e93 = local_8;
    output[_e93] = i32(3.75f);
}
