namespace cg = cooperative_groups;
using Element = unsigned;
extern __shared__ Element global_values[];

__device__ void initialize(unsigned index, unsigned value) {
    extern __shared__ unsigned helper_values[];
    helper_values[index] = value;
}

__device__ void increment(unsigned &value) { ++value; }

__global__ void exchange(unsigned *output) {
    extern __shared__ unsigned local_values[];
    __shared__ unsigned fixed_values[4];
    unsigned lane = threadIdx.x;
    unsigned base = blockIdx.x * 8u;
    initialize(lane, blockIdx.x * 10u + lane + 1u);
    fixed_values[lane] = 100u + lane;
    auto group = cg::this_thread_block();
    group.sync();
    {
        extern __shared__ Element nested_values[];
        unsigned neighbor = (lane + 1u) % 4u;
        output[base + lane] = nested_values[neighbor] + fixed_values[lane];
    }
    cg::sync(group);
    auto pointer = local_values;
    unsigned &saved = pointer[lane];
    increment(saved);
    output[base + 4u + lane] = global_values[lane];
}
