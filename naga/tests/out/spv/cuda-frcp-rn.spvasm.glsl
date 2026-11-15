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

float _204(float _203)
{
    return uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(_203)));
}

uint _227(uint _226)
{
    uint _230 = _226 & 2147483647u;
    return (_230 > 2139095040u) ? 2143289344u : _230;
}

int _214(bool _213)
{
    int _218 = 0;
    if (_213)
    {
        _218 = 7;
    }
    else
    {
        _218 = 9;
    }
    return _218;
}

void main()
{
    float _285 = 0.0;
    uint _279 = 0u;
    uint _273 = 0u;
    bool _266 = false;
    int _260 = 0;
    uint _283 = 0u;
    uint _277 = 0u;
    uint _271 = 0u;
    uint _264 = 0u;
    uint _258 = 0u;
    uint _288 = 0u;
    uint _281 = 0u;
    uint _275 = 0u;
    bool _269 = false;
    uint _262 = 0u;
    uint _294 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_294 >= 4096u)
    {
        return;
    }
    uint _299 = 4u + (_294 * 10u);
    uint _302 = _9._m0[_294];
    float _303 = uintBitsToFloat(_302);
    _12._m0[_299] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(_303))));
    _258 = _299 + 1u;
    _12._m0[_258] = floatBitsToUint(_204(_303));
    _260 = 0;
    int _315 = _260;
    _260 = _315 + 1;
    _264 = _294 + uint(_315);
    _262 = _299 + 2u;
    _12._m0[_262] = floatBitsToUint(_204(uintBitsToFloat(_9._m0[_264])));
    _266 = false;
    if (false)
    {
        int _330 = _260;
        _260 = _330 + 1;
        _266 = _227(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(float(_330)))))) != 0u;
    }
    _269 = true;
    if (!true)
    {
        int _342 = _260;
        _260 = _342 + 1;
        _269 = _227(floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(float(_342)))))) != 0u;
    }
    _271 = _299 + 3u;
    _12._m0[_271] = uint(_260);
    float _357 = -0.0;
    _273 = _299 + 4u;
    _12._m0[_273] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(_357))));
    _277 = 4286578688u;
    _275 = _299 + 5u;
    _12._m0[_275] = floatBitsToUint(uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(uintBitsToFloat(_277)))));
    float _376 = float(2u);
    _279 = _299 + 6u;
    _12._m0[_279] = floatBitsToUint(_204(_376));
    _281 = _299 + 7u;
    _12._m0[_281] = uint(_214(true));
    if (true)
    {
        _285 = uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(_303)));
    }
    else
    {
        int _394 = _260;
        _260 = _394 + 1;
        _285 = uintBitsToFloat(_18(floatBitsToUint(1.0), floatBitsToUint(float(_394))));
    }
    _283 = _299 + 8u;
    _12._m0[_283] = floatBitsToUint(_285);
    _288 = _299 + 9u;
    _12._m0[_288] = uint(_260);
}

