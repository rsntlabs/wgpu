struct type_5 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<i32>;
@group(0) @binding(1)
var<storage> input: array<i64>;
@group(0) @binding(2)
var<uniform> count: type_5;

fn first_set_word(value: i64) -> i32 {
    let _e1 = u32(value);
    let _e4 = u32((value >> 32u));
    return i32(select(select(0u, (countTrailingZeros(_e4) + 33u), (_e4 != 0u)), (countTrailingZeros(_e1) + 1u), (_e1 != 0u)));
}

@compute @workgroup_size(64, 1, 1)
fn first_set_positions(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;

    let count_1 = count.value;
    let index = ((blockIdx.x * 64u) + threadIdx.x);
    if (index >= count_1) {
        return;
    }
    let _e13 = input[index];
    let _e14 = first_set_word(_e13);
    local = u32((index + 4u));
    let _e19 = local;
    output[_e19] = _e14;
}
