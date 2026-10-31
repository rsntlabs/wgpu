#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _12_11
{
    uint _m0[];
} _11;

int _17(float _15, float _16)
{
    uint _30 = min(0u, 32u);
    uint _35 = min(0u, 32u);
    return int(uint(bitfieldExtract(int(clamp(_15, -2147483648.0, 2147483520.0)), int(_30), int(min(24u, (32u - _30))))) * uint(bitfieldExtract(int(clamp(_16, -2147483648.0, 2147483520.0)), int(_35), int(min(24u, (32u - _35))))));
}

uint _44(float _42, float _43)
{
    uint _54 = min(0u, 32u);
    uint _58 = min(0u, 32u);
    return bitfieldExtract(uint(clamp(_42, 0.0, 4294967040.0)), int(_54), int(min(24u, (32u - _54)))) * bitfieldExtract(uint(clamp(_43, 0.0, 4294967040.0)), int(_58), int(min(24u, (32u - _58))));
}

int _65(bool _63, bool _64)
{
    int _70 = 0;
    int _73 = 0;
    if (_63)
    {
        if (_64)
        {
            _70 = 71;
        }
        else
        {
            _70 = 73;
        }
        _73 = _70;
    }
    else
    {
        _73 = 79;
    }
    return _73;
}

int _87(float _85, float _86)
{
    return int(clamp((_85 * 10.0) + _86, -2147483648.0, 2147483520.0));
}

uint _97(int _95, int _96)
{
    return uint((_95 + _96) + 100);
}

int _107(int _105, int _106)
{
    uint _111 = min(0u, 32u);
    uint _116 = min(0u, 32u);
    return int(uint(bitfieldExtract(_105, int(_111), int(min(24u, (32u - _111))))) * uint(bitfieldExtract(_106, int(_116), int(min(24u, (32u - _116))))));
}

void main()
{
    uint _428 = 0u;
    int _293[2] = int[](0, 0);
    uint _404 = 0u;
    uint _269 = 0u;
    uint _514 = 0u;
    uint _380 = 0u;
    uint _245 = 0u;
    uint _490 = 0u;
    uint _356 = 0u;
    uint _221 = 0u;
    uint _466 = 0u;
    uint _332[2] = uint[](0u, 0u);
    uint _197 = 0u;
    uint _442 = 0u;
    uint _308 = 0u;
    uint _418 = 0u;
    uint _283[2] = uint[](0u, 0u);
    uint _394 = 0u;
    uint _259[2] = uint[](0u, 0u);
    uint _504[2] = uint[](0u, 0u);
    uint _370 = 0u;
    uint _235[2] = uint[](0u, 0u);
    uint _480[2] = uint[](0u, 0u);
    uint _346 = 0u;
    uint _211[2] = uint[](0u, 0u);
    uint _456[2] = uint[](0u, 0u);
    uint _186[2] = uint[](0u, 0u);
    uint _432[2] = uint[](0u, 0u);
    uint _298 = 0u;
    uint _408[2] = uint[](0u, 0u);
    uint _273 = 0u;
    uint _518 = 0u;
    uint _384[2] = uint[](0u, 0u);
    uint _249 = 0u;
    uint _494 = 0u;
    uint _360[2] = uint[](0u, 0u);
    uint _225 = 0u;
    uint _470 = 0u;
    uint _336[2] = uint[](0u, 0u);
    uint _201 = 0u;
    uint _446 = 0u;
    uint _312[2] = uint[](0u, 0u);
    uint _422 = 0u;
    uint _287[2] = uint[](0u, 0u);
    uint _398 = 0u;
    uint _263[2] = uint[](0u, 0u);
    uint _508 = 0u;
    uint _374 = 0u;
    uint _239[2] = uint[](0u, 0u);
    uint _484 = 0u;
    uint _350 = 0u;
    uint _215[2] = uint[](0u, 0u);
    uint _460 = 0u;
    uint _326 = 0u;
    uint _191[2] = uint[](0u, 0u);
    uint _436 = 0u;
    int _302 = 0;
    uint _412 = 0u;
    uint _277 = 0u;
    uint _522[2] = uint[](0u, 0u);
    uint _388 = 0u;
    uint _253 = 0u;
    uint _498[2] = uint[](0u, 0u);
    uint _364 = 0u;
    uint _229 = 0u;
    uint _474[2] = uint[](0u, 0u);
    uint _340 = 0u;
    uint _205 = 0u;
    uint _450[2] = uint[](0u, 0u);
    uint _316[2] = uint[](0u, 0u);
    uint _426[2] = uint[](0u, 0u);
    int _291 = 0;
    uint _402[2] = uint[](0u, 0u);
    int _267 = 0;
    uint _512 = 0u;
    uint _378[2] = uint[](0u, 0u);
    uint _243[2] = uint[](0u, 0u);
    uint _488 = 0u;
    uint _354[2] = uint[](0u, 0u);
    uint _219[2] = uint[](0u, 0u);
    uint _464 = 0u;
    uint _330 = 0u;
    uint _195[2] = uint[](0u, 0u);
    uint _440 = 0u;
    uint _306[2] = uint[](0u, 0u);
    uint _416 = 0u;
    uint _281 = 0u;
    uint _526 = 0u;
    uint _392 = 0u;
    uint _257 = 0u;
    uint _502 = 0u;
    uint _368 = 0u;
    uint _233 = 0u;
    uint _478 = 0u;
    uint _344 = 0u;
    uint _209 = 0u;
    uint _454 = 0u;
    int _320 = 0;
    uint _183[2] = uint[](0u, 0u);
    uint _430 = 0u;
    uint _296[2] = uint[](0u, 0u);
    uint _406 = 0u;
    uint _271[2] = uint[](0u, 0u);
    uint _516[2] = uint[](0u, 0u);
    uint _382 = 0u;
    uint _247[2] = uint[](0u, 0u);
    uint _492[2] = uint[](0u, 0u);
    uint _358 = 0u;
    uint _223[2] = uint[](0u, 0u);
    uint _468[2] = uint[](0u, 0u);
    uint _334 = 0u;
    uint _199[2] = uint[](0u, 0u);
    uint _444[2] = uint[](0u, 0u);
    int _310 = 0;
    uint _420[2] = uint[](0u, 0u);
    uint _285 = 0u;
    uint _396[2] = uint[](0u, 0u);
    uint _261 = 0u;
    uint _506 = 0u;
    uint _372[2] = uint[](0u, 0u);
    uint _237 = 0u;
    uint _482 = 0u;
    uint _348[2] = uint[](0u, 0u);
    uint _213 = 0u;
    uint _458 = 0u;
    uint _324[2] = uint[](0u, 0u);
    uint _188 = 0u;
    uint _434 = 0u;
    int _300 = 0;
    uint _410 = 0u;
    uint _275[2] = uint[](0u, 0u);
    uint _520 = 0u;
    uint _386 = 0u;
    uint _251[2] = uint[](0u, 0u);
    uint _496 = 0u;
    uint _362 = 0u;
    uint _227[2] = uint[](0u, 0u);
    uint _472 = 0u;
    uint _338 = 0u;
    uint _203[2] = uint[](0u, 0u);
    uint _448 = 0u;
    uint _314 = 0u;
    uint _424 = 0u;
    uint _289 = 0u;
    uint _400 = 0u;
    uint _265 = 0u;
    uint _510[2] = uint[](0u, 0u);
    uint _376 = 0u;
    uint _241 = 0u;
    uint _486[2] = uint[](0u, 0u);
    uint _352 = 0u;
    uint _217 = 0u;
    uint _462[2] = uint[](0u, 0u);
    uint _328[2] = uint[](0u, 0u);
    uint _193 = 0u;
    uint _438[2] = uint[](0u, 0u);
    int _304[2] = int[](0, 0);
    uint _414[2] = uint[](0u, 0u);
    uint _279[2] = uint[](0u, 0u);
    uint _524 = 0u;
    uint _390[2] = uint[](0u, 0u);
    uint _255[2] = uint[](0u, 0u);
    uint _500 = 0u;
    uint _366[2] = uint[](0u, 0u);
    uint _231[2] = uint[](0u, 0u);
    uint _476 = 0u;
    uint _342[2] = uint[](0u, 0u);
    uint _207[2] = uint[](0u, 0u);
    uint _452 = 0u;
    uint _318 = 0u;
    uvec2 _1242 = uvec2(4294967295u);
    _183 = uint[](0u, 0u);
    _183[0u] = 0u;
    _183[1u] = 0u;
    uint _533 = min(0u, 32u);
    uint _538 = min(0u, 32u);
    _186 = _183;
    _188 = uint(0);
    _336 = _186;
    _336[1u] += _188;
    _338 = _336[0u];
    _340 = _336[1u];
    _11._m0[_340] = uint(int(uint(bitfieldExtract(8388608, int(_533), int(min(24u, (32u - _533))))) * uint(bitfieldExtract(1, int(_538), int(min(24u, (32u - _538)))))));
    uint _561 = min(0u, 32u);
    uint _565 = min(0u, 32u);
    _191 = _183;
    _193 = uint(1);
    _342 = _191;
    _342[1u] += _193;
    _344 = _342[0u];
    _346 = _342[1u];
    _11._m0[_346] = bitfieldExtract(16777215u, int(_561), int(min(24u, (32u - _561)))) * bitfieldExtract(16777215u, int(_565), int(min(24u, (32u - _565))));
    uint _584 = min(0u, 32u);
    uint _589 = min(0u, 32u);
    _195 = _183;
    _197 = uint(2);
    _348 = _195;
    _348[1u] += _197;
    _350 = _348[0u];
    _352 = _348[1u];
    _11._m0[_352] = uint(int(uint(bitfieldExtract(8388607, int(_584), int(min(24u, (32u - _584))))) * uint(bitfieldExtract(8388607, int(_589), int(min(24u, (32u - _589)))))));
    uint _611 = min(0u, 32u);
    uint _615 = min(0u, 32u);
    _199 = _183;
    _201 = uint(3);
    _354 = _199;
    _354[1u] += _201;
    _356 = _354[0u];
    _358 = _354[1u];
    _11._m0[_358] = bitfieldExtract(16777216u, int(_611), int(min(24u, (32u - _611)))) * bitfieldExtract(13u, int(_615), int(min(24u, (32u - _615))));
    float _633 = -2.75;
    _203 = _183;
    _205 = uint(4);
    _360 = _203;
    _360[1u] += _205;
    _362 = _360[0u];
    _364 = _360[1u];
    _11._m0[_364] = uint(_17(3.75, _633));
    float _650 = -3.75;
    _207 = _183;
    _209 = uint(5);
    _366 = _207;
    _366[1u] += _209;
    _368 = _366[0u];
    _370 = _366[1u];
    _11._m0[_370] = uint(_17(_650, 2.75));
    _211 = _183;
    _213 = uint(6);
    _372 = _211;
    _372[1u] += _213;
    _374 = _372[0u];
    _376 = _372[1u];
    _11._m0[_376] = _44(3.75, 2.75);
    _215 = _183;
    _217 = uint(7);
    _378 = _215;
    _378[1u] += _217;
    _380 = _378[0u];
    _382 = _378[1u];
    _11._m0[_382] = _44(16777215.0, 1.0);
    _219 = _183;
    _221 = uint(8);
    _384 = _219;
    _384[1u] += _221;
    _386 = _384[0u];
    _388 = _384[1u];
    _11._m0[_388] = uint(_65(true, true));
    _223 = _183;
    _225 = uint(9);
    _390 = _223;
    _390[1u] += _225;
    _392 = _390[0u];
    _394 = _390[1u];
    _11._m0[_394] = uint(_65(false, true));
    uint _731 = min(0u, 32u);
    uint _736 = min(0u, 32u);
    _227 = _183;
    _229 = uint(10);
    _396 = _227;
    _396[1u] += _229;
    _398 = _396[0u];
    _400 = _396[1u];
    _11._m0[_400] = uint(int(uint(bitfieldExtract(3, int(_731), int(min(24u, (32u - _731))))) * uint(bitfieldExtract(int(true), int(_736), int(min(24u, (32u - _736)))))));
    uint _759 = min(0u, 32u);
    uint _764 = min(0u, 32u);
    _231 = _183;
    _233 = uint(11);
    _402 = _231;
    _402[1u] += _233;
    _404 = _402[0u];
    _406 = _402[1u];
    _11._m0[_406] = uint(int(uint(bitfieldExtract(int(true), int(_759), int(min(24u, (32u - _759))))) * uint(bitfieldExtract(3, int(_764), int(min(24u, (32u - _764)))))));
    _235 = _183;
    _237 = uint(12);
    _408 = _235;
    _408[1u] += _237;
    _410 = _408[0u];
    _412 = _408[1u];
    _11._m0[_412] = uint(_87(3.75, 2.0));
    _239 = _183;
    _241 = uint(13);
    _414 = _239;
    _414[1u] += _241;
    _416 = _414[0u];
    _418 = _414[1u];
    _11._m0[_418] = _97(3, 4);
    uint _817 = min(0u, 32u);
    uint _821 = min(0u, 32u);
    _243 = _183;
    _245 = uint(14);
    _420 = _243;
    _420[1u] += _245;
    _422 = _420[0u];
    _424 = _420[1u];
    _11._m0[_424] = bitfieldExtract(3u, int(_817), int(min(24u, (32u - _817)))) * bitfieldExtract(4u, int(_821), int(min(24u, (32u - _821))));
    _247 = _183;
    _249 = uint(15);
    _426 = _247;
    _426[1u] += _249;
    _428 = _426[0u];
    _430 = _426[1u];
    _11._m0[_430] = _97(int(true), int(true));
    uint _858 = min(0u, 32u);
    uint _862 = min(0u, 32u);
    _251 = _183;
    _253 = uint(16);
    _432 = _251;
    _432[1u] += _253;
    _434 = _432[0u];
    _436 = _432[1u];
    _11._m0[_436] = bitfieldExtract(3u, int(_858), int(min(24u, (32u - _858)))) * bitfieldExtract(uint(4), int(_862), int(min(24u, (32u - _862))));
    int _880 = -7;
    _255 = _183;
    _257 = uint(17);
    _438 = _255;
    _438[1u] += _257;
    _440 = _438[0u];
    _442 = _438[1u];
    _11._m0[_442] = uint(_107(_880, 3));
    uint _898 = min(0u, 32u);
    uint _903 = min(0u, 32u);
    uint _910 = min(0u, 32u);
    uint _915 = min(0u, 32u);
    _259 = _183;
    _261 = uint(18);
    _444 = _259;
    _444[1u] += _261;
    _446 = _444[0u];
    _448 = _444[1u];
    _11._m0[_448] = uint(int(uint(bitfieldExtract(int(uint(bitfieldExtract(3, int(_898), int(min(24u, (32u - _898))))) * uint(bitfieldExtract(4, int(_903), int(min(24u, (32u - _903)))))), int(_910), int(min(24u, (32u - _910))))) * uint(bitfieldExtract(5, int(_915), int(min(24u, (32u - _915)))))));
    uint _937 = min(0u, 32u);
    uint _941 = min(0u, 32u);
    uint _946 = min(0u, 32u);
    uint _950 = min(0u, 32u);
    _263 = _183;
    _265 = uint(19);
    _450 = _263;
    _450[1u] += _265;
    _452 = _450[0u];
    _454 = _450[1u];
    _11._m0[_454] = bitfieldExtract(bitfieldExtract(16777215u, int(_937), int(min(24u, (32u - _937)))) * bitfieldExtract(2u, int(_941), int(min(24u, (32u - _941)))), int(_946), int(min(24u, (32u - _946)))) * bitfieldExtract(2u, int(_950), int(min(24u, (32u - _950))));
    _267 = -3;
    _269 = 5u;
    uint _972 = min(0u, 32u);
    uint _977 = min(0u, 32u);
    _271 = _183;
    _273 = uint(20);
    _456 = _271;
    _456[1u] += _273;
    _458 = _456[0u];
    _460 = _456[1u];
    _11._m0[_460] = uint(int(uint(bitfieldExtract(_267, int(_972), int(min(24u, (32u - _972))))) * uint(bitfieldExtract(int(_269), int(_977), int(min(24u, (32u - _977)))))));
    uint _1002 = min(0u, 32u);
    uint _1006 = min(0u, 32u);
    _275 = _183;
    _277 = uint(21);
    _462 = _275;
    _462[1u] += _277;
    _464 = _462[0u];
    _466 = _462[1u];
    _11._m0[_466] = bitfieldExtract(uint(_267), int(_1002), int(min(24u, (32u - _1002)))) * bitfieldExtract(_269, int(_1006), int(min(24u, (32u - _1006))));
    uint _1025 = min(0u, 32u);
    uint _1030 = min(0u, 32u);
    _279 = _183;
    _281 = uint(22);
    _468 = _279;
    _468[1u] += _281;
    _470 = _468[0u];
    _472 = _468[1u];
    _11._m0[_472] = uint(int(uint(bitfieldExtract(25165824, int(_1025), int(min(24u, (32u - _1025))))) * uint(bitfieldExtract(16777217, int(_1030), int(min(24u, (32u - _1030)))))));
    uint _1052 = min(0u, 32u);
    uint _1056 = min(0u, 32u);
    _283 = _183;
    _285 = uint(23);
    _474 = _283;
    _474[1u] += _285;
    _476 = _474[0u];
    _478 = _474[1u];
    _11._m0[_478] = bitfieldExtract(4286578688u, int(_1052), int(min(24u, (32u - _1052)))) * bitfieldExtract(4278190081u, int(_1056), int(min(24u, (32u - _1056))));
    if (true)
    {
        int _1077 = -3;
        uint _1079 = min(0u, 32u);
        uint _1084 = min(0u, 32u);
        _291 = int(uint(bitfieldExtract(_1077, int(_1079), int(min(24u, (32u - _1079))))) * uint(bitfieldExtract(7, int(_1084), int(min(24u, (32u - _1084))))));
    }
    else
    {
        uint _1091 = min(0u, 32u);
        uint _1096 = min(0u, 32u);
        _291 = int(uint(bitfieldExtract(0, int(_1091), int(min(24u, (32u - _1091))))) * uint(bitfieldExtract(0, int(_1096), int(min(24u, (32u - _1096))))));
    }
    _287 = _183;
    _289 = uint(24);
    _480 = _287;
    _480[1u] += _289;
    _482 = _480[0u];
    _484 = _480[1u];
    _11._m0[_484] = uint(_291);
    uint _1119 = min(0u, 32u);
    uint _1124 = min(0u, 32u);
    _293[0u] = int(uint(bitfieldExtract(2, int(_1119), int(min(24u, (32u - _1119))))) * uint(bitfieldExtract(3, int(_1124), int(min(24u, (32u - _1124))))));
    uint _1132 = min(0u, 32u);
    uint _1137 = min(0u, 32u);
    _293[1u] = int(uint(bitfieldExtract(3, int(_1132), int(min(24u, (32u - _1132))))) * uint(bitfieldExtract(4, int(_1137), int(min(24u, (32u - _1137))))));
    _296 = _183;
    _298 = uint(25);
    _486 = _296;
    _486[1u] += _298;
    _488 = _486[0u];
    _490 = _486[1u];
    _11._m0[_490] = uint(_293[0u] + _293[1u]);
    _300 = 2;
    _304 = int[](0, 0);
    _306 = _183;
    _308 = uint(26);
    _492 = _306;
    _492[1u] += _308;
    _494 = _492[0u];
    _496 = _492[1u];
    _11._m0[_496] = uint(_300 + _304[0u]);
    _310 = 2;
    int _1183 = _310;
    _310 = _1183 + 1;
    int _1185 = _310;
    _310 = _1185 + 1;
    uint _1188 = min(0u, 32u);
    uint _1193 = min(0u, 32u);
    _312 = _183;
    _314 = uint(27);
    _498 = _312;
    _498[1u] += _314;
    _500 = _498[0u];
    _502 = _498[1u];
    _11._m0[_502] = uint(int(uint(bitfieldExtract(_1183, int(_1188), int(min(24u, (32u - _1188))))) * uint(bitfieldExtract(_1185, int(_1193), int(min(24u, (32u - _1193)))))));
    _316 = _183;
    _318 = uint(28);
    _504 = _316;
    _504[1u] += _318;
    _506 = _504[0u];
    _508 = _504[1u];
    _11._m0[_508] = uint(_310);
    _320 = 0;
    int _322 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _1242)))
        {
            break;
        }
        _1242 -= uvec2(uint(_1242.y == 0u), 1u);
        if (!(_322 < 3))
        {
            break;
        }
        uint _1260 = min(0u, 32u);
        uint _1265 = min(0u, 32u);
        _320 += int(uint(bitfieldExtract(_322 + 1, int(_1260), int(min(24u, (32u - _1260))))) * uint(bitfieldExtract(2, int(_1265), int(min(24u, (32u - _1265))))));
        _322++;
        continue;
    }
    _324 = _183;
    _326 = uint(29);
    _510 = _324;
    _510[1u] += _326;
    _512 = _510[0u];
    _514 = _510[1u];
    _11._m0[_514] = uint(_320);
    float _1293 = clamp(9.75, -2147483648.0, 2147483520.0);
    _328 = _183;
    _330 = uint(30);
    _516 = _328;
    _516[1u] += _330;
    _518 = _516[0u];
    _520 = _516[1u];
    _11._m0[_520] = uint(int(_1293));
    uint _1311 = min(0u, 32u);
    uint _1316 = min(0u, 32u);
    _332 = _183;
    _334 = uint(31);
    _522 = _332;
    _522[1u] += _334;
    _524 = _522[0u];
    _526 = _522[1u];
    _11._m0[_526] = uint(int(uint(bitfieldExtract(16777215, int(_1311), int(min(24u, (32u - _1311))))) * uint(bitfieldExtract(3, int(_1316), int(min(24u, (32u - _1316)))))));
}

