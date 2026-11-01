#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _5_6
{
    uint _m0[];
} _6;

layout(set = 0, binding = 1, std430) buffer _5_8
{
    uint _m0[];
} _8;

layout(set = 0, binding = 2, std430) buffer _5_9
{
    uint _m0[];
} _9;

void main()
{
    uint _21 = 0u;
    uvec2 _62 = uvec2(4294967295u);
    _6._m0[0u] = 7u;
    _9._m0[0u] = _6._m0[1u] + _6._m0[1u];
    _9._m0[1u] = _6._m0[2u] + _6._m0[2u];
    if (gl_LocalInvocationIndex == 0u)
    {
    }
    for (;;)
    {
        if (all(equal(uvec2(0u), _62)))
        {
            break;
        }
        _62 -= uvec2(uint(_62.y == 0u), 1u);
        if (!(_21 < 2u))
        {
            break;
        }
        _21++;
        continue;
    }
}

