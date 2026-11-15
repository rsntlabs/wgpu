__device__ float truncated_quotient(float first, float second) { return __fdiv_rz(first, second); }
__device__ int __fdiv_rz(bool first, bool second) { return first ? 7 : 9; }
__global__ void divide_round_zero(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 10u;
    float first = __uint_as_float(input[index * 2u]);
    float second = __uint_as_float(input[index * 2u + 1u]);
    output[base] = __float_as_uint(__fdiv_rz(first, second));
    output[base + 1u] = __float_as_uint(truncated_quotient(first, second));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(truncated_quotient(__uint_as_float(input[index * 2u + unsigned(cursor++)]), __uint_as_float(input[index * 2u + unsigned(cursor++)])));
    false && __fdiv_rz(float(cursor++), first);
    true || __fdiv_rz(first, float(cursor++));
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(__fdiv_rz(-0.0f, -0.0f));
    output[base + 5u] = __float_as_uint(__fdiv_rz(-0.0f, 0.0f));
    output[base + 6u] = __float_as_uint(truncated_quotient(2, 3u));
    output[base + 7u] = unsigned(__fdiv_rz(true, false));
    output[base + 8u] = __float_as_uint(true ? __fdiv_rz(first, second) : __fdiv_rz(float(cursor++), first));
    output[base + 9u] = __float_as_uint(__fdiv_rn(first, second));
}
