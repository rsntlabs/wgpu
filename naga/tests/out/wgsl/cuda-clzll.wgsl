struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i64>;
@group(0) @binding(2)
var<uniform> count: type_5;

fn leading_word(value: i64) -> i32 {
    let _e4 = u32((value >> 32u));
    return i32(select((32u + countLeadingZeros(u32(value))), countLeadingZeros(_e4), (_e4 != 0u)));
}

@compute @workgroup_size(64, 1, 1)
fn leading_zero_counts(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;

    let count_1 = count.value;
    let index = ((blockIdx.x * 64u) + threadIdx.x);
    if (index >= count_1) {
        return;
    }
    let _e13 = input[index];
    let _e14 = leading_word(_e13);
    local = u32((index + 4u));
    let _e19 = local;
    output[_e19] = _e14;
}
