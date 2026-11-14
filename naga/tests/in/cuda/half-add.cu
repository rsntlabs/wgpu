__device__ unsigned average_word(unsigned &value, unsigned scale) { return value++ * scale; }
extern "C" __global__ void half_add(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 4u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        unsigned base = 4u + row * 4u;
        output[base] = unsigned(__hadd(int(a), int(b)));
        output[base + 1u] = unsigned(__rhadd(int(a), int(b)));
        output[base + 2u] = __uhadd(a, b);
        output[base + 3u] = __urhadd(a, b);
    }
    unsigned base = 4u + count * 4u + lane * 10u;
    unsigned value = 1u;
    output[base] = unsigned(__hadd(int(average_word(value, 3u)), int(average_word(value, 5u))));
    output[base + 1u] = unsigned(__rhadd(int(average_word(value, 3u)), int(average_word(value, 5u))));
    output[base + 2u] = __uhadd(average_word(value, 3u), average_word(value, 5u));
    output[base + 3u] = __urhadd(average_word(value, 3u), average_word(value, 5u));
    (lane & 1u) == 0u ? __uhadd(value++, value++) : 0u;
    output[base + 4u] = value;
    false && __hadd(int(value++), int(value++));
    true || __urhadd(value++, value++);
    __rhadd(int(value++), int(value++));
    output[base + 5u] = value;
    unsigned index = 1u;
    output[base + 6u] = __uhadd(input[index++], input[index++]);
    output[base + 7u] = index;
    output[base + 8u] = unsigned(__hadd(-1, 0));
    output[base + 9u] = unsigned(__rhadd(-1, 0));
}
