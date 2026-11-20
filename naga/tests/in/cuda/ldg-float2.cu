__device__ float2 read_pair(const float2 *pointer) { return __ldg(pointer); }
__device__ unsigned kind(float2 value) { return 2u; }
__device__ unsigned kind(float value) { return 1u; }
__global__ void load_pairs(const float2 *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 32u) return;
    unsigned base = 4u + index * 8u;
    const float2 *alias = input;
    unsigned cursor = index;
    float2 direct = __ldg(input + cursor++);
    float2 wrapped = read_pair(alias + index);
    alias = input + (31u - index);
    float2 reversed = read_pair(alias);
    output[base] = __float_as_uint(direct.x);
    output[base + 1u] = __float_as_uint(direct.y);
    output[base + 2u] = __float_as_uint(wrapped.x);
    output[base + 3u] = __float_as_uint(wrapped.y);
    output[base + 4u] = __float_as_uint(reversed.x);
    output[base + 5u] = __float_as_uint(reversed.y);
    output[base + 6u] = cursor;
    output[base + 7u] = kind(direct);
}
