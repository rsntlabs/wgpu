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

void main()
{
    float _316 = 0.0;
    uint _310 = 0u;
    uint _304 = 0u;
    bool _297 = false;
    int _291 = 0;
    uint _314 = 0u;
    uint _308 = 0u;
    uint _302 = 0u;
    uint _295 = 0u;
    uint _289 = 0u;
    uint _319 = 0u;
    uint _312 = 0u;
    uint _306 = 0u;
    bool _300 = false;
    uint _293 = 0u;
    uint _325 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_325 >= 4096u)
    {
        return;
    }
    uint _330 = 4u + (_325 * 10u);
    uint _333 = _9._m0[_325];
    float _334 = uintBitsToFloat(_333);
    _12._m0[_330] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_334))));
    _289 = _330 + 1u;
    _12._m0[_289] = floatBitsToUint(_139(_334));
    _291 = 0;
    int _345 = _291;
    _291 = _345 + 1;
    _295 = _325 + uint(_345);
    _293 = _330 + 2u;
    _12._m0[_293] = floatBitsToUint(_139(uintBitsToFloat(_9._m0[_295])));
    _297 = false;
    if (false)
    {
        int _360 = _291;
        _291 = _360 + 1;
        _297 = _161(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_360)))))) != 0u;
    }
    _300 = true;
    if (!true)
    {
        int _371 = _291;
        _291 = _371 + 1;
        _300 = _161(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_371)))))) != 0u;
    }
    _302 = _330 + 3u;
    _12._m0[_302] = uint(_291);
    float _385 = -0.0;
    _304 = _330 + 4u;
    _12._m0[_304] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_385))));
    _308 = 2139095040u;
    _306 = _330 + 5u;
    _12._m0[_306] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(uintBitsToFloat(_308)))));
    float _402 = float(4u);
    _310 = _330 + 6u;
    _12._m0[_310] = floatBitsToUint(_139(_402));
    _312 = _330 + 7u;
    _12._m0[_312] = uint(_147(true));
    if (true)
    {
        _316 = uintBitsToFloat(_17(floatBitsToUint(_334)));
    }
    else
    {
        int _419 = _291;
        _291 = _419 + 1;
        _316 = uintBitsToFloat(_17(floatBitsToUint(float(_419))));
    }
    _314 = _330 + 8u;
    _12._m0[_314] = floatBitsToUint(_316);
    _319 = _330 + 9u;
    _12._m0[_319] = floatBitsToUint(uintBitsToFloat(_168(floatBitsToUint(_334))));
}

