__device__ unsigned byte_word(unsigned &value, unsigned scale, unsigned bias) { return (value++ * scale) ^ bias; }
__device__ unsigned byte_selector(unsigned &value) { return (value++ * 0x102u) ^ 0x7536u; }
extern "C" __global__ void byte_perm(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 64u) {
        unsigned at = 1u + row * 3u;
        output[4u + row] = __byte_perm(input[at], input[at + 1u], input[at + 2u]);
    }
    unsigned base = 4u + count + lane * 10u;
    unsigned value = 1u;
    output[base] = __byte_perm(byte_word(value, 0x01020304u, 0x80ff017fu), byte_word(value, 0x03050709u, 0xfe028100u), byte_selector(value));
    (lane & 1u) == 0u ? __byte_perm(value++, value++, value++) : 0u;
    output[base + 1u] = value;
    false && __byte_perm(value++, value++, value++);
    true || __byte_perm(value++, value++, value++);
    __byte_perm(value++, value++, value++);
    output[base + 2u] = value;
    unsigned index = 1u;
    output[base + 3u] = __byte_perm(input[index++], input[index++], input[index++]);
    output[base + 4u] = index;
    output[base + 5u] = __byte_perm(0x80ff017fu, 0xfe028100u, 0xffffu);
    output[base + 6u] = __byte_perm(0xffffffffu, 0u, 0xffffu);
    output[base + 7u] = __byte_perm(0x80ff017fu, 0xfe028100u, 0xffff7654u);
    output[base + 8u] = __byte_perm(0x80ff017fu, 0xfe028100u, -1);
    output[base + 9u] = __byte_perm(-1, 0u, 0x3210u);
}
