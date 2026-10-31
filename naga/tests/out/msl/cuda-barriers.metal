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
    uint lane = threadIdx.x;
    uint base = blockIdx.x * 256u;
    values.inner[lane] = ((blockIdx.x * 2000u) + lane) + 7u;
    local = static_cast<uint>(base + lane);
    uint _e21 = local;
    out[_e21] = (blockIdx.x * 1000u) + lane;
    if (lane == 0u) {
        broadcast = (blockIdx.x * 100u) + 11u;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e35 = values.inner[63u - lane];
    local_1 = static_cast<uint>((base + 64u) + lane);
    uint _e41 = local_1;
    out[_e41] = _e35;
    local_3 = static_cast<uint>(base + naga_mod(lane + 1u, 64u));
    uint _e50 = local_3;
    uint _e52 = out[_e50];
    local_2 = static_cast<uint>((base + 128u) + lane);
    uint _e58 = local_2;
    out[_e58] = _e52;
    uint _e61 = broadcast;
    local_4 = static_cast<uint>((base + 192u) + lane);
    uint _e67 = local_4;
    out[_e67] = _e61;
}
