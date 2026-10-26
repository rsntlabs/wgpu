#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _10_9
{
    float _m0[];
} _9;

layout(set = 0, binding = 1, std430) buffer _13_12
{
    float _m0[];
} _12;

layout(set = 0, binding = 2, std140) uniform _16_15
{
    _6 _m0;
} _15;

void main()
{
    float _60 = 0.0;
    uint _54 = 0u;
    uint _48 = 0u;
    int _40 = 0;
    uint _33 = 0u;
    uint _62 = 0u;
    uint _56 = 0u;
    uint _50 = 0u;
    float _43 = 0.0;
    uint _36 = 0u;
    uint _58 = 0u;
    uint _52 = 0u;
    uint _46 = 0u;
    uint _38 = 0u;
    _33 = 0u;
    _36 = 0u;
    _38 = _15._m0._m0;
    _40 = int((gl_WorkGroupID.x * 1u) + gl_LocalInvocationID.x);
    if (uint(_40) < _38)
    {
        _43 = float(_40);
        _52 = _33;
        _54 = _52;
        _56 = uint(_40);
        _58 = _54 + _56;
        _60 = _9._m0[_58];
        _46 = _36;
        _48 = _46;
        _50 = uint(_40);
        _62 = _48 + _50;
        _12._m0[_62] = _60 + _43;
    }
}

