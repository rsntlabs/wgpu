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
    uint _32 = _16 & 2147483647u;
    uint _37 = 1u << ((150u - (_32 >> 23u)) & 31u);
    uint _38 = _37 - 1u;
    uint _39 = _16 & _38;
    uint _42 = _16 & (~_38);
    uint _44 = _37 >> 1u;
    return (_32 > 2139095040u) ? 2143289344u : ((_32 >= 1258291200u) ? _16 : ((_32 < 1065353216u) ? ((_32 == 0u) ? _16 : ((_16 & 2147483648u) | (uint(_32 > 1056964608u) * 1065353216u))) : ((((_39 > _44) || ((_39 == _44) && ((_42 & _37) != 0u))) && (_39 != 0u)) ? (_42 + _37) : _42)));
}

float _67(float _66)
{
    return uintBitsToFloat(_17(floatBitsToUint(_66)));
}

uint _89(uint _88)
{
    uint _91 = _88 & 2147483647u;
    return (_91 > 2139095040u) ? 2143289344u : _91;
}

uint _96(uint _95)
{
    uint _98 = _95 & 2147483647u;
    uint _99 = _95 & 2147483648u;
    uint _103 = 1u << ((150u - (_98 >> 23u)) & 31u);
    uint _104 = _103 - 1u;
    uint _105 = _95 & _104;
    uint _108 = _95 & (~_104);
    return (_98 > 2139095040u) ? 2143289344u : ((_98 >= 1258291200u) ? _95 : ((_98 < 1065353216u) ? ((_98 == 0u) ? _95 : ((_98 >= 1056964608u) ? (_99 | 1065353216u) : _99)) : (((_105 >= (_103 >> 1u)) && (_105 != 0u)) ? (_108 + _103) : _108)));
}

int _75(bool _74)
{
    int _79 = 0;
    if (_74)
    {
        _79 = 7;
    }
    else
    {
        _79 = 9;
    }
    return _79;
}

void main()
{
    uint _182 = 0u;
    uint _176 = 0u;
    uint _170 = 0u;
    uint _163 = 0u;
    uint _157 = 0u;
    uint _187 = 0u;
    uint _180 = 0u;
    uint _174 = 0u;
    bool _168 = false;
    uint _161 = 0u;
    uint _154 = 0u;
    float _184 = 0.0;
    uint _178 = 0u;
    uint _172 = 0u;
    bool _165 = false;
    int _159 = 0;
    uint _193 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_193 >= 32u)
    {
        return;
    }
    uint _198 = 4u + (_193 * 12u);
    uint _201 = _9._m0[_193];
    float _202 = uintBitsToFloat(_201);
    _12._m0[_198] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_202))));
    _154 = _198 + 1u;
    _12._m0[_154] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_202))));
    _157 = _198 + 2u;
    _12._m0[_157] = floatBitsToUint(_67(_202));
    _159 = 0;
    int _220 = _159;
    _159 = _220 + 1;
    _163 = _193 + uint(_220);
    _161 = _198 + 3u;
    _12._m0[_161] = floatBitsToUint(_67(uintBitsToFloat(_9._m0[_163])));
    _165 = false;
    if (false)
    {
        int _235 = _159;
        _159 = _235 + 1;
        _165 = _89(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_235)))))) != 0u;
    }
    _168 = true;
    if (!true)
    {
        int _246 = _159;
        _159 = _246 + 1;
        _168 = _89(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_246)))))) != 0u;
    }
    _170 = _198 + 4u;
    _12._m0[_170] = uint(_159);
    float _260 = -0.5;
    _172 = _198 + 5u;
    _12._m0[_172] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_260))));
    _174 = _198 + 6u;
    _12._m0[_174] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(2.5))));
    _176 = _198 + 7u;
    _12._m0[_176] = floatBitsToUint(uintBitsToFloat(_96(floatBitsToUint(2.5))));
    float _282 = float(3u);
    _178 = _198 + 8u;
    _12._m0[_178] = floatBitsToUint(_67(_282));
    _180 = _198 + 9u;
    _12._m0[_180] = uint(_75(true));
    if (true)
    {
        _184 = uintBitsToFloat(_17(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_202))))));
    }
    else
    {
        int _302 = _159;
        _159 = _302 + 1;
        _184 = uintBitsToFloat(_17(floatBitsToUint(float(_302))));
    }
    _182 = _198 + 10u;
    _12._m0[_182] = floatBitsToUint(_184);
    _187 = _198 + 11u;
    _12._m0[_187] = uint(_159);
}

