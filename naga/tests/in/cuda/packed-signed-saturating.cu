__device__ unsigned signed_saturating_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
extern "C" __global__ void packed_signed_saturating(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned a = input[1u + row * 2u];
        unsigned b = input[2u + row * 2u];
        unsigned base = 4u + row * 4u;
        output[base] = __vaddss2(a, b);
        output[base + 1u] = __vaddss4(a, b);
        output[base + 2u] = __vsubss2(a, b);
        output[base + 3u] = __vsubss4(a, b);
    }
    unsigned base = 4u + count * 4u + lane * 12u;
    unsigned value = 1u;
    output[base] = __vaddss2(signed_saturating_word(value, 0x01020304u, 0x80ff017fu), signed_saturating_word(value, 0x03050709u, 0xfe028100u));
    output[base + 1u] = __vaddss4(signed_saturating_word(value, 0x01020304u, 0x80ff017fu), signed_saturating_word(value, 0x03050709u, 0xfe028100u));
    output[base + 2u] = __vsubss2(signed_saturating_word(value, 0x01020304u, 0x80ff017fu), signed_saturating_word(value, 0x03050709u, 0xfe028100u));
    output[base + 3u] = __vsubss4(signed_saturating_word(value, 0x01020304u, 0x80ff017fu), signed_saturating_word(value, 0x03050709u, 0xfe028100u));
    (lane & 1u) == 0u ? __vaddss2(value++, value++) : 0u;
    output[base + 4u] = value;
    false && __vsubss2(value++, value++);
    true || __vaddss4(value++, value++);
    __vsubss4(value++, value++);
    output[base + 5u] = value;
    unsigned index = 1u;
    output[base + 6u] = __vsubss4(input[index++], input[index++]);
    output[base + 7u] = index;
    output[base + 8u] = __vaddss2(0x7fff7fffu, 0x00010001u);
    output[base + 9u] = __vaddss4(0x7f7f7f7fu, 0x01010101u);
    output[base + 10u] = __vsubss2(0x80008000u, 0x00010001u);
    output[base + 11u] = __vsubss4(0x80808080u, 0x01010101u);
}
