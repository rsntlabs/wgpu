#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _8_7
{
    float _m0[];
} _7;

layout(set = 0, binding = 1, std430) readonly buffer _11_10
{
    float _m0[];
} _10;

layout(set = 0, binding = 2, std430) buffer _14_13
{
    float _m0[];
} _13;

void main()
{
    float _65 = 0.0;
    uint _58 = 0u;
    uint _52 = 0u;
    uint _46 = 0u;
    uint _40 = 0u;
    uint _34 = 0u;
    uint _63 = 0u;
    uint _56 = 0u;
    uint _50 = 0u;
    uint _44 = 0u;
    uint _38 = 0u;
    uint _31 = 0u;
    uint _67 = 0u;
    float _60 = 0.0;
    uint _54 = 0u;
    uint _48 = 0u;
    uint _42 = 0u;
    uint _36 = 0u;
    _31 = 0u;
    _34 = 0u;
    _36 = 0u;
    _38 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    _46 = _31;
    _48 = _46;
    _50 = _38;
    _52 = _34;
    _54 = _52;
    _56 = _38;
    _58 = _54 + _56;
    _60 = _10._m0[_58];
    _63 = _48 + _50;
    _65 = _7._m0[_63];
    _40 = _36;
    _42 = _40;
    _44 = _38;
    _67 = _42 + _44;
    _13._m0[_67] = _65 + (_60 * 2.0);
}

