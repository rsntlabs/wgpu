#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _9_8
{
    uint _m0[];
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    uint _m0[];
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _6 _m0;
} _14;

uint _19(float _18)
{
    return 1u;
}

void main()
{
    uint _63 = 0u;
    uint _57 = 0u;
    uint _50 = 0u;
    float _65 = 0.0;
    uint _59 = 0u;
    uint _53 = 0u;
    uint _61 = 0u;
    uint _55 = 0u;
    uint _75 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_75 >= _14._m0._m0)
    {
        return;
    }
    uint _81 = 4u + (_75 * 4u);
    uint _84 = _8._m0[_75];
    float _85 = uintBitsToFloat(_84);
    _50 = 0u;
    uint _87 = floatBitsToUint(_85) & 2147483647u;
    uint _88 = _87 >> 23u;
    bool _99 = _87 > 2139095040u;
    _53 = ((_87 == 0u) || _99) ? (_99 ? 2143289344u : 4286578688u) : ((_87 == 2139095040u) ? 2139095040u : floatBitsToUint(float((_88 == 0u) ? ((-118) - int(31u - uint(findMSB(_87)))) : (int(_88) - 127))));
    _11._m0[_81] = floatBitsToUint(uintBitsToFloat(_53));
    _65 = 0.0;
    _65 = _85;
    _50++;
    uint _116 = floatBitsToUint(_65) & 2147483647u;
    uint _117 = _116 >> 23u;
    bool _127 = _116 > 2139095040u;
    _57 = ((_116 == 0u) || _127) ? (_127 ? 2143289344u : 4286578688u) : ((_116 == 2139095040u) ? 2139095040u : floatBitsToUint(float((_117 == 0u) ? ((-118) - int(31u - uint(findMSB(_116)))) : (int(_117) - 127))));
    _55 = _81 + 1u;
    _11._m0[_55] = floatBitsToUint(uintBitsToFloat(_57));
    _59 = _81 + 2u;
    _11._m0[_59] = _50;
    uint _146 = floatBitsToUint(_85) & 2147483647u;
    uint _147 = _146 >> 23u;
    bool _157 = _146 > 2139095040u;
    _63 = ((_146 == 0u) || _157) ? (_157 ? 2143289344u : 4286578688u) : ((_146 == 2139095040u) ? 2139095040u : floatBitsToUint(float((_147 == 0u) ? ((-118) - int(31u - uint(findMSB(_146)))) : (int(_147) - 127))));
    _61 = _81 + 3u;
    _11._m0[_61] = _19(uintBitsToFloat(_63));
}

