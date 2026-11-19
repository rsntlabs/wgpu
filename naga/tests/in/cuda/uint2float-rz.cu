__device__ unsigned forward(unsigned value) { return value; }
__device__ unsigned counted(const unsigned &value, unsigned &counter) {
    ++counter;
    return value;
}
__global__ void convert_values(const unsigned *input, unsigned *output, unsigned count) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= count) return;
    unsigned base = 4u + index * 8u;
    unsigned value = input[index];
    unsigned counter = 0u;
    output[base] = __float_as_uint(__uint2float_rz(value));
    output[base + 1u] = __float_as_uint(__uint2float_rz(forward(value)));
    output[base + 2u] = __float_as_uint(__uint2float_rz(counted(value, counter)));
    output[base + 3u] = counter;
    output[base + 4u] = (index & 1u) ? __float_as_uint(__uint2float_rz(counted(value, counter))) : __float_as_uint(__uint2float_rz(counted(value, counter)));
    output[base + 5u] = counter;
    output[base + 6u] = __float_as_uint(__uint2float_rz(-1));
    output[base + 7u] = __float_as_uint(__uint2float_rz(3.5f));
}
