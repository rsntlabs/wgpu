#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
    uint _m1;
    uint _m2;
};

layout(set = 0, binding = 0, std430) buffer _11_10
{
    uint _m0[];
} _10;

uvec3 _13 = uvec3(0u);
uvec3 _16 = uvec3(0u);
uvec3 _17 = uvec3(0u);
shared uint _18[4];

void _23(uvec3 _21, uvec3 _22)
{
    if (_6(_21.x, _21.y, _21.z)._m0 < _22.x)
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

uint _40(uint _42, uint _43)
{
    return _42 / ((_43 == 0u) ? 1u : _43);
}

uint _54(uint _50, uint _51, uvec3 _52, uvec3 _53)
{
    uvec2 _86 = uvec2(4294967295u);
    uvec3 _62 = _17;
    uint _69 = _62.x + (4u * (_62.y + (1u * _62.z)));
    _18[_69] = _50;
    _23(_52, _53);
    uint _75 = _40(_51, 2u);
    uint _58 = _75;
    for (;;)
    {
        if (all(equal(uvec2(0u), _86)))
        {
            break;
        }
        _86 -= uvec2(uint(_86.y == 0u), 1u);
        if (!(_58 > 0u))
        {
            break;
        }
        if (_69 < _58)
        {
            _18[_69] += _18[_69 + _58];
        }
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _58 = _58 >> 1u;
        continue;
    }
    return _18[0u];
}

void main()
{
    uint _131 = 0u;
    uint _133 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _18 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    _17 = gl_LocalInvocationID;
    _13 = gl_WorkGroupID;
    _16 = gl_NumWorkGroups;
    uint _151 = gl_LocalInvocationID.x + (4u * (gl_LocalInvocationID.y + (1u * gl_LocalInvocationID.z)));
    uint _155 = ((gl_WorkGroupID.x * 10u) + _151) + 1u;
    uint _156 = _54(_155, 4u, gl_WorkGroupID, gl_NumWorkGroups);
    uint _158 = gl_WorkGroupID.x * 8u;
    _131 = _158 + _151;
    _10._m0[_131] = _156;
    _133 = (_158 + 4u) + _151;
    _10._m0[_133] = ((_155 * 10u) + _151) + 4u;
}

