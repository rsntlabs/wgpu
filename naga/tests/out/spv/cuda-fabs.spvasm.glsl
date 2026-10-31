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
    float _145 = 0.0;
    uint _147 = 0u;
    _145 = _142;
    uint _152 = floatBitsToUint(_145) & 2147483647u;
    _147 = (_152 > 2139095040u) ? 2143289344u : _152;
    return uintBitsToFloat(_147);
}

float _159(int _158)
{
    int _161 = 0;
    uint _164 = 0u;
    _161 = _158;
    uint _170 = floatBitsToUint(float(_161)) & 2147483647u;
    _164 = (_170 > 2139095040u) ? 2143289344u : _170;
    return uintBitsToFloat(_164);
}

float _177(uint _176)
{
    uint _179 = 0u;
    uint _181 = 0u;
    _179 = _176;
    uint _187 = floatBitsToUint(float(_179)) & 2147483647u;
    _181 = (_187 > 2139095040u) ? 2143289344u : _187;
    return uintBitsToFloat(_181);
}

float _194(bool _193)
{
    bool _196 = false;
    uint _199 = 0u;
    _196 = _193;
    uint _207 = floatBitsToUint(float(_196)) & 2147483647u;
    _199 = (_207 > 2139095040u) ? 2143289344u : _207;
    return uintBitsToFloat(_199);
}

int _214(int _213)
{
    int _217 = 0;
    _217 = _213;
    return _217 + 40;
}

uint _224(uint _223)
{
    uint _227 = 0u;
    _227 = _223;
    return _227 + 50u;
}

int _234(bool _233)
{
    bool _238 = false;
    int _240 = 0;
    _238 = _233;
    if (_238)
    {
        _240 = 7;
    }
    else
    {
        _240 = 9;
    }
    return _240;
}

int _250(bool _249)
{
    bool _253 = false;
    int _255 = 0;
    _253 = _249;
    if (_253)
    {
        _255 = 11;
    }
    else
    {
        _255 = 13;
    }
    return _255;
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

float _266(float _264, float _265)
{
    float _268 = 0.0;
    float _270 = 0.0;
    _268 = _264;
    _270 = _265;
    return _268 + _270;
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
    uint _568[2] = uint[](0u, 0u);
    uint _434[2] = uint[](0u, 0u);
    uint _678 = 0u;
    uint _544[2] = uint[](0u, 0u);
    uint _410[2] = uint[](0u, 0u);
    uint _654 = 0u;
    uint _520[2] = uint[](0u, 0u);
    uint _386 = 0u;
    uint _630 = 0u;
    vec4 _496 = vec4(0.0);
    uint _362[2] = uint[](0u, 0u);
    uint _606 = 0u;
    uint _472 = 0u;
    uint _338 = 0u;
    uint _582 = 0u;
    uint _448 = 0u;
    uint _558 = 0u;
    uint _424 = 0u;
    uint _668 = 0u;
    uint _534 = 0u;
    uint _400 = 0u;
    uint _644 = 0u;
    uint _510 = 0u;
    uint _376 = 0u;
    uint _620 = 0u;
    uint _486[2] = uint[](0u, 0u);
    uint _352 = 0u;
    uint _596 = 0u;
    uint _462[2] = uint[](0u, 0u);
    uint _328[2] = uint[](0u, 0u);
    uint _572 = 0u;
    uint _438 = 0u;
    uint _548 = 0u;
    uint _414 = 0u;
    uint _658[2] = uint[](0u, 0u);
    uint _524 = 0u;
    uint _390[2] = uint[](0u, 0u);
    uint _634[2] = uint[](0u, 0u);
    uint _500 = 0u;
    uint _366[2] = uint[](0u, 0u);
    uint _610[2] = uint[](0u, 0u);
    uint _476 = 0u;
    uint _342 = 0u;
    uint _586[2] = uint[](0u, 0u);
    uint _452 = 0u;
    uint _562[2] = uint[](0u, 0u);
    uint _428 = 0u;
    uint _672 = 0u;
    uint _538[2] = uint[](0u, 0u);
    uint _404[2] = uint[](0u, 0u);
    uint _648 = 0u;
    uint _514[2] = uint[](0u, 0u);
    uint _380 = 0u;
    uint _624 = 0u;
    uint _490[2] = uint[](0u, 0u);
    uint _356 = 0u;
    uint _600 = 0u;
    uint _466[2] = uint[](0u, 0u);
    uint _332 = 0u;
    uint _576 = 0u;
    float _442 = 0.0;
    uint _552 = 0u;
    uint _418[2] = uint[](0u, 0u);
    uint _662 = 0u;
    uint _528 = 0u;
    uint _394 = 0u;
    uint _638 = 0u;
    uint _504 = 0u;
    uint _370 = 0u;
    uint _614 = 0u;
    uint _480 = 0u;
    uint _346[2] = uint[](0u, 0u);
    uint _590 = 0u;
    uint _456 = 0u;
    uint _566 = 0u;
    uint _432 = 0u;
    uint _676[2] = uint[](0u, 0u);
    uint _542 = 0u;
    uint _408 = 0u;
    uint _652[2] = uint[](0u, 0u);
    uint _518 = 0u;
    uint _384 = 0u;
    uint _628[2] = uint[](0u, 0u);
    vec2 _494 = vec2(0.0);
    uint _360 = 0u;
    uint _604[2] = uint[](0u, 0u);
    uint _470[2] = uint[](0u, 0u);
    uint _336 = 0u;
    uint _580[2] = uint[](0u, 0u);
    uint _446 = 0u;
    uint _556[2] = uint[](0u, 0u);
    uint _422 = 0u;
    uint _666 = 0u;
    uint _532[2] = uint[](0u, 0u);
    uint _398[2] = uint[](0u, 0u);
    uint _642 = 0u;
    uint _508[2] = uint[](0u, 0u);
    uint _374[2] = uint[](0u, 0u);
    uint _618 = 0u;
    uint _484 = 0u;
    uint _350[2] = uint[](0u, 0u);
    uint _594 = 0u;
    uint _460 = 0u;
    uint _325[2] = uint[](0u, 0u);
    uint _570 = 0u;
    uint _436 = 0u;
    uint _680 = 0u;
    uint _546 = 0u;
    uint _412 = 0u;
    uint _656 = 0u;
    uint _522 = 0u;
    uint _388 = 0u;
    uint _632 = 0u;
    uint _498[2] = uint[](0u, 0u);
    uint _364 = 0u;
    uint _608 = 0u;
    _6 _474 = _6(0.0, 0.0, 0.0);
    uint _340[2] = uint[](0u, 0u);
    uint _584 = 0u;
    uint _450[2] = uint[](0u, 0u);
    uint _560 = 0u;
    uint _426[2] = uint[](0u, 0u);
    uint _670[2] = uint[](0u, 0u);
    uint _536 = 0u;
    uint _402 = 0u;
    uint _646[2] = uint[](0u, 0u);
    uint _512 = 0u;
    uint _378 = 0u;
    uint _622[2] = uint[](0u, 0u);
    uint _488 = 0u;
    uint _354[2] = uint[](0u, 0u);
    uint _598[2] = uint[](0u, 0u);
    uint _464 = 0u;
    uint _330 = 0u;
    uint _574[2] = uint[](0u, 0u);
    uint _440 = 0u;
    uint _550[2] = uint[](0u, 0u);
    uint _416 = 0u;
    uint _660 = 0u;
    uint _526[2] = uint[](0u, 0u);
    uint _392 = 0u;
    uint _636 = 0u;
    uint _502[2] = uint[](0u, 0u);
    uint _368 = 0u;
    uint _612 = 0u;
    uint _478[2] = uint[](0u, 0u);
    uint _344 = 0u;
    uint _588 = 0u;
    uint _454[2] = uint[](0u, 0u);
    uint _564 = 0u;
    uint _430 = 0u;
    uint _674 = 0u;
    uint _540 = 0u;
    uint _406 = 0u;
    uint _650 = 0u;
    uint _516 = 0u;
    uint _382[2] = uint[](0u, 0u);
    uint _626 = 0u;
    uint _492 = 0u;
    uint _358[2] = uint[](0u, 0u);
    uint _602 = 0u;
    uint _468 = 0u;
    uint _334[2] = uint[](0u, 0u);
    uint _578 = 0u;
    uint _444[2] = uint[](0u, 0u);
    uint _554 = 0u;
    uint _420 = 0u;
    uint _664[2] = uint[](0u, 0u);
    uint _530 = 0u;
    uint _396 = 0u;
    uint _640[2] = uint[](0u, 0u);
    uint _506 = 0u;
    uint _372 = 0u;
    uint _616[2] = uint[](0u, 0u);
    uint _482[2] = uint[](0u, 0u);
    uint _348 = 0u;
    uint _592[2] = uint[](0u, 0u);
    uint _458[2] = uint[](0u, 0u);
    _325 = uint[](0u, 0u);
    _325[0u] = 0u;
    _325[1u] = 0u;
    uint _686 = floatBitsToUint(0.0) & 2147483647u;
    _332 = (_686 > 2139095040u) ? 2143289344u : _686;
    _328 = _325;
    _330 = uint(0);
    _502 = _328;
    _502[1u] += _330;
    _504 = _502[0u];
    _506 = _502[1u];
    _13._m0[_506] = floatBitsToUint(uintBitsToFloat(_332));
    float _707 = -0.0;
    uint _709 = floatBitsToUint(_707) & 2147483647u;
    _338 = (_709 > 2139095040u) ? 2143289344u : _709;
    _334 = _325;
    _336 = uint(1);
    _508 = _334;
    _508[1u] += _336;
    _510 = _508[0u];
    _512 = _508[1u];
    _13._m0[_512] = floatBitsToUint(uintBitsToFloat(_338));
    float _729 = -1.75;
    uint _731 = floatBitsToUint(_729) & 2147483647u;
    _344 = (_731 > 2139095040u) ? 2143289344u : _731;
    _340 = _325;
    _342 = uint(2);
    _514 = _340;
    _514[1u] += _342;
    _516 = _514[0u];
    _518 = _514[1u];
    _13._m0[_518] = floatBitsToUint(uintBitsToFloat(_344));
    float _751 = -1.25;
    _346 = _325;
    _348 = uint(3);
    _520 = _346;
    _520[1u] += _348;
    _522 = _520[0u];
    _524 = _520[1u];
    _13._m0[_524] = floatBitsToUint(_143(_751));
    int _768 = -3;
    _350 = _325;
    _352 = uint(4);
    _526 = _350;
    _526[1u] += _352;
    _528 = _526[0u];
    _530 = _526[1u];
    _13._m0[_530] = floatBitsToUint(_159(_768));
    _354 = _325;
    _356 = uint(5);
    _532 = _354;
    _532[1u] += _356;
    _534 = _532[0u];
    _536 = _532[1u];
    _13._m0[_536] = floatBitsToUint(_177(4294967295u));
    _358 = _325;
    _360 = uint(6);
    _538 = _358;
    _538[1u] += _360;
    _540 = _538[0u];
    _542 = _538[1u];
    _13._m0[_542] = floatBitsToUint(_194(true));
    _362 = _325;
    _364 = uint(7);
    _544 = _362;
    _544[1u] += _364;
    _546 = _544[0u];
    _548 = _544[1u];
    _13._m0[_548] = floatBitsToUint(_194(false));
    _370 = 1u;
    uint _836 = floatBitsToUint(uintBitsToFloat(_370)) & 2147483647u;
    _372 = (_836 > 2139095040u) ? 2143289344u : _836;
    _366 = _325;
    _368 = uint(8);
    _550 = _366;
    _550[1u] += _368;
    _552 = _550[0u];
    _554 = _550[1u];
    _13._m0[_554] = floatBitsToUint(uintBitsToFloat(_372));
    _378 = 2147483649u;
    uint _859 = floatBitsToUint(uintBitsToFloat(_378)) & 2147483647u;
    _380 = (_859 > 2139095040u) ? 2143289344u : _859;
    _374 = _325;
    _376 = uint(9);
    _556 = _374;
    _556[1u] += _376;
    _558 = _556[0u];
    _560 = _556[1u];
    _13._m0[_560] = floatBitsToUint(uintBitsToFloat(_380));
    _386 = 8388607u;
    uint _882 = floatBitsToUint(uintBitsToFloat(_386)) & 2147483647u;
    _388 = (_882 > 2139095040u) ? 2143289344u : _882;
    _382 = _325;
    _384 = uint(10);
    _562 = _382;
    _562[1u] += _384;
    _564 = _562[0u];
    _566 = _562[1u];
    _13._m0[_566] = floatBitsToUint(uintBitsToFloat(_388));
    _394 = 2155872255u;
    uint _905 = floatBitsToUint(uintBitsToFloat(_394)) & 2147483647u;
    _396 = (_905 > 2139095040u) ? 2143289344u : _905;
    _390 = _325;
    _392 = uint(11);
    _568 = _390;
    _568[1u] += _392;
    _570 = _568[0u];
    _572 = _568[1u];
    _13._m0[_572] = floatBitsToUint(uintBitsToFloat(_396));
    uint _926 = floatBitsToUint(3.4028234663852885981170418348452e+38) & 2147483647u;
    _402 = (_926 > 2139095040u) ? 2143289344u : _926;
    _398 = _325;
    _400 = uint(12);
    _574 = _398;
    _574[1u] += _400;
    _576 = _574[0u];
    _578 = _574[1u];
    _13._m0[_578] = floatBitsToUint(uintBitsToFloat(_402));
    float _946 = -3.4028234663852885981170418348452e+38;
    uint _948 = floatBitsToUint(_946) & 2147483647u;
    _408 = (_948 > 2139095040u) ? 2143289344u : _948;
    _404 = _325;
    _406 = uint(13);
    _580 = _404;
    _580[1u] += _406;
    _582 = _580[0u];
    _584 = _580[1u];
    _13._m0[_584] = floatBitsToUint(uintBitsToFloat(_408));
    _414 = 2139095040u;
    uint _971 = floatBitsToUint(uintBitsToFloat(_414)) & 2147483647u;
    _416 = (_971 > 2139095040u) ? 2143289344u : _971;
    _410 = _325;
    _412 = uint(14);
    _586 = _410;
    _586[1u] += _412;
    _588 = _586[0u];
    _590 = _586[1u];
    _13._m0[_590] = floatBitsToUint(uintBitsToFloat(_416));
    _422 = 4286578688u;
    uint _994 = floatBitsToUint(uintBitsToFloat(_422)) & 2147483647u;
    _424 = (_994 > 2139095040u) ? 2143289344u : _994;
    _418 = _325;
    _420 = uint(15);
    _592 = _418;
    _592[1u] += _420;
    _594 = _592[0u];
    _596 = _592[1u];
    _13._m0[_596] = floatBitsToUint(uintBitsToFloat(_424));
    _430 = 2143363909u;
    uint _1017 = floatBitsToUint(uintBitsToFloat(_430)) & 2147483647u;
    _432 = (_1017 > 2139095040u) ? 2143289344u : _1017;
    _426 = _325;
    _428 = uint(16);
    _598 = _426;
    _598[1u] += _428;
    _600 = _598[0u];
    _602 = _598[1u];
    _13._m0[_602] = floatBitsToUint(uintBitsToFloat(_432));
    _438 = 2139095041u;
    uint _1040 = floatBitsToUint(uintBitsToFloat(_438)) & 2147483647u;
    _440 = (_1040 > 2139095040u) ? 2143289344u : _1040;
    _434 = _325;
    _436 = uint(17);
    _604 = _434;
    _604[1u] += _436;
    _606 = _604[0u];
    _608 = _604[1u];
    _13._m0[_608] = floatBitsToUint(uintBitsToFloat(_440));
    float _1060 = -2.75;
    _442 = _1060;
    float _1061 = _442;
    float _1062 = float(1);
    _442 = _1061 + _1062;
    uint _1065 = floatBitsToUint(_1061) & 2147483647u;
    _448 = (_1065 > 2139095040u) ? 2143289344u : _1065;
    _444 = _325;
    _446 = uint(18);
    _610 = _444;
    _610[1u] += _446;
    _612 = _610[0u];
    _614 = _610[1u];
    _13._m0[_614] = floatBitsToUint(uintBitsToFloat(_448));
    _450 = _325;
    _452 = uint(19);
    _616 = _450;
    _616[1u] += _452;
    _618 = _616[0u];
    _620 = _616[1u];
    _13._m0[_620] = floatBitsToUint(_442);
    int _1101 = -3;
    _454 = _325;
    _456 = uint(20);
    _622 = _454;
    _622[1u] += _456;
    _624 = _622[0u];
    _626 = _622[1u];
    _13._m0[_626] = uint(_214(_1101));
    _458 = _325;
    _460 = uint(21);
    _628 = _458;
    _628[1u] += _460;
    _630 = _628[0u];
    _632 = _628[1u];
    _13._m0[_632] = _224(3u);
    _462 = _325;
    _464 = uint(22);
    _634 = _462;
    _634[1u] += _464;
    _636 = _634[0u];
    _638 = _634[1u];
    _13._m0[_638] = uint(_234(true));
    _466 = _325;
    _468 = uint(23);
    _640 = _466;
    _640[1u] += _468;
    _642 = _640[0u];
    _644 = _640[1u];
    _13._m0[_644] = uint(_234(false));
    _470 = _325;
    _472 = uint(24);
    _646 = _470;
    _646[1u] += _472;
    _648 = _646[0u];
    _650 = _646[1u];
    _13._m0[_650] = uint(_250(true));
    float _1181 = -2.5;
    float _1182 = -0.0;
    _476 = 2147483649u;
    _474 = _54(_6(_1181, _1182, uintBitsToFloat(_476)));
    _478 = _325;
    _480 = uint(25);
    _652 = _478;
    _652[1u] += _480;
    _654 = _652[0u];
    _656 = _652[1u];
    _13._m0[_656] = floatBitsToUint(_474._m0);
    _482 = _325;
    _484 = uint(26);
    _658 = _482;
    _658[1u] += _484;
    _660 = _658[0u];
    _662 = _658[1u];
    _13._m0[_662] = floatBitsToUint(_474._m1);
    _486 = _325;
    _488 = uint(27);
    _664 = _486;
    _664[1u] += _488;
    _666 = _664[0u];
    _668 = _664[1u];
    _13._m0[_668] = floatBitsToUint(_474._m2);
    float _1238 = -2.0;
    _490 = _325;
    _492 = uint(28);
    _670 = _490;
    _670[1u] += _492;
    _672 = _670[0u];
    _674 = _670[1u];
    _13._m0[_674] = floatBitsToUint(_266(_1238, 3.0));
    float _1255 = -3.0;
    float _1256 = -4.0;
    _494 = _18(vec2(_1255, _1256));
    float _1259 = -1.0;
    float _1260 = -2.0;
    float _1261 = -3.0;
    float _1262 = -4.0;
    _496 = _93(vec4(_1259, _1260, _1261, _1262));
    _498 = _325;
    _500 = uint(29);
    _676 = _498;
    _676[1u] += _500;
    _678 = _676[0u];
    _680 = _676[1u];
    _13._m0[_680] = floatBitsToUint(((_494.x + _494.y) + _496.x) + _496.w);
}

