// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size2;
};

typedef float type_1[1];
struct type_3 {
    uint value;
    char _pad1[12];
};

struct addInput {
};
kernel void add(
  metal::uint3 blockIdx [[threadgroup_position_in_grid]]
, metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1 const& a [[user(fake0)]]
, device type_1 const& b [[user(fake0)]]
, device type_1& out [[user(fake0)]]
, constant type_3& n [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    float local_3 = {};
    float local_4 = {};
    uint local_5 = {};
    float local_6 = {};
    uint local_7 = {};
    float local_8 = {};
    uint local_9 = {};
    uint n_1 = n.value;
    uint i = (blockIdx.x * 1u) + threadIdx.x;
    if (i < n_1) {
        local_1 = i;
        local_2 = i;
        uint _e13 = local_1;
        local_5 = _e13;
        uint _e15 = local_5;
        float _e18 = a[_e15];
        local_6 = _e18;
        float _e20 = local_6;
        local_3 = _e20;
        float _e22 = local_3;
        uint _e23 = local_2;
        local_7 = _e23;
        uint _e25 = local_7;
        float _e28 = b[_e25];
        local_8 = _e28;
        float _e30 = local_8;
        local_4 = _e30;
        float _e32 = local_4;
        local = i;
        uint _e35 = local;
        local_9 = _e35;
        uint _e37 = local_9;
        out[_e37] = _e22 + _e32;
    }
}
