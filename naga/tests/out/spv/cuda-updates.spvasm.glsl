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
    uint _58 = 0u;
    uint _52 = 0u;
    int _46 = 0;
    uint _39 = 0u;
    int _32 = 0;
    uint _56[2] = uint[](0u, 0u);
    uint _50 = 0u;
    uint _44 = 0u;
    uint _37[2] = uint[](0u, 0u);
    uint _29[2] = uint[](0u, 0u);
    uint _60 = 0u;
    int _54 = 0;
    uint _48[2] = uint[](0u, 0u);
    uint _42[2] = uint[](0u, 0u);
    int _35 = 0;
    _29 = uint[](0u, 0u);
    _29[0u] = 0u;
    _29[1u] = 0u;
    _32 = _13._m0._m0;
    int _69 = _32;
    _32 = _69 + 1;
    _35 = _69;
    _37 = _29;
    _39 = gl_LocalInvocationID.x;
    _48 = _37;
    _48[1u] += _39;
    _50 = _48[0u];
    _52 = _48[1u];
    _54 = _10._m0[_52];
    _46 = _54;
    _10._m0[_52] = _46 + _35;
    _32++;
    _42 = _29;
    _44 = gl_LocalInvocationID.x;
    _56 = _42;
    _56[1u] += _44;
    _58 = _56[0u];
    _60 = _56[1u];
    _10._m0[_60] = _32;
}

