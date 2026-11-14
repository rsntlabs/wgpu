__device__ unsigned less_than_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void packed_less_than(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        unsigned base = 4u + row * 8u;
        output[base + 0u] = __vcmplts2(a, b);
        output[base + 1u] = __vcmplts4(a, b);
        output[base + 2u] = __vcmpltu2(a, b);
        output[base + 3u] = __vcmpltu4(a, b);
        output[base + 4u] = __vsetlts2(a, b);
        output[base + 5u] = __vsetlts4(a, b);
        output[base + 6u] = __vsetltu2(a, b);
        output[base + 7u] = __vsetltu4(a, b);
    }
    unsigned base = 4u + count * 8u + lane * 27u;
    unsigned value = 1u;
    output[base + 0u] = __vcmplts2(less_than_word(value, 0x02020202u, 0u), less_than_word(value, 0x01010101u, 0x01010101u));
    output[base + 1u] = __vcmplts4(less_than_word(value, 0x02020202u, 0u), less_than_word(value, 0x01010101u, 0x03030303u));
    output[base + 2u] = __vcmpltu2(less_than_word(value, 0x02020202u, 0u), less_than_word(value, 0x01010101u, 0x0d0d0d0du));
    output[base + 3u] = __vcmpltu4(less_than_word(value, 0x02020202u, 0u), less_than_word(value, 0x01010101u, 0x07070707u));
    output[base + 4u] = __vsetlts2(less_than_word(value, 0x02020202u, 0u), less_than_word(value, 0x01010101u, 0x19191919u));
    output[base + 5u] = __vsetlts4(less_than_word(value, 0x02020202u, 0u), less_than_word(value, 0x01010101u, 0x1b1b1b1bu));
    output[base + 6u] = __vsetltu2(less_than_word(value, 0x02020202u, 0u), less_than_word(value, 0x01010101u, 0x15151515u));
    output[base + 7u] = __vsetltu4(less_than_word(value, 0x02020202u, 0u), less_than_word(value, 0x01010101u, 0x0f0f0f0fu));
    output[base + 8u] = __vcmplts2(__vcmplts2(value++, 0xffffffffu), 0xffffffffu);
    (lane & 1u) == 0u ? __vsetltu2(value++, value++) : 0u;
    output[base + 9u] = value;
    false && __vcmplts4(value++, value++);
    true || __vsetlts4(value++, value++);
    __vcmpltu4(value++, value++);
    output[base + 10u] = value;
    unsigned index = 1u;
    output[base + 11u] = __vsetlts4(input[index++], input[index++]);
    output[base + 12u] = index;
    output[base + 13u] = __vcmplts2(0u, 0x00010001u);
    output[base + 14u] = __vcmplts4(0u, 0x01010101u);
    output[base + 15u] = __vcmpltu2(0u, 0x00010001u);
    output[base + 16u] = __vcmpltu4(0u, 0x01010101u);
    output[base + 17u] = __vsetlts2(0u, 0x00010001u);
    output[base + 18u] = __vsetlts4(0u, 0x01010101u);
    output[base + 19u] = __vsetltu2(0u, 0x00010001u);
    output[base + 20u] = __vsetltu4(0u, 0x01010101u);
    output[base + 21u] = __vcmplts2(0x80008000u, 0x7fff7fffu);
    output[base + 22u] = __vcmpltu2(0x80008000u, 0x7fff7fffu);
    output[base + 23u] = __vsetlts4(0x80808080u, 0x7f7f7f7fu);
    output[base + 24u] = __vsetltu4(0x80808080u, 0x7f7f7f7fu);
    output[base + 25u] = __vcmplts2(0x80ff017fu, 0x80ff017fu);
    output[base + 26u] = __vsetltu4(0x80ff017fu, 0x80ff017fu);
}
