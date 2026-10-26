#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

uint _13(uint _12)
{
    uint _42 = 0u;
    uint _36 = 0u;
    uint _40 = 0u;
    uint _33 = 0u;
    uint _44 = 0u;
    uint _38 = 0u;
    uvec2 _91 = uvec2(4294967295u);
    uint _49 = _12 & 2147483647u;
    if ((_49 == 0u) || (_12 == 2139095040u))
    {
        return _12;
    }
    if (((_12 & 2147483648u) != 0u) || (_49 > 2139095040u))
    {
        return 2143289344u;
    }
    uint _61 = _12 & 8388607u;
    uint _62 = _49 >> 23u;
    _33 = _61 | 8388608u;
    _36 = _62 + 127u;
    if (_62 == 0u)
    {
        uint _71 = (31u - uint(findMSB(_61))) - 8u;
        _33 = _61 << _71;
        _36 = 128u - _71;
    }
    uint _76 = _36 & 1u;
    _38 = _33 >> (9u - _76);
    _40 = _33 << (23u + _76);
    _42 = 0u;
    _44 = 0u;
    uint _46 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _91)))
        {
            break;
        }
        _91 -= uvec2(uint(_91.y == 0u), 1u);
        if (_46 >= 24u)
        {
            break;
        }
        uint _106 = _38;
        uint _109 = _44;
        uint _117 = (_109 << 2u) | (_106 >> 14u);
        uint _119 = (_42 << 2u) | 1u;
        bool _120 = _117 >= _119;
        uint _123 = _42 << 1u;
        _38 = ((_106 << 2u) | (_40 >> 30u)) & 65535u;
        _40 = _40 << 2u;
        _44 = _120 ? (_117 - _119) : _117;
        _42 = _120 ? (_123 | 1u) : _123;
        _46++;
        continue;
    }
    return ((_36 >> 1u) << 23u) | (((_44 > _42) ? (_42 + 1u) : _42) & 8388607u);
}

float _151(int _150)
{
    int _153 = 0;
    _153 = _150;
    return uintBitsToFloat(_13(floatBitsToUint(float(_153))));
}

float _164(uint _163)
{
    uint _166 = 0u;
    _166 = _163;
    return uintBitsToFloat(_13(floatBitsToUint(float(_166))));
}

float _139(float _138)
{
    float _141 = 0.0;
    _141 = _138;
    return uintBitsToFloat(_13(floatBitsToUint(_141)));
}

int _191(bool _190)
{
    bool _195 = false;
    int _197 = 0;
    _195 = _190;
    if (_195)
    {
        _197 = 7;
    }
    else
    {
        _197 = 9;
    }
    return _197;
}

float _208(float _206, float _207)
{
    float _210 = 0.0;
    float _212 = 0.0;
    _210 = _206;
    _212 = _207;
    return _210 + _212;
}

float _176(bool _175)
{
    bool _178 = false;
    _178 = _175;
    return uintBitsToFloat(_13(floatBitsToUint(float(_178))));
}

void main()
{
    uint _508 = 0u;
    uint _374 = 0u;
    uint _484 = 0u;
    uint _350 = 0u;
    uint _460 = 0u;
    uint _326 = 0u;
    uint _436 = 0u;
    uint _302 = 0u;
    uint _412 = 0u;
    uint _278 = 0u;
    uint _522 = 0u;
    uint _388 = 0u;
    uint _498 = 0u;
    float _364 = 0.0;
    uint _474 = 0u;
    uint _340 = 0u;
    uint _450 = 0u;
    uint _316 = 0u;
    uint _426 = 0u;
    uint _292 = 0u;
    uint _402 = 0u;
    uint _268 = 0u;
    uint _512 = 0u;
    uint _378 = 0u;
    uint _488 = 0u;
    uint _354 = 0u;
    uint _464 = 0u;
    uint _330 = 0u;
    uint _440 = 0u;
    uint _306 = 0u;
    uint _416 = 0u;
    uint _282 = 0u;
    uint _526 = 0u;
    uint _392 = 0u;
    uint _502 = 0u;
    uint _368 = 0u;
    uint _478 = 0u;
    uint _344 = 0u;
    uint _454 = 0u;
    uint _320 = 0u;
    uint _430 = 0u;
    uint _296 = 0u;
    uint _406 = 0u;
    uint _272 = 0u;
    uint _516 = 0u;
    uint _382 = 0u;
    uint _492 = 0u;
    uint _358 = 0u;
    uint _468 = 0u;
    uint _334 = 0u;
    uint _444 = 0u;
    uint _310 = 0u;
    uint _420 = 0u;
    uint _286 = 0u;
    uint _396 = 0u;
    uint _506 = 0u;
    uint _372 = 0u;
    uint _482 = 0u;
    uint _348 = 0u;
    uint _458 = 0u;
    uint _324 = 0u;
    uint _434 = 0u;
    uint _300 = 0u;
    uint _410 = 0u;
    uint _276 = 0u;
    uint _520 = 0u;
    uint _386 = 0u;
    uint _496 = 0u;
    uint _362 = 0u;
    uint _472 = 0u;
    uint _338 = 0u;
    uint _448 = 0u;
    uint _314 = 0u;
    uint _424 = 0u;
    uint _290 = 0u;
    uint _400 = 0u;
    uint _266 = 0u;
    uint _510 = 0u;
    uint _376 = 0u;
    uint _486 = 0u;
    uint _352 = 0u;
    uint _462 = 0u;
    uint _328 = 0u;
    uint _438 = 0u;
    uint _304 = 0u;
    uint _414 = 0u;
    uint _280 = 0u;
    uint _524 = 0u;
    uint _390 = 0u;
    uint _500 = 0u;
    uint _366 = 0u;
    uint _476 = 0u;
    uint _342 = 0u;
    uint _452 = 0u;
    uint _318 = 0u;
    uint _428 = 0u;
    uint _294 = 0u;
    uint _404 = 0u;
    uint _270 = 0u;
    uint _514 = 0u;
    uint _380 = 0u;
    uint _490 = 0u;
    uint _356 = 0u;
    uint _466 = 0u;
    uint _332 = 0u;
    uint _442 = 0u;
    uint _308 = 0u;
    uint _418 = 0u;
    uint _284 = 0u;
    uint _528 = 0u;
    uint _394 = 0u;
    uint _504 = 0u;
    uint _370 = 0u;
    uint _480 = 0u;
    uint _346 = 0u;
    uint _456 = 0u;
    uint _322 = 0u;
    uint _432 = 0u;
    uint _298 = 0u;
    uint _408 = 0u;
    uint _274 = 0u;
    uint _518 = 0u;
    uint _384 = 0u;
    uint _494 = 0u;
    uint _360 = 0u;
    uint _470 = 0u;
    uint _336 = 0u;
    uint _446 = 0u;
    uint _312 = 0u;
    uint _422 = 0u;
    uint _288 = 0u;
    uint _398 = 0u;
    _266 = 0u;
    _268 = _266;
    _270 = _268;
    _272 = uint(0);
    _470 = _270 + _272;
    _8._m0[_470] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.0))));
    float _544 = -0.0;
    _274 = _266;
    _276 = _274;
    _278 = uint(1);
    _472 = _276 + _278;
    _8._m0[_472] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_544))));
    _280 = _266;
    _282 = _280;
    _284 = uint(2);
    _474 = _282 + _284;
    _8._m0[_474] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(1.0))));
    _286 = _266;
    _288 = _286;
    _290 = uint(3);
    _476 = _288 + _290;
    _8._m0[_476] = floatBitsToUint(_151(4));
    _292 = _266;
    _294 = _292;
    _296 = uint(4);
    _478 = _294 + _296;
    _8._m0[_478] = floatBitsToUint(_164(9u));
    _298 = _266;
    _300 = _298;
    _302 = uint(5);
    _480 = _300 + _302;
    _8._m0[_480] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(6.25))));
    _304 = _266;
    _306 = _304;
    _308 = uint(6);
    _482 = _306 + _308;
    _8._m0[_482] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(2.0))));
    _316 = 1u;
    _310 = _266;
    _312 = _310;
    _314 = uint(7);
    _484 = _312 + _314;
    _8._m0[_484] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_316)))));
    _324 = 8388607u;
    _318 = _266;
    _320 = _318;
    _322 = uint(8);
    _486 = _320 + _322;
    _8._m0[_486] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_324)))));
    _332 = 8388608u;
    _326 = _266;
    _328 = _326;
    _330 = uint(9);
    _488 = _328 + _330;
    _8._m0[_488] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_332)))));
    _340 = 2139095039u;
    _334 = _266;
    _336 = _334;
    _338 = uint(10);
    _490 = _336 + _338;
    _8._m0[_490] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_340)))));
    _348 = 2139095040u;
    _342 = _266;
    _344 = _342;
    _346 = uint(11);
    _492 = _344 + _346;
    _8._m0[_492] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_348)))));
    float _683 = -1.0;
    _350 = _266;
    _352 = _350;
    _354 = uint(12);
    _494 = _352 + _354;
    _8._m0[_494] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_683))));
    _362 = 2139095041u;
    _356 = _266;
    _358 = _356;
    _360 = uint(13);
    _496 = _358 + _360;
    _8._m0[_496] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_362)))));
    _364 = 4.0;
    float _710 = _364;
    float _711 = float(1);
    _364 = _710 + _711;
    _366 = _266;
    _368 = _366;
    _370 = uint(14);
    _498 = _368 + _370;
    _8._m0[_498] = floatBitsToUint(_139(_710));
    _372 = _266;
    _374 = _372;
    _376 = uint(15);
    _500 = _374 + _376;
    _8._m0[_500] = floatBitsToUint(_364);
    _378 = _266;
    _380 = _378;
    _382 = uint(16);
    _502 = _380 + _382;
    _8._m0[_502] = uint(_191(true));
    _384 = _266;
    _386 = _384;
    _388 = uint(17);
    _504 = _386 + _388;
    _8._m0[_504] = uint(_191(false));
    _390 = _266;
    _392 = _390;
    _394 = uint(18);
    _506 = _392 + _394;
    _8._m0[_506] = floatBitsToUint(_208(2.0, 3.0));
    _402 = 1065353217u;
    _396 = _266;
    _398 = _396;
    _400 = uint(19);
    _508 = _398 + _400;
    _8._m0[_508] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_402)))));
    _410 = 1065353218u;
    _404 = _266;
    _406 = _404;
    _408 = uint(20);
    _510 = _406 + _408;
    _8._m0[_510] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_410)))));
    _418 = 1065353215u;
    _412 = _266;
    _414 = _412;
    _416 = uint(21);
    _512 = _414 + _416;
    _8._m0[_512] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_418)))));
    _420 = _266;
    _422 = _420;
    _424 = uint(22);
    _514 = _422 + _424;
    _8._m0[_514] = floatBitsToUint(_164(4294967295u));
    int _815 = -4;
    _426 = _266;
    _428 = _426;
    _430 = uint(23);
    _516 = _428 + _430;
    _8._m0[_516] = floatBitsToUint(_151(_815));
    _432 = _266;
    _434 = _432;
    _436 = uint(24);
    _518 = _434 + _436;
    _8._m0[_518] = floatBitsToUint(_139(16.0));
    _438 = _266;
    _440 = _438;
    _442 = uint(25);
    _520 = _440 + _442;
    _8._m0[_520] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.25))));
    _450 = 2147483649u;
    _444 = _266;
    _446 = _444;
    _448 = uint(26);
    _522 = _446 + _448;
    _8._m0[_522] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_450)))));
    _452 = _266;
    _454 = _452;
    _456 = uint(27);
    _524 = _454 + _456;
    _8._m0[_524] = floatBitsToUint(_176(false));
    _458 = _266;
    _460 = _458;
    _462 = uint(28);
    _526 = _460 + _462;
    _8._m0[_526] = floatBitsToUint(_176(true));
    _464 = _266;
    _466 = _464;
    _468 = uint(29);
    _528 = _466 + _468;
    _8._m0[_528] = floatBitsToUint(_139(0.5));
}

