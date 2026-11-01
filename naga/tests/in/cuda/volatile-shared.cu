__device__ void write(volatile unsigned &value, unsigned amount) {
    value = amount;
}

__device__ unsigned read(const volatile unsigned *values, unsigned index) {
    values[index];
    return values[index];
}

__global__ void exchange(unsigned *output) {
    __shared__ unsigned values[4];
    unsigned lane = threadIdx.x;
    unsigned block = blockIdx.x;
    write(values[lane], block * 1000u + lane);
    __syncthreads();
    unsigned neighbor = read(values, (lane + 1u) % 4u);
    __syncthreads();
    write(values[lane], neighbor + 17u);
    __syncthreads();
    output[block * 4u + lane] = read(values, (lane + 3u) % 4u);
}
