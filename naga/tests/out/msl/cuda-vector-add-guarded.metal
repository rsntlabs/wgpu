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
    uint i = (blockIdx.x * 64u) + threadIdx.x;
    if (i < n_1) {
        local_1 = static_cast<uint>(i);
        local_2 = static_cast<uint>(i);
        uint _e15 = local_2;
        local_5 = static_cast<uint>(_e15);
        uint _e18 = local_5;
        float _e21 = b[_e18];
        local_6 = _e21;
        float _e23 = local_6;
        local_3 = _e23;
        float _e25 = local_3;
        uint _e28 = local_1;
        local_7 = static_cast<uint>(_e28);
        uint _e31 = local_7;
        float _e34 = a[_e31];
        local_8 = _e34;
        float _e36 = local_8;
        local_4 = _e36;
        float _e38 = local_4;
        local = static_cast<uint>(i);
        uint _e42 = local;
        local_9 = static_cast<uint>(_e42);
        uint _e45 = local_9;
        out[_e45] = _e38 + (_e25 * 2.0);
    }
}
