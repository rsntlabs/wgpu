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
    uint _44 = 1u << ((150u - (_39 >> 23u)) & 31u);
    uint _45 = _44 - 1u;
    uint _50 = _24 & (~_45);
    return (_39 > 2139095040u) ? 2143289344u : ((_39 >= 1258291200u) ? _24 : ((_39 < 1065353216u) ? ((_39 == 0u) ? _24 : (_40 | ((1u - (_40 >> 31u)) * 1065353216u))) : (((_40 == 0u) && ((_24 & _45) != 0u)) ? (_50 + _44) : _50)));
}

float _20(float _19)
{
    return _19;
}

void main()
{
    float _127 = 0.0;
    uint _121 = 0u;
    int _114 = 0;
    uint _108 = 0u;
    uint _101 = 0u;
    uint _95 = 0u;
    uint _125 = 0u;
    uint _119 = 0u;
    uint _112 = 0u;
    float _106 = 0.0;
    uint _99 = 0u;
    uint _92 = 0u;
    int _129 = 0;
    float _123 = 0.0;
    uint _117 = 0u;
    uint _110 = 0u;
    float _103 = 0.0;
    uint _97 = 0u;
    uint _138 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_138 >= _15._m0._m0)
    {
        return;
    }
    uint _143 = 4u + (_138 * 8u);
    uint _146 = _9._m0[_138];
    float _147 = uintBitsToFloat(_146);
    _92 = 0u;
    _12._m0[_143] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_147))), 0.0, 4294967040.0));
    _95 = _143 + 1u;
    _12._m0[_95] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_20(_147)))), 0.0, 4294967040.0));
    _92++;
    _97 = _143 + 2u;
    _12._m0[_97] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_147))), 0.0, 4294967040.0));
    _99 = _143 + 3u;
    _12._m0[_99] = uint(int(_92));
    if ((_138 & 1u) != 0u)
    {
        _121 = _92;
        _92 = _121 + uint(1);
        _123 = _147;
        _103 = _123;
        _108 = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_103))), 0.0, 4294967040.0));
    }
    else
    {
        _125 = _92;
        _92 = _125 + uint(1);
        _127 = _147;
        _106 = _127;
        _108 = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_106))), 0.0, 4294967040.0));
    }
    _101 = _143 + 4u;
    _12._m0[_101] = _108;
    _110 = _143 + 5u;
    _12._m0[_110] = uint(int(_92));
    float _219 = float(16777217u);
    _112 = _143 + 6u;
    _12._m0[_112] = uint(clamp(uintBitsToFloat(_25(floatBitsToUint(_219))), 0.0, 4294967040.0));
    _114 = 7;
    _129 = 0;
    _129 = 3;
    _119 = uint(_114 + _129);
    _117 = _143 + 7u;
    _12._m0[_117] = _119;
}

