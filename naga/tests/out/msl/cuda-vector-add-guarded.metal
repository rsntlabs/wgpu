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
, constant type_3& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_5 a = {};
    type_5 b = {};
    type_5 out = {};
    uint n = {};
    uint i = {};
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
    uint _e25 = n_1.value;
    n = _e25;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e33 = i;
    uint _e34 = n;
    if (_e33 < _e34) {
        type_5 _e38 = a;
        local_2 = _e38;
        uint _e39 = i;
        local_3 = static_cast<uint>(_e39);
        type_5 _e44 = b;
        local_4 = _e44;
        uint _e45 = i;
        local_5 = static_cast<uint>(_e45);
        type_5 _e49 = local_4;
        local_8 = _e49;
        uint _e50 = local_5;
        uint _e52 = local_8.inner[1];
        local_8.inner[1] = _e52 + _e50;
        uint _e56 = local_8.inner[0];
        local_9 = static_cast<uint>(_e56);
        uint _e60 = local_8.inner[1];
        local_10 = static_cast<uint>(_e60);
        uint _e64 = local_10;
        float _e66 = b_1[_e64];
        local_11 = _e66;
        float _e67 = local_11;
        local_6 = _e67;
        float _e69 = local_6;
        type_5 _e73 = local_2;
        local_12 = _e73;
        uint _e74 = local_3;
        uint _e76 = local_12.inner[1];
        local_12.inner[1] = _e76 + _e74;
        uint _e80 = local_12.inner[0];
        local_13 = static_cast<uint>(_e80);
        uint _e84 = local_12.inner[1];
        local_14 = static_cast<uint>(_e84);
        uint _e88 = local_14;
        float _e90 = a_1[_e88];
        local_15 = _e90;
        float _e91 = local_15;
        local_7 = _e91;
        float _e93 = local_7;
        type_5 _e97 = out;
        local = _e97;
        uint _e98 = i;
        local_1 = static_cast<uint>(_e98);
        type_5 _e102 = local;
        local_16 = _e102;
        uint _e103 = local_1;
        uint _e105 = local_16.inner[1];
        local_16.inner[1] = _e105 + _e103;
        uint _e109 = local_16.inner[0];
        local_17 = static_cast<uint>(_e109);
        uint _e113 = local_16.inner[1];
        local_18 = static_cast<uint>(_e113);
        uint _e116 = local_18;
        out_1[_e116] = _e93 + (_e69 * 2.0);
    }
}
