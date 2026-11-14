__device__ unsigned average_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void packed_averages(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        unsigned base = 4u + row * 4u;
        output[base] = __vavgs2(a, b);
        output[base + 1u] = __vavgs4(a, b);
        output[base + 2u] = __vavgu2(a, b);
        output[base + 3u] = __vavgu4(a, b);
    }
    unsigned base = 4u + count * 4u + lane * 12u;
    unsigned value = 1u;
    output[base] = __vavgs2(average_word(value, 0x01020304u, 0x80ff017fu), average_word(value, 0x03050709u, 0xfe028100u));
    output[base + 1u] = __vavgs4(average_word(value, 0x01020304u, 0x80ff017fu), average_word(value, 0x03050709u, 0xfe028100u));
    output[base + 2u] = __vavgu2(average_word(value, 0x01020304u, 0x80ff017fu), average_word(value, 0x03050709u, 0xfe028100u));
    output[base + 3u] = __vavgu4(average_word(value, 0x01020304u, 0x80ff017fu), average_word(value, 0x03050709u, 0xfe028100u));
    (lane & 1u) == 0u ? __vavgs2(value++, value++) : 0u;
    output[base + 4u] = value;
    false && __vavgu2(value++, value++);
    true || __vavgs4(value++, value++);
    __vavgu4(value++, value++);
    output[base + 5u] = value;
    unsigned index = 1u;
    output[base + 6u] = __vavgu4(input[index++], input[index++]);
    output[base + 7u] = index;
    output[base + 8u] = __vavgs2(0xffffffffu, 0u);
    output[base + 9u] = __vavgs4(0xfdfdfdfdu, 0u);
    output[base + 10u] = __vavgu2(0xffffffffu, 0u);
    output[base + 11u] = __vavgu4(0xffffffffu, 0xffffffffu);
}
