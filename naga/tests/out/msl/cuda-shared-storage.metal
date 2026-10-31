// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_1[1];
struct type_2 {
    uint inner[64];
};
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}


struct shared_storageInput {
};
kernel void shared_storage(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, threadgroup type_2& values
, threadgroup int& signed_value
, threadgroup float& float_value
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        values = {};
        signed_value = {};
        float_value = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint lane = threadIdx.x;
    uint base = blockIdx.x * 128u;
    values.inner[lane] = ((blockIdx.x * 1000u) + lane) + 10u;
    uint _e15 = values.inner[lane];
    local = static_cast<uint>(base + lane);
    uint _e19 = local;
    local_3 = static_cast<uint>(_e19);
    uint _e22 = local_3;
    out[_e22] = _e15;
    if (lane == 0u) {
        signed_value = naga_neg(7);
        float_value = 3.5;
        int _e32 = signed_value;
        local_1 = static_cast<uint>(base + 64u);
        uint _e40 = local_1;
        local_4 = static_cast<uint>(_e40);
        uint _e43 = local_4;
        out[_e43] = static_cast<uint>(as_type<int>(as_type<uint>(_e32) + as_type<uint>(10)));
        float _e45 = float_value;
        local_2 = static_cast<uint>(base + 65u);
        uint _e53 = local_2;
        local_5 = static_cast<uint>(_e53);
        uint _e56 = local_5;
        out[_e56] = naga_f2u32(_e45 * 2.0);
    }
}
