struct type_4 {
    value: u64,
}

struct type_5 {
    value: i64,
}

@group(0) @binding(0)
var<storage> input: array<i64>;
@group(0) @binding(1)
var<storage, read_write> output: array<u64>;
@group(0) @binding(2)
var<uniform> count: type_4;
@group(0) @binding(3)
var<uniform> bias: type_5;

fn kind(value: i64) -> u32 {
    return 3u;
}

fn kind_1(value_1: i64) -> u32 {
    return 5u;
}

fn identity_long(value_2: i64) -> i64 {
    return value_2;
}

@compute @workgroup_size(64, 1, 1)
fn long_types(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    let count_1 = count.value;
    let bias_1 = bias.value;
    let index = ((blockIdx.x * 64u) + threadIdx.x);
    if (u64(index) >= count_1) {
        return;
    }
    let _e17 = input[index];
    let value_3 = identity_long((_e17 + bias_1));
    let _e20 = kind(value_3);
    let _e23 = kind_1(value_3);
    let tags = ((_e20 * 10u) + _e23);
    output[index] = (u64((value_3 + 1li)) + u64(tags));
}
