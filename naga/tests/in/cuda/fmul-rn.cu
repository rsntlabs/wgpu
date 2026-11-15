__device__ float product_value(float first, float second) { return __fmul_rn(first, second); }
__device__ int __fmul_rn(bool first, bool second) { return first ? 7 : 9; }
__global__ void multiply_round_nearest(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 10u;
    float first = __uint_as_float(input[index * 2u]);
    float second = __uint_as_float(input[index * 2u + 1u]);
    output[base] = __float_as_uint(__fmul_rn(first, second));
    output[base + 1u] = __float_as_uint(product_value(first, second));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(product_value(__uint_as_float(input[index * 2u + unsigned(cursor++)]), __uint_as_float(input[index * 2u + unsigned(cursor++)])));
    false && __fmul_rn(float(cursor++), first);
    true || __fmul_rn(first, float(cursor++));
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(__fmul_rn(-0.0f, -0.0f));
    output[base + 5u] = __float_as_uint(__fmul_rn(-0.0f, 0.0f));
    output[base + 6u] = __float_as_uint(product_value(2, 3u));
    output[base + 7u] = unsigned(__fmul_rn(true, false));
    output[base + 8u] = __float_as_uint(__fmul_rn(second, first));
    output[base + 9u] = __float_as_uint(__fmul_rn(__uint_as_float(0x3f800001u), __uint_as_float(0x3f7ffffeu)) - 1.0f);
}
