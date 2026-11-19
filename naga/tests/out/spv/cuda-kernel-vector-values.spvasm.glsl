#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _8
{
    ivec2 _m0;
};

struct _10
{
    uvec2 _m0;
};

struct _13
{
    vec2 _m0;
};

struct _14
{
    ivec4 _m0;
};

struct _16
{
    uvec4 _m0;
};

struct _18
{
    vec4 _m0;
};

layout(set = 0, binding = 0, std430) buffer _21_20
{
    uint _m0[];
} _20;

layout(set = 0, binding = 1, std140) uniform _24_23
{
    _8 _m0;
} _23;

layout(set = 0, binding = 2, std140) uniform _27_26
{
    _10 _m0;
} _26;

layout(set = 0, binding = 3, std140) uniform _30_29
{
    _13 _m0;
} _29;

layout(set = 0, binding = 4, std140) uniform _33_32
{
    _14 _m0;
} _32;

layout(set = 0, binding = 5, std140) uniform _36_35
{
    _16 _m0;
} _35;

layout(set = 0, binding = 6, std140) uniform _39_38
{
    _18 _m0;
} _38;

int _43(ivec4 _42)
{
    ivec4 _45 = ivec4(0);
    _45 = _42;
    return _45.x + _45.y;
}

void main()
{
    uint _136 = 0u;
    uint _130 = 0u;
    uint _124 = 0u;
    uint _118 = 0u;
    vec2 _111 = vec2(0.0);
    uvec4 _103 = uvec4(0u);
    uvec2 _95 = uvec2(0u);
    uint _134 = 0u;
    uint _128 = 0u;
    uint _122 = 0u;
    uint _115 = 0u;
    ivec2 _109 = ivec2(0);
    ivec4 _101 = ivec4(0);
    ivec2 _92 = ivec2(0);
    uint _132 = 0u;
    uint _126 = 0u;
    uint _120 = 0u;
    uvec4 _113 = uvec4(0u);
    vec4 _106 = vec4(0.0);
    vec2 _98 = vec2(0.0);
    _92 = _23._m0._m0;
    _95 = _26._m0._m0;
    _98 = _29._m0._m0;
    _101 = _32._m0._m0;
    _103 = _35._m0._m0;
    _106 = _38._m0._m0;
    uint _160 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_160 >= 4u)
    {
        return;
    }
    uint _166 = 4u + (_160 * 12u);
    _109 = _92;
    _111 = _98;
    _113 = _103;
    _92.x += int(_160);
    _92.y -= int(_160);
    _95.x += _160;
    _95.y += 2u;
    _98.x += float(_160);
    _98.y *= 2.0;
    _101 = ivec4(_101.x, _101.y, _101.z + int(_160), _43(_101));
    _103.x = _103.y + 1u;
    _103.w += _160;
    _20._m0[_166] = uint(_92.x + 10);
    _115 = _166 + 1u;
    _20._m0[_115] = uint(_92.y);
    _118 = _166 + 2u;
    _20._m0[_118] = _95.x + _95.y;
    _120 = _166 + 3u;
    _20._m0[_120] = floatBitsToUint(_98.x);
    _122 = _166 + 4u;
    _20._m0[_122] = floatBitsToUint(_98.y);
    _124 = _166 + 5u;
    _20._m0[_124] = uint(_101.z + 10);
    _126 = _166 + 6u;
    _20._m0[_126] = uint(_101.w);
    _128 = _166 + 7u;
    _20._m0[_128] = _103.x + _103.w;
    _130 = _166 + 8u;
    _20._m0[_130] = floatBitsToUint(((_106.x + _106.y) + _106.z) + _106.w);
    _132 = _166 + 9u;
    _20._m0[_132] = uint(_109.x + 10);
    _134 = _166 + 10u;
    _20._m0[_134] = floatBitsToUint(_111.x);
    _136 = _166 + 11u;
    _20._m0[_136] = _113.x + _113.w;
}

