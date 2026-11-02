// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef uint type_2[1];
constant float HexScale = 0.75;

float identity(
    float value_1
) {
    return value_1;
}

kernel void hex_float_literals(
  device type_2& output [[user(fake0)]]
, constant _mslBufferSizes& _buffer_sizes [[user(fake0)]]
) {
    uint counter = {};
    float value = {};
    counter = 0u;
    output[static_cast<uint>(0)] = as_type<uint>(0.0);
    output[static_cast<uint>(1)] = as_type<uint>(-(0.0));
    output[static_cast<uint>(2)] = as_type<uint>(1.0);
    output[static_cast<uint>(3)] = as_type<uint>(2.0);
    output[static_cast<uint>(4)] = as_type<uint>(1.0);
    output[static_cast<uint>(5)] = as_type<uint>(0.5);
    output[static_cast<uint>(6)] = as_type<uint>(3.0);
    output[static_cast<uint>(7)] = as_type<uint>(-(5.0));
    output[static_cast<uint>(8)] = as_type<uint>(0.000000000000000000000000000000000000011754944);
    output[static_cast<uint>(9)] = as_type<uint>(0.000000000000000000000000000000000000000000001);
    output[static_cast<uint>(10)] = as_type<uint>(0.000000000000000000000000000000000000011754942);
    output[static_cast<uint>(11)] = as_type<uint>(0.000000000000000000000000000000000000011754944);
    output[static_cast<uint>(12)] = as_type<uint>(0.0);
    output[static_cast<uint>(13)] = as_type<uint>(-(0.0));
    output[static_cast<uint>(14)] = as_type<uint>(0.000000000000000000000000000000000000000000001);
    output[static_cast<uint>(15)] = as_type<uint>(0.0);
    output[static_cast<uint>(16)] = as_type<uint>(0.000000000000000000000000000000000000000000003);
    output[static_cast<uint>(17)] = as_type<uint>(0.000000000000000000000000000000000000000000003);
    output[static_cast<uint>(18)] = as_type<uint>(0.000000000000000000000000000000000000000000006);
    output[static_cast<uint>(19)] = as_type<uint>(1.0);
    output[static_cast<uint>(20)] = as_type<uint>(1.0000002);
    output[static_cast<uint>(21)] = as_type<uint>(1.0000001);
    output[static_cast<uint>(22)] = as_type<uint>(1.0);
    output[static_cast<uint>(23)] = as_type<uint>(340282350000000000000000000000000000000.0);
    output[static_cast<uint>(24)] = as_type<uint>(-(340282350000000000000000000000000000000.0));
    output[static_cast<uint>(25)] = as_type<uint>(340282330000000000000000000000000000000.0);
    output[static_cast<uint>(26)] = as_type<uint>(340282350000000000000000000000000000000.0);
    output[static_cast<uint>(27)] = as_type<uint>(0.000000000000000000000000000000000000000000001);
    output[static_cast<uint>(28)] = as_type<uint>(-(0.000000000000000000000000000000000000000000001));
    output[static_cast<uint>(29)] = as_type<uint>(0.0);
    output[static_cast<uint>(30)] = as_type<uint>(72.8125);
    output[static_cast<uint>(31)] = as_type<uint>(0.25);
    output[static_cast<uint>(32)] = as_type<uint>(6.0);
    output[static_cast<uint>(33)] = as_type<uint>(4.0);
    output[static_cast<uint>(34)] = as_type<uint>(HexScale);
    float _e184 = identity(9.0);
    output[static_cast<uint>(35)] = as_type<uint>(_e184);
    value = float {};
    value = 3.0;
    uint _e193 = counter;
    counter = _e193 + static_cast<uint>(1);
    float _e197 = value;
    output[static_cast<uint>(36)] = as_type<uint>(_e197);
    output[static_cast<uint>(37)] = as_type<uint>(0.25 + 0.5);
    output[static_cast<uint>(38)] = as_type<uint>(0.0);
    uint _e214 = counter;
    output[static_cast<uint>(39)] = _e214;
}
