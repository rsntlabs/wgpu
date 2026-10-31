#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _11_10
{
    uint _m0[];
} _10;

shared uint _13[64];
shared int _15;
shared float _17;

void main()
{
    uint _47 = 0u;
    uint _41 = 0u;
    uint _45 = 0u;
    uint _38 = 0u;
    uint _49 = 0u;
    uint _43 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _13 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        _15 = 0;
        _17 = 0.0;
    }
    barrier();
    uint _67 = gl_WorkGroupID.x * 128u;
    _13[gl_LocalInvocationID.x] = ((gl_WorkGroupID.x * 1000u) + gl_LocalInvocationID.x) + 10u;
    _38 = _67 + gl_LocalInvocationID.x;
    _45 = _38;
    _10._m0[_45] = _13[gl_LocalInvocationID.x];
    if (gl_LocalInvocationID.x == 0u)
    {
        int _84 = -7;
        _15 = _84;
        _17 = 3.5;
        _41 = _67 + 64u;
        _47 = _41;
        _10._m0[_47] = uint(_15 + 10);
        _43 = _67 + 65u;
        _49 = _43;
        _10._m0[_49] = uint(clamp(_17 * 2.0, 0.0, 4294967040.0));
    }
}

