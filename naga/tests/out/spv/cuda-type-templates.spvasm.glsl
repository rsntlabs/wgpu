////////////////////////////////////////////////
// Entry point: "copy_typed<unsigned>" (comp) //
////////////////////////////////////////////////
#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _10_9
{
    uint _m0[];
} _9;

layout(set = 0, binding = 1, std430) readonly buffer _13_12
{
    uint _m0[];
} _12;

layout(set = 0, binding = 2, std140) uniform _16_15
{
    _6 _m0;
} _15;

layout(set = 0, binding = 0, std430) buffer _19_18
{
    float _m0[];
} _18;

layout(set = 0, binding = 1, std430) readonly buffer _22_21
{
    float _m0[];
} _21;

layout(set = 0, binding = 2, std140) uniform _25_24
{
    _6 _m0;
} _24;

uint _29(uint _28)
{
    return _28;
}

void main()
{
    uint _61 = 0u;
    uint _55 = 0u;
    uint _59 = 0u;
    uint _52 = 0u;
    uint _63 = 0u;
    uint _57 = 0u;
    uint _72 = (gl_WorkGroupID.x * 4u) + gl_LocalInvocationID.x;
    if (_72 < _15._m0._m0)
    {
        _55 = _72;
        _59 = _55;
        _61 = _12._m0[_59];
        _57 = _61;
        _52 = _72;
        _63 = _52;
        _9._m0[_63] = _29(_57);
    }
}


/////////////////////////////////////////////
// Entry point: "copy_typed<float>" (comp) //
/////////////////////////////////////////////
#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _10_9
{
    uint _m0[];
} _9;

layout(set = 0, binding = 1, std430) readonly buffer _13_12
{
    uint _m0[];
} _12;

layout(set = 0, binding = 2, std140) uniform _16_15
{
    _6 _m0;
} _15;

layout(set = 0, binding = 0, std430) buffer _19_18
{
    float _m0[];
} _18;

layout(set = 0, binding = 1, std430) readonly buffer _22_21
{
    float _m0[];
} _21;

layout(set = 0, binding = 2, std140) uniform _25_24
{
    _6 _m0;
} _24;

float _34(float _33)
{
    return _33;
}

void main()
{
    float _107 = 0.0;
    uint _100 = 0u;
    uint _105 = 0u;
    uint _98 = 0u;
    uint _109 = 0u;
    float _102 = 0.0;
    uint _117 = (gl_WorkGroupID.x * 4u) + gl_LocalInvocationID.x;
    if (_117 < _24._m0._m0)
    {
        _100 = _117;
        _105 = _100;
        _107 = _21._m0[_105];
        _102 = _107;
        _98 = _117;
        _109 = _98;
        _18._m0[_109] = _34(_102);
    }
}

