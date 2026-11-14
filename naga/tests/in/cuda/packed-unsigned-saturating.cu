__device__ unsigned saturating_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void packed_unsigned_saturating(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        unsigned base = 4u + row * 4u;
        output[base] = __vaddus2(a, b);
        output[base + 1u] = __vaddus4(a, b);
        output[base + 2u] = __vsubus2(a, b);
        output[base + 3u] = __vsubus4(a, b);
    }
    unsigned base = 4u + count * 4u + lane * 12u;
    unsigned value = 1u;
    output[base] = __vaddus2(saturating_word(value, 0x01020304u, 0x80ff017fu), saturating_word(value, 0x03050709u, 0xfe028100u));
    output[base + 1u] = __vaddus4(saturating_word(value, 0x01020304u, 0x80ff017fu), saturating_word(value, 0x03050709u, 0xfe028100u));
    output[base + 2u] = __vsubus2(saturating_word(value, 0x01020304u, 0x80ff017fu), saturating_word(value, 0x03050709u, 0xfe028100u));
    output[base + 3u] = __vsubus4(saturating_word(value, 0x01020304u, 0x80ff017fu), saturating_word(value, 0x03050709u, 0xfe028100u));
    (lane & 1u) == 0u ? __vaddus2(value++, value++) : 0u;
    output[base + 4u] = value;
    false && __vsubus2(value++, value++);
    true || __vaddus4(value++, value++);
    __vsubus4(value++, value++);
    output[base + 5u] = value;
    unsigned index = 1u;
    output[base + 6u] = __vsubus4(input[index++], input[index++]);
    output[base + 7u] = index;
    output[base + 8u] = __vaddus2(0xffffffffu, 0x00010001u);
    output[base + 9u] = __vaddus4(0xffffffffu, 0x01010101u);
    output[base + 10u] = __vsubus2(0u, 0x00010001u);
    output[base + 11u] = __vsubus4(0u, 0x01010101u);
}
