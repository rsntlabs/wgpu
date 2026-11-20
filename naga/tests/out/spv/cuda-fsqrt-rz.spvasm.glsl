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

uint _17(uint _16)
{
    uint _46 = 0u;
    uint _40 = 0u;
    uint _44 = 0u;
    uint _37 = 0u;
    uint _48 = 0u;
    uint _42 = 0u;
    uvec2 _95 = uvec2(4294967295u);
    uint _53 = _16 & 2147483647u;
    if ((_53 == 0u) || (_16 == 2139095040u))
    {
        return _16;
    }
    if (((_16 & 2147483648u) != 0u) || (_53 > 2139095040u))
    {
        return 2143289344u;
    }
    uint _65 = _16 & 8388607u;
    uint _66 = _53 >> 23u;
    _37 = _65 | 8388608u;
    _40 = _66 + 127u;
    if (_66 == 0u)
    {
        uint _75 = (31u - uint(findMSB(_65))) - 8u;
        _37 = _65 << _75;
        _40 = 128u - _75;
    }
    uint _80 = _40 & 1u;
    _42 = _37 >> (9u - _80);
    _44 = _37 << (23u + _80);
    _46 = 0u;
    _48 = 0u;
    uint _50 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _95)))
        {
            break;
        }
        _95 -= uvec2(uint(_95.y == 0u), 1u);
        if (_50 >= 24u)
        {
            break;
        }
        uint _110 = _42;
        uint _113 = _48;
        uint _121 = (_113 << 2u) | (_110 >> 14u);
        uint _123 = (_46 << 2u) | 1u;
        bool _124 = _121 >= _123;
        uint _127 = _46 << 1u;
        _42 = ((_110 << 2u) | (_44 >> 30u)) & 65535u;
        _44 = _44 << 2u;
        _48 = _124 ? (_121 - _123) : _121;
        _46 = _124 ? (_127 | 1u) : _127;
        _50++;
        continue;
    }
    return ((_40 >> 1u) << 23u) | (_46 & 8388607u);
}

float _139(float _138)
{
    return uintBitsToFloat(_17(floatBitsToUint(_138)));
}

uint _161(uint _160)
{
    uint _163 = _160 & 2147483647u;
    return (_163 > 2139095040u) ? 2143289344u : _163;
}

int _147(bool _146)
{
    int _151 = 0;
    if (_146)
    {
        _151 = 7;
    }
    else
    {
        _151 = 9;
    }
    return _151;
}

uint _168(uint _167)
{
    uint _177 = 0u;
    uint _171 = 0u;
    uint _175 = 0u;
    uint _169 = 0u;
    uint _179 = 0u;
    uint _173 = 0u;
    uvec2 _219 = uvec2(4294967295u);
    uint _184 = _167 & 2147483647u;
    if ((_184 == 0u) || (_167 == 2139095040u))
    {
        return _167;
    }
    if (((_167 & 2147483648u) != 0u) || (_184 > 2139095040u))
    {
        return 2143289344u;
    }
    uint _196 = _167 & 8388607u;
    uint _197 = _184 >> 23u;
    _169 = _196 | 8388608u;
    _171 = _197 + 127u;
    if (_197 == 0u)
    {
        uint _205 = (31u - uint(findMSB(_196))) - 8u;
        _169 = _196 << _205;
        _171 = 128u - _205;
    }
    uint _210 = _171 & 1u;
    _173 = _169 >> (9u - _210);
    _175 = _169 << (23u + _210);
    _177 = 0u;
    _179 = 0u;
    uint _181 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _219)))
        {
            break;
        }
        _219 -= uvec2(uint(_219.y == 0u), 1u);
        if (_181 >= 24u)
        {
            break;
        }
        uint _234 = _173;
        uint _237 = _179;
        uint _245 = (_237 << 2u) | (_234 >> 14u);
        uint _247 = (_177 << 2u) | 1u;
        bool _248 = _245 >= _247;
        uint _251 = _177 << 1u;
        _173 = ((_234 << 2u) | (_175 >> 30u)) & 65535u;
        _175 = _175 << 2u;
        _179 = _248 ? (_245 - _247) : _245;
        _177 = _248 ? (_251 | 1u) : _251;
        _181++;
        continue;
    }
    return ((_171 >> 1u) << 23u) | (((_179 > _177) ? (_177 + 1u) : _177) & 8388607u);
}

uint _267(uint _266)
{
    uint _276 = 0u;
    uint _270 = 0u;
    uint _274 = 0u;
    uint _268 = 0u;
    uint _278 = 0u;
    uint _272 = 0u;
    uvec2 _318 = uvec2(4294967295u);
    uint _283 = _266 & 2147483647u;
    if ((_283 == 0u) || (_266 == 2139095040u))
    {
        return _266;
    }
    if (((_266 & 2147483648u) != 0u) || (_283 > 2139095040u))
    {
        return 2143289344u;
    }
    uint _295 = _266 & 8388607u;
    uint _296 = _283 >> 23u;
    _268 = _295 | 8388608u;
    _270 = _296 + 127u;
    if (_296 == 0u)
    {
        uint _304 = (31u - uint(findMSB(_295))) - 8u;
        _268 = _295 << _304;
        _270 = 128u - _304;
    }
    uint _309 = _270 & 1u;
    _272 = _268 >> (9u - _309);
    _274 = _268 << (23u + _309);
    _276 = 0u;
    _278 = 0u;
    uint _280 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _318)))
        {
            break;
        }
        _318 -= uvec2(uint(_318.y == 0u), 1u);
        if (_280 >= 24u)
        {
            break;
        }
        uint _333 = _272;
        uint _336 = _278;
        uint _344 = (_336 << 2u) | (_333 >> 14u);
        uint _346 = (_276 << 2u) | 1u;
        bool _347 = _344 >= _346;
        uint _350 = _276 << 1u;
        _272 = ((_333 << 2u) | (_274 >> 30u)) & 65535u;
        _274 = _274 << 2u;
        _278 = _347 ? (_344 - _346) : _344;
        _276 = _347 ? (_350 | 1u) : _350;
        _280++;
        continue;
    }
    uint _359 = (_278 > 0u) ? (_276 + 1u) : _276;
    return (((_270 >> 1u) + (_359 >> 24u)) << 23u) | (_359 & 8388607u);
}

void main()
{
    uint _433 = 0u;
    uint _427 = 0u;
    float _420 = 0.0;
    uint _414 = 0u;
    uint _408 = 0u;
    bool _401 = false;
    int _395 = 0;
    uint _437 = 0u;
    uint _431 = 0u;
    int _425 = 0;
    uint _418 = 0u;
    uint _412 = 0u;
    uint _406 = 0u;
    uint _399 = 0u;
    uint _393 = 0u;
    uint _435 = 0u;
    uint _429 = 0u;
    uint _423 = 0u;
    uint _416 = 0u;
    uint _410 = 0u;
    bool _404 = false;
    uint _397 = 0u;
    uint _443 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_443 >= 4096u)
    {
        return;
    }
    uint _448 = 4u + (_443 * 14u);
    uint _451 = _9._m0[_443];
    float _452 = uintBitsToFloat(_451);
    _12._m0[_448] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_452))));
    _393 = _448 + 1u;
    _12._m0[_393] = floatBitsToUint(_139(_452));
    _395 = 0;
    int _463 = _395;
    _395 = _463 + 1;
    _399 = _443 + uint(_463);
    _397 = _448 + 2u;
    _12._m0[_397] = floatBitsToUint(_139(uintBitsToFloat(_9._m0[_399])));
    _401 = false;
    if (false)
    {
        int _478 = _395;
        _395 = _478 + 1;
        _401 = _161(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_478)))))) != 0u;
    }
    _404 = true;
    if (!true)
    {
        int _489 = _395;
        _395 = _489 + 1;
        _404 = _161(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_489)))))) != 0u;
    }
    _406 = _448 + 3u;
    _12._m0[_406] = uint(_395);
    float _503 = -0.0;
    _408 = _448 + 4u;
    _12._m0[_408] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_503))));
    _412 = 2139095040u;
    _410 = _448 + 5u;
    _12._m0[_410] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(uintBitsToFloat(_412)))));
    float _520 = float(4u);
    _414 = _448 + 6u;
    _12._m0[_414] = floatBitsToUint(_139(_520));
    _416 = _448 + 7u;
    _12._m0[_416] = uint(_147(true));
    if (true)
    {
        _420 = uintBitsToFloat(_17(floatBitsToUint(_452)));
    }
    else
    {
        int _537 = _395;
        _395 = _537 + 1;
        _420 = uintBitsToFloat(_17(floatBitsToUint(float(_537))));
    }
    _418 = _448 + 8u;
    _12._m0[_418] = floatBitsToUint(_420);
    _423 = _448 + 9u;
    _12._m0[_423] = floatBitsToUint(uintBitsToFloat(_168(floatBitsToUint(_452))));
    _425 = 0;
    int _555 = _425;
    _425 = _555 + 1;
    _429 = _443 + uint(_555);
    _427 = _448 + 10u;
    _12._m0[_427] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(uintBitsToFloat(_9._m0[_429])))));
    _431 = _448 + 11u;
    _12._m0[_431] = uint(_425);
    _425 = 0;
    int _575 = _425;
    _425 = _575 + 1;
    _435 = _443 + uint(_575);
    _433 = _448 + 12u;
    _12._m0[_433] = floatBitsToUint(uintBitsToFloat(_267(floatBitsToUint(uintBitsToFloat(_9._m0[_435])))));
    _437 = _448 + 13u;
    _12._m0[_437] = uint(_425);
}

