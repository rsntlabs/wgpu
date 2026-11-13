struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

@compute @workgroup_size(64, 1, 1)
fn object_sizes() {
    var values: array<float3_, 2>;

    output[u32(0i)] = u32(24lu);
    output[u32(1i)] = u32(12lu);
    output[u32(2i)] = u32(8lu);
}
