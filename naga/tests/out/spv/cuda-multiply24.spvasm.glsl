#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _11_10
{
    uint _m0[];
} _10;

int _16(float _14, float _15)
{
    float _20 = 0.0;
    float _23 = 0.0;
    _20 = _14;
    _23 = _15;
    uint _36 = min(0u, 32u);
    uint _41 = min(0u, 32u);
    return int(uint(bitfieldExtract(int(clamp(_20, -2147483648.0, 2147483520.0)), int(_36), int(min(24u, (32u - _36))))) * uint(bitfieldExtract(int(clamp(_23, -2147483648.0, 2147483520.0)), int(_41), int(min(24u, (32u - _41))))));
}

uint _50(float _48, float _49)
{
    float _52 = 0.0;
    float _54 = 0.0;
    _52 = _48;
    _54 = _49;
    uint _66 = min(0u, 32u);
    uint _70 = min(0u, 32u);
    return bitfieldExtract(uint(clamp(_52, 0.0, 4294967040.0)), int(_66), int(min(24u, (32u - _66)))) * bitfieldExtract(uint(clamp(_54, 0.0, 4294967040.0)), int(_70), int(min(24u, (32u - _70))));
}

int _77(bool _75, bool _76)
{
    bool _85 = false;
    int _90 = 0;
    bool _82 = false;
    int _87 = 0;
    _82 = _75;
    _85 = _76;
    if (_82)
    {
        if (_85)
        {
            _87 = 71;
        }
        else
        {
            _87 = 73;
        }
        _90 = _87;
    }
    else
    {
        _90 = 79;
    }
    return _90;
}

int _106(float _104, float _105)
{
    float _108 = 0.0;
    float _110 = 0.0;
    _108 = _104;
    _110 = _105;
    return int(clamp((_108 * 10.0) + _110, -2147483648.0, 2147483520.0));
}

uint _122(int _120, int _121)
{
    int _125 = 0;
    int _127 = 0;
    _125 = _120;
    _127 = _121;
    return uint((_125 + _127) + 100);
}

int _138(int _136, int _137)
{
    int _140 = 0;
    int _142 = 0;
    _140 = _136;
    _142 = _137;
    uint _148 = min(0u, 32u);
    uint _153 = min(0u, 32u);
    return int(uint(bitfieldExtract(_140, int(_148), int(min(24u, (32u - _148))))) * uint(bitfieldExtract(_142, int(_153), int(min(24u, (32u - _153))))));
}

void main()
{
    uint _463 = 0u;
    uint _328 = 0u;
    uint _439 = 0u;
    uint _304 = 0u;
    uint _280 = 0u;
    int _391[2] = int[](0, 0);
    uint _256 = 0u;
    uint _366 = 0u;
    uint _232 = 0u;
    uint _477 = 0u;
    int _342 = 0;
    uint _453 = 0u;
    uint _318 = 0u;
    uint _429 = 0u;
    uint _294 = 0u;
    uint _405 = 0u;
    uint _270 = 0u;
    uint _381 = 0u;
    uint _246 = 0u;
    uint _491 = 0u;
    uint _356 = 0u;
    uint _222 = 0u;
    uint _467 = 0u;
    uint _332 = 0u;
    uint _443 = 0u;
    uint _308 = 0u;
    uint _419 = 0u;
    uint _284 = 0u;
    uint _395 = 0u;
    uint _260 = 0u;
    uint _370 = 0u;
    uint _236 = 0u;
    uint _481 = 0u;
    uint _346 = 0u;
    uint _457 = 0u;
    uint _322 = 0u;
    uint _433 = 0u;
    uint _298 = 0u;
    uint _409 = 0u;
    uint _274 = 0u;
    uint _385 = 0u;
    uint _250 = 0u;
    uint _495 = 0u;
    uint _360 = 0u;
    uint _226 = 0u;
    uint _471 = 0u;
    uint _336 = 0u;
    uint _447 = 0u;
    uint _312 = 0u;
    uint _423 = 0u;
    uint _288 = 0u;
    int _399 = 0;
    uint _264 = 0u;
    uint _374 = 0u;
    uint _240 = 0u;
    uint _485 = 0u;
    uint _350 = 0u;
    uint _461 = 0u;
    uint _326 = 0u;
    uint _437 = 0u;
    uint _302 = 0u;
    int _413 = 0;
    uint _278 = 0u;
    int _389 = 0;
    uint _254 = 0u;
    uint _364 = 0u;
    uint _230 = 0u;
    uint _475 = 0u;
    uint _340 = 0u;
    uint _451 = 0u;
    uint _316 = 0u;
    uint _427 = 0u;
    uint _292 = 0u;
    uint _403 = 0u;
    uint _268 = 0u;
    int _378[2] = int[](0, 0);
    uint _244 = 0u;
    uint _489 = 0u;
    uint _354 = 0u;
    uint _219 = 0u;
    uint _465 = 0u;
    uint _330 = 0u;
    uint _441 = 0u;
    uint _306 = 0u;
    uint _417 = 0u;
    uint _282 = 0u;
    uint _393 = 0u;
    uint _258 = 0u;
    uint _368 = 0u;
    uint _234 = 0u;
    uint _479 = 0u;
    uint _344 = 0u;
    uint _455 = 0u;
    uint _320 = 0u;
    uint _431 = 0u;
    uint _296 = 0u;
    uint _407 = 0u;
    uint _272 = 0u;
    uint _383 = 0u;
    uint _248 = 0u;
    uint _493 = 0u;
    uint _358 = 0u;
    uint _224 = 0u;
    uint _469 = 0u;
    uint _334 = 0u;
    uint _445 = 0u;
    uint _310 = 0u;
    uint _421 = 0u;
    uint _286 = 0u;
    uint _397 = 0u;
    uint _262 = 0u;
    uint _372 = 0u;
    uint _238 = 0u;
    uint _483 = 0u;
    uint _348 = 0u;
    uint _459 = 0u;
    uint _324 = 0u;
    uint _435 = 0u;
    uint _300 = 0u;
    uint _411 = 0u;
    uint _276 = 0u;
    int _387 = 0;
    uint _252 = 0u;
    uint _497 = 0u;
    uint _362 = 0u;
    uint _228 = 0u;
    uint _473 = 0u;
    uint _338 = 0u;
    uint _449 = 0u;
    uint _314 = 0u;
    uint _425 = 0u;
    uint _290 = 0u;
    uint _401 = 0u;
    uint _266 = 0u;
    int _376 = 0;
    uint _242 = 0u;
    uint _487 = 0u;
    uint _352 = 0u;
    uvec2 _1037 = uvec2(4294967295u);
    _219 = 0u;
    uint _501 = min(0u, 32u);
    uint _506 = min(0u, 32u);
    _222 = _219;
    _224 = _222;
    _226 = uint(0);
    _435 = _224 + _226;
    _10._m0[_435] = uint(int(uint(bitfieldExtract(8388608, int(_501), int(min(24u, (32u - _501))))) * uint(bitfieldExtract(1, int(_506), int(min(24u, (32u - _506)))))));
    uint _523 = min(0u, 32u);
    uint _527 = min(0u, 32u);
    _228 = _219;
    _230 = _228;
    _232 = uint(1);
    _437 = _230 + _232;
    _10._m0[_437] = bitfieldExtract(16777215u, int(_523), int(min(24u, (32u - _523)))) * bitfieldExtract(16777215u, int(_527), int(min(24u, (32u - _527))));
    uint _540 = min(0u, 32u);
    uint _545 = min(0u, 32u);
    _234 = _219;
    _236 = _234;
    _238 = uint(2);
    _439 = _236 + _238;
    _10._m0[_439] = uint(int(uint(bitfieldExtract(8388607, int(_540), int(min(24u, (32u - _540))))) * uint(bitfieldExtract(8388607, int(_545), int(min(24u, (32u - _545)))))));
    uint _561 = min(0u, 32u);
    uint _565 = min(0u, 32u);
    _240 = _219;
    _242 = _240;
    _244 = uint(3);
    _441 = _242 + _244;
    _10._m0[_441] = bitfieldExtract(16777216u, int(_561), int(min(24u, (32u - _561)))) * bitfieldExtract(13u, int(_565), int(min(24u, (32u - _565))));
    float _577 = -2.75;
    _246 = _219;
    _248 = _246;
    _250 = uint(4);
    _443 = _248 + _250;
    _10._m0[_443] = uint(_16(3.75, _577));
    float _588 = -3.75;
    _252 = _219;
    _254 = _252;
    _256 = uint(5);
    _445 = _254 + _256;
    _10._m0[_445] = uint(_16(_588, 2.75));
    _258 = _219;
    _260 = _258;
    _262 = uint(6);
    _447 = _260 + _262;
    _10._m0[_447] = _50(3.75, 2.75);
    _264 = _219;
    _266 = _264;
    _268 = uint(7);
    _449 = _266 + _268;
    _10._m0[_449] = _50(16777215.0, 1.0);
    _270 = _219;
    _272 = _270;
    _274 = uint(8);
    _451 = _272 + _274;
    _10._m0[_451] = uint(_77(true, true));
    _276 = _219;
    _278 = _276;
    _280 = uint(9);
    _453 = _278 + _280;
    _10._m0[_453] = uint(_77(false, true));
    uint _639 = min(0u, 32u);
    uint _644 = min(0u, 32u);
    _282 = _219;
    _284 = _282;
    _286 = uint(10);
    _455 = _284 + _286;
    _10._m0[_455] = uint(int(uint(bitfieldExtract(3, int(_639), int(min(24u, (32u - _639))))) * uint(bitfieldExtract(int(true), int(_644), int(min(24u, (32u - _644)))))));
    uint _661 = min(0u, 32u);
    uint _666 = min(0u, 32u);
    _288 = _219;
    _290 = _288;
    _292 = uint(11);
    _457 = _290 + _292;
    _10._m0[_457] = uint(int(uint(bitfieldExtract(int(true), int(_661), int(min(24u, (32u - _661))))) * uint(bitfieldExtract(3, int(_666), int(min(24u, (32u - _666)))))));
    _294 = _219;
    _296 = _294;
    _298 = uint(12);
    _459 = _296 + _298;
    _10._m0[_459] = uint(_106(3.75, 2.0));
    _300 = _219;
    _302 = _300;
    _304 = uint(13);
    _461 = _302 + _304;
    _10._m0[_461] = _122(3, 4);
    uint _701 = min(0u, 32u);
    uint _705 = min(0u, 32u);
    _306 = _219;
    _308 = _306;
    _310 = uint(14);
    _463 = _308 + _310;
    _10._m0[_463] = bitfieldExtract(3u, int(_701), int(min(24u, (32u - _701)))) * bitfieldExtract(4u, int(_705), int(min(24u, (32u - _705))));
    _312 = _219;
    _314 = _312;
    _316 = uint(15);
    _465 = _314 + _316;
    _10._m0[_465] = _122(int(true), int(true));
    uint _730 = min(0u, 32u);
    uint _734 = min(0u, 32u);
    _318 = _219;
    _320 = _318;
    _322 = uint(16);
    _467 = _320 + _322;
    _10._m0[_467] = bitfieldExtract(3u, int(_730), int(min(24u, (32u - _730)))) * bitfieldExtract(uint(4), int(_734), int(min(24u, (32u - _734))));
    int _746 = -7;
    _324 = _219;
    _326 = _324;
    _328 = uint(17);
    _469 = _326 + _328;
    _10._m0[_469] = uint(_138(_746, 3));
    uint _758 = min(0u, 32u);
    uint _763 = min(0u, 32u);
    uint _770 = min(0u, 32u);
    uint _775 = min(0u, 32u);
    _330 = _219;
    _332 = _330;
    _334 = uint(18);
    _471 = _332 + _334;
    _10._m0[_471] = uint(int(uint(bitfieldExtract(int(uint(bitfieldExtract(3, int(_758), int(min(24u, (32u - _758))))) * uint(bitfieldExtract(4, int(_763), int(min(24u, (32u - _763)))))), int(_770), int(min(24u, (32u - _770))))) * uint(bitfieldExtract(5, int(_775), int(min(24u, (32u - _775)))))));
    uint _791 = min(0u, 32u);
    uint _795 = min(0u, 32u);
    uint _800 = min(0u, 32u);
    uint _804 = min(0u, 32u);
    _336 = _219;
    _338 = _336;
    _340 = uint(19);
    _473 = _338 + _340;
    _10._m0[_473] = bitfieldExtract(bitfieldExtract(16777215u, int(_791), int(min(24u, (32u - _791)))) * bitfieldExtract(2u, int(_795), int(min(24u, (32u - _795)))), int(_800), int(min(24u, (32u - _800)))) * bitfieldExtract(2u, int(_804), int(min(24u, (32u - _804))));
    _342 = -3;
    _344 = 5u;
    uint _820 = min(0u, 32u);
    uint _825 = min(0u, 32u);
    _346 = _219;
    _348 = _346;
    _350 = uint(20);
    _475 = _348 + _350;
    _10._m0[_475] = uint(int(uint(bitfieldExtract(_342, int(_820), int(min(24u, (32u - _820))))) * uint(bitfieldExtract(int(_344), int(_825), int(min(24u, (32u - _825)))))));
    uint _844 = min(0u, 32u);
    uint _848 = min(0u, 32u);
    _352 = _219;
    _354 = _352;
    _356 = uint(21);
    _477 = _354 + _356;
    _10._m0[_477] = bitfieldExtract(uint(_342), int(_844), int(min(24u, (32u - _844)))) * bitfieldExtract(_344, int(_848), int(min(24u, (32u - _848))));
    uint _861 = min(0u, 32u);
    uint _866 = min(0u, 32u);
    _358 = _219;
    _360 = _358;
    _362 = uint(22);
    _479 = _360 + _362;
    _10._m0[_479] = uint(int(uint(bitfieldExtract(25165824, int(_861), int(min(24u, (32u - _861))))) * uint(bitfieldExtract(16777217, int(_866), int(min(24u, (32u - _866)))))));
    uint _882 = min(0u, 32u);
    uint _886 = min(0u, 32u);
    _364 = _219;
    _366 = _364;
    _368 = uint(23);
    _481 = _366 + _368;
    _10._m0[_481] = bitfieldExtract(4286578688u, int(_882), int(min(24u, (32u - _882)))) * bitfieldExtract(4278190081u, int(_886), int(min(24u, (32u - _886))));
    if (true)
    {
        int _901 = -3;
        uint _903 = min(0u, 32u);
        uint _908 = min(0u, 32u);
        _376 = int(uint(bitfieldExtract(_901, int(_903), int(min(24u, (32u - _903))))) * uint(bitfieldExtract(7, int(_908), int(min(24u, (32u - _908))))));
    }
    else
    {
        uint _915 = min(0u, 32u);
        uint _920 = min(0u, 32u);
        _376 = int(uint(bitfieldExtract(0, int(_915), int(min(24u, (32u - _915))))) * uint(bitfieldExtract(0, int(_920), int(min(24u, (32u - _920))))));
    }
    _370 = _219;
    _372 = _370;
    _374 = uint(24);
    _483 = _372 + _374;
    _10._m0[_483] = uint(_376);
    uint _937 = min(0u, 32u);
    uint _942 = min(0u, 32u);
    _378[0u] = int(uint(bitfieldExtract(2, int(_937), int(min(24u, (32u - _937))))) * uint(bitfieldExtract(3, int(_942), int(min(24u, (32u - _942))))));
    uint _950 = min(0u, 32u);
    uint _955 = min(0u, 32u);
    _378[1u] = int(uint(bitfieldExtract(3, int(_950), int(min(24u, (32u - _950))))) * uint(bitfieldExtract(4, int(_955), int(min(24u, (32u - _955))))));
    _381 = _219;
    _383 = _381;
    _385 = uint(25);
    _485 = _383 + _385;
    _10._m0[_485] = uint(_378[0u] + _378[1u]);
    _387 = 2;
    _391 = int[](0, 0);
    _393 = _219;
    _395 = _393;
    _397 = uint(26);
    _487 = _395 + _397;
    _10._m0[_487] = uint(_387 + _391[0u]);
    _399 = 2;
    int _990 = _399;
    _399 = _990 + 1;
    int _992 = _399;
    _399 = _992 + 1;
    uint _995 = min(0u, 32u);
    uint _1000 = min(0u, 32u);
    _401 = _219;
    _403 = _401;
    _405 = uint(27);
    _489 = _403 + _405;
    _10._m0[_489] = uint(int(uint(bitfieldExtract(_990, int(_995), int(min(24u, (32u - _995))))) * uint(bitfieldExtract(_992, int(_1000), int(min(24u, (32u - _1000)))))));
    _407 = _219;
    _409 = _407;
    _411 = uint(28);
    _491 = _409 + _411;
    _10._m0[_491] = uint(_399);
    _413 = 0;
    int _415 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _1037)))
        {
            break;
        }
        _1037 -= uvec2(uint(_1037.y == 0u), 1u);
        if (!(_415 < 3))
        {
            break;
        }
        uint _1055 = min(0u, 32u);
        uint _1060 = min(0u, 32u);
        _413 += int(uint(bitfieldExtract(_415 + 1, int(_1055), int(min(24u, (32u - _1055))))) * uint(bitfieldExtract(2, int(_1060), int(min(24u, (32u - _1060))))));
        _415++;
        continue;
    }
    _417 = _219;
    _419 = _417;
    _421 = uint(29);
    _493 = _419 + _421;
    _10._m0[_493] = uint(_413);
    float _1082 = clamp(9.75, -2147483648.0, 2147483520.0);
    _423 = _219;
    _425 = _423;
    _427 = uint(30);
    _495 = _425 + _427;
    _10._m0[_495] = uint(int(_1082));
    uint _1094 = min(0u, 32u);
    uint _1099 = min(0u, 32u);
    _429 = _219;
    _431 = _429;
    _433 = uint(31);
    _497 = _431 + _433;
    _10._m0[_497] = uint(int(uint(bitfieldExtract(16777215, int(_1094), int(min(24u, (32u - _1094))))) * uint(bitfieldExtract(3, int(_1099), int(min(24u, (32u - _1099)))))));
}

