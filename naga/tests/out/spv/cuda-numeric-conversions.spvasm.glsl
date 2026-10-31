#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _9_8
{
    float _m0[];
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    float _m0[];
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _6 _m0;
} _14;

void main()
{
    uint _42 = 0u;
    uint _35 = 0u;
    uint _46 = 0u;
    float _40 = 0.0;
    float _32 = 0.0;
    float _44 = 0.0;
    uint _38 = 0u;
    int _57 = int((gl_WorkGroupID.x * 1u) + gl_LocalInvocationID.x);
    if (uint(_57) < _14._m0._m0)
    {
        _32 = float(_57);
        _38 = uint(_57);
        _42 = _38;
        _44 = _8._m0[_42];
        _40 = _44;
        _35 = uint(_57);
        _46 = _35;
        _11._m0[_46] = _40 + _32;
    }
}

