__device__ unsigned product_word(unsigned &value, unsigned scale) { return value++ * scale; }
extern "C" __global__ void multiply_high(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 4u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        output[4u + row * 2u] = __umulhi(a, b);
        output[5u + row * 2u] = unsigned(__mulhi(int(a), int(b)));
    }
    unsigned base = 4u + count * 2u + lane * 10u;
    unsigned value = 1u;
    output[base] = __umulhi(product_word(value, 0x40000001u), product_word(value, 0x20000003u));
    output[base + 1u] = unsigned(__mulhi(int(product_word(value, 0x40000001u)), int(product_word(value, 0x20000003u))));
    (lane & 1u) == 0u ? __umulhi(value++, value++) : 0u;
    output[base + 2u] = value;
    false && __mulhi(int(value++), int(value++));
    true || __umulhi(value++, value++);
    __mulhi(int(value++), int(value++));
    output[base + 3u] = value;
    unsigned index = 1u;
    output[base + 4u] = __umulhi(input[index++], input[index++]);
    output[base + 5u] = index;
    output[base + 6u] = unsigned(__mulhi(-1, 1));
    output[base + 7u] = unsigned(__mulhi(-2147483647 - 1, -2147483647 - 1));
    output[base + 8u] = __umulhi(0xffffffffu, 0xffffffffu);
    output[base + 9u] = __umulhi(-1, 2u);
}
