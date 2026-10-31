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
    uint _104[2] = uint[](0u, 0u);
    uint _98[2] = uint[](0u, 0u);
    uint _92 = 0u;
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68[2] = uint[](0u, 0u);
    uint _62 = 0u;
    uint _56[2] = uint[](0u, 0u);
    uint _48[2] = uint[](0u, 0u);
    uint _106 = 0u;
    uint _100 = 0u;
    uint _94 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _64[2] = uint[](0u, 0u);
    uint _58 = 0u;
    uint _51 = 0u;
    uint _108 = 0u;
    uint _102 = 0u;
    uint _96 = 0u;
    uint _90[2] = uint[](0u, 0u);
    uint _84[2] = uint[](0u, 0u);
    uint _78[2] = uint[](0u, 0u);
    uint _72[2] = uint[](0u, 0u);
    uint _66 = 0u;
    uint _60[2] = uint[](0u, 0u);
    uint _54 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _13 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        _15 = 0u;
    }
    barrier();
    _48 = uint[](0u, 0u);
    _48[0u] = 0u;
    _48[1u] = 0u;
    _51 = gl_LocalInvocationID.x;
    _54 = gl_WorkGroupID.x * 256u;
    _13[_51] = ((gl_WorkGroupID.x * 2000u) + _51) + 7u;
    _56 = _48;
    _58 = _54 + _51;
    _78 = _56;
    _78[1u] += _58;
    _80 = _78[0u];
    _82 = _78[1u];
    _10._m0[_82] = (gl_WorkGroupID.x * 1000u) + _51;
    if (_51 == 0u)
    {
        _15 = (gl_WorkGroupID.x * 100u) + 11u;
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _60 = _48;
    _62 = (_54 + 64u) + _51;
    _84 = _60;
    _84[1u] += _62;
    _86 = _84[0u];
    _88 = _84[1u];
    _10._m0[_88] = _13[63u - _51];
    _68 = _48;
    _70 = _54 + _17(_51 + 1u, 64u);
    _90 = _68;
    _90[1u] += _70;
    _92 = _90[0u];
    _94 = _90[1u];
    _96 = _10._m0[_94];
    _76 = _96;
    _64 = _48;
    _66 = (_54 + 128u) + _51;
    _98 = _64;
    _98[1u] += _66;
    _100 = _98[0u];
    _102 = _98[1u];
    _10._m0[_102] = _76;
    _72 = _48;
    _74 = (_54 + 192u) + _51;
    _104 = _72;
    _104[1u] += _74;
    _106 = _104[0u];
    _108 = _104[1u];
    _10._m0[_108] = _15;
}

