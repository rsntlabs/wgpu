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
, constant type_3& value [[user(fake0)]]
, constant type_4& amount [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint bits = {};
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    int value_1 = value.value;
    uint amount_1 = amount.value;
    int remainder = naga_mod(value_1, naga_neg(3));
    bits = static_cast<uint>(remainder) & 15u;
    uint _e14 = bits;
    bits = _e14 | 8u;
    uint _e17 = bits;
    bits = _e17 ^ 1u;
    uint _e20 = bits;
    local = amount_1;
    uint _e22 = local;
    bits = _e20 << _e22;
    uint _e24 = bits;
    bits = _e24 >> 1u;
    uint _e27 = bits;
    bits = naga_mod(_e27, 97u);
    uint _e30 = bits;
    bits = _e30 & 255u;
    uint _e33 = bits;
    local_1 = static_cast<uint>(threadIdx.x);
    uint _e38 = local_1;
    local_2 = static_cast<uint>(_e38);
    uint _e41 = local_2;
    out[_e41] = ~(_e33);
}
