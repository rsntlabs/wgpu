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
    uint local = {};
    int value = {};
    int previous = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    int local_8 = {};
    uint local_9 = {};
    local = 0u;
    int _e5 = value_1.value;
    value = _e5;
    int _e7 = value;
    value = as_type<int>(as_type<uint>(_e7) + as_type<uint>(1));
    previous = _e7;
    int _e11 = previous;
    uint _e12 = local;
    local_1 = _e12;
    uint _e14 = local_1;
    local_2 = static_cast<uint>(_e14);
    local_3 = static_cast<uint>(threadIdx.x);
    uint _e21 = local_2;
    uint _e22 = local_3;
    local_7 = static_cast<uint>(_e21 + _e22);
    uint _e27 = local_7;
    int _e29 = out[_e27];
    local_8 = _e29;
    int _e30 = local_8;
    uint _e32 = local_7;
    out[_e32] = as_type<int>(as_type<uint>(_e30) + as_type<uint>(_e11));
    int _e34 = value;
    value = as_type<int>(as_type<uint>(_e34) + as_type<uint>(1));
    int _e37 = value;
    uint _e38 = local;
    local_4 = _e38;
    uint _e40 = local_4;
    local_5 = static_cast<uint>(_e40);
    local_6 = static_cast<uint>(threadIdx.x);
    uint _e46 = local_5;
    uint _e47 = local_6;
    local_9 = static_cast<uint>(_e46 + _e47);
    uint _e51 = local_9;
    out[_e51] = _e37;
}
