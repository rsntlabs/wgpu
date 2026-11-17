__device__ float rounded_even(float value) { return rintf(value); }
__device__ int rintf(bool value) { return value ? 7 : 9; }
__global__ void nearest_even(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 14u;
    float value = __uint_as_float(input[index]);
    output[base] = __float_as_uint(rintf(value));
    output[base + 1u] = __float_as_uint(rounded_even(value));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(rounded_even(__uint_as_float(input[index + unsigned(cursor++)])));
    false && rintf(float(cursor++));
    true || rintf(float(cursor++));
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(rintf(-0.5f));
    output[base + 5u] = __float_as_uint(rintf(0.5f));
    output[base + 6u] = __float_as_uint(rintf(2.5f));
    output[base + 7u] = __float_as_uint(roundf(2.5f));
    output[base + 8u] = __float_as_uint(rintf(-2.5f));
    output[base + 9u] = __float_as_uint(roundf(-2.5f));
    output[base + 10u] = __float_as_uint(rounded_even(3u));
    output[base + 11u] = unsigned(rintf(true));
    output[base + 12u] = __float_as_uint(true ? rintf(rintf(value)) : rintf(float(cursor++)));
    output[base + 13u] = unsigned(cursor);
}
