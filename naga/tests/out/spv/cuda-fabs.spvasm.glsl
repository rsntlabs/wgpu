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
    uint _412 = 0u;
    vec2 _400 = vec2(0.0);
    _6 _388 = _6(0.0, 0.0, 0.0);
    uint _376 = 0u;
    uint _364 = 0u;
    uint _352 = 0u;
    uint _340 = 0u;
    uint _462 = 0u;
    uint _328 = 0u;
    uint _450 = 0u;
    uint _316 = 0u;
    uint _438 = 0u;
    uint _304 = 0u;
    uint _426 = 0u;
    uint _292 = 0u;
    uint _414 = 0u;
    vec4 _402 = vec4(0.0);
    uint _390 = 0u;
    uint _378 = 0u;
    uint _366 = 0u;
    uint _354 = 0u;
    uint _342 = 0u;
    uint _464 = 0u;
    uint _330 = 0u;
    uint _452 = 0u;
    uint _318 = 0u;
    uint _440 = 0u;
    uint _306 = 0u;
    uint _428 = 0u;
    uint _294 = 0u;
    uint _416 = 0u;
    uint _404 = 0u;
    uint _392 = 0u;
    uint _380 = 0u;
    uint _368 = 0u;
    uint _356 = 0u;
    uint _344 = 0u;
    uint _332 = 0u;
    uint _454 = 0u;
    uint _320 = 0u;
    uint _442 = 0u;
    uint _308 = 0u;
    uint _430 = 0u;
    uint _296 = 0u;
    uint _418 = 0u;
    uint _406 = 0u;
    uint _394 = 0u;
    uint _382 = 0u;
    float _370 = 0.0;
    uint _358 = 0u;
    uint _346 = 0u;
    uint _334 = 0u;
    uint _456 = 0u;
    uint _322 = 0u;
    uint _444 = 0u;
    uint _310 = 0u;
    uint _432 = 0u;
    uint _298 = 0u;
    uint _420 = 0u;
    uint _408 = 0u;
    uint _396 = 0u;
    uint _384 = 0u;
    uint _372 = 0u;
    uint _360 = 0u;
    uint _348 = 0u;
    uint _336 = 0u;
    uint _458 = 0u;
    uint _324 = 0u;
    uint _446 = 0u;
    uint _312 = 0u;
    uint _434 = 0u;
    uint _300 = 0u;
    uint _422 = 0u;
    uint _410 = 0u;
    uint _398 = 0u;
    uint _386 = 0u;
    uint _374 = 0u;
    uint _362 = 0u;
    uint _350 = 0u;
    uint _338 = 0u;
    uint _460 = 0u;
    uint _326 = 0u;
    uint _448 = 0u;
    uint _314 = 0u;
    uint _436 = 0u;
    uint _302 = 0u;
    uint _424 = 0u;
    uint _468 = floatBitsToUint(0.0) & 2147483647u;
    _294 = (_468 > 2139095040u) ? 2143289344u : _468;
    _292 = uint(0);
    _406 = _292;
    _11._m0[_406] = floatBitsToUint(uintBitsToFloat(_294));
    float _479 = -0.0;
    uint _481 = floatBitsToUint(_479) & 2147483647u;
    _298 = (_481 > 2139095040u) ? 2143289344u : _481;
    _296 = uint(1);
    _408 = _296;
    _11._m0[_408] = floatBitsToUint(uintBitsToFloat(_298));
    float _491 = -1.75;
    uint _493 = floatBitsToUint(_491) & 2147483647u;
    _302 = (_493 > 2139095040u) ? 2143289344u : _493;
    _300 = uint(2);
    _410 = _300;
    _11._m0[_410] = floatBitsToUint(uintBitsToFloat(_302));
    float _503 = -1.25;
    _304 = uint(3);
    _412 = _304;
    _11._m0[_412] = floatBitsToUint(_142(_503));
    int _510 = -3;
    _306 = uint(4);
    _414 = _306;
    _11._m0[_414] = floatBitsToUint(_155(_510));
    _308 = uint(5);
    _416 = _308;
    _11._m0[_416] = floatBitsToUint(_169(4294967295u));
    _310 = uint(6);
    _418 = _310;
    _11._m0[_418] = floatBitsToUint(_183(true));
    _312 = uint(7);
    _420 = _312;
    _11._m0[_420] = floatBitsToUint(_183(false));
    _316 = 1u;
    uint _538 = floatBitsToUint(uintBitsToFloat(_316)) & 2147483647u;
    _318 = (_538 > 2139095040u) ? 2143289344u : _538;
    _314 = uint(8);
    _422 = _314;
    _11._m0[_422] = floatBitsToUint(uintBitsToFloat(_318));
    _322 = 2147483649u;
    uint _551 = floatBitsToUint(uintBitsToFloat(_322)) & 2147483647u;
    _324 = (_551 > 2139095040u) ? 2143289344u : _551;
    _320 = uint(9);
    _424 = _320;
    _11._m0[_424] = floatBitsToUint(uintBitsToFloat(_324));
    _328 = 8388607u;
    uint _564 = floatBitsToUint(uintBitsToFloat(_328)) & 2147483647u;
    _330 = (_564 > 2139095040u) ? 2143289344u : _564;
    _326 = uint(10);
    _426 = _326;
    _11._m0[_426] = floatBitsToUint(uintBitsToFloat(_330));
    _334 = 2155872255u;
    uint _577 = floatBitsToUint(uintBitsToFloat(_334)) & 2147483647u;
    _336 = (_577 > 2139095040u) ? 2143289344u : _577;
    _332 = uint(11);
    _428 = _332;
    _11._m0[_428] = floatBitsToUint(uintBitsToFloat(_336));
    uint _588 = floatBitsToUint(3.4028234663852885981170418348452e+38) & 2147483647u;
    _340 = (_588 > 2139095040u) ? 2143289344u : _588;
    _338 = uint(12);
    _430 = _338;
    _11._m0[_430] = floatBitsToUint(uintBitsToFloat(_340));
    float _598 = -3.4028234663852885981170418348452e+38;
    uint _600 = floatBitsToUint(_598) & 2147483647u;
    _344 = (_600 > 2139095040u) ? 2143289344u : _600;
    _342 = uint(13);
    _432 = _342;
    _11._m0[_432] = floatBitsToUint(uintBitsToFloat(_344));
    _348 = 2139095040u;
    uint _613 = floatBitsToUint(uintBitsToFloat(_348)) & 2147483647u;
    _350 = (_613 > 2139095040u) ? 2143289344u : _613;
    _346 = uint(14);
    _434 = _346;
    _11._m0[_434] = floatBitsToUint(uintBitsToFloat(_350));
    _354 = 4286578688u;
    uint _626 = floatBitsToUint(uintBitsToFloat(_354)) & 2147483647u;
    _356 = (_626 > 2139095040u) ? 2143289344u : _626;
    _352 = uint(15);
    _436 = _352;
    _11._m0[_436] = floatBitsToUint(uintBitsToFloat(_356));
    _360 = 2143363909u;
    uint _639 = floatBitsToUint(uintBitsToFloat(_360)) & 2147483647u;
    _362 = (_639 > 2139095040u) ? 2143289344u : _639;
    _358 = uint(16);
    _438 = _358;
    _11._m0[_438] = floatBitsToUint(uintBitsToFloat(_362));
    _366 = 2139095041u;
    uint _652 = floatBitsToUint(uintBitsToFloat(_366)) & 2147483647u;
    _368 = (_652 > 2139095040u) ? 2143289344u : _652;
    _364 = uint(17);
    _440 = _364;
    _11._m0[_440] = floatBitsToUint(uintBitsToFloat(_368));
    float _662 = -2.75;
    _370 = _662;
    float _663 = _370;
    float _664 = float(1);
    _370 = _663 + _664;
    uint _667 = floatBitsToUint(_663) & 2147483647u;
    _374 = (_667 > 2139095040u) ? 2143289344u : _667;
    _372 = uint(18);
    _442 = _372;
    _11._m0[_442] = floatBitsToUint(uintBitsToFloat(_374));
    _376 = uint(19);
    _444 = _376;
    _11._m0[_444] = floatBitsToUint(_370);
    int _683 = -3;
    _378 = uint(20);
    _446 = _378;
    _11._m0[_446] = uint(_199(_683));
    _380 = uint(21);
    _448 = _380;
    _11._m0[_448] = _206(3u);
    _382 = uint(22);
    _450 = _382;
    _11._m0[_450] = uint(_213(true));
    _384 = uint(23);
    _452 = _384;
    _11._m0[_452] = uint(_213(false));
    _386 = uint(24);
    _454 = _386;
    _11._m0[_454] = uint(_227(true));
    float _713 = -2.5;
    float _714 = -0.0;
    _390 = 2147483649u;
    _388 = _52(_6(_713, _714, uintBitsToFloat(_390)));
    _392 = uint(25);
    _456 = _392;
    _11._m0[_456] = floatBitsToUint(_388._m0);
    _394 = uint(26);
    _458 = _394;
    _11._m0[_458] = floatBitsToUint(_388._m1);
    _396 = uint(27);
    _460 = _396;
    _11._m0[_460] = floatBitsToUint(_388._m2);
    float _740 = -2.0;
    _398 = uint(28);
    _462 = _398;
    _11._m0[_462] = floatBitsToUint(_240(_740, 3.0));
    float _747 = -3.0;
    float _748 = -4.0;
    _400 = _16(vec2(_747, _748));
    float _751 = -1.0;
    float _752 = -2.0;
    float _753 = -3.0;
    float _754 = -4.0;
    _402 = _92(vec4(_751, _752, _753, _754));
    _404 = uint(29);
    _464 = _404;
    _11._m0[_464] = floatBitsToUint(((_400.x + _400.y) + _402.x) + _402.w);
}

