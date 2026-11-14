__device__ unsigned swap_take(unsigned &value) { return value++; }
__device__ int swap_result(unsigned value) { return 1; }
__device__ int swap_result(int value) { return 2; }
extern "C" __global__ void byte_swap32(unsigned *output, const unsigned *input) {
    unsigned lane = threadIdx.x;
    unsigned count = input[0];
    for (unsigned row = lane; row < count; row += 4u) {
        unsigned value = input[1u + row];
        output[4u + row * 2u] = __nv_bswap32(value);
        output[5u + row * 2u] = __nv_bswap32(__nv_bswap32(value));
    }
    unsigned base = 4u + count * 2u + lane * 10u;
    unsigned value = 0x01020304u + lane;
    output[base] = __nv_bswap32(swap_take(value));
    output[base + 1u] = __nv_bswap32(value++);
    output[base + 2u] = value;
    (lane & 1u) == 0u ? __nv_bswap32(value++) : 0u;
    output[base + 3u] = value;
    false && __nv_bswap32(value++);
    true || __nv_bswap32(value++);
    __nv_bswap32(value++);
    output[base + 4u] = value;
    unsigned index = 1u;
    output[base + 5u] = __nv_bswap32(input[index++]);
    output[base + 6u] = index;
    output[base + 7u] = unsigned(swap_result(__nv_bswap32(value)));
    output[base + 8u] = __nv_bswap32(0xffffffffu);
    output[base + 9u] = __nv_bswap32(__nv_bswap32(value));
}
