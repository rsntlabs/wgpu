__device__ int forward(int value) { return value; }
__device__ int counted(const int &value, unsigned &counter) {
    ++counter;
    return value;
}
__global__ void convert_values(const int *input, unsigned *output, unsigned count) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= count) return;
    unsigned base = 4u + index * 9u;
    int value = input[index];
    unsigned counter = 0u;
    output[base] = __float_as_uint(__int2float_rn(value));
    output[base + 1u] = __float_as_uint(__int2float_rn(forward(value)));
    output[base + 2u] = __float_as_uint(__int2float_rn(counted(value, counter)));
    output[base + 3u] = counter;
    output[base + 4u] = (index & 1u) ? __float_as_uint(__int2float_rn(counted(value, counter))) : __float_as_uint(__int2float_rn(counted(value, counter)));
    output[base + 5u] = counter;
    output[base + 6u] = __float_as_uint(__int2float_rn(0xffffffffu));
    output[base + 7u] = __float_as_uint(__int2float_rn(-3.5f));
    output[base + 8u] = __float_as_uint(__int2float_rz(value));
}
