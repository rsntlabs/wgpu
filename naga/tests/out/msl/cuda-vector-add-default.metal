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
struct type_4 {
    uint inner[2];
};

struct addInput {
};
kernel void add(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& a_1 [[user(fake0)]]
, device type_1 const& b_1 [[user(fake0)]]
, device type_1& out_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_4 a = {};
    type_4 b = {};
    type_4 out = {};
    uint i = {};
    type_4 local = {};
    uint local_1 = {};
    type_4 local_2 = {};
    uint local_3 = {};
    type_4 local_4 = {};
    uint local_5 = {};
    float local_6 = {};
    float local_7 = {};
    type_4 local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    float local_11 = {};
    type_4 local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    float local_15 = {};
    type_4 local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    a = type_4 {};
    a.inner[0] = 0u;
    a.inner[1] = 0u;
    b = type_4 {};
    b.inner[0] = 1u;
    b.inner[1] = 0u;
    out = type_4 {};
    out.inner[0] = 2u;
    out.inner[1] = 0u;
    i = (blockIdx.x * 1u) + threadIdx.x;
    type_4 _e31 = a;
    local_2 = _e31;
    uint _e32 = i;
    local_3 = static_cast<uint>(_e32);
    type_4 _e37 = b;
    local_4 = _e37;
    uint _e38 = i;
    local_5 = static_cast<uint>(_e38);
    type_4 _e42 = local_4;
    local_8 = _e42;
    uint _e43 = local_5;
    uint _e45 = local_8.inner[1];
    local_8.inner[1] = _e45 + _e43;
    uint _e49 = local_8.inner[0];
    local_9 = static_cast<uint>(_e49);
    uint _e53 = local_8.inner[1];
    local_10 = static_cast<uint>(_e53);
    uint _e57 = local_10;
    float _e59 = b_1[_e57];
    local_11 = _e59;
    float _e60 = local_11;
    local_6 = _e60;
    float _e62 = local_6;
    type_4 _e66 = local_2;
    local_12 = _e66;
    uint _e67 = local_3;
    uint _e69 = local_12.inner[1];
    local_12.inner[1] = _e69 + _e67;
    uint _e73 = local_12.inner[0];
    local_13 = static_cast<uint>(_e73);
    uint _e77 = local_12.inner[1];
    local_14 = static_cast<uint>(_e77);
    uint _e81 = local_14;
    float _e83 = a_1[_e81];
    local_15 = _e83;
    float _e84 = local_15;
    local_7 = _e84;
    float _e86 = local_7;
    type_4 _e90 = out;
    local = _e90;
    uint _e91 = i;
    local_1 = static_cast<uint>(_e91);
    type_4 _e95 = local;
    local_16 = _e95;
    uint _e96 = local_1;
    uint _e98 = local_16.inner[1];
    local_16.inner[1] = _e98 + _e96;
    uint _e102 = local_16.inner[0];
    local_17 = static_cast<uint>(_e102);
    uint _e106 = local_16.inner[1];
    local_18 = static_cast<uint>(_e106);
    uint _e109 = local_18;
    out_1[_e109] = _e86 + (_e62 * 2.0);
}
