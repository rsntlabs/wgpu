#version 460
layout(local_size_x = 8, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    float _m0;
    float _m1;
    float _m2;
};

layout(set = 0, binding = 0, std430) buffer _12_11
{
    float _m0[];
} _11;

shared _4 _14[8];
shared _4 _16;

uint _42(uint _44, uint _45)
{
    return _44 % ((_45 == 0u) ? 1u : _45);
}

_4 _20(_4 _19)
{
    _4 _23 = _4(0.0, 0.0, 0.0);
    _23 = _19;
    _23._m0 += 1.0;
    _23._m1 = _23._m2 - _23._m1;
    return _23;
}

void main()
{
    uint _114 = 0u;
    uint _108 = 0u;
    uint _102 = 0u;
    uint _96 = 0u;
    uint _90 = 0u;
    uint _84 = 0u;
    int _76 = 0;
    uint _112 = 0u;
    uint _106 = 0u;
    uint _100 = 0u;
    uint _94 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    _4 _74 = _4(0.0, 0.0, 0.0);
    uint _110 = 0u;
    uint _104 = 0u;
    uint _98 = 0u;
    uint _92 = 0u;
    uint _86 = 0u;
    uint _79 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _14 = _4[](_4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0));
        _16 = _4(0.0, 0.0, 0.0);
    }
    barrier();
    float _131 = float((gl_WorkGroupID.x * 16u) + gl_LocalInvocationID.x);
    _14[gl_LocalInvocationID.x] = _4(_131 + 0.5, (-_131) - 1.25, _131 + 2.5);
    if (gl_LocalInvocationID.x == 0u)
    {
        _16 = _4(float(gl_WorkGroupID.x) + 0.25, float(gl_WorkGroupID.x) + 0.5, float(gl_WorkGroupID.x) + 0.75);
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    uint _150 = _42(gl_LocalInvocationID.x + 1u, 8u);
    _74 = _20(_14[_150]);
    _76 = 1;
    _74._m0 += float(_76);
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    if ((gl_LocalInvocationID.x & 1u) != 0u)
    {
        _14[gl_LocalInvocationID.x]._m1 += _16._m0;
    }
    else
    {
        _74._m1 += _16._m0;
    }
    _14[gl_LocalInvocationID.x]._m2 = _74._m0;
    uint _183 = ((gl_WorkGroupID.x * 8u) + gl_LocalInvocationID.x) * 9u;
    _79 = _183;
    _98 = _79;
    _11._m0[_98] = _74._m0;
    _82 = _183 + 1u;
    _100 = _82;
    _11._m0[_100] = _74._m1;
    _84 = _183 + 2u;
    _102 = _84;
    _11._m0[_102] = _74._m2;
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _86 = _183 + 3u;
    _104 = _86;
    _11._m0[_104] = _14[_150]._m0;
    _88 = _183 + 4u;
    _106 = _88;
    _11._m0[_106] = _14[_150]._m1;
    _90 = _183 + 5u;
    _108 = _90;
    _11._m0[_108] = _14[_150]._m2;
    _92 = _183 + 6u;
    _110 = _92;
    _11._m0[_110] = _16._m0;
    _94 = _183 + 7u;
    _112 = _94;
    _11._m0[_112] = _16._m1;
    _96 = _183 + 8u;
    _114 = _96;
    _11._m0[_114] = _16._m2;
}

