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
    var local_9: i32;
    var local_10: i32;
    var local_11: i32;
    var local_12: u32;
    var local_13: i32;
    var local_14: u32;
    var local_15: i32;
    var local_16: u32;
    var local_17: u32;
    var local_18: u32;
    var local_19: u32;
    var local_20: i32;
    var local_21: u32;
    var local_22: u32;
    var local_23: u32;

    bias = 3i;
    Count = 2i;
    local = u32(0i);
    let _e10 = local;
    local_12 = u32(_e10);
    let _e14 = local_12;
    let _e16 = input[_e14];
    local_13 = _e16;
    let _e17 = local_13;
    local_9 = _e17;
    let _e19 = local_9;
    values[0] = _e19;
    local_1 = u32(1i);
    let _e24 = local_1;
    local_14 = u32(_e24);
    let _e28 = local_14;
    let _e30 = input[_e28];
    local_15 = _e30;
    let _e31 = local_15;
    local_10 = _e31;
    let _e33 = local_10;
    values[1] = _e33;
    let _e36 = values[0i];
    let _e37 = bias;
    let _e38 = combine(_e36, _e37);
    sample.value = _e38;
    let _e44 = values[1i];
    sample.samples[0] = _e44;
    sample.samples[1] = -(2i);
    let _e50 = sample.value;
    local_2 = u32(0i);
    let _e55 = local_2;
    local_16 = u32(_e55);
    let _e58 = local_16;
    output[_e58] = _e50;
    let _e66 = sample.samples[0i];
    let _e67 = sample.samples[1i];
    local_3 = u32(1i);
    let _e72 = local_3;
    local_17 = u32(_e72);
    let _e75 = local_17;
    output[_e75] = (_e66 + _e67);
    local_4 = u32(2i);
    let _e83 = local_4;
    local_18 = u32(_e83);
    let _e86 = local_18;
    output[_e86] = i32(-(3.75f));
    local_6 = u32(0i);
    let _e91 = local_6;
    local_19 = u32(_e91);
    let _e95 = local_19;
    let _e97 = input[_e95];
    local_20 = _e97;
    let _e98 = local_20;
    local_11 = _e98;
    let _e100 = local_11;
    local_5 = u32(3i);
    let _e108 = local_5;
    local_21 = u32(_e108);
    let _e111 = local_21;
    output[_e111] = i32((u32(_e100) < 1u));
    local_7 = u32(4i);
    let _e119 = local_7;
    local_22 = u32(_e119);
    let _e122 = local_22;
    output[_e122] = i32(-(2.75f));
    local_8 = u32(5i);
    let _e129 = local_8;
    local_23 = u32(_e129);
    let _e132 = local_23;
    output[_e132] = i32(3.75f);
}
