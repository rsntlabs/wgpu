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
    uint lane = threadIdx.x;
    uint base = blockIdx.x * 256u;
    values.inner[lane] = ((blockIdx.x * 2000u) + lane) + 7u;
    local = static_cast<uint>(base + lane);
    uint _e21 = local;
    local_6 = static_cast<uint>(_e21);
    uint _e24 = local_6;
    out[_e24] = (blockIdx.x * 1000u) + lane;
    if (lane == 0u) {
        broadcast = (blockIdx.x * 100u) + 11u;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e38 = values.inner[63u - lane];
    local_1 = static_cast<uint>((base + 64u) + lane);
    uint _e44 = local_1;
    local_7 = static_cast<uint>(_e44);
    uint _e47 = local_7;
    out[_e47] = _e38;
    local_3 = static_cast<uint>(base + naga_mod(lane + 1u, 64u));
    uint _e56 = local_3;
    local_8 = static_cast<uint>(_e56);
    uint _e59 = local_8;
    uint _e61 = out[_e59];
    local_9 = _e61;
    uint _e63 = local_9;
    local_5 = _e63;
    uint _e65 = local_5;
    local_2 = static_cast<uint>((base + 128u) + lane);
    uint _e71 = local_2;
    local_10 = static_cast<uint>(_e71);
    uint _e74 = local_10;
    out[_e74] = _e65;
    uint _e77 = broadcast;
    local_4 = static_cast<uint>((base + 192u) + lane);
    uint _e83 = local_4;
    local_11 = static_cast<uint>(_e83);
    uint _e86 = local_11;
    out[_e86] = _e77;
}
