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
struct type_4 {
    uint inner[2];
};
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct barriersInput {
};
kernel void barriers(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, threadgroup type_2& values
, threadgroup uint& broadcast
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        values = {};
        broadcast = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_4 local = {};
    uint lane = {};
    uint base = {};
    type_4 local_1 = {};
    uint local_2 = {};
    type_4 local_3 = {};
    uint local_4 = {};
    type_4 local_5 = {};
    uint local_6 = {};
    type_4 local_7 = {};
    uint local_8 = {};
    type_4 local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    type_4 local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    type_4 local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    type_4 local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    type_4 local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    type_4 local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
    local = type_4 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    lane = threadIdx.x;
    base = blockIdx.x * 256u;
    uint _e18 = lane;
    uint _e22 = lane;
    values.inner[_e22] = ((blockIdx.x * 2000u) + _e18) + 7u;
    uint _e28 = lane;
    type_4 _e32 = local;
    local_1 = _e32;
    uint _e33 = base;
    uint _e34 = lane;
    local_2 = static_cast<uint>(_e33 + _e34);
    type_4 _e39 = local_1;
    local_12 = _e39;
    uint _e40 = local_2;
    uint _e42 = local_12.inner[1];
    local_12.inner[1] = _e42 + _e40;
    uint _e46 = local_12.inner[0];
    local_13 = static_cast<uint>(_e46);
    uint _e50 = local_12.inner[1];
    local_14 = static_cast<uint>(_e50);
    uint _e53 = local_14;
    out[_e53] = (blockIdx.x * 1000u) + _e28;
    uint _e55 = lane;
    if (_e55 == 0u) {
        broadcast = (blockIdx.x * 100u) + 11u;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e64 = lane;
    uint _e68 = values.inner[63u - _e64];
    type_4 _e70 = local;
    local_3 = _e70;
    uint _e71 = base;
    uint _e74 = lane;
    local_4 = static_cast<uint>((_e71 + 64u) + _e74);
    type_4 _e79 = local_3;
    local_15 = _e79;
    uint _e80 = local_4;
    uint _e82 = local_15.inner[1];
    local_15.inner[1] = _e82 + _e80;
    uint _e86 = local_15.inner[0];
    local_16 = static_cast<uint>(_e86);
    uint _e90 = local_15.inner[1];
    local_17 = static_cast<uint>(_e90);
    uint _e93 = local_17;
    out[_e93] = _e68;
    type_4 _e96 = local;
    local_7 = _e96;
    uint _e97 = lane;
    uint _e102 = base;
    local_8 = static_cast<uint>(_e102 + naga_mod(_e97 + 1u, 64u));
    type_4 _e107 = local_7;
    local_18 = _e107;
    uint _e108 = local_8;
    uint _e110 = local_18.inner[1];
    local_18.inner[1] = _e110 + _e108;
    uint _e114 = local_18.inner[0];
    local_19 = static_cast<uint>(_e114);
    uint _e118 = local_18.inner[1];
    local_20 = static_cast<uint>(_e118);
    uint _e122 = local_20;
    uint _e124 = out[_e122];
    local_21 = _e124;
    uint _e125 = local_21;
    local_11 = _e125;
    uint _e127 = local_11;
    type_4 _e129 = local;
    local_5 = _e129;
    uint _e130 = base;
    uint _e133 = lane;
    local_6 = static_cast<uint>((_e130 + 128u) + _e133);
    type_4 _e138 = local_5;
    local_22 = _e138;
    uint _e139 = local_6;
    uint _e141 = local_22.inner[1];
    local_22.inner[1] = _e141 + _e139;
    uint _e145 = local_22.inner[0];
    local_23 = static_cast<uint>(_e145);
    uint _e149 = local_22.inner[1];
    local_24 = static_cast<uint>(_e149);
    uint _e152 = local_24;
    out[_e152] = _e127;
    uint _e155 = broadcast;
    type_4 _e157 = local;
    local_9 = _e157;
    uint _e158 = base;
    uint _e161 = lane;
    local_10 = static_cast<uint>((_e158 + 192u) + _e161);
    type_4 _e166 = local_9;
    local_25 = _e166;
    uint _e167 = local_10;
    uint _e169 = local_25.inner[1];
    local_25.inner[1] = _e169 + _e167;
    uint _e173 = local_25.inner[0];
    local_26 = static_cast<uint>(_e173);
    uint _e177 = local_25.inner[1];
    local_27 = static_cast<uint>(_e177);
    uint _e180 = local_27;
    out[_e180] = _e155;
}
