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
    float local_3 = {};
    float local_4 = {};
    uint local_5 = {};
    float local_6 = {};
    uint local_7 = {};
    float local_8 = {};
    uint local_9 = {};
    uint i = (blockIdx.x * 1u) + threadIdx.x;
    local_1 = static_cast<uint>(i);
    local_2 = static_cast<uint>(i);
    uint _e11 = local_2;
    local_5 = static_cast<uint>(_e11);
    uint _e14 = local_5;
    float _e17 = b[_e14];
    local_6 = _e17;
    float _e19 = local_6;
    local_3 = _e19;
    float _e21 = local_3;
    uint _e24 = local_1;
    local_7 = static_cast<uint>(_e24);
    uint _e27 = local_7;
    float _e30 = a[_e27];
    local_8 = _e30;
    float _e32 = local_8;
    local_4 = _e32;
    float _e34 = local_4;
    local = static_cast<uint>(i);
    uint _e38 = local;
    local_9 = static_cast<uint>(_e38);
    uint _e41 = local_9;
    out[_e41] = _e34 + (_e21 * 2.0);
}
