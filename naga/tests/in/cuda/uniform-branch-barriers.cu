namespace cg = cooperative_groups;
using Block = cg::thread_block;

__global__ void exchange(const unsigned *input, unsigned *output, unsigned mode) {
    __shared__ unsigned values[4];
    unsigned lane = threadIdx.x;
    unsigned base = blockIdx.x * 4u;
    values[lane] = input[base + lane];
    auto group = cg::this_thread_block();
    unsigned transformed;
    if (mode) {
        group.sync();
        transformed = values[(lane + 1u) % 4u] + 10u;
    } else {
        cg::sync(group);
        transformed = values[(lane + 2u) % 4u] + 20u;
    }
    Block::sync();
    values[lane] = transformed;
    switch ((blockIdx.x + mode) % 3u) {
        case 0u:
            group.sync();
            values[lane] += 1u;
            break;
        case 1u:
            cg::sync(group);
            values[lane] *= 2u;
        default:
            __syncthreads();
            values[lane] += 3u;
    }
    __syncthreads();
    output[base + lane] = values[(lane + 3u) % 4u];
}
