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

uint _20(int _19)
{
    return 2u;
}

void main()
{
    float _59 = 0.0;
    uint _53 = 0u;
    uint _57 = 0u;
    uint _50 = 0u;
    uint _55 = 0u;
    uint _69 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_69 >= _15._m0._m0)
    {
        return;
    }
    uint _75 = 4u + (_69 * 4u);
    uint _78 = _9._m0[_69];
    float _79 = uintBitsToFloat(_78);
    _50 = 0u;
    uint _81 = floatBitsToUint(_79) & 2147483647u;
    uint _82 = _81 >> 23u;
    _12._m0[_75] = uint(((_81 == 0u) || (_81 > 2139095040u)) ? int(0x80000000) : ((_81 == 2139095040u) ? 2147483647 : ((_82 == 0u) ? ((-118) - int(31u - uint(findMSB(_81)))) : (int(_82) - 127))));
    _59 = 0.0;
    _59 = _79;
    _50++;
    uint _105 = floatBitsToUint(_59) & 2147483647u;
    uint _106 = _105 >> 23u;
    _53 = _75 + 1u;
    _12._m0[_53] = uint(((_105 == 0u) || (_105 > 2139095040u)) ? int(0x80000000) : ((_105 == 2139095040u) ? 2147483647 : ((_106 == 0u) ? ((-118) - int(31u - uint(findMSB(_105)))) : (int(_106) - 127))));
    _55 = _75 + 2u;
    _12._m0[_55] = _50;
    uint _130 = floatBitsToUint(_79) & 2147483647u;
    uint _131 = _130 >> 23u;
    _57 = _75 + 3u;
    _12._m0[_57] = _20(((_130 == 0u) || (_130 > 2139095040u)) ? int(0x80000000) : ((_130 == 2139095040u) ? 2147483647 : ((_131 == 0u) ? ((-118) - int(31u - uint(findMSB(_130)))) : (int(_131) - 127))));
}

