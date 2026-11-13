// language: metal2.3
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct float3_ {
    float x;
    float y;
    float z;
};
struct type_2 {
    int inner[3];
};
struct type_3 {
    type_2 inner[2];
};
struct Record_cuda_record_0_ {
    float3_ vector;
    type_3 matrix_;
};
typedef uint type_5[1];
struct type_6 {
    float3_ inner[2];
};
struct type_7 {
    Record_cuda_record_0_ inner[2];
};

[[max_total_threads_per_threadgroup(64)]] kernel void object_sizes(
  device type_5& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
) {
    type_6 values = {};
    Record_cuda_record_0_ record = {};
    type_7 records = {};
    output[static_cast<uint>(0)] = static_cast<uint>(24uL);
    output[static_cast<uint>(1)] = static_cast<uint>(12uL);
    output[static_cast<uint>(2)] = static_cast<uint>(8uL);
    output[static_cast<uint>(3)] = static_cast<uint>(12uL);
    output[static_cast<uint>(4)] = static_cast<uint>(24uL);
    output[static_cast<uint>(5)] = static_cast<uint>(4uL);
    output[static_cast<uint>(6)] = static_cast<uint>(4uL);
    output[static_cast<uint>(7)] = static_cast<uint>(12uL);
    output[static_cast<uint>(8)] = static_cast<uint>(12uL);
    output[static_cast<uint>(9)] = static_cast<uint>(4uL);
    output[static_cast<uint>(10)] = static_cast<uint>(36uL);
}
