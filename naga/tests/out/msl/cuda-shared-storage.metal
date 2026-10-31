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
    uint lane = {};
    uint base = {};
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
    lane = threadIdx.x;
    base = blockIdx.x * 128u;
    uint _e18 = lane;
    uint _e22 = lane;
    values.inner[_e22] = ((blockIdx.x * 1000u) + _e18) + 10u;
    uint _e25 = lane;
    uint _e27 = values.inner[_e25];
    type_6 _e30 = out;
    local = _e30;
    uint _e31 = base;
    uint _e32 = lane;
    local_1 = static_cast<uint>(_e31 + _e32);
    type_6 _e37 = local;
    local_6 = _e37;
    uint _e38 = local_1;
    uint _e40 = local_6.inner[1];
    local_6.inner[1] = _e40 + _e38;
    uint _e44 = local_6.inner[0];
    local_7 = static_cast<uint>(_e44);
    uint _e48 = local_6.inner[1];
    local_8 = static_cast<uint>(_e48);
    uint _e51 = local_8;
    out_1[_e51] = _e27;
    uint _e53 = lane;
    if (_e53 == 0u) {
        signed_value = naga_neg(7);
        float_value = 3.5;
        int _e61 = signed_value;
        type_6 _e65 = out;
        local_2 = _e65;
        uint _e66 = base;
        local_3 = static_cast<uint>(_e66 + 64u);
        type_6 _e73 = local_2;
        local_9 = _e73;
        uint _e74 = local_3;
        uint _e76 = local_9.inner[1];
        local_9.inner[1] = _e76 + _e74;
        uint _e80 = local_9.inner[0];
        local_10 = static_cast<uint>(_e80);
        uint _e84 = local_9.inner[1];
        local_11 = static_cast<uint>(_e84);
        uint _e87 = local_11;
        out_1[_e87] = static_cast<uint>(as_type<int>(as_type<uint>(_e61) + as_type<uint>(10)));
        float _e89 = float_value;
        type_6 _e93 = out;
        local_4 = _e93;
        uint _e94 = base;
        local_5 = static_cast<uint>(_e94 + 65u);
        type_6 _e101 = local_4;
        local_12 = _e101;
        uint _e102 = local_5;
        uint _e104 = local_12.inner[1];
        local_12.inner[1] = _e104 + _e102;
        uint _e108 = local_12.inner[0];
        local_13 = static_cast<uint>(_e108);
        uint _e112 = local_12.inner[1];
        local_14 = static_cast<uint>(_e112);
        uint _e115 = local_14;
        out_1[_e115] = naga_f2u32(_e89 * 2.0);
    }
}
