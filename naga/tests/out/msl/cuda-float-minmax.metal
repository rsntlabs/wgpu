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
    float first = {};
    float second = {};
    float value = {};
    float seed = out[static_cast<uint>(0)];
    uint _e7 = as_type<uint>(seed);
    bool _e16 = (_e7 & 2147483647u) > 2139095040u;
    uint _e17 = as_type<uint>(-(7.5));
    bool _e23 = (_e17 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(0)] = as_type<float>((_e16 && _e23) ? 2143289344u : (_e23 ? _e7 : (_e16 ? _e17 : ((((_e7 >= 2147483648u) ? ~(_e7) : (_e7 ^ 2147483648u)) < ((_e17 >= 2147483648u) ? ~(_e17) : (_e17 ^ 2147483648u))) ? _e7 : _e17))));
    uint _e37 = as_type<uint>(seed);
    bool _e46 = (_e37 & 2147483647u) > 2139095040u;
    uint _e47 = as_type<uint>(-(7.5));
    bool _e53 = (_e47 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(1)] = as_type<float>((_e46 && _e53) ? 2143289344u : (_e53 ? _e37 : (_e46 ? _e47 : ((((_e37 >= 2147483648u) ? ~(_e37) : (_e37 ^ 2147483648u)) > ((_e47 >= 2147483648u) ? ~(_e47) : (_e47 ^ 2147483648u))) ? _e37 : _e47))));
    uint _e65 = as_type<uint>(seed);
    bool _e74 = (_e65 & 2147483647u) > 2139095040u;
    uint _e76 = as_type<uint>(1.5);
    bool _e82 = (_e76 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(2)] = as_type<float>((_e74 && _e82) ? 2143289344u : (_e82 ? _e65 : (_e74 ? _e76 : ((((_e65 >= 2147483648u) ? ~(_e65) : (_e65 ^ 2147483648u)) < ((_e76 >= 2147483648u) ? ~(_e76) : (_e76 ^ 2147483648u))) ? _e65 : _e76))));
    uint _e96 = as_type<uint>(-(2.25));
    bool _e105 = (_e96 & 2147483647u) > 2139095040u;
    uint _e106 = as_type<uint>(seed);
    bool _e112 = (_e106 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(3)] = as_type<float>((_e105 && _e112) ? 2143289344u : (_e112 ? _e96 : (_e105 ? _e106 : ((((_e96 >= 2147483648u) ? ~(_e96) : (_e96 ^ 2147483648u)) > ((_e106 >= 2147483648u) ? ~(_e106) : (_e106 ^ 2147483648u))) ? _e96 : _e106))));
    uint _e129 = as_type<uint>(static_cast<float>(naga_neg(3)));
    bool _e138 = (_e129 & 2147483647u) > 2139095040u;
    uint _e139 = as_type<uint>(static_cast<float>(5u));
    bool _e145 = (_e139 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(4)] = as_type<float>((_e138 && _e145) ? 2143289344u : (_e145 ? _e129 : (_e138 ? _e139 : ((((_e129 >= 2147483648u) ? ~(_e129) : (_e129 ^ 2147483648u)) < ((_e139 >= 2147483648u) ? ~(_e139) : (_e139 ^ 2147483648u))) ? _e129 : _e139))));
    uint _e162 = as_type<uint>(static_cast<float>(5u));
    bool _e171 = (_e162 & 2147483647u) > 2139095040u;
    uint _e172 = as_type<uint>(static_cast<float>(naga_neg(3)));
    bool _e178 = (_e172 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(5)] = as_type<float>((_e171 && _e178) ? 2143289344u : (_e178 ? _e162 : (_e171 ? _e172 : ((((_e162 >= 2147483648u) ? ~(_e162) : (_e162 ^ 2147483648u)) > ((_e172 >= 2147483648u) ? ~(_e172) : (_e172 ^ 2147483648u))) ? _e162 : _e172))));
    uint _e194 = as_type<uint>(static_cast<float>(true));
    bool _e203 = (_e194 & 2147483647u) > 2139095040u;
    uint _e204 = as_type<uint>(static_cast<float>(false));
    bool _e210 = (_e204 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(6)] = as_type<float>((_e203 && _e210) ? 2143289344u : (_e210 ? _e194 : (_e203 ? _e204 : ((((_e194 >= 2147483648u) ? ~(_e194) : (_e194 ^ 2147483648u)) < ((_e204 >= 2147483648u) ? ~(_e204) : (_e204 ^ 2147483648u))) ? _e194 : _e204))));
    uint _e226 = as_type<uint>(static_cast<float>(false));
    bool _e235 = (_e226 & 2147483647u) > 2139095040u;
    uint _e236 = as_type<uint>(static_cast<float>(true));
    bool _e242 = (_e236 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(7)] = as_type<float>((_e235 && _e242) ? 2143289344u : (_e242 ? _e226 : (_e235 ? _e236 : ((((_e226 >= 2147483648u) ? ~(_e226) : (_e226 ^ 2147483648u)) > ((_e236 >= 2147483648u) ? ~(_e236) : (_e236 ^ 2147483648u))) ? _e226 : _e236))));
    uint _e256 = as_type<uint>(seed);
    bool _e265 = (_e256 & 2147483647u) > 2139095040u;
    uint _e266 = as_type<uint>(-(4.0));
    bool _e272 = (_e266 & 2147483647u) > 2139095040u;
    uint _e281 = as_type<uint>(as_type<float>((_e265 && _e272) ? 2143289344u : (_e272 ? _e256 : (_e265 ? _e266 : ((((_e256 >= 2147483648u) ? ~(_e256) : (_e256 ^ 2147483648u)) > ((_e266 >= 2147483648u) ? ~(_e266) : (_e266 ^ 2147483648u))) ? _e256 : _e266)))));
    bool _e290 = (_e281 & 2147483647u) > 2139095040u;
    uint _e292 = as_type<uint>(2.5);
    bool _e298 = (_e292 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(8)] = as_type<float>((_e290 && _e298) ? 2143289344u : (_e298 ? _e281 : (_e290 ? _e292 : ((((_e281 >= 2147483648u) ? ~(_e281) : (_e281 ^ 2147483648u)) < ((_e292 >= 2147483648u) ? ~(_e292) : (_e292 ^ 2147483648u))) ? _e281 : _e292))));
    float _e313 = min(seed, 1.25, -(3.5));
    out[static_cast<uint>(9)] = _e313;
    float _e317 = bounded(seed);
    out[static_cast<uint>(10)] = _e317;
    first = 1.25;
    second = 2.5;
    float _e325 = first;
    first = _e325 + static_cast<float>(1);
    float _e329 = second;
    second = _e329 + static_cast<float>(1);
    uint _e333 = as_type<uint>(_e325);
    bool _e342 = (_e333 & 2147483647u) > 2139095040u;
    uint _e343 = as_type<uint>(_e329);
    bool _e349 = (_e343 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(11)] = as_type<float>((_e342 && _e349) ? 2143289344u : (_e349 ? _e333 : (_e342 ? _e343 : ((((_e333 >= 2147483648u) ? ~(_e333) : (_e333 ^ 2147483648u)) > ((_e343 >= 2147483648u) ? ~(_e343) : (_e343 ^ 2147483648u))) ? _e333 : _e343))));
    float _e361 = first;
    out[static_cast<uint>(12)] = _e361;
    float _e365 = second;
    out[static_cast<uint>(13)] = _e365;
    value = seed;
    float _e370 = value;
    float _e371 = value;
    value = _e371 + static_cast<float>(1);
    uint _e375 = as_type<uint>(_e370);
    bool _e384 = (_e375 & 2147483647u) > 2139095040u;
    uint _e385 = as_type<uint>(_e371);
    bool _e391 = (_e385 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(14)] = as_type<float>((_e384 && _e391) ? 2143289344u : (_e391 ? _e375 : (_e384 ? _e385 : ((((_e375 >= 2147483648u) ? ~(_e375) : (_e375 ^ 2147483648u)) > ((_e385 >= 2147483648u) ? ~(_e385) : (_e385 ^ 2147483648u))) ? _e375 : _e385))));
    float _e403 = value;
    out[static_cast<uint>(15)] = _e403;
    uint _e409 = as_type<uint>(static_cast<float>(16777217));
    bool _e418 = (_e409 & 2147483647u) > 2139095040u;
    uint _e420 = as_type<uint>(16777216.0);
    bool _e426 = (_e420 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(16)] = as_type<float>((_e418 && _e426) ? 2143289344u : (_e426 ? _e409 : (_e418 ? _e420 : ((((_e409 >= 2147483648u) ? ~(_e409) : (_e409 ^ 2147483648u)) > ((_e420 >= 2147483648u) ? ~(_e420) : (_e420 ^ 2147483648u))) ? _e409 : _e420))));
    uint _e440 = as_type<uint>(static_cast<float>(4294967295u));
    bool _e449 = (_e440 & 2147483647u) > 2139095040u;
    uint _e451 = as_type<uint>(4294967300.0);
    bool _e457 = (_e451 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(17)] = as_type<float>((_e449 && _e457) ? 2143289344u : (_e457 ? _e440 : (_e449 ? _e451 : ((((_e440 >= 2147483648u) ? ~(_e440) : (_e440 ^ 2147483648u)) < ((_e451 >= 2147483648u) ? ~(_e451) : (_e451 ^ 2147483648u))) ? _e440 : _e451))));
    uint _e471 = as_type<uint>(static_cast<float>(true));
    bool _e480 = (_e471 & 2147483647u) > 2139095040u;
    uint _e481 = as_type<uint>(seed);
    bool _e487 = (_e481 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(18)] = as_type<float>((_e480 && _e487) ? 2143289344u : (_e487 ? _e471 : (_e480 ? _e481 : ((((_e471 >= 2147483648u) ? ~(_e471) : (_e471 ^ 2147483648u)) > ((_e481 >= 2147483648u) ? ~(_e481) : (_e481 ^ 2147483648u))) ? _e471 : _e481))));
    uint _e499 = as_type<uint>(seed);
    bool _e508 = (_e499 & 2147483647u) > 2139095040u;
    uint _e509 = as_type<uint>(seed);
    bool _e515 = (_e509 & 2147483647u) > 2139095040u;
    out[static_cast<uint>(19)] = as_type<float>((_e508 && _e515) ? 2143289344u : (_e515 ? _e499 : (_e508 ? _e509 : ((((_e499 >= 2147483648u) ? ~(_e499) : (_e499 ^ 2147483648u)) < ((_e509 >= 2147483648u) ? ~(_e509) : (_e509 ^ 2147483648u))) ? _e499 : _e509))));
}
