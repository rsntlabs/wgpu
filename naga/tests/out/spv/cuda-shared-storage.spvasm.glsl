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
    uint _75 = 0u;
    uint _69 = 0u;
    uint _63 = 0u;
    uint _57[2] = uint[](0u, 0u);
    uint _51 = 0u;
    uint _44 = 0u;
    uint _73[2] = uint[](0u, 0u);
    uint _67[2] = uint[](0u, 0u);
    uint _61[2] = uint[](0u, 0u);
    uint _55 = 0u;
    uint _49[2] = uint[](0u, 0u);
    uint _41[2] = uint[](0u, 0u);
    uint _77 = 0u;
    uint _71 = 0u;
    uint _65 = 0u;
    uint _59 = 0u;
    uint _53[2] = uint[](0u, 0u);
    uint _47 = 0u;
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
    _44 = gl_LocalInvocationID.x;
    _47 = gl_WorkGroupID.x * 128u;
    _15[_44] = ((gl_WorkGroupID.x * 1000u) + _44) + 10u;
    _49 = _41;
    _51 = _47 + _44;
    _61 = _49;
    _61[1u] += _51;
    _63 = _61[0u];
    _65 = _61[1u];
    _12._m0[_65] = _15[_44];
    if (_44 == 0u)
    {
        int _130 = -7;
        _17 = _130;
        _19 = 3.5;
        _53 = _41;
        _55 = _47 + 64u;
        _67 = _53;
        _67[1u] += _55;
        _69 = _67[0u];
        _71 = _67[1u];
        _12._m0[_71] = uint(_17 + 10);
        _57 = _41;
        _59 = _47 + 65u;
        _73 = _57;
        _73[1u] += _59;
        _75 = _73[0u];
        _77 = _73[1u];
        _12._m0[_77] = uint(clamp(_19 * 2.0, 0.0, 4294967040.0));
    }
}

