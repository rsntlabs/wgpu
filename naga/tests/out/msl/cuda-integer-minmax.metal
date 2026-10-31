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
    int local_25 = {};
    uint local_26 = {};
    int local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    uint local_38 = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_26 = static_cast<uint>(_e3);
    uint _e6 = local_26;
    int _e9 = out[_e6];
    local_27 = _e9;
    int _e11 = local_27;
    local_25 = _e11;
    int seed = local_25;
    local_1 = static_cast<uint>(0);
    uint _e20 = local_1;
    local_28 = static_cast<uint>(_e20);
    uint _e23 = local_28;
    out[_e23] = metal::min(seed, naga_neg(7));
    local_2 = static_cast<uint>(1);
    uint _e31 = local_2;
    local_29 = static_cast<uint>(_e31);
    uint _e34 = local_29;
    out[_e34] = metal::max(seed, naga_neg(7));
    local_3 = static_cast<uint>(2);
    uint _e43 = local_3;
    local_30 = static_cast<uint>(_e43);
    uint _e46 = local_30;
    out[_e46] = static_cast<int>(metal::min(3u, 9u));
    local_4 = static_cast<uint>(3);
    uint _e55 = local_4;
    local_31 = static_cast<uint>(_e55);
    uint _e58 = local_31;
    out[_e58] = static_cast<int>(metal::max(3u, 9u));
    local_5 = static_cast<uint>(4);
    uint _e71 = local_5;
    local_32 = static_cast<uint>(_e71);
    uint _e74 = local_32;
    out[_e74] = static_cast<int>(metal::min(static_cast<uint>(naga_neg(1)), 2u) == 2u);
    local_6 = static_cast<uint>(5);
    uint _e87 = local_6;
    local_33 = static_cast<uint>(_e87);
    uint _e90 = local_33;
    out[_e90] = static_cast<int>(metal::max(static_cast<uint>(naga_neg(1)), 2u) == 4294967295u);
    local_7 = static_cast<uint>(6);
    uint _e103 = local_7;
    local_34 = static_cast<uint>(_e103);
    uint _e106 = local_34;
    out[_e106] = static_cast<int>(metal::min(2u, static_cast<uint>(naga_neg(1))) == 2u);
    local_8 = static_cast<uint>(7);
    uint _e119 = local_8;
    local_35 = static_cast<uint>(_e119);
    uint _e122 = local_35;
    out[_e122] = static_cast<int>(metal::max(2u, static_cast<uint>(naga_neg(1))) == 4294967295u);
    local_9 = static_cast<uint>(8);
    uint _e132 = local_9;
    local_36 = static_cast<uint>(_e132);
    uint _e135 = local_36;
    out[_e135] = metal::min(static_cast<int>(true), static_cast<int>(false));
    local_10 = static_cast<uint>(9);
    uint _e145 = local_10;
    local_37 = static_cast<uint>(_e145);
    uint _e148 = local_37;
    out[_e148] = metal::max(static_cast<int>(false), static_cast<int>(true));
    local_11 = static_cast<uint>(10);
    uint _e158 = local_11;
    local_38 = static_cast<uint>(_e158);
    uint _e161 = local_38;
    out[_e161] = metal::min(metal::max(seed, naga_neg(5)), 2);
    local_12 = static_cast<uint>(11);
    uint _e174 = local_12;
    local_39 = static_cast<uint>(_e174);
    uint _e177 = local_39;
    out[_e177] = static_cast<int>(metal::min(static_cast<uint>(naga_neg(2)), 4u) == 4u);
    int _e181 = min(seed, 4, 5);
    local_13 = static_cast<uint>(12);
    uint _e185 = local_13;
    local_40 = static_cast<uint>(_e185);
    uint _e188 = local_40;
    out[_e188] = _e181;
    int _e190 = bounded(seed);
    local_14 = static_cast<uint>(13);
    uint _e194 = local_14;
    local_41 = static_cast<uint>(_e194);
    uint _e197 = local_41;
    out[_e197] = _e190;
    first = 3;
    second = 7;
    int _e203 = first;
    first = as_type<int>(as_type<uint>(_e203) + as_type<uint>(1));
    int _e206 = second;
    second = as_type<int>(as_type<uint>(_e206) + as_type<uint>(1));
    local_15 = static_cast<uint>(14);
    uint _e213 = local_15;
    local_42 = static_cast<uint>(_e213);
    uint _e216 = local_42;
    out[_e216] = metal::max(_e203, _e206);
    int _e218 = first;
    local_16 = static_cast<uint>(15);
    uint _e222 = local_16;
    local_43 = static_cast<uint>(_e222);
    uint _e225 = local_43;
    out[_e225] = _e218;
    int _e227 = second;
    local_17 = static_cast<uint>(16);
    uint _e231 = local_17;
    local_44 = static_cast<uint>(_e231);
    uint _e234 = local_44;
    out[_e234] = _e227;
    value = seed;
    int _e237 = value;
    int _e238 = value;
    value = as_type<int>(as_type<uint>(_e238) + as_type<uint>(1));
    local_18 = static_cast<uint>(17);
    uint _e245 = local_18;
    local_45 = static_cast<uint>(_e245);
    uint _e248 = local_45;
    out[_e248] = metal::max(_e237, _e238);
    int _e250 = value;
    local_19 = static_cast<uint>(18);
    uint _e254 = local_19;
    local_46 = static_cast<uint>(_e254);
    uint _e257 = local_46;
    out[_e257] = _e250;
    local_20 = static_cast<uint>(19);
    uint _e274 = local_20;
    local_47 = static_cast<uint>(_e274);
    uint _e277 = local_47;
    out[_e277] = static_cast<int>(metal::min(as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)), 2147483647) == as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)));
    local_21 = static_cast<uint>(20);
    uint _e288 = local_21;
    local_48 = static_cast<uint>(_e288);
    uint _e291 = local_48;
    out[_e291] = static_cast<int>(metal::max(4294967295u, 0u) == 4294967295u);
    local_22 = static_cast<uint>(21);
    uint _e303 = local_22;
    local_49 = static_cast<uint>(_e303);
    uint _e306 = local_49;
    out[_e306] = static_cast<int>(metal::min(static_cast<uint>(false), 3u) == 0u);
    local_23 = static_cast<uint>(22);
    uint _e318 = local_23;
    local_50 = static_cast<uint>(_e318);
    uint _e321 = local_50;
    out[_e321] = static_cast<int>(metal::max(static_cast<uint>(true), 0u) == 1u);
    local_24 = static_cast<uint>(23);
    uint _e327 = local_24;
    local_51 = static_cast<uint>(_e327);
    uint _e330 = local_51;
    out[_e330] = metal::min(seed, seed);
}
