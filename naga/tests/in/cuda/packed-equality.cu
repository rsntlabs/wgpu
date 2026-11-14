__device__ unsigned equality_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void packed_equality(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        unsigned base = 4u + row * 8u;
        output[base + 0u] = __vcmpeq2(a, b);
        output[base + 1u] = __vcmpeq4(a, b);
        output[base + 2u] = __vcmpne2(a, b);
        output[base + 3u] = __vcmpne4(a, b);
        output[base + 4u] = __vseteq2(a, b);
        output[base + 5u] = __vseteq4(a, b);
        output[base + 6u] = __vsetne2(a, b);
        output[base + 7u] = __vsetne4(a, b);
    }
    unsigned base = 4u + count * 8u + lane * 27u;
    unsigned value = 1u;
    output[base + 0u] = __vcmpeq2(equality_word(value, 0x01010101u, 0u), equality_word(value, 0x02020202u, 0x05050505u));
    output[base + 1u] = __vcmpeq4(equality_word(value, 0x01010101u, 0u), equality_word(value, 0x02020202u, 0x0b0b0b0bu));
    output[base + 2u] = __vcmpne2(equality_word(value, 0x01010101u, 0u), equality_word(value, 0x02020202u, 0x09090909u));
    output[base + 3u] = __vcmpne4(equality_word(value, 0x01010101u, 0u), equality_word(value, 0x02020202u, 0x17171717u));
    output[base + 4u] = __vseteq2(equality_word(value, 0x01010101u, 0u), equality_word(value, 0x02020202u, 0x1d1d1d1du));
    output[base + 5u] = __vseteq4(equality_word(value, 0x01010101u, 0u), equality_word(value, 0x02020202u, 0x13131313u));
    output[base + 6u] = __vsetne2(equality_word(value, 0x01010101u, 0u), equality_word(value, 0x02020202u, 0x11111111u));
    output[base + 7u] = __vsetne4(equality_word(value, 0x01010101u, 0u), equality_word(value, 0x02020202u, 0x2f2f2f2fu));
    output[base + 8u] = __vcmpeq2(__vcmpeq2(value++, 0xffffffffu), 0xffffffffu);
    (lane & 1u) == 0u ? __vsetne2(value++, value++) : 0u;
    output[base + 9u] = value;
    false && __vcmpeq4(value++, value++);
    true || __vseteq4(value++, value++);
    __vcmpne4(value++, value++);
    output[base + 10u] = value;
    unsigned index = 1u;
    output[base + 11u] = __vseteq4(input[index++], input[index++]);
    output[base + 12u] = index;
    output[base + 13u] = __vcmpeq2(0x80ff017fu, 0x80ff017fu);
    output[base + 14u] = __vcmpeq4(0x80ff017fu, 0x80ff017fu);
    output[base + 15u] = __vcmpne2(0x80ff017fu, 0x80ff017fu);
    output[base + 16u] = __vcmpne4(0x80ff017fu, 0x80ff017fu);
    output[base + 17u] = __vseteq2(0x80ff017fu, 0x80ff017fu);
    output[base + 18u] = __vseteq4(0x80ff017fu, 0x80ff017fu);
    output[base + 19u] = __vsetne2(0x80ff017fu, 0x80ff017fu);
    output[base + 20u] = __vsetne4(0x80ff017fu, 0x80ff017fu);
    output[base + 21u] = __vcmpeq2(0x12345678u, 0x1234abcdu);
    output[base + 22u] = __vcmpne2(0x12345678u, 0x1234abcdu);
    output[base + 23u] = __vseteq2(0x12345678u, 0x1234abcdu);
    output[base + 24u] = __vsetne2(0x12345678u, 0x1234abcdu);
    output[base + 25u] = __vseteq4(0x807f3302u, 0x7f803301u);
    output[base + 26u] = __vsetne4(0x807f3302u, 0x7f803301u);
}
