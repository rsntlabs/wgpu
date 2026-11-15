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
    return ((_40 >> 1u) << 23u) | (((_48 > _46) ? (_46 + 1u) : _46) & 8388607u);
}

float _143(float _142)
{
    return uintBitsToFloat(_17(floatBitsToUint(_142)));
}

uint _165(uint _164)
{
    uint _167 = _164 & 2147483647u;
    return (_167 > 2139095040u) ? 2143289344u : _167;
}

int _151(bool _150)
{
    int _155 = 0;
    if (_150)
    {
        _155 = 7;
    }
    else
    {
        _155 = 9;
    }
    return _155;
}

void main()
{
    float _221 = 0.0;
    uint _215 = 0u;
    uint _209 = 0u;
    bool _202 = false;
    int _196 = 0;
    uint _219 = 0u;
    uint _213 = 0u;
    uint _207 = 0u;
    uint _200 = 0u;
    uint _194 = 0u;
    uint _224 = 0u;
    uint _217 = 0u;
    uint _211 = 0u;
    bool _205 = false;
    uint _198 = 0u;
    uint _230 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_230 >= 4096u)
    {
        return;
    }
    uint _235 = 4u + (_230 * 10u);
    uint _238 = _9._m0[_230];
    float _239 = uintBitsToFloat(_238);
    _12._m0[_235] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_239))));
    _194 = _235 + 1u;
    _12._m0[_194] = floatBitsToUint(_143(_239));
    _196 = 0;
    int _250 = _196;
    _196 = _250 + 1;
    _200 = _230 + uint(_250);
    _198 = _235 + 2u;
    _12._m0[_198] = floatBitsToUint(_143(uintBitsToFloat(_9._m0[_200])));
    _202 = false;
    if (false)
    {
        int _265 = _196;
        _196 = _265 + 1;
        _202 = _165(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_265)))))) != 0u;
    }
    _205 = true;
    if (!true)
    {
        int _276 = _196;
        _196 = _276 + 1;
        _205 = _165(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_276)))))) != 0u;
    }
    _207 = _235 + 3u;
    _12._m0[_207] = uint(_196);
    float _290 = -0.0;
    _209 = _235 + 4u;
    _12._m0[_209] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_290))));
    _213 = 2139095040u;
    _211 = _235 + 5u;
    _12._m0[_211] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(uintBitsToFloat(_213)))));
    float _307 = float(4u);
    _215 = _235 + 6u;
    _12._m0[_215] = floatBitsToUint(_143(_307));
    _217 = _235 + 7u;
    _12._m0[_217] = uint(_151(true));
    if (true)
    {
        _221 = uintBitsToFloat(_17(floatBitsToUint(_239)));
    }
    else
    {
        int _324 = _196;
        _196 = _324 + 1;
        _221 = uintBitsToFloat(_17(floatBitsToUint(float(_324))));
    }
    _219 = _235 + 8u;
    _12._m0[_219] = floatBitsToUint(_221);
    _224 = _235 + 9u;
    _12._m0[_224] = uint(_196);
}

