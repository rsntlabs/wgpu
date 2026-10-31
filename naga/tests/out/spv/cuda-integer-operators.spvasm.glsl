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

layout(set = 0, binding = 0, std430) buffer _10_9
{
    uint _m0[];
} _9;

layout(set = 0, binding = 1, std140) uniform _13_12
{
    _6 _m0;
} _12;

layout(set = 0, binding = 2, std140) uniform _16_15
{
    _7 _m0;
} _15;

int _18(int _20, int _21)
{
    int _33 = ((_21 == 0) || ((_20 == int(0x80000000)) && (_21 == (-1)))) ? 1 : _21;
    return _20 - ((_20 / _33) * _33);
}

uint _37(uint _39, uint _40)
{
    return _39 % ((_40 == 0u) ? 1u : _40);
}

void main()
{
    uint _67 = 0u;
    uint _71 = 0u;
    uint _64 = 0u;
    uint _69 = 0u;
    int _80 = -3;
    _64 = uint(_18(_12._m0._m0, _80)) & 15u;
    _64 |= 8u;
    _64 ^= 1u;
    _67 = _15._m0._m0;
    _64 = _64 << _67;
    _64 = _64 >> 1u;
    _64 = _37(_64, 97u);
    _64 &= 255u;
    _69 = gl_LocalInvocationID.x;
    _71 = _69;
    _9._m0[_71] = ~_64;
}

