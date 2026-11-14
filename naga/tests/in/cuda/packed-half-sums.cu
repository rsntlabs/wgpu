__device__ unsigned half_sum_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void packed_half_sums(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        output[4u + row * 2u] = __vhaddu2(a, b);
        output[5u + row * 2u] = __vhaddu4(a, b);
    }
    unsigned base = 4u + count * 2u + lane * 13u;
    unsigned value = 1u;
    output[base] = __vhaddu2(half_sum_word(value, 0x01020304u, 0x80ff017fu), half_sum_word(value, 0x03050709u, 0xfe028100u));
    output[base + 1u] = __vhaddu4(half_sum_word(value, 0x01020304u, 0x80ff017fu), half_sum_word(value, 0x03050709u, 0xfe028100u));
    output[base + 2u] = __vhaddu2(__vhaddu2(value++, 1u), 1u);
    output[base + 3u] = value;
    (lane & 1u) == 0u ? __vhaddu4(value++, value++) : 0u;
    output[base + 4u] = value;
    false && __vhaddu2(value++, value++);
    true || __vhaddu4(value++, value++);
    __vhaddu2(value++, value++);
    output[base + 5u] = value;
    unsigned index = 1u;
    output[base + 6u] = __vhaddu4(input[index++], input[index++]);
    output[base + 7u] = index;
    output[base + 8u] = __vhaddu2(0xffffffffu, 0xffffffffu);
    output[base + 9u] = __vhaddu4(0xffffffffu, 0u);
    output[base + 10u] = __vhaddu2(0xffffffffu, 0u);
    output[base + 11u] = __vhaddu4(0u, 0x01010101u);
    output[base + 12u] = __vhaddu2(0xffff0001u, 0x0001ffffu);
}
