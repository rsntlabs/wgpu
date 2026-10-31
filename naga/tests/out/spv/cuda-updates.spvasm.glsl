#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    int _m0;
};

layout(set = 0, binding = 0, std430) buffer _11_10
{
    int _m0[];
} _10;

layout(set = 0, binding = 1, std140) uniform _14_13
{
    _6 _m0;
} _13;

void main()
{
    uint _56 = 0u;
    uint _50 = 0u;
    int _44 = 0;
    uint _37 = 0u;
    uint _29[2] = uint[](0u, 0u);
    uint _58 = 0u;
    int _52 = 0;
    uint _46[2] = uint[](0u, 0u);
    uint _40[2] = uint[](0u, 0u);
    int _32 = 0;
    uint _54[2] = uint[](0u, 0u);
    uint _48 = 0u;
    uint _42 = 0u;
    uint _35[2] = uint[](0u, 0u);
    _29 = uint[](0u, 0u);
    _29[0u] = 0u;
    _29[1u] = 0u;
    _32 = _13._m0._m0;
    int _67 = _32;
    _32 = _67 + 1;
    _35 = _29;
    _37 = gl_LocalInvocationID.x;
    _46 = _35;
    _46[1u] += _37;
    _48 = _46[0u];
    _50 = _46[1u];
    _52 = _10._m0[_50];
    _44 = _52;
    _10._m0[_50] = _44 + _67;
    _32++;
    _40 = _29;
    _42 = gl_LocalInvocationID.x;
    _54 = _40;
    _54[1u] += _42;
    _56 = _54[0u];
    _58 = _54[1u];
    _10._m0[_58] = _32;
}

