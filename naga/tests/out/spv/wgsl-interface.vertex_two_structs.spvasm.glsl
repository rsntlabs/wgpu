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

void main()
{
    uint _32 = 2u;
    _13 _16 = _13(uint(gl_VertexIndex));
    _14 _20 = _14(uint(gl_InstanceIndex));
    gl_PointSize = 1.0;
    uint _35 = _16._m0;
    float _36 = float(_35);
    uint _37 = _20._m0;
    float _38 = float(_37);
    float _40 = float(_32);
    vec4 _41 = vec4(_36, _38, _40, 0.0);
    gl_Position = _41;
}

