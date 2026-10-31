#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) readonly buffer _8_7
{
    float _m0[];
} _7;

layout(set = 0, binding = 1, std430) readonly buffer _11_10
{
    float _m0[];
} _10;

layout(set = 0, binding = 2, std430) buffer _14_13
{
    float _m0[];
} _13;

void main()
{
    uint _51 = 0u;
    float _45 = 0.0;
    float _38 = 0.0;
    uint _31 = 0u;
    uint _47 = 0u;
    float _41 = 0.0;
    uint _34 = 0u;
    float _49 = 0.0;
    uint _43 = 0u;
    uint _36 = 0u;
    uint _57 = (gl_WorkGroupID.x * 1u) + gl_LocalInvocationID.x;
    _34 = _57;
    _36 = _57;
    _43 = _36;
    _45 = _10._m0[_43];
    _38 = _45;
    _47 = _34;
    _49 = _7._m0[_47];
    _41 = _49;
    _31 = _57;
    _51 = _31;
    _13._m0[_51] = _41 + (_38 * 2.0);
}

