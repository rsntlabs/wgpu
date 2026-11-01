#version 460

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

layout(location = 0) out vec4 _23;

void main()
{
    _23 = vec4(float(uint(gl_PrimitiveID)), 1.0, 1.0, 1.0);
}

