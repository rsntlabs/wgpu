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
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint i = (blockIdx.x * 1u) + threadIdx.x;
    local_1 = static_cast<uint>(i);
    local_2 = static_cast<uint>(i);
    uint _e11 = local_2;
    local_3 = static_cast<uint>(_e11);
    uint _e14 = local_3;
    float _e17 = b[_e14];
    uint _e20 = local_1;
    local_4 = static_cast<uint>(_e20);
    uint _e23 = local_4;
    float _e26 = a[_e23];
    local = static_cast<uint>(i);
    uint _e30 = local;
    local_5 = static_cast<uint>(_e30);
    uint _e33 = local_5;
    out[_e33] = _e26 + (_e17 * 2.0);
}
