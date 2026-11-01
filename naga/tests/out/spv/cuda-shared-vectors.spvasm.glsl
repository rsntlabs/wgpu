#version 460
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    float _m0;
    float _m1;
    float _m2;
};

struct _5
{
    float _m0;
    float _m1;
    float _m2;
};

layout(set = 0, binding = 0, std430) buffer _14_13
{
    float _m0[];
} _13;

shared _5 _16[8];
shared _5 _18;

_5 _120(_4 _122)
{
    return _5(_122._m0, _122._m1, _122._m2);
}

uint _44(uint _46, uint _47)
{
    return _46 % ((_47 == 0u) ? 1u : _47);
}

_4 _146(_5 _148)
{
    return _4(_148._m0, _148._m1, _148._m2);
}

_4 _22(_4 _21)
{
    _4 _25 = _4(0.0, 0.0, 0.0);
    _25 = _21;
    _25._m0 += 1.0;
    _25._m1 = _25._m2 - _25._m1;
    return _25;
}

void main()
{
    uint _96 = 0u;
    uint _90 = 0u;
    uint _84 = 0u;
    _4 _76 = _4(0.0, 0.0, 0.0);
    uint _92 = 0u;
    uint _86 = 0u;
    int _78 = 0;
    uint _94 = 0u;
    uint _88 = 0u;
    uint _81 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _16 = _5[](_5(0.0, 0.0, 0.0), _5(0.0, 0.0, 0.0), _5(0.0, 0.0, 0.0), _5(0.0, 0.0, 0.0), _5(0.0, 0.0, 0.0), _5(0.0, 0.0, 0.0), _5(0.0, 0.0, 0.0), _5(0.0, 0.0, 0.0));
        _18 = _5(0.0, 0.0, 0.0);
    }
    barrier();
    float _113 = float((gl_WorkGroupID.x * 16u) + gl_LocalInvocationID.x);
    _16[gl_LocalInvocationID.x] = _120(_4(_113 + 0.5, (-_113) - 1.25, _113 + 2.5));
    if (gl_LocalInvocationID.x == 0u)
    {
        _18 = _120(_4(float(gl_WorkGroupID.x) + 0.25, float(gl_WorkGroupID.x) + 0.5, float(gl_WorkGroupID.x) + 0.75));
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    uint _142 = _44(gl_LocalInvocationID.x + 1u, 8u);
    _76 = _22(_146(_16[_142]));
    _78 = 1;
    _76._m0 += float(_78);
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    if ((gl_LocalInvocationID.x & 1u) != 0u)
    {
        _16[gl_LocalInvocationID.x]._m1 += _18._m0;
    }
    else
    {
        _76._m1 += _18._m0;
    }
    _16[gl_LocalInvocationID.x]._m2 = _76._m0;
    uint _184 = ((gl_WorkGroupID.x * 8u) + gl_LocalInvocationID.x) * 9u;
    _13._m0[_184] = _76._m0;
    _81 = _184 + 1u;
    _13._m0[_81] = _76._m1;
    _84 = _184 + 2u;
    _13._m0[_84] = _76._m2;
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _86 = _184 + 3u;
    _13._m0[_86] = _16[_142]._m0;
    _88 = _184 + 4u;
    _13._m0[_88] = _16[_142]._m1;
    _90 = _184 + 5u;
    _13._m0[_90] = _16[_142]._m2;
    _92 = _184 + 6u;
    _13._m0[_92] = _18._m0;
    _94 = _184 + 7u;
    _13._m0[_94] = _18._m1;
    _96 = _184 + 8u;
    _13._m0[_96] = _18._m2;
}

