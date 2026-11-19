#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    int _m0;
    uint _m1;
    float _m2;
};

layout(set = 0, binding = 0, std430) readonly buffer _15_14
{
    int _m0[];
} _14;

layout(set = 0, binding = 1, std430) buffer _18_17
{
    uint _m0[];
} _17;

void main()
{
    uint _120 = 0u;
    uint _114 = 0u;
    uint _108 = 0u;
    uint _102 = 0u;
    uint _96 = 0u;
    uint _90 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    uint _66 = 0u;
    int _50 = 0;
    uint _116 = 0u;
    uint _110 = 0u;
    uint _104 = 0u;
    uint _98 = 0u;
    uint _92 = 0u;
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    _6 _61 = _6(0, 0u, 0.0);
    int _53[2][3] = int[][](int[](0, 0, 0), int[](0, 0, 0));
    uint _118 = 0u;
    uint _112 = 0u;
    uint _106 = 0u;
    uint _100 = 0u;
    uint _94 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _64 = 0u;
    uvec2 _141 = uvec2(4294967295u);
    uvec2 _161 = uvec2(4294967295u);
    uint _125 = 4u + (gl_LocalInvocationID.x * 16u);
    _50 = 7;
    uint _56 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _141)))
        {
            break;
        }
        _141 -= uvec2(uint(_141.y == 0u), 1u);
        if (_56 >= 2u)
        {
            break;
        }
        uint _59 = 0u;
        for (;;)
        {
            if (all(equal(uvec2(0u), _161)))
            {
                break;
            }
            _161 -= uvec2(uint(_161.y == 0u), 1u);
            if (_59 >= 3u)
            {
                break;
            }
            _53[_56][_59] = 0;
            _59++;
            continue;
        }
        _56++;
        continue;
    }
    _61 = _6(0, 0u, 0.0);
    _64 = 4u;
    _66 = 1u;
    _68 = 24u;
    _70 = 12u;
    _72 = 4u;
    _74 = 4u;
    _76 = 8u;
    _78 = 8u;
    _80 = 1u;
    _82 = 1u;
    _84 = 1u;
    _86 = 4u;
    _88 = 1u;
    _90 = 8u;
    _17._m0[_125] = _64;
    _92 = _125 + 1u;
    _17._m0[_92] = _66;
    _94 = _125 + 2u;
    _17._m0[_94] = _68;
    _96 = _125 + 3u;
    _17._m0[_96] = _70;
    _98 = _125 + 4u;
    _17._m0[_98] = _72;
    _100 = _125 + 5u;
    _17._m0[_100] = _74;
    _102 = _125 + 6u;
    _17._m0[_102] = _76;
    _104 = _125 + 7u;
    _17._m0[_104] = _78;
    _106 = _125 + 8u;
    _17._m0[_106] = _80;
    _108 = _125 + 9u;
    _17._m0[_108] = _82;
    _110 = _125 + 10u;
    _17._m0[_110] = _84;
    _112 = _125 + 11u;
    _17._m0[_112] = _86;
    _114 = _125 + 12u;
    _17._m0[_114] = _88;
    _116 = _125 + 13u;
    _17._m0[_116] = _90;
    _118 = _125 + 14u;
    _17._m0[_118] = uint(_50);
    _120 = _125 + 15u;
    _17._m0[_120] = uint(_14._m0[gl_LocalInvocationID.x]);
}

