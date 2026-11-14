#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

layout(set = 0, binding = 1, std430) readonly buffer _12_11
{
    uint _m0[];
} _11;

void main()
{
    uint _155 = 0u;
    uint _149 = 0u;
    uint _143 = 0u;
    uint _137 = 0u;
    uint _131 = 0u;
    uint _125 = 0u;
    uint _119 = 0u;
    uint _113 = 0u;
    uint _107 = 0u;
    uint _101 = 0u;
    bool _95 = false;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _64 = 0u;
    uint _58 = 0u;
    uint _157 = 0u;
    uint _151 = 0u;
    uint _145 = 0u;
    uint _139 = 0u;
    uint _133 = 0u;
    uint _127 = 0u;
    uint _121 = 0u;
    uint _115 = 0u;
    uint _109 = 0u;
    uint _103 = 0u;
    uint _97 = 0u;
    uint _90 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    uint _66 = 0u;
    uint _60 = 0u;
    uint _54 = 0u;
    uint _153 = 0u;
    uint _147 = 0u;
    uint _141 = 0u;
    uint _135 = 0u;
    uint _129 = 0u;
    uint _123 = 0u;
    uint _117 = 0u;
    uint _111 = 0u;
    uint _105 = 0u;
    uint _99 = 0u;
    bool _92 = false;
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _62 = 0u;
    uint _56 = 0u;
    uvec2 _176 = uvec2(4294967295u);
    uint _161 = uint(0);
    uint _164 = _11._m0[_161];
    uint _51 = gl_LocalInvocationID.x;
    for (;;)
    {
        if (all(equal(uvec2(0u), _176)))
        {
            break;
        }
        _176 -= uvec2(uint(_176.y == 0u), 1u);
        if (!(_51 < _164))
        {
            break;
        }
        _54 = 1u + (_51 * 3u);
        _58 = _54;
        _143 = _58;
        _145 = _11._m0[_143];
        _113 = _145;
        _56 = _113;
        _62 = _54 + 1u;
        _147 = _62;
        _149 = _11._m0[_147];
        _115 = _149;
        _60 = _115;
        _66 = _54 + 2u;
        _151 = _66;
        _153 = _11._m0[_151];
        _117 = _153;
        _64 = _117;
        int _226 = int(uint(int(_56)));
        int _227 = int(uint(int(_60)));
        uint _245 = uint((((0 + (bitfieldExtract(_226, int(0u), int(8u)) * bitfieldExtract(_227, int(0u), int(8u)))) + (bitfieldExtract(_226, int(8u), int(8u)) * bitfieldExtract(_227, int(8u), int(8u)))) + (bitfieldExtract(_226, int(16u), int(8u)) * bitfieldExtract(_227, int(16u), int(8u)))) + (bitfieldExtract(_226, int(24u), int(8u)) * bitfieldExtract(_227, int(24u), int(8u))));
        uint _246 = uint(int(_64));
        uint _249 = (_245 & 65535u) + (_246 & 65535u);
        _68 = 4u + (_51 * 2u);
        _155 = _68;
        _8._m0[_155] = uint(int((((((_245 >> 16u) + (_246 >> 16u)) + (_249 >> 16u)) & 65535u) << 16u) | (_249 & 65535u)));
        uint _270 = (((0u + (bitfieldExtract(_56, int(0u), int(8u)) * bitfieldExtract(_60, int(0u), int(8u)))) + (bitfieldExtract(_56, int(8u), int(8u)) * bitfieldExtract(_60, int(8u), int(8u)))) + (bitfieldExtract(_56, int(16u), int(8u)) * bitfieldExtract(_60, int(16u), int(8u)))) + (bitfieldExtract(_56, int(24u), int(8u)) * bitfieldExtract(_60, int(24u), int(8u)));
        uint _288 = (_270 & 65535u) + (_64 & 65535u);
        _70 = 5u + (_51 * 2u);
        _157 = _70;
        _8._m0[_157] = (((((_270 >> 16u) + (_64 >> 16u)) + (_288 >> 16u)) & 65535u) << 16u) | (_288 & 65535u);
        _51 += 4u;
        continue;
    }
    uint _309 = (4u + (_164 * 2u)) + (gl_LocalInvocationID.x * 10u);
    _72 = 1u;
    _119 = 0u;
    _121 = 0u;
    _119 = 16909060u;
    _121 = 2164195711u;
    uint _310 = _72;
    _72 = _310 + uint(1);
    _74 = (_310 * _119) ^ _121;
    _123 = 0u;
    _125 = 0u;
    _123 = 50661129u;
    _125 = 4261576960u;
    uint _318 = _72;
    _72 = _318 + uint(1);
    _76 = (_318 * _123) ^ _125;
    _127 = 0u;
    _129 = 0u;
    _127 = 17u;
    _129 = 0u;
    uint _326 = _72;
    _72 = _326 + uint(1);
    _78 = (_326 * _127) ^ _129;
    uint _336 = uint(-int(_78));
    uint _337 = (((0u + (bitfieldExtract(_74, int(0u), int(8u)) * bitfieldExtract(_76, int(0u), int(8u)))) + (bitfieldExtract(_74, int(8u), int(8u)) * bitfieldExtract(_76, int(8u), int(8u)))) + (bitfieldExtract(_74, int(16u), int(8u)) * bitfieldExtract(_76, int(16u), int(8u)))) + (bitfieldExtract(_74, int(24u), int(8u)) * bitfieldExtract(_76, int(24u), int(8u)));
    uint _355 = (_337 & 65535u) + (_336 & 65535u);
    _8._m0[_309] = (((((_337 >> 16u) + (_336 >> 16u)) + (_355 >> 16u)) & 65535u) << 16u) | (_355 & 65535u);
    _131 = 0u;
    _133 = 0u;
    _131 = 16909060u;
    _133 = 2164195711u;
    uint _366 = _72;
    _72 = _366 + uint(1);
    _82 = (_366 * _131) ^ _133;
    _135 = 0u;
    _137 = 0u;
    _135 = 50661129u;
    _137 = 4261576960u;
    uint _375 = _72;
    _72 = _375 + uint(1);
    _84 = (_375 * _135) ^ _137;
    _139 = 0u;
    _141 = 0u;
    _139 = 17u;
    _141 = 0u;
    uint _384 = _72;
    _72 = _384 + uint(1);
    _86 = (_384 * _139) ^ _141;
    int _397 = int(uint(int(_82)));
    int _398 = int(uint(int(_84)));
    uint _414 = uint((((0 + (bitfieldExtract(_397, int(0u), int(8u)) * bitfieldExtract(_398, int(0u), int(8u)))) + (bitfieldExtract(_397, int(8u), int(8u)) * bitfieldExtract(_398, int(8u), int(8u)))) + (bitfieldExtract(_397, int(16u), int(8u)) * bitfieldExtract(_398, int(16u), int(8u)))) + (bitfieldExtract(_397, int(24u), int(8u)) * bitfieldExtract(_398, int(24u), int(8u))));
    uint _415 = uint(-int(_86));
    uint _418 = (_414 & 65535u) + (_415 & 65535u);
    _80 = _309 + 1u;
    _8._m0[_80] = uint(int((((((_414 >> 16u) + (_415 >> 16u)) + (_418 >> 16u)) & 65535u) << 16u) | (_418 & 65535u)));
    if ((gl_LocalInvocationID.x & 1u) == 0u)
    {
        uint _438 = _72;
        _72 = _438 + uint(1);
        uint _441 = _72;
        _72 = _441 + uint(1);
        uint _444 = _72;
        _72 = _444 + uint(1);
        uint _447 = (((0u + (bitfieldExtract(_438, int(0u), int(8u)) * bitfieldExtract(_441, int(0u), int(8u)))) + (bitfieldExtract(_438, int(8u), int(8u)) * bitfieldExtract(_441, int(8u), int(8u)))) + (bitfieldExtract(_438, int(16u), int(8u)) * bitfieldExtract(_441, int(16u), int(8u)))) + (bitfieldExtract(_438, int(24u), int(8u)) * bitfieldExtract(_441, int(24u), int(8u)));
        uint _465 = (_447 & 65535u) + (_444 & 65535u);
        _88 = (((((_447 >> 16u) + (_444 >> 16u)) + (_465 >> 16u)) & 65535u) << 16u) | (_465 & 65535u);
    }
    else
    {
        _88 = 0u;
    }
    _90 = _309 + 2u;
    _8._m0[_90] = _72;
    _92 = false;
    if (false)
    {
        uint _481 = _72;
        _72 = _481 + uint(1);
        uint _484 = _72;
        _72 = _484 + uint(1);
        uint _487 = _72;
        _72 = _487 + uint(1);
        uint _490 = (((0u + (bitfieldExtract(_481, int(0u), int(8u)) * bitfieldExtract(_484, int(0u), int(8u)))) + (bitfieldExtract(_481, int(8u), int(8u)) * bitfieldExtract(_484, int(8u), int(8u)))) + (bitfieldExtract(_481, int(16u), int(8u)) * bitfieldExtract(_484, int(16u), int(8u)))) + (bitfieldExtract(_481, int(24u), int(8u)) * bitfieldExtract(_484, int(24u), int(8u)));
        uint _508 = (_490 & 65535u) + (_487 & 65535u);
        _92 = ((((((_490 >> 16u) + (_487 >> 16u)) + (_508 >> 16u)) & 65535u) << 16u) | (_508 & 65535u)) != 0u;
    }
    _95 = true;
    if (!true)
    {
        uint _521 = _72;
        _72 = _521 + uint(1);
        uint _524 = _72;
        _72 = _524 + uint(1);
        uint _527 = _72;
        _72 = _527 + uint(1);
        uint _530 = (((0u + (bitfieldExtract(_521, int(0u), int(8u)) * bitfieldExtract(_524, int(0u), int(8u)))) + (bitfieldExtract(_521, int(8u), int(8u)) * bitfieldExtract(_524, int(8u), int(8u)))) + (bitfieldExtract(_521, int(16u), int(8u)) * bitfieldExtract(_524, int(16u), int(8u)))) + (bitfieldExtract(_521, int(24u), int(8u)) * bitfieldExtract(_524, int(24u), int(8u)));
        uint _548 = (_530 & 65535u) + (_527 & 65535u);
        _95 = ((((((_530 >> 16u) + (_527 >> 16u)) + (_548 >> 16u)) & 65535u) << 16u) | (_548 & 65535u)) != 0u;
    }
    _72++;
    _72++;
    _72++;
    _97 = _309 + 3u;
    _8._m0[_97] = _72;
    _99 = 1u;
    uint _572 = _99;
    _99 = _572 + uint(1);
    uint _577 = _99;
    _99 = _577 + uint(1);
    uint _582 = _99;
    _99 = _582 + uint(1);
    uint _587 = (((0u + (bitfieldExtract(_11._m0[_572], int(0u), int(8u)) * bitfieldExtract(_11._m0[_577], int(0u), int(8u)))) + (bitfieldExtract(_11._m0[_572], int(8u), int(8u)) * bitfieldExtract(_11._m0[_577], int(8u), int(8u)))) + (bitfieldExtract(_11._m0[_572], int(16u), int(8u)) * bitfieldExtract(_11._m0[_577], int(16u), int(8u)))) + (bitfieldExtract(_11._m0[_572], int(24u), int(8u)) * bitfieldExtract(_11._m0[_577], int(24u), int(8u)));
    uint _605 = (_587 & 65535u) + (_11._m0[_582] & 65535u);
    _101 = _309 + 4u;
    _8._m0[_101] = (((((_587 >> 16u) + (_11._m0[_582] >> 16u)) + (_605 >> 16u)) & 65535u) << 16u) | (_605 & 65535u);
    _103 = _309 + 5u;
    _8._m0[_103] = _99;
    uint _622 = (((0u + (bitfieldExtract(4294967295u, int(0u), int(8u)) * bitfieldExtract(4294967295u, int(0u), int(8u)))) + (bitfieldExtract(4294967295u, int(8u), int(8u)) * bitfieldExtract(4294967295u, int(8u), int(8u)))) + (bitfieldExtract(4294967295u, int(16u), int(8u)) * bitfieldExtract(4294967295u, int(16u), int(8u)))) + (bitfieldExtract(4294967295u, int(24u), int(8u)) * bitfieldExtract(4294967295u, int(24u), int(8u)));
    uint _640 = (_622 & 65535u) + (4294967295u & 65535u);
    _105 = _309 + 6u;
    _8._m0[_105] = (((((_622 >> 16u) + (4294967295u >> 16u)) + (_640 >> 16u)) & 65535u) << 16u) | (_640 & 65535u);
    int _658 = int(uint(int(2155905152u)));
    int _659 = int(uint(int(2155905152u)));
    uint _675 = uint((((0 + (bitfieldExtract(_658, int(0u), int(8u)) * bitfieldExtract(_659, int(0u), int(8u)))) + (bitfieldExtract(_658, int(8u), int(8u)) * bitfieldExtract(_659, int(8u), int(8u)))) + (bitfieldExtract(_658, int(16u), int(8u)) * bitfieldExtract(_659, int(16u), int(8u)))) + (bitfieldExtract(_658, int(24u), int(8u)) * bitfieldExtract(_659, int(24u), int(8u))));
    uint _676 = uint(2147483647);
    uint _679 = (_675 & 65535u) + (_676 & 65535u);
    _107 = _309 + 7u;
    _8._m0[_107] = uint(int((((((_675 >> 16u) + (_676 >> 16u)) + (_679 >> 16u)) & 65535u) << 16u) | (_679 & 65535u)));
    int _696 = -2147483647;
    int _701 = int(uint(int(2155905152u)));
    int _702 = int(uint(int(2139062143u)));
    uint _718 = uint((((0 + (bitfieldExtract(_701, int(0u), int(8u)) * bitfieldExtract(_702, int(0u), int(8u)))) + (bitfieldExtract(_701, int(8u), int(8u)) * bitfieldExtract(_702, int(8u), int(8u)))) + (bitfieldExtract(_701, int(16u), int(8u)) * bitfieldExtract(_702, int(16u), int(8u)))) + (bitfieldExtract(_701, int(24u), int(8u)) * bitfieldExtract(_702, int(24u), int(8u))));
    uint _719 = uint(_696 - 1);
    uint _722 = (_718 & 65535u) + (_719 & 65535u);
    _109 = _309 + 8u;
    _8._m0[_109] = uint(int((((((_718 >> 16u) + (_719 >> 16u)) + (_722 >> 16u)) & 65535u) << 16u) | (_722 & 65535u)));
    uint _737 = (((0u + (bitfieldExtract(16843009u, int(0u), int(8u)) * bitfieldExtract(16843009u, int(0u), int(8u)))) + (bitfieldExtract(16843009u, int(8u), int(8u)) * bitfieldExtract(16843009u, int(8u), int(8u)))) + (bitfieldExtract(16843009u, int(16u), int(8u)) * bitfieldExtract(16843009u, int(16u), int(8u)))) + (bitfieldExtract(16843009u, int(24u), int(8u)) * bitfieldExtract(16843009u, int(24u), int(8u)));
    uint _755 = (_737 & 65535u) + (65535u & 65535u);
    _111 = _309 + 9u;
    _8._m0[_111] = (((((_737 >> 16u) + (65535u >> 16u)) + (_755 >> 16u)) & 65535u) << 16u) | (_755 & 65535u);
}

