#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _18_17
{
    float _m0[];
} _17;

layout(set = 0, binding = 1, std430) buffer _21_20
{
    float _m0[];
} _20;

uint[22] _143(uint _141[2], uint _142[20])
{
    uint _157[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _154 = 0u;
    uint _148[2] = uint[](0u, 0u);
    uint _150[20] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _152[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _164 = uvec2(4294967295u);
    uvec2 _185 = uvec2(4294967295u);
    uvec2 _223 = uvec2(4294967295u);
    _148 = _141;
    _150 = _142;
    uint _155 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _164)))
        {
            break;
        }
        _164 -= uvec2(uint(_164.y == 0u), 1u);
        if (_155 >= 2u)
        {
            break;
        }
        _154 = 0u;
        uint _156 = 0u;
        for (;;)
        {
            if (all(equal(uvec2(0u), _185)))
            {
                break;
            }
            _185 -= uvec2(uint(_185.y == 0u), 1u);
            if (_156 >= 20u)
            {
                break;
            }
            uint _202 = _155 + _156;
            uint _204 = _152[_202];
            uint _208 = ((_148[_155] * _150[_156]) + _204) + _154;
            _152[_202] = _208 & 65535u;
            _154 = _208 >> 16u;
            _156++;
            continue;
        }
        _152[_155 + 20u] = _154;
        _155++;
        continue;
    }
    uint _158 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _223)))
        {
            break;
        }
        _223 -= uvec2(uint(_223.y == 0u), 1u);
        if (_158 >= 22u)
        {
            break;
        }
        _157[_158] = _152[_158 + 0u];
        _158++;
        continue;
    }
    return _157;
}

uint _245(uint _247, uint _248)
{
    return _247 / ((_248 == 0u) ? 1u : _248);
}

uint _253(uint _254, uint _255)
{
    return _254 % ((_255 == 0u) ? 1u : _255);
}

uint _354(uint _352[22], uint _353)
{
    uint _356[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _357 = 0u;
    uint _358 = 0u;
    _356 = _352;
    uint _360 = _245(_353, 16u);
    uint _361 = _253(_353, 16u);
    uint _362 = _360 + 0u;
    if (_362 < 22u)
    {
        _357 = _356[_362];
    }
    uint _368 = _360 + 1u;
    if (_368 < 22u)
    {
        _358 = _356[_368];
    }
    return ((_357 >> _361) | (_358 << (16u - _361))) & 65535u;
}

uint[12] _305(uint _302[12], uint _303[12], uint _304)
{
    uint _308[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _310 = 0u;
    uint _307[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _309[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _318 = uvec2(4294967295u);
    _307 = _302;
    _308 = _303;
    bool _313 = _304 != 0u;
    uint _311 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _318)))
        {
            break;
        }
        _318 -= uvec2(uint(_318.y == 0u), 1u);
        if (_311 >= 12u)
        {
            break;
        }
        uint _338 = _308[_311] + _310;
        uint _340 = _307[_311] + _338;
        _309[_311] = (_313 ? (_307[_311] - _338) : _340) & 65535u;
        _310 = _313 ? uint(_307[_311] < _338) : (_340 >> 16u);
        _311++;
        continue;
    }
    return _309;
}

uint[12] _26(uint _24[12], uint _25[12])
{
    uint _45[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _41 = 0u;
    uint _36[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _38[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _39[24] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _59 = uvec2(4294967295u);
    uvec2 _80 = uvec2(4294967295u);
    uvec2 _118 = uvec2(4294967295u);
    _36 = _24;
    _38 = _25;
    uint _43 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _59)))
        {
            break;
        }
        _59 -= uvec2(uint(_59.y == 0u), 1u);
        if (_43 >= 12u)
        {
            break;
        }
        _41 = 0u;
        uint _44 = 0u;
        for (;;)
        {
            if (all(equal(uvec2(0u), _80)))
            {
                break;
            }
            _80 -= uvec2(uint(_80.y == 0u), 1u);
            if (_44 >= 12u)
            {
                break;
            }
            uint _97 = _43 + _44;
            uint _99 = _39[_97];
            uint _103 = ((_36[_43] * _38[_44]) + _99) + _41;
            _39[_97] = _103 & 65535u;
            _41 = _103 >> 16u;
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
        if (all(equal(uvec2(0u), _118)))
        {
            break;
        }
        _118 -= uvec2(uint(_118.y == 0u), 1u);
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

uint[12] _263(uint _261[12], uint _262)
{
    uint _266[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _265[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _267 = 0u;
    uvec2 _274 = uvec2(4294967295u);
    _265 = _261;
    uint _268 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _274)))
        {
            break;
        }
        _274 -= uvec2(uint(_274.y == 0u), 1u);
        if (_268 >= 12u)
        {
            break;
        }
        uint _289 = 11u - _268;
        uint _294 = (_267 << 16u) | _265[_289];
        _266[_289] = _245(_294, _262);
        _267 = _253(_294, _262);
        _268++;
        continue;
    }
    return _266;
}

uint[12] _414(uint _412[12], uint _413)
{
    uint _417[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _418[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _431 = uvec2(4294967295u);
    bool _421 = _413 != 0u;
    if (_421)
    {
        _417 = _412;
    }
    else
    {
        _417 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u);
    }
    _418 = _417;
    uint _426[12] = _26(_412, _412);
    uint _419 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _431)))
        {
            break;
        }
        _431 -= uvec2(uint(_431.y == 0u), 1u);
        if (_419 >= 8u)
        {
            break;
        }
        uint _446 = _419 + 1u;
        uint _447 = _446 * 2u;
        uint _454[12] = _263(_26(_417, _426), _447 * (_421 ? (_447 + 1u) : (_447 - 1u)));
        _417 = _454;
        _418 = _305(_418, _454, _446 & 1u);
        _419++;
        continue;
    }
    return _418;
}

uint _384(uint _382[12], uint _383)
{
    uint _386[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _387 = 0u;
    uint _388 = 0u;
    _386 = _382;
    uint _390 = _245(_383, 16u);
    uint _391 = _253(_383, 16u);
    uint _392 = _390 + 0u;
    if (_392 < 12u)
    {
        _387 = _386[_392];
    }
    uint _398 = _390 + 1u;
    if (_398 < 12u)
    {
        _388 = _386[_398];
    }
    return ((_387 >> _391) | (_388 << (16u - _391))) & 65535u;
}

uint _463(uint _462[12])
{
    uint _476 = 0u;
    uint _473 = 0u;
    uint _472[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _474 = 0u;
    uvec2 _483 = uvec2(4294967295u);
    uvec2 _537 = uvec2(4294967295u);
    _472 = _462;
    uint _475 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _483)))
        {
            break;
        }
        _483 -= uvec2(uint(_483.y == 0u), 1u);
        if (_475 >= 12u)
        {
            break;
        }
        _474 |= _472[_475];
        if (_472[_475] != 0u)
        {
            _473 = (_475 * 16u) + (31u - (31u - uint(findMSB(_472[_475]))));
        }
        _475++;
        continue;
    }
    if (_474 == 0u)
    {
        return 0u;
    }
    uint _519 = (_473 >= 50u) ? (_473 - 23u) : 27u;
    uint _524 = _384(_462, _519) | (_384(_462, _519 + 16u) << 16u);
    uint _525 = _519 - 1u;
    uint _529 = _245(_525, 16u);
    uint _532 = (1u << _253(_525, 16u)) - 1u;
    uint _477 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _537)))
        {
            break;
        }
        _537 -= uvec2(uint(_537.y == 0u), 1u);
        if (_477 >= 12u)
        {
            break;
        }
        _476 |= (_472[_477] & ((_477 < _529) ? 65535u : ((_477 == _529) ? _532 : 0u)));
        _477++;
        continue;
    }
    uint _569 = _524 + uint(((_384(_462, _525) & 1u) != 0u) && ((_476 | (_524 & 1u)) != 0u));
    if (_473 < 50u)
    {
        return _569;
    }
    bool _573 = _569 == 16777216u;
    uint _576 = _473 - 49u;
    return ((_573 ? (_576 + 1u) : _576) << 23u) | ((_573 ? (_569 >> 1u) : _569) & 8388607u);
}

uint _585(uint _583, uint _584)
{
    uint _632 = 0u;
    uint _633[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _663 = uvec2(4294967295u);
    uint _636 = _583 & 2147483647u;
    if (_636 >= 2139095040u)
    {
        return 2143289344u;
    }
    bool _640 = _584 != 0u;
    if (_636 <= 956301312u)
    {
        return (_584 * 1065353216u) | ((1u - _584) * _583);
    }
    uint _649 = 470u - (_636 >> 23u);
    uint _651 = (_636 & 8388607u) | 8388608u;
    uint _655[22] = _143(uint[](_651 & 65535u, _651 >> 16u), uint[](53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    _632 = _354(_655, _649) & 3u;
    uint _658 = _649 - 176u;
    uint _634 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _663)))
        {
            break;
        }
        _663 -= uvec2(uint(_663.y == 0u), 1u);
        if (_634 >= 11u)
        {
            break;
        }
        _633[_634] = _354(_655, _658 + (_634 * 16u));
        _634++;
        continue;
    }
    uint _685 = _633[10u];
    bool _686 = _685 >= 32768u;
    if (_686)
    {
        _632 = (_632 + 1u) & 3u;
        _633 = _305(uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u), _633, 1u);
    }
    bool _698 = (_632 & 1u) == _584;
    return _463(_414(_26(_633, uint[](5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u)), uint(_698))) | ((((_686 && _698) ? 2147483648u : 0u) ^ (((_640 ? (_632 + 1u) : _632) & 2u) << 30u)) ^ (_640 ? 0u : (_583 & 2147483648u)));
}

void main()
{
    uint _760 = 0u;
    uint _754 = 0u;
    uint _748 = 0u;
    uint _742 = 0u;
    float _736 = 0.0;
    uint _758 = 0u;
    uint _752 = 0u;
    uint _746 = 0u;
    uint _740 = 0u;
    float _733 = 0.0;
    uint _762 = 0u;
    uint _756 = 0u;
    uint _750 = 0u;
    uint _744 = 0u;
    float _738 = 0.0;
    uint _767 = 4u + (gl_LocalInvocationID.x * 16u);
    _733 = _17._m0[gl_LocalInvocationID.x];
    _736 = uintBitsToFloat(_585(floatBitsToUint(_733), 0u));
    _738 = uintBitsToFloat(_585(floatBitsToUint(_733), 1u));
    _20._m0[_767] = _736;
    _740 = _767 + 1u;
    _20._m0[_740] = _738;
    _742 = _767 + 2u;
    float _785 = _733;
    float _786 = float(1);
    _733 = _785 + _786;
    uint _788 = _742;
    _742 = _788 + uint(1);
    uint _791 = _742;
    _742 = _791 + uint(1);
    _20._m0[_788] = uintBitsToFloat(_585(floatBitsToUint(_785), 0u));
    _20._m0[_791] = uintBitsToFloat(_585(floatBitsToUint(_785), 1u));
    _744 = _767 + 4u;
    _20._m0[_744] = float(_742);
    _746 = _767 + 5u;
    _20._m0[_746] = _733;
    _736 = uintBitsToFloat(_585(floatBitsToUint(0.0), 0u));
    _736 = uintBitsToFloat(_585(floatBitsToUint(0.0), 1u));
    _748 = _767 + 6u;
    _20._m0[_748] = _736;
    _750 = _767 + 7u;
    _20._m0[_750] = _738;
    _733 = _17._m0[gl_LocalInvocationID.x];
    uint _828 = floatBitsToUint(_733);
    uint _832 = ((_828 & 2139095040u) == 0u) ? (_828 & 2147483648u) : _828;
    uint _833 = _585(_832, 0u);
    uint _834 = _585(_832, 1u);
    _736 = uintBitsToFloat(((_833 & 2139095040u) == 0u) ? (_833 & 2147483648u) : _833);
    _738 = uintBitsToFloat(((_834 & 2139095040u) == 0u) ? (_834 & 2147483648u) : _834);
    _752 = _767 + 8u;
    _20._m0[_752] = _736;
    _754 = _767 + 9u;
    _20._m0[_754] = _738;
    _742 = _767 + 10u;
    float _854 = _733;
    float _855 = float(1);
    _733 = _854 + _855;
    uint _857 = _742;
    _742 = _857 + uint(1);
    uint _860 = _742;
    _742 = _860 + uint(1);
    uint _863 = floatBitsToUint(_854);
    uint _867 = ((_863 & 2139095040u) == 0u) ? (_863 & 2147483648u) : _863;
    uint _868 = _585(_867, 0u);
    uint _869 = _585(_867, 1u);
    _20._m0[_857] = uintBitsToFloat(((_868 & 2139095040u) == 0u) ? (_868 & 2147483648u) : _868);
    _20._m0[_860] = uintBitsToFloat(((_869 & 2139095040u) == 0u) ? (_869 & 2147483648u) : _869);
    _756 = _767 + 12u;
    _20._m0[_756] = float(_742);
    _758 = _767 + 13u;
    _20._m0[_758] = _733;
    uint _893 = floatBitsToUint(_17._m0[gl_LocalInvocationID.x]);
    uint _897 = ((_893 & 2139095040u) == 0u) ? (_893 & 2147483648u) : _893;
    uint _898 = _585(_897, 0u);
    uint _899 = _585(_897, 1u);
    _736 = uintBitsToFloat(((_898 & 2139095040u) == 0u) ? (_898 & 2147483648u) : _898);
    _736 = uintBitsToFloat(((_899 & 2139095040u) == 0u) ? (_899 & 2147483648u) : _899);
    _760 = _767 + 14u;
    _20._m0[_760] = _736;
    _762 = _767 + 15u;
    _20._m0[_762] = _738;
}

