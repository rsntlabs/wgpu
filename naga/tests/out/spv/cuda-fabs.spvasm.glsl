#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    float _m0;
    float _m1;
    float _m2;
};

layout(set = 0, binding = 0, std430) buffer _12_11
{
    uint _m0[];
} _11;

float _142(float _141)
{
    uint _144 = 0u;
    uint _148 = floatBitsToUint(_141) & 2147483647u;
    _144 = (_148 > 2139095040u) ? 2143289344u : _148;
    return uintBitsToFloat(_144);
}

float _155(int _154)
{
    uint _157 = 0u;
    uint _162 = floatBitsToUint(float(_154)) & 2147483647u;
    _157 = (_162 > 2139095040u) ? 2143289344u : _162;
    return uintBitsToFloat(_157);
}

float _169(uint _168)
{
    uint _171 = 0u;
    uint _176 = floatBitsToUint(float(_168)) & 2147483647u;
    _171 = (_176 > 2139095040u) ? 2143289344u : _176;
    return uintBitsToFloat(_171);
}

float _183(bool _182)
{
    uint _185 = 0u;
    uint _192 = floatBitsToUint(float(_182)) & 2147483647u;
    _185 = (_192 > 2139095040u) ? 2143289344u : _192;
    return uintBitsToFloat(_185);
}

int _199(int _198)
{
    return _198 + 40;
}

uint _206(uint _205)
{
    return _205 + 50u;
}

int _213(bool _212)
{
    int _217 = 0;
    if (_212)
    {
        _217 = 7;
    }
    else
    {
        _217 = 9;
    }
    return _217;
}

int _227(bool _226)
{
    int _230 = 0;
    if (_226)
    {
        _230 = 11;
    }
    else
    {
        _230 = 13;
    }
    return _230;
}

_6 _52(_6 _51)
{
    uint _57 = 0u;
    uint _61 = 0u;
    _6 _54 = _6(0.0, 0.0, 0.0);
    uint _59 = 0u;
    _54 = _51;
    uint _67 = floatBitsToUint(_54._m0) & 2147483647u;
    _57 = (_67 > 2139095040u) ? 2143289344u : _67;
    uint _75 = floatBitsToUint(_54._m1) & 2147483647u;
    _59 = (_75 > 2139095040u) ? 2143289344u : _75;
    uint _84 = floatBitsToUint(_54._m2) & 2147483647u;
    _61 = (_84 > 2139095040u) ? 2143289344u : _84;
    return _6(uintBitsToFloat(_57), uintBitsToFloat(_59), uintBitsToFloat(_61));
}

float _240(float _238, float _239)
{
    return _238 + _239;
}

vec2 _16(vec2 _15)
{
    vec2 _21 = vec2(0.0);
    uint _24 = 0u;
    uint _27 = 0u;
    _21 = _15;
    uint _35 = floatBitsToUint(_21.x) & 2147483647u;
    _24 = (_35 > 2139095040u) ? 2143289344u : _35;
    uint _44 = floatBitsToUint(_21.y) & 2147483647u;
    _27 = (_44 > 2139095040u) ? 2143289344u : _44;
    return vec2(uintBitsToFloat(_24), uintBitsToFloat(_27));
}

vec4 _92(vec4 _91)
{
    uint _103 = 0u;
    uint _97 = 0u;
    uint _101 = 0u;
    vec4 _94 = vec4(0.0);
    uint _99 = 0u;
    _94 = _91;
    uint _109 = floatBitsToUint(_94.x) & 2147483647u;
    _97 = (_109 > 2139095040u) ? 2143289344u : _109;
    uint _117 = floatBitsToUint(_94.y) & 2147483647u;
    _99 = (_117 > 2139095040u) ? 2143289344u : _117;
    uint _125 = floatBitsToUint(_94.z) & 2147483647u;
    _101 = (_125 > 2139095040u) ? 2143289344u : _125;
    uint _134 = floatBitsToUint(_94.w) & 2147483647u;
    _103 = (_134 > 2139095040u) ? 2143289344u : _134;
    return vec4(uintBitsToFloat(_97), uintBitsToFloat(_99), uintBitsToFloat(_101), uintBitsToFloat(_103));
}

void main()
{
    vec2 _400 = vec2(0.0);
    _6 _388 = _6(0.0, 0.0, 0.0);
    uint _376 = 0u;
    uint _364 = 0u;
    uint _352 = 0u;
    uint _340 = 0u;
    uint _328 = 0u;
    uint _316 = 0u;
    uint _304 = 0u;
    uint _292 = 0u;
    vec4 _402 = vec4(0.0);
    uint _390 = 0u;
    uint _378 = 0u;
    uint _366 = 0u;
    uint _354 = 0u;
    uint _342 = 0u;
    uint _330 = 0u;
    uint _318 = 0u;
    uint _306 = 0u;
    uint _294 = 0u;
    uint _404 = 0u;
    uint _392 = 0u;
    uint _380 = 0u;
    uint _368 = 0u;
    uint _356 = 0u;
    uint _344 = 0u;
    uint _332 = 0u;
    uint _320 = 0u;
    uint _308 = 0u;
    uint _296 = 0u;
    uint _394 = 0u;
    uint _382 = 0u;
    float _370 = 0.0;
    uint _358 = 0u;
    uint _346 = 0u;
    uint _334 = 0u;
    uint _322 = 0u;
    uint _310 = 0u;
    uint _298 = 0u;
    uint _396 = 0u;
    uint _384 = 0u;
    uint _372 = 0u;
    uint _360 = 0u;
    uint _348 = 0u;
    uint _336 = 0u;
    uint _324 = 0u;
    uint _312 = 0u;
    uint _300 = 0u;
    uint _398 = 0u;
    uint _386 = 0u;
    uint _374 = 0u;
    uint _362 = 0u;
    uint _350 = 0u;
    uint _338 = 0u;
    uint _326 = 0u;
    uint _314 = 0u;
    uint _302 = 0u;
    uint _408 = floatBitsToUint(0.0) & 2147483647u;
    _294 = (_408 > 2139095040u) ? 2143289344u : _408;
    _292 = uint(0);
    _11._m0[_292] = floatBitsToUint(uintBitsToFloat(_294));
    float _418 = -0.0;
    uint _420 = floatBitsToUint(_418) & 2147483647u;
    _298 = (_420 > 2139095040u) ? 2143289344u : _420;
    _296 = uint(1);
    _11._m0[_296] = floatBitsToUint(uintBitsToFloat(_298));
    float _429 = -1.75;
    uint _431 = floatBitsToUint(_429) & 2147483647u;
    _302 = (_431 > 2139095040u) ? 2143289344u : _431;
    _300 = uint(2);
    _11._m0[_300] = floatBitsToUint(uintBitsToFloat(_302));
    float _440 = -1.25;
    _304 = uint(3);
    _11._m0[_304] = floatBitsToUint(_142(_440));
    int _446 = -3;
    _306 = uint(4);
    _11._m0[_306] = floatBitsToUint(_155(_446));
    _308 = uint(5);
    _11._m0[_308] = floatBitsToUint(_169(4294967295u));
    _310 = uint(6);
    _11._m0[_310] = floatBitsToUint(_183(true));
    _312 = uint(7);
    _11._m0[_312] = floatBitsToUint(_183(false));
    _316 = 1u;
    uint _470 = floatBitsToUint(uintBitsToFloat(_316)) & 2147483647u;
    _318 = (_470 > 2139095040u) ? 2143289344u : _470;
    _314 = uint(8);
    _11._m0[_314] = floatBitsToUint(uintBitsToFloat(_318));
    _322 = 2147483649u;
    uint _482 = floatBitsToUint(uintBitsToFloat(_322)) & 2147483647u;
    _324 = (_482 > 2139095040u) ? 2143289344u : _482;
    _320 = uint(9);
    _11._m0[_320] = floatBitsToUint(uintBitsToFloat(_324));
    _328 = 8388607u;
    uint _494 = floatBitsToUint(uintBitsToFloat(_328)) & 2147483647u;
    _330 = (_494 > 2139095040u) ? 2143289344u : _494;
    _326 = uint(10);
    _11._m0[_326] = floatBitsToUint(uintBitsToFloat(_330));
    _334 = 2155872255u;
    uint _506 = floatBitsToUint(uintBitsToFloat(_334)) & 2147483647u;
    _336 = (_506 > 2139095040u) ? 2143289344u : _506;
    _332 = uint(11);
    _11._m0[_332] = floatBitsToUint(uintBitsToFloat(_336));
    uint _516 = floatBitsToUint(3.4028234663852885981170418348452e+38) & 2147483647u;
    _340 = (_516 > 2139095040u) ? 2143289344u : _516;
    _338 = uint(12);
    _11._m0[_338] = floatBitsToUint(uintBitsToFloat(_340));
    float _525 = -3.4028234663852885981170418348452e+38;
    uint _527 = floatBitsToUint(_525) & 2147483647u;
    _344 = (_527 > 2139095040u) ? 2143289344u : _527;
    _342 = uint(13);
    _11._m0[_342] = floatBitsToUint(uintBitsToFloat(_344));
    _348 = 2139095040u;
    uint _539 = floatBitsToUint(uintBitsToFloat(_348)) & 2147483647u;
    _350 = (_539 > 2139095040u) ? 2143289344u : _539;
    _346 = uint(14);
    _11._m0[_346] = floatBitsToUint(uintBitsToFloat(_350));
    _354 = 4286578688u;
    uint _551 = floatBitsToUint(uintBitsToFloat(_354)) & 2147483647u;
    _356 = (_551 > 2139095040u) ? 2143289344u : _551;
    _352 = uint(15);
    _11._m0[_352] = floatBitsToUint(uintBitsToFloat(_356));
    _360 = 2143363909u;
    uint _563 = floatBitsToUint(uintBitsToFloat(_360)) & 2147483647u;
    _362 = (_563 > 2139095040u) ? 2143289344u : _563;
    _358 = uint(16);
    _11._m0[_358] = floatBitsToUint(uintBitsToFloat(_362));
    _366 = 2139095041u;
    uint _575 = floatBitsToUint(uintBitsToFloat(_366)) & 2147483647u;
    _368 = (_575 > 2139095040u) ? 2143289344u : _575;
    _364 = uint(17);
    _11._m0[_364] = floatBitsToUint(uintBitsToFloat(_368));
    float _584 = -2.75;
    _370 = _584;
    float _585 = _370;
    float _586 = float(1);
    _370 = _585 + _586;
    uint _589 = floatBitsToUint(_585) & 2147483647u;
    _374 = (_589 > 2139095040u) ? 2143289344u : _589;
    _372 = uint(18);
    _11._m0[_372] = floatBitsToUint(uintBitsToFloat(_374));
    _376 = uint(19);
    _11._m0[_376] = floatBitsToUint(_370);
    int _603 = -3;
    _378 = uint(20);
    _11._m0[_378] = uint(_199(_603));
    _380 = uint(21);
    _11._m0[_380] = _206(3u);
    _382 = uint(22);
    _11._m0[_382] = uint(_213(true));
    _384 = uint(23);
    _11._m0[_384] = uint(_213(false));
    _386 = uint(24);
    _11._m0[_386] = uint(_227(true));
    float _628 = -2.5;
    float _629 = -0.0;
    _390 = 2147483649u;
    _388 = _52(_6(_628, _629, uintBitsToFloat(_390)));
    _392 = uint(25);
    _11._m0[_392] = floatBitsToUint(_388._m0);
    _394 = uint(26);
    _11._m0[_394] = floatBitsToUint(_388._m1);
    _396 = uint(27);
    _11._m0[_396] = floatBitsToUint(_388._m2);
    float _652 = -2.0;
    _398 = uint(28);
    _11._m0[_398] = floatBitsToUint(_240(_652, 3.0));
    float _658 = -3.0;
    float _659 = -4.0;
    _400 = _16(vec2(_658, _659));
    float _662 = -1.0;
    float _663 = -2.0;
    float _664 = -3.0;
    float _665 = -4.0;
    _402 = _92(vec4(_662, _663, _664, _665));
    _404 = uint(29);
    _11._m0[_404] = floatBitsToUint(((_400.x + _400.y) + _402.x) + _402.w);
}

