#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _5
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _11_10
{
    uint _m0[];
} _10;

layout(set = 0, binding = 1, std430) buffer _14_13
{
    uint _m0[];
} _13;

layout(set = 0, binding = 2, std140) uniform _17_16
{
    _5 _m0;
} _16;

shared uint _19[4];

uint _21(uint _23, uint _24)
{
    return _23 % ((_24 == 0u) ? 1u : _24);
}

void main()
{
    uint _49 = 0u;
    uint _52 = 0u;
    uint _54 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _19 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    uint _71 = gl_WorkGroupID.x * 4u;
    _49 = _71 + gl_LocalInvocationID.x;
    _19[gl_LocalInvocationID.x] = _10._m0[_49];
    if (_16._m0._m0 != 0u)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _52 = _19[_21(gl_LocalInvocationID.x + 1u, 4u)] + 10u;
    }
    else
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _52 = _19[_21(gl_LocalInvocationID.x + 2u, 4u)] + 20u;
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _19[gl_LocalInvocationID.x] = _52;
    switch (_21(gl_WorkGroupID.x + _16._m0._m0, 3u))
    {
        case 0u:
        {
            memoryBarrierShared();
            memoryBarrierBuffer();
            barrier();
            _19[gl_LocalInvocationID.x]++;
            break;
        }
        case 1u:
        {
            memoryBarrierShared();
            memoryBarrierBuffer();
            barrier();
            _19[gl_LocalInvocationID.x] *= 2u;
            memoryBarrierShared();
            memoryBarrierBuffer();
            barrier();
            _19[gl_LocalInvocationID.x] += 3u;
            break;
        }
        default:
        {
            memoryBarrierShared();
            memoryBarrierBuffer();
            barrier();
            _19[gl_LocalInvocationID.x] += 3u;
            break;
        }
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _54 = _71 + gl_LocalInvocationID.x;
    _13._m0[_54] = _19[_21(gl_LocalInvocationID.x + 3u, 4u)];
}

