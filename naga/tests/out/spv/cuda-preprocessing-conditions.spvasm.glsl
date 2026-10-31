#version 460
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _7_6
{
    uint _m0[];
} _6;

uint _11(uint _10)
{
    return _10 + 73u;
}

void main()
{
    uint _112 = 0u;
    uint _106 = 0u;
    uint _100 = 0u;
    uint _94 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _110 = 0u;
    uint _104 = 0u;
    uint _98 = 0u;
    uint _92 = 0u;
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _67 = 0u;
    uint _114 = 0u;
    uint _108 = 0u;
    uint _102 = 0u;
    uint _96 = 0u;
    uint _90 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    if (gl_LocalInvocationID.x >= 2u)
    {
        return;
    }
    uint _121 = gl_LocalInvocationID.x * 24u;
    _6._m0[_121] = 7u;
    _67 = _121 + 1u;
    _6._m0[_67] = 11u;
    _70 = _121 + 2u;
    _6._m0[_70] = 13u;
    _72 = _121 + 3u;
    _6._m0[_72] = 17u;
    _74 = _121 + 4u;
    _6._m0[_74] = 19u;
    _76 = _121 + 5u;
    _6._m0[_76] = 23u;
    _78 = _121 + 6u;
    _6._m0[_78] = 29u;
    _80 = _121 + 7u;
    _6._m0[_80] = 31u;
    _82 = _121 + 8u;
    _6._m0[_82] = 37u;
    _84 = _121 + 9u;
    _6._m0[_84] = 41u;
    _86 = _121 + 10u;
    _6._m0[_86] = 43u;
    _88 = _121 + 11u;
    _6._m0[_88] = 47u;
    _90 = _121 + 12u;
    _6._m0[_90] = 53u;
    _92 = _121 + 13u;
    _6._m0[_92] = 59u;
    _94 = _121 + 14u;
    _6._m0[_94] = 61u;
    _96 = _121 + 15u;
    _6._m0[_96] = 67u;
    _98 = _121 + 16u;
    _6._m0[_98] = 71u;
    _100 = _121 + 17u;
    _6._m0[_100] = _11(gl_LocalInvocationID.x);
    _102 = 0u;
    uint _176 = _102;
    _102 = _176 + uint(1);
    _104 = _121 + 18u;
    _6._m0[_104] = _176;
    _106 = _121 + 19u;
    _6._m0[_106] = _102;
    _108 = _121 + 20u;
    _6._m0[_108] = uint(true);
    _110 = _121 + 21u;
    _6._m0[_110] = gl_LocalInvocationID.x;
    float _193 = -0.0;
    _112 = _121 + 22u;
    _6._m0[_112] = floatBitsToUint(_193);
    _114 = _121 + 23u;
    _6._m0[_114] = 4294967295u;
}

