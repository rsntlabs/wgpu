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
    var local_9: u32;
    var local_10: u32;
    var local_11: u32;
    var local_12: u32;
    var local_13: u32;
    var local_14: u32;
    var local_15: u32;
    var local_16: u32;
    var local_17: u32;

    bias = 3i;
    Count = 2i;
    local = u32(0i);
    let _e9 = local;
    local_9 = u32(_e9);
    let _e12 = local_9;
    let _e15 = input[_e12];
    values[0] = _e15;
    local_1 = u32(1i);
    let _e20 = local_1;
    local_10 = u32(_e20);
    let _e23 = local_10;
    let _e25 = input[_e23];
    values[1] = _e25;
    let _e28 = values[0i];
    let _e29 = bias;
    let _e30 = combine(_e28, _e29);
    sample.value = _e30;
    let _e36 = values[1i];
    sample.samples[0] = _e36;
    sample.samples[1] = -(2i);
    let _e42 = sample.value;
    local_2 = u32(0i);
    let _e46 = local_2;
    local_11 = u32(_e46);
    let _e49 = local_11;
    output[_e49] = _e42;
    let _e58 = sample.samples[0i];
    let _e59 = sample.samples[1i];
    local_3 = u32(1i);
    let _e64 = local_3;
    local_12 = u32(_e64);
    let _e67 = local_12;
    output[_e67] = (_e58 + _e59);
    local_4 = u32(2i);
    let _e75 = local_4;
    local_13 = u32(_e75);
    let _e78 = local_13;
    output[_e78] = i32(-(3.75f));
    local_6 = u32(0i);
    let _e83 = local_6;
    local_14 = u32(_e83);
    let _e86 = local_14;
    let _e88 = input[_e86];
    local_5 = u32(3i);
    let _e96 = local_5;
    local_15 = u32(_e96);
    let _e99 = local_15;
    output[_e99] = i32((u32(_e88) < 1u));
    local_7 = u32(4i);
    let _e107 = local_7;
    local_16 = u32(_e107);
    let _e110 = local_16;
    output[_e110] = i32(-(2.75f));
    local_8 = u32(5i);
    let _e117 = local_8;
    local_17 = u32(_e117);
    let _e120 = local_17;
    output[_e120] = i32(3.75f);
}
