__device__ unsigned negation_word(unsigned &value) { return (value++ * 0x01020304u) ^ 0x80ff017fu; }
extern "C" __global__ void packed_negation(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned value = input[1u + row];
        unsigned base = 4u + row * 4u;
        output[base] = __vneg2(value);
        output[base + 1u] = __vneg4(value);
        output[base + 2u] = __vnegss2(value);
        output[base + 3u] = __vnegss4(value);
    }
    unsigned base = 4u + count * 4u + lane * 17u;
    unsigned value = 1u;
    output[base] = __vneg2(negation_word(value));
    output[base + 1u] = __vneg4(negation_word(value));
    output[base + 2u] = __vnegss2(negation_word(value));
    output[base + 3u] = __vnegss4(negation_word(value));
    output[base + 4u] = __vneg4(__vneg4(value++));
    (lane & 1u) == 0u ? __vnegss4(value++) : 0u;
    output[base + 5u] = value;
    false && __vneg2(value++);
    true || __vneg4(value++);
    __vneg2(value++);
    output[base + 6u] = value;
    unsigned index = 1u;
    output[base + 7u] = __vnegss2(input[index++]);
    output[base + 8u] = index;
    output[base + 9u] = __vneg2(0x80008000u);
    output[base + 10u] = __vnegss2(0x80008000u);
    output[base + 11u] = __vneg4(0x80808080u);
    output[base + 12u] = __vnegss4(0x80808080u);
    output[base + 13u] = __vneg2(__vneg2(0x80008000u));
    output[base + 14u] = __vneg4(__vneg4(0x80808080u));
    output[base + 15u] = __vnegss2(__vnegss2(0x80008000u));
    output[base + 16u] = __vnegss4(__vnegss4(0x80808080u));
}
