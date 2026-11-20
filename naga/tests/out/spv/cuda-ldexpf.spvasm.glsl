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

uint _29(uint _27, int _28)
{
    uint _46 = _27 & 2147483647u;
    uint _47 = _27 & 2147483648u;
    if (_46 > 2139095040u)
    {
        return 2143289344u;
    }
    if ((_46 == 0u) || (_46 == 2139095040u))
    {
        return _27;
    }
    uint _61 = max((31u - uint(findMSB(_46))), 8u) - 8u;
    uint _63 = (_46 << _61) & 8388607u;
    uint _64 = _63 | 8388608u;
    int _72 = (max(int(_46 >> 23u), 1) - int(_61)) + min(max(_28, (-512)), 512);
    if (_72 >= 255)
    {
        return 2139095040u | _47;
    }
    if (_72 >= 1)
    {
        return ((uint(_72) << 23u) | _63) | _47;
    }
    uint _87 = uint(min(max((1 - _72), 1), 25));
    uint _88 = _64 >> _87;
    uint _89 = 1u << _87;
    uint _91 = _64 & (_89 - 1u);
    uint _92 = _89 >> 1u;
    return (_88 + uint((_91 > _92) || ((_91 == _92) && ((_88 & 1u) != 0u)))) | _47;
}

uint _22(float _21)
{
    return 1u;
}

void main()
{
    float _130 = 0.0;
    uint _124 = 0u;
    uint _128 = 0u;
    uint _121 = 0u;
    int _133 = 0;
    uint _126 = 0u;
    uint _143 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_143 >= _17._m0._m0)
    {
        return;
    }
    uint _148 = 4u + (_143 * 4u);
    uint _152 = _11._m0[_143].x;
    float _153 = uintBitsToFloat(_152);
    uint _155 = _11._m0[_143].y;
    int _156 = int(_155);
    _121 = 0u;
    _14._m0[_148] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_153), _156)));
    _130 = 0.0;
    _130 = _153;
    _121++;
    _133 = 0;
    _133 = _156;
    _121++;
    _124 = _148 + 1u;
    _14._m0[_124] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_130), _133)));
    _126 = _148 + 2u;
    _14._m0[_126] = _121;
    _128 = _148 + 3u;
    _14._m0[_128] = _22(uintBitsToFloat(_29(floatBitsToUint(_153), _156)));
}

