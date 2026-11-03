//////////////////////////////////////////////
// Entry point: "copy_records<Pair>" (comp) //
//////////////////////////////////////////////
#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    uint _m0;
    uint _m1;
};

struct _7
{
    _4 _m0;
    uint _m1[2];
};

struct _9
{
    uint _m0;
};

struct _11
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _14_13
{
    _7 _m0[];
} _13;

layout(set = 0, binding = 1, std430) readonly buffer _17_16
{
    _7 _m0[];
} _16;

layout(set = 0, binding = 2, std140) uniform _20_19
{
    _9 _m0;
} _19;

layout(set = 0, binding = 0, std430) buffer _23_22
{
    _4 _m0[];
} _22;

layout(set = 0, binding = 1, std430) readonly buffer _26_25
{
    _4 _m0[];
} _25;

layout(set = 0, binding = 2, std140) uniform _29_28
{
    _9 _m0;
} _28;

layout(set = 0, binding = 0, std430) buffer _32_31
{
    _7 _m0[];
} _31;

layout(set = 0, binding = 1, std430) readonly buffer _35_34
{
    _7 _m0[];
} _34;

layout(set = 0, binding = 2, std140) uniform _38_37
{
    _9 _m0;
} _37;

void main()
{
    _4 _82 = _4(0u, 0u);
    uint _76 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _84 = 0u;
    _4 _78 = _4(0u, 0u);
    uint _93 = (gl_WorkGroupID.x * 4u) + gl_LocalInvocationID.x;
    if (_93 < _28._m0._m0)
    {
        _76 = _93;
        _80 = _76;
        _82 = _25._m0[_80];
        _78 = _82;
        _74 = _93;
        _84 = _74;
        _22._m0[_84] = _78;
    }
}


///////////////////////////////////////////////////
// Entry point: "copy_records<PacketTag>" (comp) //
///////////////////////////////////////////////////
#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    uint _m0;
    uint _m1;
};

struct _7
{
    _4 _m0;
    uint _m1[2];
};

struct _9
{
    uint _m0;
};

struct _11
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _14_13
{
    _7 _m0[];
} _13;

layout(set = 0, binding = 1, std430) readonly buffer _17_16
{
    _7 _m0[];
} _16;

layout(set = 0, binding = 2, std140) uniform _20_19
{
    _9 _m0;
} _19;

layout(set = 0, binding = 0, std430) buffer _23_22
{
    _4 _m0[];
} _22;

layout(set = 0, binding = 1, std430) readonly buffer _26_25
{
    _4 _m0[];
} _25;

layout(set = 0, binding = 2, std140) uniform _29_28
{
    _9 _m0;
} _28;

layout(set = 0, binding = 0, std430) buffer _32_31
{
    _7 _m0[];
} _31;

layout(set = 0, binding = 1, std430) readonly buffer _35_34
{
    _7 _m0[];
} _34;

layout(set = 0, binding = 2, std140) uniform _38_37
{
    _9 _m0;
} _37;

void main()
{
    _7 _127 = _7(_4(0u, 0u), uint[](0u, 0u));
    uint _120 = 0u;
    uint _125 = 0u;
    uint _118 = 0u;
    uint _129 = 0u;
    _7 _122 = _7(_4(0u, 0u), uint[](0u, 0u));
    uint _137 = (gl_WorkGroupID.x * 4u) + gl_LocalInvocationID.x;
    if (_137 < _37._m0._m0)
    {
        _120 = _137;
        _125 = _120;
        _127 = _34._m0[_125];
        _122 = _127;
        _118 = _137;
        _129 = _118;
        _31._m0[_129] = _122;
    }
}


/////////////////////////////////////////////
// Entry point: "transform_records" (comp) //
/////////////////////////////////////////////
#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    uint _m0;
    uint _m1;
};

struct _7
{
    _4 _m0;
    uint _m1[2];
};

struct _9
{
    uint _m0;
};

struct _11
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _14_13
{
    _7 _m0[];
} _13;

layout(set = 0, binding = 1, std430) readonly buffer _17_16
{
    _7 _m0[];
} _16;

layout(set = 0, binding = 2, std140) uniform _20_19
{
    _9 _m0;
} _19;

layout(set = 0, binding = 0, std430) buffer _23_22
{
    _4 _m0[];
} _22;

layout(set = 0, binding = 1, std430) readonly buffer _26_25
{
    _4 _m0[];
} _25;

layout(set = 0, binding = 2, std140) uniform _29_28
{
    _9 _m0;
} _28;

layout(set = 0, binding = 0, std430) buffer _32_31
{
    _7 _m0[];
} _31;

layout(set = 0, binding = 1, std430) readonly buffer _35_34
{
    _7 _m0[];
} _34;

layout(set = 0, binding = 2, std140) uniform _38_37
{
    _9 _m0;
} _37;

_4 _42(_4 _41)
{
    _4 _44 = _4(0u, 0u);
    _4 _47 = _4(0u, 0u);
    _44 = _41;
    _47._m0 = _44._m1;
    _47._m1 = _44._m0;
    return _47;
}

void main()
{
    _7 _167 = _7(_4(0u, 0u), uint[](0u, 0u));
    _7 _171 = _7(_4(0u, 0u), uint[](0u, 0u));
    _11 _164 = _11(0u);
    _7 _169 = _7(_4(0u, 0u), uint[](0u, 0u));
    uint _179 = (gl_WorkGroupID.x * 4u) + gl_LocalInvocationID.x;
    if (_179 >= _19._m0._m0)
    {
        return;
    }
    _164._m0 = _179 + 1u;
    _171 = _16._m0[_179];
    _169 = _171;
    _167 = _169;
    _167._m0 = _42(_167._m0);
    _167._m1[0u] += _164._m0;
    _167._m1[1u] ^= 2779077210u;
    _13._m0[_179] = _167;
}

