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
    uint lane = {};
    uint base = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    local = 0u;
    lane = threadIdx.x;
    base = blockIdx.x * 128u;
    uint _e13 = lane;
    uint _e17 = lane;
    values.inner[_e17] = ((blockIdx.x * 1000u) + _e13) + 10u;
    uint _e20 = lane;
    uint _e22 = values.inner[_e20];
    uint _e23 = local;
    local_1 = _e23;
    uint _e25 = local_1;
    local_2 = static_cast<uint>(_e25);
    uint _e28 = base;
    uint _e29 = lane;
    local_3 = static_cast<uint>(_e28 + _e29);
    uint _e34 = local_2;
    uint _e35 = local_3;
    local_10 = static_cast<uint>(_e34 + _e35);
    uint _e39 = local_10;
    out[_e39] = _e22;
    uint _e41 = lane;
    if (_e41 == 0u) {
        signed_value = naga_neg(7);
        float_value = 3.5;
        int _e49 = signed_value;
        uint _e52 = local;
        local_4 = _e52;
        uint _e54 = local_4;
        local_5 = static_cast<uint>(_e54);
        uint _e57 = base;
        local_6 = static_cast<uint>(_e57 + 64u);
        uint _e63 = local_5;
        uint _e64 = local_6;
        local_11 = static_cast<uint>(_e63 + _e64);
        uint _e68 = local_11;
        out[_e68] = static_cast<uint>(as_type<int>(as_type<uint>(_e49) + as_type<uint>(10)));
        float _e70 = float_value;
        uint _e73 = local;
        local_7 = _e73;
        uint _e75 = local_7;
        local_8 = static_cast<uint>(_e75);
        uint _e78 = base;
        local_9 = static_cast<uint>(_e78 + 65u);
        uint _e84 = local_8;
        uint _e85 = local_9;
        local_12 = static_cast<uint>(_e84 + _e85);
        uint _e89 = local_12;
        out[_e89] = naga_f2u32(_e70 * 2.0);
    }
}
