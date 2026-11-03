template<unsigned Bias>
__launch_bounds__(1, 2, 4) __device__ unsigned shifted(unsigned value) {
    return value * 3u + Bias;
}

__device__ void observe(unsigned *output, const unsigned *input, unsigned count) {
    unsigned block_size = blockDim.x * blockDim.y * blockDim.z;
    unsigned local_index = threadIdx.x + blockDim.x * (threadIdx.y + blockDim.y * threadIdx.z);
    unsigned index = blockIdx.x * block_size + local_index;
    if (index < count) {
        unsigned offset = index * 4u;
        output[offset] = shifted<7u>(input[index]);
        output[offset + 1u] = block_size;
        output[offset + 2u] = local_index;
        output[offset + 3u] = blockIdx.x;
    }
}

__launch_bounds__(12, 2, 4) __global__ void bounded(unsigned *output, const unsigned *input, unsigned count) {
    observe(output, input, count);
}

template<unsigned Bound>
__global__ void __launch_bounds__(Bound, 1) bounded_template(unsigned *output, const unsigned *input, unsigned count) {
    observe(output, input, count);
}

template __global__ void bounded_template<12>(unsigned *, const unsigned *, unsigned);
