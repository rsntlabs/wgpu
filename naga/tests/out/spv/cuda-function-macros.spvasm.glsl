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
    uvec2 _71 = uvec2(0u);
    _4 _63 = _4(0u, 0u);
    uint _123 = 0u;
    uint _117 = 0u;
    uint _111 = 0u;
    uint _105 = 0u;
    uint _99 = 0u;
    uint _93 = 0u;
    uint _87 = 0u;
    uint _81 = 0u;
    uint _74 = 0u;
    _4 _66 = _4(0u, 0u);
    uint _125 = 0u;
    uint _119 = 0u;
    uint _113 = 0u;
    uint _107 = 0u;
    uint _101 = 0u;
    uint _95 = 0u;
    uint _89 = 0u;
    uint _83 = 0u;
    uint _77 = 0u;
    uint _68[3] = uint[](0u, 0u, 0u);
    if (gl_LocalInvocationID.x >= 2u)
    {
        return;
    }
    uint _133 = gl_LocalInvocationID.x * 24u;
    _66._m0 = 11u;
    _66._m1 = 13u;
    _63 = _66;
    _68[0u] = 2u;
    _68[1u] = 3u;
    _68[2u] = 5u;
    _71 = uvec2(17u, 19u);
    _74 = 0u;
    _10._m0[_133] = 7u;
    _77 = _133 + 1u;
    _10._m0[_77] = 11u;
    uint _145 = 2u + 3u;
    _79 = _133 + 2u;
    _10._m0[_79] = _145;
    uint _149 = 1u + 2u;
    _81 = _133 + 3u;
    _10._m0[_81] = _149 * 3u;
    uint _154 = 5u + 6u;
    _83 = _133 + 4u;
    _10._m0[_83] = _154;
    uint _158 = 7u + 8u;
    _85 = _133 + 5u;
    _10._m0[_85] = _158;
    _87 = _133 + 6u;
    _10._m0[_87] = _63._m0;
    _89 = _133 + 7u;
    _10._m0[_89] = _63._m1;
    _91 = _133 + 8u;
    _10._m0[_91] = uint(3);
    _93 = _133 + 9u;
    _10._m0[_93] = _68[gl_LocalInvocationID.x];
    _95 = _133 + 10u;
    _10._m0[_95] = _71.x;
    _97 = _133 + 11u;
    _10._m0[_97] = _71.y;
    _74++;
    uint _194 = _74;
    _74 = _194 + uint(1);
    _99 = _133 + 12u;
    _10._m0[_99] = _194;
    _101 = _133 + 13u;
    _10._m0[_101] = _74;
    _103 = _133 + 14u;
    _10._m0[_103] = 19u;
    _105 = _133 + 15u;
    _10._m0[_105] = _74;
    _68[0u] = 23u;
    _107 = _133 + 16u;
    _10._m0[_107] = _68[0u];
    _109 = _133 + 17u;
    _10._m0[_109] = _68[0u];
    if (gl_LocalInvocationID.x == 0u)
    {
        _113 = 29u;
    }
    else
    {
        _113 = 31u;
    }
    _111 = _133 + 18u;
    _10._m0[_111] = _113;
    _115 = _133 + 19u;
    _10._m0[_115] = _15(gl_LocalInvocationID.x);
    _117 = 37u;
    _119 = _133 + 20u;
    _10._m0[_119] = _117;
    float _238 = -0.0;
    _121 = _133 + 21u;
    _10._m0[_121] = floatBitsToUint(_238);
    _123 = _133 + 22u;
    _10._m0[_123] = 4294967295u;
    _125 = _133 + 23u;
    _10._m0[_125] = 41u + gl_LocalInvocationID.x;
}

