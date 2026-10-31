#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    float _m0;
};

layout(set = 0, binding = 0, std140) uniform _11_10
{
    _4 _m0;
} _10;

layout(set = 0, binding = 1, std430) readonly buffer _14_13
{
    float _m0[];
} _13;

layout(set = 0, binding = 2, std430) buffer _17_16
{
    float _m0[];
} _16;

void main()
{
    uint _63 = 0u;
    uint _57 = 0u;
    float _51 = 0.0;
    uint _44 = 0u;
    uint _37[2] = uint[](0u, 0u);
    uint _61[2] = uint[](0u, 0u);
    uint _55 = 0u;
    uint _49 = 0u;
    uint _42[2] = uint[](0u, 0u);
    float _34 = 0.0;
    uint _65 = 0u;
    float _59 = 0.0;
    uint _53[2] = uint[](0u, 0u);
    uint _47[2] = uint[](0u, 0u);
    uint _40[2] = uint[](0u, 0u);
    _34 = _10._m0._m0;
    _37 = uint[](0u, 0u);
    _37[0u] = 0u;
    _37[1u] = 0u;
    _40 = uint[](0u, 0u);
    _40[0u] = 1u;
    _40[1u] = 0u;
    _34 *= 2.0;
    _47 = _37;
    _49 = gl_LocalInvocationID.x;
    _53 = _47;
    _53[1u] += _49;
    _55 = _53[0u];
    _57 = _53[1u];
    _59 = _13._m0[_57];
    _51 = _59;
    _42 = _40;
    _44 = gl_LocalInvocationID.x;
    _61 = _42;
    _61[1u] += _44;
    _63 = _61[0u];
    _65 = _61[1u];
    _16._m0[_65] = _51 * _34;
}

