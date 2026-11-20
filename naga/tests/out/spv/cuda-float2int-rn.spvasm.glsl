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
    uint _41 = _25 & 2147483647u;
    uint _46 = 1u << ((150u - (_41 >> 23u)) & 31u);
    uint _47 = _46 - 1u;
    uint _48 = _25 & _47;
    uint _52 = _25 & (~_47);
    uint _54 = _46 >> 1u;
    return (_41 > 2139095040u) ? 2143289344u : ((_41 >= 1258291200u) ? _25 : ((_41 < 1065353216u) ? ((_41 == 0u) ? _25 : ((_25 & 2147483648u) | (uint(_41 > 1056964608u) * 1065353216u))) : ((((_48 > _54) || ((_48 == _54) && ((_52 & _46) != 0u))) && (_48 != 0u)) ? (_52 + _46) : _52)));
}

float _21(float _20)
{
    return _20;
}

void main()
{
    float _136 = 0.0;
    uint _130 = 0u;
    int _124 = 0;
    int _117 = 0;
    uint _110 = 0u;
    uint _104 = 0u;
    uint _134 = 0u;
    int _128 = 0;
    uint _122 = 0u;
    float _115 = 0.0;
    uint _108 = 0u;
    uint _101 = 0u;
    int _138 = 0;
    float _132 = 0.0;
    uint _126 = 0u;
    uint _120 = 0u;
    float _112 = 0.0;
    uint _106 = 0u;
    uint _147 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_147 >= _16._m0._m0)
    {
        return;
    }
    uint _152 = 4u + (_147 * 8u);
    uint _155 = _10._m0[_147];
    float _156 = uintBitsToFloat(_155);
    _101 = 0u;
    _13._m0[_152] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_156))), -2147483648.0, 2147483520.0));
    _104 = _152 + 1u;
    _13._m0[_104] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_21(_156)))), -2147483648.0, 2147483520.0));
    _101++;
    _106 = _152 + 2u;
    _13._m0[_106] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_156))), -2147483648.0, 2147483520.0));
    _108 = _152 + 3u;
    _13._m0[_108] = int(_101);
    if ((_147 & 1u) != 0u)
    {
        _130 = _101;
        _101 = _130 + uint(1);
        _132 = _156;
        _112 = _132;
        _117 = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_112))), -2147483648.0, 2147483520.0));
    }
    else
    {
        _134 = _101;
        _101 = _134 + uint(1);
        _136 = _156;
        _115 = _136;
        _117 = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_115))), -2147483648.0, 2147483520.0));
    }
    _110 = _152 + 4u;
    _13._m0[_110] = _117;
    _120 = _152 + 5u;
    _13._m0[_120] = int(_101);
    float _227 = float(16777217);
    _122 = _152 + 6u;
    _13._m0[_122] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_227))), -2147483648.0, 2147483520.0));
    _124 = 7;
    _138 = 0;
    _138 = 3;
    _128 = _124 + _138;
    _126 = _152 + 7u;
    _13._m0[_126] = _128;
}

