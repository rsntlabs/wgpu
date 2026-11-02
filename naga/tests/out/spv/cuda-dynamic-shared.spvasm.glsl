#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _14_13
{
    uint _m0[];
} _13;

shared uint _11[4];
shared uint _16[4];

void _20(uint _18, uint _19)
{
    _11[_18] = _19;
}

uint _25(uint _27, uint _28)
{
    return _27 % ((_28 == 0u) ? 1u : _28);
}

void main()
{
    uint _87 = 0u;
    uint _81 = 0u;
    uint _75 = 0u;
    uint _69 = 0u;
    uint _63[2] = uint[](0u, 0u);
    uint _56 = 0u;
    uint _85 = 0u;
    uint _79 = 0u;
    uint _73 = 0u;
    uint _67[2] = uint[](0u, 0u);
    uint _61 = 0u;
    uint _53[2] = uint[](0u, 0u);
    uint _83[2] = uint[](0u, 0u);
    uint _77[2] = uint[](0u, 0u);
    uint _71[2] = uint[](0u, 0u);
    uint _65[2] = uint[](0u, 0u);
    uint _59[2] = uint[](0u, 0u);
    if (gl_LocalInvocationIndex == 0u)
    {
        _11 = uint[](0u, 0u, 0u, 0u);
        _16 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    _53 = uint[](0u, 0u);
    _53[0u] = 2u;
    _53[1u] = 0u;
    uint _103 = gl_WorkGroupID.x * 8u;
    _20(gl_LocalInvocationID.x, ((gl_WorkGroupID.x * 10u) + gl_LocalInvocationID.x) + 1u);
    _16[gl_LocalInvocationID.x] = 100u + gl_LocalInvocationID.x;
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _56 = _25(gl_LocalInvocationID.x + 1u, 4u);
    _59 = _53;
    _61 = _103 + gl_LocalInvocationID.x;
    _71 = _59;
    _71[1u] += _61;
    _73 = _71[0u];
    _75 = _71[1u];
    _13._m0[_75] = _11[_56] + _16[gl_LocalInvocationID.x];
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _63 = uint[](0u, 0u);
    _63[0u] = 3u;
    _63[1u] = 0u;
    _65 = _63;
    _77 = _65;
    _77[1u] += gl_LocalInvocationID.x;
    _79 = _77[0u];
    _81 = _77[1u];
    _11[_81]++;
    _67 = _53;
    _69 = (_103 + 4u) + gl_LocalInvocationID.x;
    _83 = _67;
    _83[1u] += _69;
    _85 = _83[0u];
    _87 = _83[1u];
    _13._m0[_87] = _11[gl_LocalInvocationID.x];
}

