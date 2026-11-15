using Frozen = unsigned;
constexpr int Count = 5;
using Self = unsigned;
template<class T, int N> __device__ T value() { return T(N); }
template<class T = Frozen, int N> __device__ T value();
template<class Renamed, int Count = Count> __device__ Renamed value();
template<class T> __device__ T self_named() { return T(9); }
template<class Self = Self> __device__ Self self_named();
template<int N> __device__ int choose(int value) { return N + value; }
template<int N> __device__ int choose(unsigned value) { return 20 + N + int(value); }
template<int N = 3> __device__ int choose(int value);
template<int N = 5> __device__ int choose(unsigned value);
template<int Amount, class T> __device__ int bump(int &state, T value) { int old = state; state += Amount + int(value); return old; }
template<int Amount = 2, class T> __device__ int bump(int &state, T value);
template<int Marker> __device__ unsigned caller() { return value(); }
__device__ int kind(int value) { return 1; }
__device__ int kind(unsigned value) { return 2; }

__global__ void template_default_merging(unsigned *output, const int *input) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 16u;
    using Frozen = int;
    constexpr int Count = 99;
    output[base] = value();
    output[base + 1u] = value<>();
    output[base + 2u] = value<unsigned>();
    output[base + 3u] = value<unsigned, 5>();
    output[base + 4u] = self_named();
    output[base + 5u] = unsigned(kind(value()));
    output[base + 6u] = unsigned(choose(1));
    output[base + 7u] = unsigned(choose(1u));
    output[base + 8u] = unsigned(choose<7>(1));
    output[base + 9u] = caller<1>();
    int state = int(lane) + 1;
    output[base + 10u] = unsigned(bump(state, 1));
    output[base + 11u] = unsigned(bump<3>(state, 2u));
    false && bump(state, 9);
    true || bump(state, 9);
    bump(state, 0);
    output[base + 12u] = unsigned(state);
    int index = 0;
    output[base + 13u] = unsigned(bump(state, input[index++]));
    output[base + 14u] = unsigned(state);
    output[base + 15u] = unsigned(index);
}
