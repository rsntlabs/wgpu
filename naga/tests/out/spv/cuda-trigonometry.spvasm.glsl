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
    return uintBitsToFloat(_584(floatBitsToUint(_710), 0u));
}

float _719(float _718)
{
    return uintBitsToFloat(_584(floatBitsToUint(_718), 1u));
}

int _726(bool _725)
{
    int _730 = 0;
    if (_725)
    {
        _730 = 17;
    }
    else
    {
        _730 = 19;
    }
    return _730;
}

int _740(int _739)
{
    return _739 + 23;
}

float _748(float _746, float _747)
{
    return _746 + _747;
}

float _754(vec2 _753)
{
    vec2 _756 = vec2(0.0);
    _756 = _753;
    return _756.x + _756.y;
}

float _768(float _767)
{
    return _767;
}

float _773(float _771, float _772)
{
    return (_771 * 10.0) + _772;
}

void main()
{
    uint _1062 = 0u;
    int _928 = 0;
    uint _1038 = 0u;
    bool _903 = false;
    uint _1014 = 0u;
    uint _878[2] = uint[](0u, 0u);
    uint _1124[2] = uint[](0u, 0u);
    uint _990 = 0u;
    uint _854 = 0u;
    uint _1100[2] = uint[](0u, 0u);
    uint _966 = 0u;
    uint _830 = 0u;
    uint _1076[2] = uint[](0u, 0u);
    uint _942 = 0u;
    uint _1052[2] = uint[](0u, 0u);
    uint _917[2] = uint[](0u, 0u);
    uint _1028[2] = uint[](0u, 0u);
    uint _892 = 0u;
    uint _1004[2] = uint[](0u, 0u);
    float _868 = 0.0;
    uint _1114 = 0u;
    uint _980[2] = uint[](0u, 0u);
    uint _844[2] = uint[](0u, 0u);
    uint _1090 = 0u;
    float _956 = 0.0;
    uint _820[2] = uint[](0u, 0u);
    uint _1066 = 0u;
    uint _932[2] = uint[](0u, 0u);
    uint _1042 = 0u;
    uint _907 = 0u;
    uint _1018 = 0u;
    uint _882[2] = uint[](0u, 0u);
    uint _1128 = 0u;
    uint _994 = 0u;
    uint _858 = 0u;
    uint _1104 = 0u;
    uint _970 = 0u;
    uint _834 = 0u;
    uint _1080 = 0u;
    uint _946 = 0u;
    uint _1056 = 0u;
    float _921[2] = float[](0.0, 0.0);
    uint _1032 = 0u;
    int _897 = 0;
    uint _1008 = 0u;
    uint _872 = 0u;
    uint _1118[2] = uint[](0u, 0u);
    uint _984 = 0u;
    uint _848[2] = uint[](0u, 0u);
    uint _1094[2] = uint[](0u, 0u);
    uint _960 = 0u;
    uint _824[2] = uint[](0u, 0u);
    uint _1070[2] = uint[](0u, 0u);
    int _936 = 0;
    uint _1046[2] = uint[](0u, 0u);
    uint _911[2] = uint[](0u, 0u);
    uint _1022[2] = uint[](0u, 0u);
    uint _886[2] = uint[](0u, 0u);
    uint _1132 = 0u;
    uint _998[2] = uint[](0u, 0u);
    uint _862 = 0u;
    uint _1108 = 0u;
    uint _974[2] = uint[](0u, 0u);
    uint _838 = 0u;
    uint _1084 = 0u;
    uint _950 = 0u;
    uint _1060 = 0u;
    uint _926 = 0u;
    uint _1036 = 0u;
    uint _901 = 0u;
    uint _1012 = 0u;
    uint _876 = 0u;
    uint _1122 = 0u;
    uint _988 = 0u;
    uint _852[2] = uint[](0u, 0u);
    uint _1098 = 0u;
    uint _964 = 0u;
    uint _828[2] = uint[](0u, 0u);
    uint _1074 = 0u;
    uint _940[2] = uint[](0u, 0u);
    uint _1050 = 0u;
    float _915 = 0.0;
    uint _1026 = 0u;
    uint _890[2] = uint[](0u, 0u);
    uint _1002 = 0u;
    uint _866 = 0u;
    uint _1112[2] = uint[](0u, 0u);
    uint _978 = 0u;
    uint _842 = 0u;
    uint _1088[2] = uint[](0u, 0u);
    uint _954 = 0u;
    uint _818[2] = uint[](0u, 0u);
    uint _1064[2] = uint[](0u, 0u);
    float _930[2] = float[](0.0, 0.0);
    uint _1040[2] = uint[](0u, 0u);
    uint _905[2] = uint[](0u, 0u);
    uint _1016[2] = uint[](0u, 0u);
    uint _880 = 0u;
    uint _1126 = 0u;
    uint _992[2] = uint[](0u, 0u);
    uint _856[2] = uint[](0u, 0u);
    uint _1102 = 0u;
    uint _968[2] = uint[](0u, 0u);
    uint _832[2] = uint[](0u, 0u);
    uint _1078 = 0u;
    uint _944[2] = uint[](0u, 0u);
    uint _1054 = 0u;
    uint _919 = 0u;
    uint _1030 = 0u;
    bool _894 = false;
    uint _1006 = 0u;
    uint _870[2] = uint[](0u, 0u);
    uint _1116 = 0u;
    uint _982 = 0u;
    uint _846 = 0u;
    uint _1092 = 0u;
    uint _958[2] = uint[](0u, 0u);
    uint _822 = 0u;
    uint _1068 = 0u;
    uint _934 = 0u;
    uint _1044 = 0u;
    bool _909 = false;
    uint _1020 = 0u;
    uint _884 = 0u;
    uint _1130[2] = uint[](0u, 0u);
    uint _996 = 0u;
    uint _860[2] = uint[](0u, 0u);
    uint _1106[2] = uint[](0u, 0u);
    uint _972 = 0u;
    uint _836[2] = uint[](0u, 0u);
    uint _1082[2] = uint[](0u, 0u);
    uint _948[2] = uint[](0u, 0u);
    uint _1058[2] = uint[](0u, 0u);
    uint _924[2] = uint[](0u, 0u);
    uint _1034[2] = uint[](0u, 0u);
    uint _899[2] = uint[](0u, 0u);
    uint _1010[2] = uint[](0u, 0u);
    uint _874[2] = uint[](0u, 0u);
    uint _1120 = 0u;
    uint _986[2] = uint[](0u, 0u);
    uint _850 = 0u;
    uint _1096 = 0u;
    uint _962[2] = uint[](0u, 0u);
    uint _826 = 0u;
    uint _1072 = 0u;
    uint _1048 = 0u;
    uint _913 = 0u;
    uint _1024 = 0u;
    uint _888 = 0u;
    uint _1134 = 0u;
    uint _1000 = 0u;
    uint _864[2] = uint[](0u, 0u);
    uint _1110 = 0u;
    uint _976 = 0u;
    uint _840[2] = uint[](0u, 0u);
    uint _1086 = 0u;
    uint _952[2] = uint[](0u, 0u);
    uvec2 _1616 = uvec2(4294967295u);
    _818 = uint[](0u, 0u);
    _818[0u] = 0u;
    _818[1u] = 0u;
    _820 = _818;
    _822 = uint(0);
    _962 = _820;
    _962[1u] += _822;
    _964 = _962[0u];
    _966 = _962[1u];
    _20._m0[_966] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 0u)));
    float _1158 = -0.0;
    _824 = _818;
    _826 = uint(1);
    _968 = _824;
    _968[1u] += _826;
    _970 = _968[0u];
    _972 = _968[1u];
    _20._m0[_972] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_1158), 0u)));
    _828 = _818;
    _830 = uint(2);
    _974 = _828;
    _974[1u] += _830;
    _976 = _974[0u];
    _978 = _974[1u];
    _20._m0[_978] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)));
    float _1195 = -0.0;
    _832 = _818;
    _834 = uint(3);
    _980 = _832;
    _980[1u] += _834;
    _982 = _980[0u];
    _984 = _980[1u];
    _20._m0[_984] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_1195), 1u)));
    float _1214 = float(0);
    _836 = _818;
    _838 = uint(4);
    _986 = _836;
    _986[1u] += _838;
    _988 = _986[0u];
    _990 = _986[1u];
    _20._m0[_990] = floatBitsToUint(_711(_1214));
    float _1231 = float(0u);
    _840 = _818;
    _842 = uint(5);
    _992 = _840;
    _992[1u] += _842;
    _994 = _992[0u];
    _996 = _992[1u];
    _20._m0[_996] = floatBitsToUint(_719(_1231));
    _844 = _818;
    _846 = uint(6);
    _998 = _844;
    _998[1u] += _846;
    _1000 = _998[0u];
    _1002 = _998[1u];
    _20._m0[_1002] = uint(_726(true));
    _848 = _818;
    _850 = uint(7);
    _1004 = _848;
    _1004[1u] += _850;
    _1006 = _1004[0u];
    _1008 = _1004[1u];
    _20._m0[_1008] = uint(_726(false));
    _852 = _818;
    _854 = uint(8);
    _1010 = _852;
    _1010[1u] += _854;
    _1012 = _1010[0u];
    _1014 = _1010[1u];
    _20._m0[_1014] = uint(_740(4));
    _856 = _818;
    _858 = uint(9);
    _1016 = _856;
    _1016[1u] += _858;
    _1018 = _1016[0u];
    _1020 = _1016[1u];
    _20._m0[_1020] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)));
    _860 = _818;
    _862 = uint(10);
    _1022 = _860;
    _1022[1u] += _862;
    _1024 = _1022[0u];
    _1026 = _1022[1u];
    _20._m0[_1026] = floatBitsToUint(_748(2.0, 3.0));
    _864 = _818;
    _866 = uint(11);
    _1028 = _864;
    _1028[1u] += _866;
    _1030 = _1028[0u];
    _1032 = _1028[1u];
    _20._m0[_1032] = floatBitsToUint(_754(vec2(2.0, 3.0)));
    _868 = 0.0;
    float _1346 = _868;
    float _1347 = float(1);
    _868 = _1346 + _1347;
    _870 = _818;
    _872 = uint(12);
    _1034 = _870;
    _1034[1u] += _872;
    _1036 = _1034[0u];
    _1038 = _1034[1u];
    _20._m0[_1038] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_1346), 0u)));
    _874 = _818;
    _876 = uint(13);
    _1040 = _874;
    _1040[1u] += _876;
    _1042 = _1040[0u];
    _1044 = _1040[1u];
    _20._m0[_1044] = floatBitsToUint(_868);
    float _1383 = -1.0;
    _868 = _1383;
    float _1385 = float(1);
    _868 += _1385;
    _878 = _818;
    _880 = uint(14);
    _1046 = _878;
    _1046[1u] += _880;
    _1048 = _1046[0u];
    _1050 = _1046[1u];
    _20._m0[_1050] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_868), 1u)));
    _882 = _818;
    _884 = uint(15);
    _1052 = _882;
    _1052[1u] += _884;
    _1054 = _1052[0u];
    _1056 = _1052[1u];
    _20._m0[_1056] = floatBitsToUint(_868);
    float _1422 = _868;
    float _1423 = float(1);
    _868 = _1422 + _1423;
    float _1429 = _868;
    float _1430 = float(1);
    _868 = _1429 + _1430;
    _886 = _818;
    _888 = uint(16);
    _1058 = _886;
    _1058[1u] += _888;
    _1060 = _1058[0u];
    _1062 = _1058[1u];
    _20._m0[_1062] = floatBitsToUint(_773(uintBitsToFloat(_584(floatBitsToUint(_768(_1422)), 0u)), _1429));
    _890 = _818;
    _892 = uint(17);
    _1064 = _890;
    _1064[1u] += _892;
    _1066 = _1064[0u];
    _1068 = _1064[1u];
    _20._m0[_1068] = floatBitsToUint(_868);
    _894 = false;
    _897 = 0;
    _903 = _894;
    if (_894)
    {
        int _1467 = _897;
        _897 = _1467 + 1;
        _903 = uintBitsToFloat(_584(floatBitsToUint(float(_1467)), 0u)) != 0.0;
    }
    _899 = _818;
    _901 = uint(18);
    _1070 = _899;
    _1070[1u] += _901;
    _1072 = _1070[0u];
    _1074 = _1070[1u];
    _20._m0[_1074] = uint(_903);
    _909 = true;
    if (!true)
    {
        int _1492 = _897;
        _897 = _1492 + 1;
        _909 = uintBitsToFloat(_584(floatBitsToUint(float(_1492)), 1u)) != 0.0;
    }
    _905 = _818;
    _907 = uint(19);
    _1076 = _905;
    _1076[1u] += _907;
    _1078 = _1076[0u];
    _1080 = _1076[1u];
    _20._m0[_1080] = uint(_909);
    if (_894)
    {
        _897++;
        _915 = uintBitsToFloat(_584(floatBitsToUint(float(_897)), 0u));
    }
    else
    {
        _915 = uintBitsToFloat(_584(floatBitsToUint(float(_897)), 1u));
    }
    _911 = _818;
    _913 = uint(20);
    _1082 = _911;
    _1082[1u] += _913;
    _1084 = _1082[0u];
    _1086 = _1082[1u];
    _20._m0[_1086] = uint(clamp(_915, 0.0, 4294967040.0));
    _917 = _818;
    _919 = uint(21);
    _1088 = _917;
    _1088[1u] += _919;
    _1090 = _1088[0u];
    _1092 = _1088[1u];
    _20._m0[_1092] = uint(_897);
    _921[0u] = uintBitsToFloat(_584(floatBitsToUint(0.0), 0u));
    _921[1u] = uintBitsToFloat(_584(floatBitsToUint(0.0), 1u));
    _924 = _818;
    _926 = uint(22);
    _1094 = _924;
    _1094[1u] += _926;
    _1096 = _1094[0u];
    _1098 = _1094[1u];
    _20._m0[_1098] = floatBitsToUint(_921[0u] + _921[1u]);
    _928 = 2;
    _930 = float[](0.0, 0.0);
    _932 = _818;
    _934 = uint(23);
    _1100 = _932;
    _1100[1u] += _934;
    _1102 = _1100[0u];
    _1104 = _1100[1u];
    _20._m0[_1104] = floatBitsToUint(_930[1u]);
    _936 = 0;
    int _938 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _1616)))
        {
            break;
        }
        _1616 -= uvec2(uint(_1616.y == 0u), 1u);
        if (!(_938 < 3))
        {
            break;
        }
        if (_938 == 0)
        {
            int _1644 = _938;
            _938 = _1644 + 1;
            continue;
        }
        _936 += int(clamp(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)), -2147483648.0, 2147483520.0));
        int _1644 = _938;
        _938 = _1644 + 1;
        continue;
    }
    _940 = _818;
    _942 = uint(24);
    _1106 = _940;
    _1106[1u] += _942;
    _1108 = _1106[0u];
    _1110 = _1106[1u];
    _20._m0[_1110] = uint(_936);
    _868 = 0.0;
    float _1662 = _868;
    float _1663 = float(1);
    _868 = _1662 + _1663;
    float _1668 = float(1);
    _868 -= _1668;
    _944 = _818;
    _946 = uint(25);
    _1112 = _944;
    _1112[1u] += _946;
    _1114 = _1112[0u];
    _1116 = _1112[1u];
    _20._m0[_1116] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_868), 1u)));
    _948 = _818;
    _950 = uint(26);
    _1118 = _948;
    _1118[1u] += _950;
    _1120 = _1118[0u];
    _1122 = _1118[1u];
    _20._m0[_1122] = floatBitsToUint(_868);
    if (true)
    {
        _956 = uintBitsToFloat(_584(floatBitsToUint(0.0), 1u));
    }
    else
    {
        _956 = uintBitsToFloat(_584(floatBitsToUint(99.0), 0u));
    }
    _952 = _818;
    _954 = uint(27);
    _1124 = _952;
    _1124[1u] += _954;
    _1126 = _1124[0u];
    _1128 = _1124[1u];
    _20._m0[_1128] = uint(clamp(_956, 0.0, 4294967040.0));
    _958 = _818;
    _960 = uint(28);
    _1130 = _958;
    _1130[1u] += _960;
    _1132 = _1130[0u];
    _1134 = _1130[1u];
    _20._m0[_1134] = floatBitsToUint(_719(float(false)));
}

