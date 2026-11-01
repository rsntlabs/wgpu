#version 310 es

precision highp float;
precision highp int;

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430) buffer type_1_block_0Compute { float _group_0_binding_0_cs[]; };


float min_(float first_1, float second_1, float third) {
    uint _e3 = floatBitsToUint(first_1);
    bool _e12 = ((_e3 & 2147483647u) > 2139095040u);
    uint _e13 = floatBitsToUint(second_1);
    bool _e19 = ((_e13 & 2147483647u) > 2139095040u);
    uint _e28 = floatBitsToUint(uintBitsToFloat(((_e12 && _e19) ? 2143289344u : (_e19 ? _e3 : (_e12 ? _e13 : ((((_e3 >= 2147483648u) ? ~(_e3) : (_e3 ^ 2147483648u)) < ((_e13 >= 2147483648u) ? ~(_e13) : (_e13 ^ 2147483648u))) ? _e3 : _e13))))));
    bool _e37 = ((_e28 & 2147483647u) > 2139095040u);
    uint _e38 = floatBitsToUint(third);
    bool _e44 = ((_e38 & 2147483647u) > 2139095040u);
    return uintBitsToFloat(((_e37 && _e44) ? 2143289344u : (_e44 ? _e28 : (_e37 ? _e38 : ((((_e28 >= 2147483648u) ? ~(_e28) : (_e28 ^ 2147483648u)) < ((_e38 >= 2147483648u) ? ~(_e38) : (_e38 ^ 2147483648u))) ? _e28 : _e38)))));
}

float bounded(float value_1) {
    uint _e6 = floatBitsToUint(value_1);
    bool _e15 = ((_e6 & 2147483647u) > 2139095040u);
    uint _e16 = floatBitsToUint(float(4));
    bool _e22 = ((_e16 & 2147483647u) > 2139095040u);
    uint _e31 = floatBitsToUint(float(-(2)));
    bool _e40 = ((_e31 & 2147483647u) > 2139095040u);
    uint _e41 = floatBitsToUint(uintBitsToFloat(((_e15 && _e22) ? 2143289344u : (_e22 ? _e6 : (_e15 ? _e16 : ((((_e6 >= 2147483648u) ? ~(_e6) : (_e6 ^ 2147483648u)) < ((_e16 >= 2147483648u) ? ~(_e16) : (_e16 ^ 2147483648u))) ? _e6 : _e16))))));
    bool _e47 = ((_e41 & 2147483647u) > 2139095040u);
    return uintBitsToFloat(((_e40 && _e47) ? 2143289344u : (_e47 ? _e31 : (_e40 ? _e41 : ((((_e31 >= 2147483648u) ? ~(_e31) : (_e31 ^ 2147483648u)) > ((_e41 >= 2147483648u) ? ~(_e41) : (_e41 ^ 2147483648u))) ? _e31 : _e41)))));
}

void main() {
    float first = 0.0;
    float second = 0.0;
    float value = 0.0;
    float seed = _group_0_binding_0_cs[uint(0)];
    uint _e7 = floatBitsToUint(seed);
    bool _e16 = ((_e7 & 2147483647u) > 2139095040u);
    uint _e17 = floatBitsToUint(-(7.5));
    bool _e23 = ((_e17 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(0)] = uintBitsToFloat(((_e16 && _e23) ? 2143289344u : (_e23 ? _e7 : (_e16 ? _e17 : ((((_e7 >= 2147483648u) ? ~(_e7) : (_e7 ^ 2147483648u)) < ((_e17 >= 2147483648u) ? ~(_e17) : (_e17 ^ 2147483648u))) ? _e7 : _e17)))));
    uint _e37 = floatBitsToUint(seed);
    bool _e46 = ((_e37 & 2147483647u) > 2139095040u);
    uint _e47 = floatBitsToUint(-(7.5));
    bool _e53 = ((_e47 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(1)] = uintBitsToFloat(((_e46 && _e53) ? 2143289344u : (_e53 ? _e37 : (_e46 ? _e47 : ((((_e37 >= 2147483648u) ? ~(_e37) : (_e37 ^ 2147483648u)) > ((_e47 >= 2147483648u) ? ~(_e47) : (_e47 ^ 2147483648u))) ? _e37 : _e47)))));
    uint _e65 = floatBitsToUint(seed);
    bool _e74 = ((_e65 & 2147483647u) > 2139095040u);
    uint _e76 = floatBitsToUint(1.5);
    bool _e82 = ((_e76 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(2)] = uintBitsToFloat(((_e74 && _e82) ? 2143289344u : (_e82 ? _e65 : (_e74 ? _e76 : ((((_e65 >= 2147483648u) ? ~(_e65) : (_e65 ^ 2147483648u)) < ((_e76 >= 2147483648u) ? ~(_e76) : (_e76 ^ 2147483648u))) ? _e65 : _e76)))));
    uint _e96 = floatBitsToUint(-(2.25));
    bool _e105 = ((_e96 & 2147483647u) > 2139095040u);
    uint _e106 = floatBitsToUint(seed);
    bool _e112 = ((_e106 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(3)] = uintBitsToFloat(((_e105 && _e112) ? 2143289344u : (_e112 ? _e96 : (_e105 ? _e106 : ((((_e96 >= 2147483648u) ? ~(_e96) : (_e96 ^ 2147483648u)) > ((_e106 >= 2147483648u) ? ~(_e106) : (_e106 ^ 2147483648u))) ? _e96 : _e106)))));
    uint _e129 = floatBitsToUint(float(-(3)));
    bool _e138 = ((_e129 & 2147483647u) > 2139095040u);
    uint _e139 = floatBitsToUint(float(5u));
    bool _e145 = ((_e139 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(4)] = uintBitsToFloat(((_e138 && _e145) ? 2143289344u : (_e145 ? _e129 : (_e138 ? _e139 : ((((_e129 >= 2147483648u) ? ~(_e129) : (_e129 ^ 2147483648u)) < ((_e139 >= 2147483648u) ? ~(_e139) : (_e139 ^ 2147483648u))) ? _e129 : _e139)))));
    uint _e162 = floatBitsToUint(float(5u));
    bool _e171 = ((_e162 & 2147483647u) > 2139095040u);
    uint _e172 = floatBitsToUint(float(-(3)));
    bool _e178 = ((_e172 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(5)] = uintBitsToFloat(((_e171 && _e178) ? 2143289344u : (_e178 ? _e162 : (_e171 ? _e172 : ((((_e162 >= 2147483648u) ? ~(_e162) : (_e162 ^ 2147483648u)) > ((_e172 >= 2147483648u) ? ~(_e172) : (_e172 ^ 2147483648u))) ? _e162 : _e172)))));
    uint _e194 = floatBitsToUint(float(true));
    bool _e203 = ((_e194 & 2147483647u) > 2139095040u);
    uint _e204 = floatBitsToUint(float(false));
    bool _e210 = ((_e204 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(6)] = uintBitsToFloat(((_e203 && _e210) ? 2143289344u : (_e210 ? _e194 : (_e203 ? _e204 : ((((_e194 >= 2147483648u) ? ~(_e194) : (_e194 ^ 2147483648u)) < ((_e204 >= 2147483648u) ? ~(_e204) : (_e204 ^ 2147483648u))) ? _e194 : _e204)))));
    uint _e226 = floatBitsToUint(float(false));
    bool _e235 = ((_e226 & 2147483647u) > 2139095040u);
    uint _e236 = floatBitsToUint(float(true));
    bool _e242 = ((_e236 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(7)] = uintBitsToFloat(((_e235 && _e242) ? 2143289344u : (_e242 ? _e226 : (_e235 ? _e236 : ((((_e226 >= 2147483648u) ? ~(_e226) : (_e226 ^ 2147483648u)) > ((_e236 >= 2147483648u) ? ~(_e236) : (_e236 ^ 2147483648u))) ? _e226 : _e236)))));
    uint _e256 = floatBitsToUint(seed);
    bool _e265 = ((_e256 & 2147483647u) > 2139095040u);
    uint _e266 = floatBitsToUint(-(4.0));
    bool _e272 = ((_e266 & 2147483647u) > 2139095040u);
    uint _e281 = floatBitsToUint(uintBitsToFloat(((_e265 && _e272) ? 2143289344u : (_e272 ? _e256 : (_e265 ? _e266 : ((((_e256 >= 2147483648u) ? ~(_e256) : (_e256 ^ 2147483648u)) > ((_e266 >= 2147483648u) ? ~(_e266) : (_e266 ^ 2147483648u))) ? _e256 : _e266))))));
    bool _e290 = ((_e281 & 2147483647u) > 2139095040u);
    uint _e292 = floatBitsToUint(2.5);
    bool _e298 = ((_e292 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(8)] = uintBitsToFloat(((_e290 && _e298) ? 2143289344u : (_e298 ? _e281 : (_e290 ? _e292 : ((((_e281 >= 2147483648u) ? ~(_e281) : (_e281 ^ 2147483648u)) < ((_e292 >= 2147483648u) ? ~(_e292) : (_e292 ^ 2147483648u))) ? _e281 : _e292)))));
    float _e313 = min_(seed, 1.25, -(3.5));
    _group_0_binding_0_cs[uint(9)] = _e313;
    float _e317 = bounded(seed);
    _group_0_binding_0_cs[uint(10)] = _e317;
    first = 1.25;
    second = 2.5;
    float _e325 = first;
    first = (_e325 + float(1));
    float _e329 = second;
    second = (_e329 + float(1));
    uint _e333 = floatBitsToUint(_e325);
    bool _e342 = ((_e333 & 2147483647u) > 2139095040u);
    uint _e343 = floatBitsToUint(_e329);
    bool _e349 = ((_e343 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(11)] = uintBitsToFloat(((_e342 && _e349) ? 2143289344u : (_e349 ? _e333 : (_e342 ? _e343 : ((((_e333 >= 2147483648u) ? ~(_e333) : (_e333 ^ 2147483648u)) > ((_e343 >= 2147483648u) ? ~(_e343) : (_e343 ^ 2147483648u))) ? _e333 : _e343)))));
    float _e361 = first;
    _group_0_binding_0_cs[uint(12)] = _e361;
    float _e365 = second;
    _group_0_binding_0_cs[uint(13)] = _e365;
    value = seed;
    float _e370 = value;
    float _e371 = value;
    value = (_e371 + float(1));
    uint _e375 = floatBitsToUint(_e370);
    bool _e384 = ((_e375 & 2147483647u) > 2139095040u);
    uint _e385 = floatBitsToUint(_e371);
    bool _e391 = ((_e385 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(14)] = uintBitsToFloat(((_e384 && _e391) ? 2143289344u : (_e391 ? _e375 : (_e384 ? _e385 : ((((_e375 >= 2147483648u) ? ~(_e375) : (_e375 ^ 2147483648u)) > ((_e385 >= 2147483648u) ? ~(_e385) : (_e385 ^ 2147483648u))) ? _e375 : _e385)))));
    float _e403 = value;
    _group_0_binding_0_cs[uint(15)] = _e403;
    uint _e409 = floatBitsToUint(float(16777217));
    bool _e418 = ((_e409 & 2147483647u) > 2139095040u);
    uint _e420 = floatBitsToUint(16777216.0);
    bool _e426 = ((_e420 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(16)] = uintBitsToFloat(((_e418 && _e426) ? 2143289344u : (_e426 ? _e409 : (_e418 ? _e420 : ((((_e409 >= 2147483648u) ? ~(_e409) : (_e409 ^ 2147483648u)) > ((_e420 >= 2147483648u) ? ~(_e420) : (_e420 ^ 2147483648u))) ? _e409 : _e420)))));
    uint _e440 = floatBitsToUint(float(4294967295u));
    bool _e449 = ((_e440 & 2147483647u) > 2139095040u);
    uint _e451 = floatBitsToUint(4294967300.0);
    bool _e457 = ((_e451 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(17)] = uintBitsToFloat(((_e449 && _e457) ? 2143289344u : (_e457 ? _e440 : (_e449 ? _e451 : ((((_e440 >= 2147483648u) ? ~(_e440) : (_e440 ^ 2147483648u)) < ((_e451 >= 2147483648u) ? ~(_e451) : (_e451 ^ 2147483648u))) ? _e440 : _e451)))));
    uint _e471 = floatBitsToUint(float(true));
    bool _e480 = ((_e471 & 2147483647u) > 2139095040u);
    uint _e481 = floatBitsToUint(seed);
    bool _e487 = ((_e481 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(18)] = uintBitsToFloat(((_e480 && _e487) ? 2143289344u : (_e487 ? _e471 : (_e480 ? _e481 : ((((_e471 >= 2147483648u) ? ~(_e471) : (_e471 ^ 2147483648u)) > ((_e481 >= 2147483648u) ? ~(_e481) : (_e481 ^ 2147483648u))) ? _e471 : _e481)))));
    uint _e499 = floatBitsToUint(seed);
    bool _e508 = ((_e499 & 2147483647u) > 2139095040u);
    uint _e509 = floatBitsToUint(seed);
    bool _e515 = ((_e509 & 2147483647u) > 2139095040u);
    _group_0_binding_0_cs[uint(19)] = uintBitsToFloat(((_e508 && _e515) ? 2143289344u : (_e515 ? _e499 : (_e508 ? _e509 : ((((_e499 >= 2147483648u) ? ~(_e499) : (_e499 ^ 2147483648u)) < ((_e509 >= 2147483648u) ? ~(_e509) : (_e509 ^ 2147483648u))) ? _e499 : _e509)))));
}

