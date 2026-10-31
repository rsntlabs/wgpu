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
    uint lane = threadIdx.x;
    uint base = blockIdx.x * 256u;
    values.inner[lane] = ((blockIdx.x * 2000u) + lane) + 7u;
    type_4 _e25 = out;
    local = _e25;
    local_1 = static_cast<uint>(base + lane);
    type_4 _e30 = local;
    local_11 = _e30;
    uint _e32 = local_1;
    uint _e34 = local_11.inner[1];
    local_11.inner[1] = _e34 + _e32;
    uint _e38 = local_11.inner[0];
    local_12 = static_cast<uint>(_e38);
    uint _e42 = local_11.inner[1];
    local_13 = static_cast<uint>(_e42);
    uint _e45 = local_13;
    out_1[_e45] = (blockIdx.x * 1000u) + lane;
    if (lane == 0u) {
        broadcast = (blockIdx.x * 100u) + 11u;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e59 = values.inner[63u - lane];
    type_4 _e60 = out;
    local_2 = _e60;
    local_3 = static_cast<uint>((base + 64u) + lane);
    type_4 _e67 = local_2;
    local_14 = _e67;
    uint _e69 = local_3;
    uint _e71 = local_14.inner[1];
    local_14.inner[1] = _e71 + _e69;
    uint _e75 = local_14.inner[0];
    local_15 = static_cast<uint>(_e75);
    uint _e79 = local_14.inner[1];
    local_16 = static_cast<uint>(_e79);
    uint _e82 = local_16;
    out_1[_e82] = _e59;
    type_4 _e84 = out;
    local_6 = _e84;
    local_7 = static_cast<uint>(base + naga_mod(lane + 1u, 64u));
    type_4 _e93 = local_6;
    local_17 = _e93;
    uint _e95 = local_7;
    uint _e97 = local_17.inner[1];
    local_17.inner[1] = _e97 + _e95;
    uint _e101 = local_17.inner[0];
    local_18 = static_cast<uint>(_e101);
    uint _e105 = local_17.inner[1];
    local_19 = static_cast<uint>(_e105);
    uint _e108 = local_19;
    uint _e110 = out_1[_e108];
    local_20 = _e110;
    uint _e112 = local_20;
    local_10 = _e112;
    uint _e114 = local_10;
    type_4 _e115 = out;
    local_4 = _e115;
    local_5 = static_cast<uint>((base + 128u) + lane);
    type_4 _e122 = local_4;
    local_21 = _e122;
    uint _e124 = local_5;
    uint _e126 = local_21.inner[1];
    local_21.inner[1] = _e126 + _e124;
    uint _e130 = local_21.inner[0];
    local_22 = static_cast<uint>(_e130);
    uint _e134 = local_21.inner[1];
    local_23 = static_cast<uint>(_e134);
    uint _e137 = local_23;
    out_1[_e137] = _e114;
    uint _e140 = broadcast;
    type_4 _e141 = out;
    local_8 = _e141;
    local_9 = static_cast<uint>((base + 192u) + lane);
    type_4 _e148 = local_8;
    local_24 = _e148;
    uint _e150 = local_9;
    uint _e152 = local_24.inner[1];
    local_24.inner[1] = _e152 + _e150;
    uint _e156 = local_24.inner[0];
    local_25 = static_cast<uint>(_e156);
    uint _e160 = local_24.inner[1];
    local_26 = static_cast<uint>(_e160);
    uint _e163 = local_26;
    out_1[_e163] = _e140;
}
