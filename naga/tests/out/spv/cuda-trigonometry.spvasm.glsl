#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _21_20
{
    uint _m0[];
} _20;

uint[22] _142(uint _140[2], uint _141[20])
{
    uint _156[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _153 = 0u;
    uint _147[2] = uint[](0u, 0u);
    uint _149[20] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _151[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _163 = uvec2(4294967295u);
    uvec2 _184 = uvec2(4294967295u);
    uvec2 _222 = uvec2(4294967295u);
    _147 = _140;
    _149 = _141;
    uint _154 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _163)))
        {
            break;
        }
        _163 -= uvec2(uint(_163.y == 0u), 1u);
        if (_154 >= 2u)
        {
            break;
        }
        _153 = 0u;
        uint _155 = 0u;
        for (;;)
        {
            if (all(equal(uvec2(0u), _184)))
            {
                break;
            }
            _184 -= uvec2(uint(_184.y == 0u), 1u);
            if (_155 >= 20u)
            {
                break;
            }
            uint _201 = _154 + _155;
            uint _203 = _151[_201];
            uint _207 = ((_147[_154] * _149[_155]) + _203) + _153;
            _151[_201] = _207 & 65535u;
            _153 = _207 >> 16u;
            _155++;
            continue;
        }
        _151[_154 + 20u] = _153;
        _154++;
        continue;
    }
    uint _157 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _222)))
        {
            break;
        }
        _222 -= uvec2(uint(_222.y == 0u), 1u);
        if (_157 >= 22u)
        {
            break;
        }
        _156[_157] = _151[_157 + 0u];
        _157++;
        continue;
    }
    return _156;
}

uint _244(uint _246, uint _247)
{
    return _246 / ((_247 == 0u) ? 1u : _247);
}

uint _252(uint _253, uint _254)
{
    return _253 % ((_254 == 0u) ? 1u : _254);
}

uint _353(uint _351[22], uint _352)
{
    uint _355[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _356 = 0u;
    uint _357 = 0u;
    _355 = _351;
    uint _359 = _244(_352, 16u);
    uint _360 = _252(_352, 16u);
    uint _361 = _359 + 0u;
    if (_361 < 22u)
    {
        _356 = _355[_361];
    }
    uint _367 = _359 + 1u;
    if (_367 < 22u)
    {
        _357 = _355[_367];
    }
    return ((_356 >> _360) | (_357 << (16u - _360))) & 65535u;
}

uint[12] _304(uint _301[12], uint _302[12], uint _303)
{
    uint _307[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _309 = 0u;
    uint _306[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _308[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _317 = uvec2(4294967295u);
    _306 = _301;
    _307 = _302;
    bool _312 = _303 != 0u;
    uint _310 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _317)))
        {
            break;
        }
        _317 -= uvec2(uint(_317.y == 0u), 1u);
        if (_310 >= 12u)
        {
            break;
        }
        uint _337 = _307[_310] + _309;
        uint _339 = _306[_310] + _337;
        _308[_310] = (_312 ? (_306[_310] - _337) : _339) & 65535u;
        _309 = _312 ? uint(_306[_310] < _337) : (_339 >> 16u);
        _310++;
        continue;
    }
    return _308;
}

uint[12] _26(uint _24[12], uint _25[12])
{
    uint _45[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _41 = 0u;
    uint _36[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _38[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _39[24] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _58 = uvec2(4294967295u);
    uvec2 _79 = uvec2(4294967295u);
    uvec2 _117 = uvec2(4294967295u);
    _36 = _24;
    _38 = _25;
    uint _43 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _58)))
        {
            break;
        }
        _58 -= uvec2(uint(_58.y == 0u), 1u);
        if (_43 >= 12u)
        {
            break;
        }
        _41 = 0u;
        uint _44 = 0u;
        for (;;)
        {
            if (all(equal(uvec2(0u), _79)))
            {
                break;
            }
            _79 -= uvec2(uint(_79.y == 0u), 1u);
            if (_44 >= 12u)
            {
                break;
            }
            uint _96 = _43 + _44;
            uint _98 = _39[_96];
            uint _102 = ((_36[_43] * _38[_44]) + _98) + _41;
            _39[_96] = _102 & 65535u;
            _41 = _102 >> 16u;
            _44++;
            continue;
        }
        _39[_43 + 12u] = _41;
        _43++;
        continue;
    }
    uint _46 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _117)))
        {
            break;
        }
        _117 -= uvec2(uint(_117.y == 0u), 1u);
        if (_46 >= 12u)
        {
            break;
        }
        _45[_46] = _39[_46 + 11u];
        _46++;
        continue;
    }
    return _45;
}

uint[12] _262(uint _260[12], uint _261)
{
    uint _265[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _264[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _266 = 0u;
    uvec2 _273 = uvec2(4294967295u);
    _264 = _260;
    uint _267 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _273)))
        {
            break;
        }
        _273 -= uvec2(uint(_273.y == 0u), 1u);
        if (_267 >= 12u)
        {
            break;
        }
        uint _288 = 11u - _267;
        uint _293 = (_266 << 16u) | _264[_288];
        _265[_288] = _244(_293, _261);
        _266 = _252(_293, _261);
        _267++;
        continue;
    }
    return _265;
}

uint[12] _413(uint _411[12], uint _412)
{
    uint _416[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _417[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _430 = uvec2(4294967295u);
    bool _420 = _412 != 0u;
    if (_420)
    {
        _416 = _411;
    }
    else
    {
        _416 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u);
    }
    _417 = _416;
    uint _425[12] = _26(_411, _411);
    uint _418 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _430)))
        {
            break;
        }
        _430 -= uvec2(uint(_430.y == 0u), 1u);
        if (_418 >= 8u)
        {
            break;
        }
        uint _445 = _418 + 1u;
        uint _446 = _445 * 2u;
        uint _453[12] = _262(_26(_416, _425), _446 * (_420 ? (_446 + 1u) : (_446 - 1u)));
        _416 = _453;
        _417 = _304(_417, _453, _445 & 1u);
        _418++;
        continue;
    }
    return _417;
}

uint _383(uint _381[12], uint _382)
{
    uint _385[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _386 = 0u;
    uint _387 = 0u;
    _385 = _381;
    uint _389 = _244(_382, 16u);
    uint _390 = _252(_382, 16u);
    uint _391 = _389 + 0u;
    if (_391 < 12u)
    {
        _386 = _385[_391];
    }
    uint _397 = _389 + 1u;
    if (_397 < 12u)
    {
        _387 = _385[_397];
    }
    return ((_386 >> _390) | (_387 << (16u - _390))) & 65535u;
}

uint _462(uint _461[12])
{
    uint _475 = 0u;
    uint _472 = 0u;
    uint _471[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _473 = 0u;
    uvec2 _482 = uvec2(4294967295u);
    uvec2 _536 = uvec2(4294967295u);
    _471 = _461;
    uint _474 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _482)))
        {
            break;
        }
        _482 -= uvec2(uint(_482.y == 0u), 1u);
        if (_474 >= 12u)
        {
            break;
        }
        _473 |= _471[_474];
        if (_471[_474] != 0u)
        {
            _472 = (_474 * 16u) + (31u - (31u - uint(findMSB(_471[_474]))));
        }
        _474++;
        continue;
    }
    if (_473 == 0u)
    {
        return 0u;
    }
    uint _518 = (_472 >= 50u) ? (_472 - 23u) : 27u;
    uint _523 = _383(_461, _518) | (_383(_461, _518 + 16u) << 16u);
    uint _524 = _518 - 1u;
    uint _528 = _244(_524, 16u);
    uint _531 = (1u << _252(_524, 16u)) - 1u;
    uint _476 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _536)))
        {
            break;
        }
        _536 -= uvec2(uint(_536.y == 0u), 1u);
        if (_476 >= 12u)
        {
            break;
        }
        _475 |= (_471[_476] & ((_476 < _528) ? 65535u : ((_476 == _528) ? _531 : 0u)));
        _476++;
        continue;
    }
    uint _568 = _523 + uint(((_383(_461, _524) & 1u) != 0u) && ((_475 | (_523 & 1u)) != 0u));
    if (_472 < 50u)
    {
        return _568;
    }
    bool _572 = _568 == 16777216u;
    uint _575 = _472 - 49u;
    return ((_572 ? (_575 + 1u) : _575) << 23u) | ((_572 ? (_568 >> 1u) : _568) & 8388607u);
}

uint _584(uint _582, uint _583)
{
    uint _631 = 0u;
    uint _632[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _659 = uvec2(4294967295u);
    uint _635 = _582 & 2147483647u;
    if (_635 >= 2139095040u)
    {
        return 2143289344u;
    }
    bool _639 = _583 != 0u;
    if (_635 <= 956301312u)
    {
        return _639 ? 1065353216u : _582;
    }
    uint _645 = 470u - (_635 >> 23u);
    uint _647 = (_635 & 8388607u) | 8388608u;
    uint _651[22] = _142(uint[](_647 & 65535u, _647 >> 16u), uint[](53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    _631 = _353(_651, _645) & 3u;
    uint _654 = _645 - 176u;
    uint _633 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _659)))
        {
            break;
        }
        _659 -= uvec2(uint(_659.y == 0u), 1u);
        if (_633 >= 11u)
        {
            break;
        }
        _632[_633] = _353(_651, _654 + (_633 * 16u));
        _633++;
        continue;
    }
    uint _681 = _632[10u];
    bool _682 = _681 >= 32768u;
    if (_682)
    {
        _631 = (_631 + 1u) & 3u;
        _632 = _304(uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u), _632, 1u);
    }
    bool _694 = (_631 & 1u) == _583;
    return _462(_413(_26(_632, uint[](5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u)), uint(_694))) | ((((_682 && _694) ? 2147483648u : 0u) ^ (((_639 ? (_631 + 1u) : _631) & 2u) << 30u)) ^ (_639 ? 0u : (_582 & 2147483648u)));
}

float _711(float _710)
{
    float _713 = 0.0;
    _713 = _710;
    return uintBitsToFloat(_584(floatBitsToUint(_713), 0u));
}

float _723(float _722)
{
    float _724 = 0.0;
    _724 = _722;
    return uintBitsToFloat(_584(floatBitsToUint(_724), 1u));
}

int _733(bool _732)
{
    bool _737 = false;
    int _740 = 0;
    _737 = _732;
    if (_737)
    {
        _740 = 17;
    }
    else
    {
        _740 = 19;
    }
    return _740;
}

int _751(int _750)
{
    int _754 = 0;
    _754 = _750;
    return _754 + 23;
}

float _762(float _760, float _761)
{
    float _764 = 0.0;
    float _766 = 0.0;
    _764 = _760;
    _766 = _761;
    return _764 + _766;
}

float _774(vec2 _773)
{
    vec2 _776 = vec2(0.0);
    _776 = _773;
    return _776.x + _776.y;
}

float _787(float _786)
{
    float _788 = 0.0;
    _788 = _786;
    return _788;
}

float _795(float _793, float _794)
{
    float _797 = 0.0;
    float _799 = 0.0;
    _797 = _793;
    _799 = _794;
    return (_797 * 10.0) + _799;
}

void main()
{
    uint _1089 = 0u;
    uint _954 = 0u;
    uint _1065 = 0u;
    uint _930 = 0u;
    uint _1041 = 0u;
    uint _906 = 0u;
    uint _1017 = 0u;
    uint _882 = 0u;
    float _992[2] = float[](0.0, 0.0);
    uint _858 = 0u;
    uint _1103 = 0u;
    bool _968 = false;
    uint _1079 = 0u;
    uint _944 = 0u;
    uint _1055 = 0u;
    float _920 = 0.0;
    uint _1031 = 0u;
    uint _896 = 0u;
    uint _1007 = 0u;
    uint _872 = 0u;
    uint _982 = 0u;
    uint _848 = 0u;
    uint _1093 = 0u;
    bool _958 = false;
    uint _1069 = 0u;
    uint _934 = 0u;
    uint _1045 = 0u;
    uint _910 = 0u;
    uint _1021 = 0u;
    uint _886 = 0u;
    uint _997 = 0u;
    uint _862 = 0u;
    uint _972 = 0u;
    uint _1083 = 0u;
    uint _948 = 0u;
    uint _1059 = 0u;
    uint _924 = 0u;
    uint _1035 = 0u;
    uint _900 = 0u;
    int _1011 = 0;
    uint _876 = 0u;
    uint _986 = 0u;
    uint _852 = 0u;
    uint _1097 = 0u;
    uint _962 = 0u;
    uint _1073 = 0u;
    uint _938 = 0u;
    uint _1049 = 0u;
    uint _914 = 0u;
    uint _1025 = 0u;
    uint _890 = 0u;
    int _1001 = 0;
    uint _866 = 0u;
    bool _976 = false;
    uint _1087 = 0u;
    uint _952 = 0u;
    uint _1063 = 0u;
    uint _928 = 0u;
    float _1039 = 0.0;
    uint _904 = 0u;
    uint _1015 = 0u;
    uint _880 = 0u;
    uint _990 = 0u;
    uint _856 = 0u;
    uint _1101 = 0u;
    uint _966 = 0u;
    uint _1077 = 0u;
    uint _942 = 0u;
    uint _1053 = 0u;
    uint _918 = 0u;
    uint _1029 = 0u;
    uint _894 = 0u;
    uint _1005 = 0u;
    uint _870 = 0u;
    uint _980 = 0u;
    uint _846 = 0u;
    uint _1091 = 0u;
    uint _956 = 0u;
    uint _1067 = 0u;
    uint _932 = 0u;
    uint _1043 = 0u;
    uint _908 = 0u;
    uint _1019 = 0u;
    uint _884 = 0u;
    uint _995 = 0u;
    uint _860 = 0u;
    uint _970 = 0u;
    uint _1081 = 0u;
    uint _946 = 0u;
    uint _1057 = 0u;
    uint _922 = 0u;
    uint _1033 = 0u;
    uint _898 = 0u;
    uint _1009 = 0u;
    uint _874 = 0u;
    float _984 = 0.0;
    uint _850 = 0u;
    uint _1095 = 0u;
    int _960 = 0;
    uint _1071 = 0u;
    uint _936 = 0u;
    uint _1047 = 0u;
    uint _912 = 0u;
    uint _1023 = 0u;
    uint _888 = 0u;
    uint _999 = 0u;
    uint _864 = 0u;
    uint _974 = 0u;
    uint _1085 = 0u;
    uint _950 = 0u;
    uint _1061 = 0u;
    uint _926 = 0u;
    uint _1037 = 0u;
    uint _902 = 0u;
    uint _878 = 0u;
    uint _988 = 0u;
    uint _854 = 0u;
    uint _1099 = 0u;
    uint _964 = 0u;
    uint _1075 = 0u;
    uint _940 = 0u;
    uint _1051 = 0u;
    uint _916 = 0u;
    uint _1027 = 0u;
    uint _892 = 0u;
    float _1003[2] = float[](0.0, 0.0);
    uint _868 = 0u;
    uint _978 = 0u;
    uvec2 _1439 = uvec2(4294967295u);
    _846 = 0u;
    _848 = _846;
    _850 = _848;
    _852 = uint(0);
    _1047 = _850 + _852;
    _20._m0[_1047] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 0u)));
    float _1119 = -0.0;
    _854 = _846;
    _856 = _854;
    _858 = uint(1);
    _1049 = _856 + _858;
    _20._m0[_1049] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_1119), 0u)));
    _860 = _846;
    _862 = _860;
    _864 = uint(2);
    _1051 = _862 + _864;
    _20._m0[_1051] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)));
    float _1144 = -0.0;
    _866 = _846;
    _868 = _866;
    _870 = uint(3);
    _1053 = _868 + _870;
    _20._m0[_1053] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_1144), 1u)));
    float _1157 = float(0);
    _872 = _846;
    _874 = _872;
    _876 = uint(4);
    _1055 = _874 + _876;
    _20._m0[_1055] = floatBitsToUint(_711(_1157));
    float _1168 = float(0u);
    _878 = _846;
    _880 = _878;
    _882 = uint(5);
    _1057 = _880 + _882;
    _20._m0[_1057] = floatBitsToUint(_723(_1168));
    _884 = _846;
    _886 = _884;
    _888 = uint(6);
    _1059 = _886 + _888;
    _20._m0[_1059] = uint(_733(true));
    _890 = _846;
    _892 = _890;
    _894 = uint(7);
    _1061 = _892 + _894;
    _20._m0[_1061] = uint(_733(false));
    _896 = _846;
    _898 = _896;
    _900 = uint(8);
    _1063 = _898 + _900;
    _20._m0[_1063] = uint(_751(4));
    _902 = _846;
    _904 = _902;
    _906 = uint(9);
    _1065 = _904 + _906;
    _20._m0[_1065] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)));
    _908 = _846;
    _910 = _908;
    _912 = uint(10);
    _1067 = _910 + _912;
    _20._m0[_1067] = floatBitsToUint(_762(2.0, 3.0));
    _914 = _846;
    _916 = _914;
    _918 = uint(11);
    _1069 = _916 + _918;
    _20._m0[_1069] = floatBitsToUint(_774(vec2(2.0, 3.0)));
    _920 = 0.0;
    float _1241 = _920;
    float _1242 = float(1);
    _920 = _1241 + _1242;
    _922 = _846;
    _924 = _922;
    _926 = uint(12);
    _1071 = _924 + _926;
    _20._m0[_1071] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_1241), 0u)));
    _928 = _846;
    _930 = _928;
    _932 = uint(13);
    _1073 = _930 + _932;
    _20._m0[_1073] = floatBitsToUint(_920);
    float _1266 = -1.0;
    _920 = _1266;
    float _1268 = float(1);
    _920 += _1268;
    _934 = _846;
    _936 = _934;
    _938 = uint(14);
    _1075 = _936 + _938;
    _20._m0[_1075] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_920), 1u)));
    _940 = _846;
    _942 = _940;
    _944 = uint(15);
    _1077 = _942 + _944;
    _20._m0[_1077] = floatBitsToUint(_920);
    float _1293 = _920;
    float _1294 = float(1);
    _920 = _1293 + _1294;
    float _1300 = _920;
    float _1301 = float(1);
    _920 = _1300 + _1301;
    _946 = _846;
    _948 = _946;
    _950 = uint(16);
    _1079 = _948 + _950;
    _20._m0[_1079] = floatBitsToUint(_795(uintBitsToFloat(_584(floatBitsToUint(_787(_1293)), 0u)), _1300));
    _952 = _846;
    _954 = _952;
    _956 = uint(17);
    _1081 = _954 + _956;
    _20._m0[_1081] = floatBitsToUint(_920);
    _958 = false;
    _960 = 0;
    _968 = _958;
    if (_958)
    {
        int _1326 = _960;
        _960 = _1326 + 1;
        _968 = uintBitsToFloat(_584(floatBitsToUint(float(_1326)), 0u)) != 0.0;
    }
    _962 = _846;
    _964 = _962;
    _966 = uint(18);
    _1083 = _964 + _966;
    _20._m0[_1083] = uint(_968);
    _976 = true;
    if (!true)
    {
        int _1345 = _960;
        _960 = _1345 + 1;
        _976 = uintBitsToFloat(_584(floatBitsToUint(float(_1345)), 1u)) != 0.0;
    }
    _970 = _846;
    _972 = _970;
    _974 = uint(19);
    _1085 = _972 + _974;
    _20._m0[_1085] = uint(_976);
    if (_958)
    {
        _960++;
        _984 = uintBitsToFloat(_584(floatBitsToUint(float(_960)), 0u));
    }
    else
    {
        _984 = uintBitsToFloat(_584(floatBitsToUint(float(_960)), 1u));
    }
    _978 = _846;
    _980 = _978;
    _982 = uint(20);
    _1087 = _980 + _982;
    _20._m0[_1087] = uint(clamp(_984, 0.0, 4294967040.0));
    _986 = _846;
    _988 = _986;
    _990 = uint(21);
    _1089 = _988 + _990;
    _20._m0[_1089] = uint(_960);
    _992[0u] = uintBitsToFloat(_584(floatBitsToUint(0.0), 0u));
    _992[1u] = uintBitsToFloat(_584(floatBitsToUint(0.0), 1u));
    _995 = _846;
    _997 = _995;
    _999 = uint(22);
    _1091 = _997 + _999;
    _20._m0[_1091] = floatBitsToUint(_992[0u] + _992[1u]);
    _1001 = 2;
    _1003 = float[](0.0, 0.0);
    _1005 = _846;
    _1007 = _1005;
    _1009 = uint(23);
    _1093 = _1007 + _1009;
    _20._m0[_1093] = floatBitsToUint(_1003[1u]);
    _1011 = 0;
    int _1013 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _1439)))
        {
            break;
        }
        _1439 -= uvec2(uint(_1439.y == 0u), 1u);
        if (!(_1013 < 3))
        {
            break;
        }
        if (_1013 == 0)
        {
            int _1467 = _1013;
            _1013 = _1467 + 1;
            continue;
        }
        _1011 += int(clamp(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)), -2147483648.0, 2147483520.0));
        int _1467 = _1013;
        _1013 = _1467 + 1;
        continue;
    }
    _1015 = _846;
    _1017 = _1015;
    _1019 = uint(24);
    _1095 = _1017 + _1019;
    _20._m0[_1095] = uint(_1011);
    _920 = 0.0;
    float _1479 = _920;
    float _1480 = float(1);
    _920 = _1479 + _1480;
    float _1485 = float(1);
    _920 -= _1485;
    _1021 = _846;
    _1023 = _1021;
    _1025 = uint(25);
    _1097 = _1023 + _1025;
    _20._m0[_1097] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_920), 1u)));
    _1027 = _846;
    _1029 = _1027;
    _1031 = uint(26);
    _1099 = _1029 + _1031;
    _20._m0[_1099] = floatBitsToUint(_920);
    if (true)
    {
        _1039 = uintBitsToFloat(_584(floatBitsToUint(0.0), 1u));
    }
    else
    {
        _1039 = uintBitsToFloat(_584(floatBitsToUint(99.0), 0u));
    }
    _1033 = _846;
    _1035 = _1033;
    _1037 = uint(27);
    _1101 = _1035 + _1037;
    _20._m0[_1101] = uint(clamp(_1039, 0.0, 4294967040.0));
    _1041 = _846;
    _1043 = _1041;
    _1045 = uint(28);
    _1103 = _1043 + _1045;
    _20._m0[_1103] = floatBitsToUint(_723(float(false)));
}

