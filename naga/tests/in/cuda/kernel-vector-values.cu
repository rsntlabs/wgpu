__device__ int sum_pair(int4 value) { return value.x + value.y; }
__global__ void vector_values(unsigned *output, int2 signed2, uint2 unsigned2,
                             float2 real2, int4 signed4, uint4 unsigned4,
                             const float4 real4) {
    unsigned lane = threadIdx.x + blockIdx.x * blockDim.x;
    if (lane >= 4u) return;
    unsigned base = 4u + lane * 12u;
    int2 original_signed = signed2;
    float2 original_real = real2;
    uint4 original_unsigned = unsigned4;
    signed2.x += int(lane);
    signed2.y -= int(lane);
    unsigned2.x += lane;
    unsigned2.y += 2u;
    real2.x += float(lane);
    real2.y *= 2.0f;
    signed4 = make_int4(signed4.x, signed4.y, signed4.z + int(lane), sum_pair(signed4));
    unsigned4.x = unsigned4.y + 1u;
    unsigned4.w += lane;
    output[base] = unsigned(signed2.x + 10);
    output[base + 1u] = unsigned(signed2.y);
    output[base + 2u] = unsigned2.x + unsigned2.y;
    output[base + 3u] = __float_as_uint(real2.x);
    output[base + 4u] = __float_as_uint(real2.y);
    output[base + 5u] = unsigned(signed4.z + 10);
    output[base + 6u] = unsigned(signed4.w);
    output[base + 7u] = unsigned4.x + unsigned4.w;
    output[base + 8u] = __float_as_uint(real4.x + real4.y + real4.z + real4.w);
    output[base + 9u] = unsigned(original_signed.x + 10);
    output[base + 10u] = __float_as_uint(original_real.x);
    output[base + 11u] = original_unsigned.x + original_unsigned.w;
}
