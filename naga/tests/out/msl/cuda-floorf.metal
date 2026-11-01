// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_4[1];

uint _naga_floorf(
    uint input_bits
) {
    uint _e5 = input_bits & 2147483647u;
    bool _e7 = (input_bits & 2147483648u) != 0u;
    uint _e14 = 1u << ((150u - (_e5 >> 23u)) & 31u);
    uint _e15 = _e14 - 1u;
    uint _e19 = input_bits & ~(_e15);
    return (_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : (_e7 ? 3212836864u : 0u)) : ((_e7 && ((input_bits & _e15) != 0u)) ? (_e19 + _e14) : _e19)));
}

float floor_value(
    float value_1
) {
    uint _e2 = _naga_floorf(as_type<uint>(value_1));
    return as_type<float>(_e2);
}

float floor_value_1(
    int value_2
) {
    uint _e3 = _naga_floorf(as_type<uint>(static_cast<float>(value_2)));
    return as_type<float>(_e3);
}

float floor_value_2(
    uint value_3
) {
    uint _e3 = _naga_floorf(as_type<uint>(static_cast<float>(value_3)));
    return as_type<float>(_e3);
}

float floor_value_3(
    bool value_4
) {
    uint _e3 = _naga_floorf(as_type<uint>(static_cast<float>(value_4)));
    return as_type<float>(_e3);
}

int floorf(
    bool value_5
) {
    int local_42 = {};
    if (value_5) {
        local_42 = 7;
    } else {
        local_42 = 9;
    }
    int _e6 = local_42;
    return _e6;
}

float floorf_1(
    float first,
    float second
) {
    return first + second;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void floors(
  device type_4& out [[user(fake0)]]
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
    float value = {};
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
    uint _e2 = _naga_floorf(as_type<uint>(0.0));
    local = static_cast<uint>(0);
    uint _e8 = local;
    out[_e8] = as_type<uint>(as_type<float>(_e2));
    uint _e14 = _naga_floorf(as_type<uint>(-(0.0)));
    local_1 = static_cast<uint>(1);
    uint _e20 = local_1;
    out[_e20] = as_type<uint>(as_type<float>(_e14));
    uint _e24 = _naga_floorf(as_type<uint>(1.75));
    local_2 = static_cast<uint>(2);
    uint _e30 = local_2;
    out[_e30] = as_type<uint>(as_type<float>(_e24));
    uint _e35 = _naga_floorf(as_type<uint>(-(1.25)));
    local_3 = static_cast<uint>(3);
    uint _e41 = local_3;
    out[_e41] = as_type<uint>(as_type<float>(_e35));
    float _e44 = floor_value_1(3);
    local_4 = static_cast<uint>(4);
    uint _e49 = local_4;
    out[_e49] = as_type<uint>(_e44);
    float _e52 = floor_value_2(5u);
    local_5 = static_cast<uint>(5);
    uint _e57 = local_5;
    out[_e57] = as_type<uint>(_e52);
    float _e60 = floor_value_3(true);
    local_6 = static_cast<uint>(6);
    uint _e65 = local_6;
    out[_e65] = as_type<uint>(_e60);
    float _e68 = floor_value_3(false);
    local_7 = static_cast<uint>(7);
    uint _e73 = local_7;
    out[_e73] = as_type<uint>(_e68);
    local_9 = 1u;
    uint _e77 = local_9;
    uint _e80 = _naga_floorf(as_type<uint>(as_type<float>(_e77)));
    local_8 = static_cast<uint>(8);
    uint _e86 = local_8;
    out[_e86] = as_type<uint>(as_type<float>(_e80));
    local_11 = 2147483649u;
    uint _e90 = local_11;
    uint _e93 = _naga_floorf(as_type<uint>(as_type<float>(_e90)));
    local_10 = static_cast<uint>(9);
    uint _e99 = local_10;
    out[_e99] = as_type<uint>(as_type<float>(_e93));
    local_13 = 8388607u;
    uint _e103 = local_13;
    uint _e106 = _naga_floorf(as_type<uint>(as_type<float>(_e103)));
    local_12 = static_cast<uint>(10);
    uint _e112 = local_12;
    out[_e112] = as_type<uint>(as_type<float>(_e106));
    local_15 = 2155872255u;
    uint _e116 = local_15;
    uint _e119 = _naga_floorf(as_type<uint>(as_type<float>(_e116)));
    local_14 = static_cast<uint>(11);
    uint _e125 = local_14;
    out[_e125] = as_type<uint>(as_type<float>(_e119));
    uint _e129 = _naga_floorf(as_type<uint>(340282350000000000000000000000000000000.0));
    local_16 = static_cast<uint>(12);
    uint _e135 = local_16;
    out[_e135] = as_type<uint>(as_type<float>(_e129));
    uint _e140 = _naga_floorf(as_type<uint>(-(340282350000000000000000000000000000000.0)));
    local_17 = static_cast<uint>(13);
    uint _e146 = local_17;
    out[_e146] = as_type<uint>(as_type<float>(_e140));
    local_19 = 2139095039u;
    uint _e150 = local_19;
    uint _e153 = _naga_floorf(as_type<uint>(as_type<float>(_e150)));
    local_18 = static_cast<uint>(14);
    uint _e159 = local_18;
    out[_e159] = as_type<uint>(as_type<float>(_e153));
    local_21 = 4286578687u;
    uint _e163 = local_21;
    uint _e166 = _naga_floorf(as_type<uint>(as_type<float>(_e163)));
    local_20 = static_cast<uint>(15);
    uint _e172 = local_20;
    out[_e172] = as_type<uint>(as_type<float>(_e166));
    local_23 = 2139095040u;
    uint _e176 = local_23;
    uint _e179 = _naga_floorf(as_type<uint>(as_type<float>(_e176)));
    local_22 = static_cast<uint>(16);
    uint _e185 = local_22;
    out[_e185] = as_type<uint>(as_type<float>(_e179));
    local_25 = 4286578688u;
    uint _e189 = local_25;
    uint _e192 = _naga_floorf(as_type<uint>(as_type<float>(_e189)));
    local_24 = static_cast<uint>(17);
    uint _e198 = local_24;
    out[_e198] = as_type<uint>(as_type<float>(_e192));
    local_27 = 2143363909u;
    uint _e202 = local_27;
    uint _e205 = _naga_floorf(as_type<uint>(as_type<float>(_e202)));
    local_26 = static_cast<uint>(18);
    uint _e211 = local_26;
    out[_e211] = as_type<uint>(as_type<float>(_e205));
    local_29 = 2139095041u;
    uint _e215 = local_29;
    uint _e218 = _naga_floorf(as_type<uint>(as_type<float>(_e215)));
    local_28 = static_cast<uint>(19);
    uint _e224 = local_28;
    out[_e224] = as_type<uint>(as_type<float>(_e218));
    value = 2.75;
    float _e228 = value;
    value = _e228 + static_cast<float>(1);
    float _e232 = floor_value(_e228);
    local_30 = static_cast<uint>(20);
    uint _e237 = local_30;
    out[_e237] = as_type<uint>(_e232);
    float _e239 = value;
    local_31 = static_cast<uint>(21);
    uint _e244 = local_31;
    out[_e244] = as_type<uint>(_e239);
    int _e247 = floorf(true);
    local_32 = static_cast<uint>(22);
    uint _e252 = local_32;
    out[_e252] = static_cast<uint>(_e247);
    int _e255 = floorf(false);
    local_33 = static_cast<uint>(23);
    uint _e260 = local_33;
    out[_e260] = static_cast<uint>(_e255);
    float _e264 = floorf_1(2.0, 3.0);
    local_34 = static_cast<uint>(24);
    uint _e269 = local_34;
    out[_e269] = as_type<uint>(_e264);
    local_36 = 1258291199u;
    uint _e273 = local_36;
    uint _e276 = _naga_floorf(as_type<uint>(as_type<float>(_e273)));
    local_35 = static_cast<uint>(25);
    uint _e282 = local_35;
    out[_e282] = as_type<uint>(as_type<float>(_e276));
    local_38 = 3405774847u;
    uint _e286 = local_38;
    uint _e289 = _naga_floorf(as_type<uint>(as_type<float>(_e286)));
    local_37 = static_cast<uint>(26);
    uint _e295 = local_37;
    out[_e295] = as_type<uint>(as_type<float>(_e289));
    float _e298 = floor_value_2(4294967295u);
    local_39 = static_cast<uint>(27);
    uint _e303 = local_39;
    out[_e303] = as_type<uint>(_e298);
    float _e309 = floor_value_1(as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)));
    local_40 = static_cast<uint>(28);
    uint _e314 = local_40;
    out[_e314] = as_type<uint>(_e309);
    uint _e318 = _naga_floorf(as_type<uint>(10000000000.0));
    local_41 = static_cast<uint>(29);
    uint _e324 = local_41;
    out[_e324] = as_type<uint>(as_type<float>(_e318));
}
