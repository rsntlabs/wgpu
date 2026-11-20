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
    uint _56 = _55 | 2139095040u;
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
        return _56;
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
        uint _163 = uint((-126) - _115) & 31u;
        uint _164 = 1u << _163;
        uint _166 = _45 & (_164 - 1u);
        uint _167 = _164 >> 1u;
        uint _168 = _45 >> _163;
        return _55 | (_168 + uint((_166 > _167) || ((_166 == _167) && ((_47 != 0u) || ((_168 & 1u) != 0u)))));
    }
    uint _180 = _47 << 1u;
    uint _188 = _45 + uint((_180 > _41) || ((_180 == _41) && ((_45 & 1u) != 0u)));
    uint _189 = _188 >> 24u;
    int _192 = _115 + int(_189);
    if (_192 > 127)
    {
        return _56;
    }
    return _55 | ((uint(_192 + 127) << 23u) | ((_188 >> _189) & 8388607u));
}

float _205(float _203, float _204)
{
    return uintBitsToFloat(_18(floatBitsToUint(_203), floatBitsToUint(_204)));
}

uint _228(uint _227)
{
    uint _231 = _227 & 2147483647u;
    return (_231 > 2139095040u) ? 2143289344u : _231;
}

int _215(bool _213, bool _214)
{
    int _219 = 0;
    if (_213)
    {
        _219 = 7;
    }
    else
    {
        _219 = 9;
    }
    return _219;
}

void main()
{
    uint _331 = 0u;
    uint _325 = 0u;
    uint _319 = 0u;
    uint _313 = 0u;
    uint _307 = 0u;
    uint _301 = 0u;
    uint _295 = 0u;
    uint _289 = 0u;
    uint _282 = 0u;
    int _276 = 0;
    uint _270 = 0u;
    uint _327 = 0u;
    uint _321 = 0u;
    uint _315 = 0u;
    uint _309 = 0u;
    uint _303 = 0u;
    uint _297 = 0u;
    uint _291 = 0u;
    bool _284 = false;
    uint _278 = 0u;
    uint _272 = 0u;
    uint _329 = 0u;
    uint _323 = 0u;
    uint _317 = 0u;
    uint _311 = 0u;
    int _305 = 0;
    uint _299 = 0u;
    uint _293 = 0u;
    bool _287 = false;
    uint _280 = 0u;
    uint _274 = 0u;
    uint _337 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_337 >= 4096u)
    {
        return;
    }
    uint _342 = 4u + (_337 * 16u);
    _270 = _337 * 2u;
    uint _347 = _9._m0[_270];
    float _348 = uintBitsToFloat(_347);
    _272 = (_337 * 2u) + 1u;
    uint _353 = _9._m0[_272];
    float _354 = uintBitsToFloat(_353);
    _12._m0[_342] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_348), floatBitsToUint(_354))));
    _274 = _342 + 1u;
    _12._m0[_274] = floatBitsToUint(_205(_348, _354));
    _276 = 0;
    int _367 = _276;
    _276 = _367 + 1;
    _280 = (_337 * 2u) + uint(_367);
    int _376 = _276;
    _276 = _376 + 1;
    _282 = (_337 * 2u) + uint(_376);
    _278 = _342 + 2u;
    _12._m0[_278] = floatBitsToUint(_205(uintBitsToFloat(_9._m0[_280]), uintBitsToFloat(_9._m0[_282])));
    _284 = false;
    if (false)
    {
        int _391 = _276;
        _276 = _391 + 1;
        _284 = _228(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(float(_391)), floatBitsToUint(_348))))) != 0u;
    }
    _287 = true;
    if (!true)
    {
        int _403 = _276;
        _276 = _403 + 1;
        _287 = _228(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_348), floatBitsToUint(float(_403)))))) != 0u;
    }
    _289 = _342 + 3u;
    _12._m0[_289] = uint(_276);
    float _418 = -0.0;
    float _419 = -0.0;
    _291 = _342 + 4u;
    _12._m0[_291] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_418), floatBitsToUint(_419))));
    float _428 = -0.0;
    _293 = _342 + 5u;
    _12._m0[_293] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_428), floatBitsToUint(0.0))));
    float _437 = float(2);
    float _438 = float(3u);
    _295 = _342 + 6u;
    _12._m0[_295] = floatBitsToUint(_205(_437, _438));
    _297 = _342 + 7u;
    _12._m0[_297] = uint(_215(true, false));
    _299 = _342 + 8u;
    _12._m0[_299] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_354), floatBitsToUint(_348))));
    _301 = _342 + 9u;
    _12._m0[_301] = floatBitsToUint(_205(1.0, 3.0));
    uint _463 = floatBitsToUint(_354);
    uint _464 = _463 & 2147483647u;
    _303 = _342 + 10u;
    _12._m0[_303] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(_348), ((_464 > 2122317824u) && (_464 < 2139095040u)) ? ((_463 & 2147483648u) | 2139095040u) : _463)));
    _305 = 0;
    int _478 = _305;
    _305 = _478 + 1;
    _309 = (_337 * 2u) + uint(_478);
    int _487 = _305;
    _305 = _487 + 1;
    _311 = (_337 * 2u) + uint(_487);
    uint _496 = floatBitsToUint(uintBitsToFloat(_9._m0[_311]));
    uint _497 = _496 & 2147483647u;
    _307 = _342 + 11u;
    _12._m0[_307] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(uintBitsToFloat(_9._m0[_309])), ((_497 > 2122317824u) && (_497 < 2139095040u)) ? ((_496 & 2147483648u) | 2139095040u) : _496)));
    _313 = _342 + 12u;
    _12._m0[_313] = uint(_305);
    _317 = 2122317824u;
    _319 = 2122317823u;
    uint _520 = floatBitsToUint(uintBitsToFloat(_319));
    uint _521 = _520 & 2147483647u;
    _315 = _342 + 13u;
    _12._m0[_315] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(uintBitsToFloat(_317)), ((_521 > 2122317824u) && (_521 < 2139095040u)) ? ((_520 & 2147483648u) | 2139095040u) : _520)));
    _323 = 2122317824u;
    _325 = 2122317824u;
    uint _539 = floatBitsToUint(uintBitsToFloat(_325));
    uint _540 = _539 & 2147483647u;
    _321 = _342 + 14u;
    _12._m0[_321] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(uintBitsToFloat(_323)), ((_540 > 2122317824u) && (_540 < 2139095040u)) ? ((_539 & 2147483648u) | 2139095040u) : _539)));
    _329 = 2122317824u;
    _331 = 2122317825u;
    uint _558 = floatBitsToUint(uintBitsToFloat(_331));
    uint _559 = _558 & 2147483647u;
    _327 = _342 + 15u;
    _12._m0[_327] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(uintBitsToFloat(_329)), ((_559 > 2122317824u) && (_559 < 2139095040u)) ? ((_558 & 2147483648u) | 2139095040u) : _558)));
}

