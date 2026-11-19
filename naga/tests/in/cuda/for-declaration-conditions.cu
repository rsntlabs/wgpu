__device__ int stream_next(const int *input, unsigned offset, int &cursor) {
    return input[offset + unsigned(cursor++)];
}
__global__ void for_conditions(const int *input, unsigned *output) {
    unsigned lane = threadIdx.x + blockIdx.x * blockDim.x;
    if (lane >= 4u) return;
    unsigned offset = lane * 4u, base = 4u + lane * 8u;
    int cursor = 0, total = 0;
    unsigned iterations = 0u, observed = 0u;
    for (; int value = stream_next(input, offset, cursor); observed += unsigned(value), ++iterations) {
        total += value;
        value = 10 + int(iterations);
        if (iterations == 0u) continue;
    }
    output[base] = unsigned(total);
    output[base + 1u] = unsigned(cursor);
    output[base + 2u] = iterations;
    output[base + 3u] = observed;
    int inferred_cursor = 0, inferred_total = 0;
    for (; auto value{stream_next(input, offset, inferred_cursor)}; value = 0) {
        inferred_total += value;
        value = 99;
    }
    output[base + 4u] = unsigned(inferred_total);
    output[base + 5u] = unsigned(inferred_cursor);
    int break_cursor = 0, first = 0;
    unsigned continued = 0u;
    for (; const auto value = stream_next(input, offset, break_cursor); ++continued) {
        first = value;
        break;
    }
    output[base + 6u] = unsigned(break_cursor);
    output[base + 7u] = unsigned(first) + 100u * continued;
}
