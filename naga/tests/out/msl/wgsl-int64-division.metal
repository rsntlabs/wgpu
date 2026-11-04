// language: metal2.3
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
    uint size1;
    uint size2;
};

struct Values {
    long signed_scalar;
    ulong unsigned_scalar;
    metal::long2 signed_pair;
    metal::ulong2 unsigned_pair;
    char _pad4[16];
    metal::long3 signed_triple;
    metal::ulong3 unsigned_triple;
    metal::long4 signed_quad;
    metal::ulong4 unsigned_quad;
};
typedef Values type_8[1];
long naga_div(long lhs, long rhs) {
    return lhs / metal::select(rhs, 1, (lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0));
}

ulong naga_div(ulong lhs, ulong rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}

metal::long2 naga_div(metal::long2 lhs, metal::long2 rhs) {
    return lhs / metal::select(rhs, 1, (lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0));
}

metal::ulong2 naga_div(metal::ulong2 lhs, metal::ulong2 rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}

metal::long3 naga_div(metal::long3 lhs, metal::long3 rhs) {
    return lhs / metal::select(rhs, 1, (lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0));
}

metal::ulong3 naga_div(metal::ulong3 lhs, metal::ulong3 rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}

metal::long4 naga_div(metal::long4 lhs, metal::long4 rhs) {
    return lhs / metal::select(rhs, 1, (lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0));
}

metal::ulong4 naga_div(metal::ulong4 lhs, metal::ulong4 rhs) {
    return lhs / metal::select(rhs, 1u, rhs == 0u);
}

long naga_mod(long lhs, long rhs) {
    long divisor = metal::select(rhs, 1, (lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0));
    return lhs - (lhs / divisor) * divisor;
}

ulong naga_mod(ulong lhs, ulong rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

metal::long2 naga_mod(metal::long2 lhs, metal::long2 rhs) {
    metal::long2 divisor = metal::select(rhs, 1, (lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0));
    return lhs - (lhs / divisor) * divisor;
}

metal::ulong2 naga_mod(metal::ulong2 lhs, metal::ulong2 rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

metal::long3 naga_mod(metal::long3 lhs, metal::long3 rhs) {
    metal::long3 divisor = metal::select(rhs, 1, (lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0));
    return lhs - (lhs / divisor) * divisor;
}

metal::ulong3 naga_mod(metal::ulong3 lhs, metal::ulong3 rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}

metal::long4 naga_mod(metal::long4 lhs, metal::long4 rhs) {
    metal::long4 divisor = metal::select(rhs, 1, (lhs == (-9223372036854775807L - 1L) & rhs == -1) | (rhs == 0));
    return lhs - (lhs / divisor) * divisor;
}

metal::ulong4 naga_mod(metal::ulong4 lhs, metal::ulong4 rhs) {
    return lhs % metal::select(rhs, 1u, rhs == 0u);
}


[[max_total_threads_per_threadgroup(1)]] kernel void integer_division(
  device type_8 const& operands [[user(fake0)]]
, device type_8& quotients [[user(fake0)]]
, device type_8& remainders [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    Values dividend = operands[0];
    Values divisor = operands[1];
    quotients[0] = Values {naga_div(dividend.signed_scalar, divisor.signed_scalar), naga_div(dividend.unsigned_scalar, divisor.unsigned_scalar), naga_div(dividend.signed_pair, divisor.signed_pair), naga_div(dividend.unsigned_pair, divisor.unsigned_pair), {}, naga_div(dividend.signed_triple, divisor.signed_triple), naga_div(dividend.unsigned_triple, divisor.unsigned_triple), naga_div(dividend.signed_quad, divisor.signed_quad), naga_div(dividend.unsigned_quad, divisor.unsigned_quad)};
    remainders[0] = Values {naga_mod(dividend.signed_scalar, divisor.signed_scalar), naga_mod(dividend.unsigned_scalar, divisor.unsigned_scalar), naga_mod(dividend.signed_pair, divisor.signed_pair), naga_mod(dividend.unsigned_pair, divisor.unsigned_pair), {}, naga_mod(dividend.signed_triple, divisor.signed_triple), naga_mod(dividend.unsigned_triple, divisor.unsigned_triple), naga_mod(dividend.signed_quad, divisor.signed_quad), naga_mod(dividend.unsigned_quad, divisor.unsigned_quad)};
    return;
}
