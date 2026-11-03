// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_4[1];

uint _naga_roundf(
    uint input_bits
) {
    uint _e5 = input_bits & 2147483647u;
    uint _e6 = input_bits & 2147483648u;
    uint _e13 = 1u << ((150u - (_e5 >> 23u)) & 31u);
    uint _e14 = _e13 - 1u;
    uint _e15 = input_bits & _e14;
    uint _e18 = input_bits & ~(_e14);
    return (_e5 > 2139095040u) ? 2143289344u : ((_e5 >= 1258291200u) ? input_bits : ((_e5 < 1065353216u) ? ((_e5 == 0u) ? input_bits : ((_e5 >= 1056964608u) ? (_e6 | 1065353216u) : _e6)) : (((_e15 >= (_e13 >> 1u)) && (_e15 != 0u)) ? (_e18 + _e13) : _e18)));
}

float rounded(
    float value_1
) {
    uint _e2 = _naga_roundf(as_type<uint>(value_1));
    return as_type<float>(_e2);
}

int roundf(
    bool value_2
) {
    int local_18 = {};
    if (value_2) {
        local_18 = 7;
    } else {
        local_18 = 9;
    }
    int _e6 = local_18;
    return _e6;
}

float roundf_1(
    float first,
    float second
) {
    return first + second;
}
int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}


kernel void rounds(
  device type_4& output [[buffer(0)]]
, constant _mslBufferSizes& _buffer_sizes [[buffer(1)]]
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
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint _e2 = _naga_roundf(as_type<uint>(0.0));
    output[static_cast<uint>(0)] = as_type<uint>(as_type<float>(_e2));
    uint _e12 = _naga_roundf(as_type<uint>(-(0.0)));
    output[static_cast<uint>(1)] = as_type<uint>(as_type<float>(_e12));
    uint _e20 = _naga_roundf(as_type<uint>(1.25));
    output[static_cast<uint>(2)] = as_type<uint>(as_type<float>(_e20));
    uint _e29 = _naga_roundf(as_type<uint>(-(1.75)));
    output[static_cast<uint>(3)] = as_type<uint>(as_type<float>(_e29));
    float _e37 = rounded(static_cast<float>(3));
    output[static_cast<uint>(4)] = as_type<uint>(_e37);
    float _e44 = rounded(static_cast<float>(5u));
    output[static_cast<uint>(5)] = as_type<uint>(_e44);
    int _e50 = roundf(true);
    output[static_cast<uint>(6)] = static_cast<uint>(_e50);
    int _e56 = roundf(false);
    output[static_cast<uint>(7)] = static_cast<uint>(_e56);
    float _e63 = rounded(static_cast<float>(true));
    output[static_cast<uint>(8)] = as_type<uint>(_e63);
    float _e70 = rounded(static_cast<float>(false));
    output[static_cast<uint>(9)] = as_type<uint>(_e70);
    local = 1u;
    uint _e77 = local;
    uint _e80 = _naga_roundf(as_type<uint>(as_type<float>(_e77)));
    output[static_cast<uint>(10)] = as_type<uint>(as_type<float>(_e80));
    local_1 = 2147483649u;
    uint _e88 = local_1;
    uint _e91 = _naga_roundf(as_type<uint>(as_type<float>(_e88)));
    output[static_cast<uint>(11)] = as_type<uint>(as_type<float>(_e91));
    local_2 = 8388607u;
    uint _e99 = local_2;
    uint _e102 = _naga_roundf(as_type<uint>(as_type<float>(_e99)));
    output[static_cast<uint>(12)] = as_type<uint>(as_type<float>(_e102));
    local_3 = 2155872255u;
    uint _e110 = local_3;
    uint _e113 = _naga_roundf(as_type<uint>(as_type<float>(_e110)));
    output[static_cast<uint>(13)] = as_type<uint>(as_type<float>(_e113));
    uint _e122 = _naga_roundf(as_type<uint>(-(0.25)));
    output[static_cast<uint>(14)] = as_type<uint>(as_type<float>(_e122));
    local_4 = 1258291199u;
    uint _e130 = local_4;
    uint _e133 = _naga_roundf(as_type<uint>(as_type<float>(_e130)));
    output[static_cast<uint>(15)] = as_type<uint>(as_type<float>(_e133));
    local_5 = 3405774847u;
    uint _e141 = local_5;
    uint _e144 = _naga_roundf(as_type<uint>(as_type<float>(_e141)));
    output[static_cast<uint>(16)] = as_type<uint>(as_type<float>(_e144));
    uint _e152 = _naga_roundf(as_type<uint>(340282350000000000000000000000000000000.0));
    output[static_cast<uint>(17)] = as_type<uint>(as_type<float>(_e152));
    uint _e161 = _naga_roundf(as_type<uint>(-(340282350000000000000000000000000000000.0)));
    output[static_cast<uint>(18)] = as_type<uint>(as_type<float>(_e161));
    local_6 = 2139095040u;
    uint _e169 = local_6;
    uint _e172 = _naga_roundf(as_type<uint>(as_type<float>(_e169)));
    output[static_cast<uint>(19)] = as_type<uint>(as_type<float>(_e172));
    local_7 = 4286578688u;
    uint _e180 = local_7;
    uint _e183 = _naga_roundf(as_type<uint>(as_type<float>(_e180)));
    output[static_cast<uint>(20)] = as_type<uint>(as_type<float>(_e183));
    local_8 = 2143363909u;
    uint _e191 = local_8;
    uint _e194 = _naga_roundf(as_type<uint>(as_type<float>(_e191)));
    output[static_cast<uint>(21)] = as_type<uint>(as_type<float>(_e194));
    local_9 = 4286578689u;
    uint _e202 = local_9;
    uint _e205 = _naga_roundf(as_type<uint>(as_type<float>(_e202)));
    output[static_cast<uint>(22)] = as_type<uint>(as_type<float>(_e205));
    value = 2.25;
    float _e213 = value;
    value = _e213 + static_cast<float>(1);
    float _e217 = rounded(_e213);
    output[static_cast<uint>(23)] = as_type<uint>(_e217);
    float _e222 = value;
    output[static_cast<uint>(24)] = as_type<uint>(_e222);
    float _e229 = roundf_1(2.0, 3.0);
    output[static_cast<uint>(25)] = as_type<uint>(_e229);
    float _e236 = rounded(static_cast<float>(4294967295u));
    output[static_cast<uint>(26)] = as_type<uint>(_e236);
    float _e246 = rounded(static_cast<float>(as_type<int>(as_type<uint>(naga_neg(2147483647)) - as_type<uint>(1))));
    output[static_cast<uint>(27)] = as_type<uint>(_e246);
    uint _e253 = _naga_roundf(as_type<uint>(10000000000.0));
    output[static_cast<uint>(28)] = as_type<uint>(as_type<float>(_e253));
    uint _e261 = _naga_roundf(as_type<uint>(1.5));
    output[static_cast<uint>(29)] = as_type<uint>(as_type<float>(_e261));
    uint _e270 = _naga_roundf(as_type<uint>(-(1.5)));
    output[static_cast<uint>(30)] = as_type<uint>(as_type<float>(_e270));
    uint _e278 = _naga_roundf(as_type<uint>(2.5));
    output[static_cast<uint>(31)] = as_type<uint>(as_type<float>(_e278));
    uint _e287 = _naga_roundf(as_type<uint>(-(2.5)));
    output[static_cast<uint>(32)] = as_type<uint>(as_type<float>(_e287));
    local_10 = 1056964607u;
    uint _e295 = local_10;
    uint _e298 = _naga_roundf(as_type<uint>(as_type<float>(_e295)));
    output[static_cast<uint>(33)] = as_type<uint>(as_type<float>(_e298));
    local_11 = 1056964609u;
    uint _e306 = local_11;
    uint _e309 = _naga_roundf(as_type<uint>(as_type<float>(_e306)));
    output[static_cast<uint>(34)] = as_type<uint>(as_type<float>(_e309));
    local_12 = 3204448255u;
    uint _e317 = local_12;
    uint _e320 = _naga_roundf(as_type<uint>(as_type<float>(_e317)));
    output[static_cast<uint>(35)] = as_type<uint>(as_type<float>(_e320));
    local_13 = 3204448257u;
    uint _e328 = local_13;
    uint _e331 = _naga_roundf(as_type<uint>(as_type<float>(_e328)));
    output[static_cast<uint>(36)] = as_type<uint>(as_type<float>(_e331));
    local_14 = 1249902593u;
    uint _e339 = local_14;
    uint _e342 = _naga_roundf(as_type<uint>(as_type<float>(_e339)));
    output[static_cast<uint>(37)] = as_type<uint>(as_type<float>(_e342));
    local_15 = 3397386241u;
    uint _e350 = local_15;
    uint _e353 = _naga_roundf(as_type<uint>(as_type<float>(_e350)));
    output[static_cast<uint>(38)] = as_type<uint>(as_type<float>(_e353));
    local_16 = 1258291197u;
    uint _e361 = local_16;
    uint _e364 = _naga_roundf(as_type<uint>(as_type<float>(_e361)));
    output[static_cast<uint>(39)] = as_type<uint>(as_type<float>(_e364));
    local_17 = 3405774845u;
    uint _e372 = local_17;
    uint _e375 = _naga_roundf(as_type<uint>(as_type<float>(_e372)));
    output[static_cast<uint>(40)] = as_type<uint>(as_type<float>(_e375));
}
