__device__ float truncated(float value) { return truncf(value); }
__device__ int truncf(bool value) { return value ? 7 : 9; }
__global__ void truncations(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 12u;
    float value = __uint_as_float(input[index]);
    output[base] = __float_as_uint(truncf(value));
    output[base + 1u] = __float_as_uint(truncated(value));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(truncated(__uint_as_float(input[index + unsigned(cursor++)])));
    false && truncf(float(cursor++));
    true || truncf(float(cursor++));
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(truncf(-0.0f));
    output[base + 5u] = __float_as_uint(truncf(-0.25f));
    output[base + 6u] = __float_as_uint(truncf(-1.75f));
    output[base + 7u] = __float_as_uint(truncated(3u));
    output[base + 8u] = unsigned(truncf(true));
    output[base + 9u] = __float_as_uint(true ? truncf(value) : truncf(float(cursor++)));
    output[base + 10u] = __float_as_uint(truncf(truncf(value)));
    output[base + 11u] = unsigned(cursor);
}
