#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _8
{
    uint _m0;
    int _m1[2];
};

struct _9
{
    uint _m0;
    int _m1[2];
};

shared uint _12;
shared int _14;
shared _9 _16;

void main()
{
    bool _33 = false;
    bool _36 = false;
    bool _38 = false;
    if (gl_LocalInvocationIndex == 0u)
    {
        _12 = 0u;
        _14 = 0;
        _16 = _9(0u, int[](0, 0));
    }
    barrier();
    uint _58 = atomicOr(_12, uint((gl_WorkGroupID.x + (gl_WorkGroupID.y * 32768u)) >= 64u));
    int _60 = atomicAdd(_14, 1);
    atomicExchange(_16._m0, 1u);
    int _63 = atomicAdd(_16._m1[0u], 1);
    barrier();
    barrier();
    uint _65 = atomicAdd(_12, 0u);
    barrier();
    barrier();
    int _66 = atomicAdd(_14, 0);
    barrier();
    barrier();
    uint _68 = atomicAdd(_16._m0, 0u);
    barrier();
    barrier();
    int _70 = atomicAdd(_16._m1[0u], 0);
    barrier();
    if (_65 == 0u)
    {
        _33 = _66 > 0;
    }
    else
    {
        _33 = false;
    }
    if (_33)
    {
        _36 = _68 > 0u;
    }
    else
    {
        _36 = false;
    }
    if (_36)
    {
        _38 = _70 > 0;
    }
    else
    {
        _38 = false;
    }
    if (_38)
    {
        return;
    }
    else
    {
        return;
    }
}

