#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _14_13
{
    uint _m0[];
} _13;

shared uint _11[4];
shared uint _16[4];

void _20(uint _18, uint _19)
{
    _11[_18] = _19;
}

uint _25(uint _27, uint _28)
{
    return _27 % ((_28 == 0u) ? 1u : _28);
}

void main()
{
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _62[2] = uint[](0u, 0u);
    uint _55 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    uint _66[2] = uint[](0u, 0u);
    uint _60 = 0u;
    uint _52[2] = uint[](0u, 0u);
    uint _82[2] = uint[](0u, 0u);
    uint _76[2] = uint[](0u, 0u);
    uint _70[2] = uint[](0u, 0u);
    uint _64[2] = uint[](0u, 0u);
    uint _58[2] = uint[](0u, 0u);
    if (gl_LocalInvocationIndex == 0u)
    {
        _11 = uint[](0u, 0u, 0u, 0u);
        _16 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    _52 = uint[](0u, 0u);
    _52[0u] = 0u;
    _52[1u] = 0u;
    uint _102 = gl_WorkGroupID.x * 8u;
    _20(gl_LocalInvocationID.x, ((gl_WorkGroupID.x * 10u) + gl_LocalInvocationID.x) + 1u);
    _16[gl_LocalInvocationID.x] = 100u + gl_LocalInvocationID.x;
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _55 = _25(gl_LocalInvocationID.x + 1u, 4u);
    _58 = _52;
    _60 = _102 + gl_LocalInvocationID.x;
    _70 = _58;
    _70[1u] += _60;
    _72 = _70[0u];
    _74 = _70[1u];
    _13._m0[_74] = _11[_55] + _16[gl_LocalInvocationID.x];
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _62 = uint[](0u, 0u);
    _62[0u] = 1u;
    _62[1u] = 0u;
    _64 = _62;
    _76 = _64;
    _76[1u] += gl_LocalInvocationID.x;
    _78 = _76[0u];
    _80 = _76[1u];
    _11[_80]++;
    _66 = _52;
    _68 = (_102 + 4u) + gl_LocalInvocationID.x;
    _82 = _66;
    _82[1u] += _68;
    _84 = _82[0u];
    _86 = _82[1u];
    _13._m0[_86] = _11[gl_LocalInvocationID.x];
}

