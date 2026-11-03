#version 460
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    uint _m0;
    uint _m1;
};

layout(set = 0, binding = 0, std430) buffer _11_10
{
    uint _m0[];
} _10;

uint _15(uint _14)
{
    return _14 + 3u;
}

void main()
{
    uint _121 = 0u;
    uint _115 = 0u;
    uint _109 = 0u;
    uint _103 = 0u;
    uint _97 = 0u;
    uint _91 = 0u;
    uint _85 = 0u;
    uint _79 = 0u;
    uint _72 = 0u;
    _4 _63 = _4(0u, 0u);
    uint _123 = 0u;
    uint _117 = 0u;
    uint _111 = 0u;
    uint _105 = 0u;
    uint _99 = 0u;
    uint _93 = 0u;
    uint _87 = 0u;
    uint _81 = 0u;
    uint _75 = 0u;
    uint _66[3] = uint[](0u, 0u, 0u);
    uint _119 = 0u;
    uint _113 = 0u;
    uint _107 = 0u;
    uint _101 = 0u;
    uint _95 = 0u;
    uint _89 = 0u;
    uint _83 = 0u;
    uint _77 = 0u;
    uvec2 _69 = uvec2(0u);
    if (gl_LocalInvocationID.x >= 2u)
    {
        return;
    }
    uint _131 = gl_LocalInvocationID.x * 24u;
    _63._m0 = 11u;
    _63._m1 = 13u;
    _66[0u] = 2u;
    _66[1u] = 3u;
    _66[2u] = 5u;
    _69 = uvec2(17u, 19u);
    _72 = 0u;
    _10._m0[_131] = 7u;
    _75 = _131 + 1u;
    _10._m0[_75] = 11u;
    uint _142 = 2u + 3u;
    _77 = _131 + 2u;
    _10._m0[_77] = _142;
    uint _146 = 1u + 2u;
    _79 = _131 + 3u;
    _10._m0[_79] = _146 * 3u;
    uint _151 = 5u + 6u;
    _81 = _131 + 4u;
    _10._m0[_81] = _151;
    uint _155 = 7u + 8u;
    _83 = _131 + 5u;
    _10._m0[_83] = _155;
    _85 = _131 + 6u;
    _10._m0[_85] = _63._m0;
    _87 = _131 + 7u;
    _10._m0[_87] = _63._m1;
    _89 = _131 + 8u;
    _10._m0[_89] = uint(3);
    _91 = _131 + 9u;
    _10._m0[_91] = _66[gl_LocalInvocationID.x];
    _93 = _131 + 10u;
    _10._m0[_93] = _69.x;
    _95 = _131 + 11u;
    _10._m0[_95] = _69.y;
    _72++;
    uint _191 = _72;
    _72 = _191 + uint(1);
    _97 = _131 + 12u;
    _10._m0[_97] = _191;
    _99 = _131 + 13u;
    _10._m0[_99] = _72;
    _101 = _131 + 14u;
    _10._m0[_101] = 19u;
    _103 = _131 + 15u;
    _10._m0[_103] = _72;
    _66[0u] = 23u;
    _105 = _131 + 16u;
    _10._m0[_105] = _66[0u];
    _107 = _131 + 17u;
    _10._m0[_107] = _66[0u];
    if (gl_LocalInvocationID.x == 0u)
    {
        _111 = 29u;
    }
    else
    {
        _111 = 31u;
    }
    _109 = _131 + 18u;
    _10._m0[_109] = _111;
    _113 = _131 + 19u;
    _10._m0[_113] = _15(gl_LocalInvocationID.x);
    _115 = 37u;
    _117 = _131 + 20u;
    _10._m0[_117] = _115;
    float _235 = -0.0;
    _119 = _131 + 21u;
    _10._m0[_119] = floatBitsToUint(_235);
    _121 = _131 + 22u;
    _10._m0[_121] = 4294967295u;
    _123 = _131 + 23u;
    _10._m0[_123] = 41u + gl_LocalInvocationID.x;
}

