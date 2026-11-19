__device__ int sum_pair(int3 value) { return value.x + value.y; }
__global__ void named_vectors(unsigned *output, int1 signed1, uint1 unsigned1,
                             float1 real1, int3 signed3, uint3 unsigned3,
                             const float3 real3, const float3 *input) {
    unsigned lane = threadIdx.x + blockIdx.x * blockDim.x;
    if (lane >= 4u) return;
    unsigned base = 4u + lane * 12u;
    int1 original_signed = signed1;
    float1 original_real = real1;
    uint3 original_unsigned = unsigned3;
    signed1.x += int(lane);
    unsigned1.x += lane;
    real1.x += float(lane);
    signed3 = make_int3(signed3.x, signed3.y, signed3.z + int(lane));
    unsigned3.x = unsigned3.y + 1u;
    unsigned3.z += lane;
    float3 stored = input[lane];
    output[base] = unsigned(signed1.x + 10);
    output[base + 1u] = unsigned1.x;
    output[base + 2u] = __float_as_uint(real1.x);
    output[base + 3u] = unsigned(signed3.z + 10);
    output[base + 4u] = unsigned(sum_pair(signed3));
    output[base + 5u] = unsigned3.x + unsigned3.z;
    output[base + 6u] = __float_as_uint(real3.x + real3.y + real3.z);
    output[base + 7u] = unsigned(original_signed.x + 10);
    output[base + 8u] = original_unsigned.x + original_unsigned.z;
    output[base + 9u] = __float_as_uint(original_real.x);
    output[base + 10u] = __float_as_uint(stored.z);
    output[base + 11u] = __float_as_uint(stored.x + real3.x);
}
