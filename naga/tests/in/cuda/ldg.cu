__device__ unsigned read_value(const unsigned *pointer) { return __ldg(pointer); }
__global__ void load_values(const unsigned *input, unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 6u;
    const unsigned *alias = input;
    const unsigned *selected = input + lane;
    unsigned cursor = lane;
    output[base] = __ldg(input + lane);
    output[base + 1u] = read_value(alias + lane);
    output[base + 2u] = __ldg(input + cursor++);
    output[base + 3u] = cursor;
    selected = alias + (3u - lane);
    output[base + 4u] = __ldg(selected);
    output[base + 5u] = input[lane];
}
