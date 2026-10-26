#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

shared uint _11[64];
shared uint _13;

uint _15(uint _17, uint _18)
{
    return _17 % ((_18 == 0u) ? 1u : _18);
}

void main()
{
    uint _90 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    uint _66 = 0u;
    uint _60 = 0u;
    uint _54 = 0u;
    uint _48 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _64 = 0u;
    uint _58 = 0u;
    uint _52 = 0u;
    uint _45 = 0u;
    uint _92 = 0u;
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _62 = 0u;
    uint _56 = 0u;
    uint _50 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _11 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        _13 = 0u;
    }
    barrier();
    _45 = 0u;
    _48 = gl_LocalInvocationID.x;
    _50 = gl_WorkGroupID.x * 256u;
    _11[_48] = ((gl_WorkGroupID.x * 2000u) + _48) + 7u;
    _52 = _45;
    _54 = _52;
    _56 = _50 + _48;
    _82 = _54 + _56;
    _8._m0[_82] = (gl_WorkGroupID.x * 1000u) + _48;
    if (_48 == 0u)
    {
        _13 = (gl_WorkGroupID.x * 100u) + 11u;
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _58 = _45;
    _60 = _58;
    _62 = (_50 + 64u) + _48;
    _84 = _60 + _62;
    _8._m0[_84] = _11[63u - _48];
    _70 = _45;
    _72 = _70;
    _74 = _50 + _15(_48 + 1u, 64u);
    _86 = _72 + _74;
    _88 = _8._m0[_86];
    _64 = _45;
    _66 = _64;
    _68 = (_50 + 128u) + _48;
    _90 = _66 + _68;
    _8._m0[_90] = _88;
    _76 = _45;
    _78 = _76;
    _80 = (_50 + 192u) + _48;
    _92 = _78 + _80;
    _8._m0[_92] = _13;
}

