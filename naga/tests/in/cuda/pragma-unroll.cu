constexpr unsigned Factor = 4u;

__device__ unsigned accumulate(unsigned seed) {
    const int Count = 3;
#pragma unroll Count + 1
    for (unsigned index = 0u; index < 3u; ++index) seed = seed * 2u + index;
    return seed;
}

__global__ void loops(const unsigned *input, unsigned *output) {
    unsigned lane = blockIdx.x * 4u + threadIdx.x;
    if (lane >= 4u) return;
    unsigned count = input[lane], tests = 0u, steps = 0u, total = 0u;
#pragma unroll
    for (unsigned index = 0u; (++tests, index < count); ++index, ++steps) {
        if (index == 2u) continue;
        if (index == 5u) break;
        total += index + 1u;
    }
    unsigned while_index = 0u, while_total = 0u;
#pragma unroll (Factor)
    while (while_index < 3u) while_total += ++while_index;
    unsigned do_index = 0u, do_total = 0u;
#pragma unroll 1
    do { do_total += do_index + 1u; ++do_index; } while (do_index < 2u);
    unsigned nested = 0u;
#pragma unroll 0
    for (unsigned outer = 0u; outer < 2u; ++outer) {
#pragma unroll -1
        for (unsigned inner = 0u; inner < 3u; ++inner) nested += outer * 10u + inner;
    }
    unsigned converted = 0u;
#pragma unroll 2147483648u
    for (unsigned index = 0u; index < 1u; ++index) converted += 5u;
#pragma unroll 0xffffffffu
    for (unsigned index = 0u; index < 1u; ++index) converted += 7u;
#pragma unroll int(3.75f)
    for (unsigned index = 0u; index < 2u; ++index) converted += index;
    unsigned offset = lane * 12u;
    output[offset] = total; output[offset + 1u] = tests; output[offset + 2u] = steps;
    output[offset + 3u] = while_total; output[offset + 4u] = while_index;
    output[offset + 5u] = do_total; output[offset + 6u] = do_index;
    output[offset + 7u] = accumulate(lane); output[offset + 8u] = nested;
    output[offset + 9u] = converted; output[offset + 10u] = Factor; output[offset + 11u] = count;
}
