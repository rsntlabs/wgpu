struct type_3 {
    value: u32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u64>;
@group(0) @binding(1)
var<storage> input: array<u64>;
@group(0) @binding(2)
var<uniform> count: type_3;

fn reverse_word(value: u64) -> u64 {
    return ((u64(reverseBits(u32(value))) << 32u) | u64(reverseBits(u32((value >> 32u)))));
}

@compute @workgroup_size(64, 1, 1)
fn reverse_words(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    var local: u32;

    let count_1 = count.value;
    let index = ((blockIdx.x * 64u) + threadIdx.x);
    if (index >= count_1) {
        return;
    }
    let _e13 = input[index];
    let _e14 = reverse_word(_e13);
    local = u32((index + 4u));
    let _e19 = local;
    output[_e19] = _e14;
}
