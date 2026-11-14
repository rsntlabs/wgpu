__device__ unsigned next_word(unsigned &value) { return value++; }
extern "C" __global__ void funnel_shifts_clamped(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 4u) {
        unsigned at = 1u + row * 3u;
        unsigned lo = input[at];
        unsigned hi = input[at + 1u];
        unsigned shift = input[at + 2u];
        output[4u + row * 2u] = __funnelshift_lc(lo, hi, shift);
        output[5u + row * 2u] = __funnelshift_rc(lo, hi, shift);
    }
    unsigned base = 4u + count * 2u + lane * 6u;
    unsigned value = 1u;
    output[base] = __funnelshift_lc(next_word(value), next_word(value), next_word(value));
    output[base + 1u] = __funnelshift_rc(next_word(value), next_word(value), next_word(value));
    (lane & 1u) == 0u ? __funnelshift_lc(value++, value++, value++) : 0u;
    output[base + 2u] = value;
    false && __funnelshift_rc(value++, value++, value++);
    true || __funnelshift_lc(value++, value++, value++);
    __funnelshift_rc(value++, value++, value++);
    output[base + 3u] = value;
    unsigned index = 1u;
    output[base + 4u] = __funnelshift_lc(input[index++], input[index++], input[index++]);
    output[base + 5u] = index;
}
