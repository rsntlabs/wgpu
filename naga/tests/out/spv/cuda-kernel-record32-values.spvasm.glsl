#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    int _m0;
    uint _m1;
    float _m2;
    uint _m3;
    int _m4;
};

struct _7
{
    int _m0;
    uint _m1;
    float _m2;
    uint _m3;
    int _m4;
    uint _m5;
};

struct _8
{
    int _m0;
    uint _m1;
    float _m2;
    uint _m3;
    int _m4;
    uint _m5;
    float _m6;
};

struct _9
{
    int _m0;
    uint _m1;
    float _m2;
    uint _m3;
    int _m4;
    uint _m5;
    float _m6;
    uint _m7;
};

struct _10
{
    uint _m0;
};

struct _12
{
    _6 _m0;
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

struct _16
{
    _10 _m0;
};

layout(set = 0, binding = 0, std430) buffer _20_19
{
    uint _m0[];
} _19;

layout(set = 0, binding = 1, std140) uniform _23_22
{
    _12 _m0;
} _22;

layout(set = 0, binding = 2, std140) uniform _26_25
{
    _13 _m0;
} _25;

layout(set = 0, binding = 3, std140) uniform _29_28
{
    _14 _m0;
} _28;

layout(set = 0, binding = 4, std140) uniform _32_31
{
    _15 _m0;
} _31;

layout(set = 0, binding = 5, std140) uniform _35_34
{
    _16 _m0;
} _34;

layout(set = 0, binding = 6, std430) readonly buffer _38_37
{
    _6 _m0[];
} _37;

void main()
{
    _6 _127 = _6(0, 0u, 0.0, 0u, 0);
    uint _121 = 0u;
    uint _115 = 0u;
    uint _109 = 0u;
    uint _103 = 0u;
    _9 _96 = _9(0, 0u, 0.0, 0u, 0, 0u, 0.0, 0u);
    _10 _89 = _10(0u);
    _7 _80 = _7(0, 0u, 0.0, 0u, 0, 0u);
    _6 _125 = _6(0, 0u, 0.0, 0u, 0);
    uint _119 = 0u;
    uint _113 = 0u;
    uint _107 = 0u;
    uint _100 = 0u;
    _8 _94 = _8(0, 0u, 0.0, 0u, 0, 0u, 0.0);
    _9 _86 = _9(0, 0u, 0.0, 0u, 0, 0u, 0.0, 0u);
    _6 _77 = _6(0, 0u, 0.0, 0u, 0);
    uint _123 = 0u;
    uint _117 = 0u;
    uint _111 = 0u;
    uint _105 = 0u;
    _6 _98 = _6(0, 0u, 0.0, 0u, 0);
    _6 _92 = _6(0, 0u, 0.0, 0u, 0);
    _8 _83 = _8(0, 0u, 0.0, 0u, 0, 0u, 0.0);
    _77 = _22._m0._m0;
    _80 = _25._m0._m0;
    _83 = _28._m0._m0;
    _86 = _31._m0._m0;
    _89 = _34._m0._m0;
    uint _148 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_148 >= 4u)
    {
        return;
    }
    uint _154 = 4u + (_148 * 12u);
    _92 = _77;
    _94 = _83;
    _123 = 0u;
    _123 = _148;
    _77._m4 += int(_123);
    _83._m6 += float(_148);
    _96 = _86;
    _96._m7 += _148;
    _86 = _96;
    _127 = _37._m0[_148];
    _125 = _127;
    _98 = _125;
    _19._m0[_154] = uint(_92._m4 + 30);
    _100 = _154 + 1u;
    _19._m0[_100] = uint(_77._m4 + 30);
    _103 = _154 + 2u;
    _19._m0[_103] = uint(_80._m4 + 30);
    _105 = _154 + 3u;
    _19._m0[_105] = _80._m5;
    _107 = _154 + 4u;
    _19._m0[_107] = floatBitsToUint(_83._m6);
    _109 = _154 + 5u;
    _19._m0[_109] = floatBitsToUint(_94._m6);
    _111 = _154 + 6u;
    _19._m0[_111] = _86._m7;
    _113 = _154 + 7u;
    _19._m0[_113] = _86._m5;
    _115 = _154 + 8u;
    _19._m0[_115] = floatBitsToUint(_86._m6);
    _117 = _154 + 9u;
    _19._m0[_117] = uint(_86._m4 + 30);
    _119 = _154 + 10u;
    _19._m0[_119] = _89._m0;
    _121 = _154 + 11u;
    _19._m0[_121] = ((uint(_98._m0 + _98._m4) + _98._m1) + _98._m3) + uint(clamp(_98._m2, 0.0, 4294967040.0));
}

