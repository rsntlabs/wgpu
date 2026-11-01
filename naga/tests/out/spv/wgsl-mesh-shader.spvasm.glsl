///////////////////////////////////
// Entry point: "ts_main" (task) //
///////////////////////////////////
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    vec4 _m0;
    bool _m1;
};

struct _7
{
    vec4 _m0;
    vec4 _m1;
};

struct _8
{
    vec4 _m0;
    vec4 _m1;
};

struct _11
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _12
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _13
{
    vec4 _m0;
};

struct _20
{
    _7 _m0[3];
    _11 _m1[1];
    uint _m2;
    uint _m3;
};

struct _21
{
    _8 _m0[3];
    _12 _m1[1];
    uint _m2;
    uint _m3;
};

struct _73
{
    uint _m0;
    uint _m1;
};

taskPayloadSharedEXT _6 _22;
shared float _24;

void _37(bool _36)
{
    _22._m1 = _36;
}

bool _29()
{
    return _22._m1;
}

uvec3 _42()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _22 = _6(vec4(0.0), false);
        _24 = 0.0;
    }
    barrier();
    _24 = 1.0;
    _22._m0 = vec4(1.0, 1.0, 0.0, 1.0);
    _37(true);
    _22._m1 = _29();
    return uvec3(1u);
}

void main()
{
    uvec3 _70 = _42();
    barrier();
    _73 _80;
    umulExtended(_70.x, _70.y, _80._m1, _80._m0);
    _73 _82;
    umulExtended(_80._m0, _70.z, _82._m1, _82._m0);
    uvec3 _95 = ((((((_82._m0 > 1024u) || (_70.x > 256u)) || (_70.y > 256u)) || (_70.z > 256u)) || (_80._m1 != 0u)) || (_82._m1 != 0u)) ? uvec3(0u) : _70;
    EmitMeshTasksEXT(_95.x, _95.y, _95.z);
}


////////////////////////////////////////
// Entry point: "ts_divergent" (task) //
////////////////////////////////////////
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    vec4 _m0;
    bool _m1;
};

struct _7
{
    vec4 _m0;
    vec4 _m1;
};

struct _8
{
    vec4 _m0;
    vec4 _m1;
};

struct _11
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _12
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _13
{
    vec4 _m0;
};

struct _20
{
    _7 _m0[3];
    _11 _m1[1];
    uint _m2;
    uint _m3;
};

struct _21
{
    _8 _m0[3];
    _12 _m1[1];
    uint _m2;
    uint _m3;
};

struct _73
{
    uint _m0;
    uint _m1;
};

taskPayloadSharedEXT _6 _22;

uvec3 _103()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _22 = _6(vec4(0.0), false);
    }
    barrier();
    if (gl_LocalInvocationID.x == 0u)
    {
        _22._m0 = vec4(1.0, 1.0, 0.0, 1.0);
        _22._m1 = true;
        return uvec3(1u);
    }
    return uvec3(2u);
}

void main()
{
    uvec3 _120 = _103();
    barrier();
    _73 _127;
    umulExtended(_120.x, _120.y, _127._m1, _127._m0);
    _73 _129;
    umulExtended(_127._m0, _120.z, _129._m1, _129._m0);
    uvec3 _142 = ((((((_129._m0 > 1024u) || (_120.x > 256u)) || (_120.y > 256u)) || (_120.z > 256u)) || (_127._m1 != 0u)) || (_129._m1 != 0u)) ? uvec3(0u) : _120;
    EmitMeshTasksEXT(_142.x, _142.y, _142.z);
}


///////////////////////////////////
// Entry point: "ms_main" (mesh) //
///////////////////////////////////
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 3, max_primitives = 1, triangles) out;

struct _6
{
    vec4 _m0;
    bool _m1;
};

struct _7
{
    vec4 _m0;
    vec4 _m1;
};

struct _8
{
    vec4 _m0;
    vec4 _m1;
};

struct _11
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _12
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _13
{
    vec4 _m0;
};

struct _20
{
    _7 _m0[3];
    _11 _m1[1];
    uint _m2;
    uint _m3;
};

struct _21
{
    _8 _m0[3];
    _12 _m1[1];
    uint _m2;
    uint _m3;
};

struct _73
{
    uint _m0;
    uint _m1;
};

layout(location = 0) out vec4 _159[3];
layout(location = 1) perprimitiveEXT out vec4 _165[1];
taskPayloadSharedEXT _6 _22;
shared float _24;
shared _21 _26;

bool _29()
{
    return _22._m1;
}

void _166()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _24 = 0.0;
        _26 = _21(_8[](_8(vec4(0.0), vec4(0.0)), _8(vec4(0.0), vec4(0.0)), _8(vec4(0.0), vec4(0.0))), _12[](_12(uvec3(0u), false, vec4(0.0))), 0u, 0u);
    }
    barrier();
    _26._m2 = 3u;
    _26._m3 = 1u;
    _24 = 2.0;
    _26._m0[0u]._m0 = vec4(0.0, 1.0, 0.0, 1.0);
    _26._m0[0u]._m1 = vec4(0.0, 1.0, 0.0, 1.0) * _22._m0;
    _26._m0[1u]._m0 = vec4(-1.0, -1.0, 0.0, 1.0);
    _26._m0[1u]._m1 = vec4(0.0, 0.0, 1.0, 1.0) * _22._m0;
    _26._m0[2u]._m0 = vec4(1.0, -1.0, 0.0, 1.0);
    _26._m0[2u]._m1 = vec4(1.0, 0.0, 0.0, 1.0) * _22._m0;
    _26._m1[0u]._m0 = uvec3(0u, 1u, 2u);
    _26._m1[0u]._m1 = !_29();
    _26._m1[0u]._m2 = vec4(1.0, 0.0, 1.0, 1.0);
}

void main()
{
    _166();
    barrier();
    uint _221 = min(_26._m2, 3u);
    uint _224 = min(_26._m3, 1u);
    SetMeshOutputsEXT(_221, _224);
    for (uint _214 = gl_LocalInvocationIndex; _214 < _221; _214++)
    {
        gl_MeshVerticesEXT[_214].gl_Position = _26._m0[_214]._m0;
        _159[_214] = _26._m0[_214]._m1;
    }
    for (uint _215 = gl_LocalInvocationIndex; _215 < _224; _215++)
    {
        gl_PrimitiveTriangleIndicesEXT[_215] = _26._m1[_215]._m0;
        gl_MeshPrimitivesEXT[_215].gl_CullPrimitiveEXT = _26._m1[_215]._m1;
        _165[_215] = _26._m1[_215]._m2;
    }
}


////////////////////////////////////
// Entry point: "ms_no_ts" (mesh) //
////////////////////////////////////
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 3, max_primitives = 1, triangles) out;

struct _6
{
    vec4 _m0;
    bool _m1;
};

struct _7
{
    vec4 _m0;
    vec4 _m1;
};

struct _8
{
    vec4 _m0;
    vec4 _m1;
};

struct _11
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _12
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _13
{
    vec4 _m0;
};

struct _20
{
    _7 _m0[3];
    _11 _m1[1];
    uint _m2;
    uint _m3;
};

struct _21
{
    _8 _m0[3];
    _12 _m1[1];
    uint _m2;
    uint _m3;
};

struct _73
{
    uint _m0;
    uint _m1;
};

layout(location = 0) out vec4 _278[3];
layout(location = 1) perprimitiveEXT out vec4 _284[1];
shared float _24;
shared _21 _26;

void _285()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _24 = 0.0;
        _26 = _21(_8[](_8(vec4(0.0), vec4(0.0)), _8(vec4(0.0), vec4(0.0)), _8(vec4(0.0), vec4(0.0))), _12[](_12(uvec3(0u), false, vec4(0.0))), 0u, 0u);
    }
    barrier();
    _26._m2 = 3u;
    _26._m3 = 1u;
    _24 = 2.0;
    _26._m0[0u]._m0 = vec4(0.0, 1.0, 0.0, 1.0);
    _26._m0[0u]._m1 = vec4(0.0, 1.0, 0.0, 1.0);
    _26._m0[1u]._m0 = vec4(-1.0, -1.0, 0.0, 1.0);
    _26._m0[1u]._m1 = vec4(0.0, 0.0, 1.0, 1.0);
    _26._m0[2u]._m0 = vec4(1.0, -1.0, 0.0, 1.0);
    _26._m0[2u]._m1 = vec4(1.0, 0.0, 0.0, 1.0);
    _26._m1[0u]._m0 = uvec3(0u, 1u, 2u);
    _26._m1[0u]._m1 = false;
    _26._m1[0u]._m2 = vec4(1.0, 0.0, 1.0, 1.0);
}

void main()
{
    _285();
    barrier();
    uint _311 = min(_26._m2, 3u);
    uint _314 = min(_26._m3, 1u);
    SetMeshOutputsEXT(_311, _314);
    for (uint _305 = gl_LocalInvocationIndex; _305 < _311; _305++)
    {
        gl_MeshVerticesEXT[_305].gl_Position = _26._m0[_305]._m0;
        _278[_305] = _26._m0[_305]._m1;
    }
    for (uint _306 = gl_LocalInvocationIndex; _306 < _314; _306++)
    {
        gl_PrimitiveTriangleIndicesEXT[_306] = _26._m1[_306]._m0;
        gl_MeshPrimitivesEXT[_306].gl_CullPrimitiveEXT = _26._m1[_306]._m1;
        _284[_306] = _26._m1[_306]._m2;
    }
}


////////////////////////////////////////
// Entry point: "ms_divergent" (mesh) //
////////////////////////////////////////
#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 3, max_primitives = 1, triangles) out;

struct _6
{
    vec4 _m0;
    bool _m1;
};

struct _7
{
    vec4 _m0;
    vec4 _m1;
};

struct _8
{
    vec4 _m0;
    vec4 _m1;
};

struct _11
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _12
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _13
{
    vec4 _m0;
};

struct _20
{
    _7 _m0[3];
    _11 _m1[1];
    uint _m2;
    uint _m3;
};

struct _21
{
    _8 _m0[3];
    _12 _m1[1];
    uint _m2;
    uint _m3;
};

struct _73
{
    uint _m0;
    uint _m1;
};

layout(location = 0) out vec4 _367[3];
layout(location = 1) perprimitiveEXT out vec4 _373[1];
shared float _24;
shared _21 _26;

void _374()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _24 = 0.0;
        _26 = _21(_8[](_8(vec4(0.0), vec4(0.0)), _8(vec4(0.0), vec4(0.0)), _8(vec4(0.0), vec4(0.0))), _12[](_12(uvec3(0u), false, vec4(0.0))), 0u, 0u);
    }
    barrier();
    if (gl_LocalInvocationID.x == 0u)
    {
        _26._m2 = 3u;
        _26._m3 = 1u;
        _24 = 2.0;
        _26._m0[0u]._m0 = vec4(0.0, 1.0, 0.0, 1.0);
        _26._m0[0u]._m1 = vec4(0.0, 1.0, 0.0, 1.0);
        _26._m0[1u]._m0 = vec4(-1.0, -1.0, 0.0, 1.0);
        _26._m0[1u]._m1 = vec4(0.0, 0.0, 1.0, 1.0);
        _26._m0[2u]._m0 = vec4(1.0, -1.0, 0.0, 1.0);
        _26._m0[2u]._m1 = vec4(1.0, 0.0, 0.0, 1.0);
        _26._m1[0u]._m0 = uvec3(0u, 1u, 2u);
        _26._m1[0u]._m1 = false;
        _26._m1[0u]._m2 = vec4(1.0, 0.0, 1.0, 1.0);
        return;
    }
    else
    {
        return;
    }
}

void main()
{
    _374();
    barrier();
    uint _404 = min(_26._m2, 3u);
    uint _407 = min(_26._m3, 1u);
    SetMeshOutputsEXT(_404, _407);
    for (uint _398 = gl_LocalInvocationIndex; _398 < _404; _398 += 2u)
    {
        gl_MeshVerticesEXT[_398].gl_Position = _26._m0[_398]._m0;
        _367[_398] = _26._m0[_398]._m1;
    }
    for (uint _399 = gl_LocalInvocationIndex; _399 < _407; _399 += 2u)
    {
        gl_PrimitiveTriangleIndicesEXT[_399] = _26._m1[_399]._m0;
        gl_MeshPrimitivesEXT[_399].gl_CullPrimitiveEXT = _26._m1[_399]._m1;
        _373[_399] = _26._m1[_399]._m2;
    }
}


///////////////////////////////////
// Entry point: "fs_main" (frag) //
///////////////////////////////////
#version 460
#extension GL_EXT_mesh_shader : require

struct _6
{
    vec4 _m0;
    bool _m1;
};

struct _7
{
    vec4 _m0;
    vec4 _m1;
};

struct _8
{
    vec4 _m0;
    vec4 _m1;
};

struct _11
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _12
{
    uvec3 _m0;
    bool _m1;
    vec4 _m2;
};

struct _13
{
    vec4 _m0;
};

struct _20
{
    _7 _m0[3];
    _11 _m1[1];
    uint _m2;
    uint _m3;
};

struct _21
{
    _8 _m0[3];
    _12 _m1[1];
    uint _m2;
    uint _m3;
};

struct _73
{
    uint _m0;
    uint _m1;
};

layout(location = 0) in vec4 _450;
layout(location = 1) perprimitiveEXT in vec4 _453;
layout(location = 0) out vec4 _455;

void main()
{
    _455 = _7(gl_FragCoord, _450)._m1 * _13(_453)._m0;
}

