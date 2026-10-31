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
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
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
    uint local_50 = {};
    uint local_51 = {};
    uint local_52 = {};
    uint local_53 = {};
    uint local_54 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    uint local_58 = {};
    uint local_59 = {};
    local = static_cast<uint>(0);
    uint _e8 = local;
    local_30 = static_cast<uint>(_e8);
    uint _e11 = local_30;
    out[_e11] = static_cast<uint>(metal::clz(static_cast<int>(true)));
    local_1 = static_cast<uint>(1);
    uint _e19 = local_1;
    local_31 = static_cast<uint>(_e19);
    uint _e22 = local_31;
    out[_e22] = static_cast<uint>(metal::clz(8));
    local_2 = static_cast<uint>(2);
    uint _e31 = local_2;
    local_32 = static_cast<uint>(_e31);
    uint _e34 = local_32;
    out[_e34] = static_cast<uint>(metal::clz(static_cast<int>(2147483648u)));
    local_3 = static_cast<uint>(3);
    uint _e43 = local_3;
    local_33 = static_cast<uint>(_e43);
    uint _e46 = local_33;
    out[_e46] = static_cast<uint>(metal::clz(naga_f2i32(8.75)));
    local_4 = static_cast<uint>(4);
    uint _e57 = local_4;
    local_34 = static_cast<uint>(_e57);
    uint _e60 = local_34;
    out[_e60] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(static_cast<int>(true)) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_5 = static_cast<uint>(5);
    uint _e70 = local_5;
    local_35 = static_cast<uint>(_e70);
    uint _e73 = local_35;
    out[_e73] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(8) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_6 = static_cast<uint>(6);
    uint _e84 = local_6;
    local_36 = static_cast<uint>(_e84);
    uint _e87 = local_36;
    out[_e87] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(static_cast<int>(2147483648u)) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_7 = static_cast<uint>(7);
    uint _e98 = local_7;
    local_37 = static_cast<uint>(_e98);
    uint _e101 = local_37;
    out[_e101] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(naga_f2i32(8.75)) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_8 = static_cast<uint>(8);
    uint _e111 = local_8;
    local_38 = static_cast<uint>(_e111);
    uint _e114 = local_38;
    out[_e114] = static_cast<uint>(static_cast<int>(metal::popcount(static_cast<uint>(true))));
    local_9 = static_cast<uint>(9);
    uint _e125 = local_9;
    local_39 = static_cast<uint>(_e125);
    uint _e128 = local_39;
    out[_e128] = static_cast<uint>(static_cast<int>(metal::popcount(static_cast<uint>(naga_neg(1)))));
    local_10 = static_cast<uint>(10);
    uint _e137 = local_10;
    local_40 = static_cast<uint>(_e137);
    uint _e140 = local_40;
    out[_e140] = static_cast<uint>(static_cast<int>(metal::popcount(2147483649u)));
    local_11 = static_cast<uint>(11);
    uint _e150 = local_11;
    local_41 = static_cast<uint>(_e150);
    uint _e153 = local_41;
    out[_e153] = static_cast<uint>(static_cast<int>(metal::popcount(naga_f2u32(3.75))));
    local_12 = static_cast<uint>(12);
    uint _e161 = local_12;
    local_42 = static_cast<uint>(_e161);
    uint _e164 = local_42;
    out[_e164] = metal::reverse_bits(static_cast<uint>(true));
    local_13 = static_cast<uint>(13);
    uint _e173 = local_13;
    local_43 = static_cast<uint>(_e173);
    uint _e176 = local_43;
    out[_e176] = metal::reverse_bits(static_cast<uint>(naga_neg(1)));
    local_14 = static_cast<uint>(14);
    uint _e183 = local_14;
    local_44 = static_cast<uint>(_e183);
    uint _e186 = local_44;
    out[_e186] = metal::reverse_bits(19088743u);
    local_15 = static_cast<uint>(15);
    uint _e194 = local_15;
    local_45 = static_cast<uint>(_e194);
    uint _e197 = local_45;
    out[_e197] = metal::reverse_bits(naga_f2u32(2.75));
    int _e200 = count(2147483649u);
    local_16 = static_cast<uint>(16);
    uint _e205 = local_16;
    local_46 = static_cast<uint>(_e205);
    uint _e208 = local_46;
    out[_e208] = static_cast<uint>(_e200);
    int _e212 = scan(static_cast<int>(2147483648u));
    local_17 = static_cast<uint>(17);
    uint _e217 = local_17;
    local_47 = static_cast<uint>(_e217);
    uint _e220 = local_47;
    out[_e220] = static_cast<uint>(_e212);
    local_18 = static_cast<uint>(18);
    uint _e228 = local_18;
    local_48 = static_cast<uint>(_e228);
    uint _e231 = local_48;
    out[_e231] = static_cast<uint>(metal::clz(0));
    local_19 = static_cast<uint>(19);
    uint _e241 = local_19;
    local_49 = static_cast<uint>(_e241);
    uint _e244 = local_49;
    out[_e244] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(0) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_20 = static_cast<uint>(20);
    uint _e253 = local_20;
    local_50 = static_cast<uint>(_e253);
    uint _e256 = local_50;
    out[_e256] = static_cast<uint>(static_cast<int>(metal::popcount(4294967295u)));
    local_21 = static_cast<uint>(21);
    uint _e263 = local_21;
    local_51 = static_cast<uint>(_e263);
    uint _e266 = local_51;
    out[_e266] = metal::reverse_bits(0u);
    local_22 = static_cast<uint>(22);
    uint _e273 = local_22;
    local_52 = static_cast<uint>(_e273);
    uint _e276 = local_52;
    out[_e276] = metal::reverse_bits(1u);
    local_23 = static_cast<uint>(23);
    uint _e283 = local_23;
    local_53 = static_cast<uint>(_e283);
    uint _e286 = local_53;
    out[_e286] = metal::reverse_bits(2147483648u);
    local_24 = static_cast<uint>(24);
    uint _e295 = local_24;
    local_54 = static_cast<uint>(_e295);
    uint _e298 = local_54;
    out[_e298] = static_cast<uint>(metal::clz(naga_neg(2)));
    local_25 = static_cast<uint>(25);
    uint _e309 = local_25;
    local_55 = static_cast<uint>(_e309);
    uint _e312 = local_55;
    out[_e312] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(naga_neg(2)) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_26 = static_cast<uint>(26);
    uint _e321 = local_26;
    local_56 = static_cast<uint>(_e321);
    uint _e324 = local_56;
    out[_e324] = static_cast<uint>(static_cast<int>(metal::popcount(2863311530u)));
    local_27 = static_cast<uint>(27);
    uint _e331 = local_27;
    local_57 = static_cast<uint>(_e331);
    uint _e334 = local_57;
    out[_e334] = metal::reverse_bits(2863311530u);
    int _e338 = _clz(3, 4);
    local_28 = static_cast<uint>(28);
    uint _e343 = local_28;
    local_58 = static_cast<uint>(_e343);
    uint _e346 = local_58;
    out[_e346] = static_cast<uint>(_e338);
    local_29 = static_cast<uint>(29);
    uint _e359 = local_29;
    local_59 = static_cast<uint>(_e359);
    uint _e362 = local_59;
    out[_e362] = static_cast<uint>(as_type<int>(as_type<uint>(static_cast<int>(metal::popcount(3u))) - as_type<uint>(3)) < 0);
}
