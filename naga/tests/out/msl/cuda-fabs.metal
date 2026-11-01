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

uint _naga_fabsf(
    uint input_bits
) {
    uint _e2 = input_bits & 2147483647u;
    return (_e2 > 2139095040u) ? 2143289344u : _e2;
}

metal::float2 fabs(
    metal::float2 value_1
) {
    metal::float2 value_2 = {};
    value_2 = value_1;
    float _e3 = value_2.x;
    uint _e5 = _naga_fabsf(as_type<uint>(_e3));
    float _e8 = value_2.y;
    uint _e10 = _naga_fabsf(as_type<uint>(_e8));
    return metal::float2(as_type<float>(_e5), as_type<float>(_e10));
}

float3_ fabs_1(
    float3_ value_3
) {
    float3_ value_4 = {};
    value_4 = value_3;
    float _e3 = value_4.x;
    uint _e5 = _naga_fabsf(as_type<uint>(_e3));
    float _e8 = value_4.y;
    uint _e10 = _naga_fabsf(as_type<uint>(_e8));
    float _e13 = value_4.z;
    uint _e15 = _naga_fabsf(as_type<uint>(_e13));
    return float3_ {as_type<float>(_e5), as_type<float>(_e10), as_type<float>(_e15)};
}

metal::float4 fabs_2(
    metal::float4 value_5
) {
    metal::float4 value_6 = {};
    value_6 = value_5;
    float _e3 = value_6.x;
    uint _e5 = _naga_fabsf(as_type<uint>(_e3));
    float _e8 = value_6.y;
    uint _e10 = _naga_fabsf(as_type<uint>(_e8));
    float _e13 = value_6.z;
    uint _e15 = _naga_fabsf(as_type<uint>(_e13));
    float _e18 = value_6.w;
    uint _e20 = _naga_fabsf(as_type<uint>(_e18));
    return metal::float4(as_type<float>(_e5), as_type<float>(_e10), as_type<float>(_e15), as_type<float>(_e20));
}

float absolute(
    float value_7
) {
    uint _e2 = _naga_fabsf(as_type<uint>(value_7));
    return as_type<float>(_e2);
}

float converted_absolute(
    int value_8
) {
    uint _e3 = _naga_fabsf(as_type<uint>(static_cast<float>(value_8)));
    return as_type<float>(_e3);
}

float converted_absolute_1(
    uint value_9
) {
    uint _e3 = _naga_fabsf(as_type<uint>(static_cast<float>(value_9)));
    return as_type<float>(_e3);
}

float converted_absolute_2(
    bool value_10
) {
    uint _e3 = _naga_fabsf(as_type<uint>(static_cast<float>(value_10)));
    return as_type<float>(_e3);
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
    int local_39 = {};
    if (value_13) {
        local_39 = 7;
    } else {
        local_39 = 9;
    }
    int _e6 = local_39;
    return _e6;
}

int fabsf(
    bool value_14
) {
    int local_40 = {};
    if (value_14) {
        local_40 = 11;
    } else {
        local_40 = 13;
    }
    int _e6 = local_40;
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
    float value = {};
    uint local_26 = {};
    uint local_27 = {};
    uint local_28 = {};
    uint local_29 = {};
    uint local_30 = {};
    uint local_31 = {};
    uint local_32 = {};
    float3_ triple = {};
    uint local_33 = {};
    uint local_34 = {};
    uint local_35 = {};
    uint local_36 = {};
    uint local_37 = {};
    metal::float2 pair = {};
    metal::float4 quadruple = {};
    uint local_38 = {};
    uint _e2 = _naga_fabsf(as_type<uint>(0.0));
    local = static_cast<uint>(0);
    uint _e8 = local;
    out[_e8] = as_type<uint>(as_type<float>(_e2));
    uint _e14 = _naga_fabsf(as_type<uint>(-(0.0)));
    local_1 = static_cast<uint>(1);
    uint _e20 = local_1;
    out[_e20] = as_type<uint>(as_type<float>(_e14));
    uint _e25 = _naga_fabsf(as_type<uint>(-(1.75)));
    local_2 = static_cast<uint>(2);
    uint _e31 = local_2;
    out[_e31] = as_type<uint>(as_type<float>(_e25));
    float _e35 = absolute(-(1.25));
    local_3 = static_cast<uint>(3);
    uint _e40 = local_3;
    out[_e40] = as_type<uint>(_e35);
    float _e44 = converted_absolute(naga_neg(3));
    local_4 = static_cast<uint>(4);
    uint _e49 = local_4;
    out[_e49] = as_type<uint>(_e44);
    float _e52 = converted_absolute_1(4294967295u);
    local_5 = static_cast<uint>(5);
    uint _e57 = local_5;
    out[_e57] = as_type<uint>(_e52);
    float _e60 = converted_absolute_2(true);
    local_6 = static_cast<uint>(6);
    uint _e65 = local_6;
    out[_e65] = as_type<uint>(_e60);
    float _e68 = converted_absolute_2(false);
    local_7 = static_cast<uint>(7);
    uint _e73 = local_7;
    out[_e73] = as_type<uint>(_e68);
    local_9 = 1u;
    uint _e77 = local_9;
    uint _e80 = _naga_fabsf(as_type<uint>(as_type<float>(_e77)));
    local_8 = static_cast<uint>(8);
    uint _e86 = local_8;
    out[_e86] = as_type<uint>(as_type<float>(_e80));
    local_11 = 2147483649u;
    uint _e90 = local_11;
    uint _e93 = _naga_fabsf(as_type<uint>(as_type<float>(_e90)));
    local_10 = static_cast<uint>(9);
    uint _e99 = local_10;
    out[_e99] = as_type<uint>(as_type<float>(_e93));
    local_13 = 8388607u;
    uint _e103 = local_13;
    uint _e106 = _naga_fabsf(as_type<uint>(as_type<float>(_e103)));
    local_12 = static_cast<uint>(10);
    uint _e112 = local_12;
    out[_e112] = as_type<uint>(as_type<float>(_e106));
    local_15 = 2155872255u;
    uint _e116 = local_15;
    uint _e119 = _naga_fabsf(as_type<uint>(as_type<float>(_e116)));
    local_14 = static_cast<uint>(11);
    uint _e125 = local_14;
    out[_e125] = as_type<uint>(as_type<float>(_e119));
    uint _e129 = _naga_fabsf(as_type<uint>(340282350000000000000000000000000000000.0));
    local_16 = static_cast<uint>(12);
    uint _e135 = local_16;
    out[_e135] = as_type<uint>(as_type<float>(_e129));
    uint _e140 = _naga_fabsf(as_type<uint>(-(340282350000000000000000000000000000000.0)));
    local_17 = static_cast<uint>(13);
    uint _e146 = local_17;
    out[_e146] = as_type<uint>(as_type<float>(_e140));
    local_19 = 2139095040u;
    uint _e150 = local_19;
    uint _e153 = _naga_fabsf(as_type<uint>(as_type<float>(_e150)));
    local_18 = static_cast<uint>(14);
    uint _e159 = local_18;
    out[_e159] = as_type<uint>(as_type<float>(_e153));
    local_21 = 4286578688u;
    uint _e163 = local_21;
    uint _e166 = _naga_fabsf(as_type<uint>(as_type<float>(_e163)));
    local_20 = static_cast<uint>(15);
    uint _e172 = local_20;
    out[_e172] = as_type<uint>(as_type<float>(_e166));
    local_23 = 2143363909u;
    uint _e176 = local_23;
    uint _e179 = _naga_fabsf(as_type<uint>(as_type<float>(_e176)));
    local_22 = static_cast<uint>(16);
    uint _e185 = local_22;
    out[_e185] = as_type<uint>(as_type<float>(_e179));
    local_25 = 2139095041u;
    uint _e189 = local_25;
    uint _e192 = _naga_fabsf(as_type<uint>(as_type<float>(_e189)));
    local_24 = static_cast<uint>(17);
    uint _e198 = local_24;
    out[_e198] = as_type<uint>(as_type<float>(_e192));
    value = -(2.75);
    float _e203 = value;
    value = _e203 + static_cast<float>(1);
    uint _e208 = _naga_fabsf(as_type<uint>(_e203));
    local_26 = static_cast<uint>(18);
    uint _e214 = local_26;
    out[_e214] = as_type<uint>(as_type<float>(_e208));
    float _e216 = value;
    local_27 = static_cast<uint>(19);
    uint _e221 = local_27;
    out[_e221] = as_type<uint>(_e216);
    int _e225 = fabs_3(naga_neg(3));
    local_28 = static_cast<uint>(20);
    uint _e230 = local_28;
    out[_e230] = static_cast<uint>(_e225);
    uint _e233 = fabs_4(3u);
    local_29 = static_cast<uint>(21);
    uint _e237 = local_29;
    out[_e237] = _e233;
    int _e240 = fabs_5(true);
    local_30 = static_cast<uint>(22);
    uint _e245 = local_30;
    out[_e245] = static_cast<uint>(_e240);
    int _e248 = fabs_5(false);
    local_31 = static_cast<uint>(23);
    uint _e253 = local_31;
    out[_e253] = static_cast<uint>(_e248);
    int _e256 = fabsf(true);
    local_32 = static_cast<uint>(24);
    uint _e261 = local_32;
    out[_e261] = static_cast<uint>(_e256);
    local_33 = 2147483649u;
    uint _e269 = local_33;
    float3_ _e272 = fabs_1(float3_ {-(2.5), -(0.0), as_type<float>(_e269)});
    triple = _e272;
    float _e275 = triple.x;
    local_34 = static_cast<uint>(25);
    uint _e280 = local_34;
    out[_e280] = as_type<uint>(_e275);
    float _e283 = triple.y;
    local_35 = static_cast<uint>(26);
    uint _e288 = local_35;
    out[_e288] = as_type<uint>(_e283);
    float _e291 = triple.z;
    local_36 = static_cast<uint>(27);
    uint _e296 = local_36;
    out[_e296] = as_type<uint>(_e291);
    float _e301 = fabsf_1(-(2.0), 3.0);
    local_37 = static_cast<uint>(28);
    uint _e306 = local_37;
    out[_e306] = as_type<uint>(_e301);
    metal::float2 _e313 = fabs(metal::float2(-(3.0), -(4.0)));
    pair = _e313;
    metal::float4 _e324 = fabs_2(metal::float4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e324;
    float _e328 = pair.x;
    float _e329 = pair.y;
    float _e332 = quadruple.x;
    float _e335 = quadruple.w;
    local_38 = static_cast<uint>(29);
    uint _e341 = local_38;
    out[_e341] = as_type<uint>(((_e328 + _e329) + _e332) + _e335);
}
