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
    uint _40 = 0u;
    uint _33 = 0u;
    uint _38 = 0u;
    float _30 = 0.0;
    uint _36 = 0u;
    _30 = _8._m0._m0;
    _30 *= 2.0;
    _36 = gl_LocalInvocationID.x;
    _38 = _36;
    _33 = gl_LocalInvocationID.x;
    _40 = _33;
    _14._m0[_40] = _11._m0[_38] * _30;
}

