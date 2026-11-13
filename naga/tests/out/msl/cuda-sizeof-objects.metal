// language: metal2.3
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_1[1];
struct float3_ {
    float x;
    float y;
    float z;
};
struct type_3 {
    float3_ inner[2];
};

[[max_total_threads_per_threadgroup(64)]] kernel void object_sizes(
  device type_1& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
) {
    type_3 values = {};
    output[static_cast<uint>(0)] = static_cast<uint>(24uL);
    output[static_cast<uint>(1)] = static_cast<uint>(12uL);
    output[static_cast<uint>(2)] = static_cast<uint>(8uL);
}
