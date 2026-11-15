using Frozen = unsigned;
using Self = unsigned;
struct Record { int x; int y; };

__device__ int kind(int value) { return 1; }
__device__ int kind(unsigned value) { return 2; }
__device__ int pick(int &value) { return 3; }
__device__ int pick(const int &value) { return 4; }
__device__ int selected(int value) { return 10 + value; }
template<class T = unsigned> __device__ int selected(T value) { return 20 + int(value); }
template<class T = Frozen> __device__ T default_value();
template<class Renamed> __device__ Renamed default_value() { return Renamed(7); }
template<class Self = Self> __device__ Self self_named() { return Self(9); }
template<class T = unsigned> __device__ int deduced_kind(T value) { return kind(value); }
template<class Result = unsigned, class Input> __device__ Result converted(Input value) { return Result(value); }
template<class T = const int> __device__ int frozen_cv() { T value = 7; return pick(value); }
template<class T = float3> __device__ int vector_value() { T value{1.0f, 2.0f, 3.0f}; return int(value.z); }
template<class T = Record> __device__ int record_value() { T value{4, 5}; return value.x + value.y; }
template<class T = dim3> __device__ unsigned shape_value() { T value; return value.x + 10u * value.y + 100u * value.z; }
template<class T = decltype(nullptr)> __device__ T null_value() { return nullptr; }
template<class Pointer = const int *> __device__ int read(const int *input) { Pointer value = input; return value[0]; }
template<class T = unsigned> __device__ int bump(int &value, int amount = 2) { int old = value; value += amount; return old; }

__global__ void default_template_arguments(unsigned *output, const int *input) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 24u;
    using Frozen = int;
    output[base] = default_value();
    output[base + 1u] = default_value<>();
    output[base + 2u] = default_value<unsigned>();
    output[base + 3u] = self_named();
    output[base + 4u] = unsigned(deduced_kind(1));
    output[base + 5u] = unsigned(deduced_kind(1u));
    output[base + 6u] = unsigned(kind(converted(3)));
    output[base + 7u] = unsigned(kind(converted<int>(3u)));
    output[base + 8u] = unsigned(selected(1));
    output[base + 9u] = unsigned(selected(1u));
    output[base + 10u] = unsigned(selected<>(1));
    output[base + 11u] = unsigned(frozen_cv());
    output[base + 12u] = unsigned(frozen_cv<int>());
    output[base + 13u] = unsigned(vector_value());
    output[base + 14u] = unsigned(record_value());
    output[base + 15u] = shape_value();
    output[base + 16u] = unsigned(null_value() == nullptr);
    output[base + 17u] = unsigned(read(input + 1));
    int value = int(lane) + 1;
    output[base + 18u] = unsigned(bump(value));
    output[base + 19u] = unsigned(bump<unsigned>(value, 3));
    false && bump(value);
    true || bump(value);
    bump(value);
    output[base + 20u] = unsigned(value);
    output[base + 21u] = unsigned(kind(default_value()));
    output[base + 22u] = unsigned(bump<>(value, input[0]));
    output[base + 23u] = unsigned(value);
}
