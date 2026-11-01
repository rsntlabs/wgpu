#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _5
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _10_9
{
    uint _m0[];
} _9;

layout(set = 0, binding = 1, std430) buffer _13_12
{
    uint _m0[];
} _12;

layout(set = 0, binding = 2, std140) uniform _16_15
{
    _5 _m0;
} _15;

shared uint _18[4];

uint _20(uint _22, uint _23)
{
    return _22 % ((_23 == 0u) ? 1u : _23);
}

void main()
{
    uint _48 = 0u;
    uint _51 = 0u;
    uint _53 = 0u;
    if (gl_LocalInvocationIndex == 0u)
    {
        _18 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    uint _70 = gl_WorkGroupID.x * 4u;
    _48 = _70 + gl_LocalInvocationID.x;
    _18[gl_LocalInvocationID.x] = _9._m0[_48];
    if (_15._m0._m0 != 0u)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _51 = _18[_20(gl_LocalInvocationID.x + 1u, 4u)] + 10u;
    }
    else
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _51 = _18[_20(gl_LocalInvocationID.x + 2u, 4u)] + 20u;
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _18[gl_LocalInvocationID.x] = _51;
    switch (_20(gl_WorkGroupID.x + _15._m0._m0, 3u))
    {
        case 0u:
        {
            memoryBarrierShared();
            memoryBarrierBuffer();
            barrier();
            _18[gl_LocalInvocationID.x]++;
            break;
        }
        case 1u:
        {
            memoryBarrierShared();
            memoryBarrierBuffer();
            barrier();
            _18[gl_LocalInvocationID.x] *= 2u;
            memoryBarrierShared();
            memoryBarrierBuffer();
            barrier();
            _18[gl_LocalInvocationID.x] += 3u;
            break;
        }
        default:
        {
            memoryBarrierShared();
            memoryBarrierBuffer();
            barrier();
            _18[gl_LocalInvocationID.x] += 3u;
            break;
        }
    }
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    _53 = _70 + gl_LocalInvocationID.x;
    _12._m0[_53] = _18[_20(gl_LocalInvocationID.x + 3u, 4u)];
}

