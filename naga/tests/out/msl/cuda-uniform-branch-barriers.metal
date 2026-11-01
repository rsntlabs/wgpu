// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef uint type_1[1];
struct type_2 {
    uint value;
    char _pad1[12];
};
struct type_3 {
    uint inner[4];
};
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct exchangeInput {
};
kernel void exchange(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1 const& input [[user(fake0)]]
, device type_1& output [[user(fake0)]]
, constant type_2& mode [[user(fake0)]]
, threadgroup type_3& values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint local = {};
    uint transformed = {};
    uint local_1 = {};
    uint mode_1 = mode.value;
    uint lane = threadIdx.x;
    uint base = blockIdx.x * 4u;
    local = static_cast<uint>(base + lane);
    uint _e12 = local;
    uint _e15 = input[_e12];
    values.inner[lane] = _e15;
    if (mode_1 != 0u) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e25 = values.inner[naga_mod(lane + 1u, 4u)];
        transformed = _e25 + 10u;
    } else {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        uint _e34 = values.inner[naga_mod(lane + 2u, 4u)];
        transformed = _e34 + 20u;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e39 = transformed;
    values.inner[lane] = _e39;
    switch(naga_mod(blockIdx.x + mode_1, 3u)) {
        case 0u: {
            metal::threadgroup_barrier(metal::mem_flags::mem_device);
            metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
            uint _e46 = values.inner[lane];
            values.inner[lane] = _e46 + 1u;
            break;
        }
        case 1u: {
            metal::threadgroup_barrier(metal::mem_flags::mem_device);
            metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
            uint _e50 = values.inner[lane];
            values.inner[lane] = _e50 * 2u;
            metal::threadgroup_barrier(metal::mem_flags::mem_device);
            metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
            uint _e54 = values.inner[lane];
            values.inner[lane] = _e54 + 3u;
            break;
        }
        default: {
            metal::threadgroup_barrier(metal::mem_flags::mem_device);
            metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
            uint _e58 = values.inner[lane];
            values.inner[lane] = _e58 + 3u;
            break;
        }
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint _e66 = values.inner[naga_mod(lane + 3u, 4u)];
    local_1 = static_cast<uint>(base + lane);
    uint _e70 = local_1;
    output[_e70] = _e66;
}
