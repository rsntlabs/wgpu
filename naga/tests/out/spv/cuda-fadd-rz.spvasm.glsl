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

void main()
{
    uint _335 = 0u;
    uint _328 = 0u;
    uint _322 = 0u;
    bool _315 = false;
    uint _309 = 0u;
    uint _303 = 0u;
    float _332 = 0.0;
    uint _326 = 0u;
    uint _320 = 0u;
    uint _313 = 0u;
    int _307 = 0;
    uint _300 = 0u;
    uint _330 = 0u;
    uint _324 = 0u;
    bool _318 = false;
    uint _311 = 0u;
    uint _305 = 0u;
    uint _341 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_341 >= 4096u)
    {
        return;
    }
    uint _346 = 4u + (_341 * 10u);
    _300 = _341 * 2u;
    uint _351 = _9._m0[_300];
    float _352 = uintBitsToFloat(_351);
    _303 = (_341 * 2u) + 1u;
    uint _357 = _9._m0[_303];
    float _358 = uintBitsToFloat(_357);
    _12._m0[_346] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_352), floatBitsToUint(_358))));
    _305 = _346 + 1u;
    _12._m0[_305] = floatBitsToUint(_133(_352, _358));
    _307 = 0;
    int _371 = _307;
    _307 = _371 + 1;
    _311 = (_341 * 2u) + uint(_371);
    int _380 = _307;
    _307 = _380 + 1;
    _313 = (_341 * 2u) + uint(_380);
    _309 = _346 + 2u;
    _12._m0[_309] = floatBitsToUint(_133(uintBitsToFloat(_9._m0[_311]), uintBitsToFloat(_9._m0[_313])));
    _315 = false;
    if (false)
    {
        int _395 = _307;
        _307 = _395 + 1;
        _315 = _157(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(float(_395)), floatBitsToUint(_352))))) != 0u;
    }
    _318 = true;
    if (!true)
    {
        int _407 = _307;
        _307 = _407 + 1;
        _318 = _157(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_352), floatBitsToUint(float(_407)))))) != 0u;
    }
    _320 = _346 + 3u;
    _12._m0[_320] = uint(_307);
    float _422 = -0.0;
    float _423 = -0.0;
    _322 = _346 + 4u;
    _12._m0[_322] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_422), floatBitsToUint(_423))));
    float _432 = -0.0;
    _324 = _346 + 5u;
    _12._m0[_324] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_432), floatBitsToUint(0.0))));
    float _441 = float(1);
    float _442 = float(2u);
    _326 = _346 + 6u;
    _12._m0[_326] = floatBitsToUint(_133(_441, _442));
    _328 = _346 + 7u;
    _12._m0[_328] = uint(_143(true, false));
    if (true)
    {
        _332 = uintBitsToFloat(_18(floatBitsToUint(_352), floatBitsToUint(_358)));
    }
    else
    {
        int _460 = _307;
        _307 = _460 + 1;
        _332 = uintBitsToFloat(_18(floatBitsToUint(float(_460)), floatBitsToUint(_352)));
    }
    _330 = _346 + 8u;
    _12._m0[_330] = floatBitsToUint(_332);
    _335 = _346 + 9u;
    _12._m0[_335] = floatBitsToUint(uintBitsToFloat(_166(floatBitsToUint(_352), floatBitsToUint(_358))));
}

