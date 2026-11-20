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
    uvec2 _662 = uvec2(4294967295u);
    uint _635 = _582 & 2147483647u;
    if (_635 >= 2139095040u)
    {
        return 2143289344u;
    }
    bool _639 = _583 != 0u;
    if (_635 <= 956301312u)
    {
        return (_583 * 1065353216u) | ((1u - _583) * _582);
    }
    uint _648 = 470u - (_635 >> 23u);
    uint _650 = (_635 & 8388607u) | 8388608u;
    uint _654[22] = _142(uint[](_650 & 65535u, _650 >> 16u), uint[](53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    _631 = _353(_654, _648) & 3u;
    uint _657 = _648 - 176u;
    uint _633 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _662)))
        {
            break;
        }
        _662 -= uvec2(uint(_662.y == 0u), 1u);
        if (_633 >= 11u)
        {
            break;
        }
        _632[_633] = _353(_654, _657 + (_633 * 16u));
        _633++;
        continue;
    }
    uint _684 = _632[10u];
    bool _685 = _684 >= 32768u;
    if (_685)
    {
        _631 = (_631 + 1u) & 3u;
        _632 = _304(uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u), _632, 1u);
    }
    bool _697 = (_631 & 1u) == _583;
    return _462(_413(_26(_632, uint[](5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u)), uint(_697))) | ((((_685 && _697) ? 2147483648u : 0u) ^ (((_639 ? (_631 + 1u) : _631) & 2u) << 30u)) ^ (_639 ? 0u : (_582 & 2147483648u)));
}

float _714(float _713)
{
    return uintBitsToFloat(_584(floatBitsToUint(_713), 0u));
}

float _722(float _721)
{
    return uintBitsToFloat(_584(floatBitsToUint(_721), 1u));
}

int _729(bool _728)
{
    int _733 = 0;
    if (_728)
    {
        _733 = 17;
    }
    else
    {
        _733 = 19;
    }
    return _733;
}

int _743(int _742)
{
    return _742 + 23;
}

float _751(float _749, float _750)
{
    return _749 + _750;
}

float _757(vec2 _756)
{
    vec2 _759 = vec2(0.0);
    _759 = _756;
    return _759.x + _759.y;
}

float _771(float _770)
{
    return _770;
}

float _776(float _774, float _775)
{
    return (_774 * 10.0) + _775;
}

uint _783(uint _782)
{
    uint _786 = _782 & 2147483647u;
    return (_786 > 2139095040u) ? 2143289344u : _786;
}

void main()
{
    uint _866 = 0u;
    int _854 = 0;
    bool _847 = false;
    bool _840 = false;
    uint _864 = 0u;
    int _858 = 0;
    float _851[2] = float[](0.0, 0.0);
    bool _845 = false;
    float _838 = 0.0;
    uint _868 = 0u;
    float _862 = 0.0;
    float _856[2] = float[](0.0, 0.0);
    float _849 = 0.0;
    int _843 = 0;
    uvec2 _1064 = uvec2(4294967295u);
    _20._m0[uint(0)] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 0u)));
    float _878 = -0.0;
    _20._m0[uint(1)] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_878), 0u)));
    _20._m0[uint(2)] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)));
    float _891 = -0.0;
    _20._m0[uint(3)] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_891), 1u)));
    float _898 = float(0);
    _20._m0[uint(4)] = floatBitsToUint(_714(_898));
    float _903 = float(0u);
    _20._m0[uint(5)] = floatBitsToUint(_722(_903));
    _20._m0[uint(6)] = uint(_729(true));
    _20._m0[uint(7)] = uint(_729(false));
    _20._m0[uint(8)] = uint(_743(4));
    _20._m0[uint(9)] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)));
    _20._m0[uint(10)] = floatBitsToUint(_751(2.0, 3.0));
    _20._m0[uint(11)] = floatBitsToUint(_757(vec2(2.0, 3.0)));
    _838 = 0.0;
    float _934 = _838;
    float _935 = float(1);
    _838 = _934 + _935;
    _20._m0[uint(12)] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_934), 0u)));
    _20._m0[uint(13)] = floatBitsToUint(_838);
    float _947 = -1.0;
    _838 = _947;
    float _949 = float(1);
    _838 += _949;
    _20._m0[uint(14)] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_838), 1u)));
    _20._m0[uint(15)] = floatBitsToUint(_838);
    float _962 = _838;
    float _963 = float(1);
    _838 = _962 + _963;
    float _969 = _838;
    float _970 = float(1);
    _838 = _969 + _970;
    _20._m0[uint(16)] = floatBitsToUint(_776(uintBitsToFloat(_584(floatBitsToUint(_771(_962)), 0u)), _969));
    _20._m0[uint(17)] = floatBitsToUint(_838);
    _840 = false;
    _843 = 0;
    _845 = _840;
    if (_840)
    {
        int _983 = _843;
        _843 = _983 + 1;
        _845 = _783(floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(float(_983)), 0u)))) != 0u;
    }
    _20._m0[uint(18)] = uint(_845);
    _847 = true;
    if (!true)
    {
        int _998 = _843;
        _843 = _998 + 1;
        _847 = _783(floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(float(_998)), 1u)))) != 0u;
    }
    _20._m0[uint(19)] = uint(_847);
    if (_840)
    {
        _843++;
        _849 = uintBitsToFloat(_584(floatBitsToUint(float(_843)), 0u));
    }
    else
    {
        _849 = uintBitsToFloat(_584(floatBitsToUint(float(_843)), 1u));
    }
    _20._m0[uint(20)] = uint(clamp(_849, 0.0, 4294967040.0));
    _20._m0[uint(21)] = uint(_843);
    _851[0u] = uintBitsToFloat(_584(floatBitsToUint(0.0), 0u));
    _851[1u] = uintBitsToFloat(_584(floatBitsToUint(0.0), 1u));
    _20._m0[uint(22)] = floatBitsToUint(_851[0u] + _851[1u]);
    _854 = 2;
    _856 = float[](0.0, 0.0);
    _20._m0[uint(23)] = floatBitsToUint(_856[1u]);
    _858 = 0;
    int _860 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _1064)))
        {
            break;
        }
        _1064 -= uvec2(uint(_1064.y == 0u), 1u);
        if (!(_860 < 3))
        {
            break;
        }
        if (_860 == 0)
        {
            int _1092 = _860;
            _860 = _1092 + 1;
            continue;
        }
        _858 += int(clamp(uintBitsToFloat(_584(floatBitsToUint(0.0), 1u)), -2147483648.0, 2147483520.0));
        int _1092 = _860;
        _860 = _1092 + 1;
        continue;
    }
    _20._m0[uint(24)] = uint(_858);
    _838 = 0.0;
    float _1098 = _838;
    float _1099 = float(1);
    _838 = _1098 + _1099;
    float _1104 = float(1);
    _838 -= _1104;
    _20._m0[uint(25)] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_838), 1u)));
    _20._m0[uint(26)] = floatBitsToUint(_838);
    if (true)
    {
        _862 = uintBitsToFloat(_584(floatBitsToUint(0.0), 1u));
    }
    else
    {
        _862 = uintBitsToFloat(_584(floatBitsToUint(99.0), 0u));
    }
    _20._m0[uint(27)] = uint(clamp(_862, 0.0, 4294967040.0));
    _20._m0[uint(28)] = floatBitsToUint(_722(float(false)));
    uint _1137 = _584(floatBitsToUint(0.0), 0u);
    _20._m0[uint(29)] = floatBitsToUint(uintBitsToFloat(((_1137 & 2139095040u) == 0u) ? (_1137 & 2147483648u) : _1137));
    float _1146 = -0.0;
    uint _1148 = _584(floatBitsToUint(_1146), 0u);
    _20._m0[uint(30)] = floatBitsToUint(uintBitsToFloat(((_1148 & 2139095040u) == 0u) ? (_1148 & 2147483648u) : _1148));
    _864 = 1u;
    uint _1160 = _584(floatBitsToUint(uintBitsToFloat(_864)), 0u);
    _20._m0[uint(31)] = floatBitsToUint(uintBitsToFloat(((_1160 & 2139095040u) == 0u) ? (_1160 & 2147483648u) : _1160));
    _866 = 2147483649u;
    uint _1171 = floatBitsToUint(uintBitsToFloat(_866));
    uint _1176 = _584(((_1171 & 2139095040u) == 0u) ? (_1171 & 2147483648u) : _1171, 0u);
    _20._m0[uint(32)] = floatBitsToUint(uintBitsToFloat(((_1176 & 2139095040u) == 0u) ? (_1176 & 2147483648u) : _1176));
    _868 = 1u;
    uint _1187 = floatBitsToUint(uintBitsToFloat(_868));
    uint _1192 = _584(((_1187 & 2139095040u) == 0u) ? (_1187 & 2147483648u) : _1187, 1u);
    _20._m0[uint(33)] = floatBitsToUint(uintBitsToFloat(((_1192 & 2139095040u) == 0u) ? (_1192 & 2147483648u) : _1192));
    _838 = 0.0;
    float _1201 = _838;
    float _1202 = float(1);
    _838 = _1201 + _1202;
    uint _1205 = _584(floatBitsToUint(_1201), 0u);
    _20._m0[uint(34)] = floatBitsToUint(uintBitsToFloat(((_1205 & 2139095040u) == 0u) ? (_1205 & 2147483648u) : _1205));
    _20._m0[uint(35)] = floatBitsToUint(_838);
    float _1219 = float(1);
    _838 -= _1219;
    _20._m0[uint(36)] = floatBitsToUint(uintBitsToFloat(_584(floatBitsToUint(_838), 1u)));
}

