#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _14_13
{
    int _m0[];
} _13;

layout(set = 0, binding = 1, std430) buffer _17_16
{
    uint _m0[];
} _16;

void main()
{
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
    int _59 = 0;
    int _51 = 0;
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
    int _61[2][3] = int[][](int[](0, 0, 0), int[](0, 0, 0));
    int _54 = 0;
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
    bool _56 = false;
    uvec2 _161 = uvec2(4294967295u);
    uvec2 _181 = uvec2(4294967295u);
    uint _146 = 4u + (gl_LocalInvocationID.x * 20u);
    int _149 = _13._m0[gl_LocalInvocationID.x];
    _59 = 7;
    uint _64 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _161)))
        {
            break;
        }
        _161 -= uvec2(uint(_161.y == 0u), 1u);
        if (_64 >= 2u)
        {
            break;
        }
        uint _67 = 0u;
        for (;;)
        {
            if (all(equal(uvec2(0u), _181)))
            {
                break;
            }
            _181 -= uvec2(uint(_181.y == 0u), 1u);
            if (_67 >= 3u)
            {
                break;
            }
            _61[_64][_67] = 0;
            _67++;
            continue;
        }
        _64++;
        continue;
    }
    _69 = 4u;
    _71 = 1u;
    _73 = 4u;
    _75 = 4u;
    _77 = 4u;
    _79 = 4u;
    _81 = 4u;
    _83 = 4u;
    _85 = 4u;
    _87 = 12u;
    _89 = 4u;
    _91 = 4u;
    _93 = 4u;
    _95 = 4u;
    _97 = 4u;
    _99 = 7u;
    _103 = 5u;
    _16._m0[_146] = _69;
    _105 = _146 + 1u;
    _16._m0[_105] = _71;
    _107 = _146 + 2u;
    _16._m0[_107] = _73;
    _109 = _146 + 3u;
    _16._m0[_109] = _75;
    _111 = _146 + 4u;
    _16._m0[_111] = _77;
    _113 = _146 + 5u;
    _16._m0[_113] = _79;
    _115 = _146 + 6u;
    _16._m0[_115] = _81;
    _117 = _146 + 7u;
    _16._m0[_117] = _83;
    _119 = _146 + 8u;
    _16._m0[_119] = _85;
    _121 = _146 + 9u;
    _16._m0[_121] = _87;
    _123 = _146 + 10u;
    _16._m0[_123] = _89;
    _125 = _146 + 11u;
    _16._m0[_125] = _91;
    _127 = _146 + 12u;
    _16._m0[_127] = _93;
    _129 = _146 + 13u;
    _16._m0[_129] = _95;
    _131 = _146 + 14u;
    _16._m0[_131] = _97;
    _133 = _146 + 15u;
    _16._m0[_133] = _99;
    _135 = _146 + 16u;
    _16._m0[_135] = _103;
    _137 = _146 + 17u;
    _16._m0[_137] = uint(_59);
    _139 = _146 + 18u;
    _16._m0[_139] = uint(_149);
    _141 = _146 + 19u;
    _16._m0[_141] = uint(_149 != 0);
}

