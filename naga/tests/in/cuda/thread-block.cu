namespace cg = cooperative_groups;
namespace blocks = cg;
using Block = blocks::thread_block;

__global__ void exchange(unsigned *output) {
    Block original = blocks::this_thread_block();
    const Block fixed = original;
    auto group = fixed;
    __shared__ unsigned scratch[4];
    unsigned lane = threadIdx.x;
    unsigned base = blockIdx.x * 12u;
    scratch[lane] = blockIdx.x * 10u + lane + 1u;
    blocks::sync(group);
    output[base + lane] = scratch[(lane + 1u) % 4u];
    fixed.sync();
    output[base + 4u + lane] = output[base + (lane + 3u) % 4u];
    Block::sync();
    output[base + 8u + lane] = output[base + 4u + (lane + 1u) % 4u];
}
