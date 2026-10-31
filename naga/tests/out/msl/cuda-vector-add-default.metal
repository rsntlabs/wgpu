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
    uint i = (blockIdx.x * 1u) + threadIdx.x;
    type_4 _e26 = a;
    local_2 = _e26;
    local_3 = static_cast<uint>(i);
    type_4 _e31 = b;
    local_4 = _e31;
    local_5 = static_cast<uint>(i);
    type_4 _e35 = local_4;
    local_8 = _e35;
    uint _e37 = local_5;
    uint _e39 = local_8.inner[1];
    local_8.inner[1] = _e39 + _e37;
    uint _e43 = local_8.inner[0];
    local_9 = static_cast<uint>(_e43);
    uint _e47 = local_8.inner[1];
    local_10 = static_cast<uint>(_e47);
    uint _e50 = local_10;
    float _e53 = b_1[_e50];
    local_11 = _e53;
    float _e55 = local_11;
    local_6 = _e55;
    float _e57 = local_6;
    type_4 _e60 = local_2;
    local_12 = _e60;
    uint _e62 = local_3;
    uint _e64 = local_12.inner[1];
    local_12.inner[1] = _e64 + _e62;
    uint _e68 = local_12.inner[0];
    local_13 = static_cast<uint>(_e68);
    uint _e72 = local_12.inner[1];
    local_14 = static_cast<uint>(_e72);
    uint _e75 = local_14;
    float _e78 = a_1[_e75];
    local_15 = _e78;
    float _e80 = local_15;
    local_7 = _e80;
    float _e82 = local_7;
    type_4 _e85 = out;
    local = _e85;
    local_1 = static_cast<uint>(i);
    type_4 _e89 = local;
    local_16 = _e89;
    uint _e91 = local_1;
    uint _e93 = local_16.inner[1];
    local_16.inner[1] = _e93 + _e91;
    uint _e97 = local_16.inner[0];
    local_17 = static_cast<uint>(_e97);
    uint _e101 = local_16.inner[1];
    local_18 = static_cast<uint>(_e101);
    uint _e104 = local_18;
    out_1[_e104] = _e82 + (_e57 * 2.0);
}
