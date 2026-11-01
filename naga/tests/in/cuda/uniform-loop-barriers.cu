namespace cg = cooperative_groups;

__global__ void reduce(const unsigned *input, unsigned *output, unsigned count) {
    unsigned lane = threadIdx.x;
    unsigned sum = 0u;
    for (unsigned index = lane; index < count; index += 8u) {
        sum += input[blockIdx.x * count + index];
    }
    __shared__ unsigned values[8];
    values[lane] = sum;
    auto group = cg::this_thread_block();
    for (unsigned stride = 4u; stride > 0u; stride >>= 1u) {
        cg::sync(group);
        if (lane < stride) values[lane] += values[lane + stride];
    }
    if (lane == 0u) output[blockIdx.x] = values[0];
}
