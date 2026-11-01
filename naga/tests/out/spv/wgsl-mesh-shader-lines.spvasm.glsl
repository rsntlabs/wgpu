///////////////////////////////////
// Entry point: "ts_main" (task) //
///////////////////////////////////
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    uint _m0;
};

struct _7
{
    vec4 _m0;
};

struct _8
{
    vec4 _m0;
};

struct _10
{
    uvec2 _m0;
};

struct _11
{
    uvec2 _m0;
};

struct _19
{
    _7 _m0[2];
    _10 _m1[1];
    uint _m2;
    uint _m3;
};

struct _20
{
    _8 _m0[2];
    _11 _m1[1];
    uint _m2;
    uint _m3;
};

struct _47
{
    uint _m0;
    uint _m1;
};

taskPayloadSharedEXT _4 _21;

uvec3 _26()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _21 = _4(0u);
    }
    barrier();
    return uvec3(1u);
}

void main()
{
    uvec3 _44 = _26();
    barrier();
    _47 _54;
    umulExtended(_44.x, _44.y, _54._m1, _54._m0);
    _47 _56;
    umulExtended(_54._m0, _44.z, _56._m1, _56._m0);
    uvec3 _69 = ((((((_56._m0 > 1024u) || (_44.x > 256u)) || (_44.y > 256u)) || (_44.z > 256u)) || (_54._m1 != 0u)) || (_56._m1 != 0u)) ? uvec3(0u) : _44;
    EmitMeshTasksEXT(_69.x, _69.y, _69.z);
}


///////////////////////////////////
// Entry point: "ms_main" (mesh) //
///////////////////////////////////
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 2, max_primitives = 1, lines) out;

struct _4
{
    uint _m0;
};

struct _7
{
    vec4 _m0;
};

struct _8
{
    vec4 _m0;
};

struct _10
{
    uvec2 _m0;
};

struct _11
{
    uvec2 _m0;
};

struct _19
{
    _7 _m0[2];
    _10 _m1[1];
    uint _m2;
    uint _m3;
};

struct _20
{
    _8 _m0[2];
    _11 _m1[1];
    uint _m2;
    uint _m3;
};

struct _47
{
    uint _m0;
    uint _m1;
};

taskPayloadSharedEXT _4 _21;
shared _20 _23;

void _84()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _23 = _20(_8[](_8(vec4(0.0)), _8(vec4(0.0))), _11[](_11(uvec2(0u))), 0u, 0u);
    }
    barrier();
}

void main()
{
    _84();
    barrier();
    uint _101 = min(_23._m2, 2u);
    uint _105 = min(_23._m3, 1u);
    SetMeshOutputsEXT(_101, _105);
    for (uint _93 = gl_LocalInvocationIndex; _93 < _101; _93 += 64u)
    {
        gl_MeshVerticesEXT[_93].gl_Position = _23._m0[_93]._m0;
    }
    for (uint _94 = gl_LocalInvocationIndex; _94 < _105; _94 += 64u)
    {
        gl_PrimitiveLineIndicesEXT[_94] = _23._m1[_94]._m0;
    }
}

