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
    uint _30 = _16 & 2147483647u;
    return (_30 > 2139095040u) ? 2143289344u : ((_30 >= 1258291200u) ? _16 : ((_30 < 1065353216u) ? (_16 & 2147483648u) : (_16 & (~((1u << ((150u - (_30 >> 23u)) & 31u)) - 1u)))));
}

float _47(float _46)
{
    return uintBitsToFloat(_17(floatBitsToUint(_46)));
}

uint _69(uint _68)
{
    uint _71 = _68 & 2147483647u;
    return (_71 > 2139095040u) ? 2143289344u : _71;
}

int _55(bool _54)
{
    int _59 = 0;
    if (_54)
    {
        _59 = 7;
    }
    else
    {
        _59 = 9;
    }
    return _59;
}

void main()
{
    float _134 = 0.0;
    uint _128 = 0u;
    uint _122 = 0u;
    bool _115 = false;
    int _109 = 0;
    uint _139 = 0u;
    uint _132 = 0u;
    uint _126 = 0u;
    uint _120 = 0u;
    uint _113 = 0u;
    uint _106 = 0u;
    uint _137 = 0u;
    uint _130 = 0u;
    uint _124 = 0u;
    bool _118 = false;
    uint _111 = 0u;
    uint _145 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 32u);
    if (_145 >= 4096u)
    {
        return;
    }
    uint _150 = 4u + (_145 * 12u);
    uint _153 = _9._m0[_145];
    float _154 = uintBitsToFloat(_153);
    _12._m0[_150] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_154))));
    _106 = _150 + 1u;
    _12._m0[_106] = floatBitsToUint(_47(_154));
    _109 = 0;
    int _165 = _109;
    _109 = _165 + 1;
    _113 = _145 + uint(_165);
    _111 = _150 + 2u;
    _12._m0[_111] = floatBitsToUint(_47(uintBitsToFloat(_9._m0[_113])));
    _115 = false;
    if (false)
    {
        int _180 = _109;
        _109 = _180 + 1;
        _115 = _69(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_180)))))) != 0u;
    }
    _118 = true;
    if (!true)
    {
        int _191 = _109;
        _109 = _191 + 1;
        _118 = _69(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(float(_191)))))) != 0u;
    }
    _120 = _150 + 3u;
    _12._m0[_120] = uint(_109);
    float _205 = -0.0;
    _122 = _150 + 4u;
    _12._m0[_122] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_205))));
    float _213 = -0.25;
    _124 = _150 + 5u;
    _12._m0[_124] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_213))));
    float _221 = -1.75;
    _126 = _150 + 6u;
    _12._m0[_126] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_221))));
    float _229 = float(3u);
    _128 = _150 + 7u;
    _12._m0[_128] = floatBitsToUint(_47(_229));
    _130 = _150 + 8u;
    _12._m0[_130] = uint(_55(true));
    if (true)
    {
        _134 = uintBitsToFloat(_17(floatBitsToUint(_154)));
    }
    else
    {
        int _246 = _109;
        _109 = _246 + 1;
        _134 = uintBitsToFloat(_17(floatBitsToUint(float(_246))));
    }
    _132 = _150 + 9u;
    _12._m0[_132] = floatBitsToUint(_134);
    _137 = _150 + 10u;
    _12._m0[_137] = floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(uintBitsToFloat(_17(floatBitsToUint(_154)))))));
    _139 = _150 + 11u;
    _12._m0[_139] = uint(_109);
}

