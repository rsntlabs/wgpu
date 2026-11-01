// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_1[1];
struct type_2 {
    uint value;
    char _pad1[12];
};

void synchronize(
) {
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    return;
}

void rounds(
    uint count,
    uint mode
) {
    uint iteration = {};
    {
        iteration = 0u;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e8 = iteration;
                iteration = _e8 + static_cast<uint>(1);
            }
            loop_init = false;
            uint _e4 = iteration;
            if (_e4 < count) {
            } else {
                break;
            }
            if (mode != 0u) {
                metal::threadgroup_barrier(metal::mem_flags::mem_device);
                metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
            } else {
                metal::threadgroup_barrier(metal::mem_flags::mem_device);
                metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
            }
        }
        return;
    }
}

uint finish(
    uint lane
) {
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    if ((lane & 1u) != 0u) {
        return lane + 100u;
    }
    return lane + 200u;
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct exchangeInput {
};
kernel void exchange(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, device type_1& output [[user(fake0)]]
, constant type_2& mode_1 [[user(fake0)]]
, constant type_2& count_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint mode_2 = mode_1.value;
    uint count_2 = count_1.value;
    uint lane_1 = threadIdx.x;
    uint base = blockIdx.x * 12u;
    local = static_cast<uint>(base + lane_1);
    uint _e21 = local;
    output[_e21] = ((blockIdx.x * 10u) + lane_1) + 1u;
    synchronize();
    local_1 = static_cast<uint>(base + naga_mod(lane_1 + 1u, 4u));
    uint _e31 = local_1;
    uint next = output[_e31];
    synchronize();
    local_2 = static_cast<uint>(base + lane_1);
    uint _e39 = local_2;
    output[_e39] = next + 10u;
    rounds(count_2, mode_2);
    local_4 = static_cast<uint>(base + naga_mod(lane_1 + 1u, 4u));
    uint _e48 = local_4;
    uint _e50 = output[_e48];
    local_3 = static_cast<uint>((base + 4u) + lane_1);
    uint _e56 = local_3;
    output[_e56] = _e50;
    uint _e58 = finish(lane_1);
    local_5 = static_cast<uint>((base + 8u) + lane_1);
    uint _e64 = local_5;
    output[_e64] = _e58;
    synchronize();
}
