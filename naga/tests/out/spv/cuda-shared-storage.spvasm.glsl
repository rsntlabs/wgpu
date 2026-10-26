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
    uint _65 = 0u;
    uint _59 = 0u;
    uint _53 = 0u;
    uint _47 = 0u;
    uint _41 = 0u;
    uint _63 = 0u;
    uint _57 = 0u;
    uint _51 = 0u;
    uint _45 = 0u;
    uint _38 = 0u;
    uint _67 = 0u;
    uint _61 = 0u;
    uint _55 = 0u;
    uint _49 = 0u;
    uint _43 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _13 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        _15 = 0;
        _17 = 0.0;
    }
    barrier();
    _38 = 0u;
    _41 = gl_LocalInvocationID.x;
    _43 = gl_WorkGroupID.x * 128u;
    _13[_41] = ((gl_WorkGroupID.x * 1000u) + _41) + 10u;
    _45 = _38;
    _47 = _45;
    _49 = _43 + _41;
    _63 = _47 + _49;
    _10._m0[_63] = _13[_41];
    if (_41 == 0u)
    {
        int _112 = -7;
        _15 = _112;
        _17 = 3.5;
        _51 = _38;
        _53 = _51;
        _55 = _43 + 64u;
        _65 = _53 + _55;
        _10._m0[_65] = uint(_15 + 10);
        _57 = _38;
        _59 = _57;
        _61 = _43 + 65u;
        _67 = _59 + _61;
        _10._m0[_67] = uint(clamp(_17 * 2.0, 0.0, 4294967040.0));
    }
}

