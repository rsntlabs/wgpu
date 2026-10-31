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
, device type_1& out_1 [[user(fake0)]]
, threadgroup type_2& values
, threadgroup uint& broadcast
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        values = {};
        broadcast = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_4 out = {};
    uint lane = {};
    uint base = {};
    type_4 local = {};
    uint local_1 = {};
    type_4 local_2 = {};
    uint local_3 = {};
    type_4 local_4 = {};
    uint local_5 = {};
    type_4 local_6 = {};
    uint local_7 = {};
    type_4 local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    type_4 local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    type_4 local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    type_4 local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    type_4 local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    type_4 local_24 = {};
    uint local_25 = {};
    uint local_26 = {};
    out = type_4 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    lane = threadIdx.x;
    base = blockIdx.x * 256u;
    uint _e18 = lane;
    uint _e22 = lane;
    values.inner[_e22] = ((blockIdx.x * 2000u) + _e18) + 7u;
    uint _e28 = lane;
    type_4 _e32 = out;
    local = _e32;
    uint _e33 = base;
    uint _e34 = lane;
    local_1 = static_cast<uint>(_e33 + _e34);
    type_4 _e39 = local;
    local_11 = _e39;
    uint _e40 = local_1;
    uint _e42 = local_11.inner[1];
    local_11.inner[1] = _e42 + _e40;
    uint _e46 = local_11.inner[0];
    local_12 = static_cast<uint>(_e46);
    uint _e50 = local_11.inner[1];
    local_13 = static_cast<uint>(_e50);
    uint _e53 = local_13;
    out_1[_e53] = (blockIdx.x * 1000u) + _e28;
    uint _e55 = lane;
    if (_e55 == 0u) {
        broadcast = (blockIdx.x * 100u) + 11u;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e64 = lane;
    uint _e68 = values.inner[63u - _e64];
    type_4 _e70 = out;
    local_2 = _e70;
    uint _e71 = base;
    uint _e74 = lane;
    local_3 = static_cast<uint>((_e71 + 64u) + _e74);
    type_4 _e79 = local_2;
    local_14 = _e79;
    uint _e80 = local_3;
    uint _e82 = local_14.inner[1];
    local_14.inner[1] = _e82 + _e80;
    uint _e86 = local_14.inner[0];
    local_15 = static_cast<uint>(_e86);
    uint _e90 = local_14.inner[1];
    local_16 = static_cast<uint>(_e90);
    uint _e93 = local_16;
    out_1[_e93] = _e68;
    type_4 _e96 = out;
    local_6 = _e96;
    uint _e97 = lane;
    uint _e102 = base;
    local_7 = static_cast<uint>(_e102 + naga_mod(_e97 + 1u, 64u));
    type_4 _e107 = local_6;
    local_17 = _e107;
    uint _e108 = local_7;
    uint _e110 = local_17.inner[1];
    local_17.inner[1] = _e110 + _e108;
    uint _e114 = local_17.inner[0];
    local_18 = static_cast<uint>(_e114);
    uint _e118 = local_17.inner[1];
    local_19 = static_cast<uint>(_e118);
    uint _e122 = local_19;
    uint _e124 = out_1[_e122];
    local_20 = _e124;
    uint _e125 = local_20;
    local_10 = _e125;
    uint _e127 = local_10;
    type_4 _e129 = out;
    local_4 = _e129;
    uint _e130 = base;
    uint _e133 = lane;
    local_5 = static_cast<uint>((_e130 + 128u) + _e133);
    type_4 _e138 = local_4;
    local_21 = _e138;
    uint _e139 = local_5;
    uint _e141 = local_21.inner[1];
    local_21.inner[1] = _e141 + _e139;
    uint _e145 = local_21.inner[0];
    local_22 = static_cast<uint>(_e145);
    uint _e149 = local_21.inner[1];
    local_23 = static_cast<uint>(_e149);
    uint _e152 = local_23;
    out_1[_e152] = _e127;
    uint _e155 = broadcast;
    type_4 _e157 = out;
    local_8 = _e157;
    uint _e158 = base;
    uint _e161 = lane;
    local_9 = static_cast<uint>((_e158 + 192u) + _e161);
    type_4 _e166 = local_8;
    local_24 = _e166;
    uint _e167 = local_9;
    uint _e169 = local_24.inner[1];
    local_24.inner[1] = _e169 + _e167;
    uint _e173 = local_24.inner[0];
    local_25 = static_cast<uint>(_e173);
    uint _e177 = local_24.inner[1];
    local_26 = static_cast<uint>(_e177);
    uint _e180 = local_26;
    out_1[_e180] = _e155;
}
