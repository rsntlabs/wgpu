#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    int _m0;
};

layout(set = 0, binding = 0, std430) buffer _9_8
{
    int _m0[];
} _8;

layout(set = 0, binding = 1, std140) uniform _12_11
{
    _6 _m0;
} _11;

void main()
{
    uint _36 = 0u;
    uint _29 = 0u;
    uint _40 = 0u;
    int _34 = 0;
    int _26 = 0;
    int _38 = 0;
    uint _32 = 0u;
    _26 = _11._m0._m0;
    int _46 = _26;
    _26 = _46 + 1;
    _29 = gl_LocalInvocationID.x;
    _36 = _29;
    _38 = _8._m0[_36];
    _34 = _38;
    _8._m0[_36] = _34 + _46;
    _26++;
    _32 = gl_LocalInvocationID.x;
    _40 = _32;
    _8._m0[_40] = _26;
}

