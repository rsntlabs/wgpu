// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_1[1];
struct dim3_ {
    uint x;
    uint y;
    uint z;
};
struct type_3 {
    uint inner[4];
};

void synchronize(
    metal::uint3 blockIdx_1,
    metal::uint3 gridDim_1
) {
    if (dim3_ {blockIdx_1.x, blockIdx_1.y, blockIdx_1.z}.x < gridDim_1.x) {
        metal::threadgroup_barrier(metal::mem_flags::mem_device);
        metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        return;
    } else {
        return;
    }
}

uint naga_div(uint lhs, uint rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}

uint reduce(
    uint input,
    uint width,
    metal::uint3 blockIdx_2,
    metal::uint3 gridDim_2,
    thread metal::uint3& threadIdx_1,
    threadgroup type_3& values
) {
    uint stride = {};
    metal::uint3 _e5 = threadIdx_1;
    uint lane = _e5.x + (4u * (_e5.y + (1u * _e5.z)));
    values.inner[lane] = input;
    synchronize(blockIdx_2, gridDim_2);
    {
        stride = naga_div(width, 2u);
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e34 = stride;
                stride = _e34 >> 1u;
            }
            loop_init = false;
            uint _e20 = stride;
            if (_e20 > 0u) {
            } else {
                break;
            }
            uint _e23 = stride;
            if (lane < _e23) {
                uint _e25 = stride;
                uint _e29 = values.inner[lane + _e25];
                uint _e32 = values.inner[lane];
                values.inner[lane] = _e32 + _e29;
            }
            metal::threadgroup_barrier(metal::mem_flags::mem_device);
            metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        }
    }
    uint _e40 = values.inner[0];
    return _e40;
}

struct exchangeInput {
};
kernel void exchange(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 gridDim [[threadgroups_per_grid]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& output [[user(fake0)]]
, threadgroup type_3& values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    metal::uint3 blockIdx_3 = {};
    metal::uint3 gridDim_3 = {};
    metal::uint3 threadIdx_1 = {};
    if (__local_invocation_index == 0u) {
        values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint local = {};
    uint local_1 = {};
    threadIdx_1 = threadIdx;
    blockIdx_3 = blockIdx;
    gridDim_3 = gridDim;
    uint lane_1 = threadIdx.x + (4u * (threadIdx.y + (1u * threadIdx.z)));
    uint value = ((blockIdx.x * 10u) + lane_1) + 1u;
    uint _e22 = reduce(value, 4u, blockIdx, gridDim, threadIdx_1, values);
    uint base = blockIdx.x * 8u;
    local = static_cast<uint>(base + lane_1);
    uint _e29 = local;
    output[_e29] = _e22;
    local_1 = static_cast<uint>((base + 4u) + lane_1);
    uint _e42 = local_1;
    output[_e42] = ((value * 10u) + lane_1) + 4u;
}
