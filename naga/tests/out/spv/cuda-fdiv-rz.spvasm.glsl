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
    uint _45 = 0u;
    int _38 = 0;
    int _43 = 0;
    uint _35 = 0u;
    uint _47 = 0u;
    uint _41 = 0u;
    uvec2 _130 = uvec2(4294967295u);
    uint _52 = _16 & 2147483647u;
    uint _53 = _17 & 2147483647u;
    uint _55 = (_16 ^ _17) & 2147483648u;
    bool _60 = _52 == 0u;
    bool _61 = _53 == 0u;
    bool _63 = _52 == 2139095040u;
    bool _64 = _53 == 2139095040u;
    if ((((_52 > 2139095040u) || (_53 > 2139095040u)) || (_60 && _61)) || (_63 && _64))
    {
        return 2143289344u;
    }
    if (_63 || _61)
    {
        return _55 | 2139095040u;
    }
    if (_60 || _64)
    {
        return _55;
    }
    uint _76 = _52 & 8388607u;
    uint _77 = _52 >> 23u;
    _35 = _76 | 8388608u;
    _38 = int(_77) - 127;
    if (_77 == 0u)
    {
        uint _86 = (31u - uint(findMSB(_76))) - 8u;
        _35 = _76 << _86;
        _38 = (-126) - int(_86);
    }
    uint _92 = _53 & 8388607u;
    uint _93 = _53 >> 23u;
    _41 = _92 | 8388608u;
    _43 = int(_93) - 127;
    if (_93 == 0u)
    {
        uint _102 = (31u - uint(findMSB(_92))) - 8u;
        _41 = _92 << _102;
        _43 = (-126) - int(_102);
    }
    bool _108 = _35 < _41;
    int _115 = (_38 - _43) - int(_108);
    if (_115 < (-150))
    {
        return _55;
    }
    _45 = 1u;
    _47 = (_108 ? (_35 << 1u) : _35) - _41;
    uint _49 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _130)))
        {
            break;
        }
        _130 -= uvec2(uint(_130.y == 0u), 1u);
        if (_49 >= 23u)
        {
            break;
        }
        uint _145 = _47;
        uint _147 = _145 << 1u;
        bool _148 = _147 >= _41;
        _47 = _148 ? (_147 - _41) : _147;
        _45 = (_45 << 1u) | uint(_148);
        _49++;
        continue;
    }
    if (_115 < (-126))
    {
        return _55 | (_45 >> (uint((-126) - _115) & 31u));
    }
    if (_115 > 127)
    {
        return _55 | 2139095039u;
    }
    return _55 | ((uint(_115 + 127) << 23u) | (_45 & 8388607u));
}

float _178(float _176, float _177)
{
    return uintBitsToFloat(_18(floatBitsToUint(_176), floatBitsToUint(_177)));
}

uint _201(uint _200)
{
    uint _204 = _200 & 2147483647u;
    return (_204 > 2139095040u) ? 2143289344u : _204;
}

int _188(bool _186, bool _187)
{
    int _192 = 0;
    if (_186)
    {
        _192 = 7;
    }
    else
    {
        _192 = 9;
    }
    return _192;
}

uint _210(uint _208, uint _209)
{
    uint _220 = 0u;
    int _214 = 0;
    int _218 = 0;
    uint _212 = 0u;
    uint _222 = 0u;
    uint _216 = 0u;
    uvec2 _297 = uvec2(4294967295u);
    uint _227 = _208 & 2147483647u;
    uint _228 = _209 & 2147483647u;
    uint _230 = (_208 ^ _209) & 2147483648u;
    uint _231 = _230 | 2139095040u;
    bool _235 = _227 == 0u;
    bool _236 = _228 == 0u;
    bool _238 = _227 == 2139095040u;
    bool _239 = _228 == 2139095040u;
    if ((((_227 > 2139095040u) || (_228 > 2139095040u)) || (_235 && _236)) || (_238 && _239))
    {
        return 2143289344u;
    }
    if (_238 || _236)
    {
        return _231;
    }
    if (_235 || _239)
    {
        return _230;
    }
    uint _251 = _227 & 8388607u;
    uint _252 = _227 >> 23u;
    _212 = _251 | 8388608u;
    _214 = int(_252) - 127;
    if (_252 == 0u)
    {
        uint _261 = (31u - uint(findMSB(_251))) - 8u;
        _212 = _251 << _261;
        _214 = (-126) - int(_261);
    }
    uint _267 = _228 & 8388607u;
    uint _268 = _228 >> 23u;
    _216 = _267 | 8388608u;
    _218 = int(_268) - 127;
    if (_268 == 0u)
    {
        uint _277 = (31u - uint(findMSB(_267))) - 8u;
        _216 = _267 << _277;
        _218 = (-126) - int(_277);
    }
    bool _283 = _212 < _216;
    int _288 = (_214 - _218) - int(_283);
    if (_288 < (-150))
    {
        return _230;
    }
    _220 = 1u;
    _222 = (_283 ? (_212 << 1u) : _212) - _216;
    uint _224 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _297)))
        {
            break;
        }
        _297 -= uvec2(uint(_297.y == 0u), 1u);
        if (_224 >= 23u)
        {
            break;
        }
        uint _312 = _222;
        uint _314 = _312 << 1u;
        bool _315 = _314 >= _216;
        _222 = _315 ? (_314 - _216) : _314;
        _220 = (_220 << 1u) | uint(_315);
        _224++;
        continue;
    }
    if (_288 < (-126))
    {
        uint _330 = uint((-126) - _288) & 31u;
        uint _331 = 1u << _330;
        uint _333 = _220 & (_331 - 1u);
        uint _334 = _331 >> 1u;
        uint _335 = _220 >> _330;
        return _230 | (_335 + uint((_333 > _334) || ((_333 == _334) && ((_222 != 0u) || ((_335 & 1u) != 0u)))));
    }
    uint _347 = _222 << 1u;
    uint _355 = _220 + uint((_347 > _216) || ((_347 == _216) && ((_220 & 1u) != 0u)));
    uint _356 = _355 >> 24u;
    int _359 = _288 + int(_356);
    if (_359 > 127)
    {
        return _231;
    }
    return _230 | ((uint(_359 + 127) << 23u) | ((_355 >> _356) & 8388607u));
}

void main()
{
    uint _428 = 0u;
    uint _421 = 0u;
    uint _415 = 0u;
    bool _408 = false;
    uint _402 = 0u;
    uint _396 = 0u;
    float _425 = 0.0;
    uint _419 = 0u;
    uint _413 = 0u;
    uint _406 = 0u;
    int _400 = 0;
    uint _394 = 0u;
    uint _423 = 0u;
    uint _417 = 0u;
    bool _411 = false;
    uint _404 = 0u;
    uint _398 = 0u;
    uint _434 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_434 >= 4096u)
    {
        return;
    }
    uint _439 = 4u + (_434 * 10u);
    _394 = _434 * 2u;
    uint _444 = _9._m0[_394];
    float _445 = uintBitsToFloat(_444);
    _396 = (_434 * 2u) + 1u;
    uint _450 = _9._m0[_396];
    float _451 = uintBitsToFloat(_450);
    _12._m0[_439] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_445), floatBitsToUint(_451))));
    _398 = _439 + 1u;
    _12._m0[_398] = floatBitsToUint(_178(_445, _451));
    _400 = 0;
    int _464 = _400;
    _400 = _464 + 1;
    _404 = (_434 * 2u) + uint(_464);
    int _473 = _400;
    _400 = _473 + 1;
    _406 = (_434 * 2u) + uint(_473);
    _402 = _439 + 2u;
    _12._m0[_402] = floatBitsToUint(_178(uintBitsToFloat(_9._m0[_404]), uintBitsToFloat(_9._m0[_406])));
    _408 = false;
    if (false)
    {
        int _488 = _400;
        _400 = _488 + 1;
        _408 = _201(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(float(_488)), floatBitsToUint(_445))))) != 0u;
    }
    _411 = true;
    if (!true)
    {
        int _500 = _400;
        _400 = _500 + 1;
        _411 = _201(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_445), floatBitsToUint(float(_500)))))) != 0u;
    }
    _413 = _439 + 3u;
    _12._m0[_413] = uint(_400);
    float _515 = -0.0;
    float _516 = -0.0;
    _415 = _439 + 4u;
    _12._m0[_415] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_515), floatBitsToUint(_516))));
    float _525 = -0.0;
    _417 = _439 + 5u;
    _12._m0[_417] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_525), floatBitsToUint(0.0))));
    float _534 = float(2);
    float _535 = float(3u);
    _419 = _439 + 6u;
    _12._m0[_419] = floatBitsToUint(_178(_534, _535));
    _421 = _439 + 7u;
    _12._m0[_421] = uint(_188(true, false));
    if (true)
    {
        _425 = uintBitsToFloat(_18(floatBitsToUint(_445), floatBitsToUint(_451)));
    }
    else
    {
        int _553 = _400;
        _400 = _553 + 1;
        _425 = uintBitsToFloat(_18(floatBitsToUint(float(_553)), floatBitsToUint(_445)));
    }
    _423 = _439 + 8u;
    _12._m0[_423] = floatBitsToUint(_425);
    _428 = _439 + 9u;
    _12._m0[_428] = floatBitsToUint(uintBitsToFloat(_210(floatBitsToUint(_445), floatBitsToUint(_451))));
}

