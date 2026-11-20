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
    uint _56 = 0u;
    int _49 = 0;
    int _54 = 0;
    uint _46 = 0u;
    uint _58 = 0u;
    uint _52 = 0u;
    uvec2 _144 = uvec2(4294967295u);
    uint _63 = _27 & 2147483647u;
    uint _64 = _28 & 2147483647u;
    uint _66 = (_27 ^ _28) & 2147483648u;
    uint _67 = _66 | 2139095040u;
    bool _72 = _63 == 0u;
    bool _73 = _64 == 0u;
    bool _75 = _63 == 2139095040u;
    bool _76 = _64 == 2139095040u;
    if ((((_63 > 2139095040u) || (_64 > 2139095040u)) || (_72 && _73)) || (_75 && _76))
    {
        return 2143289344u;
    }
    if (_75 || _73)
    {
        return _67;
    }
    if (_72 || _76)
    {
        return _66;
    }
    uint _88 = _63 & 8388607u;
    uint _89 = _63 >> 23u;
    _46 = _88 | 8388608u;
    _49 = int(_89) - 127;
    if (_89 == 0u)
    {
        uint _98 = (31u - uint(findMSB(_88))) - 8u;
        _46 = _88 << _98;
        _49 = (-126) - int(_98);
    }
    uint _104 = _64 & 8388607u;
    uint _105 = _64 >> 23u;
    _52 = _104 | 8388608u;
    _54 = int(_105) - 127;
    if (_105 == 0u)
    {
        uint _114 = (31u - uint(findMSB(_104))) - 8u;
        _52 = _104 << _114;
        _54 = (-126) - int(_114);
    }
    bool _120 = _46 < _52;
    int _127 = (_49 - _54) - int(_120);
    bool _129 = _66 != 0u;
    if (_127 < (-150))
    {
        return _66 | uint(_129);
    }
    _56 = 1u;
    _58 = (_120 ? (_46 << 1u) : _46) - _52;
    uint _60 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _144)))
        {
            break;
        }
        _144 -= uvec2(uint(_144.y == 0u), 1u);
        if (_60 >= 23u)
        {
            break;
        }
        uint _159 = _58;
        uint _161 = _159 << 1u;
        bool _162 = _161 >= _52;
        _58 = _162 ? (_161 - _52) : _161;
        _56 = (_56 << 1u) | uint(_162);
        _60++;
        continue;
    }
    if (_127 < (-126))
    {
        uint _177 = uint((-126) - _127) & 31u;
        return _66 | ((_56 >> _177) + uint(_129 && (((_56 & ((1u << _177) - 1u)) | _58) != 0u)));
    }
    uint _191 = _56 + uint(_129 && (_58 != 0u));
    uint _192 = _191 >> 24u;
    int _195 = _127 + int(_192);
    if (_195 > 127)
    {
        return _129 ? _67 : 2139095039u;
    }
    return _66 | ((uint(_195 + 127) << 23u) | ((_191 >> _192) & 8388607u));
}

uint _22(float _21)
{
    return 1u;
}

void main()
{
    float _247 = 0.0;
    uint _240 = 0u;
    uint _234 = 0u;
    uint _228 = 0u;
    float _249 = 0.0;
    uint _242 = 0u;
    uint _236 = 0u;
    uint _230 = 0u;
    float _244 = 0.0;
    uint _238 = 0u;
    uint _232 = 0u;
    uint _258 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_258 >= _17._m0._m0)
    {
        return;
    }
    uint _263 = 4u + (_258 * 8u);
    uint _267 = _11._m0[_258].x;
    float _268 = uintBitsToFloat(_267);
    uint _270 = _11._m0[_258].y;
    float _271 = uintBitsToFloat(_270);
    _228 = 0u;
    _14._m0[_263] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_268), floatBitsToUint(_271))));
    _244 = 0.0;
    _244 = _268;
    _228++;
    _247 = 0.0;
    _247 = _271;
    _228++;
    _230 = _263 + 1u;
    _14._m0[_230] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_244), floatBitsToUint(_247))));
    _232 = _263 + 2u;
    _14._m0[_232] = _228;
    _234 = _263 + 3u;
    _14._m0[_234] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(1.0), floatBitsToUint(_271))));
    _249 = 0.0;
    _249 = _271;
    _228++;
    _236 = _263 + 4u;
    _14._m0[_236] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(1.0), floatBitsToUint(_249))));
    _238 = _263 + 5u;
    _14._m0[_238] = _228;
    _240 = _263 + 6u;
    _14._m0[_240] = _22(uintBitsToFloat(_29(floatBitsToUint(_268), floatBitsToUint(_271))));
    _242 = _263 + 7u;
    _14._m0[_242] = _22(uintBitsToFloat(_29(floatBitsToUint(1.0), floatBitsToUint(_271))));
}

