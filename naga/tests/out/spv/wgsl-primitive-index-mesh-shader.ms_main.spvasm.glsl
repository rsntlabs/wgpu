#version 460
#extension GL_EXT_mesh_shader : require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(max_vertices = 3, max_primitives = 1, triangles) out;

struct _5
{
    vec4 _m0;
};

struct _6
{
    vec4 _m0;
};

struct _9
{
    uvec3 _m0;
    uint _m1;
};

struct _10
{
    uvec3 _m0;
    uint _m1;
};

struct _17
{
    _5 _m0[3];
    _9 _m1[1];
    uint _m2;
    uint _m3;
};

struct _18
{
    _6 _m0[3];
    _10 _m1[1];
    uint _m2;
    uint _m3;
};

shared _18 _19;

void _36()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _19 = _18(_6[](_6(vec4(0.0)), _6(vec4(0.0)), _6(vec4(0.0))), _10[](_10(uvec3(0u), 0u)), 0u, 0u);
    }
    barrier();
    _19._m2 = 3u;
    _19._m3 = 1u;
    _19._m0[0u]._m0 = vec4(0.0, 1.0, 0.0, 1.0);
    _19._m0[1u]._m0 = vec4(-1.0, -1.0, 0.0, 1.0);
    _19._m0[2u]._m0 = vec4(1.0, -1.0, 0.0, 1.0);
    _19._m1[0u]._m0 = uvec3(0u, 1u, 2u);
    _19._m1[0u]._m1 = 7u;
}

void main()
{
    _36();
    barrier();
    uint _79 = min(_19._m2, 3u);
    uint _82 = min(_19._m3, 1u);
    SetMeshOutputsEXT(_79, _82);
    for (uint _72 = gl_LocalInvocationIndex; _72 < _79; _72++)
    {
        gl_MeshVerticesEXT[_72].gl_Position = _19._m0[_72]._m0;
    }
    for (uint _73 = gl_LocalInvocationIndex; _73 < _82; _73++)
    {
        gl_PrimitiveTriangleIndicesEXT[_73] = _19._m1[_73]._m0;
        gl_MeshPrimitivesEXT[_73].gl_PrimitiveID = _19._m1[_73]._m1;
    }
}

