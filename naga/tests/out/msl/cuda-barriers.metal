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
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    local = 0u;
    lane = threadIdx.x;
    base = blockIdx.x * 256u;
    uint _e13 = lane;
    uint _e17 = lane;
    values.inner[_e17] = ((blockIdx.x * 2000u) + _e13) + 7u;
    uint _e23 = lane;
    uint _e25 = local;
    local_1 = _e25;
    uint _e27 = local_1;
    local_2 = static_cast<uint>(_e27);
    uint _e30 = base;
    uint _e31 = lane;
    local_3 = static_cast<uint>(_e30 + _e31);
    uint _e36 = local_2;
    uint _e37 = local_3;
    local_16 = static_cast<uint>(_e36 + _e37);
    uint _e41 = local_16;
    out[_e41] = (blockIdx.x * 1000u) + _e23;
    uint _e43 = lane;
    if (_e43 == 0u) {
        broadcast = (blockIdx.x * 100u) + 11u;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e52 = lane;
    uint _e56 = values.inner[63u - _e52];
    uint _e57 = local;
    local_4 = _e57;
    uint _e59 = local_4;
    local_5 = static_cast<uint>(_e59);
    uint _e62 = base;
    uint _e65 = lane;
    local_6 = static_cast<uint>((_e62 + 64u) + _e65);
    uint _e69 = local_5;
    uint _e70 = local_6;
    local_17 = static_cast<uint>(_e69 + _e70);
    uint _e74 = local_17;
    out[_e74] = _e56;
    uint _e76 = local;
    local_10 = _e76;
    uint _e78 = local_10;
    local_11 = static_cast<uint>(_e78);
    uint _e81 = lane;
    uint _e86 = base;
    local_12 = static_cast<uint>(_e86 + naga_mod(_e81 + 1u, 64u));
    uint _e90 = local_11;
    uint _e91 = local_12;
    local_18 = static_cast<uint>(_e90 + _e91);
    uint _e96 = local_18;
    uint _e98 = out[_e96];
    local_19 = _e98;
    uint _e99 = local_19;
    uint _e100 = local;
    local_7 = _e100;
    uint _e102 = local_7;
    local_8 = static_cast<uint>(_e102);
    uint _e105 = base;
    uint _e108 = lane;
    local_9 = static_cast<uint>((_e105 + 128u) + _e108);
    uint _e112 = local_8;
    uint _e113 = local_9;
    local_20 = static_cast<uint>(_e112 + _e113);
    uint _e117 = local_20;
    out[_e117] = _e99;
    uint _e120 = broadcast;
    uint _e121 = local;
    local_13 = _e121;
    uint _e123 = local_13;
    local_14 = static_cast<uint>(_e123);
    uint _e126 = base;
    uint _e129 = lane;
    local_15 = static_cast<uint>((_e126 + 192u) + _e129);
    uint _e133 = local_14;
    uint _e134 = local_15;
    local_21 = static_cast<uint>(_e133 + _e134);
    uint _e138 = local_21;
    out[_e138] = _e120;
}
