#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    float _m0;
};

layout(set = 0, binding = 0, std140) uniform _9_8
{
    _4 _m0;
} _8;

layout(set = 0, binding = 1, std430) readonly buffer _12_11
{
    float _m0[];
} _11;

layout(set = 0, binding = 2, std430) buffer _15_14
{
    float _m0[];
} _14;

void main()
{
    uint _50 = 0u;
    uint _44 = 0u;
    uint _38 = 0u;
    float _30 = 0.0;
    float _52 = 0.0;
    uint _46 = 0u;
    uint _40 = 0u;
    uint _33 = 0u;
    uint _54 = 0u;
    uint _48 = 0u;
    uint _42 = 0u;
    uint _36 = 0u;
    _30 = _8._m0._m0;
    _33 = 0u;
    _36 = 0u;
    _30 *= 2.0;
    _44 = _33;
    _46 = _44;
    _48 = gl_LocalInvocationID.x;
    _50 = _46 + _48;
    _52 = _11._m0[_50];
    _38 = _36;
    _40 = _38;
    _42 = gl_LocalInvocationID.x;
    _54 = _40 + _42;
    _14._m0[_54] = _52 * _30;
}

