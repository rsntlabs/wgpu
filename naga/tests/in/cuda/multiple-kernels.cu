namespace cg = cooperative_groups;

__device__ unsigned coordinate();
__device__ void advance(int &value, int amount) { value += amount; }

__global__ void next_neighbor(int *output, const int *input, int offset) {
    __shared__ int shared_values[4];
    unsigned lane = threadIdx.x;
    unsigned base = blockIdx.x * 4u;
    shared_values[lane] = input[base + lane] + offset;
    cg::thread_block group = cg::this_thread_block();
    group.sync();
    int &selected = shared_values[(lane + 1u) % 4u];
    int value = selected;
    advance(value, int(coordinate()));
    output[base + lane] = value;
}

__global__ void previous_neighbor(int *output, const int *input, int offset) {
    __shared__ int shared_values[4];
    unsigned lane = threadIdx.x;
    unsigned base = blockIdx.x * 4u;
    shared_values[lane] = input[base + lane] - offset;
    __syncthreads();
    int *selected = &shared_values[(lane + 3u) % 4u];
    int value = *selected;
    advance(value, int(coordinate()));
    output[base + lane] = value;
}

__device__ unsigned coordinate() {
    return threadIdx.x + blockIdx.x * 10u + gridDim.x + blockDim.x;
}
