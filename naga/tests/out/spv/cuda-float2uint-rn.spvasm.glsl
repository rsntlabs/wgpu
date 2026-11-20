#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _7
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _10_9
{
    uint _m0[];
} _9;

layout(set = 0, binding = 1, std430) buffer _13_12
{
    uint _m0[];
} _12;

layout(set = 0, binding = 2, std140) uniform _16_15
{
    _7 _m0;
} _15;

uint _25(uint _24)
{
    uint _40 = _24 & 2147483647u;
    uint _45 = 1u << ((150u - (_40 >> 23u)) & 31u);
    uint _46 = _45 - 1u;
    uint _47 = _24 & _46;
    uint _51 = _24 & (~_46);
    uint _53 = _45 >> 1u;
    return (_40 > 2139095040u) ? 2143289344u : ((_40 >= 1258291200u) ? _24 : ((_40 < 1065353216u) ? ((_40 == 0u) ? _24 : ((_24 & 2147483648u) | (uint(_40 > 1056964608u) * 1065353216u))) : ((((_47 > _53) || ((_47 == _53) && ((_51 & _45) != 0u))) && (_47 != 0u)) ? (_51 + _45) : _51)));
}

float _20(float _19)
{
    return _19;
}

void main()
{
    float _134 = 0.0;
    uint _128 = 0u;
    int _121 = 0;
    uint _115 = 0u;
    uint _108 = 0u;
    uint _102 = 0u;
    uint _132 = 0u;
    uint _126 = 0u;
    uint _119 = 0u;
    float _113 = 0.0;
    uint _106 = 0u;
    uint _99 = 0u;
    int _136 = 0;
    float _130 = 0.0;
    uint _124 = 0u;
    uint _117 = 0u;
    float _110 = 0.0;
    uint _104 = 0u;
    uint _145 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_145 >= _15._m0._m0)
    {
        return;
    }
    uint _150 = 4u + (_145 * 8u);
    uint _153 = _9._m0[_145];
    float _154 = uintBitsToFloat(_153);
    _99 = 0u;
    _12._m0[_150] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_154))), 0.0, 4294967040.0));
    _102 = _150 + 1u;
    _12._m0[_102] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_20(_154)))), 0.0, 4294967040.0));
    _99++;
    _104 = _150 + 2u;
    _12._m0[_104] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_154))), 0.0, 4294967040.0));
    _106 = _150 + 3u;
    _12._m0[_106] = uint(int(_99));
    if ((_145 & 1u) != 0u)
    {
        _128 = _99;
        _99 = _128 + uint(1);
        _130 = _154;
        _110 = _130;
        _115 = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_110))), 0.0, 4294967040.0));
    }
    else
    {
        _132 = _99;
        _99 = _132 + uint(1);
        _134 = _154;
        _113 = _134;
        _115 = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_113))), 0.0, 4294967040.0));
    }
    _108 = _150 + 4u;
    _12._m0[_108] = _115;
    _117 = _150 + 5u;
    _12._m0[_117] = uint(int(_99));
    float _226 = float(16777217u);
    _119 = _150 + 6u;
    _12._m0[_119] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_226))), 0.0, 4294967040.0));
    _121 = 7;
    _136 = 0;
    _136 = 3;
    _126 = uint(_121 + _136);
    _124 = _150 + 7u;
    _12._m0[_124] = _126;
}

