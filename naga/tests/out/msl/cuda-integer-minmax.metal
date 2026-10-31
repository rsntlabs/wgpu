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
    uint local = {};
    uint local_1 = {};
    uint local_2 = {};
    uint local_3 = {};
    uint local_4 = {};
    uint local_5 = {};
    uint local_6 = {};
    uint local_7 = {};
    uint local_8 = {};
    uint local_9 = {};
    uint local_10 = {};
    uint local_11 = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    int first = {};
    int second = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    int value = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    uint local_21 = {};
    uint local_22 = {};
    uint local_23 = {};
    uint local_24 = {};
    local = static_cast<uint>(0);
    uint _e3 = local;
    int seed = out[_e3];
    local_1 = static_cast<uint>(0);
    uint _e13 = local_1;
    out[_e13] = metal::min(seed, naga_neg(7));
    local_2 = static_cast<uint>(1);
    uint _e21 = local_2;
    out[_e21] = metal::max(seed, naga_neg(7));
    local_3 = static_cast<uint>(2);
    uint _e30 = local_3;
    out[_e30] = static_cast<int>(metal::min(3u, 9u));
    local_4 = static_cast<uint>(3);
    uint _e39 = local_4;
    out[_e39] = static_cast<int>(metal::max(3u, 9u));
    local_5 = static_cast<uint>(4);
    uint _e52 = local_5;
    out[_e52] = static_cast<int>(metal::min(static_cast<uint>(naga_neg(1)), 2u) == 2u);
    local_6 = static_cast<uint>(5);
    uint _e65 = local_6;
    out[_e65] = static_cast<int>(metal::max(static_cast<uint>(naga_neg(1)), 2u) == 4294967295u);
    local_7 = static_cast<uint>(6);
    uint _e78 = local_7;
    out[_e78] = static_cast<int>(metal::min(2u, static_cast<uint>(naga_neg(1))) == 2u);
    local_8 = static_cast<uint>(7);
    uint _e91 = local_8;
    out[_e91] = static_cast<int>(metal::max(2u, static_cast<uint>(naga_neg(1))) == 4294967295u);
    local_9 = static_cast<uint>(8);
    uint _e101 = local_9;
    out[_e101] = metal::min(static_cast<int>(true), static_cast<int>(false));
    local_10 = static_cast<uint>(9);
    uint _e111 = local_10;
    out[_e111] = metal::max(static_cast<int>(false), static_cast<int>(true));
    local_11 = static_cast<uint>(10);
    uint _e121 = local_11;
    out[_e121] = metal::min(metal::max(seed, naga_neg(5)), 2);
    local_12 = static_cast<uint>(11);
    uint _e134 = local_12;
    out[_e134] = static_cast<int>(metal::min(static_cast<uint>(naga_neg(2)), 4u) == 4u);
    int _e138 = min(seed, 4, 5);
    local_13 = static_cast<uint>(12);
    uint _e142 = local_13;
    out[_e142] = _e138;
    int _e144 = bounded(seed);
    local_14 = static_cast<uint>(13);
    uint _e148 = local_14;
    out[_e148] = _e144;
    first = 3;
    second = 7;
    int _e154 = first;
    first = as_type<int>(as_type<uint>(_e154) + as_type<uint>(1));
    int _e157 = second;
    second = as_type<int>(as_type<uint>(_e157) + as_type<uint>(1));
    local_15 = static_cast<uint>(14);
    uint _e164 = local_15;
    out[_e164] = metal::max(_e154, _e157);
    int _e166 = first;
    local_16 = static_cast<uint>(15);
    uint _e170 = local_16;
    out[_e170] = _e166;
    int _e172 = second;
    local_17 = static_cast<uint>(16);
    uint _e176 = local_17;
    out[_e176] = _e172;
    value = seed;
    int _e179 = value;
    int _e180 = value;
    value = as_type<int>(as_type<uint>(_e180) + as_type<uint>(1));
    local_18 = static_cast<uint>(17);
    uint _e187 = local_18;
    out[_e187] = metal::max(_e179, _e180);
    int _e189 = value;
    local_19 = static_cast<uint>(18);
    uint _e193 = local_19;
    out[_e193] = _e189;
    local_20 = static_cast<uint>(19);
    uint _e210 = local_20;
    out[_e210] = static_cast<int>(metal::min(as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)), 2147483647) == as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)));
    local_21 = static_cast<uint>(20);
    uint _e221 = local_21;
    out[_e221] = static_cast<int>(metal::max(4294967295u, 0u) == 4294967295u);
    local_22 = static_cast<uint>(21);
    uint _e233 = local_22;
    out[_e233] = static_cast<int>(metal::min(static_cast<uint>(false), 3u) == 0u);
    local_23 = static_cast<uint>(22);
    uint _e245 = local_23;
    out[_e245] = static_cast<int>(metal::max(static_cast<uint>(true), 0u) == 1u);
    local_24 = static_cast<uint>(23);
    uint _e251 = local_24;
    out[_e251] = metal::min(seed, seed);
}
