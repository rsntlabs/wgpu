#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _9_8
{
    int _m0[];
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    uint _m0[];
} _11;

void main()
{
    uint _142 = 0u;
    uint _136 = 0u;
    uint _130 = 0u;
    uint _124 = 0u;
    uint _118 = 0u;
    int _112 = 0;
    int _106 = 0;
    uint _100 = 0u;
    uint _94 = 0u;
    int _88 = 0;
    uint _82 = 0u;
    uint _76 = 0u;
    int _70 = 0;
    uint _62 = 0u;
    uint _144 = 0u;
    uint _138 = 0u;
    uint _132 = 0u;
    uint _126 = 0u;
    uint _120 = 0u;
    uint _114 = 0u;
    uint _108 = 0u;
    int _96 = 0;
    uint _90 = 0u;
    int _84 = 0;
    uint _78 = 0u;
    uint _72 = 0u;
    int _65 = 0;
    uint _140 = 0u;
    uint _134 = 0u;
    uint _128 = 0u;
    uint _122 = 0u;
    uint _116 = 0u;
    uint _110 = 0u;
    int _104 = 0;
    uint _98 = 0u;
    uint _92 = 0u;
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    uvec2 _305 = uvec2(4294967295u);
    uint _149 = 4u + (gl_LocalInvocationID.x * 16u);
    int _152 = _8._m0[gl_LocalInvocationID.x];
    _62 = gl_LocalInvocationID.x + 4u;
    int _156 = _8._m0[_62];
    _65 = int(gl_LocalInvocationID.x) + 1;
    if (_152 > 0)
    {
        _65 += 10;
    }
    else
    {
        _65 += 20;
    }
    _11._m0[_149] = uint(_65);
    _65++;
    if (false)
    {
        _65 += 99;
    }
    else
    {
        _68 = _149 + 1u;
        _124 = _68;
        _11._m0[_124] = uint(_65);
    }
    _70 = 0;
    _70++;
    _65 += 2;
    if (_152 < _156)
    {
        _65 += 3;
    }
    else
    {
        _65 += 5;
    }
    _72 = _149 + 2u;
    _11._m0[_72] = uint(_70);
    _74 = _149 + 3u;
    _11._m0[_74] = uint(_65);
    if (_152 < _156)
    {
        _76 = _149 + 4u;
        _126 = _76;
        _11._m0[_126] = uint(_152 + 100);
    }
    else
    {
        _78 = _149 + 4u;
        _128 = _78;
        _11._m0[_128] = uint(_156 + 200);
    }
    if (true)
    {
        _80 = _149 + 5u;
        _130 = _80;
        _11._m0[_130] = uint(_152 + 300);
    }
    if (_65 > 0)
    {
        _65 += 7;
    }
    _82 = _149 + 6u;
    _11._m0[_82] = uint(_65);
    _84 = 50;
    if (_152 > 0)
    {
        _86 = _149 + 7u;
        _132 = _86;
        _11._m0[_132] = uint(_152 + 400);
    }
    else
    {
        _88 = _156;
        if (_88 > 0)
        {
            _90 = _149 + 7u;
            _134 = _90;
            _11._m0[_134] = uint(_88 + 500);
        }
        else
        {
            _92 = _149 + 7u;
            _136 = _92;
            _11._m0[_136] = uint(_88 + 600);
        }
    }
    _94 = _149 + 8u;
    _11._m0[_94] = uint(_84);
    if (true)
    {
        _96 = 9;
        _65 += _96;
        _98 = _149 + 9u;
        _138 = _98;
        _11._m0[_138] = uint(_152 + 20);
    }
    _100 = _149 + 10u;
    _11._m0[_100] = uint(_65);
    int _102 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _305)))
        {
            break;
        }
        _305 -= uvec2(uint(_305.y == 0u), 1u);
        if (!(_102 < 4))
        {
            break;
        }
        _104 = _102;
        if (_104 == 1)
        {
            int _334 = _102;
            _102 = _334 + 1;
            continue;
        }
        _106 = _102;
        if (_106 == 3)
        {
            break;
        }
        _65 += (_102 + 1);
        int _334 = _102;
        _102 = _334 + 1;
        continue;
    }
    _108 = _149 + 11u;
    _11._m0[_108] = uint(_65);
    _65++;
    if (true)
    {
        _110 = _149 + 12u;
        _140 = _110;
        _11._m0[_140] = uint(_65);
    }
    _112 = 0;
    int _351 = _112;
    _112 = _351 + 1;
    _114 = gl_LocalInvocationID.x + uint(_351);
    if (_8._m0[_114] > 0)
    {
        _116 = _149 + 13u;
        _142 = _116;
        _11._m0[_142] = uint(_112 + 100);
    }
    else
    {
        _118 = _149 + 13u;
        _144 = _118;
        _11._m0[_144] = uint(_112 + 200);
    }
    _120 = _149 + 14u;
    _11._m0[_120] = uint(_65);
    _122 = _149 + 15u;
    _11._m0[_122] = uint(_70);
}

