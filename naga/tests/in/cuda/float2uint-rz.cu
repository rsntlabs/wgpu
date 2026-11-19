__device__ float forward(float value) { return value; }
__device__ float counted(const float &value, unsigned &counter) {
    ++counter;
    return value;
}
__device__ unsigned __float2uint_rz(const int &value, int extra) { return unsigned(value + extra); }
__global__ void convert_values(const unsigned *input, unsigned *output, unsigned count) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= count) return;
    unsigned base = 4u + index * 10u;
    float value = __uint_as_float(input[index]);
    unsigned counter = 0u;
    output[base] = __float2uint_rz(value);
    output[base + 1u] = __float2uint_rz(forward(value));
    output[base + 2u] = __float2uint_rz(counted(value, counter));
    output[base + 3u] = counter;
    output[base + 4u] = (index & 1u) ? __float2uint_rz(counted(value, counter)) : __float2uint_rz(counted(value, counter));
    output[base + 5u] = counter;
    output[base + 6u] = __float2uint_rz(16777217u);
    output[base + 7u] = __float2uint_rz(2147483649u);
    output[base + 8u] = __float2uint_rz(true);
    int local = 7;
    output[base + 9u] = __float2uint_rz(local, 3);
}
