#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

uint _13(uint _12)
{
    uint _42 = 0u;
    uint _36 = 0u;
    uint _40 = 0u;
    uint _33 = 0u;
    uint _44 = 0u;
    uint _38 = 0u;
    uvec2 _91 = uvec2(4294967295u);
    uint _49 = _12 & 2147483647u;
    if ((_49 == 0u) || (_12 == 2139095040u))
    {
        return _12;
    }
    if (((_12 & 2147483648u) != 0u) || (_49 > 2139095040u))
    {
        return 2143289344u;
    }
    uint _61 = _12 & 8388607u;
    uint _62 = _49 >> 23u;
    _33 = _61 | 8388608u;
    _36 = _62 + 127u;
    if (_62 == 0u)
    {
        uint _71 = (31u - uint(findMSB(_61))) - 8u;
        _33 = _61 << _71;
        _36 = 128u - _71;
    }
    uint _76 = _36 & 1u;
    _38 = _33 >> (9u - _76);
    _40 = _33 << (23u + _76);
    _42 = 0u;
    _44 = 0u;
    uint _46 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _91)))
        {
            break;
        }
        _91 -= uvec2(uint(_91.y == 0u), 1u);
        if (_46 >= 24u)
        {
            break;
        }
        uint _106 = _38;
        uint _109 = _44;
        uint _117 = (_109 << 2u) | (_106 >> 14u);
        uint _119 = (_42 << 2u) | 1u;
        bool _120 = _117 >= _119;
        uint _123 = _42 << 1u;
        _38 = ((_106 << 2u) | (_40 >> 30u)) & 65535u;
        _40 = _40 << 2u;
        _44 = _120 ? (_117 - _119) : _117;
        _42 = _120 ? (_123 | 1u) : _123;
        _46++;
        continue;
    }
    return ((_36 >> 1u) << 23u) | (((_44 > _42) ? (_42 + 1u) : _42) & 8388607u);
}

uint _140(uint _138, uint _139)
{
    uint _154 = 0u;
    int _147 = 0;
    int _152 = 0;
    uint _145 = 0u;
    uint _156 = 0u;
    uint _150 = 0u;
    uvec2 _233 = uvec2(4294967295u);
    uint _161 = _138 & 2147483647u;
    uint _162 = _139 & 2147483647u;
    uint _164 = (_138 ^ _139) & 2147483648u;
    uint _165 = _164 | 2139095040u;
    bool _169 = _161 == 0u;
    bool _170 = _162 == 0u;
    bool _172 = _161 == 2139095040u;
    bool _173 = _162 == 2139095040u;
    if ((((_161 > 2139095040u) || (_162 > 2139095040u)) || (_169 && _170)) || (_172 && _173))
    {
        return 2143289344u;
    }
    if (_172 || _170)
    {
        return _165;
    }
    if (_169 || _173)
    {
        return _164;
    }
    uint _185 = _161 & 8388607u;
    uint _186 = _161 >> 23u;
    _145 = _185 | 8388608u;
    _147 = int(_186) - 127;
    if (_186 == 0u)
    {
        uint _195 = (31u - uint(findMSB(_185))) - 8u;
        _145 = _185 << _195;
        _147 = (-126) - int(_195);
    }
    uint _201 = _162 & 8388607u;
    uint _202 = _162 >> 23u;
    _150 = _201 | 8388608u;
    _152 = int(_202) - 127;
    if (_202 == 0u)
    {
        uint _211 = (31u - uint(findMSB(_201))) - 8u;
        _150 = _201 << _211;
        _152 = (-126) - int(_211);
    }
    bool _217 = _145 < _150;
    int _224 = (_147 - _152) - int(_217);
    if (_224 < (-150))
    {
        return _164;
    }
    _154 = 1u;
    _156 = (_217 ? (_145 << 1u) : _145) - _150;
    uint _158 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _233)))
        {
            break;
        }
        _233 -= uvec2(uint(_233.y == 0u), 1u);
        if (_158 >= 23u)
        {
            break;
        }
        uint _248 = _156;
        uint _250 = _248 << 1u;
        bool _251 = _250 >= _150;
        _156 = _251 ? (_250 - _150) : _250;
        _154 = (_154 << 1u) | uint(_251);
        _158++;
        continue;
    }
    if (_224 < (-126))
    {
        uint _266 = uint((-126) - _224) & 31u;
        uint _267 = 1u << _266;
        uint _269 = _154 & (_267 - 1u);
        uint _270 = _267 >> 1u;
        uint _271 = _154 >> _266;
        return _164 | (_271 + uint((_269 > _270) || ((_269 == _270) && ((_156 != 0u) || ((_271 & 1u) != 0u)))));
    }
    uint _283 = _156 << 1u;
    uint _291 = _154 + uint((_283 > _150) || ((_283 == _150) && ((_154 & 1u) != 0u)));
    uint _292 = _291 >> 24u;
    int _295 = _224 + int(_292);
    if (_295 > 127)
    {
        return _165;
    }
    return _164 | ((uint(_295 + 127) << 23u) | ((_291 >> _292) & 8388607u));
}

float _320(int _319)
{
    return uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(float(_319)))))));
}

float _333(uint _332)
{
    return uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(float(_332)))))));
}

float _307(float _306)
{
    return uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_306))))));
}

int _360(bool _359)
{
    int _364 = 0;
    if (_359)
    {
        _364 = 7;
    }
    else
    {
        _364 = 9;
    }
    return _364;
}

float _374(float _372, float _373)
{
    return _372 + _373;
}

float _346(bool _345)
{
    return uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(float(_345)))))));
}

float _381(float _379, float _380)
{
    return (_379 * 10.0) + _380;
}

void main()
{
    float _492 = 0.0;
    float _486 = 0.0;
    bool _480 = false;
    uint _473 = 0u;
    uint _467 = 0u;
    uint _460 = 0u;
    uint _454 = 0u;
    uint _496 = 0u;
    uint _490 = 0u;
    float _484 = 0.0;
    float _478 = 0.0;
    uint _471 = 0u;
    float _464 = 0.0;
    uint _458 = 0u;
    uint _452 = 0u;
    bool _494 = false;
    bool _482 = false;
    bool _475 = false;
    uint _469 = 0u;
    uint _462 = 0u;
    uint _456 = 0u;
    uvec2 _908 = uvec2(4294967295u);
    _8._m0[uint(0)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.0)))))));
    float _510 = -0.0;
    _8._m0[uint(1)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_510)))))));
    _8._m0[uint(2)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(1.0)))))));
    _8._m0[uint(3)] = floatBitsToUint(_320(4));
    _8._m0[uint(4)] = floatBitsToUint(_333(9u));
    _8._m0[uint(5)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(6.25)))))));
    _8._m0[uint(6)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(2.0)))))));
    _452 = 1u;
    _8._m0[uint(7)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_452))))))));
    _454 = 8388607u;
    _8._m0[uint(8)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_454))))))));
    _456 = 8388608u;
    _8._m0[uint(9)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_456))))))));
    _458 = 2139095039u;
    _8._m0[uint(10)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_458))))))));
    _460 = 2139095040u;
    _8._m0[uint(11)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_460))))))));
    float _619 = -1.0;
    _8._m0[uint(12)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_619)))))));
    _462 = 2139095041u;
    _8._m0[uint(13)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_462))))))));
    _464 = 4.0;
    float _642 = _464;
    float _643 = float(1);
    _464 = _642 + _643;
    _8._m0[uint(14)] = floatBitsToUint(_307(_642));
    _8._m0[uint(15)] = floatBitsToUint(_464);
    _8._m0[uint(16)] = uint(_360(true));
    _8._m0[uint(17)] = uint(_360(false));
    _8._m0[uint(18)] = floatBitsToUint(_374(2.0, 3.0));
    _467 = 1065353217u;
    _8._m0[uint(19)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_467))))))));
    _469 = 1065353218u;
    _8._m0[uint(20)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_469))))))));
    _471 = 1065353215u;
    _8._m0[uint(21)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_471))))))));
    _8._m0[uint(22)] = floatBitsToUint(_333(4294967295u));
    int _705 = -4;
    _8._m0[uint(23)] = floatBitsToUint(_320(_705));
    _8._m0[uint(24)] = floatBitsToUint(_307(16.0));
    _8._m0[uint(25)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(0.25)))))));
    _473 = 2147483649u;
    _8._m0[uint(26)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(uintBitsToFloat(_473))))))));
    _8._m0[uint(27)] = floatBitsToUint(_346(false));
    _8._m0[uint(28)] = floatBitsToUint(_346(true));
    _8._m0[uint(29)] = floatBitsToUint(_307(0.5));
    _8._m0[uint(30)] = floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(2.0))));
    _8._m0[uint(31)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(2.0)))))));
    _8._m0[uint(32)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(2.0)))))));
    _464 = 4.0;
    _475 = false;
    if (_475)
    {
        float _778 = _464;
        float _779 = float(1);
        _464 = _778 + _779;
        _478 = uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_778))))));
    }
    else
    {
        float _788 = _464;
        float _789 = float(1);
        _464 = _788 + _789;
        _478 = uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_788))))));
    }
    _8._m0[uint(33)] = floatBitsToUint(_478);
    _8._m0[uint(34)] = floatBitsToUint(_464);
    _480 = false;
    if (false)
    {
        float _808 = _464;
        float _809 = float(1);
        _464 = _808 + _809;
        _480 = uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_808)))))) != 0.0;
    }
    _8._m0[uint(35)] = uint(_480);
    _482 = true;
    if (!true)
    {
        float _825 = _464;
        float _826 = float(1);
        _464 = _825 + _826;
        _482 = uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_825)))))) != 0.0;
    }
    _8._m0[uint(36)] = uint(_482);
    _8._m0[uint(37)] = floatBitsToUint(_464);
    _484 = 4.0;
    _486 = 9.0;
    float _844 = _484;
    float _845 = float(1);
    _484 = _844 + _845;
    float _854 = _486;
    float _855 = float(1);
    _486 = _854 + _855;
    _8._m0[uint(38)] = floatBitsToUint(_381(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_844)))))), uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_854))))))));
    _8._m0[uint(39)] = floatBitsToUint(_484);
    _8._m0[uint(40)] = floatBitsToUint(_486);
    float _876 = _464;
    float _877 = float(1);
    _464 = _876 + _877;
    float _885 = _464;
    float _886 = float(1);
    _464 = _885 + _886;
    _8._m0[uint(41)] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_885)))))));
    _8._m0[uint(42)] = floatBitsToUint(_464);
    int _488 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _908)))
        {
            break;
        }
        _908 -= uvec2(uint(_908.y == 0u), 1u);
        if (!(_488 < 2))
        {
            break;
        }
        if (_488 == 0)
        {
            int _942 = _488;
            _488 = _942 + 1;
            continue;
        }
        float _927 = _464;
        float _928 = float(1);
        _464 = _927 + _928;
        _490 = uint(43);
        _496 = _490;
        _8._m0[_496] = floatBitsToUint(uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_927)))))));
        int _942 = _488;
        _488 = _942 + 1;
        continue;
    }
    _8._m0[uint(44)] = floatBitsToUint(_464);
    float _948 = _464;
    float _949 = float(1);
    _464 = _948 + _949;
    _492 = uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_948))))));
    _8._m0[uint(45)] = floatBitsToUint(_492);
    _8._m0[uint(46)] = floatBitsToUint(_464);
    _494 = true;
    if (true)
    {
        float _968 = _464;
        float _969 = float(1);
        _464 = _968 + _969;
        _494 = uintBitsToFloat(_140(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_13(floatBitsToUint(_968)))))) != 0.0;
    }
    _8._m0[uint(47)] = uint(_494);
    _8._m0[uint(48)] = floatBitsToUint(_464);
}

