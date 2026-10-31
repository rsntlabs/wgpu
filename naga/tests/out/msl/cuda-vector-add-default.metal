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
, device type_1 const& a [[user(fake0)]]
, device type_1 const& b [[user(fake0)]]
, device type_1& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_4 local = {};
    type_4 local_1 = {};
    type_4 local_2 = {};
    uint i = {};
    type_4 local_3 = {};
    uint local_4 = {};
    type_4 local_5 = {};
    uint local_6 = {};
    type_4 local_7 = {};
    uint local_8 = {};
    float local_9 = {};
    float local_10 = {};
    type_4 local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    float local_14 = {};
    type_4 local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    float local_18 = {};
    type_4 local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    local = type_4 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    local_1 = type_4 {};
    local_1.inner[0] = 1u;
    local_1.inner[1] = 0u;
    local_2 = type_4 {};
    local_2.inner[0] = 2u;
    local_2.inner[1] = 0u;
    i = (blockIdx.x * 1u) + threadIdx.x;
    type_4 _e31 = local;
    local_5 = _e31;
    uint _e32 = i;
    local_6 = static_cast<uint>(_e32);
    type_4 _e37 = local_1;
    local_7 = _e37;
    uint _e38 = i;
    local_8 = static_cast<uint>(_e38);
    type_4 _e42 = local_7;
    local_11 = _e42;
    uint _e43 = local_8;
    uint _e45 = local_11.inner[1];
    local_11.inner[1] = _e45 + _e43;
    uint _e49 = local_11.inner[0];
    local_12 = static_cast<uint>(_e49);
    uint _e53 = local_11.inner[1];
    local_13 = static_cast<uint>(_e53);
    uint _e57 = local_13;
    float _e59 = b[_e57];
    local_14 = _e59;
    float _e60 = local_14;
    local_9 = _e60;
    float _e62 = local_9;
    type_4 _e66 = local_5;
    local_15 = _e66;
    uint _e67 = local_6;
    uint _e69 = local_15.inner[1];
    local_15.inner[1] = _e69 + _e67;
    uint _e73 = local_15.inner[0];
    local_16 = static_cast<uint>(_e73);
    uint _e77 = local_15.inner[1];
    local_17 = static_cast<uint>(_e77);
    uint _e81 = local_17;
    float _e83 = a[_e81];
    local_18 = _e83;
    float _e84 = local_18;
    local_10 = _e84;
    float _e86 = local_10;
    type_4 _e90 = local_2;
    local_3 = _e90;
    uint _e91 = i;
    local_4 = static_cast<uint>(_e91);
    type_4 _e95 = local_3;
    local_19 = _e95;
    uint _e96 = local_4;
    uint _e98 = local_19.inner[1];
    local_19.inner[1] = _e98 + _e96;
    uint _e102 = local_19.inner[0];
    local_20 = static_cast<uint>(_e102);
    uint _e106 = local_19.inner[1];
    local_21 = static_cast<uint>(_e106);
    uint _e109 = local_21;
    out[_e109] = _e86 + (_e62 * 2.0);
}
