template<int Bias> __device__ unsigned adjusted(unsigned value) {
    return value + unsigned(Bias);
}

template<int Width> __global__ void reduce(unsigned *output, const unsigned *input) {
    __shared__ unsigned values[Width];
    unsigned lane = threadIdx.x;
    unsigned base = blockIdx.x * 4u;
    values[lane] = input[base + lane];
    __syncthreads();
    for (unsigned stride = 2u; stride > 0u; stride >>= 1u) {
        if (lane < stride) values[lane] += values[lane + stride];
        __syncthreads();
    }
    output[base + lane] = adjusted<Width>(values[0]);
}

template __global__ void reduce<4>(unsigned *, const unsigned *);
template __global__ void reduce<8>(unsigned *, const unsigned *);
