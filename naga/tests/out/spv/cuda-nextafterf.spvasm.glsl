#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _10_9
{
    uvec2 _m0[];
} _9;

layout(set = 0, binding = 1, std430) buffer _13_12
{
    uint _m0[];
} _12;

uint _24(uint _22, uint _23)
{
    uint _32 = _22 & 2147483647u;
    uint _33 = _23 & 2147483647u;
    if ((_32 > 2139095040u) || (_33 > 2139095040u))
    {
        return 2143289344u;
    }
    bool _40 = _32 == 0u;
    if ((_40 && (_33 == 0u)) || (_22 == _23))
    {
        return _23;
    }
    if (_40)
    {
        return (_23 & 2147483648u) | 1u;
    }
    return (((_22 ^ _23) < 2147483648u) && (_33 > _32)) ? (_22 + 1u) : (_22 - 1u);
}

uint _17(float _16)
{
    return 1u;
}

void main()
{
    float _86 = 0.0;
    uint _80 = 0u;
    uint _84 = 0u;
    uint _77 = 0u;
    float _89 = 0.0;
    uint _82 = 0u;
    uint _95 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_95 >= 24u)
    {
        return;
    }
    uint _100 = 4u + (_95 * 4u);
    uint _104 = _9._m0[_95].x;
    float _105 = uintBitsToFloat(_104);
    uint _107 = _9._m0[_95].y;
    float _108 = uintBitsToFloat(_107);
    _77 = 0u;
    _12._m0[_100] = floatBitsToUint(uintBitsToFloat(_24(floatBitsToUint(_105), floatBitsToUint(_108))));
    _86 = 0.0;
    _86 = _105;
    _77++;
    _89 = 0.0;
    _89 = _108;
    _77++;
    _80 = _100 + 1u;
    _12._m0[_80] = floatBitsToUint(uintBitsToFloat(_24(floatBitsToUint(_86), floatBitsToUint(_89))));
    _82 = _100 + 2u;
    _12._m0[_82] = _77;
    _84 = _100 + 3u;
    _12._m0[_84] = _17(uintBitsToFloat(_24(floatBitsToUint(_105), floatBitsToUint(_108))));
}

