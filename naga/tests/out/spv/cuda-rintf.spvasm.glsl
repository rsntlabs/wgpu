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
    float _191 = 0.0;
    uint _185 = 0u;
    uint _179 = 0u;
    uint _173 = 0u;
    bool _166 = false;
    int _160 = 0;
    uint _189 = 0u;
    uint _183 = 0u;
    uint _177 = 0u;
    uint _171 = 0u;
    uint _164 = 0u;
    uint _157 = 0u;
    uint _194 = 0u;
    uint _187 = 0u;
    uint _181 = 0u;
    uint _175 = 0u;
    bool _169 = false;
    uint _162 = 0u;
    uint _200 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_200 >= 4096u)
    {
        return;
    }
    uint _205 = 4u + (_200 * 14u);
    uint _208 = _9._m0[_200];
    float _209 = uintBitsToFloat(_208);
    _12._m0[_205] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_209))));
    _157 = _205 + 1u;
    _12._m0[_157] = floatBitsToUint(_67(_209));
    _160 = 0;
    int _220 = _160;
    _160 = _220 + 1;
    _164 = _200 + uint(_220);
    _162 = _205 + 2u;
    _12._m0[_162] = floatBitsToUint(_67(uintBitsToFloat(_9._m0[_164])));
    _166 = false;
    if (false)
    {
        int _235 = _160;
        _160 = _235 + 1;
        _166 = _89(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_235)))))) != 0u;
    }
    _169 = true;
    if (!true)
    {
        int _246 = _160;
        _160 = _246 + 1;
        _169 = _89(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_246)))))) != 0u;
    }
    _171 = _205 + 3u;
    _12._m0[_171] = uint(_160);
    float _260 = -0.5;
    _173 = _205 + 4u;
    _12._m0[_173] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_260))));
    _175 = _205 + 5u;
    _12._m0[_175] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(0.5))));
    _177 = _205 + 6u;
    _12._m0[_177] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(2.5))));
    _179 = _205 + 7u;
    _12._m0[_179] = floatBitsToUint(uintBitsToFloat(_96(floatBitsToUint(2.5))));
    float _289 = -2.5;
    _181 = _205 + 8u;
    _12._m0[_181] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_289))));
    float _297 = -2.5;
    _183 = _205 + 9u;
    _12._m0[_183] = floatBitsToUint(uintBitsToFloat(_96(floatBitsToUint(_297))));
    float _305 = float(3u);
    _185 = _205 + 10u;
    _12._m0[_185] = floatBitsToUint(_67(_305));
    _187 = _205 + 11u;
    _12._m0[_187] = uint(_75(true));
    if (true)
    {
        _191 = uintBitsToFloat(_17(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_209))))));
    }
    else
    {
        int _325 = _160;
        _160 = _325 + 1;
        _191 = uintBitsToFloat(_17(floatBitsToUint(float(_325))));
    }
    _189 = _205 + 12u;
    _12._m0[_189] = floatBitsToUint(_191);
    _194 = _205 + 13u;
    _12._m0[_194] = uint(_160);
}

