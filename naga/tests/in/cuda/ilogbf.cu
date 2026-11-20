__device__ float counted(float value, unsigned &counter) { ++counter; return value; }
__device__ unsigned kind(float value) { return 1u; }
__device__ unsigned kind(int value) { return 2u; }
__global__ void exponent_values(const unsigned *input, unsigned *output, unsigned count) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= count) return;
    unsigned base = 4u + index * 4u;
    float value = __uint_as_float(input[index]);
    unsigned counter = 0u;
    output[base] = unsigned(ilogbf(value));
    output[base + 1u] = unsigned(__nv_ilogbf(counted(value, counter)));
    output[base + 2u] = counter;
    output[base + 3u] = kind(ilogbf(value));
}
