struct R { int x; int y; };
__device__ int kind(int value) { return 1; }
__device__ int kind(unsigned value) { return 2; }
__device__ int pick(int &value) { return 3; }
__device__ int pick(const int &value) { return 4; }
template<class T = unsigned, class U = T, class V = const U> __device__ unsigned chain() { V value = 7; return unsigned(value); }
template<class T, class U = T> __device__ int selected(T input) { U value = input; return kind(value); }
template<class T = int, class U = const T> __device__ int cv_value() { U value = 7; return pick(value); }
template<class T, class U> __device__ U merged(T input) { return U(input); }
template<class Renamed, class Result = Renamed> __device__ Result merged(Renamed input);
template<class T, class U = T> __device__ int vector3(T input) { U value = input; return int(value.z); }
template<class T, class U = T> __device__ int vector1(T input) { U value = input; return value.x; }
template<class T = R, class U = T> __device__ int record_value() { U value{4, 5}; return value.x + value.y; }
template<class T = dim3, class U = T> __device__ unsigned shape() { U value; return value.x + value.y + value.z; }
template<class T = decltype(nullptr), class U = T> __device__ U null_value() { return nullptr; }
template<class T, class U = const T> __device__ int write(T input) { U pointer = input; *pointer = 9; return *pointer; }
template<class T, class U = T> __device__ int update(int &state, T amount) { U copy = amount; int old = state; state += int(copy); return old; }

__global__ void dependent_type_defaults(unsigned *output, const int *input) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 20u;
    output[base] = chain();
    output[base + 1u] = chain<unsigned>();
    output[base + 2u] = chain<unsigned, unsigned, const unsigned>();
    output[base + 3u] = unsigned(selected(1));
    output[base + 4u] = unsigned(selected(1u));
    output[base + 5u] = unsigned(cv_value());
    output[base + 6u] = unsigned(cv_value<int, int>());
    output[base + 7u] = merged(8u);
    float3 vector{1, 2, 3};
    int1 one{7};
    output[base + 8u] = unsigned(vector3(vector));
    output[base + 9u] = unsigned(vector1(one));
    output[base + 10u] = unsigned(record_value());
    output[base + 11u] = shape();
    output[base + 12u] = unsigned(null_value() == nullptr);
    int local = 0;
    output[base + 13u] = unsigned(write(&local));
    output[base + 14u] = unsigned(local);
    int state = int(lane) + 1;
    output[base + 15u] = unsigned(update(state, 2));
    output[base + 16u] = unsigned(update(state, 3u));
    false && update(state, 99);
    true || update(state, 99);
    int index = 0;
    update(state, input[index++]);
    output[base + 17u] = unsigned(state);
    output[base + 18u] = unsigned(index);
    output[base + 19u] = unsigned(kind(merged(1u)));
}
