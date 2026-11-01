// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef int type_1[1];

int min(
    int first_1,
    int second_1,
    int third
) {
    return as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(as_type<int>(as_type<uint>(first_1) + as_type<uint>(second_1))) + as_type<uint>(third))) + as_type<uint>(100));
}

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

int bounded(
    int value_1
) {
    return metal::min(metal::max(value_1, naga_neg(2)), 2);
}

kernel void integer_minmax(
  device type_1& out [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    int first = {};
    int second = {};
    int value = {};
    int seed = out[static_cast<uint>(0)];
    out[static_cast<uint>(0)] = metal::min(seed, naga_neg(7));
    out[static_cast<uint>(1)] = metal::max(seed, naga_neg(7));
    out[static_cast<uint>(2)] = static_cast<int>(metal::min(3u, 9u));
    out[static_cast<uint>(3)] = static_cast<int>(metal::max(3u, 9u));
    out[static_cast<uint>(4)] = static_cast<int>(metal::min(static_cast<uint>(naga_neg(1)), 2u) == 2u);
    out[static_cast<uint>(5)] = static_cast<int>(metal::max(static_cast<uint>(naga_neg(1)), 2u) == 4294967295u);
    out[static_cast<uint>(6)] = static_cast<int>(metal::min(2u, static_cast<uint>(naga_neg(1))) == 2u);
    out[static_cast<uint>(7)] = static_cast<int>(metal::max(2u, static_cast<uint>(naga_neg(1))) == 4294967295u);
    out[static_cast<uint>(8)] = metal::min(static_cast<int>(true), static_cast<int>(false));
    out[static_cast<uint>(9)] = metal::max(static_cast<int>(false), static_cast<int>(true));
    out[static_cast<uint>(10)] = metal::min(metal::max(seed, naga_neg(5)), 2);
    out[static_cast<uint>(11)] = static_cast<int>(metal::min(static_cast<uint>(naga_neg(2)), 4u) == 4u);
    int _e112 = min(seed, 4, 5);
    out[static_cast<uint>(12)] = _e112;
    int _e116 = bounded(seed);
    out[static_cast<uint>(13)] = _e116;
    first = 3;
    second = 7;
    int _e124 = first;
    first = as_type<int>(as_type<uint>(_e124) + as_type<uint>(1));
    int _e127 = second;
    second = as_type<int>(as_type<uint>(_e127) + as_type<uint>(1));
    out[static_cast<uint>(14)] = metal::max(_e124, _e127);
    int _e134 = first;
    out[static_cast<uint>(15)] = _e134;
    int _e138 = second;
    out[static_cast<uint>(16)] = _e138;
    value = seed;
    int _e143 = value;
    int _e144 = value;
    value = as_type<int>(as_type<uint>(_e144) + as_type<uint>(1));
    out[static_cast<uint>(17)] = metal::max(_e143, _e144);
    int _e151 = value;
    out[static_cast<uint>(18)] = _e151;
    out[static_cast<uint>(19)] = static_cast<int>(metal::min(as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)), 2147483647) == as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)));
    out[static_cast<uint>(20)] = static_cast<int>(metal::max(4294967295u, 0u) == 4294967295u);
    out[static_cast<uint>(21)] = static_cast<int>(metal::min(static_cast<uint>(false), 3u) == 0u);
    out[static_cast<uint>(22)] = static_cast<int>(metal::max(static_cast<uint>(true), 0u) == 1u);
    out[static_cast<uint>(23)] = metal::min(seed, seed);
}
