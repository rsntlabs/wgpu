@group(0) @binding(0)
var<storage, read_write> output: array<i32>;
@group(0) @binding(1)
var<storage> input: array<u64>;

fn count_word(value: u64) -> i32 {
    return i32((countOneBits(u32(value)) + countOneBits(u32((value >> 32u)))));
}

@compute @workgroup_size(4, 1, 1)
fn popcounts(@builtin(local_invocation_id) threadIdx: vec3<u32>) {
    let index = threadIdx.x;
    let _e4 = input[index];
    let _e5 = count_word(_e4);
    output[index] = _e5;
}
