#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    int _m0;
};

struct _7
{
    uint _m0;
    float _m1;
};

struct _8
{
    int _m0;
    uint _m1;
    float _m2;
};

struct _9
{
    int _m0;
    uint _m1;
    float _m2;
    uint _m3;
};

struct _10
{
    int _m0;
    uint _m1;
    float _m2;
};

struct _12
{
    _4 _m0;
};

struct _13
{
    _7 _m0;
};

struct _14
{
    _8 _m0;
};

struct _15
{
    _9 _m0;
};

layout(set = 0, binding = 0, std430) buffer _19_18
{
    uint _m0[];
} _18;

layout(set = 0, binding = 1, std140) uniform _22_21
{
    _12 _m0;
} _21;

layout(set = 0, binding = 2, std140) uniform _25_24
{
    _13 _m0;
} _24;

layout(set = 0, binding = 3, std140) uniform _28_27
{
    _14 _m0;
} _27;

layout(set = 0, binding = 4, std140) uniform _31_30
{
    _15 _m0;
} _30;

layout(set = 0, binding = 5, std430) readonly buffer _34_33
{
    _8 _m0[];
} _33;

uint _38(_8 _37)
{
    return 11u;
}

uint _44(_10 _43)
{
    return 22u;
}

void main()
{
    uint _128 = 0u;
    uint _122 = 0u;
    uint _116 = 0u;
    uint _110 = 0u;
    _8 _103 = _8(0, 0u, 0.0);
    _8 _96 = _8(0, 0u, 0.0);
    _7 _87 = _7(0u, 0.0);
    _8 _132 = _8(0, 0u, 0.0);
    uint _126 = 0u;
    uint _120 = 0u;
    uint _114 = 0u;
    uint _108 = 0u;
    _10 _100 = _10(0, 0u, 0.0);
    _9 _93 = _9(0, 0u, 0.0, 0u);
    _4 _84 = _4(0);
    _8 _130 = _8(0, 0u, 0.0);
    uint _124 = 0u;
    uint _118 = 0u;
    uint _112 = 0u;
    uint _105 = 0u;
    _9 _98 = _9(0, 0u, 0.0, 0u);
    _8 _90 = _8(0, 0u, 0.0);
    _84 = _21._m0._m0;
    _87 = _24._m0._m0;
    _90 = _27._m0._m0;
    _93 = _30._m0._m0;
    uint _150 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_150 >= 4u)
    {
        return;
    }
    uint _156 = 4u + (_150 * 12u);
    _96 = _90;
    _84._m0 += int(_150);
    _128 = 0u;
    _128 = _150;
    _90._m1 += _128;
    _90._m0 -= int(_150);
    _98 = _93;
    _98._m0 += int(_150);
    _98._m1++;
    _98._m2 *= 2.0;
    _93 = _98;
    _100._m0 = _96._m0;
    _100._m1 = _96._m1;
    _100._m2 = _96._m2;
    _132 = _33._m0[_150];
    _130 = _132;
    _103 = _130;
    _18._m0[_156] = uint(_84._m0 + 10);
    _105 = _156 + 1u;
    _18._m0[_105] = _87._m0;
    _108 = _156 + 2u;
    _18._m0[_108] = floatBitsToUint(_87._m1);
    _110 = _156 + 3u;
    _18._m0[_110] = uint(_90._m0 + 20);
    _112 = _156 + 4u;
    _18._m0[_112] = _90._m1;
    _114 = _156 + 5u;
    _18._m0[_114] = floatBitsToUint(_90._m2);
    _116 = _156 + 6u;
    _18._m0[_116] = uint(_93._m0 + 20);
    _118 = _156 + 7u;
    _18._m0[_118] = _93._m1;
    _120 = _156 + 8u;
    _18._m0[_120] = floatBitsToUint(_93._m2);
    _122 = _156 + 9u;
    _18._m0[_122] = _93._m3;
    _124 = _156 + 10u;
    _18._m0[_124] = _96._m1;
    _126 = _156 + 11u;
    _18._m0[_126] = (((_38(_90) + _44(_100)) + uint(_103._m0)) + _103._m1) + uint(clamp(_103._m2, 0.0, 4294967040.0));
}

