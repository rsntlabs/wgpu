using Sample = const float;
using Bits = unsigned;

__device__ float sqrt(Sample);
__device__ float sqrtf(float);
__device__ Sample root(Sample value) { return sqrt(value); }
__device__ int sqrt(int value) { return value + 40; }
__device__ unsigned sqrt(unsigned value) { return value + 50u; }
__device__ int sqrt(bool value) { return value ? 7 : 9; }
__device__ int sqrt(int first, int second) { return first + second; }
__device__ float2 sqrt(float2 value) {
    return make_float2(sqrt(value.x), sqrt(value.y));
}

__global__ void roots(Bits *output) {
    output[0] = __float_as_uint(sqrt(0.0f));
    output[1] = __float_as_uint(sqrt(-0.0f));
    output[2] = __float_as_uint(root(6.25f));
    output[3] = __float_as_uint(sqrtf(9.0f));
    output[4] = unsigned(sqrt(-3));
    output[5] = sqrt(3u);
    output[6] = unsigned(sqrt(true));
    output[7] = unsigned(sqrt(false));
    output[8] = __float_as_uint(sqrt(__uint_as_float(1u)));
    output[9] = __float_as_uint(sqrt(__uint_as_float(0x7f800000u)));
    output[10] = __float_as_uint(sqrt(-4.0f));
    output[11] = __float_as_uint(sqrt(__uint_as_float(0x7f800001u)));
    float value = 4.0f;
    output[12] = __float_as_uint(sqrt(value++));
    output[13] = __float_as_uint(value);
    output[14] = unsigned(sqrt(3, 4));
    output[15] = __float_as_uint(root(float(16)));
    float2 pair = sqrt(make_float2(9.0f, 16.0f));
    output[16] = __float_as_uint(pair.x);
    output[17] = __float_as_uint(pair.y);
}
