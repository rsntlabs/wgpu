constexpr int Frozen = 3;
using Null = decltype(nullptr);
template<class T> __device__ int add_template_default(T original, int bias = Frozen);
template<class U> __device__ int add_template_default(U renamed, int other) { return int(renamed) + other; }
template<class T> __device__ int converted_template_default(T value, int bias = 3.75f, bool enabled = 2, float scale = 2) { return int(value) + bias + int(enabled) + int(scale); }
template<class T> __device__ unsigned wrapped_template_default(unsigned value = -1) { return value; }
template<class T> __device__ int choose_template_default(T value, int bias = 3) { return 300 + int(value) + bias; }
__device__ int choose_template_default(bool value, int bias = 4) { return 400 + int(value) + bias; }
template<class T> __device__ int left_template_default(T value, int bias = 3) { return 100 + bias; }
template<class T> __device__ int left_template_default(T *value) { return 200 + int(*value); }
template<class T> __device__ int right_template_default(T value) { return 100; }
template<class T> __device__ int right_template_default(T *value, int bias = 4) { return 200 + int(*value) + bias; }
__device__ int tied_template_default(int value, int bias = 2) { return 400 + value + bias; }
template<class T> __device__ int tied_template_default(T value, int bias = 3) { return 500 + int(value) + bias; }
template<class T> __device__ int bump_template_default(T &value, int step = 2) { int old = int(value); value += T(step); return old; }
template<class T> __device__ int load_template_default(const T *input, int index = 1) { return int(input[index]); }
template<int N> __device__ int erased_template_default(Null value, int result = 7) { return result + N; }
template<class T> __device__ int conditional_template_default(T value, int count = true ? 1, 2 : 3) { return int(value) + count; }
template<class T> __device__ int casted_template_default(T value, int count = static_cast<int>(static_cast<float>(3))) { return int(value) + count; }
__device__ int inner_template_default(int value, int extra = 2) { return value + extra; }
template<int N> __device__ int explicit_value_template_default(int bias = 7) { return inner_template_default(bias) + N; }
extern "C" __global__ void template_default_arguments(unsigned *output, const int *input) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 23u;
    int value = int(lane) + 1;
    int Frozen = 99;
    output[base] = unsigned(add_template_default(value));
    output[base + 1u] = unsigned(add_template_default(value, 9));
    output[base + 2u] = unsigned(converted_template_default(value));
    output[base + 3u] = wrapped_template_default<int>();
    output[base + 4u] = unsigned(choose_template_default(true));
    output[base + 5u] = unsigned(choose_template_default(1));
    output[base + 6u] = unsigned(choose_template_default<bool>(true));
    output[base + 7u] = unsigned(left_template_default(input));
    output[base + 8u] = unsigned(right_template_default(input));
    output[base + 9u] = unsigned(tied_template_default(1));
    output[base + 10u] = unsigned(tied_template_default(1u));
    output[base + 11u] = unsigned(bump_template_default(value));
    output[base + 12u] = unsigned(bump_template_default(value, 5));
    output[base + 13u] = unsigned(load_template_default(input));
    output[base + 14u] = unsigned(erased_template_default<5>(nullptr));
    int index = 0;
    output[base + 15u] = unsigned(load_template_default(input + index++));
    false && bump_template_default(value);
    true || bump_template_default(value);
    (lane & 1u) == 0u ? bump_template_default(value) : bump_template_default(value, 3);
    bump_template_default(value);
    output[base + 16u] = unsigned(value);
    output[base + 17u] = unsigned(index);
    output[base + 18u] = unsigned(add_template_default(0));
    output[base + 19u] = unsigned(add_template_default<unsigned>(2u));
    output[base + 20u] = unsigned(conditional_template_default(1));
    output[base + 21u] = unsigned(casted_template_default(1));
    output[base + 22u] = unsigned(explicit_value_template_default<3>());
}
