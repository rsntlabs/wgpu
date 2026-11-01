#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _8
{
    float _m0;
};

struct _9
{
    float _m0;
    float _m1;
    float _m2;
};

struct _11
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _19_18
{
    int _m0[];
} _18;

layout(set = 0, binding = 1, std140) uniform _22_21
{
    _8 _m0;
} _21;

layout(set = 0, binding = 2, std430) readonly buffer _25_24
{
    _9 _m0[];
} _24;

layout(set = 0, binding = 3, std140) uniform _28_27
{
    _11 _m0;
} _27;

layout(set = 0, binding = 4, std430) buffer _31_30
{
    uint _m0[];
} _30;

uvec3 _13 = uvec3(0u);
uvec3 _16 = uvec3(0u);
uvec3 _17 = uvec3(0u);

uint _55(uint _54)
{
    if (_54 == 0u)
    {
        return _16.x;
    }
    if (_54 == 1u)
    {
        return _16.y;
    }
    return _16.z;
}

uint _71(uint _70)
{
    if (_70 == 0u)
    {
        return 1u;
    }
    if (_70 == 1u)
    {
        return 1u;
    }
    return 1u;
}

uint _35(uint _34)
{
    if (_34 == 0u)
    {
        return _13.x;
    }
    if (_34 == 1u)
    {
        return _13.y;
    }
    return _13.z;
}

uint _97(uint _96)
{
    return _35(_96);
}

uint _110()
{
    return (_55(0u) * _71(0u)) + _97(0u);
}

void _124()
{
    if (_17.z != 0u)
    {
        return;
    }
    else
    {
        return;
    }
}

uint _81(uint _80)
{
    if (_80 == 0u)
    {
        return _17.x;
    }
    if (_80 == 1u)
    {
        return _17.y;
    }
    return _17.z;
}

float _102(float _101)
{
    return float(_16.x) + _101;
}

uint _120(uint _119)
{
    return 11u;
}

void main()
{
    _13 = gl_LocalInvocationID;
    _16 = gl_WorkGroupID;
    _17 = gl_NumWorkGroups;
    if (_110() >= _27._m0._m0)
    {
        return;
    }
    _124();
    _30._m0[uint(0)] = _35(0u);
    _30._m0[uint(1)] = _35(1u);
    _30._m0[uint(2)] = _35(2u);
    _30._m0[uint(3)] = _55(0u);
    _30._m0[uint(4)] = _55(1u);
    _30._m0[uint(5)] = _55(2u);
    _30._m0[uint(6)] = _71(0u);
    _30._m0[uint(7)] = _71(1u);
    _30._m0[uint(8)] = _71(2u);
    _30._m0[uint(9)] = _81(0u);
    _30._m0[uint(10)] = _81(1u);
    _30._m0[uint(11)] = _81(2u);
    _30._m0[uint(12)] = _110();
    _30._m0[uint(13)] = _97(0u);
    _30._m0[uint(14)] = floatBitsToUint(_102(2.5));
    _30._m0[uint(15)] = gl_LocalInvocationID.x;
    _30._m0[uint(16)] = gl_WorkGroupID.y;
    _30._m0[uint(17)] = gl_NumWorkGroups.z;
    _30._m0[uint(18)] = 1u;
    _30._m0[uint(19)] = uint(_18._m0[uint(0)]);
    _30._m0[uint(20)] = floatBitsToUint(_21._m0._m0);
    _30._m0[uint(21)] = floatBitsToUint(_24._m0[uint(0)]._m0);
    _30._m0[uint(22)] = floatBitsToUint(_24._m0[uint(0)]._m1);
    _30._m0[uint(23)] = floatBitsToUint(_24._m0[uint(0)]._m2);
    _30._m0[uint(24)] = _27._m0._m0;
    _30._m0[uint(25)] = ((_35(0u) + _55(1u)) + _71(2u)) + _81(0u);
    _30._m0[uint(26)] = _110() + _110();
    _30._m0[uint(27)] = floatBitsToUint((float(_18._m0[uint(0)]) * _21._m0._m0) + _24._m0[uint(0)]._m0);
    _30._m0[uint(28)] = _120(gl_LocalInvocationID.x);
    _30._m0[uint(29)] = _81(2u);
}

