__device__ unsigned dot_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void dp4a(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 4u) {
        unsigned at = 1u + row * 3u;
        unsigned a = input[at];
        unsigned b = input[at + 1u];
        unsigned accumulator = input[at + 2u];
        output[4u + row * 2u] = unsigned(__dp4a(int(a), int(b), int(accumulator)));
        output[5u + row * 2u] = __dp4a(a, b, accumulator);
    }
    unsigned base = 4u + count * 2u + lane * 10u;
    unsigned value = 1u;
    output[base] = __dp4a(dot_word(value, 0x01020304u, 0x80ff017fu), dot_word(value, 0x03050709u, 0xfe028100u), unsigned(-int(dot_word(value, 17u, 0u))));
    output[base + 1u] = unsigned(__dp4a(int(dot_word(value, 0x01020304u, 0x80ff017fu)), int(dot_word(value, 0x03050709u, 0xfe028100u)), -int(dot_word(value, 17u, 0u))));
    (lane & 1u) == 0u ? __dp4a(value++, value++, value++) : 0u;
    output[base + 2u] = value;
    false && __dp4a(value++, value++, value++);
    true || __dp4a(value++, value++, value++);
    __dp4a(value++, value++, value++);
    output[base + 3u] = value;
    unsigned index = 1u;
    output[base + 4u] = __dp4a(input[index++], input[index++], input[index++]);
    output[base + 5u] = index;
    output[base + 6u] = __dp4a(0xffffffffu, 0xffffffffu, 0xffffffffu);
    output[base + 7u] = unsigned(__dp4a(int(0x80808080u), int(0x80808080u), 2147483647));
    output[base + 8u] = unsigned(__dp4a(int(0x80808080u), int(0x7f7f7f7fu), -2147483647 - 1));
    output[base + 9u] = __dp4a(0x01010101u, 0x01010101u, 0xffffu);
}
