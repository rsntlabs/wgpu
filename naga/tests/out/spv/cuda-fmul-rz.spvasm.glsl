#version 460
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _11_10
{
    uint _m0[];
} _10;

layout(set = 0, binding = 1, std430) buffer _14_13
{
    uint _m0[];
} _13;

uint _19(uint _17, uint _18)
{
    uint _48 = _17 & 2147483647u;
    uint _49 = _18 & 2147483647u;
    uint _51 = (_17 ^ _18) & 2147483648u;
    if ((_48 > 2139095040u) || (_49 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _59 = (_48 == 2139095040u) || (_49 == 2139095040u);
    bool _62 = (_48 == 0u) || (_49 == 0u);
    if (_59 && _62)
    {
        return 2143289344u;
    }
    if (_59)
    {
        return _51 | 2139095040u;
    }
    if (_62)
    {
        return _51;
    }
    uint _71 = _48 >> 23u;
    uint _72 = _49 >> 23u;
    bool _73 = _71 != 0u;
    bool _74 = _72 != 0u;
    uint _79 = (_48 & 8388607u) | (_73 ? 8388608u : 0u);
    uint _80 = (_49 & 8388607u) | (_74 ? 8388608u : 0u);
    uint _81 = _79 & 4095u;
    uint _82 = _80 & 4095u;
    uint _83 = _79 >> 12u;
    uint _84 = _80 >> 12u;
    uint _85 = _81 * _82;
    uint _90 = ((_81 * _84) + (_83 * _82)) + (_85 >> 12u);
    uint _93 = (_83 * _84) + (_90 >> 12u);
    uint _97 = (_85 & 4095u) | ((_90 & 4095u) << 12u);
    int _107 = int((_93 != 0u) ? (55u - (31u - uint(findMSB(_93)))) : (31u - (31u - uint(findMSB(_97 | 1u)))));
    int _112 = int(_73 ? _71 : 1u) + int(_74 ? _72 : 1u);
    int _114 = (_107 + _112) - 173;
    int _118 = max((_107 - 23), (151 - _112)) - 3;
    uint _130 = uint(min(max(_118, 0), 31)) & 31u;
    uint _152 = uint(min(max((_118 - 24), 0), 31)) & 31u;
    uint _173 = ((_118 <= 0) ? (((_93 << 24u) | _97) << (uint(min(max((0 - _118), 0), 31)) & 31u)) : ((_118 < 24) ? (((_93 << (uint(min(max((24 - _118), 0), 31)) & 31u)) | (_97 >> _130)) | uint((_97 & ((1u << _130) - 1u)) != 0u)) : ((_118 == 24) ? (_93 | uint(_97 != 0u)) : ((_118 < 48) ? ((_93 >> _152) | uint(((_93 & ((1u << _152) - 1u)) != 0u) || (_97 != 0u))) : uint((_93 | _97) != 0u))))) >> 3u;
    if (_114 >= 255)
    {
        return _51 | 2139095039u;
    }
    return _51 | ((((_173 >= 8388608u) ? uint(max(_114, 1)) : 0u) << 23u) | (_173 & 8388607u));
}

float _189(float _187, float _188)
{
    return uintBitsToFloat(_19(floatBitsToUint(_187), floatBitsToUint(_188)));
}

uint _213(uint _212)
{
    uint _216 = _212 & 2147483647u;
    return (_216 > 2139095040u) ? 2143289344u : _216;
}

int _199(bool _197, bool _198)
{
    int _203 = 0;
    if (_197)
    {
        _203 = 7;
    }
    else
    {
        _203 = 9;
    }
    return _203;
}

uint _222(uint _220, uint _221)
{
    uint _227 = _220 & 2147483647u;
    uint _228 = _221 & 2147483647u;
    uint _230 = (_220 ^ _221) & 2147483648u;
    if ((_227 > 2139095040u) || (_228 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _238 = (_227 == 2139095040u) || (_228 == 2139095040u);
    bool _241 = (_227 == 0u) || (_228 == 0u);
    if (_238 && _241)
    {
        return 2143289344u;
    }
    uint _245 = _230 | 2139095040u;
    if (_238)
    {
        return _245;
    }
    if (_241)
    {
        return _230;
    }
    uint _250 = _227 >> 23u;
    uint _251 = _228 >> 23u;
    bool _252 = _250 != 0u;
    bool _253 = _251 != 0u;
    uint _258 = (_227 & 8388607u) | (_252 ? 8388608u : 0u);
    uint _259 = (_228 & 8388607u) | (_253 ? 8388608u : 0u);
    uint _260 = _258 & 4095u;
    uint _261 = _259 & 4095u;
    uint _262 = _258 >> 12u;
    uint _263 = _259 >> 12u;
    uint _264 = _260 * _261;
    uint _269 = ((_260 * _263) + (_262 * _261)) + (_264 >> 12u);
    uint _272 = (_262 * _263) + (_269 >> 12u);
    uint _276 = (_264 & 4095u) | ((_269 & 4095u) << 12u);
    int _286 = int((_272 != 0u) ? (55u - (31u - uint(findMSB(_272)))) : (31u - (31u - uint(findMSB(_276 | 1u)))));
    int _291 = int(_252 ? _250 : 1u) + int(_253 ? _251 : 1u);
    int _297 = max((_286 - 23), (151 - _291)) - 3;
    uint _309 = uint(min(max(_297, 0), 31)) & 31u;
    uint _331 = uint(min(max((_297 - 24), 0), 31)) & 31u;
    uint _351 = (_297 <= 0) ? (((_272 << 24u) | _276) << (uint(min(max((0 - _297), 0), 31)) & 31u)) : ((_297 < 24) ? (((_272 << (uint(min(max((24 - _297), 0), 31)) & 31u)) | (_276 >> _309)) | uint((_276 & ((1u << _309) - 1u)) != 0u)) : ((_297 == 24) ? (_272 | uint(_276 != 0u)) : ((_297 < 48) ? ((_272 >> _331) | uint(((_272 & ((1u << _331) - 1u)) != 0u) || (_276 != 0u))) : uint((_272 | _276) != 0u))));
    uint _352 = _351 & 7u;
    uint _353 = _351 >> 3u;
    uint _361 = _353 + uint((_352 > 4u) || ((_352 == 4u) && ((_353 & 1u) != 0u)));
    bool _362 = _361 >= 16777216u;
    uint _364 = _362 ? (_361 >> 1u) : _361;
    int _366 = ((_286 + _291) - 173) + int(_362);
    if (_366 >= 255)
    {
        return _245;
    }
    return _230 | ((((_364 >= 8388608u) ? uint(max(_366, 1)) : 0u) << 23u) | (_364 & 8388607u));
}

uint _381(uint _379, uint _380)
{
    uint _383 = _379 & 2147483647u;
    uint _384 = _380 & 2147483647u;
    uint _386 = (_379 ^ _380) & 2147483648u;
    if ((_383 > 2139095040u) || (_384 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _394 = (_383 == 2139095040u) || (_384 == 2139095040u);
    bool _397 = (_383 == 0u) || (_384 == 0u);
    if (_394 && _397)
    {
        return 2143289344u;
    }
    uint _401 = _386 | 2139095040u;
    if (_394)
    {
        return _401;
    }
    if (_397)
    {
        return _386;
    }
    uint _406 = _383 >> 23u;
    uint _407 = _384 >> 23u;
    bool _408 = _406 != 0u;
    bool _409 = _407 != 0u;
    uint _414 = (_383 & 8388607u) | (_408 ? 8388608u : 0u);
    uint _415 = (_384 & 8388607u) | (_409 ? 8388608u : 0u);
    uint _416 = _414 & 4095u;
    uint _417 = _415 & 4095u;
    uint _418 = _414 >> 12u;
    uint _419 = _415 >> 12u;
    uint _420 = _416 * _417;
    uint _425 = ((_416 * _419) + (_418 * _417)) + (_420 >> 12u);
    uint _428 = (_418 * _419) + (_425 >> 12u);
    uint _432 = (_420 & 4095u) | ((_425 & 4095u) << 12u);
    int _442 = int((_428 != 0u) ? (55u - (31u - uint(findMSB(_428)))) : (31u - (31u - uint(findMSB(_432 | 1u)))));
    int _447 = int(_408 ? _406 : 1u) + int(_409 ? _407 : 1u);
    int _453 = max((_442 - 23), (151 - _447)) - 3;
    uint _465 = uint(min(max(_453, 0), 31)) & 31u;
    uint _487 = uint(min(max((_453 - 24), 0), 31)) & 31u;
    uint _507 = (_453 <= 0) ? (((_428 << 24u) | _432) << (uint(min(max((0 - _453), 0), 31)) & 31u)) : ((_453 < 24) ? (((_428 << (uint(min(max((24 - _453), 0), 31)) & 31u)) | (_432 >> _465)) | uint((_432 & ((1u << _465) - 1u)) != 0u)) : ((_453 == 24) ? (_428 | uint(_432 != 0u)) : ((_453 < 48) ? ((_428 >> _487) | uint(((_428 & ((1u << _487) - 1u)) != 0u) || (_432 != 0u))) : uint((_428 | _432) != 0u))));
    bool _508 = _386 != 0u;
    uint _514 = (_507 >> 3u) + uint(_508 && ((_507 & 7u) > 0u));
    bool _515 = _514 >= 16777216u;
    uint _517 = _515 ? (_514 >> 1u) : _514;
    int _519 = ((_442 + _447) - 173) + int(_515);
    if (_519 >= 255)
    {
        return _508 ? _401 : (_386 | 2139095039u);
    }
    return _386 | ((((_517 >= 8388608u) ? uint(max(_519, 1)) : 0u) << 23u) | (_517 & 8388607u));
}

uint _536(uint _534, uint _535)
{
    uint _538 = _534 & 2147483647u;
    uint _539 = _535 & 2147483647u;
    uint _541 = (_534 ^ _535) & 2147483648u;
    if ((_538 > 2139095040u) || (_539 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _549 = (_538 == 2139095040u) || (_539 == 2139095040u);
    bool _552 = (_538 == 0u) || (_539 == 0u);
    if (_549 && _552)
    {
        return 2143289344u;
    }
    uint _556 = _541 | 2139095040u;
    if (_549)
    {
        return _556;
    }
    if (_552)
    {
        return _541;
    }
    uint _561 = _538 >> 23u;
    uint _562 = _539 >> 23u;
    bool _563 = _561 != 0u;
    bool _564 = _562 != 0u;
    uint _569 = (_538 & 8388607u) | (_563 ? 8388608u : 0u);
    uint _570 = (_539 & 8388607u) | (_564 ? 8388608u : 0u);
    uint _571 = _569 & 4095u;
    uint _572 = _570 & 4095u;
    uint _573 = _569 >> 12u;
    uint _574 = _570 >> 12u;
    uint _575 = _571 * _572;
    uint _580 = ((_571 * _574) + (_573 * _572)) + (_575 >> 12u);
    uint _583 = (_573 * _574) + (_580 >> 12u);
    uint _587 = (_575 & 4095u) | ((_580 & 4095u) << 12u);
    int _597 = int((_583 != 0u) ? (55u - (31u - uint(findMSB(_583)))) : (31u - (31u - uint(findMSB(_587 | 1u)))));
    int _602 = int(_563 ? _561 : 1u) + int(_564 ? _562 : 1u);
    int _608 = max((_597 - 23), (151 - _602)) - 3;
    uint _620 = uint(min(max(_608, 0), 31)) & 31u;
    uint _642 = uint(min(max((_608 - 24), 0), 31)) & 31u;
    uint _662 = (_608 <= 0) ? (((_583 << 24u) | _587) << (uint(min(max((0 - _608), 0), 31)) & 31u)) : ((_608 < 24) ? (((_583 << (uint(min(max((24 - _608), 0), 31)) & 31u)) | (_587 >> _620)) | uint((_587 & ((1u << _620) - 1u)) != 0u)) : ((_608 == 24) ? (_583 | uint(_587 != 0u)) : ((_608 < 48) ? ((_583 >> _642) | uint(((_583 & ((1u << _642) - 1u)) != 0u) || (_587 != 0u))) : uint((_583 | _587) != 0u))));
    bool _663 = _541 == 0u;
    uint _669 = (_662 >> 3u) + uint(_663 && ((_662 & 7u) > 0u));
    bool _670 = _669 >= 16777216u;
    uint _672 = _670 ? (_669 >> 1u) : _669;
    int _674 = ((_597 + _602) - 173) + int(_670);
    if (_674 >= 255)
    {
        return _663 ? _556 : (_541 | 2139095039u);
    }
    return _541 | ((((_672 >= 8388608u) ? uint(max(_674, 1)) : 0u) << 23u) | (_672 & 8388607u));
}

void main()
{
    vec2 _848 = vec2(0.0);
    vec2 _836 = vec2(0.0);
    vec2 _824 = vec2(0.0);
    vec2 _812 = vec2(0.0);
    vec2 _800 = vec2(0.0);
    vec2 _788 = vec2(0.0);
    uint _775 = 0u;
    uint _763 = 0u;
    uint _751 = 0u;
    uint _738 = 0u;
    uint _725 = 0u;
    vec2 _838 = vec2(0.0);
    vec2 _826 = vec2(0.0);
    vec2 _814 = vec2(0.0);
    vec2 _802 = vec2(0.0);
    vec2 _790 = vec2(0.0);
    vec2 _777 = vec2(0.0);
    uint _765 = 0u;
    uint _753 = 0u;
    bool _740 = false;
    uint _728 = 0u;
    vec2 _840 = vec2(0.0);
    uint _828 = 0u;
    uint _816 = 0u;
    uint _804 = 0u;
    uint _792 = 0u;
    uint _780 = 0u;
    uint _767 = 0u;
    uint _755 = 0u;
    bool _743 = false;
    uint _730 = 0u;
    vec2 _842 = vec2(0.0);
    uint _830 = 0u;
    uint _818 = 0u;
    uint _806 = 0u;
    uint _794 = 0u;
    vec2 _782 = vec2(0.0);
    uint _769 = 0u;
    uint _757 = 0u;
    uint _745 = 0u;
    int _732 = 0;
    vec2 _844 = vec2(0.0);
    uint _832 = 0u;
    uint _820 = 0u;
    uint _808 = 0u;
    uint _796 = 0u;
    uint _784 = 0u;
    uint _771 = 0u;
    int _759 = 0;
    uint _747 = 0u;
    uint _734 = 0u;
    vec2 _846 = vec2(0.0);
    vec2 _834 = vec2(0.0);
    vec2 _822 = vec2(0.0);
    vec2 _810 = vec2(0.0);
    vec2 _798 = vec2(0.0);
    vec2 _786 = vec2(0.0);
    uint _773 = 0u;
    uint _761 = 0u;
    uint _749 = 0u;
    uint _736 = 0u;
    uint _854 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_854 >= 4096u)
    {
        return;
    }
    uint _859 = 4u + (_854 * 26u);
    _725 = _854 * 2u;
    uint _864 = _10._m0[_725];
    float _865 = uintBitsToFloat(_864);
    _728 = (_854 * 2u) + 1u;
    uint _870 = _10._m0[_728];
    float _871 = uintBitsToFloat(_870);
    _13._m0[_859] = floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_865), floatBitsToUint(_871))));
    _730 = _859 + 1u;
    _13._m0[_730] = floatBitsToUint(_189(_865, _871));
    _732 = 0;
    int _884 = _732;
    _732 = _884 + 1;
    _736 = (_854 * 2u) + uint(_884);
    int _893 = _732;
    _732 = _893 + 1;
    _738 = (_854 * 2u) + uint(_893);
    _734 = _859 + 2u;
    _13._m0[_734] = floatBitsToUint(_189(uintBitsToFloat(_10._m0[_736]), uintBitsToFloat(_10._m0[_738])));
    _740 = false;
    if (false)
    {
        int _908 = _732;
        _732 = _908 + 1;
        _740 = _213(floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(float(_908)), floatBitsToUint(_865))))) != 0u;
    }
    _743 = true;
    if (!true)
    {
        int _920 = _732;
        _732 = _920 + 1;
        _743 = _213(floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_865), floatBitsToUint(float(_920)))))) != 0u;
    }
    _745 = _859 + 3u;
    _13._m0[_745] = uint(_732);
    float _935 = -0.0;
    float _936 = -0.0;
    _747 = _859 + 4u;
    _13._m0[_747] = floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_935), floatBitsToUint(_936))));
    float _945 = -0.0;
    _749 = _859 + 5u;
    _13._m0[_749] = floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_945), floatBitsToUint(0.0))));
    float _954 = float(2);
    float _955 = float(3u);
    _751 = _859 + 6u;
    _13._m0[_751] = floatBitsToUint(_189(_954, _955));
    _753 = _859 + 7u;
    _13._m0[_753] = uint(_199(true, false));
    _755 = _859 + 8u;
    _13._m0[_755] = floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_871), floatBitsToUint(_865))));
    _757 = _859 + 9u;
    _13._m0[_757] = floatBitsToUint(uintBitsToFloat(_222(floatBitsToUint(_865), floatBitsToUint(_871))));
    _759 = 0;
    int _983 = _759;
    _759 = _983 + 1;
    _763 = (_854 * 2u) + uint(_983);
    int _992 = _759;
    _759 = _992 + 1;
    _765 = (_854 * 2u) + uint(_992);
    _761 = _859 + 10u;
    _13._m0[_761] = floatBitsToUint(uintBitsToFloat(_381(floatBitsToUint(uintBitsToFloat(_10._m0[_763])), floatBitsToUint(uintBitsToFloat(_10._m0[_765])))));
    _767 = _859 + 11u;
    _13._m0[_767] = uint(_759);
    _759 = 0;
    int _1014 = _759;
    _759 = _1014 + 1;
    _771 = (_854 * 2u) + uint(_1014);
    int _1023 = _759;
    _759 = _1023 + 1;
    _773 = (_854 * 2u) + uint(_1023);
    _769 = _859 + 12u;
    _13._m0[_769] = floatBitsToUint(uintBitsToFloat(_536(floatBitsToUint(uintBitsToFloat(_10._m0[_771])), floatBitsToUint(uintBitsToFloat(_10._m0[_773])))));
    _775 = _859 + 13u;
    _13._m0[_775] = uint(_759);
    uint _1044 = _854 ^ 1u;
    _780 = _1044 * 2u;
    _777 = vec2(_865, uintBitsToFloat(_10._m0[_780]));
    _784 = (_1044 * 2u) + 1u;
    _782 = vec2(_871, uintBitsToFloat(_10._m0[_784]));
    _759 = 0;
    _834 = vec2(0.0);
    _834 = _777;
    _759++;
    _788 = _834;
    _836 = vec2(0.0);
    _836 = _782;
    _759++;
    _790 = _836;
    _786 = vec2(uintBitsToFloat(_222(floatBitsToUint(_788.x), floatBitsToUint(_790.x))), uintBitsToFloat(_222(floatBitsToUint(_788.y), floatBitsToUint(_790.y))));
    _792 = _859 + 14u;
    _13._m0[_792] = floatBitsToUint(_786.x);
    _794 = _859 + 15u;
    _13._m0[_794] = floatBitsToUint(_786.y);
    _796 = _859 + 16u;
    _13._m0[_796] = uint(_759);
    _759 = 0;
    _838 = vec2(0.0);
    _838 = _777;
    _759++;
    _800 = _838;
    _840 = vec2(0.0);
    _840 = _782;
    _759++;
    _802 = _840;
    _798 = vec2(uintBitsToFloat(_19(floatBitsToUint(_800.x), floatBitsToUint(_802.x))), uintBitsToFloat(_19(floatBitsToUint(_800.y), floatBitsToUint(_802.y))));
    _804 = _859 + 17u;
    _13._m0[_804] = floatBitsToUint(_798.x);
    _806 = _859 + 18u;
    _13._m0[_806] = floatBitsToUint(_798.y);
    _808 = _859 + 19u;
    _13._m0[_808] = uint(_759);
    _759 = 0;
    _842 = vec2(0.0);
    _842 = _777;
    _759++;
    _812 = _842;
    _844 = vec2(0.0);
    _844 = _782;
    _759++;
    _814 = _844;
    _810 = vec2(uintBitsToFloat(_381(floatBitsToUint(_812.x), floatBitsToUint(_814.x))), uintBitsToFloat(_381(floatBitsToUint(_812.y), floatBitsToUint(_814.y))));
    _816 = _859 + 20u;
    _13._m0[_816] = floatBitsToUint(_810.x);
    _818 = _859 + 21u;
    _13._m0[_818] = floatBitsToUint(_810.y);
    _820 = _859 + 22u;
    _13._m0[_820] = uint(_759);
    _759 = 0;
    _846 = vec2(0.0);
    _846 = _777;
    _759++;
    _824 = _846;
    _848 = vec2(0.0);
    _848 = _782;
    _759++;
    _826 = _848;
    _822 = vec2(uintBitsToFloat(_536(floatBitsToUint(_824.x), floatBitsToUint(_826.x))), uintBitsToFloat(_536(floatBitsToUint(_824.y), floatBitsToUint(_826.y))));
    _828 = _859 + 23u;
    _13._m0[_828] = floatBitsToUint(_822.x);
    _830 = _859 + 24u;
    _13._m0[_830] = floatBitsToUint(_822.y);
    _832 = _859 + 25u;
    _13._m0[_832] = uint(_759);
}

