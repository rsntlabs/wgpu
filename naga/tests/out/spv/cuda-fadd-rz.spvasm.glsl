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

uint _18(uint _16, uint _17)
{
    uint _37 = _16 & 2147483647u;
    uint _38 = _17 & 2147483647u;
    uint _39 = _16 & 2147483648u;
    uint _40 = _17 & 2147483648u;
    if ((_37 > 2139095040u) || (_38 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _46 = _37 == 2139095040u;
    bool _47 = _38 == 2139095040u;
    if ((_46 && _47) && (_39 != _40))
    {
        return 2143289344u;
    }
    if (_46)
    {
        return _16;
    }
    if (_47)
    {
        return _17;
    }
    bool _58 = _37 >= _38;
    uint _59 = _58 ? _37 : _38;
    uint _60 = _58 ? _38 : _37;
    uint _61 = _58 ? _39 : _40;
    uint _62 = _59 >> 23u;
    uint _63 = _60 >> 23u;
    bool _64 = _62 != 0u;
    bool _65 = _63 != 0u;
    uint _72 = ((_59 & 8388607u) | (_64 ? 8388608u : 0u)) << 3u;
    uint _73 = ((_60 & 8388607u) | (_65 ? 8388608u : 0u)) << 3u;
    uint _74 = _64 ? _62 : 1u;
    uint _76 = _74 - (_65 ? _63 : 1u);
    uint _77 = _76 & 31u;
    uint _88 = (_76 < 32u) ? ((_73 >> _77) | uint((_73 & ((1u << _77) - 1u)) != 0u)) : uint(_73 != 0u);
    uint _91 = (_39 == _40) ? (_72 + _88) : (_72 - _88);
    if (_91 == 0u)
    {
        return _39 & _40;
    }
    bool _96 = _91 >= 134217728u;
    uint _97 = 1u & 31u;
    uint _109 = _96 ? ((1u < 32u) ? ((_91 >> _97) | uint((_91 & ((1u << _97) - 1u)) != 0u)) : uint(_91 != 0u)) : _91;
    uint _111 = _74 + uint(_96);
    uint _116 = min(((31u - uint(findMSB(_109))) - 5u), (_111 - 1u));
    uint _118 = _111 - _116;
    uint _119 = (_109 << _116) >> 3u;
    if (_118 >= 255u)
    {
        return _61 | 2139095039u;
    }
    return _61 | ((((_119 >= 8388608u) ? _118 : 0u) << 23u) | (_119 & 8388607u));
}

float _133(float _131, float _132)
{
    return uintBitsToFloat(_18(floatBitsToUint(_131), floatBitsToUint(_132)));
}

uint _157(uint _156)
{
    uint _160 = _156 & 2147483647u;
    return (_160 > 2139095040u) ? 2143289344u : _160;
}

int _143(bool _141, bool _142)
{
    int _147 = 0;
    if (_141)
    {
        _147 = 7;
    }
    else
    {
        _147 = 9;
    }
    return _147;
}

uint _166(uint _164, uint _165)
{
    uint _171 = _164 & 2147483647u;
    uint _172 = _165 & 2147483647u;
    uint _173 = _164 & 2147483648u;
    uint _174 = _165 & 2147483648u;
    if ((_171 > 2139095040u) || (_172 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _180 = _171 == 2139095040u;
    bool _181 = _172 == 2139095040u;
    if ((_180 && _181) && (_173 != _174))
    {
        return 2143289344u;
    }
    if (_180)
    {
        return _164;
    }
    if (_181)
    {
        return _165;
    }
    bool _192 = _171 >= _172;
    uint _193 = _192 ? _171 : _172;
    uint _194 = _192 ? _172 : _171;
    uint _195 = _192 ? _173 : _174;
    uint _196 = _193 >> 23u;
    uint _197 = _194 >> 23u;
    bool _198 = _196 != 0u;
    bool _199 = _197 != 0u;
    uint _206 = ((_193 & 8388607u) | (_198 ? 8388608u : 0u)) << 3u;
    uint _207 = ((_194 & 8388607u) | (_199 ? 8388608u : 0u)) << 3u;
    uint _208 = _198 ? _196 : 1u;
    uint _210 = _208 - (_199 ? _197 : 1u);
    uint _211 = _210 & 31u;
    uint _222 = (_210 < 32u) ? ((_207 >> _211) | uint((_207 & ((1u << _211) - 1u)) != 0u)) : uint(_207 != 0u);
    uint _225 = (_173 == _174) ? (_206 + _222) : (_206 - _222);
    if (_225 == 0u)
    {
        return _173 & _174;
    }
    bool _230 = _225 >= 134217728u;
    uint _231 = 1u & 31u;
    uint _243 = _230 ? ((1u < 32u) ? ((_225 >> _231) | uint((_225 & ((1u << _231) - 1u)) != 0u)) : uint(_225 != 0u)) : _225;
    uint _245 = _208 + uint(_230);
    uint _250 = min(((31u - uint(findMSB(_243))) - 5u), (_245 - 1u));
    uint _251 = _243 << _250;
    uint _253 = _251 & 7u;
    uint _254 = _251 >> 3u;
    uint _262 = _254 + uint((_253 > 4u) || ((_253 == 4u) && ((_254 & 1u) != 0u)));
    bool _263 = _262 >= 16777216u;
    uint _265 = _263 ? (_262 >> 1u) : _262;
    uint _267 = (_245 - _250) + uint(_263);
    if (_267 >= 255u)
    {
        return _195 | 2139095040u;
    }
    return _195 | ((((_265 >= 8388608u) ? _267 : 0u) << 23u) | (_265 & 8388607u));
}

uint _281(uint _279, uint _280)
{
    uint _283 = _279 & 2147483647u;
    uint _284 = _280 & 2147483647u;
    uint _285 = _279 & 2147483648u;
    uint _286 = _280 & 2147483648u;
    if ((_283 > 2139095040u) || (_284 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _292 = _283 == 2139095040u;
    bool _293 = _284 == 2139095040u;
    if ((_292 && _293) && (_285 != _286))
    {
        return 2143289344u;
    }
    if (_292)
    {
        return _279;
    }
    if (_293)
    {
        return _280;
    }
    bool _304 = _283 >= _284;
    uint _305 = _304 ? _283 : _284;
    uint _306 = _304 ? _284 : _283;
    uint _307 = _304 ? _285 : _286;
    uint _308 = _305 >> 23u;
    uint _309 = _306 >> 23u;
    bool _310 = _308 != 0u;
    bool _311 = _309 != 0u;
    uint _318 = ((_305 & 8388607u) | (_310 ? 8388608u : 0u)) << 3u;
    uint _319 = ((_306 & 8388607u) | (_311 ? 8388608u : 0u)) << 3u;
    uint _320 = _310 ? _308 : 1u;
    uint _322 = _320 - (_311 ? _309 : 1u);
    uint _323 = _322 & 31u;
    uint _334 = (_322 < 32u) ? ((_319 >> _323) | uint((_319 & ((1u << _323) - 1u)) != 0u)) : uint(_319 != 0u);
    uint _337 = (_285 == _286) ? (_318 + _334) : (_318 - _334);
    if (_337 == 0u)
    {
        return _285 | _286;
    }
    bool _342 = _337 >= 134217728u;
    uint _343 = 1u & 31u;
    uint _355 = _342 ? ((1u < 32u) ? ((_337 >> _343) | uint((_337 & ((1u << _343) - 1u)) != 0u)) : uint(_337 != 0u)) : _337;
    uint _357 = _320 + uint(_342);
    uint _362 = min(((31u - uint(findMSB(_355))) - 5u), (_357 - 1u));
    uint _363 = _355 << _362;
    bool _365 = _307 != 0u;
    uint _371 = (_363 >> 3u) + uint(_365 && ((_363 & 7u) > 0u));
    bool _372 = _371 >= 16777216u;
    uint _374 = _372 ? (_371 >> 1u) : _371;
    uint _376 = (_357 - _362) + uint(_372);
    if (_376 >= 255u)
    {
        return _307 | (_365 ? 2139095040u : 2139095039u);
    }
    return _307 | ((((_374 >= 8388608u) ? _376 : 0u) << 23u) | (_374 & 8388607u));
}

uint _391(uint _389, uint _390)
{
    uint _393 = _389 & 2147483647u;
    uint _394 = _390 & 2147483647u;
    uint _395 = _389 & 2147483648u;
    uint _396 = _390 & 2147483648u;
    if ((_393 > 2139095040u) || (_394 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _402 = _393 == 2139095040u;
    bool _403 = _394 == 2139095040u;
    if ((_402 && _403) && (_395 != _396))
    {
        return 2143289344u;
    }
    if (_402)
    {
        return _389;
    }
    if (_403)
    {
        return _390;
    }
    bool _414 = _393 >= _394;
    uint _415 = _414 ? _393 : _394;
    uint _416 = _414 ? _394 : _393;
    uint _417 = _414 ? _395 : _396;
    uint _418 = _415 >> 23u;
    uint _419 = _416 >> 23u;
    bool _420 = _418 != 0u;
    bool _421 = _419 != 0u;
    uint _428 = ((_415 & 8388607u) | (_420 ? 8388608u : 0u)) << 3u;
    uint _429 = ((_416 & 8388607u) | (_421 ? 8388608u : 0u)) << 3u;
    uint _430 = _420 ? _418 : 1u;
    uint _432 = _430 - (_421 ? _419 : 1u);
    uint _433 = _432 & 31u;
    uint _444 = (_432 < 32u) ? ((_429 >> _433) | uint((_429 & ((1u << _433) - 1u)) != 0u)) : uint(_429 != 0u);
    uint _447 = (_395 == _396) ? (_428 + _444) : (_428 - _444);
    if (_447 == 0u)
    {
        return _395 & _396;
    }
    bool _452 = _447 >= 134217728u;
    uint _453 = 1u & 31u;
    uint _465 = _452 ? ((1u < 32u) ? ((_447 >> _453) | uint((_447 & ((1u << _453) - 1u)) != 0u)) : uint(_447 != 0u)) : _447;
    uint _467 = _430 + uint(_452);
    uint _472 = min(((31u - uint(findMSB(_465))) - 5u), (_467 - 1u));
    uint _473 = _465 << _472;
    bool _475 = _417 == 0u;
    uint _481 = (_473 >> 3u) + uint(_475 && ((_473 & 7u) > 0u));
    bool _482 = _481 >= 16777216u;
    uint _484 = _482 ? (_481 >> 1u) : _481;
    uint _486 = (_467 - _472) + uint(_482);
    if (_486 >= 255u)
    {
        return _417 | (_475 ? 2139095040u : 2139095039u);
    }
    return _417 | ((((_484 >= 8388608u) ? _486 : 0u) << 23u) | (_484 & 8388607u));
}

void main()
{
    uint _597 = 0u;
    uint _591 = 0u;
    uint _585 = 0u;
    uint _579 = 0u;
    uint _573 = 0u;
    uint _567 = 0u;
    float _560 = 0.0;
    uint _554 = 0u;
    uint _548 = 0u;
    uint _541 = 0u;
    int _535 = 0;
    uint _528 = 0u;
    uint _593 = 0u;
    uint _587 = 0u;
    uint _581 = 0u;
    uint _575 = 0u;
    uint _569 = 0u;
    uint _563 = 0u;
    uint _556 = 0u;
    uint _550 = 0u;
    bool _543 = false;
    uint _537 = 0u;
    uint _531 = 0u;
    uint _595 = 0u;
    uint _589 = 0u;
    uint _583 = 0u;
    uint _577 = 0u;
    uint _571 = 0u;
    int _565 = 0;
    uint _558 = 0u;
    uint _552 = 0u;
    bool _546 = false;
    uint _539 = 0u;
    uint _533 = 0u;
    uint _603 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_603 >= 4096u)
    {
        return;
    }
    uint _608 = 4u + (_603 * 18u);
    _528 = _603 * 2u;
    uint _613 = _9._m0[_528];
    float _614 = uintBitsToFloat(_613);
    _531 = (_603 * 2u) + 1u;
    uint _619 = _9._m0[_531];
    float _620 = uintBitsToFloat(_619);
    _12._m0[_608] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_614), floatBitsToUint(_620))));
    _533 = _608 + 1u;
    _12._m0[_533] = floatBitsToUint(_133(_614, _620));
    _535 = 0;
    int _633 = _535;
    _535 = _633 + 1;
    _539 = (_603 * 2u) + uint(_633);
    int _642 = _535;
    _535 = _642 + 1;
    _541 = (_603 * 2u) + uint(_642);
    _537 = _608 + 2u;
    _12._m0[_537] = floatBitsToUint(_133(uintBitsToFloat(_9._m0[_539]), uintBitsToFloat(_9._m0[_541])));
    _543 = false;
    if (false)
    {
        int _657 = _535;
        _535 = _657 + 1;
        _543 = _157(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(float(_657)), floatBitsToUint(_614))))) != 0u;
    }
    _546 = true;
    if (!true)
    {
        int _669 = _535;
        _535 = _669 + 1;
        _546 = _157(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_614), floatBitsToUint(float(_669)))))) != 0u;
    }
    _548 = _608 + 3u;
    _12._m0[_548] = uint(_535);
    float _684 = -0.0;
    float _685 = -0.0;
    _550 = _608 + 4u;
    _12._m0[_550] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_684), floatBitsToUint(_685))));
    float _694 = -0.0;
    _552 = _608 + 5u;
    _12._m0[_552] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_694), floatBitsToUint(0.0))));
    float _703 = float(1);
    float _704 = float(2u);
    _554 = _608 + 6u;
    _12._m0[_554] = floatBitsToUint(_133(_703, _704));
    _556 = _608 + 7u;
    _12._m0[_556] = uint(_143(true, false));
    if (true)
    {
        _560 = uintBitsToFloat(_18(floatBitsToUint(_614), floatBitsToUint(_620)));
    }
    else
    {
        int _722 = _535;
        _535 = _722 + 1;
        _560 = uintBitsToFloat(_18(floatBitsToUint(float(_722)), floatBitsToUint(_614)));
    }
    _558 = _608 + 8u;
    _12._m0[_558] = floatBitsToUint(_560);
    _563 = _608 + 9u;
    _12._m0[_563] = floatBitsToUint(uintBitsToFloat(_166(floatBitsToUint(_614), floatBitsToUint(_620))));
    _565 = 0;
    int _743 = _565;
    _565 = _743 + 1;
    _569 = (_603 * 2u) + uint(_743);
    int _752 = _565;
    _565 = _752 + 1;
    _571 = (_603 * 2u) + uint(_752);
    _567 = _608 + 10u;
    _12._m0[_567] = floatBitsToUint(uintBitsToFloat(_281(floatBitsToUint(uintBitsToFloat(_9._m0[_569])), floatBitsToUint(uintBitsToFloat(_9._m0[_571])))));
    _573 = _608 + 11u;
    _12._m0[_573] = uint(_565);
    _565 = 0;
    int _774 = _565;
    _565 = _774 + 1;
    _577 = (_603 * 2u) + uint(_774);
    int _783 = _565;
    _565 = _783 + 1;
    _579 = (_603 * 2u) + uint(_783);
    _575 = _608 + 12u;
    _12._m0[_575] = floatBitsToUint(uintBitsToFloat(_391(floatBitsToUint(uintBitsToFloat(_9._m0[_577])), floatBitsToUint(uintBitsToFloat(_9._m0[_579])))));
    _581 = _608 + 13u;
    _12._m0[_581] = uint(_565);
    _565 = 0;
    int _805 = _565;
    _565 = _805 + 1;
    _585 = (_603 * 2u) + uint(_805);
    int _814 = _565;
    _565 = _814 + 1;
    _587 = (_603 * 2u) + uint(_814);
    _583 = _608 + 14u;
    _12._m0[_583] = floatBitsToUint(uintBitsToFloat(_281(floatBitsToUint(uintBitsToFloat(_9._m0[_585])), floatBitsToUint(uintBitsToFloat(_9._m0[_587])) ^ 2147483648u)));
    _589 = _608 + 15u;
    _12._m0[_589] = uint(_565);
    _565 = 0;
    int _837 = _565;
    _565 = _837 + 1;
    _593 = (_603 * 2u) + uint(_837);
    int _846 = _565;
    _565 = _846 + 1;
    _595 = (_603 * 2u) + uint(_846);
    _591 = _608 + 16u;
    _12._m0[_591] = floatBitsToUint(uintBitsToFloat(_391(floatBitsToUint(uintBitsToFloat(_9._m0[_593])), floatBitsToUint(uintBitsToFloat(_9._m0[_595])) ^ 2147483648u)));
    _597 = _608 + 17u;
    _12._m0[_597] = uint(_565);
}

