#version 460
layout(local_size_x = 32, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _10_9
{
    uint _m0[];
} _9;

layout(set = 0, binding = 1, std430) buffer _13_12
{
    uint _m0[];
} _12;

uint _19(uint _16, uint _17, uint _18)
{
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    int _66 = 0;
    uint _59 = 0u;
    uint _53 = 0u;
    int _82 = 0;
    uint _76 = 0u;
    int _70 = 0;
    int _63 = 0;
    uint _57 = 0u;
    uint _50 = 0u;
    uint _86 = 0u;
    int _80 = 0;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _61 = 0u;
    uint _55 = 0u;
    uint _89 = _16 & 2147483647u;
    bool _91 = _89 == 2139095040u;
    bool _92 = _89 == 0u;
    uint _93 = _17 & 2147483647u;
    bool _95 = _93 == 2139095040u;
    bool _96 = _93 == 0u;
    uint _97 = _18 & 2147483647u;
    bool _99 = _97 == 2139095040u;
    bool _100 = _97 == 0u;
    if (((_89 > 2139095040u) || (_93 > 2139095040u)) || (_97 > 2139095040u))
    {
        return 2143289344u;
    }
    if ((_92 && _95) || (_96 && _91))
    {
        return 2143289344u;
    }
    uint _111 = (_16 ^ _17) & 2147483648u;
    uint _112 = _18 & 2147483648u;
    bool _113 = _111 != _112;
    bool _114 = _91 || _95;
    if (_114 && (_99 && _113))
    {
        return 2143289344u;
    }
    if (_114)
    {
        return _111 | 2139095040u;
    }
    if (_99)
    {
        return _18;
    }
    bool _124 = _92 || _96;
    if (_124 && _100)
    {
        return _111 & _112;
    }
    if (_124)
    {
        return _18;
    }
    uint _131 = _89 >> 23u;
    bool _132 = _131 != 0u;
    uint _135 = (_89 & 8388607u) | (_132 ? 8388608u : 0u);
    uint _139 = _93 >> 23u;
    bool _140 = _139 != 0u;
    uint _143 = (_93 & 8388607u) | (_140 ? 8388608u : 0u);
    uint _147 = _97 >> 23u;
    bool _148 = _147 != 0u;
    uint _151 = (_97 & 8388607u) | (_148 ? 8388608u : 0u);
    uint _155 = _135 & 4095u;
    uint _156 = _135 >> 12u;
    uint _157 = _143 & 4095u;
    uint _158 = _143 >> 12u;
    uint _159 = _155 * _157;
    uint _164 = ((_155 * _158) + (_156 * _157)) + (_159 >> 12u);
    uint _167 = (_156 * _158) + (_164 >> 12u);
    _50 = ((_159 & 4095u) | ((_164 & 4095u) << 12u)) | (_167 << 24u);
    _53 = _167 >> 8u;
    int _187 = int((_53 != 0u) ? (63u - (31u - uint(findMSB(_53 | 1u)))) : (31u - (31u - uint(findMSB(_50 | 1u)))));
    int _188 = 50 - _187;
    uint _192 = uint(min(max(_188, 0), 31)) & 31u;
    bool _210 = _188 < 32;
    _55 = _210 ? (_50 << _192) : 0u;
    _57 = _210 ? ((_53 << _192) | ((_188 > 0) ? (_50 >> (uint(min(max((32 - _188), 0), 31)) & 31u)) : 0u)) : (_50 << (uint(min(max((_188 - 32), 0), 31)) & 31u));
    int _216 = ((int(_132 ? _131 : 1u) - 150) + (int(_140 ? _139 : 1u) - 150)) + _187;
    int _227 = int((0u != 0u) ? (63u - (31u - uint(findMSB(0u | 1u)))) : (31u - (31u - uint(findMSB(_151 | 1u)))));
    int _228 = 50 - _227;
    uint _232 = uint(min(max(_228, 0), 31)) & 31u;
    bool _250 = _228 < 32;
    _59 = _250 ? (_151 << _232) : 0u;
    _61 = _250 ? ((0u << _232) | ((_228 > 0) ? (_151 >> (uint(min(max((32 - _228), 0), 31)) & 31u)) : 0u)) : (_151 << (uint(min(max((_228 - 32), 0), 31)) & 31u));
    int _256 = _100 ? _216 : ((int(_148 ? _147 : 1u) - 150) + _227);
    bool _265 = (_216 < _256) || ((_216 == _256) && ((_57 < _61) || ((_57 == _61) && (_55 < _59))));
    uint _266 = _265 ? _59 : _55;
    uint _267 = _265 ? _61 : _57;
    uint _268 = _265 ? _55 : _59;
    uint _269 = _265 ? _57 : _61;
    _63 = _265 ? _256 : _216;
    _66 = _265 ? _216 : _256;
    _68 = _265 ? _112 : _111;
    _70 = _63 - _66;
    uint _281 = uint(min(max(_70, 0), 31)) & 31u;
    uint _303 = uint(min(max((_70 - 32), 0), 31)) & 31u;
    bool _312 = _70 < 32;
    bool _318 = _70 < 64;
    int _321 = 0 - _70;
    uint _325 = uint(min(max(_321, 0), 31)) & 31u;
    bool _343 = _321 < 32;
    bool _346 = _70 <= 0;
    _72 = _346 ? (_343 ? (_268 << _325) : 0u) : (_318 ? (_312 ? (((_268 >> _281) | ((_70 > 0) ? (_269 << (uint(min(max((32 - _70), 0), 31)) & 31u)) : 0u)) | uint((_268 & ((1u << _281) - 1u)) != 0u)) : ((_269 >> _303) | uint(((_269 & ((1u << _303) - 1u)) | _268) != 0u))) : uint((_269 | _268) != 0u));
    _74 = _346 ? (_343 ? ((_269 << _325) | ((_321 > 0) ? (_268 >> (uint(min(max((32 - _321), 0), 31)) & 31u)) : 0u)) : (_268 << (uint(min(max((_321 - 32), 0), 31)) & 31u))) : (_318 ? (_312 ? (_269 >> _281) : 0u) : 0u);
    uint _351 = _266 + _72;
    _76 = _113 ? (_266 - _72) : _351;
    _78 = _113 ? ((_267 - _74) - uint(_266 < _72)) : ((_267 + _74) + uint(_351 < _266));
    if ((_76 | _78) == 0u)
    {
        return 0u;
    }
    int _380 = _63 - 50;
    int _383 = max(((int((_78 != 0u) ? (63u - (31u - uint(findMSB(_78 | 1u)))) : (31u - (31u - uint(findMSB(_76 | 1u))))) + _380) - 23), (-149));
    _80 = _383;
    _82 = (_383 - _380) - 3;
    uint _391 = uint(min(max(_82, 0), 31)) & 31u;
    uint _413 = uint(min(max((_82 - 32), 0), 31)) & 31u;
    bool _422 = _82 < 32;
    bool _428 = _82 < 64;
    int _431 = 0 - _82;
    uint _435 = uint(min(max(_431, 0), 31)) & 31u;
    bool _453 = _431 < 32;
    bool _456 = _82 <= 0;
    _84 = _456 ? (_453 ? (_76 << _435) : 0u) : (_428 ? (_422 ? (((_76 >> _391) | ((_82 > 0) ? (_78 << (uint(min(max((32 - _82), 0), 31)) & 31u)) : 0u)) | uint((_76 & ((1u << _391) - 1u)) != 0u)) : ((_78 >> _413) | uint(((_78 & ((1u << _413) - 1u)) | _76) != 0u))) : uint((_78 | _76) != 0u));
    _86 = _456 ? (_453 ? ((_78 << _435) | ((_431 > 0) ? (_76 >> (uint(min(max((32 - _431), 0), 31)) & 31u)) : 0u)) : (_76 << (uint(min(max((_431 - 32), 0), 31)) & 31u))) : (_428 ? (_422 ? (_78 >> _391) : 0u) : 0u);
    uint _460 = _84 >> 3u;
    uint _461 = _84 & 7u;
    uint _469 = _460 + uint((_461 > 4u) || ((_461 == 4u) && ((_460 & 1u) != 0u)));
    bool _470 = _469 >= 16777216u;
    uint _472 = _470 ? (_469 >> 1u) : _469;
    int _476 = (_80 + int(_470)) + 150;
    if (_476 >= 255)
    {
        return _68 | 2139095040u;
    }
    return _68 | ((((_472 >= 8388608u) ? uint(max(_476, 0)) : 0u) << 23u) | (_472 & 8388607u));
}

float _493(float _490, float _491, float _492)
{
    return uintBitsToFloat(_19(floatBitsToUint(_490), floatBitsToUint(_491), floatBitsToUint(_492)));
}

uint _518(uint _517)
{
    uint _521 = _517 & 2147483647u;
    return (_521 > 2139095040u) ? 2143289344u : _521;
}

int _505(bool _502, bool _503, bool _504)
{
    int _509 = 0;
    if (_502)
    {
        _509 = 7;
    }
    else
    {
        _509 = 9;
    }
    return _509;
}

void main()
{
    uint _581 = 0u;
    uint _575 = 0u;
    bool _569 = false;
    uint _562 = 0u;
    int _556 = 0;
    uint _550 = 0u;
    uint _586 = 0u;
    uint _579 = 0u;
    uint _573 = 0u;
    bool _566 = false;
    uint _560 = 0u;
    uint _554 = 0u;
    uint _548 = 0u;
    float _583 = 0.0;
    uint _577 = 0u;
    uint _571 = 0u;
    uint _564 = 0u;
    uint _558 = 0u;
    uint _552 = 0u;
    uint _592 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_592 >= 4096u)
    {
        return;
    }
    uint _597 = 4u + (_592 * 10u);
    _548 = _592 * 3u;
    uint _602 = _9._m0[_548];
    float _603 = uintBitsToFloat(_602);
    _550 = (_592 * 3u) + 1u;
    uint _608 = _9._m0[_550];
    float _609 = uintBitsToFloat(_608);
    _552 = (_592 * 3u) + 2u;
    uint _614 = _9._m0[_552];
    float _615 = uintBitsToFloat(_614);
    _12._m0[_597] = floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_603), floatBitsToUint(_609), floatBitsToUint(_615))));
    _554 = _597 + 1u;
    _12._m0[_554] = floatBitsToUint(_493(_603, _609, _615));
    _556 = 0;
    int _629 = _556;
    _556 = _629 + 1;
    _560 = (_592 * 3u) + uint(_629);
    int _638 = _556;
    _556 = _638 + 1;
    _562 = (_592 * 3u) + uint(_638);
    int _647 = _556;
    _556 = _647 + 1;
    _564 = (_592 * 3u) + uint(_647);
    _558 = _597 + 2u;
    _12._m0[_558] = floatBitsToUint(_493(uintBitsToFloat(_9._m0[_560]), uintBitsToFloat(_9._m0[_562]), uintBitsToFloat(_9._m0[_564])));
    _566 = false;
    if (false)
    {
        int _662 = _556;
        _556 = _662 + 1;
        _566 = _518(floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(float(_662)), floatBitsToUint(_603), floatBitsToUint(_609))))) != 0u;
    }
    _569 = true;
    if (!true)
    {
        int _675 = _556;
        _556 = _675 + 1;
        _569 = _518(floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_603), floatBitsToUint(float(_675)), floatBitsToUint(_609))))) != 0u;
    }
    _571 = _597 + 3u;
    _12._m0[_571] = uint(_556);
    float _691 = -0.0;
    float _692 = -0.0;
    _573 = _597 + 4u;
    _12._m0[_573] = floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_691), floatBitsToUint(1.0), floatBitsToUint(_692))));
    float _702 = -0.0;
    _575 = _597 + 5u;
    _12._m0[_575] = floatBitsToUint(uintBitsToFloat(_19(floatBitsToUint(_702), floatBitsToUint(1.0), floatBitsToUint(0.0))));
    float _712 = float(2);
    float _713 = float(3u);
    float _714 = float(4);
    _577 = _597 + 6u;
    _12._m0[_577] = floatBitsToUint(_493(_712, _713, _714));
    _579 = _597 + 7u;
    _12._m0[_579] = uint(_505(true, false, true));
    if (true)
    {
        _583 = uintBitsToFloat(_19(floatBitsToUint(_603), floatBitsToUint(_609), floatBitsToUint(_615)));
    }
    else
    {
        int _733 = _556;
        _556 = _733 + 1;
        _583 = uintBitsToFloat(_19(floatBitsToUint(float(_733)), floatBitsToUint(_603), floatBitsToUint(_609)));
    }
    _581 = _597 + 8u;
    _12._m0[_581] = floatBitsToUint(_583);
    _586 = _597 + 9u;
    _12._m0[_586] = uint(_556);
}

