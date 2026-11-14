__device__ unsigned difference_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void packed_absolute_differences(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        unsigned base = 4u + row * 4u;
        output[base] = __vabsdiffs2(a, b);
        output[base + 1u] = __vabsdiffs4(a, b);
        output[base + 2u] = __vabsdiffu2(a, b);
        output[base + 3u] = __vabsdiffu4(a, b);
    }
    unsigned base = 4u + count * 4u + lane * 17u;
    unsigned value = 1u;
    output[base] = __vabsdiffs2(difference_word(value, 0x01020304u, 0x80ff017fu), difference_word(value, 0x03050709u, 0xfe028100u));
    output[base + 1u] = __vabsdiffs4(difference_word(value, 0x01020304u, 0x80ff017fu), difference_word(value, 0x03050709u, 0xfe028100u));
    output[base + 2u] = __vabsdiffu2(difference_word(value, 0x01020304u, 0x80ff017fu), difference_word(value, 0x03050709u, 0xfe028100u));
    output[base + 3u] = __vabsdiffu4(difference_word(value, 0x01020304u, 0x80ff017fu), difference_word(value, 0x03050709u, 0xfe028100u));
    output[base + 4u] = __vabsdiffs2(__vabsdiffs2(value++, 0u), 0u);
    (lane & 1u) == 0u ? __vabsdiffs2(value++, value++) : 0u;
    output[base + 5u] = value;
    false && __vabsdiffs4(value++, value++);
    true || __vabsdiffu2(value++, value++);
    __vabsdiffu4(value++, value++);
    output[base + 6u] = value;
    unsigned index = 1u;
    output[base + 7u] = __vabsdiffu4(input[index++], input[index++]);
    output[base + 8u] = index;
    output[base + 9u] = __vabsdiffs2(0x80008000u, 0x7fff7fffu);
    output[base + 10u] = __vabsdiffs4(0x80808080u, 0x7f7f7f7fu);
    output[base + 11u] = __vabsdiffu2(0x80008000u, 0x7fff7fffu);
    output[base + 12u] = __vabsdiffu4(0x80808080u, 0x7f7f7f7fu);
    output[base + 13u] = __vabsdiffs2(0xffffffffu, 0u);
    output[base + 14u] = __vabsdiffu2(0xffffffffu, 0u);
    output[base + 15u] = __vabsdiffu4(0x80ff017fu, 0x80ff017fu);
    output[base + 16u] = __vabsdiffs4(0x7f7f7f7fu, 0x80808080u);
}
