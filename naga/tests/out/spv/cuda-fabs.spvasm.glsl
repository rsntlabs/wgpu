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
    float _144 = 0.0;
    uint _146 = 0u;
    _144 = _141;
    uint _151 = floatBitsToUint(_144) & 2147483647u;
    _146 = (_151 > 2139095040u) ? 2143289344u : _151;
    return uintBitsToFloat(_146);
}

float _158(int _157)
{
    int _160 = 0;
    uint _163 = 0u;
    _160 = _157;
    uint _169 = floatBitsToUint(float(_160)) & 2147483647u;
    _163 = (_169 > 2139095040u) ? 2143289344u : _169;
    return uintBitsToFloat(_163);
}

float _176(uint _175)
{
    uint _178 = 0u;
    uint _180 = 0u;
    _178 = _175;
    uint _186 = floatBitsToUint(float(_178)) & 2147483647u;
    _180 = (_186 > 2139095040u) ? 2143289344u : _186;
    return uintBitsToFloat(_180);
}

float _193(bool _192)
{
    bool _195 = false;
    uint _198 = 0u;
    _195 = _192;
    uint _206 = floatBitsToUint(float(_195)) & 2147483647u;
    _198 = (_206 > 2139095040u) ? 2143289344u : _206;
    return uintBitsToFloat(_198);
}

int _213(int _212)
{
    int _216 = 0;
    _216 = _212;
    return _216 + 40;
}

uint _223(uint _222)
{
    uint _226 = 0u;
    _226 = _222;
    return _226 + 50u;
}

int _233(bool _232)
{
    bool _237 = false;
    int _239 = 0;
    _237 = _232;
    if (_237)
    {
        _239 = 7;
    }
    else
    {
        _239 = 9;
    }
    return _239;
}

int _249(bool _248)
{
    bool _252 = false;
    int _254 = 0;
    _252 = _248;
    if (_252)
    {
        _254 = 11;
    }
    else
    {
        _254 = 13;
    }
    return _254;
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

float _265(float _263, float _264)
{
    float _267 = 0.0;
    float _269 = 0.0;
    _267 = _263;
    _269 = _264;
    return _267 + _269;
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
    uint _565 = 0u;
    uint _431 = 0u;
    uint _541 = 0u;
    uint _407 = 0u;
    uint _517 = 0u;
    uint _383 = 0u;
    uint _493 = 0u;
    uint _359 = 0u;
    uint _603 = 0u;
    uint _469 = 0u;
    uint _335 = 0u;
    uint _579 = 0u;
    uint _445 = 0u;
    uint _555 = 0u;
    uint _421 = 0u;
    uint _531 = 0u;
    uint _397 = 0u;
    uint _507 = 0u;
    uint _373 = 0u;
    uint _617 = 0u;
    uint _483 = 0u;
    uint _349 = 0u;
    uint _593 = 0u;
    uint _459 = 0u;
    uint _325 = 0u;
    uint _569 = 0u;
    uint _435 = 0u;
    uint _545 = 0u;
    uint _411 = 0u;
    _6 _521 = _6(0.0, 0.0, 0.0);
    uint _387 = 0u;
    uint _497 = 0u;
    uint _363 = 0u;
    uint _607 = 0u;
    uint _473 = 0u;
    uint _339 = 0u;
    uint _583 = 0u;
    uint _449 = 0u;
    uint _559 = 0u;
    uint _425 = 0u;
    uint _535 = 0u;
    uint _401 = 0u;
    uint _511 = 0u;
    uint _377 = 0u;
    uint _487 = 0u;
    uint _353 = 0u;
    uint _597 = 0u;
    uint _463 = 0u;
    uint _329 = 0u;
    uint _573 = 0u;
    uint _439 = 0u;
    vec2 _549 = vec2(0.0);
    uint _415 = 0u;
    uint _525 = 0u;
    uint _391 = 0u;
    uint _501 = 0u;
    uint _367 = 0u;
    uint _611 = 0u;
    uint _477 = 0u;
    uint _343 = 0u;
    uint _587 = 0u;
    uint _453 = 0u;
    uint _563 = 0u;
    uint _429 = 0u;
    uint _539 = 0u;
    uint _405 = 0u;
    uint _515 = 0u;
    uint _381 = 0u;
    uint _491 = 0u;
    uint _357 = 0u;
    uint _601 = 0u;
    uint _467 = 0u;
    uint _333 = 0u;
    uint _577 = 0u;
    uint _443 = 0u;
    uint _553 = 0u;
    uint _419 = 0u;
    uint _529 = 0u;
    uint _395 = 0u;
    uint _505 = 0u;
    uint _371 = 0u;
    uint _615 = 0u;
    uint _481 = 0u;
    uint _347 = 0u;
    uint _591 = 0u;
    uint _457 = 0u;
    uint _323 = 0u;
    uint _567 = 0u;
    uint _433 = 0u;
    uint _543 = 0u;
    uint _409 = 0u;
    uint _519 = 0u;
    uint _385 = 0u;
    uint _495 = 0u;
    uint _361 = 0u;
    uint _605 = 0u;
    uint _471 = 0u;
    uint _337 = 0u;
    uint _581 = 0u;
    uint _447 = 0u;
    uint _557 = 0u;
    uint _423 = 0u;
    uint _533 = 0u;
    uint _399 = 0u;
    uint _509 = 0u;
    uint _375 = 0u;
    uint _485 = 0u;
    uint _351 = 0u;
    uint _595 = 0u;
    uint _461 = 0u;
    uint _327 = 0u;
    uint _571 = 0u;
    uint _437 = 0u;
    uint _547 = 0u;
    uint _413 = 0u;
    uint _523 = 0u;
    uint _389 = 0u;
    uint _499 = 0u;
    uint _365 = 0u;
    uint _609 = 0u;
    float _475 = 0.0;
    uint _341 = 0u;
    uint _585 = 0u;
    uint _451 = 0u;
    uint _561 = 0u;
    uint _427 = 0u;
    uint _537 = 0u;
    uint _403 = 0u;
    uint _513 = 0u;
    uint _379 = 0u;
    uint _489 = 0u;
    uint _355 = 0u;
    uint _599 = 0u;
    uint _465 = 0u;
    uint _331 = 0u;
    uint _575 = 0u;
    uint _441 = 0u;
    vec4 _551 = vec4(0.0);
    uint _417 = 0u;
    uint _527 = 0u;
    uint _393 = 0u;
    uint _503 = 0u;
    uint _369 = 0u;
    uint _613 = 0u;
    uint _479 = 0u;
    uint _345 = 0u;
    uint _589 = 0u;
    uint _455 = 0u;
    _323 = 0u;
    uint _621 = floatBitsToUint(0.0) & 2147483647u;
    _331 = (_621 > 2139095040u) ? 2143289344u : _621;
    _325 = _323;
    _327 = _325;
    _329 = uint(0);
    _559 = _327 + _329;
    _11._m0[_559] = floatBitsToUint(uintBitsToFloat(_331));
    float _636 = -0.0;
    uint _638 = floatBitsToUint(_636) & 2147483647u;
    _339 = (_638 > 2139095040u) ? 2143289344u : _638;
    _333 = _323;
    _335 = _333;
    _337 = uint(1);
    _561 = _335 + _337;
    _11._m0[_561] = floatBitsToUint(uintBitsToFloat(_339));
    float _652 = -1.75;
    uint _654 = floatBitsToUint(_652) & 2147483647u;
    _347 = (_654 > 2139095040u) ? 2143289344u : _654;
    _341 = _323;
    _343 = _341;
    _345 = uint(2);
    _563 = _343 + _345;
    _11._m0[_563] = floatBitsToUint(uintBitsToFloat(_347));
    float _668 = -1.25;
    _349 = _323;
    _351 = _349;
    _353 = uint(3);
    _565 = _351 + _353;
    _11._m0[_565] = floatBitsToUint(_142(_668));
    int _679 = -3;
    _355 = _323;
    _357 = _355;
    _359 = uint(4);
    _567 = _357 + _359;
    _11._m0[_567] = floatBitsToUint(_158(_679));
    _361 = _323;
    _363 = _361;
    _365 = uint(5);
    _569 = _363 + _365;
    _11._m0[_569] = floatBitsToUint(_176(4294967295u));
    _367 = _323;
    _369 = _367;
    _371 = uint(6);
    _571 = _369 + _371;
    _11._m0[_571] = floatBitsToUint(_193(true));
    _373 = _323;
    _375 = _373;
    _377 = uint(7);
    _573 = _375 + _377;
    _11._m0[_573] = floatBitsToUint(_193(false));
    _385 = 1u;
    uint _723 = floatBitsToUint(uintBitsToFloat(_385)) & 2147483647u;
    _387 = (_723 > 2139095040u) ? 2143289344u : _723;
    _379 = _323;
    _381 = _379;
    _383 = uint(8);
    _575 = _381 + _383;
    _11._m0[_575] = floatBitsToUint(uintBitsToFloat(_387));
    _395 = 2147483649u;
    uint _740 = floatBitsToUint(uintBitsToFloat(_395)) & 2147483647u;
    _397 = (_740 > 2139095040u) ? 2143289344u : _740;
    _389 = _323;
    _391 = _389;
    _393 = uint(9);
    _577 = _391 + _393;
    _11._m0[_577] = floatBitsToUint(uintBitsToFloat(_397));
    _405 = 8388607u;
    uint _757 = floatBitsToUint(uintBitsToFloat(_405)) & 2147483647u;
    _407 = (_757 > 2139095040u) ? 2143289344u : _757;
    _399 = _323;
    _401 = _399;
    _403 = uint(10);
    _579 = _401 + _403;
    _11._m0[_579] = floatBitsToUint(uintBitsToFloat(_407));
    _415 = 2155872255u;
    uint _774 = floatBitsToUint(uintBitsToFloat(_415)) & 2147483647u;
    _417 = (_774 > 2139095040u) ? 2143289344u : _774;
    _409 = _323;
    _411 = _409;
    _413 = uint(11);
    _581 = _411 + _413;
    _11._m0[_581] = floatBitsToUint(uintBitsToFloat(_417));
    uint _789 = floatBitsToUint(3.4028234663852885981170418348452e+38) & 2147483647u;
    _425 = (_789 > 2139095040u) ? 2143289344u : _789;
    _419 = _323;
    _421 = _419;
    _423 = uint(12);
    _583 = _421 + _423;
    _11._m0[_583] = floatBitsToUint(uintBitsToFloat(_425));
    float _803 = -3.4028234663852885981170418348452e+38;
    uint _805 = floatBitsToUint(_803) & 2147483647u;
    _433 = (_805 > 2139095040u) ? 2143289344u : _805;
    _427 = _323;
    _429 = _427;
    _431 = uint(13);
    _585 = _429 + _431;
    _11._m0[_585] = floatBitsToUint(uintBitsToFloat(_433));
    _441 = 2139095040u;
    uint _822 = floatBitsToUint(uintBitsToFloat(_441)) & 2147483647u;
    _443 = (_822 > 2139095040u) ? 2143289344u : _822;
    _435 = _323;
    _437 = _435;
    _439 = uint(14);
    _587 = _437 + _439;
    _11._m0[_587] = floatBitsToUint(uintBitsToFloat(_443));
    _451 = 4286578688u;
    uint _839 = floatBitsToUint(uintBitsToFloat(_451)) & 2147483647u;
    _453 = (_839 > 2139095040u) ? 2143289344u : _839;
    _445 = _323;
    _447 = _445;
    _449 = uint(15);
    _589 = _447 + _449;
    _11._m0[_589] = floatBitsToUint(uintBitsToFloat(_453));
    _461 = 2143363909u;
    uint _856 = floatBitsToUint(uintBitsToFloat(_461)) & 2147483647u;
    _463 = (_856 > 2139095040u) ? 2143289344u : _856;
    _455 = _323;
    _457 = _455;
    _459 = uint(16);
    _591 = _457 + _459;
    _11._m0[_591] = floatBitsToUint(uintBitsToFloat(_463));
    _471 = 2139095041u;
    uint _873 = floatBitsToUint(uintBitsToFloat(_471)) & 2147483647u;
    _473 = (_873 > 2139095040u) ? 2143289344u : _873;
    _465 = _323;
    _467 = _465;
    _469 = uint(17);
    _593 = _467 + _469;
    _11._m0[_593] = floatBitsToUint(uintBitsToFloat(_473));
    float _887 = -2.75;
    _475 = _887;
    float _888 = _475;
    float _889 = float(1);
    _475 = _888 + _889;
    uint _892 = floatBitsToUint(_888) & 2147483647u;
    _483 = (_892 > 2139095040u) ? 2143289344u : _892;
    _477 = _323;
    _479 = _477;
    _481 = uint(18);
    _595 = _479 + _481;
    _11._m0[_595] = floatBitsToUint(uintBitsToFloat(_483));
    _485 = _323;
    _487 = _485;
    _489 = uint(19);
    _597 = _487 + _489;
    _11._m0[_597] = floatBitsToUint(_475);
    int _916 = -3;
    _491 = _323;
    _493 = _491;
    _495 = uint(20);
    _599 = _493 + _495;
    _11._m0[_599] = uint(_213(_916));
    _497 = _323;
    _499 = _497;
    _501 = uint(21);
    _601 = _499 + _501;
    _11._m0[_601] = _223(3u);
    _503 = _323;
    _505 = _503;
    _507 = uint(22);
    _603 = _505 + _507;
    _11._m0[_603] = uint(_233(true));
    _509 = _323;
    _511 = _509;
    _513 = uint(23);
    _605 = _511 + _513;
    _11._m0[_605] = uint(_233(false));
    _515 = _323;
    _517 = _515;
    _519 = uint(24);
    _607 = _517 + _519;
    _11._m0[_607] = uint(_249(true));
    float _966 = -2.5;
    float _967 = -0.0;
    _523 = 2147483649u;
    _521 = _52(_6(_966, _967, uintBitsToFloat(_523)));
    _525 = _323;
    _527 = _525;
    _529 = uint(25);
    _609 = _527 + _529;
    _11._m0[_609] = floatBitsToUint(_521._m0);
    _531 = _323;
    _533 = _531;
    _535 = uint(26);
    _611 = _533 + _535;
    _11._m0[_611] = floatBitsToUint(_521._m1);
    _537 = _323;
    _539 = _537;
    _541 = uint(27);
    _613 = _539 + _541;
    _11._m0[_613] = floatBitsToUint(_521._m2);
    float _1005 = -2.0;
    _543 = _323;
    _545 = _543;
    _547 = uint(28);
    _615 = _545 + _547;
    _11._m0[_615] = floatBitsToUint(_265(_1005, 3.0));
    float _1016 = -3.0;
    float _1017 = -4.0;
    _549 = _16(vec2(_1016, _1017));
    float _1020 = -1.0;
    float _1021 = -2.0;
    float _1022 = -3.0;
    float _1023 = -4.0;
    _551 = _92(vec4(_1020, _1021, _1022, _1023));
    _553 = _323;
    _555 = _553;
    _557 = uint(29);
    _617 = _555 + _557;
    _11._m0[_617] = floatBitsToUint(((_549.x + _549.y) + _551.x) + _551.w);
}

