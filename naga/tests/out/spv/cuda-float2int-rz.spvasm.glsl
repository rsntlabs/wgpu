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

float _21(float _20)
{
    return _20;
}

void main()
{
    float _87 = 0.0;
    uint _81 = 0u;
    int _75 = 0;
    int _68 = 0;
    uint _61 = 0u;
    uint _55 = 0u;
    uint _85 = 0u;
    int _79 = 0;
    uint _73 = 0u;
    float _66 = 0.0;
    uint _59 = 0u;
    uint _52 = 0u;
    int _89 = 0;
    float _83 = 0.0;
    uint _77 = 0u;
    uint _71 = 0u;
    float _63 = 0.0;
    uint _57 = 0u;
    uint _98 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_98 >= _16._m0._m0)
    {
        return;
    }
    uint _104 = 4u + (_98 * 8u);
    uint _107 = _10._m0[_98];
    float _108 = uintBitsToFloat(_107);
    _52 = 0u;
    _13._m0[_104] = int(clamp(_108, -2147483648.0, 2147483520.0));
    _55 = _104 + 1u;
    _13._m0[_55] = int(clamp(_21(_108), -2147483648.0, 2147483520.0));
    _52++;
    _57 = _104 + 2u;
    _13._m0[_57] = int(clamp(_108, -2147483648.0, 2147483520.0));
    _59 = _104 + 3u;
    _13._m0[_59] = int(_52);
    if ((_98 & 1u) != 0u)
    {
        _81 = _52;
        _52 = _81 + uint(1);
        _83 = _108;
        _63 = _83;
        _68 = int(clamp(_63, -2147483648.0, 2147483520.0));
    }
    else
    {
        _85 = _52;
        _52 = _85 + uint(1);
        _87 = _108;
        _66 = _87;
        _68 = int(clamp(_66, -2147483648.0, 2147483520.0));
    }
    _61 = _104 + 4u;
    _13._m0[_61] = _68;
    _71 = _104 + 5u;
    _13._m0[_71] = int(_52);
    float _164 = float(16777217);
    _73 = _104 + 6u;
    _13._m0[_73] = int(clamp(_164, -2147483648.0, 2147483520.0));
    _75 = 7;
    _89 = 0;
    _89 = 3;
    _79 = _75 + _89;
    _77 = _104 + 7u;
    _13._m0[_77] = _79;
}

