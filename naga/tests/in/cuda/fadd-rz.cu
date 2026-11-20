__device__ float truncate_value(float first, float second) { return __fadd_rz(first, second); }
__device__ int __fadd_rz(bool first, bool second) { return first ? 7 : 9; }
__global__ void add_round_zero(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 18u;
    float first = __uint_as_float(input[index * 2u]);
    float second = __uint_as_float(input[index * 2u + 1u]);
    output[base] = __float_as_uint(__fadd_rz(first, second));
    output[base + 1u] = __float_as_uint(truncate_value(first, second));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(truncate_value(__uint_as_float(input[index * 2u + unsigned(cursor++)]), __uint_as_float(input[index * 2u + unsigned(cursor++)])));
    false && __fadd_rz(float(cursor++), first);
    true || __fadd_rz(first, float(cursor++));
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(__fadd_rz(-0.0f, -0.0f));
    output[base + 5u] = __float_as_uint(__fadd_rz(-0.0f, 0.0f));
    output[base + 6u] = __float_as_uint(truncate_value(1, 2u));
    output[base + 7u] = unsigned(__fadd_rz(true, false));
    output[base + 8u] = __float_as_uint(true ? __fadd_rz(first, second) : __fadd_rz(float(cursor++), first));
    output[base + 9u] = __float_as_uint(__fadd_rn(first, second));
    int directed_cursor = 0;
    output[base + 10u] = __float_as_uint(__fadd_rd(__uint_as_float(input[index * 2u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 2u + unsigned(directed_cursor++)])));
    output[base + 11u] = unsigned(directed_cursor);
    directed_cursor = 0;
    output[base + 12u] = __float_as_uint(__fadd_ru(__uint_as_float(input[index * 2u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 2u + unsigned(directed_cursor++)])));
    output[base + 13u] = unsigned(directed_cursor);
    directed_cursor = 0;
    output[base + 14u] = __float_as_uint(__fsub_rd(__uint_as_float(input[index * 2u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 2u + unsigned(directed_cursor++)])));
    output[base + 15u] = unsigned(directed_cursor);
    directed_cursor = 0;
    output[base + 16u] = __float_as_uint(__fsub_ru(__uint_as_float(input[index * 2u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 2u + unsigned(directed_cursor++)])));
    output[base + 17u] = unsigned(directed_cursor);
}
