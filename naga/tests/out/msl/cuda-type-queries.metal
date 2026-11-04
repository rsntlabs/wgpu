// language: metal2.3
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef ulong unsigned_long;
typedef unsigned_long type[1];
struct type_1 {
    unsigned_long value;
    char _pad1[8];
};

unsigned_long byte_count_float3_(
) {
    return 12uL;
}

struct type_queriesInput {
};
[[max_total_threads_per_threadgroup(64)]] kernel void type_queries(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type& output [[buffer(0)]]
, constant type_1& base [[buffer(1)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    unsigned_long base_1 = base.value;
    uint index = (blockIdx.x * 64u) + threadIdx.x;
    unsigned_long _e10 = byte_count_float3_();
    output[index] = (((base_1 + _e10) + 24uL) * 8uL) + 8uL;
}
