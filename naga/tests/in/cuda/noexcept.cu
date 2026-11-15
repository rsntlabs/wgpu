using Null = decltype(nullptr);
namespace cg = cooperative_groups;
constexpr bool Safe = true;
__device__ unsigned __vadd2(bool a, bool b) { return 7u; }
__device__ int bump_noexcept(int &value, int step = 2) noexcept;
__device__ int choose_noexcept(int value) noexcept { return 10 + value; }
__device__ int choose_noexcept(unsigned value) noexcept(false) { return 20 + int(value); }
__device__ unsigned transformed_noexcept(int &value, unsigned scale) noexcept(1) { return unsigned(value++) * scale; }
__device__ unsigned combined_noexcept(unsigned a, unsigned b) noexcept(Safe) { return __vadd2(a, b); }
__device__ int queried_noexcept(const int &value) noexcept(sizeof(value) == 4) { return value + 1; }
__device__ int null_noexcept(Null erased, const int &value) noexcept(sizeof(value) == 4) { return value + 2; }
__device__ int block_noexcept(cg::thread_block erased, const int &value) noexcept(sizeof(value) == 4) { return value + 3; }
__device__ int opaque_noexcept() { return 99; }
__device__ int skipped_noexcept() noexcept(false && opaque_noexcept()) { return 7; }
__device__ int converted_noexcept() noexcept(static_cast<bool>(2)) { return 9; }
__device__ int false_noexcept();
__device__ int false_noexcept() noexcept(false) { return 13; }
__device__ int reverse_noexcept() noexcept(0);
__device__ int reverse_noexcept() { return 14; }
__device__ int default_noexcept(int value = 3.75f) noexcept(true) { return value + 4; }
__device__ int float_bool_noexcept() noexcept(bool(2.0f)) { return 15; }
extern "C" __global__ void noexcept_helpers(unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 18u;
    int value = int(lane) + 1;
    output[base] = unsigned(bump_noexcept(value));
    output[base + 1u] = unsigned(bump_noexcept(value, 5));
    output[base + 2u] = unsigned(value);
    output[base + 3u] = unsigned(choose_noexcept(1));
    output[base + 4u] = unsigned(choose_noexcept(1u));
    output[base + 5u] = combined_noexcept(transformed_noexcept(value, 3u), transformed_noexcept(value, 5u));
    output[base + 6u] = unsigned(value);
    false && bump_noexcept(value);
    true || bump_noexcept(value);
    (lane & 1u) == 0u ? bump_noexcept(value) : bump_noexcept(value, 3);
    output[base + 7u] = unsigned(value);
    bump_noexcept(value);
    output[base + 8u] = unsigned(value);
    output[base + 9u] = unsigned(queried_noexcept(value));
    output[base + 10u] = unsigned(null_noexcept(nullptr, value));
    output[base + 11u] = unsigned(block_noexcept(cg::this_thread_block(), value));
    output[base + 12u] = unsigned(skipped_noexcept());
    output[base + 13u] = unsigned(converted_noexcept());
    output[base + 14u] = unsigned(false_noexcept());
    output[base + 15u] = unsigned(reverse_noexcept());
    output[base + 16u] = unsigned(default_noexcept());
    output[base + 17u] = unsigned(float_bool_noexcept());
}
__device__ int bump_noexcept(int &renamed, int amount) noexcept(sizeof(renamed) == 4) { int old = renamed; renamed += amount; return old; }
