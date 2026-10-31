#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _12_11
{
    uint _m0[];
} _11;

int _17(float _15, float _16)
{
    float _21 = 0.0;
    float _24 = 0.0;
    _21 = _15;
    _24 = _16;
    uint _37 = min(0u, 32u);
    uint _42 = min(0u, 32u);
    return int(uint(bitfieldExtract(int(clamp(_21, -2147483648.0, 2147483520.0)), int(_37), int(min(24u, (32u - _37))))) * uint(bitfieldExtract(int(clamp(_24, -2147483648.0, 2147483520.0)), int(_42), int(min(24u, (32u - _42))))));
}

uint _51(float _49, float _50)
{
    float _53 = 0.0;
    float _55 = 0.0;
    _53 = _49;
    _55 = _50;
    uint _67 = min(0u, 32u);
    uint _71 = min(0u, 32u);
    return bitfieldExtract(uint(clamp(_53, 0.0, 4294967040.0)), int(_67), int(min(24u, (32u - _67)))) * bitfieldExtract(uint(clamp(_55, 0.0, 4294967040.0)), int(_71), int(min(24u, (32u - _71))));
}

int _78(bool _76, bool _77)
{
    bool _86 = false;
    int _91 = 0;
    bool _83 = false;
    int _88 = 0;
    _83 = _76;
    _86 = _77;
    if (_83)
    {
        if (_86)
        {
            _88 = 71;
        }
        else
        {
            _88 = 73;
        }
        _91 = _88;
    }
    else
    {
        _91 = 79;
    }
    return _91;
}

int _107(float _105, float _106)
{
    float _109 = 0.0;
    float _111 = 0.0;
    _109 = _105;
    _111 = _106;
    return int(clamp((_109 * 10.0) + _111, -2147483648.0, 2147483520.0));
}

uint _123(int _121, int _122)
{
    int _126 = 0;
    int _128 = 0;
    _126 = _121;
    _128 = _122;
    return uint((_126 + _128) + 100);
}

int _139(int _137, int _138)
{
    int _141 = 0;
    int _143 = 0;
    _141 = _137;
    _143 = _138;
    uint _149 = min(0u, 32u);
    uint _154 = min(0u, 32u);
    return int(uint(bitfieldExtract(_141, int(_149), int(min(24u, (32u - _149))))) * uint(bitfieldExtract(_143, int(_154), int(min(24u, (32u - _154))))));
}

void main()
{
    uint _466 = 0u;
    int _331[2] = int[](0, 0);
    uint _442 = 0u;
    uint _307 = 0u;
    uint _552 = 0u;
    uint _418 = 0u;
    uint _283 = 0u;
    uint _528 = 0u;
    uint _394 = 0u;
    uint _259 = 0u;
    uint _504 = 0u;
    uint _370[2] = uint[](0u, 0u);
    uint _235 = 0u;
    uint _480 = 0u;
    uint _346 = 0u;
    uint _456 = 0u;
    uint _321[2] = uint[](0u, 0u);
    uint _432 = 0u;
    uint _297[2] = uint[](0u, 0u);
    uint _542[2] = uint[](0u, 0u);
    uint _408 = 0u;
    uint _273[2] = uint[](0u, 0u);
    uint _518[2] = uint[](0u, 0u);
    uint _384 = 0u;
    uint _249[2] = uint[](0u, 0u);
    uint _494[2] = uint[](0u, 0u);
    uint _224[2] = uint[](0u, 0u);
    uint _470[2] = uint[](0u, 0u);
    uint _336 = 0u;
    uint _446[2] = uint[](0u, 0u);
    uint _311 = 0u;
    uint _556 = 0u;
    uint _422[2] = uint[](0u, 0u);
    uint _287 = 0u;
    uint _532 = 0u;
    uint _398[2] = uint[](0u, 0u);
    uint _263 = 0u;
    uint _508 = 0u;
    uint _374[2] = uint[](0u, 0u);
    uint _239 = 0u;
    uint _484 = 0u;
    uint _350[2] = uint[](0u, 0u);
    uint _460 = 0u;
    uint _325[2] = uint[](0u, 0u);
    uint _436 = 0u;
    uint _301[2] = uint[](0u, 0u);
    uint _546 = 0u;
    uint _412 = 0u;
    uint _277[2] = uint[](0u, 0u);
    uint _522 = 0u;
    uint _388 = 0u;
    uint _253[2] = uint[](0u, 0u);
    uint _498 = 0u;
    uint _364 = 0u;
    uint _229[2] = uint[](0u, 0u);
    uint _474 = 0u;
    int _340 = 0;
    uint _450 = 0u;
    uint _315 = 0u;
    uint _560[2] = uint[](0u, 0u);
    uint _426 = 0u;
    uint _291 = 0u;
    uint _536[2] = uint[](0u, 0u);
    uint _402 = 0u;
    uint _267 = 0u;
    uint _512[2] = uint[](0u, 0u);
    uint _378 = 0u;
    uint _243 = 0u;
    uint _488[2] = uint[](0u, 0u);
    uint _354[2] = uint[](0u, 0u);
    uint _464[2] = uint[](0u, 0u);
    int _329 = 0;
    uint _440[2] = uint[](0u, 0u);
    int _305 = 0;
    uint _550 = 0u;
    uint _416[2] = uint[](0u, 0u);
    uint _281[2] = uint[](0u, 0u);
    uint _526 = 0u;
    uint _392[2] = uint[](0u, 0u);
    uint _257[2] = uint[](0u, 0u);
    uint _502 = 0u;
    uint _368 = 0u;
    uint _233[2] = uint[](0u, 0u);
    uint _478 = 0u;
    uint _344[2] = uint[](0u, 0u);
    uint _454 = 0u;
    uint _319 = 0u;
    uint _564 = 0u;
    uint _430 = 0u;
    uint _295 = 0u;
    uint _540 = 0u;
    uint _406 = 0u;
    uint _271 = 0u;
    uint _516 = 0u;
    uint _382 = 0u;
    uint _247 = 0u;
    uint _492 = 0u;
    int _358 = 0;
    uint _221[2] = uint[](0u, 0u);
    uint _468 = 0u;
    uint _334[2] = uint[](0u, 0u);
    uint _444 = 0u;
    uint _309[2] = uint[](0u, 0u);
    uint _554[2] = uint[](0u, 0u);
    uint _420 = 0u;
    uint _285[2] = uint[](0u, 0u);
    uint _530[2] = uint[](0u, 0u);
    uint _396 = 0u;
    uint _261[2] = uint[](0u, 0u);
    uint _506[2] = uint[](0u, 0u);
    uint _372 = 0u;
    uint _237[2] = uint[](0u, 0u);
    uint _482[2] = uint[](0u, 0u);
    int _348 = 0;
    uint _458[2] = uint[](0u, 0u);
    uint _323 = 0u;
    uint _434[2] = uint[](0u, 0u);
    uint _299 = 0u;
    uint _544 = 0u;
    uint _410[2] = uint[](0u, 0u);
    uint _275 = 0u;
    uint _520 = 0u;
    uint _386[2] = uint[](0u, 0u);
    uint _251 = 0u;
    uint _496 = 0u;
    uint _362[2] = uint[](0u, 0u);
    uint _226 = 0u;
    uint _472 = 0u;
    int _338 = 0;
    uint _448 = 0u;
    uint _313[2] = uint[](0u, 0u);
    uint _558 = 0u;
    uint _424 = 0u;
    uint _289[2] = uint[](0u, 0u);
    uint _534 = 0u;
    uint _400 = 0u;
    uint _265[2] = uint[](0u, 0u);
    uint _510 = 0u;
    uint _376 = 0u;
    uint _241[2] = uint[](0u, 0u);
    uint _486 = 0u;
    uint _352 = 0u;
    uint _462 = 0u;
    uint _327 = 0u;
    uint _438 = 0u;
    uint _303 = 0u;
    uint _548[2] = uint[](0u, 0u);
    uint _414 = 0u;
    uint _279 = 0u;
    uint _524[2] = uint[](0u, 0u);
    uint _390 = 0u;
    uint _255 = 0u;
    uint _500[2] = uint[](0u, 0u);
    uint _366[2] = uint[](0u, 0u);
    uint _231 = 0u;
    uint _476[2] = uint[](0u, 0u);
    int _342[2] = int[](0, 0);
    uint _452[2] = uint[](0u, 0u);
    uint _317[2] = uint[](0u, 0u);
    uint _562 = 0u;
    uint _428[2] = uint[](0u, 0u);
    uint _293[2] = uint[](0u, 0u);
    uint _538 = 0u;
    uint _404[2] = uint[](0u, 0u);
    uint _269[2] = uint[](0u, 0u);
    uint _514 = 0u;
    uint _380[2] = uint[](0u, 0u);
    uint _245[2] = uint[](0u, 0u);
    uint _490 = 0u;
    uint _356 = 0u;
    uvec2 _1280 = uvec2(4294967295u);
    _221 = uint[](0u, 0u);
    _221[0u] = 0u;
    _221[1u] = 0u;
    uint _571 = min(0u, 32u);
    uint _576 = min(0u, 32u);
    _224 = _221;
    _226 = uint(0);
    _374 = _224;
    _374[1u] += _226;
    _376 = _374[0u];
    _378 = _374[1u];
    _11._m0[_378] = uint(int(uint(bitfieldExtract(8388608, int(_571), int(min(24u, (32u - _571))))) * uint(bitfieldExtract(1, int(_576), int(min(24u, (32u - _576)))))));
    uint _599 = min(0u, 32u);
    uint _603 = min(0u, 32u);
    _229 = _221;
    _231 = uint(1);
    _380 = _229;
    _380[1u] += _231;
    _382 = _380[0u];
    _384 = _380[1u];
    _11._m0[_384] = bitfieldExtract(16777215u, int(_599), int(min(24u, (32u - _599)))) * bitfieldExtract(16777215u, int(_603), int(min(24u, (32u - _603))));
    uint _622 = min(0u, 32u);
    uint _627 = min(0u, 32u);
    _233 = _221;
    _235 = uint(2);
    _386 = _233;
    _386[1u] += _235;
    _388 = _386[0u];
    _390 = _386[1u];
    _11._m0[_390] = uint(int(uint(bitfieldExtract(8388607, int(_622), int(min(24u, (32u - _622))))) * uint(bitfieldExtract(8388607, int(_627), int(min(24u, (32u - _627)))))));
    uint _649 = min(0u, 32u);
    uint _653 = min(0u, 32u);
    _237 = _221;
    _239 = uint(3);
    _392 = _237;
    _392[1u] += _239;
    _394 = _392[0u];
    _396 = _392[1u];
    _11._m0[_396] = bitfieldExtract(16777216u, int(_649), int(min(24u, (32u - _649)))) * bitfieldExtract(13u, int(_653), int(min(24u, (32u - _653))));
    float _671 = -2.75;
    _241 = _221;
    _243 = uint(4);
    _398 = _241;
    _398[1u] += _243;
    _400 = _398[0u];
    _402 = _398[1u];
    _11._m0[_402] = uint(_17(3.75, _671));
    float _688 = -3.75;
    _245 = _221;
    _247 = uint(5);
    _404 = _245;
    _404[1u] += _247;
    _406 = _404[0u];
    _408 = _404[1u];
    _11._m0[_408] = uint(_17(_688, 2.75));
    _249 = _221;
    _251 = uint(6);
    _410 = _249;
    _410[1u] += _251;
    _412 = _410[0u];
    _414 = _410[1u];
    _11._m0[_414] = _51(3.75, 2.75);
    _253 = _221;
    _255 = uint(7);
    _416 = _253;
    _416[1u] += _255;
    _418 = _416[0u];
    _420 = _416[1u];
    _11._m0[_420] = _51(16777215.0, 1.0);
    _257 = _221;
    _259 = uint(8);
    _422 = _257;
    _422[1u] += _259;
    _424 = _422[0u];
    _426 = _422[1u];
    _11._m0[_426] = uint(_78(true, true));
    _261 = _221;
    _263 = uint(9);
    _428 = _261;
    _428[1u] += _263;
    _430 = _428[0u];
    _432 = _428[1u];
    _11._m0[_432] = uint(_78(false, true));
    uint _769 = min(0u, 32u);
    uint _774 = min(0u, 32u);
    _265 = _221;
    _267 = uint(10);
    _434 = _265;
    _434[1u] += _267;
    _436 = _434[0u];
    _438 = _434[1u];
    _11._m0[_438] = uint(int(uint(bitfieldExtract(3, int(_769), int(min(24u, (32u - _769))))) * uint(bitfieldExtract(int(true), int(_774), int(min(24u, (32u - _774)))))));
    uint _797 = min(0u, 32u);
    uint _802 = min(0u, 32u);
    _269 = _221;
    _271 = uint(11);
    _440 = _269;
    _440[1u] += _271;
    _442 = _440[0u];
    _444 = _440[1u];
    _11._m0[_444] = uint(int(uint(bitfieldExtract(int(true), int(_797), int(min(24u, (32u - _797))))) * uint(bitfieldExtract(3, int(_802), int(min(24u, (32u - _802)))))));
    _273 = _221;
    _275 = uint(12);
    _446 = _273;
    _446[1u] += _275;
    _448 = _446[0u];
    _450 = _446[1u];
    _11._m0[_450] = uint(_107(3.75, 2.0));
    _277 = _221;
    _279 = uint(13);
    _452 = _277;
    _452[1u] += _279;
    _454 = _452[0u];
    _456 = _452[1u];
    _11._m0[_456] = _123(3, 4);
    uint _855 = min(0u, 32u);
    uint _859 = min(0u, 32u);
    _281 = _221;
    _283 = uint(14);
    _458 = _281;
    _458[1u] += _283;
    _460 = _458[0u];
    _462 = _458[1u];
    _11._m0[_462] = bitfieldExtract(3u, int(_855), int(min(24u, (32u - _855)))) * bitfieldExtract(4u, int(_859), int(min(24u, (32u - _859))));
    _285 = _221;
    _287 = uint(15);
    _464 = _285;
    _464[1u] += _287;
    _466 = _464[0u];
    _468 = _464[1u];
    _11._m0[_468] = _123(int(true), int(true));
    uint _896 = min(0u, 32u);
    uint _900 = min(0u, 32u);
    _289 = _221;
    _291 = uint(16);
    _470 = _289;
    _470[1u] += _291;
    _472 = _470[0u];
    _474 = _470[1u];
    _11._m0[_474] = bitfieldExtract(3u, int(_896), int(min(24u, (32u - _896)))) * bitfieldExtract(uint(4), int(_900), int(min(24u, (32u - _900))));
    int _918 = -7;
    _293 = _221;
    _295 = uint(17);
    _476 = _293;
    _476[1u] += _295;
    _478 = _476[0u];
    _480 = _476[1u];
    _11._m0[_480] = uint(_139(_918, 3));
    uint _936 = min(0u, 32u);
    uint _941 = min(0u, 32u);
    uint _948 = min(0u, 32u);
    uint _953 = min(0u, 32u);
    _297 = _221;
    _299 = uint(18);
    _482 = _297;
    _482[1u] += _299;
    _484 = _482[0u];
    _486 = _482[1u];
    _11._m0[_486] = uint(int(uint(bitfieldExtract(int(uint(bitfieldExtract(3, int(_936), int(min(24u, (32u - _936))))) * uint(bitfieldExtract(4, int(_941), int(min(24u, (32u - _941)))))), int(_948), int(min(24u, (32u - _948))))) * uint(bitfieldExtract(5, int(_953), int(min(24u, (32u - _953)))))));
    uint _975 = min(0u, 32u);
    uint _979 = min(0u, 32u);
    uint _984 = min(0u, 32u);
    uint _988 = min(0u, 32u);
    _301 = _221;
    _303 = uint(19);
    _488 = _301;
    _488[1u] += _303;
    _490 = _488[0u];
    _492 = _488[1u];
    _11._m0[_492] = bitfieldExtract(bitfieldExtract(16777215u, int(_975), int(min(24u, (32u - _975)))) * bitfieldExtract(2u, int(_979), int(min(24u, (32u - _979)))), int(_984), int(min(24u, (32u - _984)))) * bitfieldExtract(2u, int(_988), int(min(24u, (32u - _988))));
    _305 = -3;
    _307 = 5u;
    uint _1010 = min(0u, 32u);
    uint _1015 = min(0u, 32u);
    _309 = _221;
    _311 = uint(20);
    _494 = _309;
    _494[1u] += _311;
    _496 = _494[0u];
    _498 = _494[1u];
    _11._m0[_498] = uint(int(uint(bitfieldExtract(_305, int(_1010), int(min(24u, (32u - _1010))))) * uint(bitfieldExtract(int(_307), int(_1015), int(min(24u, (32u - _1015)))))));
    uint _1040 = min(0u, 32u);
    uint _1044 = min(0u, 32u);
    _313 = _221;
    _315 = uint(21);
    _500 = _313;
    _500[1u] += _315;
    _502 = _500[0u];
    _504 = _500[1u];
    _11._m0[_504] = bitfieldExtract(uint(_305), int(_1040), int(min(24u, (32u - _1040)))) * bitfieldExtract(_307, int(_1044), int(min(24u, (32u - _1044))));
    uint _1063 = min(0u, 32u);
    uint _1068 = min(0u, 32u);
    _317 = _221;
    _319 = uint(22);
    _506 = _317;
    _506[1u] += _319;
    _508 = _506[0u];
    _510 = _506[1u];
    _11._m0[_510] = uint(int(uint(bitfieldExtract(25165824, int(_1063), int(min(24u, (32u - _1063))))) * uint(bitfieldExtract(16777217, int(_1068), int(min(24u, (32u - _1068)))))));
    uint _1090 = min(0u, 32u);
    uint _1094 = min(0u, 32u);
    _321 = _221;
    _323 = uint(23);
    _512 = _321;
    _512[1u] += _323;
    _514 = _512[0u];
    _516 = _512[1u];
    _11._m0[_516] = bitfieldExtract(4286578688u, int(_1090), int(min(24u, (32u - _1090)))) * bitfieldExtract(4278190081u, int(_1094), int(min(24u, (32u - _1094))));
    if (true)
    {
        int _1115 = -3;
        uint _1117 = min(0u, 32u);
        uint _1122 = min(0u, 32u);
        _329 = int(uint(bitfieldExtract(_1115, int(_1117), int(min(24u, (32u - _1117))))) * uint(bitfieldExtract(7, int(_1122), int(min(24u, (32u - _1122))))));
    }
    else
    {
        uint _1129 = min(0u, 32u);
        uint _1134 = min(0u, 32u);
        _329 = int(uint(bitfieldExtract(0, int(_1129), int(min(24u, (32u - _1129))))) * uint(bitfieldExtract(0, int(_1134), int(min(24u, (32u - _1134))))));
    }
    _325 = _221;
    _327 = uint(24);
    _518 = _325;
    _518[1u] += _327;
    _520 = _518[0u];
    _522 = _518[1u];
    _11._m0[_522] = uint(_329);
    uint _1157 = min(0u, 32u);
    uint _1162 = min(0u, 32u);
    _331[0u] = int(uint(bitfieldExtract(2, int(_1157), int(min(24u, (32u - _1157))))) * uint(bitfieldExtract(3, int(_1162), int(min(24u, (32u - _1162))))));
    uint _1170 = min(0u, 32u);
    uint _1175 = min(0u, 32u);
    _331[1u] = int(uint(bitfieldExtract(3, int(_1170), int(min(24u, (32u - _1170))))) * uint(bitfieldExtract(4, int(_1175), int(min(24u, (32u - _1175))))));
    _334 = _221;
    _336 = uint(25);
    _524 = _334;
    _524[1u] += _336;
    _526 = _524[0u];
    _528 = _524[1u];
    _11._m0[_528] = uint(_331[0u] + _331[1u]);
    _338 = 2;
    _342 = int[](0, 0);
    _344 = _221;
    _346 = uint(26);
    _530 = _344;
    _530[1u] += _346;
    _532 = _530[0u];
    _534 = _530[1u];
    _11._m0[_534] = uint(_338 + _342[0u]);
    _348 = 2;
    int _1221 = _348;
    _348 = _1221 + 1;
    int _1223 = _348;
    _348 = _1223 + 1;
    uint _1226 = min(0u, 32u);
    uint _1231 = min(0u, 32u);
    _350 = _221;
    _352 = uint(27);
    _536 = _350;
    _536[1u] += _352;
    _538 = _536[0u];
    _540 = _536[1u];
    _11._m0[_540] = uint(int(uint(bitfieldExtract(_1221, int(_1226), int(min(24u, (32u - _1226))))) * uint(bitfieldExtract(_1223, int(_1231), int(min(24u, (32u - _1231)))))));
    _354 = _221;
    _356 = uint(28);
    _542 = _354;
    _542[1u] += _356;
    _544 = _542[0u];
    _546 = _542[1u];
    _11._m0[_546] = uint(_348);
    _358 = 0;
    int _360 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _1280)))
        {
            break;
        }
        _1280 -= uvec2(uint(_1280.y == 0u), 1u);
        if (!(_360 < 3))
        {
            break;
        }
        uint _1298 = min(0u, 32u);
        uint _1303 = min(0u, 32u);
        _358 += int(uint(bitfieldExtract(_360 + 1, int(_1298), int(min(24u, (32u - _1298))))) * uint(bitfieldExtract(2, int(_1303), int(min(24u, (32u - _1303))))));
        _360++;
        continue;
    }
    _362 = _221;
    _364 = uint(29);
    _548 = _362;
    _548[1u] += _364;
    _550 = _548[0u];
    _552 = _548[1u];
    _11._m0[_552] = uint(_358);
    float _1331 = clamp(9.75, -2147483648.0, 2147483520.0);
    _366 = _221;
    _368 = uint(30);
    _554 = _366;
    _554[1u] += _368;
    _556 = _554[0u];
    _558 = _554[1u];
    _11._m0[_558] = uint(int(_1331));
    uint _1349 = min(0u, 32u);
    uint _1354 = min(0u, 32u);
    _370 = _221;
    _372 = uint(31);
    _560 = _370;
    _560[1u] += _372;
    _562 = _560[0u];
    _564 = _560[1u];
    _11._m0[_564] = uint(int(uint(bitfieldExtract(16777215, int(_1349), int(min(24u, (32u - _1349))))) * uint(bitfieldExtract(3, int(_1354), int(min(24u, (32u - _1354)))))));
}

