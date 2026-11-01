#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
    uint _m1;
    uint _m2;
};

layout(set = 0, binding = 0, std430) buffer _10_9
{
    uint _m0[];
} _9;

uvec3 _12 = uvec3(0u);
uvec3 _15 = uvec3(0u);
uvec3 _16 = uvec3(0u);
shared uint _17[4];

void _22(uvec3 _20, uvec3 _21)
{
    if (_6(_20.x, _20.y, _20.z)._m0 < _21.x)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        return;
    }
    else
    {
        return;
    }
}

uint _39(uint _41, uint _42)
{
    return _41 / ((_42 == 0u) ? 1u : _42);
}

uint _53(uint _49, uint _50, uvec3 _51, uvec3 _52)
{
    uvec2 _85 = uvec2(4294967295u);
    uvec3 _61 = _16;
    uint _68 = _61.x + (4u * (_61.y + (1u * _61.z)));
    _17[_68] = _49;
    _22(_51, _52);
    uint _74 = _39(_50, 2u);
    uint _57 = _74;
    for (;;)
    {
        if (all(equal(uvec2(0u), _85)))
        {
            break;
        }
        _85 -= uvec2(uint(_85.y == 0u), 1u);
        if (!(_57 > 0u))
        {
            break;
        }
        if (_68 < _57)
        {
            _17[_68] += _17[_68 + _57];
        }
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _57 = _57 >> 1u;
        continue;
    }
    return _17[0u];
}

void main()
{
    uint _130 = 0u;
    uint _132 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _17 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    _16 = gl_LocalInvocationID;
    _12 = gl_WorkGroupID;
    _15 = gl_NumWorkGroups;
    uint _150 = gl_LocalInvocationID.x + (4u * (gl_LocalInvocationID.y + (1u * gl_LocalInvocationID.z)));
    uint _154 = ((gl_WorkGroupID.x * 10u) + _150) + 1u;
    uint _155 = _53(_154, 4u, gl_WorkGroupID, gl_NumWorkGroups);
    uint _157 = gl_WorkGroupID.x * 8u;
    _130 = _157 + _150;
    _9._m0[_130] = _155;
    _132 = (_157 + 4u) + _150;
    _9._m0[_132] = ((_154 * 10u) + _150) + 4u;
}

