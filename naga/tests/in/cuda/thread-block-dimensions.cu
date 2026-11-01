namespace cg = cooperative_groups;
namespace blocks = cg;
using Block = blocks::thread_block;

__device__ unsigned kind(dim3 value) { return 11u; }
__device__ unsigned kind(uint3 value) { return 22u; }

__global__ void dimensions(unsigned *output) {
    const Block group = cg::this_thread_block();
    dim3 local = group.thread_index();
    dim3 block = Block::group_index();
    dim3 extent = blocks::this_thread_block().dim_threads();
    dim3 legacy = ::cooperative_groups::thread_block::group_dim();
    dim3 copied = local; ++copied.x;
    uint3 packed = extent;
    unsigned local_index = threadIdx.x + 4u * (threadIdx.y + 3u * threadIdx.z);
    unsigned block_index = blockIdx.x + 2u * (blockIdx.y + 2u * blockIdx.z);
    unsigned offset = (block_index * 24u + local_index) * 16u;
    output[offset] = local.x; output[offset + 1u] = local.y; output[offset + 2u] = local.z;
    output[offset + 3u] = block.x; output[offset + 4u] = block.y; output[offset + 5u] = block.z;
    output[offset + 6u] = extent.x; output[offset + 7u] = extent.y; output[offset + 8u] = extent.z;
    output[offset + 9u] = legacy.x; output[offset + 10u] = legacy.y; output[offset + 11u] = legacy.z;
    output[offset + 12u] = kind(local) + kind(packed);
    output[offset + 13u] = copied.x; output[offset + 14u] = group.thread_index().x;
    output[offset + 15u] = packed.z;
}
