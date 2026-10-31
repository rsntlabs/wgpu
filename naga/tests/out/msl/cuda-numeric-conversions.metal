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
struct type_6 {
    uint inner[2];
};

struct convertInput {
};
kernel void convert(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& input_1 [[user(fake0)]]
, device type_1& output_1 [[user(fake0)]]
, constant type_3& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_6 input = {};
    type_6 output = {};
    uint n = {};
    int i = {};
    float offset = {};
    type_6 local = {};
    uint local_1 = {};
    type_6 local_2 = {};
    uint local_3 = {};
    float local_4 = {};
    type_6 local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    float local_8 = {};
    type_6 local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    input = type_6 {};
    input.inner[0] = 0u;
    input.inner[1] = 0u;
    output = type_6 {};
    output.inner[0] = 1u;
    output.inner[1] = 0u;
    uint _e18 = n_1.value;
    n = _e18;
    i = static_cast<int>((blockIdx.x * 1u) + threadIdx.x);
    int _e27 = i;
    uint _e29 = n;
    if (static_cast<uint>(_e27) < _e29) {
        int _e31 = i;
        offset = static_cast<float>(_e31);
        type_6 _e36 = input;
        local_2 = _e36;
        int _e37 = i;
        local_3 = static_cast<uint>(_e37);
        type_6 _e41 = local_2;
        local_5 = _e41;
        uint _e42 = local_3;
        uint _e44 = local_5.inner[1];
        local_5.inner[1] = _e44 + _e42;
        uint _e48 = local_5.inner[0];
        local_6 = static_cast<uint>(_e48);
        uint _e52 = local_5.inner[1];
        local_7 = static_cast<uint>(_e52);
        uint _e56 = local_7;
        float _e58 = input_1[_e56];
        local_8 = _e58;
        float _e59 = local_8;
        local_4 = _e59;
        float _e61 = local_4;
        float _e62 = offset;
        type_6 _e66 = output;
        local = _e66;
        int _e67 = i;
        local_1 = static_cast<uint>(_e67);
        type_6 _e71 = local;
        local_9 = _e71;
        uint _e72 = local_1;
        uint _e74 = local_9.inner[1];
        local_9.inner[1] = _e74 + _e72;
        uint _e78 = local_9.inner[0];
        local_10 = static_cast<uint>(_e78);
        uint _e82 = local_9.inner[1];
        local_11 = static_cast<uint>(_e82);
        uint _e85 = local_11;
        output_1[_e85] = _e61 + _e62;
    }
}
