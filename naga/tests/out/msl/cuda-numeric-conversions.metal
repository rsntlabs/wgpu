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
, device type_1 const& input [[user(fake0)]]
, device type_1& output [[user(fake0)]]
, constant type_3& n_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_6 local = {};
    type_6 local_1 = {};
    uint n = {};
    int i = {};
    float offset = {};
    type_6 local_2 = {};
    uint local_3 = {};
    type_6 local_4 = {};
    uint local_5 = {};
    float local_6 = {};
    type_6 local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    float local_10 = {};
    type_6 local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    local = type_6 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    local_1 = type_6 {};
    local_1.inner[0] = 1u;
    local_1.inner[1] = 0u;
    uint _e18 = n_1.value;
    n = _e18;
    i = static_cast<int>((blockIdx.x * 1u) + threadIdx.x);
    int _e27 = i;
    uint _e29 = n;
    if (static_cast<uint>(_e27) < _e29) {
        int _e31 = i;
        offset = static_cast<float>(_e31);
        type_6 _e36 = local;
        local_4 = _e36;
        int _e37 = i;
        local_5 = static_cast<uint>(_e37);
        type_6 _e41 = local_4;
        local_7 = _e41;
        uint _e42 = local_5;
        uint _e44 = local_7.inner[1];
        local_7.inner[1] = _e44 + _e42;
        uint _e48 = local_7.inner[0];
        local_8 = static_cast<uint>(_e48);
        uint _e52 = local_7.inner[1];
        local_9 = static_cast<uint>(_e52);
        uint _e56 = local_9;
        float _e58 = input[_e56];
        local_10 = _e58;
        float _e59 = local_10;
        local_6 = _e59;
        float _e61 = local_6;
        float _e62 = offset;
        type_6 _e66 = local_1;
        local_2 = _e66;
        int _e67 = i;
        local_3 = static_cast<uint>(_e67);
        type_6 _e71 = local_2;
        local_11 = _e71;
        uint _e72 = local_3;
        uint _e74 = local_11.inner[1];
        local_11.inner[1] = _e74 + _e72;
        uint _e78 = local_11.inner[0];
        local_12 = static_cast<uint>(_e78);
        uint _e82 = local_11.inner[1];
        local_13 = static_cast<uint>(_e82);
        uint _e85 = local_13;
        output[_e85] = _e61 + _e62;
    }
}
