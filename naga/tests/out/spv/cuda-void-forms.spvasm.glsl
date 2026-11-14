#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _10_9
{
    int _m0[];
} _9;

void main()
{
    int _52 = 0;
    uint _46 = 0u;
    uint _40 = 0u;
    int _32 = 0;
    int _54[3] = int[](0, 0, 0);
    uint _48 = 0u;
    int _42 = 0;
    uint _35 = 0u;
    uint _57 = 0u;
    int _50 = 0;
    uint _44 = 0u;
    uint _38 = 0u;
    uint _62 = 4u + (gl_LocalInvocationID.x * 6u);
    _32 = int(gl_LocalInvocationID.x);
    _32++;
    _32++;
    _9._m0[_62] = _32;
    _32++;
    _32++;
    _35 = _62 + 1u;
    _9._m0[_35] = _32;
    if ((gl_LocalInvocationID.x & 1u) == 0u)
    {
        _32 += 3;
    }
    else
    {
        _32 += 7;
    }
    _38 = _62 + 2u;
    _9._m0[_38] = _32;
    _32++;
    _32++;
    _40 = _62 + 3u;
    _9._m0[_40] = _32;
    _42 = 0;
    int _101 = _42;
    _42 = _101 + 1;
    _44 = uint(_101);
    int _104 = _42;
    _42 = _104 + 1;
    _46 = uint(_104);
    _48 = _62 + 4u;
    _9._m0[_48] = _42;
    _50 = 3;
    _54 = int[](0, 0, 0);
    _57 = _62 + 5u;
    _9._m0[_57] = _54[2u];
}

