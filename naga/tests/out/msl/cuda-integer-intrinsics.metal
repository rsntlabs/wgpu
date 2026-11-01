// language: metal1.2
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_2[1];

int count(
    uint value
) {
    return static_cast<int>(metal::popcount(value));
}

int scan(
    int value_1
) {
    return as_type<int>(as_type<uint>((((metal::ctz(value_1) + 1) % 33) - 1)) + as_type<uint>(1));
}

int _clz(
    int first,
    int second
) {
    return as_type<int>(as_type<uint>(first) + as_type<uint>(second));
}
int naga_f2i32(float value) {
    return static_cast<int>(metal::clamp(value, -2147483600.0, 2147483500.0));
}

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

uint naga_f2u32(float value) {
    return static_cast<uint>(metal::clamp(value, 0.0, 4294967000.0));
}


kernel void integer_intrinsics(
  device type_2& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    out[static_cast<uint>(0)] = static_cast<uint>(metal::clz(static_cast<int>(true)));
    out[static_cast<uint>(1)] = static_cast<uint>(metal::clz(8));
    out[static_cast<uint>(2)] = static_cast<uint>(metal::clz(static_cast<int>(2147483648u)));
    out[static_cast<uint>(3)] = static_cast<uint>(metal::clz(naga_f2i32(8.75)));
    out[static_cast<uint>(4)] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(static_cast<int>(true)) + 1) % 33) - 1)) + as_type<uint>(1)));
    out[static_cast<uint>(5)] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(8) + 1) % 33) - 1)) + as_type<uint>(1)));
    out[static_cast<uint>(6)] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(static_cast<int>(2147483648u)) + 1) % 33) - 1)) + as_type<uint>(1)));
    out[static_cast<uint>(7)] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(naga_f2i32(8.75)) + 1) % 33) - 1)) + as_type<uint>(1)));
    out[static_cast<uint>(8)] = static_cast<uint>(static_cast<int>(metal::popcount(static_cast<uint>(true))));
    out[static_cast<uint>(9)] = static_cast<uint>(static_cast<int>(metal::popcount(static_cast<uint>(naga_neg(1)))));
    out[static_cast<uint>(10)] = static_cast<uint>(static_cast<int>(metal::popcount(2147483649u)));
    out[static_cast<uint>(11)] = static_cast<uint>(static_cast<int>(metal::popcount(naga_f2u32(3.75))));
    out[static_cast<uint>(12)] = metal::reverse_bits(static_cast<uint>(true));
    out[static_cast<uint>(13)] = metal::reverse_bits(static_cast<uint>(naga_neg(1)));
    out[static_cast<uint>(14)] = metal::reverse_bits(19088743u);
    out[static_cast<uint>(15)] = metal::reverse_bits(naga_f2u32(2.75));
    int _e120 = count(2147483649u);
    out[static_cast<uint>(16)] = static_cast<uint>(_e120);
    int _e127 = scan(static_cast<int>(2147483648u));
    out[static_cast<uint>(17)] = static_cast<uint>(_e127);
    out[static_cast<uint>(18)] = static_cast<uint>(metal::clz(0));
    out[static_cast<uint>(19)] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(0) + 1) % 33) - 1)) + as_type<uint>(1)));
    out[static_cast<uint>(20)] = static_cast<uint>(static_cast<int>(metal::popcount(4294967295u)));
    out[static_cast<uint>(21)] = metal::reverse_bits(0u);
    out[static_cast<uint>(22)] = metal::reverse_bits(1u);
    out[static_cast<uint>(23)] = metal::reverse_bits(2147483648u);
    out[static_cast<uint>(24)] = static_cast<uint>(metal::clz(naga_neg(2)));
    out[static_cast<uint>(25)] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(naga_neg(2)) + 1) % 33) - 1)) + as_type<uint>(1)));
    out[static_cast<uint>(26)] = static_cast<uint>(static_cast<int>(metal::popcount(2863311530u)));
    out[static_cast<uint>(27)] = metal::reverse_bits(2863311530u);
    int _e198 = _clz(3, 4);
    out[static_cast<uint>(28)] = static_cast<uint>(_e198);
    out[static_cast<uint>(29)] = static_cast<uint>(as_type<int>(as_type<uint>(static_cast<int>(metal::popcount(3u))) - as_type<uint>(3)) < 0);
}
