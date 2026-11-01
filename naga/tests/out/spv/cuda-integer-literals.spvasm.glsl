#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _5
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _11_10
{
    uint _m0[];
} _10;

layout(set = 0, binding = 1, std430) readonly buffer _14_13
{
    uint _m0[];
} _13;

layout(set = 0, binding = 2, std140) uniform _17_16
{
    _5 _m0;
} _16;

shared uint _19[64];

void main()
{
    uint _150 = 0u;
    uint _144 = 0u;
    uint _138 = 0u;
    uint _132 = 0u;
    uint _126 = 0u;
    uint _120 = 0u;
    uint _114 = 0u;
    uint _108 = 0u;
    uint _102 = 0u;
    uint _96 = 0u;
    uint _90 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    uint _65 = 0u;
    uint _146 = 0u;
    uint _140 = 0u;
    uint _134 = 0u;
    uint _128 = 0u;
    uint _122 = 0u;
    uint _116 = 0u;
    uint _110 = 0u;
    uint _104 = 0u;
    uint _98 = 0u;
    uint _92 = 0u;
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _148 = 0u;
    uint _142 = 0u;
    uint _136 = 0u;
    uint _130 = 0u;
    uint _124 = 0u;
    uint _118 = 0u;
    uint _112 = 0u;
    uint _106 = 0u;
    uint _100 = 0u;
    uint _94 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _19 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    }
    barrier();
    uint _169 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_169 < _16._m0._m0)
    {
        _68 = _169;
        _112 = _68;
        _114 = _13._m0[_112];
        _110 = _114;
        _65 = _110;
        _70 = _65 & 3u;
        _72 = _169 * 18u;
        _19[gl_LocalInvocationID.x] = _65 ^ uint(255);
        _74 = _72;
        _116 = _74;
        _10._m0[_116] = _19[gl_LocalInvocationID.x];
        _76 = _72 + 1u;
        _118 = _76;
        _10._m0[_118] = _65 & uint(255);
        _78 = _72 + 2u;
        _120 = _78;
        _10._m0[_120] = _65 & 240u;
        _80 = _72 + 3u;
        _122 = _80;
        _10._m0[_122] = _65 + 1000u;
        _82 = _72 + 4u;
        _124 = _82;
        _10._m0[_124] = 2147483648u >> _70;
        _84 = _72 + 5u;
        _126 = _84;
        _10._m0[_126] = uint(int(2147483648u) >> int(_70));
        _86 = _72 + 6u;
        _128 = _86;
        _10._m0[_128] = 4294967295u ^ _65;
        _88 = _72 + 7u;
        _130 = _88;
        _10._m0[_130] = uint(_65 < 2147483648u);
        _90 = _72 + 8u;
        _132 = _90;
        _10._m0[_132] = uint(int(_65) < 2147483647);
        _92 = _72 + 9u;
        _134 = _92;
        _10._m0[_134] = 2147483648u >> _70;
        _94 = _72 + 10u;
        _136 = _94;
        _10._m0[_136] = 255u + _65;
        _96 = _72 + 11u;
        _138 = _96;
        _10._m0[_138] = ((_65 + 10u) + 8u) + 10u;
        _98 = _72 + 12u;
        _140 = _98;
        _10._m0[_140] = _65 + uint(15);
        _100 = _72 + 13u;
        _142 = _100;
        _10._m0[_142] = 4294967295u - _65;
        _102 = _72 + 14u;
        _144 = _102;
        _10._m0[_144] = 3735928559u ^ _65;
        int _303 = ~2147483647;
        _104 = _72 + 15u;
        _146 = _104;
        _10._m0[_146] = uint(_303 < int(_65));
        _106 = _72 + 16u;
        _148 = _106;
        _10._m0[_148] = (_65 + uint(30)) + uint(2);
        _108 = _72 + 17u;
        _150 = _108;
        _10._m0[_150] = (_65 + uint(30)) - uint(2);
    }
}

