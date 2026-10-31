#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _11_10
{
    uint _m0[];
} _10;

uint _15(uint _14)
{
    uint _43 = 0u;
    uint _37 = 0u;
    uint _41 = 0u;
    uint _34 = 0u;
    uint _45 = 0u;
    uint _39 = 0u;
    uvec2 _92 = uvec2(4294967295u);
    uint _50 = _14 & 2147483647u;
    if ((_50 == 0u) || (_14 == 2139095040u))
    {
        return _14;
    }
    if (((_14 & 2147483648u) != 0u) || (_50 > 2139095040u))
    {
        return 2143289344u;
    }
    uint _62 = _14 & 8388607u;
    uint _63 = _50 >> 23u;
    _34 = _62 | 8388608u;
    _37 = _63 + 127u;
    if (_63 == 0u)
    {
        uint _72 = (31u - uint(findMSB(_62))) - 8u;
        _34 = _62 << _72;
        _37 = 128u - _72;
    }
    uint _77 = _37 & 1u;
    _39 = _34 >> (9u - _77);
    _41 = _34 << (23u + _77);
    _43 = 0u;
    _45 = 0u;
    uint _47 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _92)))
        {
            break;
        }
        _92 -= uvec2(uint(_92.y == 0u), 1u);
        if (_47 >= 24u)
        {
            break;
        }
        uint _107 = _39;
        uint _110 = _45;
        uint _118 = (_110 << 2u) | (_107 >> 14u);
        uint _120 = (_43 << 2u) | 1u;
        bool _121 = _118 >= _120;
        uint _124 = _43 << 1u;
        _39 = ((_107 << 2u) | (_41 >> 30u)) & 65535u;
        _41 = _41 << 2u;
        _45 = _121 ? (_118 - _120) : _118;
        _43 = _121 ? (_124 | 1u) : _124;
        _47++;
        continue;
    }
    return ((_37 >> 1u) << 23u) | (((_45 > _43) ? (_43 + 1u) : _43) & 8388607u);
}

float _148(int _147)
{
    return uintBitsToFloat(_15(floatBitsToUint(float(_147))));
}

float _157(uint _156)
{
    return uintBitsToFloat(_15(floatBitsToUint(float(_156))));
}

float _140(float _139)
{
    return uintBitsToFloat(_15(floatBitsToUint(_139)));
}

int _177(bool _176)
{
    int _181 = 0;
    if (_176)
    {
        _181 = 7;
    }
    else
    {
        _181 = 9;
    }
    return _181;
}

float _192(float _190, float _191)
{
    return _190 + _191;
}

float _166(bool _165)
{
    return uintBitsToFloat(_15(floatBitsToUint(float(_165))));
}

void main()
{
    uint _489 = 0u;
    uint _355 = 0u;
    uint _465 = 0u;
    uint _331[2] = uint[](0u, 0u);
    uint _441 = 0u;
    uint _306[2] = uint[](0u, 0u);
    uint _551 = 0u;
    uint _417 = 0u;
    uint _282[2] = uint[](0u, 0u);
    uint _527 = 0u;
    uint _393 = 0u;
    uint _258 = 0u;
    uint _503 = 0u;
    uint _369[2] = uint[](0u, 0u);
    uint _479 = 0u;
    uint _345[2] = uint[](0u, 0u);
    uint _455 = 0u;
    uint _321 = 0u;
    uint _565[2] = uint[](0u, 0u);
    uint _431 = 0u;
    uint _296 = 0u;
    uint _541[2] = uint[](0u, 0u);
    uint _407 = 0u;
    uint _272[2] = uint[](0u, 0u);
    uint _517[2] = uint[](0u, 0u);
    uint _383[2] = uint[](0u, 0u);
    uint _248[2] = uint[](0u, 0u);
    uint _493[2] = uint[](0u, 0u);
    uint _359 = 0u;
    uint _469[2] = uint[](0u, 0u);
    uint _335[2] = uint[](0u, 0u);
    uint _445[2] = uint[](0u, 0u);
    uint _310[2] = uint[](0u, 0u);
    uint _555 = 0u;
    uint _421[2] = uint[](0u, 0u);
    uint _286 = 0u;
    uint _531 = 0u;
    uint _397[2] = uint[](0u, 0u);
    uint _262 = 0u;
    uint _507 = 0u;
    uint _373[2] = uint[](0u, 0u);
    uint _483 = 0u;
    uint _349 = 0u;
    uint _459 = 0u;
    uint _325 = 0u;
    uint _569 = 0u;
    uint _435 = 0u;
    uint _300[2] = uint[](0u, 0u);
    uint _545 = 0u;
    uint _411 = 0u;
    uint _276[2] = uint[](0u, 0u);
    uint _521 = 0u;
    uint _387[2] = uint[](0u, 0u);
    uint _252[2] = uint[](0u, 0u);
    uint _497 = 0u;
    uint _363 = 0u;
    uint _473 = 0u;
    uint _339[2] = uint[](0u, 0u);
    uint _449 = 0u;
    uint _314 = 0u;
    uint _559[2] = uint[](0u, 0u);
    uint _425 = 0u;
    uint _290 = 0u;
    uint _535[2] = uint[](0u, 0u);
    uint _401 = 0u;
    uint _266 = 0u;
    uint _511[2] = uint[](0u, 0u);
    uint _377 = 0u;
    uint _487[2] = uint[](0u, 0u);
    uint _353 = 0u;
    uint _463[2] = uint[](0u, 0u);
    uint _329 = 0u;
    uint _439[2] = uint[](0u, 0u);
    uint _304 = 0u;
    uint _549 = 0u;
    uint _415[2] = uint[](0u, 0u);
    uint _280 = 0u;
    uint _525 = 0u;
    uint _391[2] = uint[](0u, 0u);
    uint _256[2] = uint[](0u, 0u);
    uint _501 = 0u;
    uint _367 = 0u;
    uint _477 = 0u;
    uint _343 = 0u;
    uint _453 = 0u;
    uint _319[2] = uint[](0u, 0u);
    uint _563 = 0u;
    uint _429 = 0u;
    uint _294[2] = uint[](0u, 0u);
    uint _539 = 0u;
    uint _405 = 0u;
    uint _270 = 0u;
    uint _515 = 0u;
    uint _381 = 0u;
    uint _245[2] = uint[](0u, 0u);
    uint _491 = 0u;
    uint _357[2] = uint[](0u, 0u);
    uint _467 = 0u;
    uint _333 = 0u;
    uint _443 = 0u;
    uint _308 = 0u;
    uint _553[2] = uint[](0u, 0u);
    uint _419 = 0u;
    uint _284 = 0u;
    uint _529[2] = uint[](0u, 0u);
    uint _395 = 0u;
    uint _260[2] = uint[](0u, 0u);
    uint _505[2] = uint[](0u, 0u);
    uint _371 = 0u;
    uint _481[2] = uint[](0u, 0u);
    uint _347 = 0u;
    uint _457[2] = uint[](0u, 0u);
    uint _323[2] = uint[](0u, 0u);
    uint _567 = 0u;
    uint _433[2] = uint[](0u, 0u);
    uint _298 = 0u;
    uint _543 = 0u;
    uint _409[2] = uint[](0u, 0u);
    uint _274 = 0u;
    uint _519 = 0u;
    uint _385 = 0u;
    uint _250 = 0u;
    uint _495 = 0u;
    uint _361[2] = uint[](0u, 0u);
    uint _471 = 0u;
    uint _337 = 0u;
    uint _447 = 0u;
    uint _312 = 0u;
    uint _557 = 0u;
    uint _423 = 0u;
    uint _288[2] = uint[](0u, 0u);
    uint _533 = 0u;
    uint _399 = 0u;
    uint _264[2] = uint[](0u, 0u);
    uint _509 = 0u;
    uint _375 = 0u;
    uint _485 = 0u;
    uint _351[2] = uint[](0u, 0u);
    uint _461 = 0u;
    uint _327[2] = uint[](0u, 0u);
    uint _437 = 0u;
    uint _302 = 0u;
    uint _547[2] = uint[](0u, 0u);
    uint _413 = 0u;
    uint _278 = 0u;
    uint _523[2] = uint[](0u, 0u);
    uint _389 = 0u;
    uint _254 = 0u;
    uint _499[2] = uint[](0u, 0u);
    uint _365[2] = uint[](0u, 0u);
    uint _475[2] = uint[](0u, 0u);
    uint _341 = 0u;
    uint _451[2] = uint[](0u, 0u);
    float _316 = 0.0;
    uint _561 = 0u;
    uint _427[2] = uint[](0u, 0u);
    uint _292 = 0u;
    uint _537 = 0u;
    uint _403[2] = uint[](0u, 0u);
    uint _268[2] = uint[](0u, 0u);
    uint _513 = 0u;
    uint _379[2] = uint[](0u, 0u);
    _245 = uint[](0u, 0u);
    _245[0u] = 0u;
    _245[1u] = 0u;
    _248 = _245;
    _250 = uint(0);
    _391 = _248;
    _391[1u] += _250;
    _393 = _391[0u];
    _395 = _391[1u];
    _10._m0[_395] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(0.0))));
    float _593 = -0.0;
    _252 = _245;
    _254 = uint(1);
    _397 = _252;
    _397[1u] += _254;
    _399 = _397[0u];
    _401 = _397[1u];
    _10._m0[_401] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(_593))));
    _256 = _245;
    _258 = uint(2);
    _403 = _256;
    _403[1u] += _258;
    _405 = _403[0u];
    _407 = _403[1u];
    _10._m0[_407] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(1.0))));
    _260 = _245;
    _262 = uint(3);
    _409 = _260;
    _409[1u] += _262;
    _411 = _409[0u];
    _413 = _409[1u];
    _10._m0[_413] = floatBitsToUint(_148(4));
    _264 = _245;
    _266 = uint(4);
    _415 = _264;
    _415[1u] += _266;
    _417 = _415[0u];
    _419 = _415[1u];
    _10._m0[_419] = floatBitsToUint(_157(9u));
    _268 = _245;
    _270 = uint(5);
    _421 = _268;
    _421[1u] += _270;
    _423 = _421[0u];
    _425 = _421[1u];
    _10._m0[_425] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(6.25))));
    _272 = _245;
    _274 = uint(6);
    _427 = _272;
    _427[1u] += _274;
    _429 = _427[0u];
    _431 = _427[1u];
    _10._m0[_431] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(2.0))));
    _280 = 1u;
    _276 = _245;
    _278 = uint(7);
    _433 = _276;
    _433[1u] += _278;
    _435 = _433[0u];
    _437 = _433[1u];
    _10._m0[_437] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_280)))));
    _286 = 8388607u;
    _282 = _245;
    _284 = uint(8);
    _439 = _282;
    _439[1u] += _284;
    _441 = _439[0u];
    _443 = _439[1u];
    _10._m0[_443] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_286)))));
    _292 = 8388608u;
    _288 = _245;
    _290 = uint(9);
    _445 = _288;
    _445[1u] += _290;
    _447 = _445[0u];
    _449 = _445[1u];
    _10._m0[_449] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_292)))));
    _298 = 2139095039u;
    _294 = _245;
    _296 = uint(10);
    _451 = _294;
    _451[1u] += _296;
    _453 = _451[0u];
    _455 = _451[1u];
    _10._m0[_455] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_298)))));
    _304 = 2139095040u;
    _300 = _245;
    _302 = uint(11);
    _457 = _300;
    _457[1u] += _302;
    _459 = _457[0u];
    _461 = _457[1u];
    _10._m0[_461] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_304)))));
    float _798 = -1.0;
    _306 = _245;
    _308 = uint(12);
    _463 = _306;
    _463[1u] += _308;
    _465 = _463[0u];
    _467 = _463[1u];
    _10._m0[_467] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(_798))));
    _314 = 2139095041u;
    _310 = _245;
    _312 = uint(13);
    _469 = _310;
    _469[1u] += _312;
    _471 = _469[0u];
    _473 = _469[1u];
    _10._m0[_473] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_314)))));
    _316 = 4.0;
    float _837 = _316;
    float _838 = float(1);
    _316 = _837 + _838;
    _319 = _245;
    _321 = uint(14);
    _475 = _319;
    _475[1u] += _321;
    _477 = _475[0u];
    _479 = _475[1u];
    _10._m0[_479] = floatBitsToUint(_140(_837));
    _323 = _245;
    _325 = uint(15);
    _481 = _323;
    _481[1u] += _325;
    _483 = _481[0u];
    _485 = _481[1u];
    _10._m0[_485] = floatBitsToUint(_316);
    _327 = _245;
    _329 = uint(16);
    _487 = _327;
    _487[1u] += _329;
    _489 = _487[0u];
    _491 = _487[1u];
    _10._m0[_491] = uint(_177(true));
    _331 = _245;
    _333 = uint(17);
    _493 = _331;
    _493[1u] += _333;
    _495 = _493[0u];
    _497 = _493[1u];
    _10._m0[_497] = uint(_177(false));
    _335 = _245;
    _337 = uint(18);
    _499 = _335;
    _499[1u] += _337;
    _501 = _499[0u];
    _503 = _499[1u];
    _10._m0[_503] = floatBitsToUint(_192(2.0, 3.0));
    _343 = 1065353217u;
    _339 = _245;
    _341 = uint(19);
    _505 = _339;
    _505[1u] += _341;
    _507 = _505[0u];
    _509 = _505[1u];
    _10._m0[_509] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_343)))));
    _349 = 1065353218u;
    _345 = _245;
    _347 = uint(20);
    _511 = _345;
    _511[1u] += _347;
    _513 = _511[0u];
    _515 = _511[1u];
    _10._m0[_515] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_349)))));
    _355 = 1065353215u;
    _351 = _245;
    _353 = uint(21);
    _517 = _351;
    _517[1u] += _353;
    _519 = _517[0u];
    _521 = _517[1u];
    _10._m0[_521] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_355)))));
    _357 = _245;
    _359 = uint(22);
    _523 = _357;
    _523[1u] += _359;
    _525 = _523[0u];
    _527 = _523[1u];
    _10._m0[_527] = floatBitsToUint(_157(4294967295u));
    int _996 = -4;
    _361 = _245;
    _363 = uint(23);
    _529 = _361;
    _529[1u] += _363;
    _531 = _529[0u];
    _533 = _529[1u];
    _10._m0[_533] = floatBitsToUint(_148(_996));
    _365 = _245;
    _367 = uint(24);
    _535 = _365;
    _535[1u] += _367;
    _537 = _535[0u];
    _539 = _535[1u];
    _10._m0[_539] = floatBitsToUint(_140(16.0));
    _369 = _245;
    _371 = uint(25);
    _541 = _369;
    _541[1u] += _371;
    _543 = _541[0u];
    _545 = _541[1u];
    _10._m0[_545] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(0.25))));
    _377 = 2147483649u;
    _373 = _245;
    _375 = uint(26);
    _547 = _373;
    _547[1u] += _375;
    _549 = _547[0u];
    _551 = _547[1u];
    _10._m0[_551] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_377)))));
    _379 = _245;
    _381 = uint(27);
    _553 = _379;
    _553[1u] += _381;
    _555 = _553[0u];
    _557 = _553[1u];
    _10._m0[_557] = floatBitsToUint(_166(false));
    _383 = _245;
    _385 = uint(28);
    _559 = _383;
    _559[1u] += _385;
    _561 = _559[0u];
    _563 = _559[1u];
    _10._m0[_563] = floatBitsToUint(_166(true));
    _387 = _245;
    _389 = uint(29);
    _565 = _387;
    _565[1u] += _389;
    _567 = _565[0u];
    _569 = _565[1u];
    _10._m0[_569] = floatBitsToUint(_140(0.5));
}

