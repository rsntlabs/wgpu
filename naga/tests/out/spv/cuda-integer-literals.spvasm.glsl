#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _5
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _10_9
{
    uint _m0[];
} _9;

layout(set = 0, binding = 1, std430) readonly buffer _13_12
{
    uint _m0[];
} _12;

layout(set = 0, binding = 2, std140) uniform _16_15
{
    _5 _m0;
} _15;

shared uint _18[64];

void main()
{
    uint _149 = 0u;
    uint _143 = 0u;
    uint _137 = 0u;
    uint _131 = 0u;
    uint _125 = 0u;
    uint _119 = 0u;
    uint _113 = 0u;
    uint _107 = 0u;
    uint _101 = 0u;
    uint _95 = 0u;
    uint _89 = 0u;
    uint _83 = 0u;
    uint _77 = 0u;
    uint _71 = 0u;
    uint _64 = 0u;
    uint _145 = 0u;
    uint _139 = 0u;
    uint _133 = 0u;
    uint _127 = 0u;
    uint _121 = 0u;
    uint _115 = 0u;
    uint _109 = 0u;
    uint _103 = 0u;
    uint _97 = 0u;
    uint _91 = 0u;
    uint _85 = 0u;
    uint _79 = 0u;
    uint _73 = 0u;
    uint _67 = 0u;
    uint _147 = 0u;
    uint _141 = 0u;
    uint _135 = 0u;
    uint _129 = 0u;
    uint _123 = 0u;
    uint _117 = 0u;
    uint _111 = 0u;
    uint _105 = 0u;
    uint _99 = 0u;
    uint _93 = 0u;
    uint _87 = 0u;
    uint _81 = 0u;
    uint _75 = 0u;
    uint _69 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _18 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    }
    barrier();
    uint _168 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_168 < _15._m0._m0)
    {
        _67 = _168;
        _111 = _67;
        _113 = _12._m0[_111];
        _109 = _113;
        _64 = _109;
        _69 = _64 & 3u;
        _71 = _168 * 18u;
        _18[gl_LocalInvocationID.x] = _64 ^ uint(255);
        _73 = _71;
        _115 = _73;
        _9._m0[_115] = _18[gl_LocalInvocationID.x];
        _75 = _71 + 1u;
        _117 = _75;
        _9._m0[_117] = _64 & uint(255);
        _77 = _71 + 2u;
        _119 = _77;
        _9._m0[_119] = _64 & 240u;
        _79 = _71 + 3u;
        _121 = _79;
        _9._m0[_121] = _64 + 1000u;
        _81 = _71 + 4u;
        _123 = _81;
        _9._m0[_123] = 2147483648u >> _69;
        _83 = _71 + 5u;
        _125 = _83;
        _9._m0[_125] = uint(int(2147483648u) >> int(_69));
        _85 = _71 + 6u;
        _127 = _85;
        _9._m0[_127] = 4294967295u ^ _64;
        _87 = _71 + 7u;
        _129 = _87;
        _9._m0[_129] = uint(_64 < 2147483648u);
        _89 = _71 + 8u;
        _131 = _89;
        _9._m0[_131] = uint(int(_64) < 2147483647);
        _91 = _71 + 9u;
        _133 = _91;
        _9._m0[_133] = 2147483648u >> _69;
        _93 = _71 + 10u;
        _135 = _93;
        _9._m0[_135] = 255u + _64;
        _95 = _71 + 11u;
        _137 = _95;
        _9._m0[_137] = ((_64 + 10u) + 8u) + 10u;
        _97 = _71 + 12u;
        _139 = _97;
        _9._m0[_139] = _64 + uint(15);
        _99 = _71 + 13u;
        _141 = _99;
        _9._m0[_141] = 4294967295u - _64;
        _101 = _71 + 14u;
        _143 = _101;
        _9._m0[_143] = 3735928559u ^ _64;
        int _302 = ~2147483647;
        _103 = _71 + 15u;
        _145 = _103;
        _9._m0[_145] = uint(_302 < int(_64));
        _105 = _71 + 16u;
        _147 = _105;
        _9._m0[_147] = (_64 + uint(30)) + uint(2);
        _107 = _71 + 17u;
        _149 = _107;
        _9._m0[_149] = (_64 + uint(30)) - uint(2);
    }
}

