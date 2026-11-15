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

float _18(float _16, float _17)
{
    return uintBitsToFloat((floatBitsToUint(_16) & 2147483647u) | (floatBitsToUint(_17) & 2147483648u));
}

int _32(bool _30, bool _31)
{
    int _36 = 0;
    if (_30)
    {
        _36 = 7;
    }
    else
    {
        _36 = 9;
    }
    return _36;
}

uint _46(uint _45)
{
    uint _51 = _45 & 2147483647u;
    return (_51 > 2139095040u) ? 2143289344u : _51;
}

void main()
{
    uint _138 = 0u;
    uint _131 = 0u;
    bool _124 = false;
    uint _118 = 0u;
    uint _112 = 0u;
    uint _106 = 0u;
    uint _100 = 0u;
    uint _94 = 0u;
    float _135 = 0.0;
    bool _129 = false;
    uint _122 = 0u;
    int _116 = 0;
    uint _110 = 0u;
    uint _104 = 0u;
    uint _98 = 0u;
    uint _91 = 0u;
    uint _140 = 0u;
    uint _133 = 0u;
    bool _127 = false;
    uint _120 = 0u;
    uint _114 = 0u;
    uint _108 = 0u;
    uint _102 = 0u;
    uint _96 = 0u;
    uint _146 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_146 >= 912u)
    {
        return;
    }
    uint _151 = 4u + (_146 * 14u);
    _91 = _146 * 2u;
    uint _156 = _9._m0[_91];
    float _157 = uintBitsToFloat(_156);
    _94 = (_146 * 2u) + 1u;
    uint _162 = _9._m0[_94];
    float _163 = uintBitsToFloat(_162);
    _12._m0[_151] = floatBitsToUint(uintBitsToFloat((floatBitsToUint(_157) & 2147483647u) | (floatBitsToUint(_163) & 2147483648u)));
    _96 = _151 + 1u;
    _12._m0[_96] = floatBitsToUint(_18(_157, _163));
    float _177 = -0.0;
    _98 = _151 + 2u;
    _12._m0[_98] = floatBitsToUint(uintBitsToFloat((floatBitsToUint(0.0) & 2147483647u) | (floatBitsToUint(_177) & 2147483648u)));
    float _188 = -0.0;
    _100 = _151 + 3u;
    _12._m0[_100] = floatBitsToUint(uintBitsToFloat((floatBitsToUint(_188) & 2147483647u) | (floatBitsToUint(0.0) & 2147483648u)));
    _104 = 4286578689u;
    _102 = _151 + 4u;
    _12._m0[_102] = floatBitsToUint(uintBitsToFloat((floatBitsToUint(uintBitsToFloat(_104)) & 2147483647u) | (floatBitsToUint(0.0) & 2147483648u)));
    _108 = 2143363909u;
    float _213 = -0.0;
    _106 = _151 + 5u;
    _12._m0[_106] = floatBitsToUint(uintBitsToFloat((floatBitsToUint(uintBitsToFloat(_108)) & 2147483647u) | (floatBitsToUint(_213) & 2147483648u)));
    int _224 = -3;
    float _226 = float(0u);
    _110 = _151 + 6u;
    _12._m0[_110] = floatBitsToUint(_18(float(_224), _226));
    int _232 = -1;
    float _233 = float(5u);
    _112 = _151 + 7u;
    _12._m0[_112] = floatBitsToUint(_18(_233, float(_232)));
    _114 = _151 + 8u;
    _12._m0[_114] = uint(_32(true, false));
    _116 = 0;
    int _246 = _116;
    _116 = _246 + 1;
    _120 = (_146 * 2u) + uint(_246);
    int _255 = _116;
    _116 = _255 + 1;
    _122 = (_146 * 2u) + uint(_255);
    _118 = _151 + 9u;
    _12._m0[_118] = floatBitsToUint(_18(uintBitsToFloat(_9._m0[_120]), uintBitsToFloat(_9._m0[_122])));
    _124 = false;
    _127 = _124;
    if (_124)
    {
        int _271 = _116;
        _116 = _271 + 1;
        _127 = _46(floatBitsToUint(uintBitsToFloat((floatBitsToUint(float(_271)) & 2147483647u) | (floatBitsToUint(_163) & 2147483648u)))) != 0u;
    }
    _124 = true;
    _129 = _124;
    if (!_124)
    {
        int _286 = _116;
        _116 = _286 + 1;
        _129 = _46(floatBitsToUint(uintBitsToFloat((floatBitsToUint(float(_286)) & 2147483647u) | (floatBitsToUint(_163) & 2147483648u)))) != 0u;
    }
    _131 = _151 + 10u;
    _12._m0[_131] = uint(_116);
    if (_124)
    {
        _135 = uintBitsToFloat((floatBitsToUint(_157) & 2147483647u) | (floatBitsToUint(_163) & 2147483648u));
    }
    else
    {
        int _313 = _116;
        _116 = _313 + 1;
        _135 = uintBitsToFloat((floatBitsToUint(float(_313)) & 2147483647u) | (floatBitsToUint(_163) & 2147483648u));
    }
    _133 = _151 + 11u;
    _12._m0[_133] = floatBitsToUint(_135);
    float _327 = -1.0;
    _138 = _151 + 12u;
    _12._m0[_138] = floatBitsToUint(_18(float(true), _327));
    _140 = _151 + 13u;
    _12._m0[_140] = uint(_116);
}

