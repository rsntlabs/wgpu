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
struct type_3 {
    uint value;
    char _pad1[12];
};
struct type_5 {
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
, constant type_3& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_5 a = {};
    type_5 b = {};
    type_5 out = {};
    type_5 local = {};
    uint local_1 = {};
    type_5 local_2 = {};
    uint local_3 = {};
    type_5 local_4 = {};
    uint local_5 = {};
    float local_6 = {};
    float local_7 = {};
    type_5 local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    float local_11 = {};
    type_5 local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    float local_15 = {};
    type_5 local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    a = type_5 {};
    a.inner[0] = 0u;
    a.inner[1] = 0u;
    b = type_5 {};
    b.inner[0] = 1u;
    b.inner[1] = 0u;
    out = type_5 {};
    out.inner[0] = 2u;
    out.inner[1] = 0u;
    uint n_1 = n.value;
    uint i = (blockIdx.x * 1u) + threadIdx.x;
    if (i < n_1) {
        type_5 _e30 = a;
        local_2 = _e30;
        local_3 = static_cast<uint>(i);
        type_5 _e35 = b;
        local_4 = _e35;
        local_5 = static_cast<uint>(i);
        type_5 _e39 = local_2;
        local_8 = _e39;
        uint _e41 = local_3;
        uint _e43 = local_8.inner[1];
        local_8.inner[1] = _e43 + _e41;
        uint _e47 = local_8.inner[0];
        local_9 = static_cast<uint>(_e47);
        uint _e51 = local_8.inner[1];
        local_10 = static_cast<uint>(_e51);
        uint _e54 = local_10;
        float _e57 = a_1[_e54];
        local_11 = _e57;
        float _e59 = local_11;
        local_6 = _e59;
        float _e61 = local_6;
        type_5 _e62 = local_4;
        local_12 = _e62;
        uint _e64 = local_5;
        uint _e66 = local_12.inner[1];
        local_12.inner[1] = _e66 + _e64;
        uint _e70 = local_12.inner[0];
        local_13 = static_cast<uint>(_e70);
        uint _e74 = local_12.inner[1];
        local_14 = static_cast<uint>(_e74);
        uint _e77 = local_14;
        float _e80 = b_1[_e77];
        local_15 = _e80;
        float _e82 = local_15;
        local_7 = _e82;
        float _e84 = local_7;
        type_5 _e87 = out;
        local = _e87;
        local_1 = static_cast<uint>(i);
        type_5 _e91 = local;
        local_16 = _e91;
        uint _e93 = local_1;
        uint _e95 = local_16.inner[1];
        local_16.inner[1] = _e95 + _e93;
        uint _e99 = local_16.inner[0];
        local_17 = static_cast<uint>(_e99);
        uint _e103 = local_16.inner[1];
        local_18 = static_cast<uint>(_e103);
        uint _e106 = local_18;
        out_1[_e106] = _e61 + _e84;
    }
}
