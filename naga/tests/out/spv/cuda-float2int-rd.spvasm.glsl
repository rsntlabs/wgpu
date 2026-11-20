#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _8
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _11_10
{
    uint _m0[];
} _10;

layout(set = 0, binding = 1, std430) buffer _14_13
{
    int _m0[];
} _13;

layout(set = 0, binding = 2, std140) uniform _17_16
{
    _8 _m0;
} _16;

uint _26(uint _25)
{
    uint _40 = _25 & 2147483647u;
    uint _41 = _25 & 2147483648u;
    uint _47 = 1u << ((150u - (_40 >> 23u)) & 31u);
    uint _48 = _47 - 1u;
    uint _52 = _25 & (~_48);
    return (_40 > 2139095040u) ? 2143289344u : ((_40 >= 1258291200u) ? _25 : ((_40 < 1065353216u) ? ((_40 == 0u) ? _25 : (_41 | ((_41 >> 31u) * 1065353216u))) : (((_41 != 0u) && ((_25 & _48) != 0u)) ? (_52 + _47) : _52)));
}

float _21(float _20)
{
    return _20;
}

void main()
{
    float _128 = 0.0;
    uint _122 = 0u;
    int _116 = 0;
    int _109 = 0;
    uint _102 = 0u;
    uint _96 = 0u;
    uint _126 = 0u;
    int _120 = 0;
    uint _114 = 0u;
    float _107 = 0.0;
    uint _100 = 0u;
    uint _93 = 0u;
    int _130 = 0;
    float _124 = 0.0;
    uint _118 = 0u;
    uint _112 = 0u;
    float _104 = 0.0;
    uint _98 = 0u;
    uint _139 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_139 >= _16._m0._m0)
    {
        return;
    }
    uint _144 = 4u + (_139 * 8u);
    uint _147 = _10._m0[_139];
    float _148 = uintBitsToFloat(_147);
    _93 = 0u;
    _13._m0[_144] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_148))), -2147483648.0, 2147483520.0));
    _96 = _144 + 1u;
    _13._m0[_96] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_21(_148)))), -2147483648.0, 2147483520.0));
    _93++;
    _98 = _144 + 2u;
    _13._m0[_98] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_148))), -2147483648.0, 2147483520.0));
    _100 = _144 + 3u;
    _13._m0[_100] = int(_93);
    if ((_139 & 1u) != 0u)
    {
        _122 = _93;
        _93 = _122 + uint(1);
        _124 = _148;
        _104 = _124;
        _109 = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_104))), -2147483648.0, 2147483520.0));
    }
    else
    {
        _126 = _93;
        _93 = _126 + uint(1);
        _128 = _148;
        _107 = _128;
        _109 = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_107))), -2147483648.0, 2147483520.0));
    }
    _102 = _144 + 4u;
    _13._m0[_102] = _109;
    _112 = _144 + 5u;
    _13._m0[_112] = int(_93);
    float _219 = float(16777217);
    _114 = _144 + 6u;
    _13._m0[_114] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_219))), -2147483648.0, 2147483520.0));
    _116 = 7;
    _130 = 0;
    _130 = 3;
    _120 = _116 + _130;
    _118 = _144 + 7u;
    _13._m0[_118] = _120;
}

