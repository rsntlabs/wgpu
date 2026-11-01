namespace cg = cooperative_groups;

__device__ void synchronize();
__device__ void rounds(unsigned count, unsigned mode);
__device__ unsigned finish(unsigned lane);

__global__ void exchange(unsigned *output, unsigned mode, unsigned count) {
    unsigned lane = threadIdx.x;
    unsigned base = blockIdx.x * 12u;
    output[base + lane] = blockIdx.x * 10u + lane + 1u;
    synchronize();
    unsigned next = output[base + (lane + 1u) % 4u];
    synchronize();
    output[base + lane] = next + 10u;
    rounds(count, mode);
    output[base + 4u + lane] = output[base + (lane + 1u) % 4u];
    output[base + 8u + lane] = finish(lane);
    synchronize();
}

__device__ void synchronize() { __syncthreads(); }

__device__ void rounds(unsigned count, unsigned mode) {
    auto group = cg::this_thread_block();
    for (unsigned iteration = 0u; iteration < count; ++iteration) {
        if (mode) group.sync();
        else cg::sync(group);
    }
}

__device__ unsigned finish(unsigned lane) {
    cg::thread_block::sync();
    if (lane & 1u) return lane + 100u;
    return lane + 200u;
}
