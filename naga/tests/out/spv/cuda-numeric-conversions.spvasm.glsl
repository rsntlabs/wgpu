#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _11_10
{
    float _m0[];
} _10;

layout(set = 0, binding = 1, std430) buffer _14_13
{
    float _m0[];
} _13;

layout(set = 0, binding = 2, std140) uniform _17_16
{
    _6 _m0;
} _16;

void main()
{
    uint _64 = 0u;
    uint _58 = 0u;
    float _52 = 0.0;
    uint _45 = 0u;
    uint _38[2] = uint[](0u, 0u);
    uint _62[2] = uint[](0u, 0u);
    uint _56 = 0u;
    uint _50 = 0u;
    uint _43[2] = uint[](0u, 0u);
    uint _35[2] = uint[](0u, 0u);
    uint _66 = 0u;
    float _60 = 0.0;
    uint _54[2] = uint[](0u, 0u);
    uint _48[2] = uint[](0u, 0u);
    float _40 = 0.0;
    _35 = uint[](0u, 0u);
    _35[0u] = 0u;
    _35[1u] = 0u;
    _38 = uint[](0u, 0u);
    _38[0u] = 1u;
    _38[1u] = 0u;
    int _81 = int((gl_WorkGroupID.x * 1u) + gl_LocalInvocationID.x);
    if (uint(_81) < _16._m0._m0)
    {
        _40 = float(_81);
        _48 = _35;
        _50 = uint(_81);
        _54 = _48;
        _54[1u] += _50;
        _56 = _54[0u];
        _58 = _54[1u];
        _60 = _10._m0[_58];
        _52 = _60;
        _43 = _38;
        _45 = uint(_81);
        _62 = _43;
        _62[1u] += _45;
        _64 = _62[0u];
        _66 = _62[1u];
        _13._m0[_66] = _52 + _40;
    }
}

