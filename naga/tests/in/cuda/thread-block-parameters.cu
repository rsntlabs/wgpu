namespace cg = cooperative_groups;
using Block = cg::thread_block;
extern __shared__ unsigned values[];

__device__ void synchronize(const Block);
__device__ unsigned reduce(unsigned input, Block group, unsigned width);

__global__ void exchange(unsigned *output) {
    auto group = cg::this_thread_block();
    unsigned lane = group.thread_rank();
    unsigned value = blockIdx.x * 10u + lane + 1u;
    unsigned sum = reduce(value, Block{group}, group.size());
    unsigned base = blockIdx.x * 8u;
    output[base + lane] = sum;
    output[base + 4u + lane] = value * 10u + lane + group.size();
}

__device__ void synchronize(Block group) {
    if (group.group_index().x < gridDim.x) group.sync();
}

__device__ unsigned reduce(unsigned input, Block group, unsigned width) {
    unsigned lane = group.thread_rank();
    values[lane] = input;
    synchronize(group);
    for (unsigned stride = width / 2u; stride > 0u; stride >>= 1u) {
        if (lane < stride) values[lane] += values[lane + stride];
        cg::sync(group);
    }
    return values[0];
}
