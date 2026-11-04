#include <cstddef>

__device__ unsigned kind(long value) { return 3u; }
__device__ unsigned kind(long long value) { return 5u; }

template<class Value>
__device__ Value identity(Value value) { return value; }

extern "C" __global__ void long_types(const long *input, unsigned long *output,
                                     std::size_t count, long bias) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;

    long value = identity(input[index] + bias);
    long long wide = static_cast<long long>(value);
    unsigned tags = kind(value) * 10u + kind(wide);
    output[index] = static_cast<unsigned long>(value + 1L) + tags;
}
