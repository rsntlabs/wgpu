__device__ float subtract_value(float first, float second) { return __fsub_rz(first, second); }
__device__ int __fsub_rz(bool first, bool second) { return first ? 7 : 9; }
__global__ void subtract_round_zero(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 10u;
    float first = __uint_as_float(input[index * 2u]);
    float second = __uint_as_float(input[index * 2u + 1u]);
    output[base] = __float_as_uint(__fsub_rz(first, second));
    output[base + 1u] = __float_as_uint(subtract_value(first, second));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(subtract_value(__uint_as_float(input[index * 2u + unsigned(cursor++)]), __uint_as_float(input[index * 2u + unsigned(cursor++)])));
    false && __fsub_rz(float(cursor++), first);
    true || __fsub_rz(first, float(cursor++));
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(__fsub_rz(-0.0f, -0.0f));
    output[base + 5u] = __float_as_uint(__fsub_rz(-0.0f, 0.0f));
    output[base + 6u] = __float_as_uint(subtract_value(1, 2u));
    output[base + 7u] = unsigned(__fsub_rz(true, false));
    output[base + 8u] = __float_as_uint(true ? __fsub_rz(first, second) : __fsub_rz(float(cursor++), first));
    output[base + 9u] = __float_as_uint(__fsub_rn(first, second));
}
