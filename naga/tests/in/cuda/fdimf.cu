__device__ float counted(float value, unsigned &counter) { ++counter; return value; }
__device__ unsigned kind(float value) { return 1u; }
__device__ unsigned kind(int value) { return 2u; }
__global__ void positive_differences(const uint2 *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 26u) return;
    unsigned base = 4u + index * 4u;
    float x = __uint_as_float(input[index].x);
    float y = __uint_as_float(input[index].y);
    unsigned counter = 0u;
    output[base] = __float_as_uint(fdimf(x, y));
    output[base + 1u] = __float_as_uint(__nv_fdimf(counted(x, counter), counted(y, counter)));
    output[base + 2u] = counter;
    output[base + 3u] = kind(fdimf(x, y));
}
