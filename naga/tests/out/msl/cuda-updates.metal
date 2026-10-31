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
struct type_5 {
    uint inner[2];
};

struct updatesInput {
};
kernel void updates(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out_1 [[user(fake0)]]
, constant type_3& value_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_5 out = {};
    int value = {};
    int previous = {};
    type_5 local = {};
    uint local_1 = {};
    type_5 local_2 = {};
    uint local_3 = {};
    int local_4 = {};
    type_5 local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    int local_8 = {};
    type_5 local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    out = type_5 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    int _e10 = value_1.value;
    value = _e10;
    int _e12 = value;
    value = as_type<int>(as_type<uint>(_e12) + as_type<uint>(1));
    previous = _e12;
    int _e16 = previous;
    type_5 _e19 = out;
    local = _e19;
    local_1 = static_cast<uint>(threadIdx.x);
    type_5 _e24 = local;
    local_5 = _e24;
    uint _e25 = local_1;
    uint _e27 = local_5.inner[1];
    local_5.inner[1] = _e27 + _e25;
    uint _e31 = local_5.inner[0];
    local_6 = static_cast<uint>(_e31);
    uint _e35 = local_5.inner[1];
    local_7 = static_cast<uint>(_e35);
    uint _e39 = local_7;
    int _e41 = out_1[_e39];
    local_8 = _e41;
    int _e42 = local_8;
    local_4 = _e42;
    int _e44 = local_4;
    uint _e46 = local_7;
    out_1[_e46] = as_type<int>(as_type<uint>(_e44) + as_type<uint>(_e16));
    int _e48 = value;
    value = as_type<int>(as_type<uint>(_e48) + as_type<uint>(1));
    int _e51 = value;
    type_5 _e53 = out;
    local_2 = _e53;
    local_3 = static_cast<uint>(threadIdx.x);
    type_5 _e58 = local_2;
    local_9 = _e58;
    uint _e59 = local_3;
    uint _e61 = local_9.inner[1];
    local_9.inner[1] = _e61 + _e59;
    uint _e65 = local_9.inner[0];
    local_10 = static_cast<uint>(_e65);
    uint _e69 = local_9.inner[1];
    local_11 = static_cast<uint>(_e69);
    uint _e72 = local_11;
    out_1[_e72] = _e51;
}
