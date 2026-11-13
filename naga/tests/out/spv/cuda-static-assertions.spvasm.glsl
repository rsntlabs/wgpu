#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _8_7
{
    uint _m0[];
} _7;

uint _12(uint _11)
{
    return _11;
}

void main()
{
    uint _26 = 0u;
    uint _29 = 0u;
    _26 = 12u;
    _29 = gl_LocalInvocationID.x;
    _7._m0[_29] = _12(gl_LocalInvocationID.x + 7u);
}

