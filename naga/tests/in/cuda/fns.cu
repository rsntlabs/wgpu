__device__ unsigned search_mask(unsigned &value) { return (value++ * 0x01020304u) ^ 0x80ff017fu; }
__device__ unsigned search_base(unsigned &value) { return (value++ * 5u) & 31u; }
__device__ int search_offset(unsigned &value) { return 2 - int(value++); }
extern "C" __global__ void fns(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    __shared__ unsigned shared_values[4];
    shared_values[lane] = lane + 1u;
    if (__fns(1u, 0u, 1) == 0u) __syncthreads();
    for (unsigned row = lane; row < count; row += 4u) {
        unsigned at = 1u + row * 3u;
        output[4u + row] = __fns(input[at], input[at + 1u], int(input[at + 2u]));
    }
    unsigned base = 4u + count + lane * 11u;
    unsigned value = 1u;
    output[base] = __fns(search_mask(value), search_base(value), search_offset(value));
    output[base + 1u] = value;
    (lane & 1u) == 0u ? __fns(value++, 0u, 1) : 0u;
    output[base + 2u] = value;
    false && __fns(value++, 0u, 1);
    true || __fns(value++, 0u, 1);
    __fns(value++, 0u, 1);
    output[base + 3u] = value;
    unsigned index = 1u;
    output[base + 4u] = __fns(input[index++], input[index++], int(input[index++]));
    output[base + 5u] = index;
    output[base + 6u] = __fns(0xaaaaaaaau, 2u, 0);
    output[base + 7u] = __fns(0xaaaaaaaau, 2u, 1);
    output[base + 8u] = __fns(0xaaaaaaaau, 2u, -1);
    output[base + 9u] = __fns(0xffffffffu, 31u, -2147483647 - 1);
    output[base + 10u] = shared_values[(lane + 1u) & 3u];
}
