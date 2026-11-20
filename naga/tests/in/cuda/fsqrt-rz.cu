__device__ float truncated_sqrt(float value) { return __fsqrt_rz(value); }
__device__ int __fsqrt_rz(bool value) { return value ? 7 : 9; }
__global__ void sqrt_round_zero(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 14u;
    float value = __uint_as_float(input[index]);
    output[base] = __float_as_uint(__fsqrt_rz(value));
    output[base + 1u] = __float_as_uint(truncated_sqrt(value));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(truncated_sqrt(__uint_as_float(input[index + unsigned(cursor++)])));
    false && __fsqrt_rz(float(cursor++));
    true || __fsqrt_rz(float(cursor++));
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(__fsqrt_rz(-0.0f));
    output[base + 5u] = __float_as_uint(__fsqrt_rz(__uint_as_float(0x7f800000u)));
    output[base + 6u] = __float_as_uint(truncated_sqrt(4u));
    output[base + 7u] = unsigned(__fsqrt_rz(true));
    output[base + 8u] = __float_as_uint(true ? __fsqrt_rz(value) : __fsqrt_rz(float(cursor++)));
    output[base + 9u] = __float_as_uint(__fsqrt_rn(value));
    int directed_cursor = 0;
    output[base + 10u] = __float_as_uint(__fsqrt_rd(__uint_as_float(input[index + unsigned(directed_cursor++)])));
    output[base + 11u] = unsigned(directed_cursor);
    directed_cursor = 0;
    output[base + 12u] = __float_as_uint(__fsqrt_ru(__uint_as_float(input[index + unsigned(directed_cursor++)])));
    output[base + 13u] = unsigned(directed_cursor);
}
