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
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint n = {};
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
    uint _e10 = n_1.value;
    n = _e10;
    i = (blockIdx.x * 64u) + threadIdx.x;
    uint _e18 = i;
    uint _e19 = n;
    if (_e18 < _e19) {
        uint _e21 = local;
        local_6 = _e21;
        uint _e23 = local_6;
        local_7 = static_cast<uint>(_e23);
        uint _e26 = i;
        local_8 = static_cast<uint>(_e26);
        uint _e29 = local_1;
        local_9 = _e29;
        uint _e31 = local_9;
        local_10 = static_cast<uint>(_e31);
        uint _e34 = i;
        local_11 = static_cast<uint>(_e34);
        uint _e38 = local_10;
        uint _e39 = local_11;
        local_12 = static_cast<uint>(_e38 + _e39);
        uint _e44 = local_12;
        float _e46 = b[_e44];
        local_13 = _e46;
        float _e47 = local_13;
        uint _e51 = local_7;
        uint _e52 = local_8;
        local_14 = static_cast<uint>(_e51 + _e52);
        uint _e57 = local_14;
        float _e59 = a[_e57];
        local_15 = _e59;
        float _e60 = local_15;
        uint _e62 = local_2;
        local_3 = _e62;
        uint _e64 = local_3;
        local_4 = static_cast<uint>(_e64);
        uint _e67 = i;
        local_5 = static_cast<uint>(_e67);
        uint _e71 = local_4;
        uint _e72 = local_5;
        local_16 = static_cast<uint>(_e71 + _e72);
        uint _e76 = local_16;
        out[_e76] = _e60 + (_e47 * 2.0);
    }
}
