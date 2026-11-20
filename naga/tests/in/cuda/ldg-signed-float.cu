__device__ int read_signed(const int *pointer) { return __ldg(pointer); }
__device__ float read_float(const float *pointer) { return __ldg(pointer); }
__device__ unsigned kind(int value) { return 1u; }
__device__ unsigned kind(unsigned value) { return 2u; }
__device__ unsigned kind(float value) { return 3u; }
__global__ void load_values(const int *integers, const float *reals, unsigned *output) {
    unsigned lane = threadIdx.x;
    unsigned base = 4u + lane * 10u;
    const int *alias = integers;
    unsigned cursor = lane;
    output[base] = unsigned(__ldg(integers + lane));
    output[base + 1u] = unsigned(read_signed(alias + lane));
    output[base + 2u] = kind(__ldg(integers + lane));
    output[base + 3u] = __float_as_uint(__ldg(reals + lane));
    output[base + 4u] = __float_as_uint(read_float(reals + lane));
    output[base + 5u] = kind(__ldg(reals + lane));
    output[base + 6u] = unsigned(__ldg(integers + cursor++));
    output[base + 7u] = cursor;
    cursor = lane;
    output[base + 8u] = __float_as_uint(__ldg(reals + cursor++));
    output[base + 9u] = cursor;
}
