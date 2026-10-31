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
, device type_1& out [[user(fake0)]]
, constant type_3& value_1 [[user(fake0)]]
, constant type_4& amount_1 [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    type_6 local = {};
    int value = {};
    uint amount = {};
    int remainder = {};
    uint bits = {};
    uint local_1 = {};
    type_6 local_2 = {};
    uint local_3 = {};
    type_6 local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    local = type_6 {};
    local.inner[0] = 0u;
    local.inner[1] = 0u;
    int _e10 = value_1.value;
    value = _e10;
    uint _e14 = amount_1.value;
    amount = _e14;
    int _e18 = value;
    remainder = naga_mod(_e18, naga_neg(3));
    int _e21 = remainder;
    bits = static_cast<uint>(_e21) & 15u;
    uint _e26 = bits;
    bits = _e26 | 8u;
    uint _e29 = bits;
    bits = _e29 ^ 1u;
    uint _e32 = amount;
    uint _e33 = bits;
    local_1 = _e32;
    uint _e35 = local_1;
    bits = _e33 << _e35;
    uint _e37 = bits;
    bits = _e37 >> 1u;
    uint _e40 = bits;
    bits = naga_mod(_e40, 97u);
    uint _e43 = bits;
    bits = _e43 & 255u;
    uint _e46 = bits;
    type_6 _e50 = local;
    local_2 = _e50;
    local_3 = static_cast<uint>(threadIdx.x);
    type_6 _e55 = local_2;
    local_4 = _e55;
    uint _e56 = local_3;
    uint _e58 = local_4.inner[1];
    local_4.inner[1] = _e58 + _e56;
    uint _e62 = local_4.inner[0];
    local_5 = static_cast<uint>(_e62);
    uint _e66 = local_4.inner[1];
    local_6 = static_cast<uint>(_e66);
    uint _e69 = local_6;
    out[_e69] = ~(_e46);
}
