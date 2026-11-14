#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std140) uniform _10_9
{
    _6 _m0;
} _9;

layout(set = 0, binding = 1, std140) uniform _13_12
{
    _6 _m0;
} _12;

layout(set = 0, binding = 2, std430) buffer _16_15
{
    uint _m0[];
} _15;

int _20(bool _19)
{
    int _24 = 0;
    if (_19)
    {
        _24 = 31;
    }
    else
    {
        _24 = 17;
    }
    return _24;
}

void main()
{
    uint _70 = 0u;
    uint _64 = 0u;
    bool _56 = false;
    uint _72 = 0u;
    uint _66 = 0u;
    uint _59 = 0u;
    int _74 = 0;
    uint _68 = 0u;
    uint _62 = 0u;
    _56 = (_9._m0._m0 & 255u) != 0u;
    bool _85 = (_12._m0._m0 & 255u) != 0u;
    uint _88 = 4u + (gl_LocalInvocationID.x * 8u);
    bool _89 = _56;
    _15._m0[_88] = uint(_56);
    _59 = _88 + 1u;
    _15._m0[_59] = uint(_20(_56));
    _56 = !_56;
    _62 = _88 + 2u;
    _15._m0[_62] = uint(_56);
    _64 = _88 + 3u;
    _15._m0[_64] = uint(_20(_56));
    _66 = _88 + 4u;
    _15._m0[_66] = uint(_85);
    _74 = 0;
    if (_85)
    {
        _74 = 7;
    }
    else
    {
        _74 = 9;
    }
    _68 = _88 + 5u;
    _15._m0[_68] = uint(_74);
    _70 = _88 + 6u;
    _15._m0[_70] = uint(_20(_89));
    _72 = _88 + 7u;
    _15._m0[_72] = uint(int(_56) != int(_85));
}

