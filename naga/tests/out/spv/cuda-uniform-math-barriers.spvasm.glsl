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
    uint _47 = _31 & 2147483647u;
    bool _50 = (_31 & 2147483648u) != 0u;
    uint _54 = 1u << ((150u - (_47 >> 23u)) & 31u);
    uint _55 = _54 - 1u;
    uint _59 = _31 & (~_55);
    return (_47 > 2139095040u) ? 2143289344u : ((_47 >= 1258291200u) ? _31 : ((_47 < 1065353216u) ? ((_47 == 0u) ? _31 : (_50 ? 3212836864u : 0u)) : ((_50 && ((_31 & _55) != 0u)) ? (_59 + _54) : _59)));
}

uint _74(uint _73)
{
    uint _76 = _73 & 2147483647u;
    uint _77 = _73 & 2147483648u;
    uint _82 = 1u << ((150u - (_76 >> 23u)) & 31u);
    uint _83 = _82 - 1u;
    uint _87 = _73 & (~_83);
    return (_76 > 2139095040u) ? 2143289344u : ((_76 >= 1258291200u) ? _73 : ((_76 < 1065353216u) ? ((_76 == 0u) ? _73 : ((_77 != 0u) ? 2147483648u : 1065353216u)) : (((_77 == 0u) && ((_73 & _83) != 0u)) ? (_87 + _82) : _87)));
}

uint _103(uint _102)
{
    uint _106 = _102 & 2147483647u;
    uint _107 = _102 & 2147483648u;
    uint _111 = 1u << ((150u - (_106 >> 23u)) & 31u);
    uint _112 = _111 - 1u;
    uint _113 = _102 & _112;
    uint _116 = _102 & (~_112);
    return (_106 > 2139095040u) ? 2143289344u : ((_106 >= 1258291200u) ? _102 : ((_106 < 1065353216u) ? ((_106 == 0u) ? _102 : ((_106 >= 1056964608u) ? (_107 | 1065353216u) : _107)) : (((_113 >= (_111 >> 1u)) && (_113 != 0u)) ? (_116 + _111) : _116)));
}

uint _135(uint _134)
{
    uint _137 = _134 & 2147483647u;
    return (_137 > 2139095040u) ? 2143289344u : _137;
}

uint _142(uint _141)
{
    uint _161 = 0u;
    uint _155 = 0u;
    uint _159 = 0u;
    uint _152 = 0u;
    uint _163 = 0u;
    uint _157 = 0u;
    uvec2 _209 = uvec2(4294967295u);
    uint _168 = _141 & 2147483647u;
    if ((_168 == 0u) || (_141 == 2139095040u))
    {
        return _141;
    }
    if (((_141 & 2147483648u) != 0u) || (_168 > 2139095040u))
    {
        return 2143289344u;
    }
    uint _180 = _141 & 8388607u;
    uint _181 = _168 >> 23u;
    _152 = _180 | 8388608u;
    _155 = _181 + 127u;
    if (_181 == 0u)
    {
        uint _189 = (31u - uint(findMSB(_180))) - 8u;
        _152 = _180 << _189;
        _155 = 128u - _189;
    }
    uint _194 = _155 & 1u;
    _157 = _152 >> (9u - _194);
    _159 = _152 << (23u + _194);
    _161 = 0u;
    _163 = 0u;
    uint _165 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _209)))
        {
            break;
        }
        _209 -= uvec2(uint(_209.y == 0u), 1u);
        if (_165 >= 24u)
        {
            break;
        }
        uint _224 = _157;
        uint _227 = _163;
        uint _235 = (_227 << 2u) | (_224 >> 14u);
        uint _237 = (_161 << 2u) | 1u;
        bool _238 = _235 >= _237;
        uint _241 = _161 << 1u;
        _157 = ((_224 << 2u) | (_159 >> 30u)) & 65535u;
        _159 = _159 << 2u;
        _163 = _238 ? (_235 - _237) : _235;
        _161 = _238 ? (_241 | 1u) : _241;
        _165++;
        continue;
    }
    return ((_155 >> 1u) << 23u) | (((_163 > _161) ? (_161 + 1u) : _161) & 8388607u);
}

uint _258(uint _256, uint _257)
{
    uint _272 = 0u;
    int _265 = 0;
    int _270 = 0;
    uint _263 = 0u;
    uint _274 = 0u;
    uint _268 = 0u;
    uvec2 _351 = uvec2(4294967295u);
    uint _279 = _256 & 2147483647u;
    uint _280 = _257 & 2147483647u;
    uint _282 = (_256 ^ _257) & 2147483648u;
    uint _283 = _282 | 2139095040u;
    bool _287 = _279 == 0u;
    bool _288 = _280 == 0u;
    bool _290 = _279 == 2139095040u;
    bool _291 = _280 == 2139095040u;
    if ((((_279 > 2139095040u) || (_280 > 2139095040u)) || (_287 && _288)) || (_290 && _291))
    {
        return 2143289344u;
    }
    if (_290 || _288)
    {
        return _283;
    }
    if (_287 || _291)
    {
        return _282;
    }
    uint _303 = _279 & 8388607u;
    uint _304 = _279 >> 23u;
    _263 = _303 | 8388608u;
    _265 = int(_304) - 127;
    if (_304 == 0u)
    {
        uint _313 = (31u - uint(findMSB(_303))) - 8u;
        _263 = _303 << _313;
        _265 = (-126) - int(_313);
    }
    uint _319 = _280 & 8388607u;
    uint _320 = _280 >> 23u;
    _268 = _319 | 8388608u;
    _270 = int(_320) - 127;
    if (_320 == 0u)
    {
        uint _329 = (31u - uint(findMSB(_319))) - 8u;
        _268 = _319 << _329;
        _270 = (-126) - int(_329);
    }
    bool _335 = _263 < _268;
    int _342 = (_265 - _270) - int(_335);
    if (_342 < (-150))
    {
        return _282;
    }
    _272 = 1u;
    _274 = (_335 ? (_263 << 1u) : _263) - _268;
    uint _276 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _351)))
        {
            break;
        }
        _351 -= uvec2(uint(_351.y == 0u), 1u);
        if (_276 >= 23u)
        {
            break;
        }
        uint _366 = _274;
        uint _368 = _366 << 1u;
        bool _369 = _368 >= _268;
        _274 = _369 ? (_368 - _268) : _368;
        _272 = (_272 << 1u) | uint(_369);
        _276++;
        continue;
    }
    if (_342 < (-126))
    {
        uint _384 = uint((-126) - _342) & 31u;
        uint _385 = 1u << _384;
        uint _387 = _272 & (_385 - 1u);
        uint _388 = _385 >> 1u;
        uint _389 = _272 >> _384;
        return _282 | (_389 + uint((_387 > _388) || ((_387 == _388) && ((_274 != 0u) || ((_389 & 1u) != 0u)))));
    }
    uint _401 = _274 << 1u;
    uint _409 = _272 + uint((_401 > _268) || ((_401 == _268) && ((_272 & 1u) != 0u)));
    uint _410 = _409 >> 24u;
    int _413 = _342 + int(_410);
    if (_413 > 127)
    {
        return _283;
    }
    return _282 | ((uint(_413 + 127) << 23u) | ((_409 >> _410) & 8388607u));
}

uint _426(uint _424, uint _425)
{
    uint _435 = 0u;
    int _429 = 0;
    int _433 = 0;
    uint _427 = 0u;
    uint _437 = 0u;
    uint _431 = 0u;
    uvec2 _494 = uvec2(4294967295u);
    uint _440 = _424 & 2147483647u;
    uint _441 = _425 & 2147483647u;
    uint _442 = _424 & 2147483648u;
    if ((_440 >= 2139095040u) || ((_441 > 2139095040u) || (_441 == 0u)))
    {
        return 2143289344u;
    }
    if (_440 < _441)
    {
        return _424;
    }
    if (_440 == _441)
    {
        return _442;
    }
    uint _456 = _440 & 8388607u;
    uint _457 = _440 >> 23u;
    _427 = _456 | 8388608u;
    _429 = int(_457) - 127;
    if (_457 == 0u)
    {
        uint _466 = (31u - uint(findMSB(_456))) - 8u;
        _427 = _456 << _466;
        _429 = (-126) - int(_466);
    }
    uint _472 = _441 & 8388607u;
    uint _473 = _441 >> 23u;
    _431 = _472 | 8388608u;
    _433 = int(_473) - 127;
    if (_473 == 0u)
    {
        uint _482 = (31u - uint(findMSB(_472))) - 8u;
        _431 = _472 << _482;
        _433 = (-126) - int(_482);
    }
    _435 = _427;
    _437 = uint(_429 - _433);
    for (;;)
    {
        if (all(equal(uvec2(0u), _494)))
        {
            break;
        }
        _494 -= uvec2(uint(_494.y == 0u), 1u);
        if (_437 == 0u)
        {
            break;
        }
        _435 = ((_435 >= _431) ? (_435 - _431) : _435) << 1u;
        _437--;
        continue;
    }
    uint _518 = (_435 >= _431) ? (_435 - _431) : _435;
    if (_518 == 0u)
    {
        return _442;
    }
    uint _524 = (31u - uint(findMSB(_518))) - 8u;
    uint _525 = _518 << _524;
    int _527 = _433 - int(_524);
    return _442 | ((_527 >= (-126)) ? ((uint(_527 + 127) << 23u) | (_525 & 8388607u)) : (_525 >> (uint((-126) - _527) & 31u)));
}

uint[22] _649(uint _647[2], uint _648[20])
{
    uint _663[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _660 = 0u;
    uint _654[2] = uint[](0u, 0u);
    uint _656[20] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _658[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _670 = uvec2(4294967295u);
    uvec2 _691 = uvec2(4294967295u);
    uvec2 _729 = uvec2(4294967295u);
    _654 = _647;
    _656 = _648;
    uint _661 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _670)))
        {
            break;
        }
        _670 -= uvec2(uint(_670.y == 0u), 1u);
        if (_661 >= 2u)
        {
            break;
        }
        _660 = 0u;
        uint _662 = 0u;
        for (;;)
        {
            if (all(equal(uvec2(0u), _691)))
            {
                break;
            }
            _691 -= uvec2(uint(_691.y == 0u), 1u);
            if (_662 >= 20u)
            {
                break;
            }
            uint _708 = _661 + _662;
            uint _710 = _658[_708];
            uint _714 = ((_654[_661] * _656[_662]) + _710) + _660;
            _658[_708] = _714 & 65535u;
            _660 = _714 >> 16u;
            _662++;
            continue;
        }
        _658[_661 + 20u] = _660;
        _661++;
        continue;
    }
    uint _664 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _729)))
        {
            break;
        }
        _729 -= uvec2(uint(_729.y == 0u), 1u);
        if (_664 >= 22u)
        {
            break;
        }
        _663[_664] = _658[_664 + 0u];
        _664++;
        continue;
    }
    return _663;
}

uint _751(uint _752, uint _753)
{
    return _752 / ((_753 == 0u) ? 1u : _753);
}

uint _758(uint _759, uint _760)
{
    return _759 % ((_760 == 0u) ? 1u : _760);
}

uint _859(uint _857[22], uint _858)
{
    uint _861[22] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _862 = 0u;
    uint _863 = 0u;
    _861 = _857;
    uint _865 = _751(_858, 16u);
    uint _866 = _758(_858, 16u);
    uint _867 = _865 + 0u;
    if (_867 < 22u)
    {
        _862 = _861[_867];
    }
    uint _873 = _865 + 1u;
    if (_873 < 22u)
    {
        _863 = _861[_873];
    }
    return ((_862 >> _866) | (_863 << (16u - _866))) & 65535u;
}

uint[12] _810(uint _807[12], uint _808[12], uint _809)
{
    uint _813[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _815 = 0u;
    uint _812[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _814[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _823 = uvec2(4294967295u);
    _812 = _807;
    _813 = _808;
    bool _818 = _809 != 0u;
    uint _816 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _823)))
        {
            break;
        }
        _823 -= uvec2(uint(_823.y == 0u), 1u);
        if (_816 >= 12u)
        {
            break;
        }
        uint _843 = _813[_816] + _815;
        uint _845 = _812[_816] + _843;
        _814[_816] = (_818 ? (_812[_816] - _843) : _845) & 65535u;
        _815 = _818 ? uint(_812[_816] < _843) : (_845 >> 16u);
        _816++;
        continue;
    }
    return _814;
}

uint[12] _543(uint _541[12], uint _542[12])
{
    uint _558[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _555 = 0u;
    uint _550[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _552[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _553[24] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _565 = uvec2(4294967295u);
    uvec2 _586 = uvec2(4294967295u);
    uvec2 _624 = uvec2(4294967295u);
    _550 = _541;
    _552 = _542;
    uint _556 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _565)))
        {
            break;
        }
        _565 -= uvec2(uint(_565.y == 0u), 1u);
        if (_556 >= 12u)
        {
            break;
        }
        _555 = 0u;
        uint _557 = 0u;
        for (;;)
        {
            if (all(equal(uvec2(0u), _586)))
            {
                break;
            }
            _586 -= uvec2(uint(_586.y == 0u), 1u);
            if (_557 >= 12u)
            {
                break;
            }
            uint _603 = _556 + _557;
            uint _605 = _553[_603];
            uint _609 = ((_550[_556] * _552[_557]) + _605) + _555;
            _553[_603] = _609 & 65535u;
            _555 = _609 >> 16u;
            _557++;
            continue;
        }
        _553[_556 + 12u] = _555;
        _556++;
        continue;
    }
    uint _559 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _624)))
        {
            break;
        }
        _624 -= uvec2(uint(_624.y == 0u), 1u);
        if (_559 >= 12u)
        {
            break;
        }
        _558[_559] = _553[_559 + 11u];
        _559++;
        continue;
    }
    return _558;
}

uint[12] _768(uint _766[12], uint _767)
{
    uint _771[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _770[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _772 = 0u;
    uvec2 _779 = uvec2(4294967295u);
    _770 = _766;
    uint _773 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _779)))
        {
            break;
        }
        _779 -= uvec2(uint(_779.y == 0u), 1u);
        if (_773 >= 12u)
        {
            break;
        }
        uint _794 = 11u - _773;
        uint _799 = (_772 << 16u) | _770[_794];
        _771[_794] = _751(_799, _767);
        _772 = _758(_799, _767);
        _773++;
        continue;
    }
    return _771;
}

uint[12] _919(uint _917[12], uint _918)
{
    uint _921[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _922[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _935 = uvec2(4294967295u);
    bool _925 = _918 != 0u;
    if (_925)
    {
        _921 = _917;
    }
    else
    {
        _921 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u);
    }
    _922 = _921;
    uint _930[12] = _543(_917, _917);
    uint _923 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _935)))
        {
            break;
        }
        _935 -= uvec2(uint(_935.y == 0u), 1u);
        if (_923 >= 8u)
        {
            break;
        }
        uint _950 = _923 + 1u;
        uint _951 = _950 * 2u;
        uint _958[12] = _768(_543(_921, _930), _951 * (_925 ? (_951 + 1u) : (_951 - 1u)));
        _921 = _958;
        _922 = _810(_922, _958, _950 & 1u);
        _923++;
        continue;
    }
    return _922;
}

uint _889(uint _887[12], uint _888)
{
    uint _891[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _892 = 0u;
    uint _893 = 0u;
    _891 = _887;
    uint _895 = _751(_888, 16u);
    uint _896 = _758(_888, 16u);
    uint _897 = _895 + 0u;
    if (_897 < 12u)
    {
        _892 = _891[_897];
    }
    uint _903 = _895 + 1u;
    if (_903 < 12u)
    {
        _893 = _891[_903];
    }
    return ((_892 >> _896) | (_893 << (16u - _896))) & 65535u;
}

uint _967(uint _966[12])
{
    uint _977 = 0u;
    uint _974 = 0u;
    uint _973[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uint _975 = 0u;
    uvec2 _984 = uvec2(4294967295u);
    uvec2 _1038 = uvec2(4294967295u);
    _973 = _966;
    uint _976 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _984)))
        {
            break;
        }
        _984 -= uvec2(uint(_984.y == 0u), 1u);
        if (_976 >= 12u)
        {
            break;
        }
        _975 |= _973[_976];
        if (_973[_976] != 0u)
        {
            _974 = (_976 * 16u) + (31u - (31u - uint(findMSB(_973[_976]))));
        }
        _976++;
        continue;
    }
    if (_975 == 0u)
    {
        return 0u;
    }
    uint _1020 = (_974 >= 50u) ? (_974 - 23u) : 27u;
    uint _1025 = _889(_966, _1020) | (_889(_966, _1020 + 16u) << 16u);
    uint _1026 = _1020 - 1u;
    uint _1030 = _751(_1026, 16u);
    uint _1033 = (1u << _758(_1026, 16u)) - 1u;
    uint _978 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _1038)))
        {
            break;
        }
        _1038 -= uvec2(uint(_1038.y == 0u), 1u);
        if (_978 >= 12u)
        {
            break;
        }
        _977 |= (_973[_978] & ((_978 < _1030) ? 65535u : ((_978 == _1030) ? _1033 : 0u)));
        _978++;
        continue;
    }
    uint _1070 = _1025 + uint(((_889(_966, _1026) & 1u) != 0u) && ((_977 | (_1025 & 1u)) != 0u));
    if (_974 < 50u)
    {
        return _1070;
    }
    bool _1074 = _1070 == 16777216u;
    uint _1077 = _974 - 49u;
    return ((_1074 ? (_1077 + 1u) : _1077) << 23u) | ((_1074 ? (_1070 >> 1u) : _1070) & 8388607u);
}

uint _1086(uint _1084, uint _1085)
{
    uint _1126 = 0u;
    uint _1127[12] = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    uvec2 _1154 = uvec2(4294967295u);
    uint _1130 = _1084 & 2147483647u;
    if (_1130 >= 2139095040u)
    {
        return 2143289344u;
    }
    bool _1134 = _1085 != 0u;
    if (_1130 <= 956301312u)
    {
        return _1134 ? 1065353216u : _1084;
    }
    uint _1140 = 470u - (_1130 >> 23u);
    uint _1142 = (_1130 & 8388607u) | 8388608u;
    uint _1146[22] = _649(uint[](_1142 & 65535u, _1142 >> 16u), uint[](53984u, 16973u, 28218u, 46884u, 50529u, 57019u, 25515u, 65105u, 36929u, 15427u, 38297u, 56162u, 56768u, 62772u, 22481u, 64551u, 5417u, 20036u, 33646u, 41721u));
    _1126 = _859(_1146, _1140) & 3u;
    uint _1149 = _1140 - 176u;
    uint _1128 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _1154)))
        {
            break;
        }
        _1154 -= uvec2(uint(_1154.y == 0u), 1u);
        if (_1128 >= 11u)
        {
            break;
        }
        _1127[_1128] = _859(_1146, _1149 + (_1128 * 16u));
        _1128++;
        continue;
    }
    uint _1176 = _1127[10u];
    bool _1177 = _1176 >= 32768u;
    if (_1177)
    {
        _1126 = (_1126 + 1u) & 3u;
        _1127 = _810(uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 1u), _1127, 1u);
    }
    bool _1189 = (_1126 & 1u) == _1085;
    return _967(_919(_543(_1127, uint[](5327u, 39953u, 20996u, 14754u, 440u, 50455u, 35212u, 33897u, 17105u, 46404u, 37407u, 1u)), uint(_1189))) | ((((_1177 && _1189) ? 2147483648u : 0u) ^ (((_1134 ? (_1126 + 1u) : _1126) & 2u) << 30u)) ^ (_1134 ? 0u : (_1084 & 2147483648u)));
}

void main()
{
    uint _1222 = 0u;
    uint _1224 = 0u;
    uint _1226 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _28 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    _28[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 1u;
    _1222 = 1u;
    _1222 = 0u;
    if (uintBitsToFloat(_32(floatBitsToUint(_22._m0._m0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1222 |= 1u;
    }
    if (uintBitsToFloat(_74(floatBitsToUint(_22._m0._m0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1222 |= 2u;
    }
    if (uintBitsToFloat(_103(floatBitsToUint(_22._m0._m0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1222 |= 4u;
    }
    if (uintBitsToFloat(_135(floatBitsToUint(_22._m0._m0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1222 |= 8u;
    }
    if (uintBitsToFloat(_142(floatBitsToUint(_22._m0._m0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1222 |= 16u;
    }
    if (uintBitsToFloat(_258(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_142(floatBitsToUint(_22._m0._m0)))))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1222 |= 32u;
    }
    if (uintBitsToFloat(_426(floatBitsToUint(_22._m0._m0), floatBitsToUint(2.0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1222 |= 64u;
    }
    if (uintBitsToFloat(_258(floatBitsToUint(_22._m0._m0), floatBitsToUint(2.0))) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1222 |= 128u;
    }
    if (uintBitsToFloat(_1086(floatBitsToUint(_22._m0._m0), 0u)) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1222 |= 256u;
    }
    if (uintBitsToFloat(_1086(floatBitsToUint(_22._m0._m0), 1u)) > 0.0)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _1222 |= 512u;
    }
    _1224 = 4u + (gl_LocalInvocationID.x * 2u);
    _25._m0[_1224] = _28[(gl_LocalInvocationID.x + 1u) & 3u];
    _1226 = 5u + (gl_LocalInvocationID.x * 2u);
    _25._m0[_1226] = _1222;
}

