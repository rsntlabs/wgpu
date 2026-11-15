constexpr int Initial = 6;
template<int N = Initial, unsigned M = N, int Last = M> __device__ unsigned chain() { return unsigned(Last); }
template<int N, int M> __device__ int merged() { return M; }
template<int Renamed, int Copy = Renamed> __device__ int merged();
template<int N, bool B = N> __device__ unsigned flag() { return unsigned(B); }
template<int N, unsigned M = N> __device__ unsigned cross() { return M; }
template<unsigned long long N = 65535ULL, unsigned M = N> __device__ unsigned wide() { return M; }
template<class T = unsigned, int N = 4, int M = N> __device__ T mixed() { return T(M); }
template<int Amount, int Copy = Amount> __device__ int update(int &state) { int old = state; state += Copy; return old; }
__device__ unsigned choose(bool value) { return 99u; }
template<int N = 3, int M = N, class T> __device__ unsigned choose(T value) { return unsigned(value) + unsigned(M); }

__global__ void dependent_integral_defaults(unsigned *output, const int *input) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 16u;
    constexpr int Initial = 99;
    output[base] = chain();
    output[base + 1u] = chain<6>();
    output[base + 2u] = chain<6, 6u, 6>();
    output[base + 3u] = chain<7>();
    output[base + 4u] = unsigned(merged<8>());
    output[base + 5u] = flag<0>();
    output[base + 6u] = flag<1>();
    output[base + 7u] = cross<-1, 7u>();
    output[base + 8u] = wide();
    output[base + 9u] = mixed();
    output[base + 10u] = mixed<int, 9>();
    output[base + 11u] = choose(2u);
    int state = int(lane) + 1;
    output[base + 12u] = unsigned(update<2>(state));
    false && update<99>(state);
    true || update<99>(state);
    update<3>(state);
    output[base + 13u] = unsigned(state);
    int index = 0;
    output[base + 14u] = choose(unsigned(input[index++]));
    output[base + 15u] = unsigned(index);
}
