#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _13_12
{
    uint _m0[];
} _12;

shared uint _15[64];
shared int _17;
shared float _19;

void main()
{
    uint _69[2] = uint[](0u, 0u);
    uint _63[2] = uint[](0u, 0u);
    uint _57[2] = uint[](0u, 0u);
    uint _51 = 0u;
    uint _44[2] = uint[](0u, 0u);
    uint _73 = 0u;
    uint _67 = 0u;
    uint _61 = 0u;
    uint _55 = 0u;
    uint _49[2] = uint[](0u, 0u);
    uint _41[2] = uint[](0u, 0u);
    uint _71 = 0u;
    uint _65 = 0u;
    uint _59 = 0u;
    uint _53[2] = uint[](0u, 0u);
    uint _46 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _15 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        _17 = 0;
        _19 = 0.0;
    }
    barrier();
    _41 = uint[](0u, 0u);
    _41[0u] = 0u;
    _41[1u] = 0u;
    uint _93 = gl_WorkGroupID.x * 128u;
    _15[gl_LocalInvocationID.x] = ((gl_WorkGroupID.x * 1000u) + gl_LocalInvocationID.x) + 10u;
    _44 = _41;
    _46 = _93 + gl_LocalInvocationID.x;
    _57 = _44;
    _57[1u] += _46;
    _59 = _57[0u];
    _61 = _57[1u];
    _12._m0[_61] = _15[gl_LocalInvocationID.x];
    if (gl_LocalInvocationID.x == 0u)
    {
        int _120 = -7;
        _17 = _120;
        _19 = 3.5;
        _49 = _41;
        _51 = _93 + 64u;
        _63 = _49;
        _63[1u] += _51;
        _65 = _63[0u];
        _67 = _63[1u];
        _12._m0[_67] = uint(_17 + 10);
        _53 = _41;
        _55 = _93 + 65u;
        _69 = _53;
        _69[1u] += _55;
        _71 = _69[0u];
        _73 = _69[1u];
        _12._m0[_73] = uint(clamp(_19 * 2.0, 0.0, 4294967040.0));
    }
}

