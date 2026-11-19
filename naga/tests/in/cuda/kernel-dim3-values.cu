__device__ unsigned kind(dim3) { return 11u; }
__device__ unsigned kind(uint3) { return 22u; }
__device__ void change(dim3 &value, unsigned lane) {
    value.x += lane;
    value.y += 2u;
}
__global__ void dim3_values(unsigned *output, dim3 shape, const dim3 fixed) {
    unsigned lane = threadIdx.x + blockIdx.x * blockDim.x;
    if (lane >= 4u) return;
    unsigned base = 4u + lane * 14u;
    dim3 original = shape;
    uint3 packed = original;
    dim3 restored = packed;
    change(shape, lane);
    shape = dim3(shape.x, shape.y);
    dim3 local;
    dim3 partial(2u);
    output[base] = original.x;
    output[base + 1u] = original.y;
    output[base + 2u] = original.z;
    output[base + 3u] = shape.x;
    output[base + 4u] = shape.y;
    output[base + 5u] = shape.z;
    output[base + 6u] = local.x + local.y + local.z;
    output[base + 7u] = fixed.x;
    output[base + 8u] = fixed.y;
    output[base + 9u] = fixed.z;
    output[base + 10u] = kind(shape) + kind(packed);
    output[base + 11u] = restored.x ^ restored.y ^ restored.z;
    output[base + 12u] = blockDim.x;
    output[base + 13u] = partial.y + partial.z;
}
