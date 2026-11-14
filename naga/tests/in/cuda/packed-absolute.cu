__device__ unsigned absolute_word(unsigned &value) { return (value++ * 0x01020304u) ^ 0x80ff017fu; }
extern "C" __global__ void packed_absolute(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned value = input[1u + row];
        unsigned base = 4u + row * 4u;
        output[base] = __vabs2(value);
        output[base + 1u] = __vabs4(value);
        output[base + 2u] = __vabsss2(value);
        output[base + 3u] = __vabsss4(value);
    }
    unsigned base = 4u + count * 4u + lane * 17u;
    unsigned value = 1u;
    output[base] = __vabs2(absolute_word(value));
    output[base + 1u] = __vabs4(absolute_word(value));
    output[base + 2u] = __vabsss2(absolute_word(value));
    output[base + 3u] = __vabsss4(absolute_word(value));
    output[base + 4u] = __vabs4(__vabs4(value++));
    (lane & 1u) == 0u ? __vabsss4(value++) : 0u;
    output[base + 5u] = value;
    false && __vabs2(value++);
    true || __vabs4(value++);
    __vabs2(value++);
    output[base + 6u] = value;
    unsigned index = 1u;
    output[base + 7u] = __vabsss2(input[index++]);
    output[base + 8u] = index;
    output[base + 9u] = __vabs2(0x80008000u);
    output[base + 10u] = __vabsss2(0x80008000u);
    output[base + 11u] = __vabs4(0x80808080u);
    output[base + 12u] = __vabsss4(0x80808080u);
    output[base + 13u] = __vabs2(__vabs2(0x80008000u));
    output[base + 14u] = __vabs4(__vabs4(0x80808080u));
    output[base + 15u] = __vabsss2(__vabsss2(0x80008000u));
    output[base + 16u] = __vabsss4(__vabsss4(0x80808080u));
}
