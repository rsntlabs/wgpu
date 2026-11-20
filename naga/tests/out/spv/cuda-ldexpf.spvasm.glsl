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
    int _144 = 0;
    uint _137 = 0u;
    uint _131 = 0u;
    uint _124 = 0u;
    float _147 = 0.0;
    uint _139 = 0u;
    uint _133 = 0u;
    uint _127 = 0u;
    int _149 = 0;
    float _141 = 0.0;
    uint _135 = 0u;
    uint _129 = 0u;
    uint _158 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_158 >= _17._m0._m0)
    {
        return;
    }
    uint _163 = 4u + (_158 * 8u);
    uint _167 = _11._m0[_158].x;
    float _168 = uintBitsToFloat(_167);
    uint _170 = _11._m0[_158].y;
    int _171 = int(_170);
    _124 = 0u;
    _14._m0[_163] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_168), _171)));
    _141 = 0.0;
    _141 = _168;
    _124++;
    _144 = 0;
    _144 = _171;
    _124++;
    _127 = _163 + 1u;
    _14._m0[_127] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_141), _144)));
    _129 = _163 + 2u;
    _14._m0[_129] = _124;
    _131 = _163 + 3u;
    _14._m0[_131] = _22(uintBitsToFloat(_29(floatBitsToUint(_168), _171)));
    _133 = _163 + 4u;
    _14._m0[_133] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_168), _171)));
    _147 = 0.0;
    _147 = _168;
    _124++;
    _149 = 0;
    _149 = _171;
    _124++;
    _135 = _163 + 5u;
    _14._m0[_135] = floatBitsToUint(uintBitsToFloat(_29(floatBitsToUint(_147), _149)));
    _137 = _163 + 6u;
    _14._m0[_137] = _124;
    _139 = _163 + 7u;
    _14._m0[_139] = _22(uintBitsToFloat(_29(floatBitsToUint(_168), _171)));
}

