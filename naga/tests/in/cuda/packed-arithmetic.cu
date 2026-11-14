__device__ unsigned packed_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void packed_arithmetic(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        unsigned base = 4u + row * 4u;
        output[base] = __vadd2(a, b);
        output[base + 1u] = __vadd4(a, b);
        output[base + 2u] = __vsub2(a, b);
        output[base + 3u] = __vsub4(a, b);
    }
    unsigned base = 4u + count * 4u + lane * 12u;
    unsigned value = 1u;
    output[base] = __vadd2(packed_word(value, 0x01020304u, 0x80ff017fu), packed_word(value, 0x03050709u, 0xfe028100u));
    output[base + 1u] = __vadd4(packed_word(value, 0x01020304u, 0x80ff017fu), packed_word(value, 0x03050709u, 0xfe028100u));
    output[base + 2u] = __vsub2(packed_word(value, 0x01020304u, 0x80ff017fu), packed_word(value, 0x03050709u, 0xfe028100u));
    output[base + 3u] = __vsub4(packed_word(value, 0x01020304u, 0x80ff017fu), packed_word(value, 0x03050709u, 0xfe028100u));
    (lane & 1u) == 0u ? __vadd2(value++, value++) : 0u;
    output[base + 4u] = value;
    false && __vsub2(value++, value++);
    true || __vadd4(value++, value++);
    __vsub4(value++, value++);
    output[base + 5u] = value;
    unsigned index = 1u;
    output[base + 6u] = __vsub4(input[index++], input[index++]);
    output[base + 7u] = index;
    output[base + 8u] = __vadd2(0xffffffffu, 0x00010001u);
    output[base + 9u] = __vadd4(0xffffffffu, 0x01010101u);
    output[base + 10u] = __vsub2(0u, 0x00010001u);
    output[base + 11u] = __vsub4(0u, 0x01010101u);
}
