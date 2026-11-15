__device__ float fused_value(float first, float second, float third) { return __fmaf_rn(first, second, third); }
__device__ int __fmaf_rn(bool first, bool second, bool third) { return first ? 7 : 9; }
__global__ void fused_round_nearest(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 10u;
    float first = __uint_as_float(input[index * 3u]);
    float second = __uint_as_float(input[index * 3u + 1u]);
    float third = __uint_as_float(input[index * 3u + 2u]);
    output[base] = __float_as_uint(__fmaf_rn(first, second, third));
    output[base + 1u] = __float_as_uint(fused_value(first, second, third));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(fused_value(__uint_as_float(input[index * 3u + unsigned(cursor++)]), __uint_as_float(input[index * 3u + unsigned(cursor++)]), __uint_as_float(input[index * 3u + unsigned(cursor++)])));
    false && __fmaf_rn(float(cursor++), first, second);
    true || __fmaf_rn(first, float(cursor++), second);
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(__fmaf_rn(-0.0f, 1.0f, -0.0f));
    output[base + 5u] = __float_as_uint(__fmaf_rn(-0.0f, 1.0f, 0.0f));
    output[base + 6u] = __float_as_uint(fused_value(2, 3u, 4));
    output[base + 7u] = unsigned(__fmaf_rn(true, false, true));
    output[base + 8u] = __float_as_uint(true ? __fmaf_rn(first, second, third) : __fmaf_rn(float(cursor++), first, second));
    output[base + 9u] = unsigned(cursor);
}
