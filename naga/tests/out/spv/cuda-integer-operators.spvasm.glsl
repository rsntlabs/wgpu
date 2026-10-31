#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    int _m0;
};

struct _7
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _12_11
{
    uint _m0[];
} _11;

layout(set = 0, binding = 1, std140) uniform _15_14
{
    _6 _m0;
} _14;

layout(set = 0, binding = 2, std140) uniform _18_17
{
    _7 _m0;
} _17;

int _20(int _22, int _23)
{
    int _35 = ((_23 == 0) || ((_22 == int(0x80000000)) && (_23 == (-1)))) ? 1 : _23;
    return _22 - ((_22 / _35) * _35);
}

uint _39(uint _41, uint _42)
{
    return _41 % ((_42 == 0u) ? 1u : _42);
}

void main()
{
    uint _81 = 0u;
    uint _75[2] = uint[](0u, 0u);
    uint _67[2] = uint[](0u, 0u);
    uint _83 = 0u;
    uint _77 = 0u;
    uint _70 = 0u;
    uint _79[2] = uint[](0u, 0u);
    uint _73 = 0u;
    _67 = uint[](0u, 0u);
    _67[0u] = 0u;
    _67[1u] = 0u;
    int _94 = -3;
    _70 = uint(_20(_14._m0._m0, _94)) & 15u;
    _70 |= 8u;
    _70 ^= 1u;
    _73 = _17._m0._m0;
    _70 = _70 << _73;
    _70 = _70 >> 1u;
    _70 = _39(_70, 97u);
    _70 &= 255u;
    _75 = _67;
    _77 = gl_LocalInvocationID.x;
    _79 = _75;
    _79[1u] += _77;
    _81 = _79[0u];
    _83 = _79[1u];
    _11._m0[_83] = ~_70;
}

