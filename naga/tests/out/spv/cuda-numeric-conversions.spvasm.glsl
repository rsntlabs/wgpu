#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _12_11
{
    float _m0[];
} _11;

layout(set = 0, binding = 1, std430) buffer _15_14
{
    float _m0[];
} _14;

layout(set = 0, binding = 2, std140) uniform _18_17
{
    _6 _m0;
} _17;

void main()
{
    uint _72 = 0u;
    float _66 = 0.0;
    uint _60[2] = uint[](0u, 0u);
    uint _54[2] = uint[](0u, 0u);
    float _47 = 0.0;
    uint _39[2] = uint[](0u, 0u);
    uint _70 = 0u;
    uint _64 = 0u;
    float _58 = 0.0;
    uint _52 = 0u;
    int _44 = 0;
    uint _36[2] = uint[](0u, 0u);
    uint _68[2] = uint[](0u, 0u);
    uint _62 = 0u;
    uint _56 = 0u;
    uint _50[2] = uint[](0u, 0u);
    uint _41 = 0u;
    _36 = uint[](0u, 0u);
    _36[0u] = 0u;
    _36[1u] = 0u;
    _39 = uint[](0u, 0u);
    _39[0u] = 1u;
    _39[1u] = 0u;
    _41 = _17._m0._m0;
    _44 = int((gl_WorkGroupID.x * 1u) + gl_LocalInvocationID.x);
    if (uint(_44) < _41)
    {
        _47 = float(_44);
        _54 = _36;
        _56 = uint(_44);
        _60 = _54;
        _60[1u] += _56;
        _62 = _60[0u];
        _64 = _60[1u];
        _66 = _11._m0[_64];
        _58 = _66;
        _50 = _39;
        _52 = uint(_44);
        _68 = _50;
        _68[1u] += _52;
        _70 = _68[0u];
        _72 = _68[1u];
        _14._m0[_72] = _58 + _47;
    }
}

