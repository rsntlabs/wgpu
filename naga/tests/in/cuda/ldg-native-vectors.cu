__device__ int2 read_i2(const int2 *pointer) { return __ldg(pointer); }
__device__ unsigned kind(int2 value) { return 1u; }
__device__ uint2 read_u2(const uint2 *pointer) { return __ldg(pointer); }
__device__ unsigned kind(uint2 value) { return 2u; }
__device__ int4 read_i4(const int4 *pointer) { return __ldg(pointer); }
__device__ unsigned kind(int4 value) { return 3u; }
__device__ uint4 read_u4(const uint4 *pointer) { return __ldg(pointer); }
__device__ unsigned kind(uint4 value) { return 4u; }
__device__ float4 read_f4(const float4 *pointer) { return __ldg(pointer); }
__device__ unsigned kind(float4 value) { return 5u; }
__global__ void load_vectors(const int2 *i2, const uint2 *u2, const int4 *i4, const uint4 *u4, const float4 *f4, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 32u) return;
    unsigned base = 4u + index * 44u;
    unsigned cursor_i2 = index;
    int2 direct_i2 = __ldg(i2 + cursor_i2++);
    const int2 *alias_i2 = i2 + (31u - index);
    int2 reverse_i2 = read_i2(alias_i2);
    output[base + 0u] = unsigned(direct_i2.x);
    output[base + 1u] = unsigned(direct_i2.y);
    output[base + 2u] = unsigned(reverse_i2.x);
    output[base + 3u] = unsigned(reverse_i2.y);
    output[base + 4u] = kind(direct_i2);
    output[base + 5u] = cursor_i2;
    unsigned cursor_u2 = index;
    uint2 direct_u2 = __ldg(u2 + cursor_u2++);
    const uint2 *alias_u2 = u2 + (31u - index);
    uint2 reverse_u2 = read_u2(alias_u2);
    output[base + 6u] = unsigned(direct_u2.x);
    output[base + 7u] = unsigned(direct_u2.y);
    output[base + 8u] = unsigned(reverse_u2.x);
    output[base + 9u] = unsigned(reverse_u2.y);
    output[base + 10u] = kind(direct_u2);
    output[base + 11u] = cursor_u2;
    unsigned cursor_i4 = index;
    int4 direct_i4 = __ldg(i4 + cursor_i4++);
    const int4 *alias_i4 = i4 + (31u - index);
    int4 reverse_i4 = read_i4(alias_i4);
    output[base + 12u] = unsigned(direct_i4.x);
    output[base + 13u] = unsigned(direct_i4.y);
    output[base + 14u] = unsigned(direct_i4.z);
    output[base + 15u] = unsigned(direct_i4.w);
    output[base + 16u] = unsigned(reverse_i4.x);
    output[base + 17u] = unsigned(reverse_i4.y);
    output[base + 18u] = unsigned(reverse_i4.z);
    output[base + 19u] = unsigned(reverse_i4.w);
    output[base + 20u] = kind(direct_i4);
    output[base + 21u] = cursor_i4;
    unsigned cursor_u4 = index;
    uint4 direct_u4 = __ldg(u4 + cursor_u4++);
    const uint4 *alias_u4 = u4 + (31u - index);
    uint4 reverse_u4 = read_u4(alias_u4);
    output[base + 22u] = unsigned(direct_u4.x);
    output[base + 23u] = unsigned(direct_u4.y);
    output[base + 24u] = unsigned(direct_u4.z);
    output[base + 25u] = unsigned(direct_u4.w);
    output[base + 26u] = unsigned(reverse_u4.x);
    output[base + 27u] = unsigned(reverse_u4.y);
    output[base + 28u] = unsigned(reverse_u4.z);
    output[base + 29u] = unsigned(reverse_u4.w);
    output[base + 30u] = kind(direct_u4);
    output[base + 31u] = cursor_u4;
    unsigned cursor_f4 = index;
    float4 direct_f4 = __ldg(f4 + cursor_f4++);
    const float4 *alias_f4 = f4 + (31u - index);
    float4 reverse_f4 = read_f4(alias_f4);
    output[base + 32u] = __float_as_uint(direct_f4.x);
    output[base + 33u] = __float_as_uint(direct_f4.y);
    output[base + 34u] = __float_as_uint(direct_f4.z);
    output[base + 35u] = __float_as_uint(direct_f4.w);
    output[base + 36u] = __float_as_uint(reverse_f4.x);
    output[base + 37u] = __float_as_uint(reverse_f4.y);
    output[base + 38u] = __float_as_uint(reverse_f4.z);
    output[base + 39u] = __float_as_uint(reverse_f4.w);
    output[base + 40u] = kind(direct_f4);
    output[base + 41u] = cursor_f4;
    output[base + 42u] = unsigned(direct_i2.x < 0);
    output[base + 43u] = unsigned(direct_i4.w < 0);
}
