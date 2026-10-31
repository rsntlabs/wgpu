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
, device type_1 const& a [[user(fake0)]]
, device type_1 const& b [[user(fake0)]]
, device type_1& out [[user(fake0)]]
, constant type_3& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_5 local = {};
    type_5 local_1 = {};
    type_5 local_2 = {};
    uint n = {};
    uint i = {};
    type_5 local_3 = {};
    uint local_4 = {};
    type_5 local_5 = {};
    uint local_6 = {};
    type_5 local_7 = {};
    uint local_8 = {};
    float local_9 = {};
    float local_10 = {};
    type_5 local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    float local_14 = {};
    type_5 local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    float local_18 = {};
    type_5 local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    local = type_5 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    local_1 = type_5 {};
    local_1.inner[0] = 1u;
    local_1.inner[1] = 0u;
    local_2 = type_5 {};
    local_2.inner[0] = 2u;
    local_2.inner[1] = 0u;
    uint _e25 = n_1.value;
    n = _e25;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e33 = i;
    uint _e34 = n;
    if (_e33 < _e34) {
        type_5 _e38 = local;
        local_5 = _e38;
        uint _e39 = i;
        local_6 = static_cast<uint>(_e39);
        type_5 _e44 = local_1;
        local_7 = _e44;
        uint _e45 = i;
        local_8 = static_cast<uint>(_e45);
        type_5 _e49 = local_7;
        local_11 = _e49;
        uint _e50 = local_8;
        uint _e52 = local_11.inner[1];
        local_11.inner[1] = _e52 + _e50;
        uint _e56 = local_11.inner[0];
        local_12 = static_cast<uint>(_e56);
        uint _e60 = local_11.inner[1];
        local_13 = static_cast<uint>(_e60);
        uint _e64 = local_13;
        float _e66 = b[_e64];
        local_14 = _e66;
        float _e67 = local_14;
        local_9 = _e67;
        float _e69 = local_9;
        type_5 _e73 = local_5;
        local_15 = _e73;
        uint _e74 = local_6;
        uint _e76 = local_15.inner[1];
        local_15.inner[1] = _e76 + _e74;
        uint _e80 = local_15.inner[0];
        local_16 = static_cast<uint>(_e80);
        uint _e84 = local_15.inner[1];
        local_17 = static_cast<uint>(_e84);
        uint _e88 = local_17;
        float _e90 = a[_e88];
        local_18 = _e90;
        float _e91 = local_18;
        local_10 = _e91;
        float _e93 = local_10;
        type_5 _e97 = local_2;
        local_3 = _e97;
        uint _e98 = i;
        local_4 = static_cast<uint>(_e98);
        type_5 _e102 = local_3;
        local_19 = _e102;
        uint _e103 = local_4;
        uint _e105 = local_19.inner[1];
        local_19.inner[1] = _e105 + _e103;
        uint _e109 = local_19.inner[0];
        local_20 = static_cast<uint>(_e109);
        uint _e113 = local_19.inner[1];
        local_21 = static_cast<uint>(_e113);
        uint _e116 = local_21;
        out[_e116] = _e93 + (_e69 * 2.0);
    }
}
