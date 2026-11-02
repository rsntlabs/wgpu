template<typename Value> __device__ Value copied(Value value) {
    return value;
}

template<typename Value> __global__ void copy_typed(Value *output, const Value *input, unsigned count) {
    unsigned index = blockIdx.x * blockDim.x + threadIdx.x;
    if (index < count) output[index] = copied(input[index]);
}

template __global__ void copy_typed<unsigned>(unsigned *, const unsigned *, unsigned);
template __global__ void copy_typed<float>(float *, const float *, unsigned);
