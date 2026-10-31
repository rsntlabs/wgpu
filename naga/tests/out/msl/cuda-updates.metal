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
    int _e9 = value_1.value;
    value = _e9;
    int previous = value;
    value = as_type<int>(as_type<uint>(previous) + as_type<uint>(1));
    type_5 _e15 = out;
    local = _e15;
    local_1 = static_cast<uint>(threadIdx.x);
    type_5 _e20 = local;
    local_5 = _e20;
    uint _e22 = local_1;
    uint _e24 = local_5.inner[1];
    local_5.inner[1] = _e24 + _e22;
    uint _e28 = local_5.inner[0];
    local_6 = static_cast<uint>(_e28);
    uint _e32 = local_5.inner[1];
    local_7 = static_cast<uint>(_e32);
    uint _e35 = local_7;
    int _e38 = out_1[_e35];
    local_8 = _e38;
    int _e40 = local_8;
    local_4 = _e40;
    int _e42 = local_4;
    uint _e44 = local_7;
    out_1[_e44] = as_type<int>(as_type<uint>(_e42) + as_type<uint>(previous));
    int _e46 = value;
    value = as_type<int>(as_type<uint>(_e46) + as_type<uint>(1));
    int _e49 = value;
    type_5 _e50 = out;
    local_2 = _e50;
    local_3 = static_cast<uint>(threadIdx.x);
    type_5 _e55 = local_2;
    local_9 = _e55;
    uint _e57 = local_3;
    uint _e59 = local_9.inner[1];
    local_9.inner[1] = _e59 + _e57;
    uint _e63 = local_9.inner[0];
    local_10 = static_cast<uint>(_e63);
    uint _e67 = local_9.inner[1];
    local_11 = static_cast<uint>(_e67);
    uint _e70 = local_11;
    out_1[_e70] = _e49;
}
