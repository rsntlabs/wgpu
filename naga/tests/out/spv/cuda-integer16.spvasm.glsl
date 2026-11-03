#version 460
#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require
#extension GL_EXT_shader_16bit_storage : require
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    int16_t _m0;
    uint16_t _m1;
    uint _m2;
    int16_t _m3;
    uint16_t _m4;
};

struct _10
{
    uint16_t _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _13_12
{
    _6 _m0[];
} _12;

layout(set = 0, binding = 1, std430) buffer _16_15
{
    _6 _m0[];
} _15;

layout(set = 0, binding = 2, std430) buffer _19_18
{
    uint _m0[];
} _18;

layout(set = 0, binding = 3, std140) uniform _22_21
{
    _10 _m0;
} _21;

int16_t _44(int16_t _43)
{
    return _43;
}

uint16_t _49(uint16_t _48)
{
    return _48;
}

int _63(int _65, int _66)
{
    return _65 / (((_66 == 0) || ((_65 == int(0x80000000)) && (_66 == (-1)))) ? 1 : _66);
}

int _26(int _25)
{
    return 31;
}

int _32(int16_t _31)
{
    return 41;
}

int _38(uint16_t _37)
{
    return 43;
}

int _53()
{
    return _32(-1s);
}

int _59()
{
    return _38(65535us);
}

void main()
{
    _6 _162 = _6(0s, 0us, 0u, 0s, 0us);
    uint _156 = 0u;
    uint _150 = 0u;
    uint _144 = 0u;
    uint _138 = 0u;
    uint _132 = 0u;
    uint _125 = 0u;
    _6 _117 = _6(0s, 0us, 0u, 0s, 0us);
    _6 _160 = _6(0s, 0us, 0u, 0s, 0us);
    uint _154 = 0u;
    uint _148 = 0u;
    uint _142 = 0u;
    uint _136 = 0u;
    uint _130 = 0u;
    uint16_t _122 = 0us;
    _6 _114 = _6(0s, 0us, 0u, 0s, 0us);
    int16_t _158 = 0s;
    uint _152 = 0u;
    uint _146 = 0u;
    uint _140 = 0u;
    uint _134 = 0u;
    uint _128 = 0u;
    int16_t _119 = 0s;
    uint _171 = (gl_WorkGroupID.x * 4u) + gl_LocalInvocationID.x;
    if (_171 >= uint(_21._m0._m0))
    {
        return;
    }
    _162 = _12._m0[_171];
    _160 = _162;
    _114 = _160;
    _117 = _114;
    int _190 = int(uint(_114._m1)) + int(uint(_114._m1));
    _119 = _44(_114._m0);
    _122 = _49(_114._m1);
    _119 = int16_t(int(_119) + 3);
    int _201 = -1;
    _119 = int16_t(_63(int(_119), int(int16_t(_201))));
    _122 = uint16_t(int(uint(_122)) + int(uint(uint16_t(1))));
    _125 = uint(1);
    _122 = uint16_t(int(uint(_122)) << int(_125));
    _117._m0 = int16_t(clamp(float(_119), -32768.0, 32767.0));
    _117._m1 = uint16_t(clamp(float(_122), 0.0, 65535.0));
    _117._m2 = uint(_190);
    _117._m3 = int16_t(~int(_114._m3));
    _117._m4 = uint16_t(int(uint(_114._m4)) + 1);
    _15._m0[_171] = _117;
    uint _255 = _171 * 16u;
    _18._m0[_255] = uint(_190);
    _128 = _255 + 1u;
    _18._m0[_128] = uint(_26(int(uint(_114._m1))));
    _130 = _255 + 2u;
    _18._m0[_130] = uint(_32(_114._m0));
    _132 = _255 + 3u;
    _18._m0[_132] = uint(_38(_114._m1));
    _134 = _255 + 4u;
    _18._m0[_134] = uint(_53());
    _136 = _255 + 5u;
    _18._m0[_136] = uint(_59());
    _138 = _255 + 6u;
    _18._m0[_138] = uint(int(uint(_114._m1)));
    _140 = _255 + 7u;
    _18._m0[_140] = uint(-int(uint(_114._m1)));
    _142 = _255 + 8u;
    _18._m0[_142] = uint(~int(uint(_114._m1)));
    int _318 = -32768;
    int _320 = -1;
    _144 = _255 + 9u;
    _18._m0[_144] = uint(_63(int(int16_t(_318)), int(int16_t(_320))));
    _146 = _255 + 10u;
    _18._m0[_146] = uint(int(_114._m0) < int(uint(_114._m1)));
    _148 = _255 + 11u;
    _18._m0[_148] = uint(uint(_114._m0) < 1u);
    _150 = _255 + 12u;
    _18._m0[_150] = uint(_117._m0);
    _152 = _255 + 13u;
    _18._m0[_152] = uint(_117._m1);
    _154 = _255 + 14u;
    _18._m0[_154] = uint(_114._m3);
    if ((_171 & 1u) != 0u)
    {
        _158 = _114._m0;
    }
    else
    {
        _158 = _117._m3;
    }
    _156 = _255 + 15u;
    _18._m0[_156] = uint(_32(_158));
}

