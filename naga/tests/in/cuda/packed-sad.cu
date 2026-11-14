__device__ unsigned sad_reduction_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void packed_sad(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        unsigned base = 4u + row * 4u;
        output[base] = __vsads2(a, b);
        output[base + 1u] = __vsads4(a, b);
        output[base + 2u] = __vsadu2(a, b);
        output[base + 3u] = __vsadu4(a, b);
    }
    unsigned base = 4u + count * 4u + lane * 17u;
    unsigned value = 1u;
    output[base] = __vsads2(sad_reduction_word(value, 0x01020304u, 0x80ff017fu), sad_reduction_word(value, 0x03050709u, 0xfe028100u));
    output[base + 1u] = __vsads4(sad_reduction_word(value, 0x01020304u, 0x80ff017fu), sad_reduction_word(value, 0x03050709u, 0xfe028100u));
    output[base + 2u] = __vsadu2(sad_reduction_word(value, 0x01020304u, 0x80ff017fu), sad_reduction_word(value, 0x03050709u, 0xfe028100u));
    output[base + 3u] = __vsadu4(sad_reduction_word(value, 0x01020304u, 0x80ff017fu), sad_reduction_word(value, 0x03050709u, 0xfe028100u));
    output[base + 4u] = __vsads2(__vsads2(value++, 0u), 0u);
    (lane & 1u) == 0u ? __vsads2(value++, value++) : 0u;
    output[base + 5u] = value;
    false && __vsads4(value++, value++);
    true || __vsadu2(value++, value++);
    __vsadu4(value++, value++);
    output[base + 6u] = value;
    unsigned index = 1u;
    output[base + 7u] = __vsadu4(input[index++], input[index++]);
    output[base + 8u] = index;
    output[base + 9u] = __vsads2(0x80008000u, 0x7fff7fffu);
    output[base + 10u] = __vsads4(0x80808080u, 0x7f7f7f7fu);
    output[base + 11u] = __vsadu2(0x80008000u, 0x7fff7fffu);
    output[base + 12u] = __vsadu4(0x80808080u, 0x7f7f7f7fu);
    output[base + 13u] = __vsads2(0xffffffffu, 0u);
    output[base + 14u] = __vsadu2(0xffffffffu, 0u);
    output[base + 15u] = __vsadu4(0x80ff017fu, 0x80ff017fu);
    output[base + 16u] = __vsads4(0x7f7f7f7fu, 0x80808080u);
}
