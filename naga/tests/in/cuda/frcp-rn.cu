__device__ float reciprocal_value(float value) { return __frcp_rn(value); }
__device__ int __frcp_rn(bool value) { return value ? 7 : 9; }
__global__ void reciprocal_round_nearest(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 10u;
    float value = __uint_as_float(input[index]);
    output[base] = __float_as_uint(__frcp_rn(value));
    output[base + 1u] = __float_as_uint(reciprocal_value(value));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(reciprocal_value(__uint_as_float(input[index + unsigned(cursor++)])));
    false && __frcp_rn(float(cursor++));
    true || __frcp_rn(float(cursor++));
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(__frcp_rn(-0.0f));
    output[base + 5u] = __float_as_uint(__frcp_rn(__uint_as_float(0xff800000u)));
    output[base + 6u] = __float_as_uint(reciprocal_value(2u));
    output[base + 7u] = unsigned(__frcp_rn(true));
    output[base + 8u] = __float_as_uint(true ? __frcp_rn(value) : __frcp_rn(float(cursor++)));
    output[base + 9u] = unsigned(cursor);
}
