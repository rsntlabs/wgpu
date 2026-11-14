using Word = long long;

__device__ int first_set_word(const Word value) { return __ffsll(value); }

extern "C" __global__ void first_set_positions(int *output, const Word *input, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;
    output[index + 4u] = first_set_word(input[index]);
}
