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
    uint _94 = 0u;
    uint _88 = 0u;
    uint _82 = 0u;
    _4 _74 = _4(0.0, 0.0, 0.0);
    uint _90 = 0u;
    uint _84 = 0u;
    int _76 = 0;
    uint _92 = 0u;
    uint _86 = 0u;
    uint _79 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _14 = _4[](_4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0), _4(0.0, 0.0, 0.0));
        _16 = _4(0.0, 0.0, 0.0);
    }
    barrier();
    float _111 = float((gl_WorkGroupID.x * 16u) + gl_LocalInvocationID.x);
    _14[gl_LocalInvocationID.x] = _4(_111 + 0.5, (-_111) - 1.25, _111 + 2.5);
    if (gl_LocalInvocationID.x == 0u)
    {
        _16 = _4(float(gl_WorkGroupID.x) + 0.25, float(gl_WorkGroupID.x) + 0.5, float(gl_WorkGroupID.x) + 0.75);
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    uint _130 = _42(gl_LocalInvocationID.x + 1u, 8u);
    _74 = _20(_14[_130]);
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
    uint _163 = ((gl_WorkGroupID.x * 8u) + gl_LocalInvocationID.x) * 9u;
    _11._m0[_163] = _74._m0;
    _79 = _163 + 1u;
    _11._m0[_79] = _74._m1;
    _82 = _163 + 2u;
    _11._m0[_82] = _74._m2;
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _84 = _163 + 3u;
    _11._m0[_84] = _14[_130]._m0;
    _86 = _163 + 4u;
    _11._m0[_86] = _14[_130]._m1;
    _88 = _163 + 5u;
    _11._m0[_88] = _14[_130]._m2;
    _90 = _163 + 6u;
    _11._m0[_90] = _16._m0;
    _92 = _163 + 7u;
    _11._m0[_92] = _16._m1;
    _94 = _163 + 8u;
    _11._m0[_94] = _16._m2;
}

