__device__ unsigned dot2_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void dp2a(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 4u) {
        unsigned at = 1u + row * 3u;
        unsigned a = input[at];
        unsigned b = input[at + 1u];
        unsigned accumulator = input[at + 2u];
        unsigned base = 4u + row * 4u;
        output[base] = unsigned(__dp2a_lo(int(a), int(b), int(accumulator)));
        output[base + 1u] = unsigned(__dp2a_hi(int(a), int(b), int(accumulator)));
        output[base + 2u] = __dp2a_lo(a, b, accumulator);
        output[base + 3u] = __dp2a_hi(a, b, accumulator);
    }
    unsigned base = 4u + count * 4u + lane * 12u;
    unsigned value = 1u;
    output[base] = __dp2a_lo(dot2_word(value, 0x01020304u, 0x80ff017fu), dot2_word(value, 0x03050709u, 0xfe028100u), unsigned(-int(dot2_word(value, 17u, 0u))));
    output[base + 1u] = __dp2a_hi(dot2_word(value, 0x01020304u, 0x80ff017fu), dot2_word(value, 0x03050709u, 0xfe028100u), unsigned(-int(dot2_word(value, 17u, 0u))));
    output[base + 2u] = unsigned(__dp2a_lo(int(dot2_word(value, 0x01020304u, 0x80ff017fu)), int(dot2_word(value, 0x03050709u, 0xfe028100u)), -int(dot2_word(value, 17u, 0u))));
    output[base + 3u] = unsigned(__dp2a_hi(int(dot2_word(value, 0x01020304u, 0x80ff017fu)), int(dot2_word(value, 0x03050709u, 0xfe028100u)), -int(dot2_word(value, 17u, 0u))));
    (lane & 1u) == 0u ? __dp2a_lo(value++, value++, value++) : 0u;
    output[base + 4u] = value;
    false && __dp2a_hi(value++, value++, value++);
    true || __dp2a_lo(value++, value++, value++);
    __dp2a_hi(value++, value++, value++);
    output[base + 5u] = value;
    unsigned index = 1u;
    output[base + 6u] = __dp2a_lo(input[index++], input[index++], input[index++]);
    output[base + 7u] = index;
    output[base + 8u] = __dp2a_lo(0xffffffffu, 0xffffffffu, 0xffffffffu);
    output[base + 9u] = __dp2a_hi(0xffffffffu, 0xffffffffu, 0xffffffffu);
    output[base + 10u] = unsigned(__dp2a_lo(int(0x80008000u), int(0x80808080u), 2147483647));
    output[base + 11u] = unsigned(__dp2a_hi(int(0x80008000u), int(0x7f7f7f7fu), -2147483647 - 1));
}
