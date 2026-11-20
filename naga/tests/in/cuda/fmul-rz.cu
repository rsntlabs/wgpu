__device__ float2 counted_pair(float2 value, int &counter) { ++counter; return value; }
__device__ float truncate_product(float first, float second) { return __fmul_rz(first, second); }
__device__ int __fmul_rz(bool first, bool second) { return first ? 7 : 9; }
__global__ void multiply_round_zero(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 26u;
    float first = __uint_as_float(input[index * 2u]);
    float second = __uint_as_float(input[index * 2u + 1u]);
    output[base] = __float_as_uint(__fmul_rz(first, second));
    output[base + 1u] = __float_as_uint(truncate_product(first, second));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(truncate_product(__uint_as_float(input[index * 2u + unsigned(cursor++)]), __uint_as_float(input[index * 2u + unsigned(cursor++)])));
    false && __fmul_rz(float(cursor++), first);
    true || __fmul_rz(first, float(cursor++));
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(__fmul_rz(-0.0f, -0.0f));
    output[base + 5u] = __float_as_uint(__fmul_rz(-0.0f, 0.0f));
    output[base + 6u] = __float_as_uint(truncate_product(2, 3u));
    output[base + 7u] = unsigned(__fmul_rz(true, false));
    output[base + 8u] = __float_as_uint(__fmul_rz(second, first));
    output[base + 9u] = __float_as_uint(__fmul_rn(first, second));
    int directed_cursor = 0;
    output[base + 10u] = __float_as_uint(__fmul_rd(__uint_as_float(input[index * 2u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 2u + unsigned(directed_cursor++)])));
    output[base + 11u] = unsigned(directed_cursor);
    directed_cursor = 0;
    output[base + 12u] = __float_as_uint(__fmul_ru(__uint_as_float(input[index * 2u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 2u + unsigned(directed_cursor++)])));
    output[base + 13u] = unsigned(directed_cursor);
    unsigned other = index ^ 1u;
    float2 pair_first = make_float2(first, __uint_as_float(input[other * 2u]));
    float2 pair_second = make_float2(second, __uint_as_float(input[other * 2u + 1u]));
    directed_cursor = 0;
    float2 pair_rn = __fmul2_rn(counted_pair(pair_first, directed_cursor), counted_pair(pair_second, directed_cursor));
    output[base + 14u] = __float_as_uint(pair_rn.x);
    output[base + 15u] = __float_as_uint(pair_rn.y);
    output[base + 16u] = unsigned(directed_cursor);
    directed_cursor = 0;
    float2 pair_rz = __fmul2_rz(counted_pair(pair_first, directed_cursor), counted_pair(pair_second, directed_cursor));
    output[base + 17u] = __float_as_uint(pair_rz.x);
    output[base + 18u] = __float_as_uint(pair_rz.y);
    output[base + 19u] = unsigned(directed_cursor);
    directed_cursor = 0;
    float2 pair_rd = __fmul2_rd(counted_pair(pair_first, directed_cursor), counted_pair(pair_second, directed_cursor));
    output[base + 20u] = __float_as_uint(pair_rd.x);
    output[base + 21u] = __float_as_uint(pair_rd.y);
    output[base + 22u] = unsigned(directed_cursor);
    directed_cursor = 0;
    float2 pair_ru = __fmul2_ru(counted_pair(pair_first, directed_cursor), counted_pair(pair_second, directed_cursor));
    output[base + 23u] = __float_as_uint(pair_ru.x);
    output[base + 24u] = __float_as_uint(pair_ru.y);
    output[base + 25u] = unsigned(directed_cursor);
}
