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

void main()
{
    uint _340 = 0u;
    uint _334 = 0u;
    uint _328 = 0u;
    bool _322 = false;
    bool _315 = false;
    uint _308 = 0u;
    uint _302 = 0u;
    uint _296 = 0u;
    uint _290 = 0u;
    uint _284 = 0u;
    uint _278 = 0u;
    uint _272 = 0u;
    uint _342 = 0u;
    uint _336 = 0u;
    bool _330 = false;
    float _324 = 0.0;
    float _318 = 0.0;
    float _310 = 0.0;
    uint _304 = 0u;
    uint _298 = 0u;
    uint _292 = 0u;
    uint _286 = 0u;
    uint _280 = 0u;
    uint _274 = 0u;
    uint _344 = 0u;
    uint _338 = 0u;
    uint _332 = 0u;
    bool _320 = false;
    float _313 = 0.0;
    uint _306 = 0u;
    uint _300 = 0u;
    uint _294 = 0u;
    uint _288 = 0u;
    uint _282 = 0u;
    uint _276 = 0u;
    uvec2 _749 = uvec2(4294967295u);
    _8._m0[uint(0)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(5.5), floatBitsToUint(2.0))));
    float _355 = -5.5;
    _8._m0[uint(1)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_355), floatBitsToUint(2.0))));
    float _363 = -2.0;
    _8._m0[uint(2)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(5.5), floatBitsToUint(_363))));
    float _371 = -5.5;
    float _372 = -2.0;
    _8._m0[uint(3)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_371), floatBitsToUint(_372))));
    _8._m0[uint(4)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(4.0), floatBitsToUint(2.0))));
    float _387 = -4.0;
    _8._m0[uint(5)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_387), floatBitsToUint(2.0))));
    float _395 = -2.0;
    _8._m0[uint(6)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(0.0), floatBitsToUint(_395))));
    float _403 = -0.0;
    _8._m0[uint(7)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_403), floatBitsToUint(2.0))));
    _8._m0[uint(8)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(1.0), floatBitsToUint(3.0))));
    _8._m0[uint(9)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(3.0), floatBitsToUint(1.0))));
    _272 = 2139095039u;
    _274 = 1u;
    _8._m0[uint(10)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_272)), floatBitsToUint(uintBitsToFloat(_274)))));
    _276 = 4286578687u;
    _278 = 1u;
    _8._m0[uint(11)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_276)), floatBitsToUint(uintBitsToFloat(_278)))));
    _280 = 8388608u;
    _282 = 3u;
    _8._m0[uint(12)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_280)), floatBitsToUint(uintBitsToFloat(_282)))));
    _284 = 8388607u;
    _286 = 3u;
    _8._m0[uint(13)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_284)), floatBitsToUint(uintBitsToFloat(_286)))));
    _288 = 1u;
    _290 = 8388608u;
    _8._m0[uint(14)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_288)), floatBitsToUint(uintBitsToFloat(_290)))));
    _292 = 1065353217u;
    _8._m0[uint(15)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_292)), floatBitsToUint(1.0))));
    _294 = 1065353217u;
    _8._m0[uint(16)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_294)))));
    _296 = 2139095041u;
    _8._m0[uint(17)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_296)), floatBitsToUint(2.0))));
    _298 = 2143363909u;
    _8._m0[uint(18)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_298)))));
    _300 = 2139095040u;
    _8._m0[uint(19)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_300)), floatBitsToUint(2.0))));
    _302 = 4286578688u;
    _304 = 2139095040u;
    _8._m0[uint(20)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_302)), floatBitsToUint(uintBitsToFloat(_304)))));
    _8._m0[uint(21)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(1.0), floatBitsToUint(0.0))));
    _8._m0[uint(22)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(0.0), floatBitsToUint(0.0))));
    _306 = 2139095040u;
    _8._m0[uint(23)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(5.5), floatBitsToUint(uintBitsToFloat(_306)))));
    float _559 = -5.5;
    _308 = 4286578688u;
    _8._m0[uint(24)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_559), floatBitsToUint(uintBitsToFloat(_308)))));
    float _569 = float(7);
    float _570 = float(3);
    _8._m0[uint(25)] = floatBitsToUint(_153(_569, _570));
    float _575 = float(7u);
    float _576 = float(3u);
    _8._m0[uint(26)] = floatBitsToUint(_153(_575, _576));
    _8._m0[uint(27)] = floatBitsToUint(_153(float(true), float(true)));
    _8._m0[uint(28)] = floatBitsToUint(_153(float(false), float(true)));
    _8._m0[uint(29)] = uint(_163(true, false));
    _8._m0[uint(30)] = uint(_163(false, true));
    _8._m0[uint(31)] = floatBitsToUint(_178(1.0, 2.0, 3.0));
    _310 = 5.5;
    float _605 = _310;
    float _606 = float(1);
    _310 = _605 + _606;
    _8._m0[uint(32)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_605), floatBitsToUint(2.0))));
    _8._m0[uint(33)] = floatBitsToUint(_310);
    _313 = 2.0;
    float _619 = _313;
    float _620 = float(1);
    _313 = _619 + _620;
    _8._m0[uint(34)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(7.0), floatBitsToUint(_619))));
    _8._m0[uint(35)] = floatBitsToUint(_313);
    _310 = 5.5;
    float _633 = _310;
    float _634 = float(1);
    _310 = _633 + _634;
    float _636 = _310;
    float _637 = float(1);
    _310 = _636 + _637;
    _8._m0[uint(36)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_633), floatBitsToUint(_636))));
    _8._m0[uint(37)] = floatBitsToUint(_310);
    _315 = false;
    if (_315)
    {
        float _654 = _310;
        float _655 = float(1);
        _310 = _654 + _655;
        _318 = uintBitsToFloat(_14(floatBitsToUint(_654), floatBitsToUint(2.0)));
    }
    else
    {
        float _661 = _310;
        float _662 = float(1);
        _310 = _661 + _662;
        _318 = uintBitsToFloat(_14(floatBitsToUint(_661), floatBitsToUint(3.0)));
    }
    _8._m0[uint(38)] = floatBitsToUint(_318);
    _8._m0[uint(39)] = floatBitsToUint(_310);
    _320 = false;
    if (false)
    {
        float _678 = _310;
        float _679 = float(1);
        _310 = _678 + _679;
        _320 = uintBitsToFloat(_14(floatBitsToUint(_678), floatBitsToUint(2.0))) != 0.0;
    }
    _8._m0[uint(40)] = uint(_320);
    _322 = true;
    if (!true)
    {
        float _692 = _310;
        float _693 = float(1);
        _310 = _692 + _693;
        _322 = uintBitsToFloat(_14(floatBitsToUint(_692), floatBitsToUint(2.0))) != 0.0;
    }
    _8._m0[uint(41)] = uint(_322);
    _8._m0[uint(42)] = floatBitsToUint(_310);
    float _708 = _310;
    float _709 = float(1);
    _310 = _708 + _709;
    float _714 = _310;
    float _715 = float(1);
    _310 = _714 + _715;
    _8._m0[uint(43)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_714), floatBitsToUint(3.0))));
    _8._m0[uint(44)] = floatBitsToUint(_310);
    float _728 = _310;
    float _729 = float(1);
    _310 = _728 + _729;
    _324 = uintBitsToFloat(_14(floatBitsToUint(_728), floatBitsToUint(3.0)));
    _8._m0[uint(45)] = floatBitsToUint(_324);
    _8._m0[uint(46)] = floatBitsToUint(_310);
    int _326 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _749)))
        {
            break;
        }
        _749 -= uvec2(uint(_749.y == 0u), 1u);
        if (!(_326 < 2))
        {
            break;
        }
        if (_326 == 0)
        {
            int _780 = _326;
            _326 = _780 + 1;
            continue;
        }
        float _768 = _310;
        float _769 = float(1);
        _310 = _768 + _769;
        _328 = uint(47);
        _344 = _328;
        _8._m0[_344] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_768), floatBitsToUint(2.0))));
        int _780 = _326;
        _326 = _780 + 1;
        continue;
    }
    _8._m0[uint(48)] = floatBitsToUint(_310);
    _330 = true;
    if (true)
    {
        float _788 = _310;
        float _789 = float(1);
        _310 = _788 + _789;
        _330 = uintBitsToFloat(_14(floatBitsToUint(_788), floatBitsToUint(2.0))) != 0.0;
    }
    _8._m0[uint(49)] = uint(_330);
    _8._m0[uint(50)] = floatBitsToUint(_310);
    float _804 = float(4294967295u);
    float _805 = float(3u);
    _8._m0[uint(51)] = floatBitsToUint(_153(_804, _805));
    int _810 = -2147483647;
    float _813 = float(3);
    _8._m0[uint(52)] = floatBitsToUint(_153(float(_810 - 1), _813));
    _8._m0[uint(53)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(0.5), floatBitsToUint(0.25))));
    float _825 = -0.5;
    _8._m0[uint(54)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_825), floatBitsToUint(0.25))));
    _332 = 2147483647u;
    _8._m0[uint(55)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_332)), floatBitsToUint(1.0))));
    _8._m0[uint(56)] = floatBitsToUint(_153(3.25, 2.0));
    _8._m0[uint(57)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(1.5), floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(5.5), floatBitsToUint(2.0)))))));
    _8._m0[uint(58)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(8.5), floatBitsToUint(3.0)))), floatBitsToUint(2.0))));
    float _868 = -0.0;
    _334 = 2139095040u;
    _8._m0[uint(59)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(_868), floatBitsToUint(uintBitsToFloat(_334)))));
    _336 = 1u;
    _338 = 4286578688u;
    _8._m0[uint(60)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_336)), floatBitsToUint(uintBitsToFloat(_338)))));
    _340 = 8388609u;
    _342 = 8388607u;
    _8._m0[uint(61)] = floatBitsToUint(uintBitsToFloat(_14(floatBitsToUint(uintBitsToFloat(_340)), floatBitsToUint(uintBitsToFloat(_342)))));
}

