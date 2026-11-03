template<unsigned Bias>
__device__ unsigned phase_exchange(unsigned phase, unsigned value) {
    __shared__ unsigned counter;
    unsigned lane = threadIdx.x;
    if (lane == 0u) {
        if (phase == 0u) counter = value + Bias + 40u;
        else counter += phase * 3u;
    }
    __syncthreads();
    unsigned saved_counter = counter;
    unsigned first;
    unsigned second;
    {
        __shared__ unsigned slots[2][2];
        if (phase == 0u) slots[lane / 2u][lane % 2u] = value + Bias;
        __syncthreads();
        unsigned neighbor = (lane + 1u) % 4u;
        unsigned next = slots[neighbor / 2u][neighbor % 2u];
        __syncthreads();
        if (phase != 0u) slots[lane / 2u][lane % 2u] = next + phase;
        __syncthreads();
        first = slots[lane / 2u][lane % 2u];
    }
    {
        __shared__ unsigned slots[4];
        if (phase == 0u) slots[lane] = value + Bias + 20u;
        __syncthreads();
        unsigned next = slots[(lane + 3u) % 4u];
        __syncthreads();
        if (phase != 0u) slots[lane] = next + phase * 2u;
        __syncthreads();
        second = slots[lane];
    }
    unsigned result = first | (second << 8u) | (saved_counter << 16u);
    __syncthreads();
    return result;
}

__device__ void phase_capture(unsigned *output, unsigned phase) {
    __shared__ unsigned slots[4];
    unsigned lane = threadIdx.x;
    if (phase == 0u) slots[lane] = 700u + blockIdx.x * 16u + lane;
    __syncthreads();
    unsigned next = slots[(lane + 1u) % 4u];
    __syncthreads();
    if (phase != 0u) slots[lane] = next + phase;
    __syncthreads();
    unsigned result = slots[lane];
    __syncthreads();
    unsigned offset = (blockIdx.x * 4u + lane) * 8u;
    output[offset + 6u + phase] = result;
}

__device__ void observe(unsigned *output) {
    unsigned value = blockIdx.x * 16u + threadIdx.x;
    unsigned offset = (blockIdx.x * 4u + threadIdx.x) * 8u;
    output[offset] = phase_exchange<10u>(0u, value);
    output[offset + 1u] = phase_exchange<100u>(0u, value);
    output[offset + 2u] = phase_exchange<10u>(1u, 0u);
    output[offset + 3u] = phase_exchange<100u>(1u, 0u);
    output[offset + 4u] = phase_exchange<10u>(2u, 0u);
    output[offset + 5u] = phase_exchange<100u>(2u, 0u);
    phase_capture(output, 0u);
    phase_capture(output, 1u);
}

__global__ void device_shared(unsigned *output) {
    observe(output);
}

__global__ void forwarded_shared(unsigned *output) {
    observe(output);
}
