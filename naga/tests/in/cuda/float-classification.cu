__device__ int finite_value(float value) { return isfinite(value); }
__device__ int infinite_value(float value) { return isinf(value); }
__device__ int nan_value(float value) { return isnan(value); }
__device__ int sign_value(float value) { return signbit(value); }
__device__ unsigned result_kind(int value) { return 10u + unsigned(value); }
__device__ unsigned result_kind(bool value) { return 20u + unsigned(value); }
__device__ int signbit(bool value) { return value ? 7 : 9; }
__global__ void float_classification(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 544u) return;
    unsigned bits = input[index];
    unsigned base = 4u + index * 23u;
    float value = __uint_as_float(bits);
    output[base] = unsigned(isfinite(value));
    output[base + 1u] = unsigned(isinf(value));
    output[base + 2u] = unsigned(isnan(value));
    output[base + 3u] = unsigned(signbit(value));
    output[base + 4u] = unsigned(finite_value(value));
    output[base + 5u] = unsigned(infinite_value(value));
    output[base + 6u] = unsigned(nan_value(value));
    output[base + 7u] = unsigned(sign_value(value));
    output[base + 8u] = result_kind(isnan(value));
    int cursor = 0;
    output[base + 9u] = unsigned(signbit(__uint_as_float(input[index + unsigned(cursor++)])));
    output[base + 10u] = unsigned(cursor);
    output[base + 11u] = unsigned(signbit(true));
    if (isfinite(value)) output[base + 12u] = 2u;
    else if (isinf(value)) output[base + 12u] = 3u;
    else output[base + 12u] = 4u;
    output[base + 13u] = unsigned(false && isnan(value + float(cursor++)));
    output[base + 14u] = unsigned(cursor);
    output[base + 15u] = unsigned(isfinite(float(3)));
    output[base + 16u] = unsigned(signbit(0.0f));
    output[base + 17u] = unsigned(signbit(-0.0f));
    output[base + 18u] = unsigned(sign_value(-0.0f));
    output[base + 19u] = unsigned(isfinite(__uint_as_float(0x7f800000u)));
    output[base + 20u] = unsigned(isinf(__uint_as_float(0x7f800000u)));
    output[base + 21u] = unsigned(isnan(__uint_as_float(0xff800001u)));
    output[base + 22u] = unsigned(signbit(__uint_as_float(0xff800001u)));
}
