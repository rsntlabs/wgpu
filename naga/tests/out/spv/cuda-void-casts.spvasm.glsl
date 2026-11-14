#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _10_9
{
    int _m0[];
} _9;

layout(set = 0, binding = 1, std430) readonly buffer _13_12
{
    int _m0[];
} _12;

void main()
{
    int _86 = 0;
    int _80 = 0;
    int _74 = 0;
    int _67 = 0;
    uint _61 = 0u;
    uint _55 = 0u;
    uint _49 = 0u;
    int _42 = 0;
    int _90 = 0;
    int _84 = 0;
    int _78 = 0;
    uint _72 = 0u;
    uint _65 = 0u;
    uint _59 = 0u;
    uint _53 = 0u;
    uint _46 = 0u;
    int _39 = 0;
    int _88 = 0;
    int _82 = 0;
    int _76 = 0;
    int _69[3] = int[](0, 0, 0);
    uint _57 = 0u;
    int _51 = 0;
    int _44 = 0;
    uvec2 _174 = uvec2(4294967295u);
    uint _95 = 4u + (gl_LocalInvocationID.x * 8u);
    _39 = int(gl_LocalInvocationID.x) + 1;
    _39++;
    _39++;
    _39++;
    _9._m0[_95] = _39;
    if ((gl_LocalInvocationID.x & 1u) == 0u)
    {
        _74 = 0;
        _76 = 0;
        _74 = 3;
        _78 = _39;
        _76 = _78;
        _80 = _39;
        _39 = _80 + _74;
        _42 = _76;
    }
    else
    {
        _82 = 0;
        _84 = 0;
        _82 = 7;
        _86 = _39;
        _84 = _86;
        _88 = _39;
        _39 = _88 + _82;
        _44 = _84;
    }
    _46 = _95 + 1u;
    _9._m0[_46] = _39;
    _39++;
    _39++;
    _49 = _95 + 2u;
    _9._m0[_49] = _39;
    _51 = 0;
    int _139 = _51;
    _51 = _139 + 1;
    _53 = uint(_139);
    int _142 = _51;
    _51 = _142 + 1;
    _55 = uint(_142);
    _57 = _95 + 3u;
    _9._m0[_57] = _51;
    _59 = _95 + 4u;
    _9._m0[_59] = _12._m0[uint(0)];
    _90 = 0;
    _90 = _39;
    _39 = _90 + 1;
    _61 = _95 + 5u;
    _9._m0[_61] = _39;
    int _63 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _174)))
        {
            break;
        }
        _174 -= uvec2(uint(_174.y == 0u), 1u);
        if (!(_63 < 2))
        {
            break;
        }
        _39++;
        _63++;
        continue;
    }
    _65 = _95 + 6u;
    _9._m0[_65] = _39;
    _67 = 3;
    _69 = int[](0, 0, 0);
    _72 = _95 + 7u;
    _9._m0[_72] = _69[2u];
}

