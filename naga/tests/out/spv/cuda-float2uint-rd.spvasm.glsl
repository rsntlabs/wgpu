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
    uint _39 = _24 & 2147483647u;
    uint _40 = _24 & 2147483648u;
    uint _46 = 1u << ((150u - (_39 >> 23u)) & 31u);
    uint _47 = _46 - 1u;
    uint _51 = _24 & (~_47);
    return (_39 > 2139095040u) ? 2143289344u : ((_39 >= 1258291200u) ? _24 : ((_39 < 1065353216u) ? ((_39 == 0u) ? _24 : (_40 | ((_40 >> 31u) * 1065353216u))) : (((_40 != 0u) && ((_24 & _47) != 0u)) ? (_51 + _46) : _51)));
}

float _20(float _19)
{
    return _19;
}

void main()
{
    float _126 = 0.0;
    uint _120 = 0u;
    int _113 = 0;
    uint _107 = 0u;
    uint _100 = 0u;
    uint _94 = 0u;
    uint _124 = 0u;
    uint _118 = 0u;
    uint _111 = 0u;
    float _105 = 0.0;
    uint _98 = 0u;
    uint _91 = 0u;
    int _128 = 0;
    float _122 = 0.0;
    uint _116 = 0u;
    uint _109 = 0u;
    float _102 = 0.0;
    uint _96 = 0u;
    uint _137 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_137 >= _15._m0._m0)
    {
        return;
    }
    uint _142 = 4u + (_137 * 8u);
    uint _145 = _9._m0[_137];
    float _146 = uintBitsToFloat(_145);
    _91 = 0u;
    _12._m0[_142] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_146))), 0.0, 4294967040.0));
    _94 = _142 + 1u;
    _12._m0[_94] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_20(_146)))), 0.0, 4294967040.0));
    _91++;
    _96 = _142 + 2u;
    _12._m0[_96] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_146))), 0.0, 4294967040.0));
    _98 = _142 + 3u;
    _12._m0[_98] = uint(int(_91));
    if ((_137 & 1u) != 0u)
    {
        _120 = _91;
        _91 = _120 + uint(1);
        _122 = _146;
        _102 = _122;
        _107 = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_102))), 0.0, 4294967040.0));
    }
    else
    {
        _124 = _91;
        _91 = _124 + uint(1);
        _126 = _146;
        _105 = _126;
        _107 = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_105))), 0.0, 4294967040.0));
    }
    _100 = _142 + 4u;
    _12._m0[_100] = _107;
    _109 = _142 + 5u;
    _12._m0[_109] = uint(int(_91));
    float _218 = float(16777217u);
    _111 = _142 + 6u;
    _12._m0[_111] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_218))), 0.0, 4294967040.0));
    _113 = 7;
    _128 = 0;
    _128 = 3;
    _118 = uint(_113 + _128);
    _116 = _142 + 7u;
    _12._m0[_116] = _118;
}

