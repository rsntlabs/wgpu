__device__ float floor_value(float value) { return floorf(value); }
__device__ float ceil_value(float value) { return ceilf(value); }
__global__ void rounding_zero_signs(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x;
    unsigned bits = input[index];
    unsigned base = 4u + index * 14u;
    output[base] = __float_as_uint(floorf(__uint_as_float(bits)));
    output[base + 1u] = __float_as_uint(ceilf(__uint_as_float(bits)));
    output[base + 2u] = __float_as_uint(floor_value(__uint_as_float(bits)));
    output[base + 3u] = __float_as_uint(ceil_value(__uint_as_float(bits)));
    output[base + 4u] = __float_as_uint(floorf(0.0f));
    output[base + 5u] = __float_as_uint(floorf(-0.0f));
    output[base + 6u] = __float_as_uint(ceilf(0.0f));
    output[base + 7u] = __float_as_uint(ceilf(-0.0f));
    output[base + 8u] = __float_as_uint(floorf(0.25f));
    output[base + 9u] = __float_as_uint(ceilf(-0.25f));
    int cursor = 0;
    output[base + 10u] = __float_as_uint(floor_value(__uint_as_float(input[index + unsigned(cursor++)])));
    output[base + 11u] = __float_as_uint(ceil_value(float(cursor++)));
    output[base + 12u] = unsigned(cursor - 1);
    output[base + 13u] = unsigned(cursor);
}
