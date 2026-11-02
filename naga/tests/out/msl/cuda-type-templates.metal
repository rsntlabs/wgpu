// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size3;
    uint size4;
};

typedef uint type_2[1];
struct type_3 {
    uint value;
    char _pad1[12];
};
typedef float type_5[1];

uint copied_unsigned(
    uint value
) {
    return value;
}

float copied_float(
    float value_1
) {
    return value_1;
}

struct copy_typed_unsignedInput {
};
kernel void copy_typed_unsigned(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_2& output [[user(fake0)]]
, device type_2 const& input [[user(fake0)]]
, constant type_3& count [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint count_2 = count.value;
    uint index = (blockIdx.x * 4u) + threadIdx.x;
    if (index < count_2) {
        local_1 = index;
        uint _e12 = local_1;
        local_3 = _e12;
        uint _e14 = local_3;
        uint _e17 = input[_e14];
        local_4 = _e17;
        uint _e19 = local_4;
        local_2 = _e19;
        uint _e21 = local_2;
        uint _e22 = copied_unsigned(_e21);
        local = index;
        uint _e24 = local;
        local_5 = _e24;
        uint _e26 = local_5;
        output[_e26] = _e22;
    }
}


struct copy_typed_floatInput {
};
kernel void copy_typed_float(
  metal::uint3 blockIdx_1 [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx_1 [[thread_position_in_threadgroup]]
, device type_5& output_1 [[user(fake0)]]
, device type_5 const& input_1 [[user(fake0)]]
, constant type_3& count_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local_6 = {};
    uint local_7 = {};
    float local_8 = {};
    uint local_9 = {};
    float local_10 = {};
    uint local_11 = {};
    uint count_3 = count_1.value;
    uint index_1 = (blockIdx_1.x * 4u) + threadIdx_1.x;
    if (index_1 < count_3) {
        local_7 = index_1;
        uint _e12 = local_7;
        local_9 = _e12;
        uint _e14 = local_9;
        float _e17 = input_1[_e14];
        local_10 = _e17;
        float _e19 = local_10;
        local_8 = _e19;
        float _e21 = local_8;
        float _e22 = copied_float(_e21);
        local_6 = index_1;
        uint _e24 = local_6;
        local_11 = _e24;
        uint _e26 = local_11;
        output_1[_e26] = _e22;
    }
}
