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
    int local_12 = {};
    if (value_5) {
        local_12 = 7;
    } else {
        local_12 = 9;
    }
    int _e6 = local_12;
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
    float value = {};
    uint local_10 = {};
    uint local_11 = {};
    uint _e2 = _naga_floorf(as_type<uint>(0.0));
    out[static_cast<uint>(0)] = as_type<uint>(as_type<float>(_e2));
    uint _e12 = _naga_floorf(as_type<uint>(-(0.0)));
    out[static_cast<uint>(1)] = as_type<uint>(as_type<float>(_e12));
    uint _e20 = _naga_floorf(as_type<uint>(1.75));
    out[static_cast<uint>(2)] = as_type<uint>(as_type<float>(_e20));
    uint _e29 = _naga_floorf(as_type<uint>(-(1.25)));
    out[static_cast<uint>(3)] = as_type<uint>(as_type<float>(_e29));
    float _e36 = floor_value_1(3);
    out[static_cast<uint>(4)] = as_type<uint>(_e36);
    float _e42 = floor_value_2(5u);
    out[static_cast<uint>(5)] = as_type<uint>(_e42);
    float _e48 = floor_value_3(true);
    out[static_cast<uint>(6)] = as_type<uint>(_e48);
    float _e54 = floor_value_3(false);
    out[static_cast<uint>(7)] = as_type<uint>(_e54);
    local = 1u;
    uint _e61 = local;
    uint _e64 = _naga_floorf(as_type<uint>(as_type<float>(_e61)));
    out[static_cast<uint>(8)] = as_type<uint>(as_type<float>(_e64));
    local_1 = 2147483649u;
    uint _e72 = local_1;
    uint _e75 = _naga_floorf(as_type<uint>(as_type<float>(_e72)));
    out[static_cast<uint>(9)] = as_type<uint>(as_type<float>(_e75));
    local_2 = 8388607u;
    uint _e83 = local_2;
    uint _e86 = _naga_floorf(as_type<uint>(as_type<float>(_e83)));
    out[static_cast<uint>(10)] = as_type<uint>(as_type<float>(_e86));
    local_3 = 2155872255u;
    uint _e94 = local_3;
    uint _e97 = _naga_floorf(as_type<uint>(as_type<float>(_e94)));
    out[static_cast<uint>(11)] = as_type<uint>(as_type<float>(_e97));
    uint _e105 = _naga_floorf(as_type<uint>(340282350000000000000000000000000000000.0));
    out[static_cast<uint>(12)] = as_type<uint>(as_type<float>(_e105));
    uint _e114 = _naga_floorf(as_type<uint>(-(340282350000000000000000000000000000000.0)));
    out[static_cast<uint>(13)] = as_type<uint>(as_type<float>(_e114));
    local_4 = 2139095039u;
    uint _e122 = local_4;
    uint _e125 = _naga_floorf(as_type<uint>(as_type<float>(_e122)));
    out[static_cast<uint>(14)] = as_type<uint>(as_type<float>(_e125));
    local_5 = 4286578687u;
    uint _e133 = local_5;
    uint _e136 = _naga_floorf(as_type<uint>(as_type<float>(_e133)));
    out[static_cast<uint>(15)] = as_type<uint>(as_type<float>(_e136));
    local_6 = 2139095040u;
    uint _e144 = local_6;
    uint _e147 = _naga_floorf(as_type<uint>(as_type<float>(_e144)));
    out[static_cast<uint>(16)] = as_type<uint>(as_type<float>(_e147));
    local_7 = 4286578688u;
    uint _e155 = local_7;
    uint _e158 = _naga_floorf(as_type<uint>(as_type<float>(_e155)));
    out[static_cast<uint>(17)] = as_type<uint>(as_type<float>(_e158));
    local_8 = 2143363909u;
    uint _e166 = local_8;
    uint _e169 = _naga_floorf(as_type<uint>(as_type<float>(_e166)));
    out[static_cast<uint>(18)] = as_type<uint>(as_type<float>(_e169));
    local_9 = 2139095041u;
    uint _e177 = local_9;
    uint _e180 = _naga_floorf(as_type<uint>(as_type<float>(_e177)));
    out[static_cast<uint>(19)] = as_type<uint>(as_type<float>(_e180));
    value = 2.75;
    float _e188 = value;
    value = _e188 + static_cast<float>(1);
    float _e192 = floor_value(_e188);
    out[static_cast<uint>(20)] = as_type<uint>(_e192);
    float _e197 = value;
    out[static_cast<uint>(21)] = as_type<uint>(_e197);
    int _e203 = floorf(true);
    out[static_cast<uint>(22)] = static_cast<uint>(_e203);
    int _e209 = floorf(false);
    out[static_cast<uint>(23)] = static_cast<uint>(_e209);
    float _e216 = floorf_1(2.0, 3.0);
    out[static_cast<uint>(24)] = as_type<uint>(_e216);
    local_10 = 1258291199u;
    uint _e223 = local_10;
    uint _e226 = _naga_floorf(as_type<uint>(as_type<float>(_e223)));
    out[static_cast<uint>(25)] = as_type<uint>(as_type<float>(_e226));
    local_11 = 3405774847u;
    uint _e234 = local_11;
    uint _e237 = _naga_floorf(as_type<uint>(as_type<float>(_e234)));
    out[static_cast<uint>(26)] = as_type<uint>(as_type<float>(_e237));
    float _e244 = floor_value_2(4294967295u);
    out[static_cast<uint>(27)] = as_type<uint>(_e244);
    float _e253 = floor_value_1(as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1)));
    out[static_cast<uint>(28)] = as_type<uint>(_e253);
    uint _e260 = _naga_floorf(as_type<uint>(10000000000.0));
    out[static_cast<uint>(29)] = as_type<uint>(as_type<float>(_e260));
}
