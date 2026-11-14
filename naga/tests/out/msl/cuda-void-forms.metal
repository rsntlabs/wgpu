// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef int type_1[1];
struct type_4 {
    int inner[3];
};

struct void_formsInput {
};
kernel void void_forms(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(2)]]
) {
    int value = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    int index = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    int Count = {};
    int local_6 = {};
    type_4 array = {};
    uint local_7 = {};
    uint lane = threadIdx.x;
    uint base = 4u + (lane * 6u);
    value = static_cast<int>(lane);
    int _e8 = value;
    value = as_type<int>(as_type<uint>(_e8) + as_type<uint>(1));
    int _e11 = value;
    value = as_type<int>(as_type<uint>(_e11) + as_type<uint>(1));
    int _e14 = value;
    output[base] = _e14;
    int _e17 = value;
    value = as_type<int>(as_type<uint>(_e17) + as_type<uint>(1));
    int _e20 = value;
    value = as_type<int>(as_type<uint>(_e20) + as_type<uint>(1));
    int _e23 = value;
    local = static_cast<uint>(base + 1u);
    uint _e28 = local;
    output[_e28] = _e23;
    if ((lane & 1u) == 0u) {
        int _e34 = value;
        value = as_type<int>(as_type<uint>(_e34) + as_type<uint>(3));
    } else {
        int _e37 = value;
        value = as_type<int>(as_type<uint>(_e37) + as_type<uint>(7));
    }
    int _e40 = value;
    local_1 = static_cast<uint>(base + 2u);
    uint _e45 = local_1;
    output[_e45] = _e40;
    int _e47 = value;
    value = as_type<int>(as_type<uint>(_e47) + as_type<uint>(1));
    int _e50 = value;
    value = as_type<int>(as_type<uint>(_e50) + as_type<uint>(1));
    int _e53 = value;
    local_2 = static_cast<uint>(base + 3u);
    uint _e58 = local_2;
    output[_e58] = _e53;
    index = 0;
    int _e62 = index;
    index = as_type<int>(as_type<uint>(_e62) + as_type<uint>(1));
    local_3 = static_cast<uint>(_e62);
    int _e67 = index;
    index = as_type<int>(as_type<uint>(_e67) + as_type<uint>(1));
    local_4 = static_cast<uint>(_e67);
    int _e72 = index;
    local_5 = static_cast<uint>(base + 4u);
    uint _e77 = local_5;
    output[_e77] = _e72;
    Count = 3;
    array = type_4 {};
    int _e85 = array.inner[2];
    local_7 = static_cast<uint>(base + 5u);
    uint _e90 = local_7;
    output[_e90] = _e85;
}
