#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _10_9
{
    float _m0[];
} _9;

layout(set = 0, binding = 1, std430) readonly buffer _13_12
{
    float _m0[];
} _12;

layout(set = 0, binding = 2, std430) buffer _16_15
{
    float _m0[];
} _15;

void main()
{
    uint _75[2] = uint[](0u, 0u);
    uint _69 = 0u;
    uint _63 = 0u;
    float _57 = 0.0;
    uint _50[2] = uint[](0u, 0u);
    uint _43 = 0u;
    uint _37[2] = uint[](0u, 0u);
    uint _79 = 0u;
    float _73 = 0.0;
    uint _67[2] = uint[](0u, 0u);
    uint _61 = 0u;
    float _54 = 0.0;
    uint _48 = 0u;
    uint _41[2] = uint[](0u, 0u);
    uint _34[2] = uint[](0u, 0u);
    uint _77 = 0u;
    uint _71 = 0u;
    float _65 = 0.0;
    uint _59[2] = uint[](0u, 0u);
    uint _52 = 0u;
    uint _46[2] = uint[](0u, 0u);
    uint _39[2] = uint[](0u, 0u);
    _34 = uint[](0u, 0u);
    _34[0u] = 0u;
    _34[1u] = 0u;
    _37 = uint[](0u, 0u);
    _37[0u] = 1u;
    _37[1u] = 0u;
    _39 = uint[](0u, 0u);
    _39[0u] = 2u;
    _39[1u] = 0u;
    uint _91 = (gl_WorkGroupID.x * 1u) + gl_LocalInvocationID.x;
    _46 = _34;
    _48 = _91;
    _50 = _37;
    _52 = _91;
    _59 = _50;
    _59[1u] += _52;
    _61 = _59[0u];
    _63 = _59[1u];
    _65 = _12._m0[_63];
    _54 = _65;
    _67 = _46;
    _67[1u] += _48;
    _69 = _67[0u];
    _71 = _67[1u];
    _73 = _9._m0[_71];
    _57 = _73;
    _41 = _39;
    _43 = _91;
    _75 = _41;
    _75[1u] += _43;
    _77 = _75[0u];
    _79 = _75[1u];
    _15._m0[_79] = _57 + (_54 * 2.0);
}

