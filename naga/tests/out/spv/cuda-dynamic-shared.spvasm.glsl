#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _13_12
{
    uint _m0[];
} _12;

shared uint _10[4];
shared uint _15[4];

void _19(uint _17, uint _18)
{
    _10[_17] = _18;
}

uint _24(uint _26, uint _27)
{
    return _26 % ((_27 == 0u) ? 1u : _27);
}

void main()
{
    uint _85 = 0u;
    uint _79 = 0u;
    uint _73 = 0u;
    uint _67 = 0u;
    uint _61[2] = uint[](0u, 0u);
    uint _54 = 0u;
    uint _83 = 0u;
    uint _77 = 0u;
    uint _71 = 0u;
    uint _65[2] = uint[](0u, 0u);
    uint _59 = 0u;
    uint _51[2] = uint[](0u, 0u);
    uint _81[2] = uint[](0u, 0u);
    uint _75[2] = uint[](0u, 0u);
    uint _69[2] = uint[](0u, 0u);
    uint _63[2] = uint[](0u, 0u);
    uint _57[2] = uint[](0u, 0u);
    if (gl_LocalInvocationIndex == 0u)
    {
        _10 = uint[](0u, 0u, 0u, 0u);
        _15 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    _51 = uint[](0u, 0u);
    _51[0u] = 0u;
    _51[1u] = 0u;
    uint _101 = gl_WorkGroupID.x * 8u;
    _19(gl_LocalInvocationID.x, ((gl_WorkGroupID.x * 10u) + gl_LocalInvocationID.x) + 1u);
    _15[gl_LocalInvocationID.x] = 100u + gl_LocalInvocationID.x;
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _54 = _24(gl_LocalInvocationID.x + 1u, 4u);
    _57 = _51;
    _59 = _101 + gl_LocalInvocationID.x;
    _69 = _57;
    _69[1u] += _59;
    _71 = _69[0u];
    _73 = _69[1u];
    _12._m0[_73] = _10[_54] + _15[gl_LocalInvocationID.x];
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _61 = uint[](0u, 0u);
    _61[0u] = 1u;
    _61[1u] = 0u;
    _63 = _61;
    _75 = _63;
    _75[1u] += gl_LocalInvocationID.x;
    _77 = _75[0u];
    _79 = _75[1u];
    _10[_79]++;
    _65 = _51;
    _67 = (_101 + 4u) + gl_LocalInvocationID.x;
    _81 = _65;
    _81[1u] += _67;
    _83 = _81[0u];
    _85 = _81[1u];
    _12._m0[_85] = _10[gl_LocalInvocationID.x];
}

