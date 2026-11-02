using Null = decltype(nullptr);

template<class Value> __device__ Value copied(Value value) {
    return value;
}

__device__ Null synchronize(Null value) {
    __syncthreads();
    return value;
}

__device__ Null counted(Null value, unsigned &counter) {
    ++counter;
    return value;
}

__device__ unsigned selected(Null value) { return 7u; }
__device__ unsigned selected(unsigned *value) { return 11u; }
__device__ unsigned selected(int value) { return 13u; }

__global__ void source_null(unsigned *output) {
    __shared__ unsigned values[4];
    unsigned lane = threadIdx.x;
    unsigned counter = 0u;
    auto empty = copied(nullptr);
    Null named = counted(empty, counter);
    unsigned *pointer = named;
    values[lane] = lane + 3u;
    auto synchronized = synchronize(named);
    unsigned base = lane * 8u;
    output[base] = values[3u - lane];
    output[base + 1u] = selected(empty);
    output[base + 2u] = selected(0);
    output[base + 3u] = unsigned(pointer == synchronized);
    output[base + 4u] = counter;
    output[base + 5u] = selected(copied(named));
    Null &alias = named;
    alias = nullptr;
    output[base + 6u] = selected(alias);
    output[base + 7u] = unsigned(bool(synchronized));
}
