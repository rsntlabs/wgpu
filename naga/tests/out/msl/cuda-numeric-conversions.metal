// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
};

typedef float type_1[1];
struct type_3 {
    uint value;
    char _pad1[12];
};
struct type_5 {
    uint inner[2];
};

struct convertInput {
};
kernel void convert(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& input_1 [[user(fake0)]]
, device type_1& output_1 [[user(fake0)]]
, constant type_3& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_5 input = {};
    type_5 output = {};
    float offset = {};
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
    input = type_5 {};
    input.inner[0] = 0u;
    input.inner[1] = 0u;
    output = type_5 {};
    output.inner[0] = 1u;
    output.inner[1] = 0u;
    uint n_1 = n.value;
    int i = static_cast<int>((blockIdx.x * 1u) + threadIdx.x);
    if (static_cast<uint>(i) < n_1) {
        offset = static_cast<float>(i);
        type_5 _e28 = input;
        local_2 = _e28;
        local_3 = static_cast<uint>(i);
        type_5 _e32 = local_2;
        local_5 = _e32;
        uint _e34 = local_3;
        uint _e36 = local_5.inner[1];
        local_5.inner[1] = _e36 + _e34;
        uint _e40 = local_5.inner[0];
        local_6 = static_cast<uint>(_e40);
        uint _e44 = local_5.inner[1];
        local_7 = static_cast<uint>(_e44);
        uint _e47 = local_7;
        float _e50 = input_1[_e47];
        local_8 = _e50;
        float _e52 = local_8;
        local_4 = _e52;
        float _e54 = local_4;
        float _e55 = offset;
        type_5 _e58 = output;
        local = _e58;
        local_1 = static_cast<uint>(i);
        type_5 _e62 = local;
        local_9 = _e62;
        uint _e64 = local_1;
        uint _e66 = local_9.inner[1];
        local_9.inner[1] = _e66 + _e64;
        uint _e70 = local_9.inner[0];
        local_10 = static_cast<uint>(_e70);
        uint _e74 = local_9.inner[1];
        local_11 = static_cast<uint>(_e74);
        uint _e77 = local_11;
        output_1[_e77] = _e54 + _e55;
    }
}
