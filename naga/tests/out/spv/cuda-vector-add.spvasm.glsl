#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

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
    uint _76[2] = uint[](0u, 0u);
    uint _70 = 0u;
    uint _64 = 0u;
    float _58 = 0.0;
    uint _51[2] = uint[](0u, 0u);
    uint _44 = 0u;
    uint _38[2] = uint[](0u, 0u);
    uint _80 = 0u;
    float _74 = 0.0;
    uint _68[2] = uint[](0u, 0u);
    uint _62 = 0u;
    float _55 = 0.0;
    uint _49 = 0u;
    uint _42[2] = uint[](0u, 0u);
    uint _35[2] = uint[](0u, 0u);
    uint _78 = 0u;
    uint _72 = 0u;
    float _66 = 0.0;
    uint _60[2] = uint[](0u, 0u);
    uint _53 = 0u;
    uint _47[2] = uint[](0u, 0u);
    uint _40[2] = uint[](0u, 0u);
    _35 = uint[](0u, 0u);
    _35[0u] = 0u;
    _35[1u] = 0u;
    _38 = uint[](0u, 0u);
    _38[0u] = 1u;
    _38[1u] = 0u;
    _40 = uint[](0u, 0u);
    _40[0u] = 2u;
    _40[1u] = 0u;
    uint _92 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    _47 = _35;
    _49 = _92;
    _51 = _38;
    _53 = _92;
    _60 = _51;
    _60[1u] += _53;
    _62 = _60[0u];
    _64 = _60[1u];
    _66 = _12._m0[_64];
    _55 = _66;
    _68 = _47;
    _68[1u] += _49;
    _70 = _68[0u];
    _72 = _68[1u];
    _74 = _9._m0[_72];
    _58 = _74;
    _42 = _40;
    _44 = _92;
    _76 = _42;
    _76[1u] += _44;
    _78 = _76[0u];
    _80 = _76[1u];
    _15._m0[_80] = _58 + (_55 * 2.0);
}

