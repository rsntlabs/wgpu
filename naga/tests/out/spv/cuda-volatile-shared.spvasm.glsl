#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _12_11
{
    uint _m0[];
} _11;

shared uint _14[4];

uint _16(uint _18, uint _19)
{
    return _18 % ((_19 == 0u) ? 1u : _19);
}

void main()
{
    uint _110[2] = uint[](0u, 0u);
    uint _104[2] = uint[](0u, 0u);
    uint _98[2] = uint[](0u, 0u);
    uint _92[2] = uint[](0u, 0u);
    uint _86[2] = uint[](0u, 0u);
    uint _80 = 0u;
    uint _74[2] = uint[](0u, 0u);
    uint _68 = 0u;
    uint _62 = 0u;
    uint _56[2] = uint[](0u, 0u);
    uint _50 = 0u;
    uint _42[2] = uint[](0u, 0u);
    uint _112 = 0u;
    uint _106 = 0u;
    uint _100 = 0u;
    uint _94 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70[2] = uint[](0u, 0u);
    uint _64 = 0u;
    uint _58 = 0u;
    uint _52[2] = uint[](0u, 0u);
    uint _45[2] = uint[](0u, 0u);
    uint _114 = 0u;
    uint _108 = 0u;
    uint _102 = 0u;
    uint _96 = 0u;
    uint _90 = 0u;
    uint _84 = 0u;
    uint _78[2] = uint[](0u, 0u);
    uint _72 = 0u;
    uint _66 = 0u;
    uint _60[2] = uint[](0u, 0u);
    uint _54 = 0u;
    uint _47 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _14 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    _42 = uint[](0u, 0u);
    _42[0u] = 0u;
    _42[1u] = 0u;
    _50 = 0u;
    _50 = (gl_WorkGroupID.x * 1000u) + gl_LocalInvocationID.x;
    _14[gl_LocalInvocationID.x] = _50;
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _54 = 0u;
    _58 = 0u;
    _62 = 0u;
    _64 = 0u;
    _66 = 0u;
    _52 = uint[](0u, 0u);
    _52[0u] = 1u;
    _52[1u] = 0u;
    _54 = _16(gl_LocalInvocationID.x + 1u, 4u);
    _56 = _52;
    _58 = _54;
    _86 = _56;
    _86[1u] += _58;
    _88 = _86[0u];
    _90 = _86[1u];
    uint _154 = _14[_90];
    _64 = _154;
    _60 = _52;
    _62 = _54;
    _92 = _60;
    _92[1u] += _62;
    _94 = _92[0u];
    _96 = _92[1u];
    uint _169 = _14[_96];
    _66 = _169;
    uint _170 = _66;
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _68 = 0u;
    _68 = _170 + 17u;
    _14[gl_LocalInvocationID.x] = _68;
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _72 = 0u;
    _76 = 0u;
    _80 = 0u;
    _82 = 0u;
    _84 = 0u;
    _70 = uint[](0u, 0u);
    _70[0u] = 1u;
    _70[1u] = 0u;
    _72 = _16(gl_LocalInvocationID.x + 3u, 4u);
    _74 = _70;
    _76 = _72;
    _98 = _74;
    _98[1u] += _76;
    _100 = _98[0u];
    _102 = _98[1u];
    uint _192 = _14[_102];
    _82 = _192;
    _78 = _70;
    _80 = _72;
    _104 = _78;
    _104[1u] += _80;
    _106 = _104[0u];
    _108 = _104[1u];
    uint _207 = _14[_108];
    _84 = _207;
    _45 = _42;
    _47 = (gl_WorkGroupID.x * 4u) + gl_LocalInvocationID.x;
    _110 = _45;
    _110[1u] += _47;
    _112 = _110[0u];
    _114 = _110[1u];
    _11._m0[_114] = _84;
}

