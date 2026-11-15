__device__ float copied(float value, float sign) { return copysignf(value, sign); }
__device__ int copysignf(bool value, bool sign) { return value ? 7 : 9; }
__global__ void copy_signs(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 912u) return;
    unsigned base = 4u + index * 14u;
    float value = __uint_as_float(input[index * 2u]);
    float sign = __uint_as_float(input[index * 2u + 1u]);
    output[base] = __float_as_uint(copysignf(value, sign));
    output[base + 1u] = __float_as_uint(copied(value, sign));
    output[base + 2u] = __float_as_uint(copysignf(0.0f, -0.0f));
    output[base + 3u] = __float_as_uint(copysignf(-0.0f, 0.0f));
    output[base + 4u] = __float_as_uint(copysignf(__uint_as_float(0xff800001u), 0.0f));
    output[base + 5u] = __float_as_uint(copysignf(__uint_as_float(0x7fc12345u), -0.0f));
    output[base + 6u] = __float_as_uint(copied(-3, 0u));
    output[base + 7u] = __float_as_uint(copied(5u, -1));
    output[base + 8u] = unsigned(copysignf(true, false));
    int cursor = 0;
    output[base + 9u] = __float_as_uint(copied(__uint_as_float(input[index * 2u + unsigned(cursor++)]), __uint_as_float(input[index * 2u + unsigned(cursor++)])));
    bool run = false;
    run && copysignf(float(cursor++), sign);
    run = true;
    run || copysignf(float(cursor++), sign);
    output[base + 10u] = unsigned(cursor);
    output[base + 11u] = __float_as_uint(run ? copysignf(value, sign) : copysignf(float(cursor++), sign));
    output[base + 12u] = __float_as_uint(copied(true, -1.0f));
    output[base + 13u] = unsigned(cursor);
}
