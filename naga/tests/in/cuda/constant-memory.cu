typedef struct {
    unsigned scale, bias;
} Settings;

__constant__ unsigned addend;
__constant__ unsigned weights[4];
__constant__ Settings settings;

__device__ unsigned pointer_code(unsigned *value) {
    return 31u;
}

__device__ unsigned pointer_code(const unsigned *value) {
    return 37u;
}

__device__ unsigned reference_code(unsigned &value) {
    return 41u;
}

__device__ unsigned reference_code(const unsigned &value) {
    return 43u;
}

__device__ unsigned read_weight(unsigned *values, unsigned index) {
    return values[index];
}

__device__ unsigned read_addend(unsigned &value) {
    return value;
}

template<class Value>
__device__ Value weighted(Value input, unsigned index) {
    return input * Value(settings.scale) + Value(read_weight(weights, index)) + Value(addend);
}

__global__ void constant_memory(unsigned *output, const unsigned *input, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index < count) output[index] = weighted<unsigned>(input[index], index % 4u) + settings.bias
        + pointer_code(weights) + reference_code(addend);
}

__global__ void constant_references(unsigned *output, const unsigned *input, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index >= count) return;
    Settings current = settings;
    const unsigned *view = weights;
    const unsigned &reference = addend;
    output[index] = input[index] + read_weight(weights, (index + 1u) % 4u)
        + read_addend(addend) + current.scale + current.bias
        + pointer_code(view) + reference_code(reference);
}
