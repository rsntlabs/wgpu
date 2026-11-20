__device__ float counted(float value, unsigned &counter) { ++counter; return value; }
__device__ int counted(int value, unsigned &counter) { ++counter; return value; }
__device__ unsigned kind(float value) { return 1u; }
__device__ unsigned kind(int value) { return 2u; }
__global__ void scale_values(const uint2 *input, unsigned *output, unsigned count) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= count) return;
    unsigned base = 4u + index * 8u;
    float value = __uint_as_float(input[index].x);
    int power = int(input[index].y);
    unsigned counter = 0u;
    output[base] = __float_as_uint(ldexpf(value, power));
    output[base + 1u] = __float_as_uint(__nv_ldexpf(counted(value, counter), counted(power, counter)));
    output[base + 2u] = counter;
    output[base + 3u] = kind(ldexpf(value, power));
    output[base + 4u] = __float_as_uint(scalbnf(value, power));
    output[base + 5u] = __float_as_uint(__nv_scalbnf(counted(value, counter), counted(power, counter)));
    output[base + 6u] = counter;
    output[base + 7u] = kind(scalbnf(value, power));
}
