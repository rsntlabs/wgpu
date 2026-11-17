__device__ float nearby_value(float value) { return nearbyintf(value); }
__device__ int nearbyintf(bool value) { return value ? 7 : 9; }
__global__ void nearby_integers(const unsigned *input, unsigned *output) {
    unsigned index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index >= 32u) return;
    unsigned base = 4u + index * 12u;
    float value = __uint_as_float(input[index]);
    output[base] = __float_as_uint(nearbyintf(value));
    output[base + 1u] = __float_as_uint(rintf(value));
    output[base + 2u] = __float_as_uint(nearby_value(value));
    int cursor = 0;
    output[base + 3u] = __float_as_uint(nearby_value(__uint_as_float(input[index + unsigned(cursor++)])));
    false && nearbyintf(float(cursor++));
    true || nearbyintf(float(cursor++));
    output[base + 4u] = unsigned(cursor);
    output[base + 5u] = __float_as_uint(nearbyintf(-0.5f));
    output[base + 6u] = __float_as_uint(nearbyintf(2.5f));
    output[base + 7u] = __float_as_uint(roundf(2.5f));
    output[base + 8u] = __float_as_uint(nearby_value(3u));
    output[base + 9u] = unsigned(nearbyintf(true));
    output[base + 10u] = __float_as_uint(true ? nearbyintf(nearbyintf(value)) : nearbyintf(float(cursor++)));
    output[base + 11u] = unsigned(cursor);
}
