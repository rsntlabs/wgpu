#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _9
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _12_11
{
    uvec2 _m0[];
} _11;

layout(set = 0, binding = 1, std430) buffer _15_14
{
    uint _m0[];
} _14;

layout(set = 0, binding = 2, std140) uniform _18_17
{
    _9 _m0;
} _17;

uint _29(uint _27, uint _28)
{
    uint _55 = 0u;
    int _48 = 0;
    int _53 = 0;
    uint _45 = 0u;
    uint _57 = 0u;
    uint _51 = 0u;
    uvec2 _130 = uvec2(4294967295u);
    uint _60 = _27 & 2147483647u;
    uint _61 = _28 & 2147483647u;
    uint _62 = _27 & 2147483648u;
    if ((_60 >= 2139095040u) || ((_61 > 2139095040u) || (_61 == 0u)))
    {
        return 2143289344u;
    }
    if ((_60 == 0u) || (_61 == 2139095040u))
    {
        return _27;
    }
    if (_60 == _61)
    {
        return _62;
    }
    uint _79 = _60 & 8388607u;
    uint _80 = _60 >> 23u;
    _45 = _79 | 8388608u;
    _48 = int(_80) - 127;
    if (_80 == 0u)
    {
        uint _89 = (31u - uint(findMSB(_79))) - 8u;
        _45 = _79 << _89;
        _48 = (-126) - int(_89);
    }
    uint _95 = _61 & 8388607u;
    uint _96 = _61 >> 23u;
    _51 = _95 | 8388608u;
    _53 = int(_96) - 127;
    if (_96 == 0u)
    {
        uint _105 = (31u - uint(findMSB(_95))) - 8u;
        _51 = _95 << _105;
        _53 = (-126) - int(_105);
    }
    _55 = _45;
    int _111 = _48 - _53;
    if (_111 < (-1))
    {
        return _27;
    }
    bool _115 = _111 == (-1);
    uint _117 = _115 ? (_51 << 1u) : _51;
    _57 = uint(_115 ? 0 : _111);
    for (;;)
    {
        if (all(equal(uvec2(0u), _130)))
        {
            break;
        }
        _130 -= uvec2(uint(_130.y == 0u), 1u);
        if (_57 == 0u)
        {
            break;
        }
        _55 = ((_55 >= _117) ? (_55 - _117) : _55) << 1u;
        _57--;
        continue;
    }
    bool _152 = _55 >= _117;
    uint _154 = _152 ? (_55 - _117) : _55;
    uint _155 = _154 + _154;
    bool _159 = (_155 > _117) || ((_155 == _117) && _152);
    uint _162 = _159 ? (_117 - _154) : _154;
    uint _163 = _159 ? (_62 ^ 2147483648u) : _62;
    if (_162 == 0u)
    {
        return _163;
    }
    uint _169 = (31u - uint(findMSB(_162))) - 8u;
    uint _170 = _162 << _169;
    int _172 = (_115 ? _48 : _53) - int(_169);
    return _163 | ((_172 >= (-126)) ? ((uint(_172 + 127) << 23u) | (_170 & 8388607u)) : (_170 >> (uint((-126) - _172) & 31u)));
}

uint _22(float _21)
{
    return 1u;
}

void main()
{
    float _212 = 0.0;
    uint _206 = 0u;
    uint _210 = 0u;
    uint _204 = 0u;
    float _215 = 0.0;
    uint _208 = 0u;
    uint _224 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_224 >= _17._m0._m0)
    {
        return;
    }
    uint _229 = 4u + (_224 * 4u);
    uint _233 = _11._m0[_224].x;
    float _234 = uintBitsToFloat(_233);
    uint _236 = _11._m0[_224].y;
    float _237 = uintBitsToFloat(_236);
    _204 = 0u;
    _14._m0[_229] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_234), floatBitsToUint(_237))));
    _212 = 0.0;
    _212 = _234;
    _204++;
    _215 = 0.0;
    _215 = _237;
    _204++;
    _206 = _229 + 1u;
    _14._m0[_206] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_212), floatBitsToUint(_215))));
    _208 = _229 + 2u;
    _14._m0[_208] = _204;
    _210 = _229 + 3u;
    _14._m0[_210] = _22(uintBitsToFloat(_29(floatBitsToUint(_234), floatBitsToUint(_237))));
}

