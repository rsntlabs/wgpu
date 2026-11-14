using Flag = bool;

__device__ int flag_overload(bool value) { return value ? 31 : 17; }
__device__ int flag_overload(int value) { return value + 100; }
__device__ void flip_flag(bool &value) { value = !value; }
__device__ int inspect_flag(const bool &value) { return value ? 7 : 9; }

__global__ void boolean_parameters(Flag enabled, const Flag frozen, unsigned *output) {
    unsigned index = 4u + threadIdx.x * 8u;
    bool original = enabled;
    output[index] = unsigned(enabled);
    output[index + 1u] = unsigned(flag_overload(enabled));
    flip_flag(enabled);
    output[index + 2u] = unsigned(enabled);
    output[index + 3u] = unsigned(flag_overload(enabled));
    output[index + 4u] = unsigned(frozen);
    output[index + 5u] = unsigned(inspect_flag(frozen));
    output[index + 6u] = unsigned(flag_overload(original));
    output[index + 7u] = unsigned(enabled != frozen);
}
