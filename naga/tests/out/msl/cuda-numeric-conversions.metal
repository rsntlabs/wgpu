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

struct convertInput {
};
kernel void convert(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& input [[user(fake0)]]
, device type_1& output [[user(fake0)]]
, constant type_3& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    float offset = {};
    uint local = {};
    uint local_1 = {};
    float local_2 = {};
    uint local_3 = {};
    float local_4 = {};
    uint local_5 = {};
    uint n_1 = n.value;
    int i = static_cast<int>((blockIdx.x * 1u) + threadIdx.x);
    if (static_cast<uint>(i) < n_1) {
        offset = static_cast<float>(i);
        local_1 = static_cast<uint>(i);
        uint _e17 = local_1;
        local_3 = static_cast<uint>(_e17);
        uint _e20 = local_3;
        float _e23 = input[_e20];
        local_4 = _e23;
        float _e25 = local_4;
        local_2 = _e25;
        float _e27 = local_2;
        float _e28 = offset;
        local = static_cast<uint>(i);
        uint _e32 = local;
        local_5 = static_cast<uint>(_e32);
        uint _e35 = local_5;
        output[_e35] = _e27 + _e28;
    }
}
