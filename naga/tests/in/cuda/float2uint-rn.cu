__device__ float forward(float value) { return value; }
__device__ float counted(const float &value, unsigned &counter) {
    ++counter;
    return value;
}
__device__ unsigned __float2uint_rn(const int &value, int extra) { return value + extra; }
__global__ void convert_values(const unsigned *input, unsigned *output, unsigned count) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= count) return;
    unsigned base = 4u + index * 8u;
    float value = __uint_as_float(input[index]);
    unsigned counter = 0u;
    output[base] = __float2uint_rn(value);
    output[base + 1u] = __float2uint_rn(forward(value));
    output[base + 2u] = __float2uint_rn(counted(value, counter));
    output[base + 3u] = int(counter);
    output[base + 4u] = (index & 1u) ? __float2uint_rn(counted(value, counter)) : __float2uint_rn(counted(value, counter));
    output[base + 5u] = int(counter);
    output[base + 6u] = __float2uint_rn(16777217u);
    int local = 7;
    output[base + 7u] = __float2uint_rn(local, 3);
}
