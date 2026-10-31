// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_1[1];
struct type_3 {
    int value;
    char _pad1[12];
};
struct type_4 {
    uint value;
    char _pad1[12];
};
struct type_6 {
    uint inner[2];
};
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

int naga_mod(int lhs, int rhs) {
    int divisor = metal::select(rhs, 1, (lhs == (-2147483647 - 1) & rhs == -1) | (rhs == 0));
    return lhs - (lhs / divisor) * divisor;
}

uint naga_mod(uint lhs, uint rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


struct integer_opsInput {
};
kernel void integer_ops(
  metal::uint3 threadIdx [[thread_position_in_threadgroup]]
, device type_1& out_1 [[user(fake0)]]
, constant type_3& value [[user(fake0)]]
, constant type_4& amount [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_6 out = {};
    uint bits = {};
    uint local = {};
    type_6 local_1 = {};
    uint local_2 = {};
    type_6 local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    out = type_6 {};
    out.inner[0] = 0u;
    out.inner[1] = 0u;
    int value_1 = value.value;
    uint amount_1 = amount.value;
    int remainder = naga_mod(value_1, naga_neg(3));
    bits = static_cast<uint>(remainder) & 15u;
    uint _e20 = bits;
    bits = _e20 | 8u;
    uint _e23 = bits;
    bits = _e23 ^ 1u;
    uint _e26 = bits;
    local = amount_1;
    uint _e28 = local;
    bits = _e26 << _e28;
    uint _e30 = bits;
    bits = _e30 >> 1u;
    uint _e33 = bits;
    bits = naga_mod(_e33, 97u);
    uint _e36 = bits;
    bits = _e36 & 255u;
    uint _e39 = bits;
    type_6 _e42 = out;
    local_1 = _e42;
    local_2 = static_cast<uint>(threadIdx.x);
    type_6 _e47 = local_1;
    local_3 = _e47;
    uint _e49 = local_2;
    uint _e51 = local_3.inner[1];
    local_3.inner[1] = _e51 + _e49;
    uint _e55 = local_3.inner[0];
    local_4 = static_cast<uint>(_e55);
    uint _e59 = local_3.inner[1];
    local_5 = static_cast<uint>(_e59);
    uint _e62 = local_5;
    out_1[_e62] = ~(_e39);
}
