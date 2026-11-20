__device__ float quotient_value(float first, float second) { return __fdiv_rn(first, second); }
__device__ int __fdiv_rn(bool first, bool second) { return first ? 7 : 9; }
__global__ void divide_round_nearest(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 16u;
    float first = __uint_as_float(input[index * 2u]);
    float second = __uint_as_float(input[index * 2u + 1u]);
    output[base] = __float_as_uint(__fdiv_rn(first, second));
    output[base + 1u] = __float_as_uint(quotient_value(first, second));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(quotient_value(__uint_as_float(input[index * 2u + unsigned(cursor++)]), __uint_as_float(input[index * 2u + unsigned(cursor++)])));
    false && __fdiv_rn(float(cursor++), first);
    true || __fdiv_rn(first, float(cursor++));
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(__fdiv_rn(-0.0f, -0.0f));
    output[base + 5u] = __float_as_uint(__fdiv_rn(-0.0f, 0.0f));
    output[base + 6u] = __float_as_uint(quotient_value(2, 3u));
    output[base + 7u] = unsigned(__fdiv_rn(true, false));
    output[base + 8u] = __float_as_uint(__fdiv_rn(second, first));
    output[base + 9u] = __float_as_uint(quotient_value(1.0f, 3.0f));
    output[base + 10u] = __float_as_uint(__fdividef(first, second));
    int fast_cursor = 0;
    output[base + 11u] = __float_as_uint(__fdividef(__uint_as_float(input[index * 2u + unsigned(fast_cursor++)]), __uint_as_float(input[index * 2u + unsigned(fast_cursor++)])));
    output[base + 12u] = unsigned(fast_cursor);
    output[base + 13u] = __float_as_uint(__fdividef(__uint_as_float(0x7e800000u), __uint_as_float(0x7e7fffffu)));
    output[base + 14u] = __float_as_uint(__fdividef(__uint_as_float(0x7e800000u), __uint_as_float(0x7e800000u)));
    output[base + 15u] = __float_as_uint(__fdividef(__uint_as_float(0x7e800000u), __uint_as_float(0x7e800001u)));
}
