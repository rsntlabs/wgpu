/////////////////////////////////////
// Entry point: "reduce<4>" (comp) //
/////////////////////////////////////
#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _13_12
{
    uint _m0[];
} _12;

layout(set = 0, binding = 1, std430) readonly buffer _16_15
{
    uint _m0[];
} _15;

layout(set = 0, binding = 0, std430) buffer _21_20
{
    uint _m0[];
} _20;

layout(set = 0, binding = 1, std430) readonly buffer _24_23
{
    uint _m0[];
} _23;

shared uint _18[4];
shared uint _26[8];

uint _30(uint _29)
{
    return _29 + uint(4);
}

void main()
{
    uint _59 = 0u;
    uint _64 = 0u;
    uvec2 _100 = uvec2(4294967295u);
    if (gl_LocalInvocationIndex == 0u)
    {
        _18 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    uint _79 = gl_WorkGroupID.x * 4u;
    _59 = _79 + gl_LocalInvocationID.x;
    _18[gl_LocalInvocationID.x] = _15._m0[_59];
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    uint _62 = 2u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _100)))
        {
            break;
        }
        _100 -= uvec2(uint(_100.y == 0u), 1u);
        if (!(_62 > 0u))
        {
            break;
        }
        if (gl_LocalInvocationID.x < _62)
        {
            _18[gl_LocalInvocationID.x] += _18[gl_LocalInvocationID.x + _62];
        }
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _62 = _62 >> 1u;
        continue;
    }
    _64 = _79 + gl_LocalInvocationID.x;
    _12._m0[_64] = _30(_18[0u]);
}


/////////////////////////////////////
// Entry point: "reduce<8>" (comp) //
/////////////////////////////////////
#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _13_12
{
    uint _m0[];
} _12;

layout(set = 0, binding = 1, std430) readonly buffer _16_15
{
    uint _m0[];
} _15;

layout(set = 0, binding = 0, std430) buffer _21_20
{
    uint _m0[];
} _20;

layout(set = 0, binding = 1, std430) readonly buffer _24_23
{
    uint _m0[];
} _23;

shared uint _18[4];
shared uint _26[8];

uint _39(uint _38)
{
    return _38 + uint(8);
}

void main()
{
    uint _143 = 0u;
    uint _147 = 0u;
    uvec2 _171 = uvec2(4294967295u);
    if (gl_LocalInvocationIndex == 0u)
    {
        _26 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    }
    barrier();
    uint _159 = gl_WorkGroupID.x * 4u;
    _143 = _159 + gl_LocalInvocationID.x;
    _26[gl_LocalInvocationID.x] = _23._m0[_143];
    memoryBarrierShared();
    memoryBarrierBuffer();
    barrier();
    uint _145 = 2u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _171)))
        {
            break;
        }
        _171 -= uvec2(uint(_171.y == 0u), 1u);
        if (!(_145 > 0u))
        {
            break;
        }
        if (gl_LocalInvocationID.x < _145)
        {
            _26[gl_LocalInvocationID.x] += _26[gl_LocalInvocationID.x + _145];
        }
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
        _145 = _145 >> 1u;
        continue;
    }
    _147 = _159 + gl_LocalInvocationID.x;
    _20._m0[_147] = _39(_26[0u]);
}

