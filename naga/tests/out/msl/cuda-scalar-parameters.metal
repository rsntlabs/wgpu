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
    float local_2 = {};
    uint local_3 = {};
    float local_4 = {};
    uint local_5 = {};
    float _e3 = factor_1.value;
    factor = _e3;
    float _e5 = factor;
    factor = _e5 * 2.0;
    local_1 = static_cast<uint>(threadIdx.x);
    uint _e12 = local_1;
    local_3 = static_cast<uint>(_e12);
    uint _e16 = local_3;
    float _e18 = input[_e16];
    local_4 = _e18;
    float _e19 = local_4;
    local_2 = _e19;
    float _e21 = local_2;
    float _e22 = factor;
    local = static_cast<uint>(threadIdx.x);
    uint _e28 = local;
    local_5 = static_cast<uint>(_e28);
    uint _e31 = local_5;
    output[_e31] = _e21 * _e22;
}
