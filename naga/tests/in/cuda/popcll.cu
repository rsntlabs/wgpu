using Word = unsigned long long;

__device__ int count_word(const Word value) { return __popcll(value); }

extern "C" __global__ void popcounts(int *output, const Word *input) {
    unsigned index = threadIdx.x;
    output[index] = count_word(input[index]);
}
