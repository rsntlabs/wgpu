#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _13_12
{
    int _m0[];
} _12;

layout(set = 0, binding = 1, std430) buffer _16_15
{
    uint _m0[];
} _15;

void main()
{
    uint _108 = 0u;
    uint _102 = 0u;
    uint _96 = 0u;
    uint _90 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    uint _66 = 0u;
    uint _60 = 0u;
    int _45 = 0;
    uint _110 = 0u;
    uint _104 = 0u;
    uint _98 = 0u;
    uint _92 = 0u;
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _62 = 0u;
    uint _56 = 0u;
    int _48[2][3] = int[][](int[](0, 0, 0), int[](0, 0, 0));
    uint _112 = 0u;
    uint _106 = 0u;
    uint _100 = 0u;
    uint _94 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _64 = 0u;
    uint _58 = 0u;
    uvec2 _132 = uvec2(4294967295u);
    uvec2 _152 = uvec2(4294967295u);
    uint _117 = 4u + (gl_LocalInvocationID.x * 16u);
    _45 = 7;
    uint _51 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _132)))
        {
            break;
        }
        _132 -= uvec2(uint(_132.y == 0u), 1u);
        if (_51 >= 2u)
        {
            break;
        }
        uint _54 = 0u;
        for (;;)
        {
            if (all(equal(uvec2(0u), _152)))
            {
                break;
            }
            _152 -= uvec2(uint(_152.y == 0u), 1u);
            if (_54 >= 3u)
            {
                break;
            }
            _48[_51][_54] = 0;
            _54++;
            continue;
        }
        _51++;
        continue;
    }
    _56 = 4u;
    _58 = 2u;
    _60 = 8u;
    _62 = 4u;
    _64 = 1u;
    _66 = 1u;
    _68 = 1u;
    _70 = 4u;
    _72 = 2u;
    _74 = 1u;
    _76 = 12u;
    _78 = 4u;
    _80 = 3u;
    _82 = 4u;
    _15._m0[_117] = _56;
    _84 = _117 + 1u;
    _15._m0[_84] = _58;
    _86 = _117 + 2u;
    _15._m0[_86] = _60;
    _88 = _117 + 3u;
    _15._m0[_88] = _62;
    _90 = _117 + 4u;
    _15._m0[_90] = _64;
    _92 = _117 + 5u;
    _15._m0[_92] = _66;
    _94 = _117 + 6u;
    _15._m0[_94] = _68;
    _96 = _117 + 7u;
    _15._m0[_96] = _70;
    _98 = _117 + 8u;
    _15._m0[_98] = _72;
    _100 = _117 + 9u;
    _15._m0[_100] = _74;
    _102 = _117 + 10u;
    _15._m0[_102] = _76;
    _104 = _117 + 11u;
    _15._m0[_104] = _78;
    _106 = _117 + 12u;
    _15._m0[_106] = _80;
    _108 = _117 + 13u;
    _15._m0[_108] = _82;
    _110 = _117 + 14u;
    _15._m0[_110] = uint(_45);
    _112 = _117 + 15u;
    _15._m0[_112] = uint(_12._m0[gl_LocalInvocationID.x]);
}

