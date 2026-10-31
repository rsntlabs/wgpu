// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef int type_1[1];
struct type_3 {
    int value;
    char _pad1[12];
};

struct updatesInput {
};
kernel void updates(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out [[user(fake0)]]
, constant type_3& value_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    int value = {};
    uint local = {};
    uint local_1 = {};
    int local_2 = {};
    uint local_3 = {};
    int local_4 = {};
    uint local_5 = {};
    int _e3 = value_1.value;
    value = _e3;
    int previous = value;
    value = as_type<int>(as_type<uint>(previous) + as_type<uint>(1));
    local = static_cast<uint>(threadIdx.x);
    uint _e11 = local;
    local_3 = static_cast<uint>(_e11);
    uint _e14 = local_3;
    int _e17 = out[_e14];
    local_4 = _e17;
    int _e19 = local_4;
    local_2 = _e19;
    int _e21 = local_2;
    uint _e23 = local_3;
    out[_e23] = as_type<int>(as_type<uint>(_e21) + as_type<uint>(previous));
    int _e25 = value;
    value = as_type<int>(as_type<uint>(_e25) + as_type<uint>(1));
    int _e28 = value;
    local_1 = static_cast<uint>(threadIdx.x);
    uint _e32 = local_1;
    local_5 = static_cast<uint>(_e32);
    uint _e35 = local_5;
    out[_e35] = _e28;
}
