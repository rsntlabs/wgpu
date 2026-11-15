constexpr int N = 4;
#define INITIAL_AMOUNT (2 + 3)

template<int N = N> __device__ int self_named() { return N; }
template<int Count = INITIAL_AMOUNT> __device__ int inherited();
template<int Renamed> __device__ int inherited() { return Renamed; }
template<int N = 7> __device__ int value() { return N; }
template<int N = 3, class T> __device__ T add(T value) { return value + T(N); }
template<class T = unsigned, int N = 5> __device__ T mixed() { return T(N); }
template<bool B = bool(2), unsigned N = unsigned(4)> __device__ unsigned flags() { return unsigned(B) + N; }
template<int N = static_cast<int>(3.75f)> __device__ int cast_value() { return N; }
template<int N = (true ? 1, 2 : 3)> __device__ int comma_value() { return N; }
template<int N = (8 >> 1)> __device__ int shifted() { return N; }
__device__ int choose(int value) { return value + 10; }
template<int N = 20, class T> __device__ int choose(T value) { return int(value) + N; }
template<int Amount = 2> __device__ int bump(int &value) { int old = value; value += Amount; return old; }
__device__ int opaque() { return int(threadIdx.x); }
template<bool B = (true || threadIdx.x)> __device__ int skipped_thread() { return int(B); }
template<bool B = (false && gridDim.x)> __device__ int skipped_grid() { return int(B); }
template<bool B = (true || opaque())> __device__ int skipped_call() { return int(B); }

__global__ void integral_template_defaults(unsigned *output, const int *input) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 24u;
    constexpr int N = 99;
    output[base] = unsigned(self_named());
    output[base + 1u] = unsigned(inherited());
    output[base + 2u] = unsigned(value());
    output[base + 3u] = unsigned(value<>());
    output[base + 4u] = unsigned(value<7>());
    output[base + 5u] = unsigned(add(2));
    output[base + 6u] = add<7>(3u);
    output[base + 7u] = mixed();
    output[base + 8u] = unsigned(mixed<int, 8>());
    output[base + 9u] = flags();
    output[base + 10u] = unsigned(cast_value());
    output[base + 11u] = unsigned(comma_value());
    output[base + 12u] = unsigned(shifted());
    output[base + 13u] = unsigned(choose(1));
    output[base + 14u] = unsigned(choose(1u));
    output[base + 15u] = unsigned(choose<>(1));
    int state = int(lane) + 1;
    output[base + 16u] = unsigned(bump(state));
    output[base + 17u] = unsigned(bump<3>(state));
    false && bump(state);
    true || bump(state);
    bump(state);
    output[base + 18u] = unsigned(state);
    output[base + 19u] = unsigned(skipped_thread());
    output[base + 20u] = unsigned(skipped_grid());
    output[base + 21u] = unsigned(skipped_call());
    int index = 0;
    output[base + 22u] = unsigned(add(input[index++]));
    output[base + 23u] = unsigned(index);
}
