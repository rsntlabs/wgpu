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
struct type_5 {
    uint inner[2];
};

struct scaleInput {
};
kernel void scale(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, constant type_1& factor_1 [[user(fake0)]]
, device type_2 const& input_1 [[user(fake0)]]
, device type_2& output_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    float factor = {};
    type_5 input = {};
    type_5 output = {};
    type_5 local = {};
    uint local_1 = {};
    type_5 local_2 = {};
    uint local_3 = {};
    float local_4 = {};
    type_5 local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    float local_8 = {};
    type_5 local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    float _e3 = factor_1.value;
    factor = _e3;
    input = type_5 {};
    input.inner[0] = 0u;
    input.inner[1] = 0u;
    output = type_5 {};
    output.inner[0] = 1u;
    output.inner[1] = 0u;
    float _e19 = factor;
    factor = _e19 * 2.0;
    type_5 _e24 = input;
    local_2 = _e24;
    local_3 = static_cast<uint>(threadIdx.x);
    type_5 _e29 = local_2;
    local_5 = _e29;
    uint _e30 = local_3;
    uint _e32 = local_5.inner[1];
    local_5.inner[1] = _e32 + _e30;
    uint _e36 = local_5.inner[0];
    local_6 = static_cast<uint>(_e36);
    uint _e40 = local_5.inner[1];
    local_7 = static_cast<uint>(_e40);
    uint _e44 = local_7;
    float _e46 = input_1[_e44];
    local_8 = _e46;
    float _e47 = local_8;
    local_4 = _e47;
    float _e49 = local_4;
    float _e50 = factor;
    type_5 _e54 = output;
    local = _e54;
    local_1 = static_cast<uint>(threadIdx.x);
    type_5 _e59 = local;
    local_9 = _e59;
    uint _e60 = local_1;
    uint _e62 = local_9.inner[1];
    local_9.inner[1] = _e62 + _e60;
    uint _e66 = local_9.inner[0];
    local_10 = static_cast<uint>(_e66);
    uint _e70 = local_9.inner[1];
    local_11 = static_cast<uint>(_e70);
    uint _e73 = local_11;
    output_1[_e73] = _e49 * _e50;
}
