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
    uint _88 = 0u;
    uint _82[2] = uint[](0u, 0u);
    int _76 = 0;
    uint _67[2] = uint[](0u, 0u);
    uint _90 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    int _70 = 0;
    uint _86[2] = uint[](0u, 0u);
    uint _80 = 0u;
    uint _73 = 0u;
    _67 = uint[](0u, 0u);
    _67[0u] = 0u;
    _67[1u] = 0u;
    _70 = _14._m0._m0;
    _73 = _17._m0._m0;
    int _101 = -3;
    _76 = _20(_70, _101);
    _78 = uint(_76) & 15u;
    _78 |= 8u;
    _78 ^= 1u;
    _80 = _73;
    _78 = _78 << _80;
    _78 = _78 >> 1u;
    _78 = _39(_78, 97u);
    _78 &= 255u;
    _82 = _67;
    _84 = gl_LocalInvocationID.x;
    _86 = _82;
    _86[1u] += _84;
    _88 = _86[0u];
    _90 = _86[1u];
    _11._m0[_90] = ~_78;
}

