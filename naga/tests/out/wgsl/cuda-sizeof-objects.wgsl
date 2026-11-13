struct float3_ {
    x: f32,
    y: f32,
    z: f32,
}

struct Record_cuda_record_0_ {
    vector: float3_,
    matrix: array<array<i32, 3>, 2>,
}

@group(0) @binding(0)
var<storage, read_write> output: array<u32>;

@compute @workgroup_size(64, 1, 1)
fn object_sizes() {
    var values: array<float3_, 2>;
    var record: Record_cuda_record_0_;
    var records: array<Record_cuda_record_0_, 2>;

    output[u32(0i)] = u32(24lu);
    output[u32(1i)] = u32(12lu);
    output[u32(2i)] = u32(8lu);
    output[u32(3i)] = u32(12lu);
    output[u32(4i)] = u32(24lu);
    output[u32(5i)] = u32(4lu);
    output[u32(6i)] = u32(4lu);
    output[u32(7i)] = u32(12lu);
    output[u32(8i)] = u32(12lu);
    output[u32(9i)] = u32(4lu);
    output[u32(10i)] = u32(36lu);
    output[u32(11i)] = u32(24lu);
    output[u32(12i)] = u32(24lu);
    output[u32(13i)] = u32(12lu);
    output[u32(14i)] = u32(12lu);
    output[u32(15i)] = u32(8lu);
    output[u32(16i)] = u32(1lu);
    output[u32(17i)] = u32(8lu);
    output[u32(18i)] = u32(4lu);
}
