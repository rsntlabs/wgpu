#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _11_10
{
    uint _m0[];
} _10;

shared uint _13[64];
shared uint _15;

uint _17(uint _19, uint _20)
{
    return _19 % ((_20 == 0u) ? 1u : _20);
}

void main()
{
    uint _100[2] = uint[](0u, 0u);
    uint _94[2] = uint[](0u, 0u);
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _64[2] = uint[](0u, 0u);
    uint _58 = 0u;
    uint _51[2] = uint[](0u, 0u);
    uint _104 = 0u;
    uint _98 = 0u;
    uint _92 = 0u;
    uint _86[2] = uint[](0u, 0u);
    uint _80[2] = uint[](0u, 0u);
    uint _74[2] = uint[](0u, 0u);
    uint _68[2] = uint[](0u, 0u);
    uint _62 = 0u;
    uint _56[2] = uint[](0u, 0u);
    uint _48[2] = uint[](0u, 0u);
    uint _102 = 0u;
    uint _96 = 0u;
    uint _90 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    uint _66 = 0u;
    uint _60[2] = uint[](0u, 0u);
    uint _53 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _13 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        _15 = 0u;
    }
    barrier();
    _48 = uint[](0u, 0u);
    _48[0u] = 0u;
    _48[1u] = 0u;
    uint _121 = gl_WorkGroupID.x * 256u;
    _13[gl_LocalInvocationID.x] = ((gl_WorkGroupID.x * 2000u) + gl_LocalInvocationID.x) + 7u;
    _51 = _48;
    _53 = _121 + gl_LocalInvocationID.x;
    _74 = _51;
    _74[1u] += _53;
    _76 = _74[0u];
    _78 = _74[1u];
    _10._m0[_78] = (gl_WorkGroupID.x * 1000u) + gl_LocalInvocationID.x;
    if (gl_LocalInvocationID.x == 0u)
    {
        _15 = (gl_WorkGroupID.x * 100u) + 11u;
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _56 = _48;
    _58 = (_121 + 64u) + gl_LocalInvocationID.x;
    _80 = _56;
    _80[1u] += _58;
    _82 = _80[0u];
    _84 = _80[1u];
    _10._m0[_84] = _13[63u - gl_LocalInvocationID.x];
    _64 = _48;
    _66 = _121 + _17(gl_LocalInvocationID.x + 1u, 64u);
    _86 = _64;
    _86[1u] += _66;
    _88 = _86[0u];
    _90 = _86[1u];
    _92 = _10._m0[_90];
    _72 = _92;
    _60 = _48;
    _62 = (_121 + 128u) + gl_LocalInvocationID.x;
    _94 = _60;
    _94[1u] += _62;
    _96 = _94[0u];
    _98 = _94[1u];
    _10._m0[_98] = _72;
    _68 = _48;
    _70 = (_121 + 192u) + gl_LocalInvocationID.x;
    _100 = _68;
    _100[1u] += _70;
    _102 = _100[0u];
    _104 = _100[1u];
    _10._m0[_104] = _15;
}

