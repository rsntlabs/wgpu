#version 460

invariant gl_Position;

struct _5
{
    vec4 _m0;
    float _m1;
};

struct _7
{
    float _m0;
    uint _m1;
    float _m2;
};

struct _13
{
    uint _m0;
};

struct _14
{
    uint _m0;
};

layout(location = 10) in uint _21;
layout(location = 1) out float _25;

void main()
{
    gl_PointSize = 1.0;
    uint _33 = uint(gl_VertexIndex) + uint(gl_InstanceIndex);
    uint _34 = _33 + _21;
    float _35 = float(_34);
    _5 _36 = _5(vec4(1.0), _35);
    vec4 _37 = _36._m0;
    gl_Position = _37;
    _25 = _36._m1;
}

