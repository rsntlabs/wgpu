using Word = long long;

__device__ int leading_word(const Word value) { return __clzll(value); }

extern "C" __global__ void leading_zero_counts(int *output, const Word *input, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;
    output[index + 4u] = leading_word(input[index]);
}
