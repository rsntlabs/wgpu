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

struct _9
{
    uint _m0;
};

struct _10
{
    uint _m0;
};

struct _17
{
    _7 _m0[1];
    _9 _m1[1];
    uint _m2;
    uint _m3;
};

struct _18
{
    _8 _m0[1];
    _10 _m1[1];
    uint _m2;
    uint _m3;
};

struct _46
{
    uint _m0;
    uint _m1;
};

taskPayloadSharedEXT _4 _19;

uvec3 _24()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _19 = _4(0u);
    }
    barrier();
    return uvec3(1u);
}

void main()
{
    uvec3 _43 = _24();
    barrier();
    _46 _53;
    umulExtended(_43.x, _43.y, _53._m1, _53._m0);
    _46 _55;
    umulExtended(_53._m0, _43.z, _55._m1, _55._m0);
    uvec3 _68 = ((((((_55._m0 > 1024u) || (_43.x > 256u)) || (_43.y > 256u)) || (_43.z > 256u)) || (_53._m1 != 0u)) || (_55._m1 != 0u)) ? uvec3(0u) : _43;
    EmitMeshTasksEXT(_68.x, _68.y, _68.z);
}


///////////////////////////////////
// Entry point: "ms_main" (mesh) //
///////////////////////////////////
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 1, max_primitives = 1, points) out;

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

struct _9
{
    uint _m0;
};

struct _10
{
    uint _m0;
};

struct _17
{
    _7 _m0[1];
    _9 _m1[1];
    uint _m2;
    uint _m3;
};

struct _18
{
    _8 _m0[1];
    _10 _m1[1];
    uint _m2;
    uint _m3;
};

struct _46
{
    uint _m0;
    uint _m1;
};

taskPayloadSharedEXT _4 _19;
shared _18 _21;

void _83()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _21 = _18(_8[](_8(vec4(0.0))), _10[](_10(0u)), 0u, 0u);
    }
    barrier();
}

void main()
{
    _83();
    barrier();
    uint _100 = min(_21._m2, 1u);
    uint _104 = min(_21._m3, 1u);
    SetMeshOutputsEXT(_100, _104);
    for (uint _92 = gl_LocalInvocationIndex; _92 < _100; _92 += 64u)
    {
        gl_MeshVerticesEXT[_92].gl_Position = _21._m0[_92]._m0;
    }
    for (uint _93 = gl_LocalInvocationIndex; _93 < _104; _93 += 64u)
    {
        gl_PrimitivePointIndicesEXT[_93] = _21._m1[_93]._m0;
    }
}

