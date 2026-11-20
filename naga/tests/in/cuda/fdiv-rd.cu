__device__ float counted(float value, unsigned &counter) { ++counter; return value; }
__device__ unsigned kind(float value) { return 1u; }
__device__ unsigned kind(int value) { return 2u; }
__global__ void divide_values(const uint2 *input, unsigned *output, unsigned count) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= count) return;
    unsigned base = 4u + index * 16u;
    float x = __uint_as_float(input[index].x);
    float y = __uint_as_float(input[index].y);
    unsigned counter = 0u;
    output[base] = __float_as_uint(__fdiv_rd(x, y));
    output[base + 1u] = __float_as_uint(__fdiv_rd(counted(x, counter), counted(y, counter)));
    output[base + 2u] = counter;
    output[base + 3u] = __float_as_uint(__frcp_rd(y));
    output[base + 4u] = __float_as_uint(__frcp_rd(counted(y, counter)));
    output[base + 5u] = counter;
    output[base + 6u] = kind(__fdiv_rd(x, y));
    output[base + 7u] = kind(__frcp_rd(y));
    output[base + 8u] = __float_as_uint(__fdiv_ru(x, y));
    output[base + 9u] = __float_as_uint(__fdiv_ru(counted(x, counter), counted(y, counter)));
    output[base + 10u] = counter;
    output[base + 11u] = __float_as_uint(__frcp_ru(y));
    output[base + 12u] = __float_as_uint(__frcp_ru(counted(y, counter)));
    output[base + 13u] = counter;
    output[base + 14u] = kind(__fdiv_ru(x, y));
    output[base + 15u] = kind(__frcp_ru(y));
}
