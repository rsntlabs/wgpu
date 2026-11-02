// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size1;
};

struct type_1 {
    uint inner[4];
};
typedef uint type_2[1];
struct type_4 {
    uint inner[2];
};

void initialize(
    uint index,
    uint value,
    threadgroup type_1& helper_values
) {
    helper_values.inner[index] = value;
    return;
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct exchangeInput {
};
kernel void exchange(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, threadgroup type_1& helper_values
, device type_2& output_1 [[user(fake0)]]
, threadgroup type_1& fixed_values
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        helper_values = {};
        fixed_values = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    type_4 output = {};
    uint neighbor = {};
    type_4 local = {};
    uint local_1 = {};
    type_4 pointer = {};
    type_4 local_2 = {};
    type_4 local_3 = {};
    uint local_4 = {};
    type_4 local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    type_4 local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    type_4 local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    output = type_4 {};
    output.inner[0] = 2u;
    output.inner[1] = 0u;
    uint lane = threadIdx.x;
    uint base = blockIdx.x * 8u;
    initialize(lane, ((blockIdx.x * 10u) + lane) + 1u, helper_values);
    fixed_values.inner[lane] = 100u + lane;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    {
        neighbor = naga_mod(lane + 1u, 4u);
        uint _e27 = neighbor;
        uint _e31 = helper_values.inner[_e27];
        uint _e32 = fixed_values.inner[lane];
        type_4 _e35 = output;
        local = _e35;
        local_1 = static_cast<uint>(base + lane);
        type_4 _e40 = local;
        local_5 = _e40;
        uint _e42 = local_1;
        uint _e44 = local_5.inner[1];
        local_5.inner[1] = _e44 + _e42;
        uint _e48 = local_5.inner[0];
        local_6 = static_cast<uint>(_e48);
        uint _e52 = local_5.inner[1];
        local_7 = static_cast<uint>(_e52);
        uint _e55 = local_7;
        output_1[_e55] = _e31 + _e32;
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    pointer = type_4 {};
    pointer.inner[0] = 3u;
    pointer.inner[1] = 0u;
    type_4 _e65 = pointer;
    local_2 = _e65;
    type_4 _e67 = local_2;
    local_8 = _e67;
    uint _e70 = local_8.inner[1];
    local_8.inner[1] = _e70 + lane;
    uint _e74 = local_8.inner[0];
    local_9 = static_cast<uint>(_e74);
    uint _e78 = local_8.inner[1];
    local_10 = static_cast<uint>(_e78);
    uint _e81 = local_10;
    uint _e84 = helper_values.inner[_e81];
    uint _e88 = local_10;
    helper_values.inner[_e88] = _e84 + static_cast<uint>(1);
    uint _e92 = helper_values.inner[lane];
    type_4 _e93 = output;
    local_3 = _e93;
    local_4 = static_cast<uint>((base + 4u) + lane);
    type_4 _e100 = local_3;
    local_11 = _e100;
    uint _e102 = local_4;
    uint _e104 = local_11.inner[1];
    local_11.inner[1] = _e104 + _e102;
    uint _e108 = local_11.inner[0];
    local_12 = static_cast<uint>(_e108);
    uint _e112 = local_11.inner[1];
    local_13 = static_cast<uint>(_e112);
    uint _e115 = local_13;
    output_1[_e115] = _e92;
}
