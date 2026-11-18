__device__ int stream_next(const int *input, unsigned offset, int &cursor) {
    return input[offset + unsigned(cursor++)];
}
__global__ void while_conditions(const int *input, unsigned *output) {
    unsigned lane = threadIdx.x + blockIdx.x * blockDim.x;
    if (lane >= 4u) return;
    unsigned offset = lane * 4u;
    unsigned base = 4u + lane * 12u;
    int cursor = 0, total = 0;
    while (int entry = stream_next(input, offset, cursor)) {
        if (entry == 1) { entry = 99; continue; }
        total += entry;
    }
    output[base] = unsigned(total);
    output[base + 1u] = unsigned(cursor);
    int inferred_cursor = 0, inferred_total = 0;
    while (auto entry{stream_next(input, offset, inferred_cursor),}) {
        switch (entry) {
            case 1: entry = 77; continue;
            default: inferred_total += entry; break;
        }
    }
    output[base + 2u] = unsigned(inferred_total);
    output[base + 3u] = unsigned(inferred_cursor);
    int early_cursor = 0, first = 0;
    while (const auto entry = stream_next(input, offset, early_cursor)) { first = entry; break; }
    output[base + 4u] = unsigned(first);
    output[base + 5u] = unsigned(early_cursor);
    int repeat = 0;
    while (constexpr auto fixed = 1) { repeat += fixed; if (repeat == 2) break; }
    output[base + 6u] = unsigned(repeat);
    int entry = 50, nested = 0;
    while (auto entry = input[offset]) {
        { int entry = 9; nested += entry; }
        nested += entry;
        break;
    }
    output[base + 7u] = unsigned(nested);
    output[base + 8u] = unsigned(entry);
    int false_count = 0;
    while (auto stopped = (++false_count, 0)) ++total;
    output[base + 9u] = unsigned(false_count);
    while (float fraction{0.5f}) { ++total; break; }
    output[base + 10u] = unsigned(total);
    output[base + 11u] = unsigned(cursor + inferred_cursor + early_cursor + false_count);
}
