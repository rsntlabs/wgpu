#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    float _m0;
    float _m1;
    float _m2;
};

layout(set = 0, binding = 0, std430) buffer _14_13
{
    uint _m0[];
} _13;

float _143(float _142)
{
    uint _145 = 0u;
    uint _149 = floatBitsToUint(_142) & 2147483647u;
    _145 = (_149 > 2139095040u) ? 2143289344u : _149;
    return uintBitsToFloat(_145);
}

float _156(int _155)
{
    uint _158 = 0u;
    uint _163 = floatBitsToUint(float(_155)) & 2147483647u;
    _158 = (_163 > 2139095040u) ? 2143289344u : _163;
    return uintBitsToFloat(_158);
}

float _170(uint _169)
{
    uint _172 = 0u;
    uint _177 = floatBitsToUint(float(_169)) & 2147483647u;
    _172 = (_177 > 2139095040u) ? 2143289344u : _177;
    return uintBitsToFloat(_172);
}

float _184(bool _183)
{
    uint _186 = 0u;
    uint _193 = floatBitsToUint(float(_183)) & 2147483647u;
    _186 = (_193 > 2139095040u) ? 2143289344u : _193;
    return uintBitsToFloat(_186);
}

int _200(int _199)
{
    return _199 + 40;
}

uint _207(uint _206)
{
    return _206 + 50u;
}

int _214(bool _213)
{
    int _218 = 0;
    if (_213)
    {
        _218 = 7;
    }
    else
    {
        _218 = 9;
    }
    return _218;
}

int _228(bool _227)
{
    int _231 = 0;
    if (_227)
    {
        _231 = 11;
    }
    else
    {
        _231 = 13;
    }
    return _231;
}

_6 _54(_6 _53)
{
    uint _59 = 0u;
    uint _63 = 0u;
    _6 _56 = _6(0.0, 0.0, 0.0);
    uint _61 = 0u;
    _56 = _53;
    uint _69 = floatBitsToUint(_56._m0) & 2147483647u;
    _59 = (_69 > 2139095040u) ? 2143289344u : _69;
    uint _77 = floatBitsToUint(_56._m1) & 2147483647u;
    _61 = (_77 > 2139095040u) ? 2143289344u : _77;
    uint _85 = floatBitsToUint(_56._m2) & 2147483647u;
    _63 = (_85 > 2139095040u) ? 2143289344u : _85;
    return _6(uintBitsToFloat(_59), uintBitsToFloat(_61), uintBitsToFloat(_63));
}

float _241(float _239, float _240)
{
    return _239 + _240;
}

vec2 _18(vec2 _17)
{
    vec2 _23 = vec2(0.0);
    uint _26 = 0u;
    uint _29 = 0u;
    _23 = _17;
    uint _37 = floatBitsToUint(_23.x) & 2147483647u;
    _26 = (_37 > 2139095040u) ? 2143289344u : _37;
    uint _46 = floatBitsToUint(_23.y) & 2147483647u;
    _29 = (_46 > 2139095040u) ? 2143289344u : _46;
    return vec2(uintBitsToFloat(_26), uintBitsToFloat(_29));
}

vec4 _93(vec4 _92)
{
    uint _104 = 0u;
    uint _98 = 0u;
    uint _102 = 0u;
    vec4 _95 = vec4(0.0);
    uint _100 = 0u;
    _95 = _92;
    uint _110 = floatBitsToUint(_95.x) & 2147483647u;
    _98 = (_110 > 2139095040u) ? 2143289344u : _110;
    uint _118 = floatBitsToUint(_95.y) & 2147483647u;
    _100 = (_118 > 2139095040u) ? 2143289344u : _118;
    uint _126 = floatBitsToUint(_95.z) & 2147483647u;
    _102 = (_126 > 2139095040u) ? 2143289344u : _126;
    uint _135 = floatBitsToUint(_95.w) & 2147483647u;
    _104 = (_135 > 2139095040u) ? 2143289344u : _135;
    return vec4(uintBitsToFloat(_98), uintBitsToFloat(_100), uintBitsToFloat(_102), uintBitsToFloat(_104));
}

void main()
{
    uint _537[2] = uint[](0u, 0u);
    uint _403[2] = uint[](0u, 0u);
    uint _647 = 0u;
    uint _513[2] = uint[](0u, 0u);
    uint _379[2] = uint[](0u, 0u);
    uint _623 = 0u;
    uint _489[2] = uint[](0u, 0u);
    uint _355 = 0u;
    uint _599 = 0u;
    vec4 _465 = vec4(0.0);
    uint _331[2] = uint[](0u, 0u);
    uint _575 = 0u;
    uint _441 = 0u;
    uint _307 = 0u;
    uint _551 = 0u;
    uint _417 = 0u;
    uint _527 = 0u;
    uint _393 = 0u;
    uint _637 = 0u;
    uint _503 = 0u;
    uint _369 = 0u;
    uint _613 = 0u;
    uint _479 = 0u;
    uint _345 = 0u;
    uint _589 = 0u;
    uint _455[2] = uint[](0u, 0u);
    uint _321 = 0u;
    uint _565 = 0u;
    uint _431[2] = uint[](0u, 0u);
    uint _297[2] = uint[](0u, 0u);
    uint _541 = 0u;
    uint _407 = 0u;
    uint _517 = 0u;
    uint _383 = 0u;
    uint _627[2] = uint[](0u, 0u);
    uint _493 = 0u;
    uint _359[2] = uint[](0u, 0u);
    uint _603[2] = uint[](0u, 0u);
    uint _469 = 0u;
    uint _335[2] = uint[](0u, 0u);
    uint _579[2] = uint[](0u, 0u);
    uint _445 = 0u;
    uint _311 = 0u;
    uint _555[2] = uint[](0u, 0u);
    uint _421 = 0u;
    uint _531[2] = uint[](0u, 0u);
    uint _397 = 0u;
    uint _641 = 0u;
    uint _507[2] = uint[](0u, 0u);
    uint _373[2] = uint[](0u, 0u);
    uint _617 = 0u;
    uint _483[2] = uint[](0u, 0u);
    uint _349 = 0u;
    uint _593 = 0u;
    uint _459[2] = uint[](0u, 0u);
    uint _325 = 0u;
    uint _569 = 0u;
    uint _435[2] = uint[](0u, 0u);
    uint _301 = 0u;
    uint _545 = 0u;
    float _411 = 0.0;
    uint _521 = 0u;
    uint _387[2] = uint[](0u, 0u);
    uint _631 = 0u;
    uint _497 = 0u;
    uint _363 = 0u;
    uint _607 = 0u;
    uint _473 = 0u;
    uint _339 = 0u;
    uint _583 = 0u;
    uint _449 = 0u;
    uint _315[2] = uint[](0u, 0u);
    uint _559 = 0u;
    uint _425 = 0u;
    uint _535 = 0u;
    uint _401 = 0u;
    uint _645[2] = uint[](0u, 0u);
    uint _511 = 0u;
    uint _377 = 0u;
    uint _621[2] = uint[](0u, 0u);
    uint _487 = 0u;
    uint _353 = 0u;
    uint _597[2] = uint[](0u, 0u);
    vec2 _463 = vec2(0.0);
    uint _329 = 0u;
    uint _573[2] = uint[](0u, 0u);
    uint _439[2] = uint[](0u, 0u);
    uint _305 = 0u;
    uint _549[2] = uint[](0u, 0u);
    uint _415 = 0u;
    uint _525[2] = uint[](0u, 0u);
    uint _391 = 0u;
    uint _635 = 0u;
    uint _501[2] = uint[](0u, 0u);
    uint _367[2] = uint[](0u, 0u);
    uint _611 = 0u;
    uint _477[2] = uint[](0u, 0u);
    uint _343[2] = uint[](0u, 0u);
    uint _587 = 0u;
    uint _453 = 0u;
    uint _319[2] = uint[](0u, 0u);
    uint _563 = 0u;
    uint _429 = 0u;
    uint _294[2] = uint[](0u, 0u);
    uint _539 = 0u;
    uint _405 = 0u;
    uint _649 = 0u;
    uint _515 = 0u;
    uint _381 = 0u;
    uint _625 = 0u;
    uint _491 = 0u;
    uint _357 = 0u;
    uint _601 = 0u;
    uint _467[2] = uint[](0u, 0u);
    uint _333 = 0u;
    uint _577 = 0u;
    _6 _443 = _6(0.0, 0.0, 0.0);
    uint _309[2] = uint[](0u, 0u);
    uint _553 = 0u;
    uint _419[2] = uint[](0u, 0u);
    uint _529 = 0u;
    uint _395[2] = uint[](0u, 0u);
    uint _639[2] = uint[](0u, 0u);
    uint _505 = 0u;
    uint _371 = 0u;
    uint _615[2] = uint[](0u, 0u);
    uint _481 = 0u;
    uint _347 = 0u;
    uint _591[2] = uint[](0u, 0u);
    uint _457 = 0u;
    uint _323[2] = uint[](0u, 0u);
    uint _567[2] = uint[](0u, 0u);
    uint _433 = 0u;
    uint _299 = 0u;
    uint _543[2] = uint[](0u, 0u);
    uint _409 = 0u;
    uint _519[2] = uint[](0u, 0u);
    uint _385 = 0u;
    uint _629 = 0u;
    uint _495[2] = uint[](0u, 0u);
    uint _361 = 0u;
    uint _605 = 0u;
    uint _471[2] = uint[](0u, 0u);
    uint _337 = 0u;
    uint _581 = 0u;
    uint _447[2] = uint[](0u, 0u);
    uint _313 = 0u;
    uint _557 = 0u;
    uint _423[2] = uint[](0u, 0u);
    uint _533 = 0u;
    uint _399 = 0u;
    uint _643 = 0u;
    uint _509 = 0u;
    uint _375 = 0u;
    uint _619 = 0u;
    uint _485 = 0u;
    uint _351[2] = uint[](0u, 0u);
    uint _595 = 0u;
    uint _461 = 0u;
    uint _327[2] = uint[](0u, 0u);
    uint _571 = 0u;
    uint _437 = 0u;
    uint _303[2] = uint[](0u, 0u);
    uint _547 = 0u;
    uint _413[2] = uint[](0u, 0u);
    uint _523 = 0u;
    uint _389 = 0u;
    uint _633[2] = uint[](0u, 0u);
    uint _499 = 0u;
    uint _365 = 0u;
    uint _609[2] = uint[](0u, 0u);
    uint _475 = 0u;
    uint _341 = 0u;
    uint _585[2] = uint[](0u, 0u);
    uint _451[2] = uint[](0u, 0u);
    uint _317 = 0u;
    uint _561[2] = uint[](0u, 0u);
    uint _427[2] = uint[](0u, 0u);
    _294 = uint[](0u, 0u);
    _294[0u] = 0u;
    _294[1u] = 0u;
    uint _655 = floatBitsToUint(0.0) & 2147483647u;
    _301 = (_655 > 2139095040u) ? 2143289344u : _655;
    _297 = _294;
    _299 = uint(0);
    _471 = _297;
    _471[1u] += _299;
    _473 = _471[0u];
    _475 = _471[1u];
    _13._m0[_475] = floatBitsToUint(uintBitsToFloat(_301));
    float _676 = -0.0;
    uint _678 = floatBitsToUint(_676) & 2147483647u;
    _307 = (_678 > 2139095040u) ? 2143289344u : _678;
    _303 = _294;
    _305 = uint(1);
    _477 = _303;
    _477[1u] += _305;
    _479 = _477[0u];
    _481 = _477[1u];
    _13._m0[_481] = floatBitsToUint(uintBitsToFloat(_307));
    float _698 = -1.75;
    uint _700 = floatBitsToUint(_698) & 2147483647u;
    _313 = (_700 > 2139095040u) ? 2143289344u : _700;
    _309 = _294;
    _311 = uint(2);
    _483 = _309;
    _483[1u] += _311;
    _485 = _483[0u];
    _487 = _483[1u];
    _13._m0[_487] = floatBitsToUint(uintBitsToFloat(_313));
    float _720 = -1.25;
    _315 = _294;
    _317 = uint(3);
    _489 = _315;
    _489[1u] += _317;
    _491 = _489[0u];
    _493 = _489[1u];
    _13._m0[_493] = floatBitsToUint(_143(_720));
    int _737 = -3;
    _319 = _294;
    _321 = uint(4);
    _495 = _319;
    _495[1u] += _321;
    _497 = _495[0u];
    _499 = _495[1u];
    _13._m0[_499] = floatBitsToUint(_156(_737));
    _323 = _294;
    _325 = uint(5);
    _501 = _323;
    _501[1u] += _325;
    _503 = _501[0u];
    _505 = _501[1u];
    _13._m0[_505] = floatBitsToUint(_170(4294967295u));
    _327 = _294;
    _329 = uint(6);
    _507 = _327;
    _507[1u] += _329;
    _509 = _507[0u];
    _511 = _507[1u];
    _13._m0[_511] = floatBitsToUint(_184(true));
    _331 = _294;
    _333 = uint(7);
    _513 = _331;
    _513[1u] += _333;
    _515 = _513[0u];
    _517 = _513[1u];
    _13._m0[_517] = floatBitsToUint(_184(false));
    _339 = 1u;
    uint _805 = floatBitsToUint(uintBitsToFloat(_339)) & 2147483647u;
    _341 = (_805 > 2139095040u) ? 2143289344u : _805;
    _335 = _294;
    _337 = uint(8);
    _519 = _335;
    _519[1u] += _337;
    _521 = _519[0u];
    _523 = _519[1u];
    _13._m0[_523] = floatBitsToUint(uintBitsToFloat(_341));
    _347 = 2147483649u;
    uint _828 = floatBitsToUint(uintBitsToFloat(_347)) & 2147483647u;
    _349 = (_828 > 2139095040u) ? 2143289344u : _828;
    _343 = _294;
    _345 = uint(9);
    _525 = _343;
    _525[1u] += _345;
    _527 = _525[0u];
    _529 = _525[1u];
    _13._m0[_529] = floatBitsToUint(uintBitsToFloat(_349));
    _355 = 8388607u;
    uint _851 = floatBitsToUint(uintBitsToFloat(_355)) & 2147483647u;
    _357 = (_851 > 2139095040u) ? 2143289344u : _851;
    _351 = _294;
    _353 = uint(10);
    _531 = _351;
    _531[1u] += _353;
    _533 = _531[0u];
    _535 = _531[1u];
    _13._m0[_535] = floatBitsToUint(uintBitsToFloat(_357));
    _363 = 2155872255u;
    uint _874 = floatBitsToUint(uintBitsToFloat(_363)) & 2147483647u;
    _365 = (_874 > 2139095040u) ? 2143289344u : _874;
    _359 = _294;
    _361 = uint(11);
    _537 = _359;
    _537[1u] += _361;
    _539 = _537[0u];
    _541 = _537[1u];
    _13._m0[_541] = floatBitsToUint(uintBitsToFloat(_365));
    uint _895 = floatBitsToUint(3.4028234663852885981170418348452e+38) & 2147483647u;
    _371 = (_895 > 2139095040u) ? 2143289344u : _895;
    _367 = _294;
    _369 = uint(12);
    _543 = _367;
    _543[1u] += _369;
    _545 = _543[0u];
    _547 = _543[1u];
    _13._m0[_547] = floatBitsToUint(uintBitsToFloat(_371));
    float _915 = -3.4028234663852885981170418348452e+38;
    uint _917 = floatBitsToUint(_915) & 2147483647u;
    _377 = (_917 > 2139095040u) ? 2143289344u : _917;
    _373 = _294;
    _375 = uint(13);
    _549 = _373;
    _549[1u] += _375;
    _551 = _549[0u];
    _553 = _549[1u];
    _13._m0[_553] = floatBitsToUint(uintBitsToFloat(_377));
    _383 = 2139095040u;
    uint _940 = floatBitsToUint(uintBitsToFloat(_383)) & 2147483647u;
    _385 = (_940 > 2139095040u) ? 2143289344u : _940;
    _379 = _294;
    _381 = uint(14);
    _555 = _379;
    _555[1u] += _381;
    _557 = _555[0u];
    _559 = _555[1u];
    _13._m0[_559] = floatBitsToUint(uintBitsToFloat(_385));
    _391 = 4286578688u;
    uint _963 = floatBitsToUint(uintBitsToFloat(_391)) & 2147483647u;
    _393 = (_963 > 2139095040u) ? 2143289344u : _963;
    _387 = _294;
    _389 = uint(15);
    _561 = _387;
    _561[1u] += _389;
    _563 = _561[0u];
    _565 = _561[1u];
    _13._m0[_565] = floatBitsToUint(uintBitsToFloat(_393));
    _399 = 2143363909u;
    uint _986 = floatBitsToUint(uintBitsToFloat(_399)) & 2147483647u;
    _401 = (_986 > 2139095040u) ? 2143289344u : _986;
    _395 = _294;
    _397 = uint(16);
    _567 = _395;
    _567[1u] += _397;
    _569 = _567[0u];
    _571 = _567[1u];
    _13._m0[_571] = floatBitsToUint(uintBitsToFloat(_401));
    _407 = 2139095041u;
    uint _1009 = floatBitsToUint(uintBitsToFloat(_407)) & 2147483647u;
    _409 = (_1009 > 2139095040u) ? 2143289344u : _1009;
    _403 = _294;
    _405 = uint(17);
    _573 = _403;
    _573[1u] += _405;
    _575 = _573[0u];
    _577 = _573[1u];
    _13._m0[_577] = floatBitsToUint(uintBitsToFloat(_409));
    float _1029 = -2.75;
    _411 = _1029;
    float _1030 = _411;
    float _1031 = float(1);
    _411 = _1030 + _1031;
    uint _1034 = floatBitsToUint(_1030) & 2147483647u;
    _417 = (_1034 > 2139095040u) ? 2143289344u : _1034;
    _413 = _294;
    _415 = uint(18);
    _579 = _413;
    _579[1u] += _415;
    _581 = _579[0u];
    _583 = _579[1u];
    _13._m0[_583] = floatBitsToUint(uintBitsToFloat(_417));
    _419 = _294;
    _421 = uint(19);
    _585 = _419;
    _585[1u] += _421;
    _587 = _585[0u];
    _589 = _585[1u];
    _13._m0[_589] = floatBitsToUint(_411);
    int _1070 = -3;
    _423 = _294;
    _425 = uint(20);
    _591 = _423;
    _591[1u] += _425;
    _593 = _591[0u];
    _595 = _591[1u];
    _13._m0[_595] = uint(_200(_1070));
    _427 = _294;
    _429 = uint(21);
    _597 = _427;
    _597[1u] += _429;
    _599 = _597[0u];
    _601 = _597[1u];
    _13._m0[_601] = _207(3u);
    _431 = _294;
    _433 = uint(22);
    _603 = _431;
    _603[1u] += _433;
    _605 = _603[0u];
    _607 = _603[1u];
    _13._m0[_607] = uint(_214(true));
    _435 = _294;
    _437 = uint(23);
    _609 = _435;
    _609[1u] += _437;
    _611 = _609[0u];
    _613 = _609[1u];
    _13._m0[_613] = uint(_214(false));
    _439 = _294;
    _441 = uint(24);
    _615 = _439;
    _615[1u] += _441;
    _617 = _615[0u];
    _619 = _615[1u];
    _13._m0[_619] = uint(_228(true));
    float _1150 = -2.5;
    float _1151 = -0.0;
    _445 = 2147483649u;
    _443 = _54(_6(_1150, _1151, uintBitsToFloat(_445)));
    _447 = _294;
    _449 = uint(25);
    _621 = _447;
    _621[1u] += _449;
    _623 = _621[0u];
    _625 = _621[1u];
    _13._m0[_625] = floatBitsToUint(_443._m0);
    _451 = _294;
    _453 = uint(26);
    _627 = _451;
    _627[1u] += _453;
    _629 = _627[0u];
    _631 = _627[1u];
    _13._m0[_631] = floatBitsToUint(_443._m1);
    _455 = _294;
    _457 = uint(27);
    _633 = _455;
    _633[1u] += _457;
    _635 = _633[0u];
    _637 = _633[1u];
    _13._m0[_637] = floatBitsToUint(_443._m2);
    float _1207 = -2.0;
    _459 = _294;
    _461 = uint(28);
    _639 = _459;
    _639[1u] += _461;
    _641 = _639[0u];
    _643 = _639[1u];
    _13._m0[_643] = floatBitsToUint(_241(_1207, 3.0));
    float _1224 = -3.0;
    float _1225 = -4.0;
    _463 = _18(vec2(_1224, _1225));
    float _1228 = -1.0;
    float _1229 = -2.0;
    float _1230 = -3.0;
    float _1231 = -4.0;
    _465 = _93(vec4(_1228, _1229, _1230, _1231));
    _467 = _294;
    _469 = uint(29);
    _645 = _467;
    _645[1u] += _469;
    _647 = _645[0u];
    _649 = _645[1u];
    _13._m0[_649] = floatBitsToUint(((_463.x + _463.y) + _465.x) + _465.w);
}

