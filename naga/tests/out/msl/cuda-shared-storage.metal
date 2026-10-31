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
struct type_6 {
    uint inner[2];
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
, device type_1& out_1 [[user(fake0)]]
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
    type_6 out = {};
    type_6 local = {};
    uint local_1 = {};
    type_6 local_2 = {};
    uint local_3 = {};
    type_6 local_4 = {};
    uint local_5 = {};
    type_6 local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    type_6 local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    type_6 local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    out = type_6 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    uint lane = threadIdx.x;
    uint base = blockIdx.x * 128u;
    values.inner[lane] = ((blockIdx.x * 1000u) + lane) + 10u;
    uint _e21 = values.inner[lane];
    type_6 _e23 = out;
    local = _e23;
    local_1 = static_cast<uint>(base + lane);
    type_6 _e28 = local;
    local_6 = _e28;
    uint _e30 = local_1;
    uint _e32 = local_6.inner[1];
    local_6.inner[1] = _e32 + _e30;
    uint _e36 = local_6.inner[0];
    local_7 = static_cast<uint>(_e36);
    uint _e40 = local_6.inner[1];
    local_8 = static_cast<uint>(_e40);
    uint _e43 = local_8;
    out_1[_e43] = _e21;
    if (lane == 0u) {
        signed_value = naga_neg(7);
        float_value = 3.5;
        int _e53 = signed_value;
        type_6 _e56 = out;
        local_2 = _e56;
        local_3 = static_cast<uint>(base + 64u);
        type_6 _e63 = local_2;
        local_9 = _e63;
        uint _e65 = local_3;
        uint _e67 = local_9.inner[1];
        local_9.inner[1] = _e67 + _e65;
        uint _e71 = local_9.inner[0];
        local_10 = static_cast<uint>(_e71);
        uint _e75 = local_9.inner[1];
        local_11 = static_cast<uint>(_e75);
        uint _e78 = local_11;
        out_1[_e78] = static_cast<uint>(as_type<int>(as_type<uint>(_e53) + as_type<uint>(10)));
        float _e80 = float_value;
        type_6 _e83 = out;
        local_4 = _e83;
        local_5 = static_cast<uint>(base + 65u);
        type_6 _e90 = local_4;
        local_12 = _e90;
        uint _e92 = local_5;
        uint _e94 = local_12.inner[1];
        local_12.inner[1] = _e94 + _e92;
        uint _e98 = local_12.inner[0];
        local_13 = static_cast<uint>(_e98);
        uint _e102 = local_12.inner[1];
        local_14 = static_cast<uint>(_e102);
        uint _e105 = local_14;
        out_1[_e105] = naga_f2u32(_e80 * 2.0);
    }
}
