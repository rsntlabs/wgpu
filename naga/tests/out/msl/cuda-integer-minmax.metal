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
    uint local_25 = {};
    uint local_26 = {};
    uint local_27 = {};
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
    local = static_cast<uint>(0);
    uint _e3 = local;
    local_25 = static_cast<uint>(_e3);
    uint _e6 = local_25;
    int seed = out[_e6];
    local_1 = static_cast<uint>(0);
    uint _e16 = local_1;
    local_26 = static_cast<uint>(_e16);
    uint _e19 = local_26;
    out[_e19] = metal::min(seed, naga_neg(7));
    local_2 = static_cast<uint>(1);
    uint _e27 = local_2;
    local_27 = static_cast<uint>(_e27);
    uint _e30 = local_27;
    out[_e30] = metal::max(seed, naga_neg(7));
    local_3 = static_cast<uint>(2);
    uint _e39 = local_3;
    local_28 = static_cast<uint>(_e39);
    uint _e42 = local_28;
    out[_e42] = static_cast<int>(metal::min(3u, 9u));
    local_4 = static_cast<uint>(3);
    uint _e51 = local_4;
    local_29 = static_cast<uint>(_e51);
    uint _e54 = local_29;
    out[_e54] = static_cast<int>(metal::max(3u, 9u));
    local_5 = static_cast<uint>(4);
    uint _e67 = local_5;
    local_30 = static_cast<uint>(_e67);
    uint _e70 = local_30;
    out[_e70] = static_cast<int>(metal::min(static_cast<uint>(naga_neg(1)), 2u) == 2u);
    local_6 = static_cast<uint>(5);
    uint _e83 = local_6;
    local_31 = static_cast<uint>(_e83);
    uint _e86 = local_31;
    out[_e86] = static_cast<int>(metal::max(static_cast<uint>(naga_neg(1)), 2u) == 4294967295u);
    local_7 = static_cast<uint>(6);
    uint _e99 = local_7;
    local_32 = static_cast<uint>(_e99);
    uint _e102 = local_32;
    out[_e102] = static_cast<int>(metal::min(2u, static_cast<uint>(naga_neg(1))) == 2u);
    local_8 = static_cast<uint>(7);
    uint _e115 = local_8;
    local_33 = static_cast<uint>(_e115);
    uint _e118 = local_33;
    out[_e118] = static_cast<int>(metal::max(2u, static_cast<uint>(naga_neg(1))) == 4294967295u);
    local_9 = static_cast<uint>(8);
    uint _e128 = local_9;
    local_34 = static_cast<uint>(_e128);
    uint _e131 = local_34;
    out[_e131] = metal::min(static_cast<int>(true), static_cast<int>(false));
    local_10 = static_cast<uint>(9);
    uint _e141 = local_10;
    local_35 = static_cast<uint>(_e141);
    uint _e144 = local_35;
    out[_e144] = metal::max(static_cast<int>(false), static_cast<int>(true));
    local_11 = static_cast<uint>(10);
    uint _e154 = local_11;
    local_36 = static_cast<uint>(_e154);
    uint _e157 = local_36;
    out[_e157] = metal::min(metal::max(seed, naga_neg(5)), 2);
    local_12 = static_cast<uint>(11);
    uint _e170 = local_12;
    local_37 = static_cast<uint>(_e170);
    uint _e173 = local_37;
    out[_e173] = static_cast<int>(metal::min(static_cast<uint>(naga_neg(2)), 4u) == 4u);
    int _e177 = min(seed, 4, 5);
    local_13 = static_cast<uint>(12);
    uint _e181 = local_13;
    local_38 = static_cast<uint>(_e181);
    uint _e184 = local_38;
    out[_e184] = _e177;
    int _e186 = bounded(seed);
    local_14 = static_cast<uint>(13);
    uint _e190 = local_14;
    local_39 = static_cast<uint>(_e190);
    uint _e193 = local_39;
    out[_e193] = _e186;
    first = 3;
    second = 7;
    int _e199 = first;
    first = as_type<int>(as_type<uint>(_e199) + as_type<uint>(1));
    int _e202 = second;
    second = as_type<int>(as_type<uint>(_e202) + as_type<uint>(1));
    local_15 = static_cast<uint>(14);
    uint _e209 = local_15;
    local_40 = static_cast<uint>(_e209);
    uint _e212 = local_40;
    out[_e212] = metal::max(_e199, _e202);
    int _e214 = first;
    local_16 = static_cast<uint>(15);
    uint _e218 = local_16;
    local_41 = static_cast<uint>(_e218);
    uint _e221 = local_41;
    out[_e221] = _e214;
    int _e223 = second;
    local_17 = static_cast<uint>(16);
    uint _e227 = local_17;
    local_42 = static_cast<uint>(_e227);
    uint _e230 = local_42;
    out[_e230] = _e223;
    value = seed;
    int _e233 = value;
    int _e234 = value;
    value = as_type<int>(as_type<uint>(_e234) + as_type<uint>(1));
    local_18 = static_cast<uint>(17);
    uint _e241 = local_18;
    local_43 = static_cast<uint>(_e241);
    uint _e244 = local_43;
    out[_e244] = metal::max(_e233, _e234);
    int _e246 = value;
    local_19 = static_cast<uint>(18);
    uint _e250 = local_19;
    local_44 = static_cast<uint>(_e250);
    uint _e253 = local_44;
    out[_e253] = _e246;
    local_20 = static_cast<uint>(19);
    uint _e270 = local_20;
    local_45 = static_cast<uint>(_e270);
    uint _e273 = local_45;
    out[_e273] = static_cast<int>(metal::min(as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)), 2147483647) == as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)));
    local_21 = static_cast<uint>(20);
    uint _e284 = local_21;
    local_46 = static_cast<uint>(_e284);
    uint _e287 = local_46;
    out[_e287] = static_cast<int>(metal::max(4294967295u, 0u) == 4294967295u);
    local_22 = static_cast<uint>(21);
    uint _e299 = local_22;
    local_47 = static_cast<uint>(_e299);
    uint _e302 = local_47;
    out[_e302] = static_cast<int>(metal::min(static_cast<uint>(false), 3u) == 0u);
    local_23 = static_cast<uint>(22);
    uint _e314 = local_23;
    local_48 = static_cast<uint>(_e314);
    uint _e317 = local_48;
    out[_e317] = static_cast<int>(metal::max(static_cast<uint>(true), 0u) == 1u);
    local_24 = static_cast<uint>(23);
    uint _e323 = local_24;
    local_49 = static_cast<uint>(_e323);
    uint _e326 = local_49;
    out[_e326] = metal::min(seed, seed);
}
