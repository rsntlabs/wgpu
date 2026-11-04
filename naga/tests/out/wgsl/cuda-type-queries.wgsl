struct type_1 {
    value: u64,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u64>;
@group(0) @binding(1)
var<uniform> base: type_1;

fn byte_count_float3_() -> u64 {
    return 12lu;
}

@compute @workgroup_size(64, 1, 1)
fn type_queries(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    let base_1 = base.value;
    let index = ((blockIdx.x * 64u) + threadIdx.x);
    let _e10 = byte_count_float3_();
    output[index] = ((((base_1 + _e10) + 24lu) * 8lu) + 8lu);
}
