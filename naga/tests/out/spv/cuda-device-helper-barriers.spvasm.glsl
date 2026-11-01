#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _5
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _8_7
{
    uint _m0[];
} _7;

layout(set = 0, binding = 1, std140) uniform _11_10
{
    _5 _m0;
} _10;

layout(set = 0, binding = 2, std140) uniform _14_13
{
    _5 _m0;
} _13;

void _17()
{
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
}

uint _83(uint _85, uint _86)
{
    return _85 % ((_86 == 0u) ? 1u : _86);
}

void _26(uint _24, uint _25)
{
    uvec2 _48 = uvec2(4294967295u);
    uint _31 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _48)))
        {
            break;
        }
        _48 -= uvec2(uint(_48.y == 0u), 1u);
        if (!(_31 < _24))
        {
            break;
        }
        if (_25 != 0u)
        {
            memoryBarrierShared();
            memoryBarrierBuffer();
            barrier();
        }
        else
        {
            memoryBarrierShared();
            memoryBarrierBuffer();
            barrier();
        }
        _31++;
        continue;
    }
}

uint _72(uint _71)
{
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    if ((_71 & 1u) != 0u)
    {
        return _71 + 100u;
    }
    return _71 + 200u;
}

void main()
{
    uint _115 = 0u;
    uint _109 = 0u;
    uint _113 = 0u;
    uint _107 = 0u;
    uint _117 = 0u;
    uint _111 = 0u;
    uint _127 = gl_WorkGroupID.x * 12u;
    _107 = _127 + gl_LocalInvocationID.x;
    _7._m0[_107] = ((gl_WorkGroupID.x * 10u) + gl_LocalInvocationID.x) + 1u;
    _17();
    _109 = _127 + _83(gl_LocalInvocationID.x + 1u, 4u);
    uint _142 = _7._m0[_109];
    _17();
    _111 = _127 + gl_LocalInvocationID.x;
    _7._m0[_111] = _142 + 10u;
    _26(_13._m0._m0, _10._m0._m0);
    _115 = _127 + _83(gl_LocalInvocationID.x + 1u, 4u);
    _113 = (_127 + 4u) + gl_LocalInvocationID.x;
    _7._m0[_113] = _7._m0[_115];
    uint _159 = _72(gl_LocalInvocationID.x);
    _117 = (_127 + 8u) + gl_LocalInvocationID.x;
    _7._m0[_117] = _159;
    _17();
}

