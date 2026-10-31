// language: metal1.0
#include <metal_stdlib>
#include <simd/simd.h>

using metal::uint;

struct _mslBufferSizes {
    uint size0;
};

typedef float type_1[1];

float min(
    float first_1,
    float second_1,
    float third
) {
    uint _e3 = as_type<uint>(first_1);
    bool _e12 = (_e3 & 2147483647u) > 2139095040u;
    uint _e13 = as_type<uint>(second_1);
    bool _e19 = (_e13 & 2147483647u) > 2139095040u;
    uint _e28 = as_type<uint>(as_type<float>((_e12 && _e19) ? 2143289344u : (_e19 ? _e3 : (_e12 ? _e13 : ((((_e3 >= 2147483648u) ? ~(_e3) : (_e3 ^ 2147483648u)) < ((_e13 >= 2147483648u) ? ~(_e13) : (_e13 ^ 2147483648u))) ? _e3 : _e13)))));
    bool _e37 = (_e28 & 2147483647u) > 2139095040u;
    uint _e38 = as_type<uint>(third);
    bool _e44 = (_e38 & 2147483647u) > 2139095040u;
    return as_type<float>((_e37 && _e44) ? 2143289344u : (_e44 ? _e28 : (_e37 ? _e38 : ((((_e28 >= 2147483648u) ? ~(_e28) : (_e28 ^ 2147483648u)) < ((_e38 >= 2147483648u) ? ~(_e38) : (_e38 ^ 2147483648u))) ? _e28 : _e38))));
}

int naga_neg(int val) {
    return as_type<int>(-as_type<uint>(val));
}

float bounded(
    float value_1
) {
    uint _e6 = as_type<uint>(value_1);
    bool _e15 = (_e6 & 2147483647u) > 2139095040u;
    uint _e16 = as_type<uint>(static_cast<float>(4));
    bool _e22 = (_e16 & 2147483647u) > 2139095040u;
    uint _e31 = as_type<uint>(static_cast<float>(naga_neg(2)));
    bool _e40 = (_e31 & 2147483647u) > 2139095040u;
    uint _e41 = as_type<uint>(as_type<float>((_e15 && _e22) ? 2143289344u : (_e22 ? _e6 : (_e15 ? _e16 : ((((_e6 >= 2147483648u) ? ~(_e6) : (_e6 ^ 2147483648u)) < ((_e16 >= 2147483648u) ? ~(_e16) : (_e16 ^ 2147483648u))) ? _e6 : _e16)))));
    bool _e47 = (_e41 & 2147483647u) > 2139095040u;
    return as_type<float>((_e40 && _e47) ? 2143289344u : (_e47 ? _e31 : (_e40 ? _e41 : ((((_e31 >= 2147483648u) ? ~(_e31) : (_e31 ^ 2147483648u)) > ((_e41 >= 2147483648u) ? ~(_e41) : (_e41 ^ 2147483648u))) ? _e31 : _e41))));
}

kernel void float_minmax(
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
    float first = {};
    float second = {};
    uint local_12 = {};
    uint local_13 = {};
    uint local_14 = {};
    float value = {};
    uint local_15 = {};
    uint local_16 = {};
    uint local_17 = {};
    uint local_18 = {};
    uint local_19 = {};
    uint local_20 = {};
    local = static_cast<uint>(0);
    uint _e3 = local;
    float seed = out[_e3];
    uint _e9 = as_type<uint>(seed);
    bool _e18 = (_e9 & 2147483647u) > 2139095040u;
    uint _e19 = as_type<uint>(-(7.5));
    bool _e25 = (_e19 & 2147483647u) > 2139095040u;
    local_1 = static_cast<uint>(0);
    uint _e37 = local_1;
    out[_e37] = as_type<float>((_e18 && _e25) ? 2143289344u : (_e25 ? _e9 : (_e18 ? _e19 : ((((_e9 >= 2147483648u) ? ~(_e9) : (_e9 ^ 2147483648u)) < ((_e19 >= 2147483648u) ? ~(_e19) : (_e19 ^ 2147483648u))) ? _e9 : _e19))));
    uint _e41 = as_type<uint>(seed);
    bool _e50 = (_e41 & 2147483647u) > 2139095040u;
    uint _e51 = as_type<uint>(-(7.5));
    bool _e57 = (_e51 & 2147483647u) > 2139095040u;
    local_2 = static_cast<uint>(1);
    uint _e69 = local_2;
    out[_e69] = as_type<float>((_e50 && _e57) ? 2143289344u : (_e57 ? _e41 : (_e50 ? _e51 : ((((_e41 >= 2147483648u) ? ~(_e41) : (_e41 ^ 2147483648u)) > ((_e51 >= 2147483648u) ? ~(_e51) : (_e51 ^ 2147483648u))) ? _e41 : _e51))));
    uint _e71 = as_type<uint>(seed);
    bool _e80 = (_e71 & 2147483647u) > 2139095040u;
    uint _e82 = as_type<uint>(1.5);
    bool _e88 = (_e82 & 2147483647u) > 2139095040u;
    local_3 = static_cast<uint>(2);
    uint _e100 = local_3;
    out[_e100] = as_type<float>((_e80 && _e88) ? 2143289344u : (_e88 ? _e71 : (_e80 ? _e82 : ((((_e71 >= 2147483648u) ? ~(_e71) : (_e71 ^ 2147483648u)) < ((_e82 >= 2147483648u) ? ~(_e82) : (_e82 ^ 2147483648u))) ? _e71 : _e82))));
    uint _e104 = as_type<uint>(-(2.25));
    bool _e113 = (_e104 & 2147483647u) > 2139095040u;
    uint _e114 = as_type<uint>(seed);
    bool _e120 = (_e114 & 2147483647u) > 2139095040u;
    local_4 = static_cast<uint>(3);
    uint _e132 = local_4;
    out[_e132] = as_type<float>((_e113 && _e120) ? 2143289344u : (_e120 ? _e104 : (_e113 ? _e114 : ((((_e104 >= 2147483648u) ? ~(_e104) : (_e104 ^ 2147483648u)) > ((_e114 >= 2147483648u) ? ~(_e114) : (_e114 ^ 2147483648u))) ? _e104 : _e114))));
    uint _e139 = as_type<uint>(static_cast<float>(naga_neg(3)));
    bool _e148 = (_e139 & 2147483647u) > 2139095040u;
    uint _e149 = as_type<uint>(static_cast<float>(5u));
    bool _e155 = (_e149 & 2147483647u) > 2139095040u;
    local_5 = static_cast<uint>(4);
    uint _e167 = local_5;
    out[_e167] = as_type<float>((_e148 && _e155) ? 2143289344u : (_e155 ? _e139 : (_e148 ? _e149 : ((((_e139 >= 2147483648u) ? ~(_e139) : (_e139 ^ 2147483648u)) < ((_e149 >= 2147483648u) ? ~(_e149) : (_e149 ^ 2147483648u))) ? _e139 : _e149))));
    uint _e174 = as_type<uint>(static_cast<float>(5u));
    bool _e183 = (_e174 & 2147483647u) > 2139095040u;
    uint _e184 = as_type<uint>(static_cast<float>(naga_neg(3)));
    bool _e190 = (_e184 & 2147483647u) > 2139095040u;
    local_6 = static_cast<uint>(5);
    uint _e202 = local_6;
    out[_e202] = as_type<float>((_e183 && _e190) ? 2143289344u : (_e190 ? _e174 : (_e183 ? _e184 : ((((_e174 >= 2147483648u) ? ~(_e174) : (_e174 ^ 2147483648u)) > ((_e184 >= 2147483648u) ? ~(_e184) : (_e184 ^ 2147483648u))) ? _e174 : _e184))));
    uint _e208 = as_type<uint>(static_cast<float>(true));
    bool _e217 = (_e208 & 2147483647u) > 2139095040u;
    uint _e218 = as_type<uint>(static_cast<float>(false));
    bool _e224 = (_e218 & 2147483647u) > 2139095040u;
    local_7 = static_cast<uint>(6);
    uint _e236 = local_7;
    out[_e236] = as_type<float>((_e217 && _e224) ? 2143289344u : (_e224 ? _e208 : (_e217 ? _e218 : ((((_e208 >= 2147483648u) ? ~(_e208) : (_e208 ^ 2147483648u)) < ((_e218 >= 2147483648u) ? ~(_e218) : (_e218 ^ 2147483648u))) ? _e208 : _e218))));
    uint _e242 = as_type<uint>(static_cast<float>(false));
    bool _e251 = (_e242 & 2147483647u) > 2139095040u;
    uint _e252 = as_type<uint>(static_cast<float>(true));
    bool _e258 = (_e252 & 2147483647u) > 2139095040u;
    local_8 = static_cast<uint>(7);
    uint _e270 = local_8;
    out[_e270] = as_type<float>((_e251 && _e258) ? 2143289344u : (_e258 ? _e242 : (_e251 ? _e252 : ((((_e242 >= 2147483648u) ? ~(_e242) : (_e242 ^ 2147483648u)) > ((_e252 >= 2147483648u) ? ~(_e252) : (_e252 ^ 2147483648u))) ? _e242 : _e252))));
    uint _e274 = as_type<uint>(seed);
    bool _e283 = (_e274 & 2147483647u) > 2139095040u;
    uint _e284 = as_type<uint>(-(4.0));
    bool _e290 = (_e284 & 2147483647u) > 2139095040u;
    uint _e299 = as_type<uint>(as_type<float>((_e283 && _e290) ? 2143289344u : (_e290 ? _e274 : (_e283 ? _e284 : ((((_e274 >= 2147483648u) ? ~(_e274) : (_e274 ^ 2147483648u)) > ((_e284 >= 2147483648u) ? ~(_e284) : (_e284 ^ 2147483648u))) ? _e274 : _e284)))));
    bool _e308 = (_e299 & 2147483647u) > 2139095040u;
    uint _e310 = as_type<uint>(2.5);
    bool _e316 = (_e310 & 2147483647u) > 2139095040u;
    local_9 = static_cast<uint>(8);
    uint _e328 = local_9;
    out[_e328] = as_type<float>((_e308 && _e316) ? 2143289344u : (_e316 ? _e299 : (_e308 ? _e310 : ((((_e299 >= 2147483648u) ? ~(_e299) : (_e299 ^ 2147483648u)) < ((_e310 >= 2147483648u) ? ~(_e310) : (_e310 ^ 2147483648u))) ? _e299 : _e310))));
    float _e333 = min(seed, 1.25, -(3.5));
    local_10 = static_cast<uint>(9);
    uint _e337 = local_10;
    out[_e337] = _e333;
    float _e339 = bounded(seed);
    local_11 = static_cast<uint>(10);
    uint _e343 = local_11;
    out[_e343] = _e339;
    first = 1.25;
    second = 2.5;
    float _e349 = first;
    first = _e349 + static_cast<float>(1);
    float _e353 = second;
    second = _e353 + static_cast<float>(1);
    uint _e357 = as_type<uint>(_e349);
    bool _e366 = (_e357 & 2147483647u) > 2139095040u;
    uint _e367 = as_type<uint>(_e353);
    bool _e373 = (_e367 & 2147483647u) > 2139095040u;
    local_12 = static_cast<uint>(11);
    uint _e385 = local_12;
    out[_e385] = as_type<float>((_e366 && _e373) ? 2143289344u : (_e373 ? _e357 : (_e366 ? _e367 : ((((_e357 >= 2147483648u) ? ~(_e357) : (_e357 ^ 2147483648u)) > ((_e367 >= 2147483648u) ? ~(_e367) : (_e367 ^ 2147483648u))) ? _e357 : _e367))));
    float _e387 = first;
    local_13 = static_cast<uint>(12);
    uint _e391 = local_13;
    out[_e391] = _e387;
    float _e393 = second;
    local_14 = static_cast<uint>(13);
    uint _e397 = local_14;
    out[_e397] = _e393;
    value = seed;
    float _e400 = value;
    float _e401 = value;
    value = _e401 + static_cast<float>(1);
    uint _e405 = as_type<uint>(_e400);
    bool _e414 = (_e405 & 2147483647u) > 2139095040u;
    uint _e415 = as_type<uint>(_e401);
    bool _e421 = (_e415 & 2147483647u) > 2139095040u;
    local_15 = static_cast<uint>(14);
    uint _e433 = local_15;
    out[_e433] = as_type<float>((_e414 && _e421) ? 2143289344u : (_e421 ? _e405 : (_e414 ? _e415 : ((((_e405 >= 2147483648u) ? ~(_e405) : (_e405 ^ 2147483648u)) > ((_e415 >= 2147483648u) ? ~(_e415) : (_e415 ^ 2147483648u))) ? _e405 : _e415))));
    float _e435 = value;
    local_16 = static_cast<uint>(15);
    uint _e439 = local_16;
    out[_e439] = _e435;
    uint _e443 = as_type<uint>(static_cast<float>(16777217));
    bool _e452 = (_e443 & 2147483647u) > 2139095040u;
    uint _e454 = as_type<uint>(16777216.0);
    bool _e460 = (_e454 & 2147483647u) > 2139095040u;
    local_17 = static_cast<uint>(16);
    uint _e472 = local_17;
    out[_e472] = as_type<float>((_e452 && _e460) ? 2143289344u : (_e460 ? _e443 : (_e452 ? _e454 : ((((_e443 >= 2147483648u) ? ~(_e443) : (_e443 ^ 2147483648u)) > ((_e454 >= 2147483648u) ? ~(_e454) : (_e454 ^ 2147483648u))) ? _e443 : _e454))));
    uint _e476 = as_type<uint>(static_cast<float>(4294967295u));
    bool _e485 = (_e476 & 2147483647u) > 2139095040u;
    uint _e487 = as_type<uint>(4294967300.0);
    bool _e493 = (_e487 & 2147483647u) > 2139095040u;
    local_18 = static_cast<uint>(17);
    uint _e505 = local_18;
    out[_e505] = as_type<float>((_e485 && _e493) ? 2143289344u : (_e493 ? _e476 : (_e485 ? _e487 : ((((_e476 >= 2147483648u) ? ~(_e476) : (_e476 ^ 2147483648u)) < ((_e487 >= 2147483648u) ? ~(_e487) : (_e487 ^ 2147483648u))) ? _e476 : _e487))));
    uint _e509 = as_type<uint>(static_cast<float>(true));
    bool _e518 = (_e509 & 2147483647u) > 2139095040u;
    uint _e519 = as_type<uint>(seed);
    bool _e525 = (_e519 & 2147483647u) > 2139095040u;
    local_19 = static_cast<uint>(18);
    uint _e537 = local_19;
    out[_e537] = as_type<float>((_e518 && _e525) ? 2143289344u : (_e525 ? _e509 : (_e518 ? _e519 : ((((_e509 >= 2147483648u) ? ~(_e509) : (_e509 ^ 2147483648u)) > ((_e519 >= 2147483648u) ? ~(_e519) : (_e519 ^ 2147483648u))) ? _e509 : _e519))));
    uint _e539 = as_type<uint>(seed);
    bool _e548 = (_e539 & 2147483647u) > 2139095040u;
    uint _e549 = as_type<uint>(seed);
    bool _e555 = (_e549 & 2147483647u) > 2139095040u;
    local_20 = static_cast<uint>(19);
    uint _e567 = local_20;
    out[_e567] = as_type<float>((_e548 && _e555) ? 2143289344u : (_e555 ? _e539 : (_e548 ? _e549 : ((((_e539 >= 2147483648u) ? ~(_e539) : (_e539 ^ 2147483648u)) < ((_e549 >= 2147483648u) ? ~(_e549) : (_e549 ^ 2147483648u))) ? _e539 : _e549))));
}
