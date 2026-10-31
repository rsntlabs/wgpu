#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _9_8
{
    float _m0[];
} _8;

layout(set = 0, binding = 1, std430) readonly buffer _12_11
{
    float _m0[];
} _11;

layout(set = 0, binding = 2, std430) buffer _15_14
{
    float _m0[];
} _14;

layout(set = 0, binding = 3, std140) uniform _18_17
{
    _6 _m0;
} _17;

void main()
{
    uint _57 = 0u;
    float _51 = 0.0;
    float _44 = 0.0;
    uint _37 = 0u;
    uint _53 = 0u;
    float _47 = 0.0;
    uint _40 = 0u;
    float _55 = 0.0;
    uint _49 = 0u;
    uint _42 = 0u;
    uint _66 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_66 < _17._m0._m0)
    {
        _40 = _66;
        _42 = _66;
        _49 = _42;
        _51 = _11._m0[_49];
        _44 = _51;
        _53 = _40;
        _55 = _8._m0[_53];
        _47 = _55;
        _37 = _66;
        _57 = _37;
        _14._m0[_57] = _47 + (_44 * 2.0);
    }
}

