#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _12_11
{
    uint _m0[];
} _11;

shared uint _14[64];
shared int _16;
shared float _18;

void main()
{
    uint _48 = 0u;
    uint _42 = 0u;
    uint _46 = 0u;
    uint _39 = 0u;
    uint _44 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _14 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        _16 = 0;
        _18 = 0.0;
    }
    barrier();
    uint _66 = gl_WorkGroupID.x * 128u;
    _14[gl_LocalInvocationID.x] = ((gl_WorkGroupID.x * 1000u) + gl_LocalInvocationID.x) + 10u;
    _39 = _66 + gl_LocalInvocationID.x;
    _11._m0[_39] = _14[gl_LocalInvocationID.x];
    if (gl_LocalInvocationID.x == 0u)
    {
        int _82 = -7;
        _16 = _82;
        _18 = 3.5;
        _42 = _66 + 64u;
        _46 = _42;
        _11._m0[_46] = uint(_16 + 10);
        _44 = _66 + 65u;
        _48 = _44;
        _11._m0[_48] = uint(clamp(_18 * 2.0, 0.0, 4294967040.0));
    }
}

