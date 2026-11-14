__device__ unsigned min_max_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void packed_min_max(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        unsigned base = 4u + row * 8u;
        output[base + 0u] = __vmins2(a, b);
        output[base + 1u] = __vmins4(a, b);
        output[base + 2u] = __vminu2(a, b);
        output[base + 3u] = __vminu4(a, b);
        output[base + 4u] = __vmaxs2(a, b);
        output[base + 5u] = __vmaxs4(a, b);
        output[base + 6u] = __vmaxu2(a, b);
        output[base + 7u] = __vmaxu4(a, b);
    }
    unsigned base = 4u + count * 8u + lane * 27u;
    unsigned value = 1u;
    output[base + 0u] = __vmins2(min_max_word(value, 0x01020304u, 0x80ff017fu), min_max_word(value, 0x03050709u, 0xfe028100u));
    output[base + 1u] = __vmins4(min_max_word(value, 0x01020304u, 0x80ff017fu), min_max_word(value, 0x03050709u, 0xfe028100u));
    output[base + 2u] = __vminu2(min_max_word(value, 0x01020304u, 0x80ff017fu), min_max_word(value, 0x03050709u, 0xfe028100u));
    output[base + 3u] = __vminu4(min_max_word(value, 0x01020304u, 0x80ff017fu), min_max_word(value, 0x03050709u, 0xfe028100u));
    output[base + 4u] = __vmaxs2(min_max_word(value, 0x01020304u, 0x80ff017fu), min_max_word(value, 0x03050709u, 0xfe028100u));
    output[base + 5u] = __vmaxs4(min_max_word(value, 0x01020304u, 0x80ff017fu), min_max_word(value, 0x03050709u, 0xfe028100u));
    output[base + 6u] = __vmaxu2(min_max_word(value, 0x01020304u, 0x80ff017fu), min_max_word(value, 0x03050709u, 0xfe028100u));
    output[base + 7u] = __vmaxu4(min_max_word(value, 0x01020304u, 0x80ff017fu), min_max_word(value, 0x03050709u, 0xfe028100u));
    output[base + 8u] = __vmins2(__vmins2(value++, 0xffffffffu), 0xffffffffu);
    (lane & 1u) == 0u ? __vmaxu2(value++, value++) : 0u;
    output[base + 9u] = value;
    false && __vmins4(value++, value++);
    true || __vmaxs4(value++, value++);
    __vminu4(value++, value++);
    output[base + 10u] = value;
    unsigned index = 1u;
    output[base + 11u] = __vmaxs4(input[index++], input[index++]);
    output[base + 12u] = index;
    output[base + 13u] = __vmins2(0x80008000u, 0x7fff7fffu);
    output[base + 14u] = __vmins4(0x80808080u, 0x7f7f7f7fu);
    output[base + 15u] = __vminu2(0x80008000u, 0x7fff7fffu);
    output[base + 16u] = __vminu4(0x80808080u, 0x7f7f7f7fu);
    output[base + 17u] = __vmaxs2(0x80008000u, 0x7fff7fffu);
    output[base + 18u] = __vmaxs4(0x80808080u, 0x7f7f7f7fu);
    output[base + 19u] = __vmaxu2(0x80008000u, 0x7fff7fffu);
    output[base + 20u] = __vmaxu4(0x80808080u, 0x7f7f7f7fu);
    output[base + 21u] = __vmins2(0xffffffffu, 0u);
    output[base + 22u] = __vmaxs4(0xffffffffu, 0x01010101u);
    output[base + 23u] = __vminu2(0xffffffffu, 0x00010001u);
    output[base + 24u] = __vmaxu4(0xffffffffu, 0u);
    output[base + 25u] = __vmins2(0x80ff017fu, 0x80ff017fu);
    output[base + 26u] = __vmaxu4(0x80ff017fu, 0x80ff017fu);
}
