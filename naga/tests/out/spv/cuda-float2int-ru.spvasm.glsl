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
    uint _45 = 1u << ((150u - (_40 >> 23u)) & 31u);
    uint _46 = _45 - 1u;
    uint _51 = _25 & (~_46);
    return (_40 > 2139095040u) ? 2143289344u : ((_40 >= 1258291200u) ? _25 : ((_40 < 1065353216u) ? ((_40 == 0u) ? _25 : (_41 | ((1u - (_41 >> 31u)) * 1065353216u))) : (((_41 == 0u) && ((_25 & _46) != 0u)) ? (_51 + _45) : _51)));
}

float _21(float _20)
{
    return _20;
}

void main()
{
    float _129 = 0.0;
    uint _123 = 0u;
    int _117 = 0;
    int _110 = 0;
    uint _103 = 0u;
    uint _97 = 0u;
    uint _127 = 0u;
    int _121 = 0;
    uint _115 = 0u;
    float _108 = 0.0;
    uint _101 = 0u;
    uint _94 = 0u;
    int _131 = 0;
    float _125 = 0.0;
    uint _119 = 0u;
    uint _113 = 0u;
    float _105 = 0.0;
    uint _99 = 0u;
    uint _140 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_140 >= _16._m0._m0)
    {
        return;
    }
    uint _145 = 4u + (_140 * 8u);
    uint _148 = _10._m0[_140];
    float _149 = uintBitsToFloat(_148);
    _94 = 0u;
    _13._m0[_145] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_149))), -2147483648.0, 2147483520.0));
    _97 = _145 + 1u;
    _13._m0[_97] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_21(_149)))), -2147483648.0, 2147483520.0));
    _94++;
    _99 = _145 + 2u;
    _13._m0[_99] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_149))), -2147483648.0, 2147483520.0));
    _101 = _145 + 3u;
    _13._m0[_101] = int(_94);
    if ((_140 & 1u) != 0u)
    {
        _123 = _94;
        _94 = _123 + uint(1);
        _125 = _149;
        _105 = _125;
        _110 = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_105))), -2147483648.0, 2147483520.0));
    }
    else
    {
        _127 = _94;
        _94 = _127 + uint(1);
        _129 = _149;
        _108 = _129;
        _110 = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_108))), -2147483648.0, 2147483520.0));
    }
    _103 = _145 + 4u;
    _13._m0[_103] = _110;
    _113 = _145 + 5u;
    _13._m0[_113] = int(_94);
    float _220 = float(16777217);
    _115 = _145 + 6u;
    _13._m0[_115] = int(clamp(uintBitsToFloat(_26(floatBitsToUint(_220))), -2147483648.0, 2147483520.0));
    _117 = 7;
    _131 = 0;
    _131 = 3;
    _121 = _117 + _131;
    _119 = _145 + 7u;
    _13._m0[_119] = _121;
}

