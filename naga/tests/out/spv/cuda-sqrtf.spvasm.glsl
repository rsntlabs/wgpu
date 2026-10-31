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

float _147(int _146)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_146))));
}

float _156(uint _155)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_155))));
}

float _139(float _138)
{
    return uintBitsToFloat(_13(floatBitsToUint(_138)));
}

int _176(bool _175)
{
    int _180 = 0;
    if (_175)
    {
        _180 = 7;
    }
    else
    {
        _180 = 9;
    }
    return _180;
}

float _191(float _189, float _190)
{
    return _189 + _190;
}

float _165(bool _164)
{
    return uintBitsToFloat(_13(floatBitsToUint(float(_164))));
}

void main()
{
    uint _364 = 0u;
    uint _352 = 0u;
    uint _340 = 0u;
    uint _328 = 0u;
    uint _316 = 0u;
    uint _304 = 0u;
    uint _292 = 0u;
    uint _279 = 0u;
    uint _267 = 0u;
    uint _255 = 0u;
    uint _378 = 0u;
    uint _243 = 0u;
    uint _366 = 0u;
    uint _354 = 0u;
    uint _342 = 0u;
    uint _330 = 0u;
    uint _318 = 0u;
    uint _306 = 0u;
    uint _294 = 0u;
    uint _281 = 0u;
    uint _269 = 0u;
    uint _257 = 0u;
    uint _380 = 0u;
    uint _245 = 0u;
    uint _368 = 0u;
    uint _356 = 0u;
    uint _344 = 0u;
    uint _332 = 0u;
    uint _320 = 0u;
    uint _308 = 0u;
    uint _296 = 0u;
    float _283 = 0.0;
    uint _271 = 0u;
    uint _259 = 0u;
    uint _382 = 0u;
    uint _247 = 0u;
    uint _370 = 0u;
    uint _358 = 0u;
    uint _346 = 0u;
    uint _334 = 0u;
    uint _322 = 0u;
    uint _310 = 0u;
    uint _298 = 0u;
    uint _286 = 0u;
    uint _273 = 0u;
    uint _261 = 0u;
    uint _384 = 0u;
    uint _249 = 0u;
    uint _372 = 0u;
    uint _360 = 0u;
    uint _348 = 0u;
    uint _336 = 0u;
    uint _324 = 0u;
    uint _312 = 0u;
    uint _300 = 0u;
    uint _288 = 0u;
    uint _275 = 0u;
    uint _263 = 0u;
    uint _251 = 0u;
    uint _374 = 0u;
    uint _362 = 0u;
    uint _350 = 0u;
    uint _338 = 0u;
    uint _326 = 0u;
    uint _314 = 0u;
    uint _302 = 0u;
    uint _290 = 0u;
    uint _277 = 0u;
    uint _265 = 0u;
    uint _253 = 0u;
    uint _376 = 0u;
    _243 = uint(0);
    _326 = _243;
    _8._m0[_326] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.0))));
    float _396 = -0.0;
    _245 = uint(1);
    _328 = _245;
    _8._m0[_328] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_396))));
    _247 = uint(2);
    _330 = _247;
    _8._m0[_330] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(1.0))));
    _249 = uint(3);
    _332 = _249;
    _8._m0[_332] = floatBitsToUint(_147(4));
    _251 = uint(4);
    _334 = _251;
    _8._m0[_334] = floatBitsToUint(_156(9u));
    _253 = uint(5);
    _336 = _253;
    _8._m0[_336] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(6.25))));
    _255 = uint(6);
    _338 = _255;
    _8._m0[_338] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(2.0))));
    _259 = 1u;
    _257 = uint(7);
    _340 = _257;
    _8._m0[_340] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_259)))));
    _263 = 8388607u;
    _261 = uint(8);
    _342 = _261;
    _8._m0[_342] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_263)))));
    _267 = 8388608u;
    _265 = uint(9);
    _344 = _265;
    _8._m0[_344] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_267)))));
    _271 = 2139095039u;
    _269 = uint(10);
    _346 = _269;
    _8._m0[_346] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_271)))));
    _275 = 2139095040u;
    _273 = uint(11);
    _348 = _273;
    _8._m0[_348] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_275)))));
    float _491 = -1.0;
    _277 = uint(12);
    _350 = _277;
    _8._m0[_350] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_491))));
    _281 = 2139095041u;
    _279 = uint(13);
    _352 = _279;
    _8._m0[_352] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_281)))));
    _283 = 4.0;
    float _510 = _283;
    float _511 = float(1);
    _283 = _510 + _511;
    _286 = uint(14);
    _354 = _286;
    _8._m0[_354] = floatBitsToUint(_139(_510));
    _288 = uint(15);
    _356 = _288;
    _8._m0[_356] = floatBitsToUint(_283);
    _290 = uint(16);
    _358 = _290;
    _8._m0[_358] = uint(_176(true));
    _292 = uint(17);
    _360 = _292;
    _8._m0[_360] = uint(_176(false));
    _294 = uint(18);
    _362 = _294;
    _8._m0[_362] = floatBitsToUint(_191(2.0, 3.0));
    _298 = 1065353217u;
    _296 = uint(19);
    _364 = _296;
    _8._m0[_364] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_298)))));
    _302 = 1065353218u;
    _300 = uint(20);
    _366 = _300;
    _8._m0[_366] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_302)))));
    _306 = 1065353215u;
    _304 = uint(21);
    _368 = _304;
    _8._m0[_368] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_306)))));
    _308 = uint(22);
    _370 = _308;
    _8._m0[_370] = floatBitsToUint(_156(4294967295u));
    int _579 = -4;
    _310 = uint(23);
    _372 = _310;
    _8._m0[_372] = floatBitsToUint(_147(_579));
    _312 = uint(24);
    _374 = _312;
    _8._m0[_374] = floatBitsToUint(_139(16.0));
    _314 = uint(25);
    _376 = _314;
    _8._m0[_376] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.25))));
    _318 = 2147483649u;
    _316 = uint(26);
    _378 = _316;
    _8._m0[_378] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_318)))));
    _320 = uint(27);
    _380 = _320;
    _8._m0[_380] = floatBitsToUint(_165(false));
    _322 = uint(28);
    _382 = _322;
    _8._m0[_382] = floatBitsToUint(_165(true));
    _324 = uint(29);
    _384 = _324;
    _8._m0[_384] = floatBitsToUint(_139(0.5));
}

