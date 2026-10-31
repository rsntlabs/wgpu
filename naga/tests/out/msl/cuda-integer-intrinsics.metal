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
    local = static_cast<uint>(0);
    uint _e7 = local;
    out[_e7] = static_cast<uint>(metal::clz(static_cast<int>(true)));
    local_1 = static_cast<uint>(1);
    uint _e16 = local_1;
    out[_e16] = static_cast<uint>(metal::clz(8));
    local_2 = static_cast<uint>(2);
    uint _e25 = local_2;
    out[_e25] = static_cast<uint>(metal::clz(static_cast<int>(2147483648u)));
    local_3 = static_cast<uint>(3);
    uint _e34 = local_3;
    out[_e34] = static_cast<uint>(metal::clz(naga_f2i32(8.75)));
    local_4 = static_cast<uint>(4);
    uint _e45 = local_4;
    out[_e45] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(static_cast<int>(true)) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_5 = static_cast<uint>(5);
    uint _e55 = local_5;
    out[_e55] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(8) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_6 = static_cast<uint>(6);
    uint _e66 = local_6;
    out[_e66] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(static_cast<int>(2147483648u)) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_7 = static_cast<uint>(7);
    uint _e77 = local_7;
    out[_e77] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(naga_f2i32(8.75)) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_8 = static_cast<uint>(8);
    uint _e87 = local_8;
    out[_e87] = static_cast<uint>(static_cast<int>(metal::popcount(static_cast<uint>(true))));
    local_9 = static_cast<uint>(9);
    uint _e98 = local_9;
    out[_e98] = static_cast<uint>(static_cast<int>(metal::popcount(static_cast<uint>(naga_neg(1)))));
    local_10 = static_cast<uint>(10);
    uint _e107 = local_10;
    out[_e107] = static_cast<uint>(static_cast<int>(metal::popcount(2147483649u)));
    local_11 = static_cast<uint>(11);
    uint _e117 = local_11;
    out[_e117] = static_cast<uint>(static_cast<int>(metal::popcount(naga_f2u32(3.75))));
    local_12 = static_cast<uint>(12);
    uint _e125 = local_12;
    out[_e125] = metal::reverse_bits(static_cast<uint>(true));
    local_13 = static_cast<uint>(13);
    uint _e134 = local_13;
    out[_e134] = metal::reverse_bits(static_cast<uint>(naga_neg(1)));
    local_14 = static_cast<uint>(14);
    uint _e141 = local_14;
    out[_e141] = metal::reverse_bits(19088743u);
    local_15 = static_cast<uint>(15);
    uint _e149 = local_15;
    out[_e149] = metal::reverse_bits(naga_f2u32(2.75));
    int _e152 = count(2147483649u);
    local_16 = static_cast<uint>(16);
    uint _e157 = local_16;
    out[_e157] = static_cast<uint>(_e152);
    int _e161 = scan(static_cast<int>(2147483648u));
    local_17 = static_cast<uint>(17);
    uint _e166 = local_17;
    out[_e166] = static_cast<uint>(_e161);
    local_18 = static_cast<uint>(18);
    uint _e174 = local_18;
    out[_e174] = static_cast<uint>(metal::clz(0));
    local_19 = static_cast<uint>(19);
    uint _e184 = local_19;
    out[_e184] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(0) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_20 = static_cast<uint>(20);
    uint _e193 = local_20;
    out[_e193] = static_cast<uint>(static_cast<int>(metal::popcount(4294967295u)));
    local_21 = static_cast<uint>(21);
    uint _e200 = local_21;
    out[_e200] = metal::reverse_bits(0u);
    local_22 = static_cast<uint>(22);
    uint _e207 = local_22;
    out[_e207] = metal::reverse_bits(1u);
    local_23 = static_cast<uint>(23);
    uint _e214 = local_23;
    out[_e214] = metal::reverse_bits(2147483648u);
    local_24 = static_cast<uint>(24);
    uint _e223 = local_24;
    out[_e223] = static_cast<uint>(metal::clz(naga_neg(2)));
    local_25 = static_cast<uint>(25);
    uint _e234 = local_25;
    out[_e234] = static_cast<uint>(as_type<int>(as_type<uint>((((metal::ctz(naga_neg(2)) + 1) % 33) - 1)) + as_type<uint>(1)));
    local_26 = static_cast<uint>(26);
    uint _e243 = local_26;
    out[_e243] = static_cast<uint>(static_cast<int>(metal::popcount(2863311530u)));
    local_27 = static_cast<uint>(27);
    uint _e250 = local_27;
    out[_e250] = metal::reverse_bits(2863311530u);
    int _e254 = _clz(3, 4);
    local_28 = static_cast<uint>(28);
    uint _e259 = local_28;
    out[_e259] = static_cast<uint>(_e254);
    local_29 = static_cast<uint>(29);
    uint _e272 = local_29;
    out[_e272] = static_cast<uint>(as_type<int>(as_type<uint>(static_cast<int>(metal::popcount(3u))) - as_type<uint>(3)) < 0);
}
