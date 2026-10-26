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
    uint _46 = 0u;
    uint _40 = 0u;
    uint _34 = 0u;
    uint _26 = 0u;
    int _48 = 0;
    uint _42 = 0u;
    uint _36 = 0u;
    int _29 = 0;
    uint _50 = 0u;
    uint _44 = 0u;
    uint _38 = 0u;
    int _32 = 0;
    _26 = 0u;
    _29 = _11._m0._m0;
    int _56 = _29;
    _29 = _56 + 1;
    _32 = _56;
    _34 = _26;
    _36 = _34;
    _38 = gl_LocalInvocationID.x;
    _46 = _36 + _38;
    _48 = _8._m0[_46];
    _8._m0[_46] = _48 + _32;
    _29++;
    _40 = _26;
    _42 = _40;
    _44 = gl_LocalInvocationID.x;
    _50 = _42 + _44;
    _8._m0[_50] = _29;
}

