@group(0) @binding(0)
var<storage> a: array<f32>;
@group(0) @binding(1)
var<storage> b: array<f32>;
@group(0) @binding(2)
var<storage, read_write> out: array<f32>;

@compute @workgroup_size(1, 1, 1)
fn add(@builtin(workgroup_id) blockIdx: vec3<u32>, @builtin(local_invocation_id) threadIdx: vec3<u32>) {
    let i = ((blockIdx.x * 1u) + threadIdx.x);
    let _e9 = b[i];
    let _e14 = a[i];
    out[i] = (_e14 + (_e9 * 2f));
}
