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
    uint _940 = 0u;
    uint _928 = 0u;
    uint _916 = 0u;
    uint _904 = 0u;
    uint _892 = 0u;
    int _880 = 0;
    bool _867 = false;
    uint _854 = 0u;
    float _842 = 0.0;
    uint _830 = 0u;
    uint _954 = 0u;
    uint _818 = 0u;
    uint _942 = 0u;
    uint _930 = 0u;
    uint _918 = 0u;
    uint _906 = 0u;
    uint _894 = 0u;
    float _882[2] = float[](0.0, 0.0);
    uint _869 = 0u;
    bool _856 = false;
    uint _844 = 0u;
    uint _832 = 0u;
    uint _956 = 0u;
    uint _820 = 0u;
    uint _944 = 0u;
    uint _932 = 0u;
    uint _920 = 0u;
    uint _908 = 0u;
    uint _896 = 0u;
    uint _884 = 0u;
    float _871 = 0.0;
    int _859 = 0;
    uint _846 = 0u;
    uint _834 = 0u;
    uint _958 = 0u;
    uint _822 = 0u;
    uint _946 = 0u;
    uint _934 = 0u;
    uint _922 = 0u;
    uint _910 = 0u;
    float _898 = 0.0;
    int _886 = 0;
    uint _873 = 0u;
    uint _861 = 0u;
    uint _848 = 0u;
    uint _836 = 0u;
    uint _824 = 0u;
    uint _948 = 0u;
    uint _936 = 0u;
    uint _924 = 0u;
    uint _912 = 0u;
    uint _900 = 0u;
    float _875[2] = float[](0.0, 0.0);
    bool _863 = false;
    uint _850 = 0u;
    uint _838 = 0u;
    uint _826 = 0u;
    uint _950 = 0u;
    uint _938 = 0u;
    uint _926 = 0u;
    uint _914 = 0u;
    uint _902 = 0u;
    uint _890 = 0u;
    uint _878 = 0u;
    uint _865 = 0u;
    uint _852 = 0u;
    uint _840 = 0u;
    uint _828 = 0u;
    uint _952 = 0u;
    uvec2 _1198 = uvec2(4294967295u);
    _818 = uint(0);
    _902 = _818;
    _20._m0[_902] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 0u)));
    float _970 = -0.0;
    _820 = uint(1);
    _904 = _820;
    _20._m0[_904] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_970), 0u)));
    _822 = uint(2);
    _906 = _822;
    _20._m0[_906] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)));
    float _987 = -0.0;
    _824 = uint(3);
    _908 = _824;
    _20._m0[_908] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_987), 1u)));
    float _996 = float(0);
    _826 = uint(4);
    _910 = _826;
    _20._m0[_910] = floatBitsToUint(_711(_996));
    float _1003 = float(0u);
    _828 = uint(5);
    _912 = _828;
    _20._m0[_912] = floatBitsToUint(_719(_1003));
    _830 = uint(6);
    _914 = _830;
    _20._m0[_914] = uint(_726(true));
    _832 = uint(7);
    _916 = _832;
    _20._m0[_916] = uint(_726(false));
    _834 = uint(8);
    _918 = _834;
    _20._m0[_918] = uint(_740(4));
    _836 = uint(9);
    _920 = _836;
    _20._m0[_920] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)));
    _838 = uint(10);
    _922 = _838;
    _20._m0[_922] = floatBitsToUint(_748(2.0, 3.0));
    _840 = uint(11);
    _924 = _840;
    _20._m0[_924] = floatBitsToUint(_754(vec2(2.0, 3.0)));
    _842 = 0.0;
    float _1048 = _842;
    float _1049 = float(1);
    _842 = _1048 + _1049;
    _844 = uint(12);
    _926 = _844;
    _20._m0[_926] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_1048), 0u)));
    _846 = uint(13);
    _928 = _846;
    _20._m0[_928] = floatBitsToUint(_842);
    float _1065 = -1.0;
    _842 = _1065;
    float _1067 = float(1);
    _842 += _1067;
    _848 = uint(14);
    _930 = _848;
    _20._m0[_930] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_842), 1u)));
    _850 = uint(15);
    _932 = _850;
    _20._m0[_932] = floatBitsToUint(_842);
    float _1084 = _842;
    float _1085 = float(1);
    _842 = _1084 + _1085;
    float _1091 = _842;
    float _1092 = float(1);
    _842 = _1091 + _1092;
    _852 = uint(16);
    _934 = _852;
    _20._m0[_934] = floatBitsToUint(_773(uintBitsToFloat(_584(floatBitsToUint(_768(_1084)), 0u)), _1091));
    _854 = uint(17);
    _936 = _854;
    _20._m0[_936] = floatBitsToUint(_842);
    _856 = false;
    _859 = 0;
    _863 = _856;
    if (_856)
    {
        int _1109 = _859;
        _859 = _1109 + 1;
        _863 = uintBitsToFloat(_584(floatBitsToUint(float(_1109)), 0u)) != 0.0;
    }
    _861 = uint(18);
    _938 = _861;
    _20._m0[_938] = uint(_863);
    _867 = true;
    if (!true)
    {
        int _1124 = _859;
        _859 = _1124 + 1;
        _867 = uintBitsToFloat(_584(floatBitsToUint(float(_1124)), 1u)) != 0.0;
    }
    _865 = uint(19);
    _940 = _865;
    _20._m0[_940] = uint(_867);
    if (_856)
    {
        _859++;
        _871 = uintBitsToFloat(_584(floatBitsToUint(float(_859)), 0u));
    }
    else
    {
        _871 = uintBitsToFloat(_584(floatBitsToUint(float(_859)), 1u));
    }
    _869 = uint(20);
    _942 = _869;
    _20._m0[_942] = uint(clamp(_871, 0.0, 4294967040.0));
    _873 = uint(21);
    _944 = _873;
    _20._m0[_944] = uint(_859);
    _875[0u] = uintBitsToFloat(_584(floatBitsToUint(0.0), 0u));
    _875[1u] = uintBitsToFloat(_584(floatBitsToUint(0.0), 1u));
    _878 = uint(22);
    _946 = _878;
    _20._m0[_946] = floatBitsToUint(_875[0u] + _875[1u]);
    _880 = 2;
    _882 = float[](0.0, 0.0);
    _884 = uint(23);
    _948 = _884;
    _20._m0[_948] = floatBitsToUint(_882[1u]);
    _886 = 0;
    int _888 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _1198)))
        {
            break;
        }
        _1198 -= uvec2(uint(_1198.y == 0u), 1u);
        if (!(_888 < 3))
        {
            break;
        }
        if (_888 == 0)
        {
            int _1226 = _888;
            _888 = _1226 + 1;
            continue;
        }
        _886 += int(clamp(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)), -2147483648.0, 2147483520.0));
        int _1226 = _888;
        _888 = _1226 + 1;
        continue;
    }
    _890 = uint(24);
    _950 = _890;
    _20._m0[_950] = uint(_886);
    _842 = 0.0;
    float _1234 = _842;
    float _1235 = float(1);
    _842 = _1234 + _1235;
    float _1240 = float(1);
    _842 -= _1240;
    _892 = uint(25);
    _952 = _892;
    _20._m0[_952] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_842), 1u)));
    _894 = uint(26);
    _954 = _894;
    _20._m0[_954] = floatBitsToUint(_842);
    if (true)
    {
        _898 = uintBitsToFloat(_584(floatBitsToUint(0.0), 1u));
    }
    else
    {
        _898 = uintBitsToFloat(_584(floatBitsToUint(99.0), 0u));
    }
    _896 = uint(27);
    _956 = _896;
    _20._m0[_956] = uint(clamp(_898, 0.0, 4294967040.0));
    _900 = uint(28);
    _958 = _900;
    _20._m0[_958] = floatBitsToUint(_719(float(false)));
}

