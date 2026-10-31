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
    int _e3 = value_1.value;
    value = _e3;
    int previous = value;
    value = as_type<int>(as_type<uint>(previous) + as_type<uint>(1));
    local = static_cast<uint>(threadIdx.x);
    uint _e11 = local;
    int _e14 = out[_e11];
    out[_e11] = as_type<int>(as_type<uint>(_e14) + as_type<uint>(previous));
    int _e17 = value;
    value = as_type<int>(as_type<uint>(_e17) + as_type<uint>(1));
    int _e20 = value;
    local_1 = static_cast<uint>(threadIdx.x);
    uint _e24 = local_1;
    out[_e24] = _e20;
}
