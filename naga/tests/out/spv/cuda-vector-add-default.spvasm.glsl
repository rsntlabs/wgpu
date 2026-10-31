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
    uint _81 = 0u;
    float _75 = 0.0;
    uint _69[2] = uint[](0u, 0u);
    uint _63 = 0u;
    float _56 = 0.0;
    uint _50 = 0u;
    uint _44[2] = uint[](0u, 0u);
    uint _37[2] = uint[](0u, 0u);
    uint _79 = 0u;
    uint _73 = 0u;
    float _67 = 0.0;
    uint _61[2] = uint[](0u, 0u);
    uint _54 = 0u;
    uint _48[2] = uint[](0u, 0u);
    uint _41 = 0u;
    uint _34[2] = uint[](0u, 0u);
    uint _77[2] = uint[](0u, 0u);
    uint _71 = 0u;
    uint _65 = 0u;
    float _59 = 0.0;
    uint _52[2] = uint[](0u, 0u);
    uint _46 = 0u;
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
    _41 = (gl_WorkGroupID.x * 1u) + gl_LocalInvocationID.x;
    _48 = _34;
    _50 = _41;
    _52 = _37;
    _54 = _41;
    _61 = _52;
    _61[1u] += _54;
    _63 = _61[0u];
    _65 = _61[1u];
    _67 = _12._m0[_65];
    _56 = _67;
    _69 = _48;
    _69[1u] += _50;
    _71 = _69[0u];
    _73 = _69[1u];
    _75 = _9._m0[_73];
    _59 = _75;
    _44 = _39;
    _46 = _41;
    _77 = _44;
    _77[1u] += _46;
    _79 = _77[0u];
    _81 = _77[1u];
    _15._m0[_81] = _59 + (_56 * 2.0);
}

