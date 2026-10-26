// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size2;
};

typedef float type_1[1];

struct addInput {
};
kernel void add(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& a [[user(fake0)]]
, device type_1 const& b [[user(fake0)]]
, device type_1& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint i = {};
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
    float local_13 = {};
    uint local_14 = {};
    float local_15 = {};
    uint local_16 = {};
    local = 0u;
    local_1 = 0u;
    local_2 = 0u;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e14 = local;
    local_6 = _e14;
    uint _e16 = local_6;
    local_7 = static_cast<uint>(_e16);
    uint _e19 = i;
    local_8 = static_cast<uint>(_e19);
    uint _e22 = local_1;
    local_9 = _e22;
    uint _e24 = local_9;
    local_10 = static_cast<uint>(_e24);
    uint _e27 = i;
    local_11 = static_cast<uint>(_e27);
    uint _e31 = local_10;
    uint _e32 = local_11;
    local_12 = static_cast<uint>(_e31 + _e32);
    uint _e37 = local_12;
    float _e39 = b[_e37];
    local_13 = _e39;
    float _e40 = local_13;
    uint _e44 = local_7;
    uint _e45 = local_8;
    local_14 = static_cast<uint>(_e44 + _e45);
    uint _e50 = local_14;
    float _e52 = a[_e50];
    local_15 = _e52;
    float _e53 = local_15;
    uint _e55 = local_2;
    local_3 = _e55;
    uint _e57 = local_3;
    local_4 = static_cast<uint>(_e57);
    uint _e60 = i;
    local_5 = static_cast<uint>(_e60);
    uint _e64 = local_4;
    uint _e65 = local_5;
    local_16 = static_cast<uint>(_e64 + _e65);
    uint _e69 = local_16;
    out[_e69] = _e53 + (_e40 * 2.0);
}
