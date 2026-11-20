#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _10_9
{
    uvec2 _m0[];
} _9;

layout(set = 0, binding = 1, std430) buffer _13_12
{
    uint _m0[];
} _12;

uint _24(uint _22, uint _23)
{
    uint _44 = _22 & 2147483647u;
    uint _45 = _23 & 2147483647u;
    uint _46 = _22 & 2147483648u;
    uint _47 = _23 & 2147483648u;
    if ((_44 > 2139095040u) || (_45 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _54 = _44 == 2139095040u;
    bool _55 = _45 == 2139095040u;
    if ((_54 && _55) && (_46 != _47))
    {
        return 2143289344u;
    }
    if (_54)
    {
        return _22;
    }
    if (_55)
    {
        return _23;
    }
    bool _66 = _44 >= _45;
    uint _67 = _66 ? _44 : _45;
    uint _68 = _66 ? _45 : _44;
    uint _69 = _66 ? _46 : _47;
    uint _70 = _67 >> 23u;
    uint _71 = _68 >> 23u;
    bool _72 = _70 != 0u;
    bool _73 = _71 != 0u;
    uint _80 = ((_67 & 8388607u) | (_72 ? 8388608u : 0u)) << 3u;
    uint _81 = ((_68 & 8388607u) | (_73 ? 8388608u : 0u)) << 3u;
    uint _82 = _72 ? _70 : 1u;
    uint _84 = _82 - (_73 ? _71 : 1u);
    uint _85 = _84 & 31u;
    uint _96 = (_84 < 32u) ? ((_81 >> _85) | uint((_81 & ((1u << _85) - 1u)) != 0u)) : uint(_81 != 0u);
    uint _99 = (_46 == _47) ? (_80 + _96) : (_80 - _96);
    if (_99 == 0u)
    {
        return _46 & _47;
    }
    bool _104 = _99 >= 134217728u;
    uint _105 = 1u & 31u;
    uint _117 = _104 ? ((1u < 32u) ? ((_99 >> _105) | uint((_99 & ((1u << _105) - 1u)) != 0u)) : uint(_99 != 0u)) : _99;
    uint _119 = _82 + uint(_104);
    uint _124 = min(((31u - uint(findMSB(_117))) - 5u), (_119 - 1u));
    uint _125 = _117 << _124;
    uint _127 = _125 & 7u;
    uint _128 = _125 >> 3u;
    uint _136 = _128 + uint((_127 > 4u) || ((_127 == 4u) && ((_128 & 1u) != 0u)));
    bool _137 = _136 >= 16777216u;
    uint _139 = _137 ? (_136 >> 1u) : _136;
    uint _141 = (_119 - _124) + uint(_137);
    if (_141 >= 255u)
    {
        return _69 | 2139095040u;
    }
    return _69 | ((((_139 >= 8388608u) ? _141 : 0u) << 23u) | (_139 & 8388607u));
}

uint _17(float _16)
{
    return 1u;
}

void main()
{
    float _178 = 0.0;
    uint _172 = 0u;
    uint _176 = 0u;
    uint _169 = 0u;
    float _181 = 0.0;
    uint _174 = 0u;
    uint _187 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_187 >= 26u)
    {
        return;
    }
    uint _192 = 4u + (_187 * 4u);
    uint _196 = _9._m0[_187].x;
    float _197 = uintBitsToFloat(_196);
    uint _199 = _9._m0[_187].y;
    float _200 = uintBitsToFloat(_199);
    _169 = 0u;
    uint _201 = floatBitsToUint(_197);
    uint _202 = floatBitsToUint(_200);
    uint _208 = _24(_201, _202 ^ 2147483648u);
    _12._m0[_192] = floatBitsToUint(uintBitsToFloat(((_208 >= 2147483648u) || ((_201 == _202) && ((_201 & 2147483647u) == 2139095040u))) ? 0u : _208));
    _178 = 0.0;
    _178 = _197;
    _169++;
    _181 = 0.0;
    _181 = _200;
    _169++;
    uint _223 = floatBitsToUint(_178);
    uint _224 = floatBitsToUint(_181);
    uint _230 = _24(_223, _224 ^ 2147483648u);
    _172 = _192 + 1u;
    _12._m0[_172] = floatBitsToUint(uintBitsToFloat(((_230 >= 2147483648u) || ((_223 == _224) && ((_223 & 2147483647u) == 2139095040u))) ? 0u : _230));
    _174 = _192 + 2u;
    _12._m0[_174] = _169;
    uint _243 = floatBitsToUint(_197);
    uint _244 = floatBitsToUint(_200);
    uint _250 = _24(_243, _244 ^ 2147483648u);
    _176 = _192 + 3u;
    _12._m0[_176] = _17(uintBitsToFloat(((_250 >= 2147483648u) || ((_243 == _244) && ((_243 & 2147483647u) == 2139095040u))) ? 0u : _250));
}

