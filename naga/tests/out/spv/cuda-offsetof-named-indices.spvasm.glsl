#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _11_10
{
    uint _m0[];
} _10;

uint _14()
{
    uint _17 = 0u;
    _17 = 16u;
    return _17;
}

uint _23()
{
    uint _25 = 0u;
    _25 = 32u;
    return _25;
}

void main()
{
    uint _94 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    bool _63 = false;
    uint _57 = 0u;
    uint _92 = 0u;
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _61 = 0u;
    int _54 = 0;
    uint _90 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    uint _66 = 0u;
    int _59 = 0;
    uint _99 = 4u + (gl_LocalInvocationID.x * 10u);
    _54 = 7;
    _57 = 1u;
    _59 = 1;
    _61 = 0u;
    _63 = true;
    _66 = 56u;
    _68 = 52u;
    _70 = 28u;
    _72 = 8u;
    _74 = 48u;
    _76 = 56u;
    _10._m0[_99] = _66;
    _78 = _99 + 1u;
    _10._m0[_78] = _68;
    _80 = _99 + 2u;
    _10._m0[_80] = _70;
    _82 = _99 + 3u;
    _10._m0[_82] = _72;
    _84 = _99 + 4u;
    _10._m0[_84] = _74;
    _86 = _99 + 5u;
    _10._m0[_86] = _76;
    _88 = _99 + 6u;
    _10._m0[_88] = _14();
    _90 = _99 + 7u;
    _10._m0[_90] = _23();
    _92 = _99 + 8u;
    _10._m0[_92] = uint(_54);
    _94 = _99 + 9u;
    _10._m0[_94] = gl_LocalInvocationID.x;
}

