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

float _177(float _176)
{
    return uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(_176)));
}

uint _200(uint _199)
{
    uint _203 = _199 & 2147483647u;
    return (_203 > 2139095040u) ? 2143289344u : _203;
}

int _187(bool _186)
{
    int _191 = 0;
    if (_186)
    {
        _191 = 7;
    }
    else
    {
        _191 = 9;
    }
    return _191;
}

uint _209(uint _207, uint _208)
{
    uint _219 = 0u;
    int _213 = 0;
    int _217 = 0;
    uint _211 = 0u;
    uint _221 = 0u;
    uint _215 = 0u;
    uvec2 _296 = uvec2(4294967295u);
    uint _226 = _207 & 2147483647u;
    uint _227 = _208 & 2147483647u;
    uint _229 = (_207 ^ _208) & 2147483648u;
    uint _230 = _229 | 2139095040u;
    bool _234 = _226 == 0u;
    bool _235 = _227 == 0u;
    bool _237 = _226 == 2139095040u;
    bool _238 = _227 == 2139095040u;
    if ((((_226 > 2139095040u) || (_227 > 2139095040u)) || (_234 && _235)) || (_237 && _238))
    {
        return 2143289344u;
    }
    if (_237 || _235)
    {
        return _230;
    }
    if (_234 || _238)
    {
        return _229;
    }
    uint _250 = _226 & 8388607u;
    uint _251 = _226 >> 23u;
    _211 = _250 | 8388608u;
    _213 = int(_251) - 127;
    if (_251 == 0u)
    {
        uint _260 = (31u - uint(findMSB(_250))) - 8u;
        _211 = _250 << _260;
        _213 = (-126) - int(_260);
    }
    uint _266 = _227 & 8388607u;
    uint _267 = _227 >> 23u;
    _215 = _266 | 8388608u;
    _217 = int(_267) - 127;
    if (_267 == 0u)
    {
        uint _276 = (31u - uint(findMSB(_266))) - 8u;
        _215 = _266 << _276;
        _217 = (-126) - int(_276);
    }
    bool _282 = _211 < _215;
    int _287 = (_213 - _217) - int(_282);
    if (_287 < (-150))
    {
        return _229;
    }
    _219 = 1u;
    _221 = (_282 ? (_211 << 1u) : _211) - _215;
    uint _223 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _296)))
        {
            break;
        }
        _296 -= uvec2(uint(_296.y == 0u), 1u);
        if (_223 >= 23u)
        {
            break;
        }
        uint _311 = _221;
        uint _313 = _311 << 1u;
        bool _314 = _313 >= _215;
        _221 = _314 ? (_313 - _215) : _313;
        _219 = (_219 << 1u) | uint(_314);
        _223++;
        continue;
    }
    if (_287 < (-126))
    {
        uint _329 = uint((-126) - _287) & 31u;
        uint _330 = 1u << _329;
        uint _332 = _219 & (_330 - 1u);
        uint _333 = _330 >> 1u;
        uint _334 = _219 >> _329;
        return _229 | (_334 + uint((_332 > _333) || ((_332 == _333) && ((_221 != 0u) || ((_334 & 1u) != 0u)))));
    }
    uint _346 = _221 << 1u;
    uint _354 = _219 + uint((_346 > _215) || ((_346 == _215) && ((_219 & 1u) != 0u)));
    uint _355 = _354 >> 24u;
    int _358 = _287 + int(_355);
    if (_358 > 127)
    {
        return _230;
    }
    return _229 | ((uint(_358 + 127) << 23u) | ((_354 >> _355) & 8388607u));
}

void main()
{
    float _420 = 0.0;
    uint _414 = 0u;
    uint _408 = 0u;
    bool _401 = false;
    int _395 = 0;
    uint _418 = 0u;
    uint _412 = 0u;
    uint _406 = 0u;
    uint _399 = 0u;
    uint _393 = 0u;
    uint _423 = 0u;
    uint _416 = 0u;
    uint _410 = 0u;
    bool _404 = false;
    uint _397 = 0u;
    uint _429 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_429 >= 4096u)
    {
        return;
    }
    uint _434 = 4u + (_429 * 10u);
    uint _437 = _9._m0[_429];
    float _438 = uintBitsToFloat(_437);
    _12._m0[_434] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(_438))));
    _393 = _434 + 1u;
    _12._m0[_393] = floatBitsToUint(_177(_438));
    _395 = 0;
    int _450 = _395;
    _395 = _450 + 1;
    _399 = _429 + uint(_450);
    _397 = _434 + 2u;
    _12._m0[_397] = floatBitsToUint(_177(uintBitsToFloat(_9._m0[_399])));
    _401 = false;
    if (false)
    {
        int _465 = _395;
        _395 = _465 + 1;
        _401 = _200(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(float(_465)))))) != 0u;
    }
    _404 = true;
    if (!true)
    {
        int _477 = _395;
        _395 = _477 + 1;
        _404 = _200(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(float(_477)))))) != 0u;
    }
    _406 = _434 + 3u;
    _12._m0[_406] = uint(_395);
    float _492 = -0.0;
    _408 = _434 + 4u;
    _12._m0[_408] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(_492))));
    _412 = 4286578688u;
    _410 = _434 + 5u;
    _12._m0[_410] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_412)))));
    float _511 = float(2u);
    _414 = _434 + 6u;
    _12._m0[_414] = floatBitsToUint(_177(_511));
    _416 = _434 + 7u;
    _12._m0[_416] = uint(_187(true));
    if (true)
    {
        _420 = uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(_438)));
    }
    else
    {
        int _529 = _395;
        _395 = _529 + 1;
        _420 = uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(float(_529))));
    }
    _418 = _434 + 8u;
    _12._m0[_418] = floatBitsToUint(_420);
    _423 = _434 + 9u;
    _12._m0[_423] = floatBitsToUint(uintBitsToFloat(_209(floatBitsToUint(1.0), floatBitsToUint(_438))));
}

