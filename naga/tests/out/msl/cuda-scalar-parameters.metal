// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size1;
    uint size2;
};

struct type_1 {
    float value;
    char _pad1[12];
};
typedef float type_2[1];

struct scaleInput {
};
kernel void scale(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, constant type_1& factor_1 [[user(fake0)]]
, device type_2 const& input [[user(fake0)]]
, device type_2& output [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    float factor = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    float local_9 = {};
    uint local_10 = {};
    float _e3 = factor_1.value;
    factor = _e3;
    local = 0u;
    local_1 = 0u;
    float _e9 = factor;
    factor = _e9 * 2.0;
    uint _e12 = local;
    local_5 = _e12;
    uint _e14 = local_5;
    local_6 = static_cast<uint>(_e14);
    local_7 = static_cast<uint>(threadIdx.x);
    uint _e21 = local_6;
    uint _e22 = local_7;
    local_8 = static_cast<uint>(_e21 + _e22);
    uint _e27 = local_8;
    float _e29 = input[_e27];
    local_9 = _e29;
    float _e30 = local_9;
    float _e31 = factor;
    uint _e33 = local_1;
    local_2 = _e33;
    uint _e35 = local_2;
    local_3 = static_cast<uint>(_e35);
    local_4 = static_cast<uint>(threadIdx.x);
    uint _e42 = local_3;
    uint _e43 = local_4;
    local_10 = static_cast<uint>(_e42 + _e43);
    uint _e47 = local_10;
    output[_e47] = _e30 * _e31;
}
