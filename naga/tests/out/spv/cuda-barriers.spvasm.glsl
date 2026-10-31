#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _9_8
{
    uint _m0[];
} _8;

shared uint _11[64];
shared uint _13;

uint _15(uint _17, uint _18)
{
    return _17 % ((_18 == 0u) ? 1u : _18);
}

void main()
{
    uint _64 = 0u;
    uint _58 = 0u;
    uint _52 = 0u;
    uint _45 = 0u;
    uint _60 = 0u;
    uint _54 = 0u;
    uint _48 = 0u;
    uint _62 = 0u;
    uint _56 = 0u;
    uint _50 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _11 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
        _13 = 0u;
    }
    barrier();
    uint _80 = gl_WorkGroupID.x * 256u;
    _11[gl_LocalInvocationID.x] = ((gl_WorkGroupID.x * 2000u) + gl_LocalInvocationID.x) + 7u;
    _45 = _80 + gl_LocalInvocationID.x;
    _56 = _45;
    _8._m0[_56] = (gl_WorkGroupID.x * 1000u) + gl_LocalInvocationID.x;
    if (gl_LocalInvocationID.x == 0u)
    {
        _13 = (gl_WorkGroupID.x * 100u) + 11u;
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _48 = (_80 + 64u) + gl_LocalInvocationID.x;
    _58 = _48;
    _8._m0[_58] = _11[63u - gl_LocalInvocationID.x];
    _52 = _80 + _15(gl_LocalInvocationID.x + 1u, 64u);
    _60 = _52;
    _50 = (_80 + 128u) + gl_LocalInvocationID.x;
    _62 = _50;
    _8._m0[_62] = _8._m0[_60];
    _54 = (_80 + 192u) + gl_LocalInvocationID.x;
    _64 = _54;
    _8._m0[_64] = _13;
}

