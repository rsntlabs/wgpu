// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct float3_ {
    float x;
    float y;
    float z;
};
typedef float type_1[1];
struct type_3 {
    float3_ inner[8];
};

float3_ shift(
    float3_ value
) {
    float3_ value_1 = {};
    value_1 = value;
    float _e4 = value_1.x;
    value_1.x = _e4 + 1.0;
    float _e9 = value_1.z;
    float _e10 = value_1.y;
    value_1.y = _e9 - _e10;
    float3_ _e12 = value_1;
    return _e12;
}
uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct shared_vectorsInput {
};
kernel void shared_vectors(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, uint __local_invocation_index [[thread_index_in_threadgroup]]
, device type_1& output [[user(fake0)]]
, threadgroup type_3& values
, threadgroup float3_& broadcast
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    if (__local_invocation_index == 0u) {
        values = {};
        broadcast = {};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    float3_ copied = {};
    int offset = {};
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
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint lane = threadIdx.x;
    uint group = blockIdx.x;
    float base = static_cast<float>((group * 16u) + lane);
    values.inner[lane] = float3_ {base + 0.5, -(base) - 1.25, base + 2.5};
    if (lane == 0u) {
        broadcast = float3_ {static_cast<float>(group) + 0.25, static_cast<float>(group) + 0.5, static_cast<float>(group) + 0.75};
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    uint next = naga_mod(lane + 1u, 8u);
    float3_ _e36 = values.inner[next];
    float3_ _e37 = shift(_e36);
    copied = _e37;
    {
        offset = 1;
        int _e41 = offset;
        float _e43 = copied.x;
        copied.x = _e43 + static_cast<float>(_e41);
    }
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    bool choose_shared = (lane & 1u) != 0u;
    float _e52 = broadcast.x;
    if (choose_shared) {
        float _e55 = values.inner[lane].y;
        values.inner[lane].y = _e55 + _e52;
    } else {
        float _e58 = copied.y;
        copied.y = _e58 + _e52;
    }
    float _e61 = copied.x;
    values.inner[lane].z = _e61;
    uint row = ((group * 8u) + lane) * 9u;
    float _e70 = copied.x;
    local = static_cast<uint>(row);
    uint _e73 = local;
    local_9 = static_cast<uint>(_e73);
    uint _e76 = local_9;
    output[_e76] = _e70;
    float _e80 = copied.y;
    local_1 = static_cast<uint>(row + 1u);
    uint _e85 = local_1;
    local_10 = static_cast<uint>(_e85);
    uint _e88 = local_10;
    output[_e88] = _e80;
    float _e91 = copied.z;
    local_2 = static_cast<uint>(row + 2u);
    uint _e96 = local_2;
    local_11 = static_cast<uint>(_e96);
    uint _e99 = local_11;
    output[_e99] = _e91;
    metal::threadgroup_barrier(metal::mem_flags::mem_device);
    metal::threadgroup_barrier(metal::mem_flags::mem_threadgroup);
    float _e103 = values.inner[next].x;
    local_3 = static_cast<uint>(row + 3u);
    uint _e108 = local_3;
    local_12 = static_cast<uint>(_e108);
    uint _e111 = local_12;
    output[_e111] = _e103;
    float _e115 = values.inner[next].y;
    local_4 = static_cast<uint>(row + 4u);
    uint _e120 = local_4;
    local_13 = static_cast<uint>(_e120);
    uint _e123 = local_13;
    output[_e123] = _e115;
    float _e127 = values.inner[next].z;
    local_5 = static_cast<uint>(row + 5u);
    uint _e132 = local_5;
    local_14 = static_cast<uint>(_e132);
    uint _e135 = local_14;
    output[_e135] = _e127;
    float _e138 = broadcast.x;
    local_6 = static_cast<uint>(row + 6u);
    uint _e143 = local_6;
    local_15 = static_cast<uint>(_e143);
    uint _e146 = local_15;
    output[_e146] = _e138;
    float _e149 = broadcast.y;
    local_7 = static_cast<uint>(row + 7u);
    uint _e154 = local_7;
    local_16 = static_cast<uint>(_e154);
    uint _e157 = local_16;
    output[_e157] = _e149;
    float _e160 = broadcast.z;
    local_8 = static_cast<uint>(row + 8u);
    uint _e165 = local_8;
    local_17 = static_cast<uint>(_e165);
    uint _e168 = local_17;
    output[_e168] = _e160;
}
