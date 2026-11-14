__device__ unsigned sad_word(unsigned &value, unsigned scale) { return value++ * scale; }
extern "C" __global__ void sad(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 4u) {
        unsigned a = input[1u + row * 3u];
        unsigned b = input[2u + row * 3u];
        unsigned accumulator = input[3u + row * 3u];
        output[4u + row * 2u] = __sad(int(a), int(b), accumulator);
        output[5u + row * 2u] = __usad(a, b, accumulator);
    }
    unsigned base = 4u + count * 2u + lane * 10u;
    unsigned value = 1u;
    output[base] = __sad(int(sad_word(value, 3u)), int(sad_word(value, 5u)), -int(sad_word(value, 7u)));
    output[base + 1u] = __usad(sad_word(value, 3u), sad_word(value, 5u), -int(sad_word(value, 7u)));
    (lane & 1u) == 0u ? __sad(int(value++), int(value++), value++) : 0u;
    output[base + 2u] = value;
    false && __sad(int(value++), int(value++), value++);
    true || __usad(value++, value++, value++);
    __usad(value++, value++, value++);
    output[base + 3u] = value;
    unsigned index = 1u;
    output[base + 4u] = __usad(input[index++], input[index++], input[index++]);
    output[base + 5u] = index;
    output[base + 6u] = __sad(-2147483647 - 1, 2147483647, 1u);
    output[base + 7u] = __sad(-1, 0, 0xffffffffu);
    output[base + 8u] = __usad(0u, 0xffffffffu, 0xffffffffu);
    output[base + 9u] = __sad(0xffffffffu, 0u, 0u);
}
