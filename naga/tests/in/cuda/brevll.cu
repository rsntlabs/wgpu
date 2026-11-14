using Word = unsigned long long;

__device__ Word reverse_word(const Word value) { return __brevll(value); }

extern "C" __global__ void reverse_words(Word *output, const Word *input, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;
    output[index + 4u] = reverse_word(input[index]);
}
