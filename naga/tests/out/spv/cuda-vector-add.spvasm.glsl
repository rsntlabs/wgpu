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
    uint _82 = 0u;
    float _76 = 0.0;
    uint _70[2] = uint[](0u, 0u);
    uint _64 = 0u;
    float _57 = 0.0;
    uint _51 = 0u;
    uint _45[2] = uint[](0u, 0u);
    uint _38[2] = uint[](0u, 0u);
    uint _80 = 0u;
    uint _74 = 0u;
    float _68 = 0.0;
    uint _62[2] = uint[](0u, 0u);
    uint _55 = 0u;
    uint _49[2] = uint[](0u, 0u);
    uint _42 = 0u;
    uint _35[2] = uint[](0u, 0u);
    uint _78[2] = uint[](0u, 0u);
    uint _72 = 0u;
    uint _66 = 0u;
    float _60 = 0.0;
    uint _53[2] = uint[](0u, 0u);
    uint _47 = 0u;
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
    _42 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    _49 = _35;
    _51 = _42;
    _53 = _38;
    _55 = _42;
    _62 = _53;
    _62[1u] += _55;
    _64 = _62[0u];
    _66 = _62[1u];
    _68 = _12._m0[_66];
    _57 = _68;
    _70 = _49;
    _70[1u] += _51;
    _72 = _70[0u];
    _74 = _70[1u];
    _76 = _9._m0[_74];
    _60 = _76;
    _45 = _40;
    _47 = _42;
    _78 = _45;
    _78[1u] += _47;
    _80 = _78[0u];
    _82 = _78[1u];
    _15._m0[_82] = _60 + (_57 * 2.0);
}

