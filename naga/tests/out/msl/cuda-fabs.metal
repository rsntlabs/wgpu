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
    int local_9 = {};
    if (value_13) {
        local_9 = 7;
    } else {
        local_9 = 9;
    }
    int _e6 = local_9;
    return _e6;
}

int fabsf(
    bool value_14
) {
    int local_10 = {};
    if (value_14) {
        local_10 = 11;
    } else {
        local_10 = 13;
    }
    int _e6 = local_10;
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
    float value = {};
    float3_ triple = {};
    uint local_8 = {};
    metal::float2 pair = {};
    metal::float4 quadruple = {};
    uint _e2 = _naga_fabsf(as_type<uint>(0.0));
    out[static_cast<uint>(0)] = as_type<uint>(as_type<float>(_e2));
    uint _e12 = _naga_fabsf(as_type<uint>(-(0.0)));
    out[static_cast<uint>(1)] = as_type<uint>(as_type<float>(_e12));
    uint _e21 = _naga_fabsf(as_type<uint>(-(1.75)));
    out[static_cast<uint>(2)] = as_type<uint>(as_type<float>(_e21));
    float _e29 = absolute(-(1.25));
    out[static_cast<uint>(3)] = as_type<uint>(_e29);
    float _e36 = converted_absolute(naga_neg(3));
    out[static_cast<uint>(4)] = as_type<uint>(_e36);
    float _e42 = converted_absolute_1(4294967295u);
    out[static_cast<uint>(5)] = as_type<uint>(_e42);
    float _e48 = converted_absolute_2(true);
    out[static_cast<uint>(6)] = as_type<uint>(_e48);
    float _e54 = converted_absolute_2(false);
    out[static_cast<uint>(7)] = as_type<uint>(_e54);
    local = 1u;
    uint _e61 = local;
    uint _e64 = _naga_fabsf(as_type<uint>(as_type<float>(_e61)));
    out[static_cast<uint>(8)] = as_type<uint>(as_type<float>(_e64));
    local_1 = 2147483649u;
    uint _e72 = local_1;
    uint _e75 = _naga_fabsf(as_type<uint>(as_type<float>(_e72)));
    out[static_cast<uint>(9)] = as_type<uint>(as_type<float>(_e75));
    local_2 = 8388607u;
    uint _e83 = local_2;
    uint _e86 = _naga_fabsf(as_type<uint>(as_type<float>(_e83)));
    out[static_cast<uint>(10)] = as_type<uint>(as_type<float>(_e86));
    local_3 = 2155872255u;
    uint _e94 = local_3;
    uint _e97 = _naga_fabsf(as_type<uint>(as_type<float>(_e94)));
    out[static_cast<uint>(11)] = as_type<uint>(as_type<float>(_e97));
    uint _e105 = _naga_fabsf(as_type<uint>(340282350000000000000000000000000000000.0));
    out[static_cast<uint>(12)] = as_type<uint>(as_type<float>(_e105));
    uint _e114 = _naga_fabsf(as_type<uint>(-(340282350000000000000000000000000000000.0)));
    out[static_cast<uint>(13)] = as_type<uint>(as_type<float>(_e114));
    local_4 = 2139095040u;
    uint _e122 = local_4;
    uint _e125 = _naga_fabsf(as_type<uint>(as_type<float>(_e122)));
    out[static_cast<uint>(14)] = as_type<uint>(as_type<float>(_e125));
    local_5 = 4286578688u;
    uint _e133 = local_5;
    uint _e136 = _naga_fabsf(as_type<uint>(as_type<float>(_e133)));
    out[static_cast<uint>(15)] = as_type<uint>(as_type<float>(_e136));
    local_6 = 2143363909u;
    uint _e144 = local_6;
    uint _e147 = _naga_fabsf(as_type<uint>(as_type<float>(_e144)));
    out[static_cast<uint>(16)] = as_type<uint>(as_type<float>(_e147));
    local_7 = 2139095041u;
    uint _e155 = local_7;
    uint _e158 = _naga_fabsf(as_type<uint>(as_type<float>(_e155)));
    out[static_cast<uint>(17)] = as_type<uint>(as_type<float>(_e158));
    value = -(2.75);
    float _e167 = value;
    value = _e167 + static_cast<float>(1);
    uint _e172 = _naga_fabsf(as_type<uint>(_e167));
    out[static_cast<uint>(18)] = as_type<uint>(as_type<float>(_e172));
    float _e178 = value;
    out[static_cast<uint>(19)] = as_type<uint>(_e178);
    int _e185 = fabs_3(naga_neg(3));
    out[static_cast<uint>(20)] = static_cast<uint>(_e185);
    uint _e191 = fabs_4(3u);
    out[static_cast<uint>(21)] = _e191;
    int _e196 = fabs_5(true);
    out[static_cast<uint>(22)] = static_cast<uint>(_e196);
    int _e202 = fabs_5(false);
    out[static_cast<uint>(23)] = static_cast<uint>(_e202);
    int _e208 = fabsf(true);
    out[static_cast<uint>(24)] = static_cast<uint>(_e208);
    local_8 = 2147483649u;
    uint _e219 = local_8;
    float3_ _e222 = fabs_1(float3_ {-(2.5), -(0.0), as_type<float>(_e219)});
    triple = _e222;
    float _e225 = triple.x;
    out[static_cast<uint>(25)] = as_type<uint>(_e225);
    float _e231 = triple.y;
    out[static_cast<uint>(26)] = as_type<uint>(_e231);
    float _e237 = triple.z;
    out[static_cast<uint>(27)] = as_type<uint>(_e237);
    float _e245 = fabsf_1(-(2.0), 3.0);
    out[static_cast<uint>(28)] = as_type<uint>(_e245);
    metal::float2 _e255 = fabs(metal::float2(-(3.0), -(4.0)));
    pair = _e255;
    metal::float4 _e266 = fabs_2(metal::float4(-(1.0), -(2.0), -(3.0), -(4.0)));
    quadruple = _e266;
    float _e270 = pair.x;
    float _e271 = pair.y;
    float _e274 = quadruple.x;
    float _e277 = quadruple.w;
    out[static_cast<uint>(29)] = as_type<uint>(((_e270 + _e271) + _e274) + _e277);
}
