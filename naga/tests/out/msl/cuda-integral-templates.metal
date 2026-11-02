// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size3;
    uint size4;
};

typedef uint type_1[1];
struct type_2 {
    uint inner[4];
};
struct type_4 {
    uint inner[8];
};

uint adjusted_4_(
    uint value
) {
    return value + static_cast<uint>(4);
}

uint adjusted_8_(
    uint value_1
) {
    return value_1 + static_cast<uint>(8);
}

struct reduce_4_Input {
};
kernel void reduce_4_(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& output [[user(fake0)]]
, device type_1 const& input [[user(fake0)]]
, threadgroup type_2& values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint local = {};
    uint stride = {};
    uint local_1 = {};
    uint lane = threadIdx.x;
    uint base = blockIdx.x * 4u;
    local = static_cast<uint>(base + lane);
    uint _e9 = local;
    uint _e12 = input[_e9];
    values.inner[lane] = _e12;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    {
        stride = 2u;
        uint2 loop_bound = uint2(4294967295u);
        bool loop_init = true;
        while(true) {
            if (metal::all(loop_bound == uint2(0u))) { break; }
            loop_bound -= uint2(loop_bound.y == 0u, 1u);
            if (!loop_init) {
                uint _e29 = stride;
                stride = _e29 >> 1u;
            }
            loop_init = false;
            uint _e17 = stride;
            if (_e17 > 0u) {
            } else {
                break;
            }
            uint _e20 = stride;
            if (lane < _e20) {
                uint _e22 = stride;
                uint _e25 = values.inner[lane + _e22];
                uint _e27 = values.inner[lane];
                values.inner[lane] = _e27 + _e25;
            }
            metal::threadgroup_barrier(metal::mem_flags::mem_device);
            metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        }
    }
    uint _e34 = values.inner[0];
    uint _e35 = adjusted_4_(_e34);
    local_1 = static_cast<uint>(base + lane);
    uint _e39 = local_1;
    output[_e39] = _e35;
}


struct reduce_8_Input {
};
kernel void reduce_8_(
  metal::uint3 threadIdx_1 [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx_1 [[threadgroup_position_in_grid]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& output_1 [[user(fake0)]]
, device type_1 const& input_1 [[user(fake0)]]
, threadgroup type_4& values_1
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        values_1 = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint local_2 = {};
    uint stride_1 = {};
    uint local_3 = {};
    uint lane_1 = threadIdx_1.x;
    uint base_1 = blockIdx_1.x * 4u;
    local_2 = static_cast<uint>(base_1 + lane_1);
    uint _e9 = local_2;
    uint _e12 = input_1[_e9];
    values_1.inner[lane_1] = _e12;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    {
        stride_1 = 2u;
        uint2 loop_bound_1 = uint2(4294967295u);
        bool loop_init_1 = true;
        while(true) {
            if (metal::all(loop_bound_1 == uint2(0u))) { break; }
            loop_bound_1 -= uint2(loop_bound_1.y == 0u, 1u);
            if (!loop_init_1) {
                uint _e29 = stride_1;
                stride_1 = _e29 >> 1u;
            }
            loop_init_1 = false;
            uint _e17 = stride_1;
            if (_e17 > 0u) {
            } else {
                break;
            }
            uint _e20 = stride_1;
            if (lane_1 < _e20) {
                uint _e22 = stride_1;
                uint _e25 = values_1.inner[lane_1 + _e22];
                uint _e27 = values_1.inner[lane_1];
                values_1.inner[lane_1] = _e27 + _e25;
            }
            metal::threadgroup_barrier(metal::mem_flags::mem_device);
            metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
        }
    }
    uint _e34 = values_1.inner[0];
    uint _e35 = adjusted_8_(_e34);
    local_3 = static_cast<uint>(base_1 + lane_1);
    uint _e39 = local_3;
    output_1[_e39] = _e35;
}
