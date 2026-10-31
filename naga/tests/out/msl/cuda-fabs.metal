// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

struct float3_ {
    float x;
    float y;
    float z;
};
typedef uint type_6[1];

metal::float2 fabs(
    metal::float2 value_1
) {
    metal::float2 value_2 = {};
    uint local_53 = {};
    uint local_54 = {};
    value_2 = value_1;
    float _e3 = value_2.x;
    uint _e6 = as_type<uint>(_e3) & 2147483647u;
    local_53 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_53;
    float _e15 = value_2.y;
    uint _e18 = as_type<uint>(_e15) & 2147483647u;
    local_54 = (_e18 > 2139095040u) ? 2143289344u : _e18;
    uint _e24 = local_54;
    return metal::float2(as_type<float>(_e12), as_type<float>(_e24));
}

float3_ fabs_1(
    float3_ value_3
) {
    float3_ value_4 = {};
    uint local_55 = {};
    uint local_56 = {};
    uint local_57 = {};
    value_4 = value_3;
    float _e3 = value_4.x;
    uint _e6 = as_type<uint>(_e3) & 2147483647u;
    local_55 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_55;
    float _e15 = value_4.y;
    uint _e18 = as_type<uint>(_e15) & 2147483647u;
    local_56 = (_e18 > 2139095040u) ? 2143289344u : _e18;
    uint _e24 = local_56;
    float _e27 = value_4.z;
    uint _e30 = as_type<uint>(_e27) & 2147483647u;
    local_57 = (_e30 > 2139095040u) ? 2143289344u : _e30;
    uint _e36 = local_57;
    return float3_ {as_type<float>(_e12), as_type<float>(_e24), as_type<float>(_e36)};
}

metal::float4 fabs_2(
    metal::float4 value_5
) {
    metal::float4 value_6 = {};
    uint local_58 = {};
    uint local_59 = {};
    uint local_60 = {};
    uint local_61 = {};
    value_6 = value_5;
    float _e3 = value_6.x;
    uint _e6 = as_type<uint>(_e3) & 2147483647u;
    local_58 = (_e6 > 2139095040u) ? 2143289344u : _e6;
    uint _e12 = local_58;
    float _e15 = value_6.y;
    uint _e18 = as_type<uint>(_e15) & 2147483647u;
    local_59 = (_e18 > 2139095040u) ? 2143289344u : _e18;
    uint _e24 = local_59;
    float _e27 = value_6.z;
    uint _e30 = as_type<uint>(_e27) & 2147483647u;
    local_60 = (_e30 > 2139095040u) ? 2143289344u : _e30;
    uint _e36 = local_60;
    float _e39 = value_6.w;
    uint _e42 = as_type<uint>(_e39) & 2147483647u;
    local_61 = (_e42 > 2139095040u) ? 2143289344u : _e42;
    uint _e48 = local_61;
    return metal::float4(as_type<float>(_e12), as_type<float>(_e24), as_type<float>(_e36), as_type<float>(_e48));
}

float absolute(
    float value_7
) {
    uint local_62 = {};
    uint _e3 = as_type<uint>(value_7) & 2147483647u;
    local_62 = (_e3 > 2139095040u) ? 2143289344u : _e3;
    uint _e9 = local_62;
    return as_type<float>(_e9);
}

float converted_absolute(
    int value_8
) {
    uint local_63 = {};
    uint _e4 = as_type<uint>(static_cast<float>(value_8)) & 2147483647u;
    local_63 = (_e4 > 2139095040u) ? 2143289344u : _e4;
    uint _e10 = local_63;
    return as_type<float>(_e10);
}

float converted_absolute_1(
    uint value_9
) {
    uint local_64 = {};
    uint _e4 = as_type<uint>(static_cast<float>(value_9)) & 2147483647u;
    local_64 = (_e4 > 2139095040u) ? 2143289344u : _e4;
    uint _e10 = local_64;
    return as_type<float>(_e10);
}

float converted_absolute_2(
    bool value_10
) {
    uint local_65 = {};
    uint _e4 = as_type<uint>(static_cast<float>(value_10)) & 2147483647u;
    local_65 = (_e4 > 2139095040u) ? 2143289344u : _e4;
    uint _e10 = local_65;
    return as_type<float>(_e10);
}

int fabs_3(
    int value_11
) {
    return as_type<int>(as_type<uint>(value_11) + as_type<uint>(40));
}

uint fabs_4(
    uint value_12
) {
    return value_12 + 50u;
}

int fabs_5(
    bool value_13
) {
    int local_66 = {};
    if (value_13) {
        local_66 = 7;
    } else {
        local_66 = 9;
    }
    int _e6 = local_66;
    return _e6;
}

int fabsf(
    bool value_14
) {
    int local_67 = {};
    if (value_14) {
        local_67 = 11;
    } else {
        local_67 = 13;
    }
    int _e6 = local_67;
    return _e6;
}

float fabsf_1(
    float first,
    float second
) {
    return first + second;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void absolutes(
  device type_6& out [[user(fake0)]]
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
    float value = {};
    uint local_39 = {};
    uint local_40 = {};
    uint local_41 = {};
    uint local_42 = {};
    uint local_43 = {};
    uint local_44 = {};
    uint local_45 = {};
    uint local_46 = {};
    float3_ triple = {};
    uint local_47 = {};
    uint local_48 = {};
    uint local_49 = {};
    uint local_50 = {};
    uint local_51 = {};
    metal::float2 pair = {};
    metal::float4 quadruple = {};
    uint local_52 = {};
    uint _e3 = as_type<uint>(0.0) & 2147483647u;
    local_1 = (_e3 > 2139095040u) ? 2143289344u : _e3;
    uint _e9 = local_1;
    local = static_cast<uint>(0);
    uint _e15 = local;
    out[_e15] = as_type<uint>(as_type<float>(_e9));
    uint _e22 = as_type<uint>(-(0.0)) & 2147483647u;
    local_3 = (_e22 > 2139095040u) ? 2143289344u : _e22;
    uint _e28 = local_3;
    local_2 = static_cast<uint>(1);
    uint _e34 = local_2;
    out[_e34] = as_type<uint>(as_type<float>(_e28));
    uint _e40 = as_type<uint>(-(1.75)) & 2147483647u;
    local_5 = (_e40 > 2139095040u) ? 2143289344u : _e40;
    uint _e46 = local_5;
    local_4 = static_cast<uint>(2);
    uint _e52 = local_4;
    out[_e52] = as_type<uint>(as_type<float>(_e46));
    float _e56 = absolute(-(1.25));
    local_6 = static_cast<uint>(3);
    uint _e61 = local_6;
    out[_e61] = as_type<uint>(_e56);
    float _e65 = converted_absolute(naga_neg(3));
    local_7 = static_cast<uint>(4);
    uint _e70 = local_7;
    out[_e70] = as_type<uint>(_e65);
    float _e73 = converted_absolute_1(4294967295u);
    local_8 = static_cast<uint>(5);
    uint _e78 = local_8;
    out[_e78] = as_type<uint>(_e73);
    float _e81 = converted_absolute_2(true);
    local_9 = static_cast<uint>(6);
    uint _e86 = local_9;
    out[_e86] = as_type<uint>(_e81);
    float _e89 = converted_absolute_2(false);
    local_10 = static_cast<uint>(7);
    uint _e94 = local_10;
    out[_e94] = as_type<uint>(_e89);
    local_12 = 1u;
    uint _e98 = local_12;
    uint _e102 = as_type<uint>(as_type<float>(_e98)) & 2147483647u;
    local_13 = (_e102 > 2139095040u) ? 2143289344u : _e102;
    uint _e108 = local_13;
    local_11 = static_cast<uint>(8);
    uint _e114 = local_11;
    out[_e114] = as_type<uint>(as_type<float>(_e108));
    local_15 = 2147483649u;
    uint _e118 = local_15;
    uint _e122 = as_type<uint>(as_type<float>(_e118)) & 2147483647u;
    local_16 = (_e122 > 2139095040u) ? 2143289344u : _e122;
    uint _e128 = local_16;
    local_14 = static_cast<uint>(9);
    uint _e134 = local_14;
    out[_e134] = as_type<uint>(as_type<float>(_e128));
    local_18 = 8388607u;
    uint _e138 = local_18;
    uint _e142 = as_type<uint>(as_type<float>(_e138)) & 2147483647u;
    local_19 = (_e142 > 2139095040u) ? 2143289344u : _e142;
    uint _e148 = local_19;
    local_17 = static_cast<uint>(10);
    uint _e154 = local_17;
    out[_e154] = as_type<uint>(as_type<float>(_e148));
    local_21 = 2155872255u;
    uint _e158 = local_21;
    uint _e162 = as_type<uint>(as_type<float>(_e158)) & 2147483647u;
    local_22 = (_e162 > 2139095040u) ? 2143289344u : _e162;
    uint _e168 = local_22;
    local_20 = static_cast<uint>(11);
    uint _e174 = local_20;
    out[_e174] = as_type<uint>(as_type<float>(_e168));
    uint _e179 = as_type<uint>(340282350000000000000000000000000000000.0) & 2147483647u;
    local_24 = (_e179 > 2139095040u) ? 2143289344u : _e179;
    uint _e185 = local_24;
    local_23 = static_cast<uint>(12);
    uint _e191 = local_23;
    out[_e191] = as_type<uint>(as_type<float>(_e185));
    uint _e197 = as_type<uint>(-(340282350000000000000000000000000000000.0)) & 2147483647u;
    local_26 = (_e197 > 2139095040u) ? 2143289344u : _e197;
    uint _e203 = local_26;
    local_25 = static_cast<uint>(13);
    uint _e209 = local_25;
    out[_e209] = as_type<uint>(as_type<float>(_e203));
    local_28 = 2139095040u;
    uint _e213 = local_28;
    uint _e217 = as_type<uint>(as_type<float>(_e213)) & 2147483647u;
    local_29 = (_e217 > 2139095040u) ? 2143289344u : _e217;
    uint _e223 = local_29;
    local_27 = static_cast<uint>(14);
    uint _e229 = local_27;
    out[_e229] = as_type<uint>(as_type<float>(_e223));
    local_31 = 4286578688u;
    uint _e233 = local_31;
    uint _e237 = as_type<uint>(as_type<float>(_e233)) & 2147483647u;
    local_32 = (_e237 > 2139095040u) ? 2143289344u : _e237;
    uint _e243 = local_32;
    local_30 = static_cast<uint>(15);
    uint _e249 = local_30;
    out[_e249] = as_type<uint>(as_type<float>(_e243));
    local_34 = 2143363909u;
    uint _e253 = local_34;
    uint _e257 = as_type<uint>(as_type<float>(_e253)) & 2147483647u;
    local_35 = (_e257 > 2139095040u) ? 2143289344u : _e257;
    uint _e263 = local_35;
    local_33 = static_cast<uint>(16);
    uint _e269 = local_33;
    out[_e269] = as_type<uint>(as_type<float>(_e263));
    local_37 = 2139095041u;
    uint _e273 = local_37;
    uint _e277 = as_type<uint>(as_type<float>(_e273)) & 2147483647u;
    local_38 = (_e277 > 2139095040u) ? 2143289344u : _e277;
    uint _e283 = local_38;
    local_36 = static_cast<uint>(17);
    uint _e289 = local_36;
    out[_e289] = as_type<uint>(as_type<float>(_e283));
    value = -(2.75);
    float _e294 = value;
    value = _e294 + static_cast<float>(1);
    uint _e300 = as_type<uint>(_e294) & 2147483647u;
    local_40 = (_e300 > 2139095040u) ? 2143289344u : _e300;
    uint _e306 = local_40;
    local_39 = static_cast<uint>(18);
    uint _e312 = local_39;
    out[_e312] = as_type<uint>(as_type<float>(_e306));
    float _e314 = value;
    local_41 = static_cast<uint>(19);
    uint _e319 = local_41;
    out[_e319] = as_type<uint>(_e314);
    int _e323 = fabs_3(naga_neg(3));
    local_42 = static_cast<uint>(20);
    uint _e328 = local_42;
    out[_e328] = static_cast<uint>(_e323);
    uint _e331 = fabs_4(3u);
    local_43 = static_cast<uint>(21);
    uint _e335 = local_43;
    out[_e335] = _e331;
    int _e338 = fabs_5(true);
    local_44 = static_cast<uint>(22);
    uint _e343 = local_44;
    out[_e343] = static_cast<uint>(_e338);
    int _e346 = fabs_5(false);
    local_45 = static_cast<uint>(23);
    uint _e351 = local_45;
    out[_e351] = static_cast<uint>(_e346);
    int _e354 = fabsf(true);
    local_46 = static_cast<uint>(24);
    uint _e359 = local_46;
    out[_e359] = static_cast<uint>(_e354);
    local_47 = 2147483649u;
    uint _e367 = local_47;
    float3_ _e370 = fabs_1(float3_ {-(2.5), -(0.0), as_type<float>(_e367)});
    triple = _e370;
    float _e373 = triple.x;
    local_48 = static_cast<uint>(25);
    uint _e378 = local_48;
    out[_e378] = as_type<uint>(_e373);
    float _e381 = triple.y;
    local_49 = static_cast<uint>(26);
    uint _e386 = local_49;
    out[_e386] = as_type<uint>(_e381);
    float _e389 = triple.z;
    local_50 = static_cast<uint>(27);
    uint _e394 = local_50;
    out[_e394] = as_type<uint>(_e389);
    float _e399 = fabsf_1(-(2.0), 3.0);
    local_51 = static_cast<uint>(28);
    uint _e404 = local_51;
    out[_e404] = as_type<uint>(_e399);
    metal::float2 _e411 = fabs(metal::float2(-(3.0), -(4.0)));
    pair = _e411;
    metal::float4 _e422 = fabs_2(metal::float4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e422;
    float _e426 = pair.x;
    float _e427 = pair.y;
    float _e430 = quadruple.x;
    float _e433 = quadruple.w;
    local_52 = static_cast<uint>(29);
    uint _e439 = local_52;
    out[_e439] = as_type<uint>(((_e426 + _e427) + _e430) + _e433);
}
