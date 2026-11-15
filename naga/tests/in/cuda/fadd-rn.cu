__device__ float add_value(float first, float second) { return __fadd_rn(first, second); }
__device__ int __fadd_rn(bool first, bool second) { return first ? 7 : 9; }
__global__ void add_round_nearest(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 8u;
    float first = __uint_as_float(input[index * 2u]);
    float second = __uint_as_float(input[index * 2u + 1u]);
    output[base] = __float_as_uint(__fadd_rn(first, second));
    output[base + 1u] = __float_as_uint(add_value(first, second));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(add_value(__uint_as_float(input[index * 2u + unsigned(cursor++)]), __uint_as_float(input[index * 2u + unsigned(cursor++)])));
    false && __fadd_rn(float(cursor++), first);
    true || __fadd_rn(first, float(cursor++));
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(__fadd_rn(-0.0f, -0.0f));
    output[base + 5u] = __float_as_uint(__fadd_rn(-0.0f, 0.0f));
    output[base + 6u] = __float_as_uint(add_value(1, 2u));
    output[base + 7u] = unsigned(__fadd_rn(true, false));
}
