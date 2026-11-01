#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _10_9
{
    uint _m0[];
} _9;

shared uint _12[64];
shared uint _14;

uint _16(uint _18, uint _19)
{
    return _18 % ((_19 == 0u) ? 1u : _19);
}

void main()
{
    uint _55 = 0u;
    uint _49 = 0u;
    uint _53 = 0u;
    uint _46 = 0u;
    uint _51 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _12 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        _14 = 0u;
    }
    barrier();
    uint _71 = gl_WorkGroupID.x * 256u;
    _12[gl_LocalInvocationID.x] = ((gl_WorkGroupID.x * 2000u) + gl_LocalInvocationID.x) + 7u;
    _46 = _71 + gl_LocalInvocationID.x;
    _9._m0[_46] = (gl_WorkGroupID.x * 1000u) + gl_LocalInvocationID.x;
    if (gl_LocalInvocationID.x == 0u)
    {
        _14 = (gl_WorkGroupID.x * 100u) + 11u;
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _49 = (_71 + 64u) + gl_LocalInvocationID.x;
    _9._m0[_49] = _12[63u - gl_LocalInvocationID.x];
    _53 = _71 + _16(gl_LocalInvocationID.x + 1u, 64u);
    _51 = (_71 + 128u) + gl_LocalInvocationID.x;
    _9._m0[_51] = _9._m0[_53];
    _55 = (_71 + 192u) + gl_LocalInvocationID.x;
    _9._m0[_55] = _14;
}

