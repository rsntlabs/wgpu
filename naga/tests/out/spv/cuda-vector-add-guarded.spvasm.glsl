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
    uint _71 = 0u;
    uint _64 = 0u;
    uint _58 = 0u;
    uint _52 = 0u;
    uint _46 = 0u;
    uint _40 = 0u;
    uint _75 = 0u;
    float _68 = 0.0;
    uint _62 = 0u;
    uint _56 = 0u;
    uint _50 = 0u;
    uint _44 = 0u;
    uint _37 = 0u;
    float _73 = 0.0;
    uint _66 = 0u;
    uint _60 = 0u;
    uint _54 = 0u;
    uint _48 = 0u;
    uint _42 = 0u;
    _37 = 0u;
    _40 = 0u;
    _42 = 0u;
    _44 = _17._m0._m0;
    _46 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_46 < _44)
    {
        _54 = _37;
        _56 = _54;
        _58 = _46;
        _60 = _40;
        _62 = _60;
        _64 = _46;
        _66 = _62 + _64;
        _68 = _11._m0[_66];
        _71 = _56 + _58;
        _73 = _8._m0[_71];
        _48 = _42;
        _50 = _48;
        _52 = _46;
        _75 = _50 + _52;
        _14._m0[_75] = _73 + (_68 * 2.0);
    }
}

