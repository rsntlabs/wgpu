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
    var sample: Sample_cuda_record_0_;

    bias = 3i;
    Count = 2i;
    let _e10 = input[u32(0i)];
    values[0] = _e10;
    let _e15 = input[u32(1i)];
    values[1] = _e15;
    let _e18 = values[0i];
    let _e19 = bias;
    let _e20 = combine(_e18, _e19);
    sample.value = _e20;
    let _e26 = values[1i];
    sample.samples[0] = _e26;
    sample.samples[1] = -(2i);
    let _e32 = sample.value;
    output[u32(0i)] = _e32;
    let _e43 = sample.samples[0i];
    let _e44 = sample.samples[1i];
    output[u32(1i)] = (_e43 + _e44);
    output[u32(2i)] = i32(-(3.75f));
    let _e58 = input[u32(0i)];
    output[u32(3i)] = i32((u32(_e58) < 1u));
    output[u32(4i)] = i32(-(2.75f));
    output[u32(5i)] = i32(3.75f);
}
