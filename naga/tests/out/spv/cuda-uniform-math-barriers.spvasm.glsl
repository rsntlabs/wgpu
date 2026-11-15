#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _5
{
    float _m0;
};

layout(set = 0, binding = 0, std140) uniform _23_22
{
    _5 _m0;
} _22;

layout(set = 0, binding = 1, std430) buffer _26_25
{
    uint _m0[];
} _25;

shared uint _28[4];

uint _32(uint _31)
{
    uint _46 = _31 & 2147483647u;
    uint _47 = _31 & 2147483648u;
    uint _53 = 1u << ((150u - (_46 >> 23u)) & 31u);
    uint _54 = _53 - 1u;
    uint _58 = _31 & (~_54);
    return (_46 > 2139095040u) ? 2143289344u : ((_46 >= 1258291200u) ? _31 : ((_46 < 1065353216u) ? ((_46 == 0u) ? _31 : (_47 | ((_47 >> 31u) * 1065353216u))) : (((_47 != 0u) && ((_31 & _54) != 0u)) ? (_58 + _53) : _58)));
}

uint _75(uint _74)
{
    uint _77 = _74 & 2147483647u;
    uint _78 = _74 & 2147483648u;
    uint _82 = 1u << ((150u - (_77 >> 23u)) & 31u);
    uint _83 = _82 - 1u;
    uint _87 = _74 & (~_83);
    return (_77 > 2139095040u) ? 2143289344u : ((_77 >= 1258291200u) ? _74 : ((_77 < 1065353216u) ? ((_77 == 0u) ? _74 : (_78 | ((1u - (_78 >> 31u)) * 1065353216u))) : (((_78 == 0u) && ((_74 & _83) != 0u)) ? (_87 + _82) : _87)));
}

uint _106(uint _105)
{
    uint _109 = _105 & 2147483647u;
    uint _110 = _105 & 2147483648u;
    uint _114 = 1u << ((150u - (_109 >> 23u)) & 31u);
    uint _115 = _114 - 1u;
    uint _116 = _105 & _115;
    uint _119 = _105 & (~_115);
    return (_109 > 2139095040u) ? 2143289344u : ((_109 >= 1258291200u) ? _105 : ((_109 < 1065353216u) ? ((_109 == 0u) ? _105 : ((_109 >= 1056964608u) ? (_110 | 1065353216u) : _110)) : (((_116 >= (_114 >> 1u)) && (_116 != 0u)) ? (_119 + _114) : _119)));
}

uint _138(uint _137)
{
    uint _140 = _137 & 2147483647u;
    return (_140 > 2139095040u) ? 2143289344u : _140;
}

uint _145(uint _144)
{
    uint _164 = 0u;
    uint _158 = 0u;
    uint _162 = 0u;
    uint _155 = 0u;
    uint _166 = 0u;
    uint _160 = 0u;
    uvec2 _212 = uvec2(4294967295u);
    uint _171 = _144 & 2147483647u;
    if ((_171 == 0u) || (_144 == 2139095040u))
    {
        return _144;
    }
    if (((_144 & 2147483648u) != 0u) || (_171 > 2139095040u))
    {
        return 2143289344u;
    }
    uint _183 = _144 & 8388607u;
    uint _184 = _171 >> 23u;
    _155 = _183 | 8388608u;
    _158 = _184 + 127u;
    if (_184 == 0u)
    {
        uint _192 = (31u - uint(findMSB(_183))) - 8u;
        _155 = _183 << _192;
        _158 = 128u - _192;
    }
    uint _197 = _158 & 1u;
    _160 = _155 >> (9u - _197);
    _162 = _155 << (23u + _197);
    _164 = 0u;
    _166 = 0u;
    uint _168 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _212)))
        {
            break;
        }
        _212 -= uvec2(uint(_212.y == 0u), 1u);
        if (_168 >= 24u)
        {
            break;
        }
        uint _227 = _160;
        uint _230 = _166;
        uint _238 = (_230 << 2u) | (_227 >> 14u);
        uint _240 = (_164 << 2u) | 1u;
        bool _241 = _238 >= _240;
        uint _244 = _164 << 1u;
        _160 = ((_227 << 2u) | (_162 >> 30u)) & 65535u;
        _162 = _162 << 2u;
        _166 = _241 ? (_238 - _240) : _238;
        _164 = _241 ? (_244 | 1u) : _244;
        _168++;
        continue;
    }
    return ((_158 >> 1u) << 23u) | (((_166 > _164) ? (_164 + 1u) : _164) & 8388607u);
}

uint _261(uint _259, uint _260)
{
    uint _275 = 0u;
    int _268 = 0;
    int _273 = 0;
    uint _266 = 0u;
    uint _277 = 0u;
    uint _271 = 0u;
    uvec2 _354 = uvec2(4294967295u);
    uint _282 = _259 & 2147483647u;
    uint _283 = _260 & 2147483647u;
    uint _285 = (_259 ^ _260) & 2147483648u;
    uint _286 = _285 | 2139095040u;
    bool _290 = _282 == 0u;
    bool _291 = _283 == 0u;
    bool _293 = _282 == 2139095040u;
    bool _294 = _283 == 2139095040u;
    if ((((_282 > 2139095040u) || (_283 > 2139095040u)) || (_290 && _291)) || (_293 && _294))
    {
        return 2143289344u;
    }
    if (_293 || _291)
    {
        return _286;
    }
    if (_290 || _294)
    {
        return _285;
    }
    uint _306 = _282 & 8388607u;
    uint _307 = _282 >> 23u;
    _266 = _306 | 8388608u;
    _268 = int(_307) - 127;
    if (_307 == 0u)
    {
        uint _316 = (31u - uint(findMSB(_306))) - 8u;
        _266 = _306 << _316;
        _268 = (-126) - int(_316);
    }
    uint _322 = _283 & 8388607u;
    uint _323 = _283 >> 23u;
    _271 = _322 | 8388608u;
    _273 = int(_323) - 127;
    if (_323 == 0u)
    {
        uint _332 = (31u - uint(findMSB(_322))) - 8u;
        _271 = _322 << _332;
        _273 = (-126) - int(_332);
    }
    bool _338 = _266 < _271;
    int _345 = (_268 - _273) - int(_338);
    if (_345 < (-150))
    {
        return _285;
    }
    _275 = 1u;
    _277 = (_338 ? (_266 << 1u) : _266) - _271;
    uint _279 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _354)))
        {
            break;
        }
        _354 -= uvec2(uint(_354.y == 0u), 1u);
        if (_279 >= 23u)
        {
            break;
        }
        uint _369 = _277;
        uint _371 = _369 << 1u;
        bool _372 = _371 >= _271;
        _277 = _372 ? (_371 - _271) : _371;
        _275 = (_275 << 1u) | uint(_372);
        _279++;
        continue;
    }
    if (_345 < (-126))
    {
        uint _387 = uint((-126) - _345) & 31u;
        uint _388 = 1u << _387;
        uint _390 = _275 & (_388 - 1u);
        uint _391 = _388 >> 1u;
        uint _392 = _275 >> _387;
        return _285 | (_392 + uint((_390 > _391) || ((_390 == _391) && ((_277 != 0u) || ((_392 & 1u) != 0u)))));
    }
    uint _404 = _277 << 1u;
    uint _412 = _275 + uint((_404 > _271) || ((_404 == _271) && ((_275 & 1u) != 0u)));
    uint _413 = _412 >> 24u;
    int _416 = _345 + int(_413);
    if (_416 > 127)
    {
        return _286;
    }
    return _285 | ((uint(_416 + 127) << 23u) | ((_412 >> _413) & 8388607u));
}

uint _429(uint _427, uint _428)
{
    uint _438 = 0u;
    int _432 = 0;
    int _436 = 0;
    uint _430 = 0u;
    uint _440 = 0u;
    uint _434 = 0u;
    uvec2 _497 = uvec2(4294967295u);
    uint _443 = _427 & 2147483647u;
    uint _444 = _428 & 2147483647u;
    uint _445 = _427 & 2147483648u;
    if ((_443 >= 2139095040u) || ((_444 > 2139095040u) || (_444 == 0u)))
    {
        return 2143289344u;
    }
    if (_443 < _444)
    {
        return _427;
    }
    if (_443 == _444)
    {
        return _445;
    }
    uint _459 = _443 & 8388607u;
    uint _460 = _443 >> 23u;
    _430 = _459 | 8388608u;
    _432 = int(_460) - 127;
    if (_460 == 0u)
    {
        uint _469 = (31u - uint(findMSB(_459))) - 8u;
        _430 = _459 << _469;
        _432 = (-126) - int(_469);
    }
    uint _475 = _444 & 8388607u;
    uint _476 = _444 >> 23u;
    _434 = _475 | 8388608u;
    _436 = int(_476) - 127;
    if (_476 == 0u)
    {
        uint _485 = (31u - uint(findMSB(_475))) - 8u;
        _434 = _475 << _485;
        _436 = (-126) - int(_485);
    }
    _438 = _430;
    _440 = uint(_432 - _436);
    for (;;)
    {
        if (all(equal(uvec2(0u), _497)))
        {
            break;
        }
        _497 -= uvec2(uint(_497.y == 0u), 1u);
        if (_440 == 0u)
        {
            break;
        }
        _438 = ((_438 >= _434) ? (_438 - _434) : _438) << 1u;
        _440--;
        continue;
    }
    uint _521 = (_438 >= _434) ? (_438 - _434) : _438;
    if (_521 == 0u)
    {
        return _445;
    }
    uint _527 = (31u - uint(findMSB(_521))) - 8u;
    uint _528 = _521 << _527;
    int _530 = _436 - int(_527);
    return _445 | ((_530 >= (-126)) ? ((uint(_530 + 127) << 23u) | (_528 & 8388607u)) : (_528 >> (uint((-126) - _530) & 31u)));
}

uint[22] _652(uint _650[2], uint _651[20])
{
    uint _666[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _663 = 0u;
    uint _657[2] = uint[](0u, 0u);
    uint _659[20] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _661[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _673 = uvec2(4294967295u);
    uvec2 _694 = uvec2(4294967295u);
    uvec2 _732 = uvec2(4294967295u);
    _657 = _650;
    _659 = _651;
    uint _664 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _673)))
        {
            break;
        }
        _673 -= uvec2(uint(_673.y == 0u), 1u);
        if (_664 >= 2u)
        {
            break;
        }
        _663 = 0u;
        uint _665 = 0u;
        for (;;)
        {
            if (all(equal(uvec2(0u), _694)))
            {
                break;
            }
            _694 -= uvec2(uint(_694.y == 0u), 1u);
            if (_665 >= 20u)
            {
                break;
            }
            uint _711 = _664 + _665;
            uint _713 = _661[_711];
            uint _717 = ((_657[_664] * _659[_665]) + _713) + _663;
            _661[_711] = _717 & 65535u;
            _663 = _717 >> 16u;
            _665++;
            continue;
        }
        _661[_664 + 20u] = _663;
        _664++;
        continue;
    }
    uint _667 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _732)))
        {
            break;
        }
        _732 -= uvec2(uint(_732.y == 0u), 1u);
        if (_667 >= 22u)
        {
            break;
        }
        _666[_667] = _661[_667 + 0u];
        _667++;
        continue;
    }
    return _666;
}

uint _754(uint _755, uint _756)
{
    return _755 / ((_756 == 0u) ? 1u : _756);
}

uint _761(uint _762, uint _763)
{
    return _762 % ((_763 == 0u) ? 1u : _763);
}

uint _862(uint _860[22], uint _861)
{
    uint _864[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _865 = 0u;
    uint _866 = 0u;
    _864 = _860;
    uint _868 = _754(_861, 16u);
    uint _869 = _761(_861, 16u);
    uint _870 = _868 + 0u;
    if (_870 < 22u)
    {
        _865 = _864[_870];
    }
    uint _876 = _868 + 1u;
    if (_876 < 22u)
    {
        _866 = _864[_876];
    }
    return ((_865 >> _869) | (_866 << (16u - _869))) & 65535u;
}

uint[12] _813(uint _810[12], uint _811[12], uint _812)
{
    uint _816[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _818 = 0u;
    uint _815[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _817[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _826 = uvec2(4294967295u);
    _815 = _810;
    _816 = _811;
    bool _821 = _812 != 0u;
    uint _819 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _826)))
        {
            break;
        }
        _826 -= uvec2(uint(_826.y == 0u), 1u);
        if (_819 >= 12u)
        {
            break;
        }
        uint _846 = _816[_819] + _818;
        uint _848 = _815[_819] + _846;
        _817[_819] = (_821 ? (_815[_819] - _846) : _848) & 65535u;
        _818 = _821 ? uint(_815[_819] < _846) : (_848 >> 16u);
        _819++;
        continue;
    }
    return _817;
}

uint[12] _546(uint _544[12], uint _545[12])
{
    uint _561[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _558 = 0u;
    uint _553[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _555[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _556[24] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _568 = uvec2(4294967295u);
    uvec2 _589 = uvec2(4294967295u);
    uvec2 _627 = uvec2(4294967295u);
    _553 = _544;
    _555 = _545;
    uint _559 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _568)))
        {
            break;
        }
        _568 -= uvec2(uint(_568.y == 0u), 1u);
        if (_559 >= 12u)
        {
            break;
        }
        _558 = 0u;
        uint _560 = 0u;
        for (;;)
        {
            if (all(equal(uvec2(0u), _589)))
            {
                break;
            }
            _589 -= uvec2(uint(_589.y == 0u), 1u);
            if (_560 >= 12u)
            {
                break;
            }
            uint _606 = _559 + _560;
            uint _608 = _556[_606];
            uint _612 = ((_553[_559] * _555[_560]) + _608) + _558;
            _556[_606] = _612 & 65535u;
            _558 = _612 >> 16u;
            _560++;
            continue;
        }
        _556[_559 + 12u] = _558;
        _559++;
        continue;
    }
    uint _562 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _627)))
        {
            break;
        }
        _627 -= uvec2(uint(_627.y == 0u), 1u);
        if (_562 >= 12u)
        {
            break;
        }
        _561[_562] = _556[_562 + 11u];
        _562++;
        continue;
    }
    return _561;
}

uint[12] _771(uint _769[12], uint _770)
{
    uint _774[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _773[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _775 = 0u;
    uvec2 _782 = uvec2(4294967295u);
    _773 = _769;
    uint _776 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _782)))
        {
            break;
        }
        _782 -= uvec2(uint(_782.y == 0u), 1u);
        if (_776 >= 12u)
        {
            break;
        }
        uint _797 = 11u - _776;
        uint _802 = (_775 << 16u) | _773[_797];
        _774[_797] = _754(_802, _770);
        _775 = _761(_802, _770);
        _776++;
        continue;
    }
    return _774;
}

uint[12] _922(uint _920[12], uint _921)
{
    uint _924[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _925[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _938 = uvec2(4294967295u);
    bool _928 = _921 != 0u;
    if (_928)
    {
        _924 = _920;
    }
    else
    {
        _924 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u);
    }
    _925 = _924;
    uint _933[12] = _546(_920, _920);
    uint _926 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _938)))
        {
            break;
        }
        _938 -= uvec2(uint(_938.y == 0u), 1u);
        if (_926 >= 8u)
        {
            break;
        }
        uint _953 = _926 + 1u;
        uint _954 = _953 * 2u;
        uint _961[12] = _771(_546(_924, _933), _954 * (_928 ? (_954 + 1u) : (_954 - 1u)));
        _924 = _961;
        _925 = _813(_925, _961, _953 & 1u);
        _926++;
        continue;
    }
    return _925;
}

uint _892(uint _890[12], uint _891)
{
    uint _894[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _895 = 0u;
    uint _896 = 0u;
    _894 = _890;
    uint _898 = _754(_891, 16u);
    uint _899 = _761(_891, 16u);
    uint _900 = _898 + 0u;
    if (_900 < 12u)
    {
        _895 = _894[_900];
    }
    uint _906 = _898 + 1u;
    if (_906 < 12u)
    {
        _896 = _894[_906];
    }
    return ((_895 >> _899) | (_896 << (16u - _899))) & 65535u;
}

uint _970(uint _969[12])
{
    uint _980 = 0u;
    uint _977 = 0u;
    uint _976[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _978 = 0u;
    uvec2 _987 = uvec2(4294967295u);
    uvec2 _1041 = uvec2(4294967295u);
    _976 = _969;
    uint _979 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _987)))
        {
            break;
        }
        _987 -= uvec2(uint(_987.y == 0u), 1u);
        if (_979 >= 12u)
        {
            break;
        }
        _978 |= _976[_979];
        if (_976[_979] != 0u)
        {
            _977 = (_979 * 16u) + (31u - (31u - uint(findMSB(_976[_979]))));
        }
        _979++;
        continue;
    }
    if (_978 == 0u)
    {
        return 0u;
    }
    uint _1023 = (_977 >= 50u) ? (_977 - 23u) : 27u;
    uint _1028 = _892(_969, _1023) | (_892(_969, _1023 + 16u) << 16u);
    uint _1029 = _1023 - 1u;
    uint _1033 = _754(_1029, 16u);
    uint _1036 = (1u << _761(_1029, 16u)) - 1u;
    uint _981 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _1041)))
        {
            break;
        }
        _1041 -= uvec2(uint(_1041.y == 0u), 1u);
        if (_981 >= 12u)
        {
            break;
        }
        _980 |= (_976[_981] & ((_981 < _1033) ? 65535u : ((_981 == _1033) ? _1036 : 0u)));
        _981++;
        continue;
    }
    uint _1073 = _1028 + uint(((_892(_969, _1029) & 1u) != 0u) && ((_980 | (_1028 & 1u)) != 0u));
    if (_977 < 50u)
    {
        return _1073;
    }
    bool _1077 = _1073 == 16777216u;
    uint _1080 = _977 - 49u;
    return ((_1077 ? (_1080 + 1u) : _1080) << 23u) | ((_1077 ? (_1073 >> 1u) : _1073) & 8388607u);
}

uint _1089(uint _1087, uint _1088)
{
    uint _1129 = 0u;
    uint _1130[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _1160 = uvec2(4294967295u);
    uint _1133 = _1087 & 2147483647u;
    if (_1133 >= 2139095040u)
    {
        return 2143289344u;
    }
    bool _1137 = _1088 != 0u;
    if (_1133 <= 956301312u)
    {
        return (_1088 * 1065353216u) | ((1u - _1088) * _1087);
    }
    uint _1146 = 470u - (_1133 >> 23u);
    uint _1148 = (_1133 & 8388607u) | 8388608u;
    uint _1152[22] = _652(uint[](_1148 & 65535u, _1148 >> 16u), uint[](53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    _1129 = _862(_1152, _1146) & 3u;
    uint _1155 = _1146 - 176u;
    uint _1131 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _1160)))
        {
            break;
        }
        _1160 -= uvec2(uint(_1160.y == 0u), 1u);
        if (_1131 >= 11u)
        {
            break;
        }
        _1130[_1131] = _862(_1152, _1155 + (_1131 * 16u));
        _1131++;
        continue;
    }
    uint _1182 = _1130[10u];
    bool _1183 = _1182 >= 32768u;
    if (_1183)
    {
        _1129 = (_1129 + 1u) & 3u;
        _1130 = _813(uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u), _1130, 1u);
    }
    bool _1195 = (_1129 & 1u) == _1088;
    return _970(_922(_546(_1130, uint[](5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u)), uint(_1195))) | ((((_1183 && _1195) ? 2147483648u : 0u) ^ (((_1137 ? (_1129 + 1u) : _1129) & 2u) << 30u)) ^ (_1137 ? 0u : (_1087 & 2147483648u)));
}

void main()
{
    uint _1228 = 0u;
    uint _1230 = 0u;
    uint _1232 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _28 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    _28[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 1u;
    _1228 = 1u;
    _1228 = 0u;
    if (uintBitsToFloat(_32(floatBitsToUint(_22._m0._m0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1228 |= 1u;
    }
    if (uintBitsToFloat(_75(floatBitsToUint(_22._m0._m0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1228 |= 2u;
    }
    if (uintBitsToFloat(_106(floatBitsToUint(_22._m0._m0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1228 |= 4u;
    }
    if (uintBitsToFloat(_138(floatBitsToUint(_22._m0._m0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1228 |= 8u;
    }
    if (uintBitsToFloat(_145(floatBitsToUint(_22._m0._m0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1228 |= 16u;
    }
    if (uintBitsToFloat(_261(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_145(floatBitsToUint(_22._m0._m0)))))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1228 |= 32u;
    }
    if (uintBitsToFloat(_429(floatBitsToUint(_22._m0._m0), floatBitsToUint(2.0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1228 |= 64u;
    }
    if (uintBitsToFloat(_261(floatBitsToUint(_22._m0._m0), floatBitsToUint(2.0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1228 |= 128u;
    }
    if (uintBitsToFloat(_1089(floatBitsToUint(_22._m0._m0), 0u)) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1228 |= 256u;
    }
    if (uintBitsToFloat(_1089(floatBitsToUint(_22._m0._m0), 1u)) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1228 |= 512u;
    }
    _1230 = 4u + (gl_LocalInvocationID.x * 2u);
    _25._m0[_1230] = _28[(gl_LocalInvocationID.x + 1u) & 3u];
    _1232 = 5u + (gl_LocalInvocationID.x * 2u);
    _25._m0[_1232] = _1228;
}

