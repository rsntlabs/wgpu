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
, constant type_3& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    uint n = {};
    int i = {};
    float offset = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    float local_9 = {};
    uint local_10 = {};
    local = 0u;
    local_1 = 0u;
    uint _e8 = n_1.value;
    n = _e8;
    i = static_cast<int>((blockIdx.x * 1u) + threadIdx.x);
    int _e17 = i;
    uint _e19 = n;
    if (static_cast<uint>(_e17) < _e19) {
        int _e21 = i;
        offset = static_cast<float>(_e21);
        uint _e24 = local;
        local_5 = _e24;
        uint _e26 = local_5;
        local_6 = static_cast<uint>(_e26);
        int _e29 = i;
        local_7 = static_cast<uint>(_e29);
        uint _e33 = local_6;
        uint _e34 = local_7;
        local_8 = static_cast<uint>(_e33 + _e34);
        uint _e39 = local_8;
        float _e41 = input[_e39];
        local_9 = _e41;
        float _e42 = local_9;
        float _e43 = offset;
        uint _e45 = local_1;
        local_2 = _e45;
        uint _e47 = local_2;
        local_3 = static_cast<uint>(_e47);
        int _e50 = i;
        local_4 = static_cast<uint>(_e50);
        uint _e54 = local_3;
        uint _e55 = local_4;
        local_10 = static_cast<uint>(_e54 + _e55);
        uint _e59 = local_10;
        output[_e59] = _e42 + _e43;
    }
}
