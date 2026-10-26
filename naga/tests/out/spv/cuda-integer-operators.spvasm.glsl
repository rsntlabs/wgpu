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
    uint _84 = 0u;
    uint _78 = 0u;
    int _72 = 0;
    uint _64 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    int _67 = 0;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    _64 = 0u;
    _67 = _12._m0._m0;
    _70 = _15._m0._m0;
    int _93 = -3;
    _72 = _18(_67, _93);
    _74 = uint(_72) & 15u;
    _74 |= 8u;
    _74 ^= 1u;
    _76 = _70;
    _74 = _74 << _76;
    _74 = _74 >> 1u;
    _74 = _37(_74, 97u);
    _74 &= 255u;
    _78 = _64;
    _80 = _78;
    _82 = gl_LocalInvocationID.x;
    _84 = _80 + _82;
    _9._m0[_84] = ~_74;
}

