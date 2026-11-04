#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

uint _14(uint _12, uint _13)
{
    uint _39 = 0u;
    int _32 = 0;
    int _37 = 0;
    uint _29 = 0u;
    uint _41 = 0u;
    uint _35 = 0u;
    uvec2 _104 = uvec2(4294967295u);
    uint _44 = _12 & 2147483647u;
    uint _45 = _13 & 2147483647u;
    uint _46 = _12 & 2147483648u;
    if ((_44 >= 2139095040u) || ((_45 > 2139095040u) || (_45 == 0u)))
    {
        return 2143289344u;
    }
    if (_44 < _45)
    {
        return _12;
    }
    if (_44 == _45)
    {
        return _46;
    }
    uint _60 = _44 & 8388607u;
    uint _61 = _44 >> 23u;
    _29 = _60 | 8388608u;
    _32 = int(_61) - 127;
    if (_61 == 0u)
    {
        uint _70 = (31u - uint(findMSB(_60))) - 8u;
        _29 = _60 << _70;
        _32 = (-126) - int(_70);
    }
    uint _76 = _45 & 8388607u;
    uint _77 = _45 >> 23u;
    _35 = _76 | 8388608u;
    _37 = int(_77) - 127;
    if (_77 == 0u)
    {
        uint _86 = (31u - uint(findMSB(_76))) - 8u;
        _35 = _76 << _86;
        _37 = (-126) - int(_86);
    }
    _39 = _29;
    _41 = uint(_32 - _37);
    for (;;)
    {
        if (all(equal(uvec2(0u), _104)))
        {
            break;
        }
        _104 -= uvec2(uint(_104.y == 0u), 1u);
        if (_41 == 0u)
        {
            break;
        }
        _39 = ((_39 >= _35) ? (_39 - _35) : _39) << 1u;
        _41--;
        continue;
    }
    uint _128 = (_39 >= _35) ? (_39 - _35) : _39;
    if (_128 == 0u)
    {
        return _46;
    }
    uint _134 = (31u - uint(findMSB(_128))) - 8u;
    uint _135 = _128 << _134;
    int _137 = _37 - int(_134);
    return _46 | ((_137 >= (-126)) ? ((uint(_137 + 127) << 23u) | (_135 & 8388607u)) : (_135 >> (uint((-126) - _137) & 31u)));
}

float _153(float _151, float _152)
{
    return uintBitsToFloat(_14(floatBitsToUint(_151), floatBitsToUint(_152)));
}

int _163(bool _161, bool _162)
{
    int _167 = 0;
    if (_161)
    {
        _167 = 7;
    }
    else
    {
        _167 = 9;
    }
    return _167;
}

float _178(float _175, float _176, float _177)
{
    return (_175 + _176) + _177;
}

uint _185(uint _184)
{
    uint _188 = _184 & 2147483647u;
    return (_188 > 2139095040u) ? 2143289344u : _188;
}

void main()
{
    uint _348 = 0u;
    uint _342 = 0u;
    uint _336 = 0u;
    bool _330 = false;
    bool _323 = false;
    uint _316 = 0u;
    uint _310 = 0u;
    uint _304 = 0u;
    uint _298 = 0u;
    uint _292 = 0u;
    uint _286 = 0u;
    uint _280 = 0u;
    uint _350 = 0u;
    uint _344 = 0u;
    bool _338 = false;
    float _332 = 0.0;
    float _326 = 0.0;
    float _318 = 0.0;
    uint _312 = 0u;
    uint _306 = 0u;
    uint _300 = 0u;
    uint _294 = 0u;
    uint _288 = 0u;
    uint _282 = 0u;
    uint _352 = 0u;
    uint _346 = 0u;
    uint _340 = 0u;
    bool _328 = false;
    float _321 = 0.0;
    uint _314 = 0u;
    uint _308 = 0u;
    uint _302 = 0u;
    uint _296 = 0u;
    uint _290 = 0u;
    uint _284 = 0u;
    uvec2 _761 = uvec2(4294967295u);
    _8._m0[uint(0)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(5.5), floatBitsToUint(2.0))));
    float _363 = -5.5;
    _8._m0[uint(1)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_363), floatBitsToUint(2.0))));
    float _371 = -2.0;
    _8._m0[uint(2)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(5.5), floatBitsToUint(_371))));
    float _379 = -5.5;
    float _380 = -2.0;
    _8._m0[uint(3)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_379), floatBitsToUint(_380))));
    _8._m0[uint(4)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(4.0), floatBitsToUint(2.0))));
    float _395 = -4.0;
    _8._m0[uint(5)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_395), floatBitsToUint(2.0))));
    float _403 = -2.0;
    _8._m0[uint(6)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(0.0), floatBitsToUint(_403))));
    float _411 = -0.0;
    _8._m0[uint(7)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_411), floatBitsToUint(2.0))));
    _8._m0[uint(8)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(1.0), floatBitsToUint(3.0))));
    _8._m0[uint(9)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(3.0), floatBitsToUint(1.0))));
    _280 = 2139095039u;
    _282 = 1u;
    _8._m0[uint(10)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_280)), floatBitsToUint(uintBitsToFloat(_282)))));
    _284 = 4286578687u;
    _286 = 1u;
    _8._m0[uint(11)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_284)), floatBitsToUint(uintBitsToFloat(_286)))));
    _288 = 8388608u;
    _290 = 3u;
    _8._m0[uint(12)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_288)), floatBitsToUint(uintBitsToFloat(_290)))));
    _292 = 8388607u;
    _294 = 3u;
    _8._m0[uint(13)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_292)), floatBitsToUint(uintBitsToFloat(_294)))));
    _296 = 1u;
    _298 = 8388608u;
    _8._m0[uint(14)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_296)), floatBitsToUint(uintBitsToFloat(_298)))));
    _300 = 1065353217u;
    _8._m0[uint(15)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_300)), floatBitsToUint(1.0))));
    _302 = 1065353217u;
    _8._m0[uint(16)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_302)))));
    _304 = 2139095041u;
    _8._m0[uint(17)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_304)), floatBitsToUint(2.0))));
    _306 = 2143363909u;
    _8._m0[uint(18)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_306)))));
    _308 = 2139095040u;
    _8._m0[uint(19)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_308)), floatBitsToUint(2.0))));
    _310 = 4286578688u;
    _312 = 2139095040u;
    _8._m0[uint(20)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_310)), floatBitsToUint(uintBitsToFloat(_312)))));
    _8._m0[uint(21)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(1.0), floatBitsToUint(0.0))));
    _8._m0[uint(22)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(0.0), floatBitsToUint(0.0))));
    _314 = 2139095040u;
    _8._m0[uint(23)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(5.5), floatBitsToUint(uintBitsToFloat(_314)))));
    float _567 = -5.5;
    _316 = 4286578688u;
    _8._m0[uint(24)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_567), floatBitsToUint(uintBitsToFloat(_316)))));
    float _577 = float(7);
    float _578 = float(3);
    _8._m0[uint(25)] = floatBitsToUint(_153(_577, _578));
    float _583 = float(7u);
    float _584 = float(3u);
    _8._m0[uint(26)] = floatBitsToUint(_153(_583, _584));
    _8._m0[uint(27)] = floatBitsToUint(_153(float(true), float(true)));
    _8._m0[uint(28)] = floatBitsToUint(_153(float(false), float(true)));
    _8._m0[uint(29)] = uint(_163(true, false));
    _8._m0[uint(30)] = uint(_163(false, true));
    _8._m0[uint(31)] = floatBitsToUint(_178(1.0, 2.0, 3.0));
    _318 = 5.5;
    float _613 = _318;
    float _614 = float(1);
    _318 = _613 + _614;
    _8._m0[uint(32)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_613), floatBitsToUint(2.0))));
    _8._m0[uint(33)] = floatBitsToUint(_318);
    _321 = 2.0;
    float _627 = _321;
    float _628 = float(1);
    _321 = _627 + _628;
    _8._m0[uint(34)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(7.0), floatBitsToUint(_627))));
    _8._m0[uint(35)] = floatBitsToUint(_321);
    _318 = 5.5;
    float _641 = _318;
    float _642 = float(1);
    _318 = _641 + _642;
    float _644 = _318;
    float _645 = float(1);
    _318 = _644 + _645;
    _8._m0[uint(36)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_641), floatBitsToUint(_644))));
    _8._m0[uint(37)] = floatBitsToUint(_318);
    _323 = false;
    if (_323)
    {
        float _662 = _318;
        float _663 = float(1);
        _318 = _662 + _663;
        _326 = uintBitsToFloat(_14(floatBitsToUint(_662), floatBitsToUint(2.0)));
    }
    else
    {
        float _669 = _318;
        float _670 = float(1);
        _318 = _669 + _670;
        _326 = uintBitsToFloat(_14(floatBitsToUint(_669), floatBitsToUint(3.0)));
    }
    _8._m0[uint(38)] = floatBitsToUint(_326);
    _8._m0[uint(39)] = floatBitsToUint(_318);
    _328 = false;
    if (false)
    {
        float _686 = _318;
        float _687 = float(1);
        _318 = _686 + _687;
        _328 = _185(floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_686), floatBitsToUint(2.0))))) != 0u;
    }
    _8._m0[uint(40)] = uint(_328);
    _330 = true;
    if (!true)
    {
        float _702 = _318;
        float _703 = float(1);
        _318 = _702 + _703;
        _330 = _185(floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_702), floatBitsToUint(2.0))))) != 0u;
    }
    _8._m0[uint(41)] = uint(_330);
    _8._m0[uint(42)] = floatBitsToUint(_318);
    float _720 = _318;
    float _721 = float(1);
    _318 = _720 + _721;
    float _726 = _318;
    float _727 = float(1);
    _318 = _726 + _727;
    _8._m0[uint(43)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_726), floatBitsToUint(3.0))));
    _8._m0[uint(44)] = floatBitsToUint(_318);
    float _740 = _318;
    float _741 = float(1);
    _318 = _740 + _741;
    _332 = uintBitsToFloat(_14(floatBitsToUint(_740), floatBitsToUint(3.0)));
    _8._m0[uint(45)] = floatBitsToUint(_332);
    _8._m0[uint(46)] = floatBitsToUint(_318);
    int _334 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _761)))
        {
            break;
        }
        _761 -= uvec2(uint(_761.y == 0u), 1u);
        if (!(_334 < 2))
        {
            break;
        }
        if (_334 == 0)
        {
            int _792 = _334;
            _334 = _792 + 1;
            continue;
        }
        float _780 = _318;
        float _781 = float(1);
        _318 = _780 + _781;
        _336 = uint(47);
        _352 = _336;
        _8._m0[_352] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_780), floatBitsToUint(2.0))));
        int _792 = _334;
        _334 = _792 + 1;
        continue;
    }
    _8._m0[uint(48)] = floatBitsToUint(_318);
    _338 = true;
    if (true)
    {
        float _800 = _318;
        float _801 = float(1);
        _318 = _800 + _801;
        _338 = _185(floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_800), floatBitsToUint(2.0))))) != 0u;
    }
    _8._m0[uint(49)] = uint(_338);
    _8._m0[uint(50)] = floatBitsToUint(_318);
    float _818 = float(4294967295u);
    float _819 = float(3u);
    _8._m0[uint(51)] = floatBitsToUint(_153(_818, _819));
    int _824 = -2147483647;
    float _827 = float(3);
    _8._m0[uint(52)] = floatBitsToUint(_153(float(_824 - 1), _827));
    _8._m0[uint(53)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(0.5), floatBitsToUint(0.25))));
    float _839 = -0.5;
    _8._m0[uint(54)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_839), floatBitsToUint(0.25))));
    _340 = 2147483647u;
    _8._m0[uint(55)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_340)), floatBitsToUint(1.0))));
    _8._m0[uint(56)] = floatBitsToUint(_153(3.25, 2.0));
    _8._m0[uint(57)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(1.5), floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(5.5), floatBitsToUint(2.0)))))));
    _8._m0[uint(58)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(8.5), floatBitsToUint(3.0)))), floatBitsToUint(2.0))));
    float _882 = -0.0;
    _342 = 2139095040u;
    _8._m0[uint(59)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_882), floatBitsToUint(uintBitsToFloat(_342)))));
    _344 = 1u;
    _346 = 4286578688u;
    _8._m0[uint(60)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_344)), floatBitsToUint(uintBitsToFloat(_346)))));
    _348 = 8388609u;
    _350 = 8388607u;
    _8._m0[uint(61)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_348)), floatBitsToUint(uintBitsToFloat(_350)))));
}

