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
struct Inner_cuda_record_0_ {
    float3_ vector;
    type_2 row;
};
struct type_3 {
    type_2 inner[2];
};
struct Record_cuda_record_1_ {
    int scalar;
    float3_ vector;
    type_3 matrix_;
    Inner_cuda_record_0_ nested;
};
typedef uint type_5[1];
struct Local_cuda_record_2_ {
    uint token;
};
uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}


struct record_assertionsInput {
};
[[max_total_threads_per_threadgroup(4)]] kernel void record_assertions(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_5& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
) {
    Record_cuda_record_1_ value = {};
    Local_cuda_record_2_ local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint lane = threadIdx.x;
    value.scalar = static_cast<int>(lane + 3u);
    value.vector = float3_ {1.0, 2.0, static_cast<float>(lane + 5u)};
    value.matrix_.inner[1].inner[2] = static_cast<int>(lane + 9u);
    value.nested.row.inner[2] = static_cast<int>(lane + 15u);
    local.token = lane + 21u;
    uint index = 4u + (lane * 8u);
    int _e38 = value.scalar;
    output[index] = static_cast<uint>(_e38);
    float _e44 = value.vector.z;
    local_1 = static_cast<uint>(index + 1u);
    uint _e50 = local_1;
    output[_e50] = naga_f2u32(_e44);
    int _e57 = value.matrix_.inner[1].inner[2];
    local_2 = static_cast<uint>(index + 2u);
    uint _e63 = local_2;
    output[_e63] = static_cast<uint>(_e57);
    int _e69 = value.nested.row.inner[2];
    local_3 = static_cast<uint>(index + 3u);
    uint _e75 = local_3;
    output[_e75] = static_cast<uint>(_e69);
    local_4 = static_cast<uint>(index + 4u);
    uint _e83 = local_4;
    output[_e83] = static_cast<uint>(64uL);
    local_5 = static_cast<uint>(index + 5u);
    uint _e91 = local_5;
    output[_e91] = static_cast<uint>(24uL);
    local_6 = static_cast<uint>(index + 6u);
    uint _e99 = local_6;
    output[_e99] = static_cast<uint>(12uL);
    uint _e102 = local.token;
    local_7 = static_cast<uint>(index + 7u);
    uint _e107 = local_7;
    output[_e107] = _e102;
}
