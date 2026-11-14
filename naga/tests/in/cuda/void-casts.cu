__device__ int take(int &value) { return value++; }
__device__ void bump(int &value) { return (void)value++; }
__device__ void forward(int &value) { return static_cast<void>(bump(value)); }
__device__ int advance(int &value, int step) {
    int previous = value;
    value += step;
    return previous;
}

extern "C" __global__ void void_casts(int *output, const int *input) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 8u;
    int value = int(lane) + 1;
    (void)take(value);
    static_cast<void>(bump(value));
    (void)static_cast<void>(value++);
    output[base] = value;
    bool choose = (lane & 1u) == 0u;
    choose ? (void)advance(value, 3) : static_cast<void>(advance(value, 7));
    output[base + 1u] = value;
    (void)(value++, static_cast<void>(value++));
    output[base + 2u] = value;
    int index = 0;
    (void)input[index++];
    static_cast<void>(input[index++]);
    output[base + 3u] = index;
    output[base + 4u] = input[0];
    forward(value);
    output[base + 5u] = value;
    for (int turn = 0; turn < 2; static_cast<void>(++turn)) {
        (void)value++;
    }
    output[base + 6u] = value;
    int runtime = input[1];
    constexpr int Count = ((void)runtime, 3);
    static_assert(((void)0, true));
    int array[Count]{};
    output[base + 7u] = array[2];
}
