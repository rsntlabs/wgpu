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
, device type_1& out [[user(fake0)]]
, constant type_3& value_1 [[user(fake0)]]
, constant type_4& amount_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint local = {};
    int value = {};
    uint amount = {};
    int remainder = {};
    uint bits = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    local = 0u;
    int _e5 = value_1.value;
    value = _e5;
    uint _e9 = amount_1.value;
    amount = _e9;
    int _e13 = value;
    remainder = naga_mod(_e13, naga_neg(3));
    int _e16 = remainder;
    bits = static_cast<uint>(_e16) & 15u;
    uint _e21 = bits;
    bits = _e21 | 8u;
    uint _e24 = bits;
    bits = _e24 ^ 1u;
    uint _e27 = amount;
    uint _e28 = bits;
    local_1 = _e27;
    uint _e30 = local_1;
    bits = _e28 << _e30;
    uint _e32 = bits;
    bits = _e32 >> 1u;
    uint _e35 = bits;
    bits = naga_mod(_e35, 97u);
    uint _e38 = bits;
    bits = _e38 & 255u;
    uint _e41 = bits;
    uint _e43 = local;
    local_2 = _e43;
    uint _e45 = local_2;
    local_3 = static_cast<uint>(_e45);
    local_4 = static_cast<uint>(threadIdx.x);
    uint _e52 = local_3;
    uint _e53 = local_4;
    local_5 = static_cast<uint>(_e52 + _e53);
    uint _e57 = local_5;
    out[_e57] = ~(_e41);
}
