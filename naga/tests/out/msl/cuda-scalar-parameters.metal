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
    float _e3 = factor_1.value;
    factor = _e3;
    float _e5 = factor;
    factor = _e5 * 2.0;
    local_1 = static_cast<uint>(threadIdx.x);
    uint _e11 = local_1;
    float _e14 = input[_e11];
    float _e15 = factor;
    local = static_cast<uint>(threadIdx.x);
    uint _e20 = local;
    output[_e20] = _e14 * _e15;
}
