constexpr int Frozen = 3;
using Null = decltype(nullptr);
__device__ int add_default(int value, int step = Frozen) { return value + step; }
__device__ int combine_default(int, int = 1);
__device__ int combine_default(int = 2, int);
__device__ int combine_default(int first, int second) { return first * 10 + second; }
__device__ int converted_default(int value = 3.75f, bool enabled = 2, float scale = 2) { return value + int(enabled) + int(scale); }
__device__ unsigned wrapped_default(unsigned value = -1) { return value; }
__device__ int choose_default(int value, int extra = 1) { return 100 + value + extra; }
__device__ int choose_default(unsigned value, float extra = 2.0f) { return 200 + int(value) + int(extra); }
__device__ int choose_default(bool value, int extra = 3) { return 300 + int(value) + extra; }
__device__ int bump_default(int &value, int step = 2) { int old = value; value += step; return old; }
__device__ int load_default(const int *input, int index = 1) { return input[index]; }
__device__ int erased_default(Null value, int result = 7) { return result; }
__device__ int ranked_default(int value, int extra = 2) { return 400 + value + extra; }
template<typename T> __device__ int ranked_default(T value) { return 500 + int(value); }
extern "C" __global__ void default_arguments(unsigned *output, const int *input) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 20u;
    int value = int(lane) + 1;
    int Frozen = 99;
    output[base] = unsigned(add_default(value));
    output[base + 1u] = unsigned(add_default(value, 9));
    output[base + 2u] = unsigned(combine_default());
    output[base + 3u] = unsigned(combine_default(4));
    output[base + 4u] = unsigned(combine_default(4, 5));
    output[base + 5u] = unsigned(converted_default());
    output[base + 6u] = wrapped_default();
    output[base + 7u] = unsigned(choose_default(1));
    output[base + 8u] = unsigned(choose_default(1u));
    output[base + 9u] = unsigned(choose_default(true));
    output[base + 10u] = unsigned(bump_default(value));
    output[base + 11u] = unsigned(bump_default(value, 5));
    output[base + 12u] = unsigned(load_default(input));
    output[base + 13u] = unsigned(erased_default(nullptr));
    int index = 0;
    output[base + 14u] = unsigned(load_default(input + index++));
    false && bump_default(value);
    true || bump_default(value);
    (lane & 1u) == 0u ? bump_default(value) : bump_default(value, 3);
    bump_default(value);
    output[base + 15u] = unsigned(value);
    output[base + 16u] = unsigned(index);
    output[base + 17u] = unsigned(add_default(0));
    output[base + 18u] = unsigned(ranked_default(1));
    output[base + 19u] = unsigned(ranked_default(1u));
}
