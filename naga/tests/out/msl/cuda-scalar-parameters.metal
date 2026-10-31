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
, device type_2 const& input [[user(fake0)]]
, device type_2& output [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    float factor = {};
    type_5 local = {};
    type_5 local_1 = {};
    type_5 local_2 = {};
    uint local_3 = {};
    type_5 local_4 = {};
    uint local_5 = {};
    float local_6 = {};
    type_5 local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    float local_10 = {};
    type_5 local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    float _e3 = factor_1.value;
    factor = _e3;
    local = type_5 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    local_1 = type_5 {};
    local_1.inner[0] = 1u;
    local_1.inner[1] = 0u;
    float _e19 = factor;
    factor = _e19 * 2.0;
    type_5 _e24 = local;
    local_4 = _e24;
    local_5 = static_cast<uint>(threadIdx.x);
    type_5 _e29 = local_4;
    local_7 = _e29;
    uint _e30 = local_5;
    uint _e32 = local_7.inner[1];
    local_7.inner[1] = _e32 + _e30;
    uint _e36 = local_7.inner[0];
    local_8 = static_cast<uint>(_e36);
    uint _e40 = local_7.inner[1];
    local_9 = static_cast<uint>(_e40);
    uint _e44 = local_9;
    float _e46 = input[_e44];
    local_10 = _e46;
    float _e47 = local_10;
    local_6 = _e47;
    float _e49 = local_6;
    float _e50 = factor;
    type_5 _e54 = local_1;
    local_2 = _e54;
    local_3 = static_cast<uint>(threadIdx.x);
    type_5 _e59 = local_2;
    local_11 = _e59;
    uint _e60 = local_3;
    uint _e62 = local_11.inner[1];
    local_11.inner[1] = _e62 + _e60;
    uint _e66 = local_11.inner[0];
    local_12 = static_cast<uint>(_e66);
    uint _e70 = local_11.inner[1];
    local_13 = static_cast<uint>(_e70);
    uint _e73 = local_13;
    output[_e73] = _e49 * _e50;
}
