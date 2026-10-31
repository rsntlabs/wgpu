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

float _152(int _151)
{
    int _154 = 0;
    _154 = _151;
    return uintBitsToFloat(_15(floatBitsToUint(float(_154))));
}

float _165(uint _164)
{
    uint _167 = 0u;
    _167 = _164;
    return uintBitsToFloat(_15(floatBitsToUint(float(_167))));
}

float _140(float _139)
{
    float _142 = 0.0;
    _142 = _139;
    return uintBitsToFloat(_15(floatBitsToUint(_142)));
}

int _192(bool _191)
{
    bool _196 = false;
    int _198 = 0;
    _196 = _191;
    if (_196)
    {
        _198 = 7;
    }
    else
    {
        _198 = 9;
    }
    return _198;
}

float _209(float _207, float _208)
{
    float _211 = 0.0;
    float _213 = 0.0;
    _211 = _207;
    _213 = _208;
    return _211 + _213;
}

float _177(bool _176)
{
    bool _179 = false;
    _179 = _176;
    return uintBitsToFloat(_15(floatBitsToUint(float(_179))));
}

void main()
{
    uint _511 = 0u;
    uint _377 = 0u;
    uint _487 = 0u;
    uint _353[2] = uint[](0u, 0u);
    uint _463 = 0u;
    uint _329[2] = uint[](0u, 0u);
    uint _573 = 0u;
    uint _439 = 0u;
    uint _305[2] = uint[](0u, 0u);
    uint _549 = 0u;
    uint _415 = 0u;
    uint _281 = 0u;
    uint _525 = 0u;
    uint _391[2] = uint[](0u, 0u);
    uint _501 = 0u;
    uint _367[2] = uint[](0u, 0u);
    uint _477 = 0u;
    uint _343 = 0u;
    uint _587[2] = uint[](0u, 0u);
    uint _453 = 0u;
    uint _319 = 0u;
    uint _563[2] = uint[](0u, 0u);
    uint _429 = 0u;
    uint _295[2] = uint[](0u, 0u);
    uint _539[2] = uint[](0u, 0u);
    uint _405[2] = uint[](0u, 0u);
    uint _271[2] = uint[](0u, 0u);
    uint _515[2] = uint[](0u, 0u);
    uint _381 = 0u;
    uint _491[2] = uint[](0u, 0u);
    uint _357[2] = uint[](0u, 0u);
    uint _467[2] = uint[](0u, 0u);
    uint _333[2] = uint[](0u, 0u);
    uint _577 = 0u;
    uint _443[2] = uint[](0u, 0u);
    uint _309 = 0u;
    uint _553 = 0u;
    uint _419[2] = uint[](0u, 0u);
    uint _285 = 0u;
    uint _529 = 0u;
    uint _395[2] = uint[](0u, 0u);
    uint _505 = 0u;
    uint _371 = 0u;
    uint _481 = 0u;
    uint _347 = 0u;
    uint _591 = 0u;
    uint _457 = 0u;
    uint _323[2] = uint[](0u, 0u);
    uint _567 = 0u;
    uint _433 = 0u;
    uint _299[2] = uint[](0u, 0u);
    uint _543 = 0u;
    uint _409[2] = uint[](0u, 0u);
    uint _275[2] = uint[](0u, 0u);
    uint _519 = 0u;
    uint _385 = 0u;
    uint _495 = 0u;
    uint _361[2] = uint[](0u, 0u);
    uint _471 = 0u;
    uint _337 = 0u;
    uint _581[2] = uint[](0u, 0u);
    uint _447 = 0u;
    uint _313 = 0u;
    uint _557[2] = uint[](0u, 0u);
    uint _423 = 0u;
    uint _289 = 0u;
    uint _533[2] = uint[](0u, 0u);
    uint _399 = 0u;
    uint _509[2] = uint[](0u, 0u);
    uint _375 = 0u;
    uint _485[2] = uint[](0u, 0u);
    uint _351 = 0u;
    uint _461[2] = uint[](0u, 0u);
    uint _327 = 0u;
    uint _571 = 0u;
    uint _437[2] = uint[](0u, 0u);
    uint _303 = 0u;
    uint _547 = 0u;
    uint _413[2] = uint[](0u, 0u);
    uint _279[2] = uint[](0u, 0u);
    uint _523 = 0u;
    uint _389 = 0u;
    uint _499 = 0u;
    uint _365 = 0u;
    uint _475 = 0u;
    uint _341[2] = uint[](0u, 0u);
    uint _585 = 0u;
    uint _451 = 0u;
    uint _317[2] = uint[](0u, 0u);
    uint _561 = 0u;
    uint _427 = 0u;
    uint _293 = 0u;
    uint _537 = 0u;
    uint _403 = 0u;
    uint _268[2] = uint[](0u, 0u);
    uint _513 = 0u;
    uint _379[2] = uint[](0u, 0u);
    uint _489 = 0u;
    uint _355 = 0u;
    uint _465 = 0u;
    uint _331 = 0u;
    uint _575[2] = uint[](0u, 0u);
    uint _441 = 0u;
    uint _307 = 0u;
    uint _551[2] = uint[](0u, 0u);
    uint _417 = 0u;
    uint _283[2] = uint[](0u, 0u);
    uint _527[2] = uint[](0u, 0u);
    uint _393 = 0u;
    uint _503[2] = uint[](0u, 0u);
    uint _369 = 0u;
    uint _479[2] = uint[](0u, 0u);
    uint _345[2] = uint[](0u, 0u);
    uint _589 = 0u;
    uint _455[2] = uint[](0u, 0u);
    uint _321 = 0u;
    uint _565 = 0u;
    uint _431[2] = uint[](0u, 0u);
    uint _297 = 0u;
    uint _541 = 0u;
    uint _407 = 0u;
    uint _273 = 0u;
    uint _517 = 0u;
    uint _383[2] = uint[](0u, 0u);
    uint _493 = 0u;
    uint _359 = 0u;
    uint _469 = 0u;
    uint _335 = 0u;
    uint _579 = 0u;
    uint _445 = 0u;
    uint _311[2] = uint[](0u, 0u);
    uint _555 = 0u;
    uint _421 = 0u;
    uint _287[2] = uint[](0u, 0u);
    uint _531 = 0u;
    uint _397 = 0u;
    uint _507 = 0u;
    uint _373[2] = uint[](0u, 0u);
    uint _483 = 0u;
    uint _349[2] = uint[](0u, 0u);
    uint _459 = 0u;
    uint _325 = 0u;
    uint _569[2] = uint[](0u, 0u);
    uint _435 = 0u;
    uint _301 = 0u;
    uint _545[2] = uint[](0u, 0u);
    uint _411 = 0u;
    uint _277 = 0u;
    uint _521[2] = uint[](0u, 0u);
    uint _387[2] = uint[](0u, 0u);
    uint _497[2] = uint[](0u, 0u);
    uint _363 = 0u;
    uint _473[2] = uint[](0u, 0u);
    float _339 = 0.0;
    uint _583 = 0u;
    uint _449[2] = uint[](0u, 0u);
    uint _315 = 0u;
    uint _559 = 0u;
    uint _425[2] = uint[](0u, 0u);
    uint _291[2] = uint[](0u, 0u);
    uint _535 = 0u;
    uint _401[2] = uint[](0u, 0u);
    _268 = uint[](0u, 0u);
    _268[0u] = 0u;
    _268[1u] = 0u;
    _271 = _268;
    _273 = uint(0);
    _413 = _271;
    _413[1u] += _273;
    _415 = _413[0u];
    _417 = _413[1u];
    _10._m0[_417] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(0.0))));
    float _615 = -0.0;
    _275 = _268;
    _277 = uint(1);
    _419 = _275;
    _419[1u] += _277;
    _421 = _419[0u];
    _423 = _419[1u];
    _10._m0[_423] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(_615))));
    _279 = _268;
    _281 = uint(2);
    _425 = _279;
    _425[1u] += _281;
    _427 = _425[0u];
    _429 = _425[1u];
    _10._m0[_429] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(1.0))));
    _283 = _268;
    _285 = uint(3);
    _431 = _283;
    _431[1u] += _285;
    _433 = _431[0u];
    _435 = _431[1u];
    _10._m0[_435] = floatBitsToUint(_152(4));
    _287 = _268;
    _289 = uint(4);
    _437 = _287;
    _437[1u] += _289;
    _439 = _437[0u];
    _441 = _437[1u];
    _10._m0[_441] = floatBitsToUint(_165(9u));
    _291 = _268;
    _293 = uint(5);
    _443 = _291;
    _443[1u] += _293;
    _445 = _443[0u];
    _447 = _443[1u];
    _10._m0[_447] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(6.25))));
    _295 = _268;
    _297 = uint(6);
    _449 = _295;
    _449[1u] += _297;
    _451 = _449[0u];
    _453 = _449[1u];
    _10._m0[_453] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(2.0))));
    _303 = 1u;
    _299 = _268;
    _301 = uint(7);
    _455 = _299;
    _455[1u] += _301;
    _457 = _455[0u];
    _459 = _455[1u];
    _10._m0[_459] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_303)))));
    _309 = 8388607u;
    _305 = _268;
    _307 = uint(8);
    _461 = _305;
    _461[1u] += _307;
    _463 = _461[0u];
    _465 = _461[1u];
    _10._m0[_465] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_309)))));
    _315 = 8388608u;
    _311 = _268;
    _313 = uint(9);
    _467 = _311;
    _467[1u] += _313;
    _469 = _467[0u];
    _471 = _467[1u];
    _10._m0[_471] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_315)))));
    _321 = 2139095039u;
    _317 = _268;
    _319 = uint(10);
    _473 = _317;
    _473[1u] += _319;
    _475 = _473[0u];
    _477 = _473[1u];
    _10._m0[_477] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_321)))));
    _327 = 2139095040u;
    _323 = _268;
    _325 = uint(11);
    _479 = _323;
    _479[1u] += _325;
    _481 = _479[0u];
    _483 = _479[1u];
    _10._m0[_483] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_327)))));
    float _820 = -1.0;
    _329 = _268;
    _331 = uint(12);
    _485 = _329;
    _485[1u] += _331;
    _487 = _485[0u];
    _489 = _485[1u];
    _10._m0[_489] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(_820))));
    _337 = 2139095041u;
    _333 = _268;
    _335 = uint(13);
    _491 = _333;
    _491[1u] += _335;
    _493 = _491[0u];
    _495 = _491[1u];
    _10._m0[_495] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_337)))));
    _339 = 4.0;
    float _859 = _339;
    float _860 = float(1);
    _339 = _859 + _860;
    _341 = _268;
    _343 = uint(14);
    _497 = _341;
    _497[1u] += _343;
    _499 = _497[0u];
    _501 = _497[1u];
    _10._m0[_501] = floatBitsToUint(_140(_859));
    _345 = _268;
    _347 = uint(15);
    _503 = _345;
    _503[1u] += _347;
    _505 = _503[0u];
    _507 = _503[1u];
    _10._m0[_507] = floatBitsToUint(_339);
    _349 = _268;
    _351 = uint(16);
    _509 = _349;
    _509[1u] += _351;
    _511 = _509[0u];
    _513 = _509[1u];
    _10._m0[_513] = uint(_192(true));
    _353 = _268;
    _355 = uint(17);
    _515 = _353;
    _515[1u] += _355;
    _517 = _515[0u];
    _519 = _515[1u];
    _10._m0[_519] = uint(_192(false));
    _357 = _268;
    _359 = uint(18);
    _521 = _357;
    _521[1u] += _359;
    _523 = _521[0u];
    _525 = _521[1u];
    _10._m0[_525] = floatBitsToUint(_209(2.0, 3.0));
    _365 = 1065353217u;
    _361 = _268;
    _363 = uint(19);
    _527 = _361;
    _527[1u] += _363;
    _529 = _527[0u];
    _531 = _527[1u];
    _10._m0[_531] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_365)))));
    _371 = 1065353218u;
    _367 = _268;
    _369 = uint(20);
    _533 = _367;
    _533[1u] += _369;
    _535 = _533[0u];
    _537 = _533[1u];
    _10._m0[_537] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_371)))));
    _377 = 1065353215u;
    _373 = _268;
    _375 = uint(21);
    _539 = _373;
    _539[1u] += _375;
    _541 = _539[0u];
    _543 = _539[1u];
    _10._m0[_543] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_377)))));
    _379 = _268;
    _381 = uint(22);
    _545 = _379;
    _545[1u] += _381;
    _547 = _545[0u];
    _549 = _545[1u];
    _10._m0[_549] = floatBitsToUint(_165(4294967295u));
    int _1018 = -4;
    _383 = _268;
    _385 = uint(23);
    _551 = _383;
    _551[1u] += _385;
    _553 = _551[0u];
    _555 = _551[1u];
    _10._m0[_555] = floatBitsToUint(_152(_1018));
    _387 = _268;
    _389 = uint(24);
    _557 = _387;
    _557[1u] += _389;
    _559 = _557[0u];
    _561 = _557[1u];
    _10._m0[_561] = floatBitsToUint(_140(16.0));
    _391 = _268;
    _393 = uint(25);
    _563 = _391;
    _563[1u] += _393;
    _565 = _563[0u];
    _567 = _563[1u];
    _10._m0[_567] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(0.25))));
    _399 = 2147483649u;
    _395 = _268;
    _397 = uint(26);
    _569 = _395;
    _569[1u] += _397;
    _571 = _569[0u];
    _573 = _569[1u];
    _10._m0[_573] = floatBitsToUint(uintBitsToFloat(_15(floatBitsToUint(uintBitsToFloat(_399)))));
    _401 = _268;
    _403 = uint(27);
    _575 = _401;
    _575[1u] += _403;
    _577 = _575[0u];
    _579 = _575[1u];
    _10._m0[_579] = floatBitsToUint(_177(false));
    _405 = _268;
    _407 = uint(28);
    _581 = _405;
    _581[1u] += _407;
    _583 = _581[0u];
    _585 = _581[1u];
    _10._m0[_585] = floatBitsToUint(_177(true));
    _409 = _268;
    _411 = uint(29);
    _587 = _409;
    _587[1u] += _411;
    _589 = _587[0u];
    _591 = _587[1u];
    _10._m0[_591] = floatBitsToUint(_140(0.5));
}

