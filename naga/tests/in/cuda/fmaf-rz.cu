__device__ float2 counted_pair(float2 value, int &counter) { ++counter; return value; }
__device__ float truncate_fused(float first, float second, float third) { return __fmaf_rz(first, second, third); }
__device__ int __fmaf_rz(bool first, bool second, bool third) { return first ? 7 : 9; }
__global__ void fused_round_zero(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 4096u) return;
    unsigned base = 4u + index * 34u;
    float first = __uint_as_float(input[index * 3u]);
    float second = __uint_as_float(input[index * 3u + 1u]);
    float third = __uint_as_float(input[index * 3u + 2u]);
    output[base] = __float_as_uint(__fmaf_rz(first, second, third));
    output[base + 1u] = __float_as_uint(truncate_fused(first, second, third));
    int cursor = 0;
    output[base + 2u] = __float_as_uint(truncate_fused(__uint_as_float(input[index * 3u + unsigned(cursor++)]), __uint_as_float(input[index * 3u + unsigned(cursor++)]), __uint_as_float(input[index * 3u + unsigned(cursor++)])));
    false && __fmaf_rz(float(cursor++), first, second);
    true || __fmaf_rz(first, float(cursor++), second);
    output[base + 3u] = unsigned(cursor);
    output[base + 4u] = __float_as_uint(__fmaf_rz(-0.0f, 1.0f, -0.0f));
    output[base + 5u] = __float_as_uint(__fmaf_rz(-0.0f, 1.0f, 0.0f));
    output[base + 6u] = __float_as_uint(truncate_fused(2, 3u, 4));
    output[base + 7u] = unsigned(__fmaf_rz(true, false, true));
    output[base + 8u] = __float_as_uint(true ? __fmaf_rz(first, second, third) : __fmaf_rz(float(cursor++), first, second));
    output[base + 9u] = __float_as_uint(__fmaf_rn(first, second, third));
    int directed_cursor = 0;
    output[base + 10u] = __float_as_uint(__fmaf_rd(__uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)])));
    output[base + 11u] = unsigned(directed_cursor);
    directed_cursor = 0;
    output[base + 12u] = __float_as_uint(__fmaf_ru(__uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)])));
    output[base + 13u] = unsigned(directed_cursor);

    directed_cursor = 0;
    output[base + 14u] = __float_as_uint(__fmaf_ieee_rn(__uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)])));
    output[base + 15u] = unsigned(directed_cursor);
    directed_cursor = 0;
    output[base + 16u] = __float_as_uint(__fmaf_ieee_rz(__uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)])));
    output[base + 17u] = unsigned(directed_cursor);
    directed_cursor = 0;
    output[base + 18u] = __float_as_uint(__fmaf_ieee_rd(__uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)])));
    output[base + 19u] = unsigned(directed_cursor);
    directed_cursor = 0;
    output[base + 20u] = __float_as_uint(__fmaf_ieee_ru(__uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)]), __uint_as_float(input[index * 3u + unsigned(directed_cursor++)])));
    output[base + 21u] = unsigned(directed_cursor);
    unsigned other = index ^ 1u;
    float2 pair_first = make_float2(first, __uint_as_float(input[other * 3u]));
    float2 pair_second = make_float2(second, __uint_as_float(input[other * 3u + 1u]));
    float2 pair_third = make_float2(third, __uint_as_float(input[other * 3u + 2u]));
    directed_cursor = 0;
    float2 pair_rn = __ffma2_rn(counted_pair(pair_first, directed_cursor), counted_pair(pair_second, directed_cursor), counted_pair(pair_third, directed_cursor));
    output[base + 22u] = __float_as_uint(pair_rn.x);
    output[base + 23u] = __float_as_uint(pair_rn.y);
    output[base + 24u] = unsigned(directed_cursor);
    directed_cursor = 0;
    float2 pair_rz = __ffma2_rz(counted_pair(pair_first, directed_cursor), counted_pair(pair_second, directed_cursor), counted_pair(pair_third, directed_cursor));
    output[base + 25u] = __float_as_uint(pair_rz.x);
    output[base + 26u] = __float_as_uint(pair_rz.y);
    output[base + 27u] = unsigned(directed_cursor);
    directed_cursor = 0;
    float2 pair_rd = __ffma2_rd(counted_pair(pair_first, directed_cursor), counted_pair(pair_second, directed_cursor), counted_pair(pair_third, directed_cursor));
    output[base + 28u] = __float_as_uint(pair_rd.x);
    output[base + 29u] = __float_as_uint(pair_rd.y);
    output[base + 30u] = unsigned(directed_cursor);
    directed_cursor = 0;
    float2 pair_ru = __ffma2_ru(counted_pair(pair_first, directed_cursor), counted_pair(pair_second, directed_cursor), counted_pair(pair_third, directed_cursor));
    output[base + 31u] = __float_as_uint(pair_ru.x);
    output[base + 32u] = __float_as_uint(pair_ru.y);
    output[base + 33u] = unsigned(directed_cursor);
}
