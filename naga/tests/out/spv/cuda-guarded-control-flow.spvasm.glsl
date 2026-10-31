#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _11_10
{
    float _m0[];
} _10;

layout(set = 0, binding = 1, std430) readonly buffer _14_13
{
    float _m0[];
} _13;

layout(set = 0, binding = 2, std430) buffer _17_16
{
    float _m0[];
} _16;

layout(set = 0, binding = 3, std140) uniform _20_19
{
    _6 _m0;
} _19;

void main()
{
    uint _86 = 0u;
    uint _80 = 0u;
    float _74 = 0.0;
    uint _68[2] = uint[](0u, 0u);
    uint _61 = 0u;
    uint _55[2] = uint[](0u, 0u);
    uint _49 = 0u;
    uint _42[2] = uint[](0u, 0u);
    uint _84[2] = uint[](0u, 0u);
    uint _78 = 0u;
    uint _72 = 0u;
    float _66 = 0.0;
    uint _59[2] = uint[](0u, 0u);
    uint _53 = 0u;
    uint _46 = 0u;
    uint _39[2] = uint[](0u, 0u);
    uint _88 = 0u;
    float _82 = 0.0;
    uint _76[2] = uint[](0u, 0u);
    uint _70 = 0u;
    float _63 = 0.0;
    uint _57 = 0u;
    uint _51[2] = uint[](0u, 0u);
    uint _44[2] = uint[](0u, 0u);
    _39 = uint[](0u, 0u);
    _39[0u] = 0u;
    _39[1u] = 0u;
    _42 = uint[](0u, 0u);
    _42[0u] = 1u;
    _42[1u] = 0u;
    _44 = uint[](0u, 0u);
    _44[0u] = 2u;
    _44[1u] = 0u;
    _46 = _19._m0._m0;
    _49 = (gl_WorkGroupID.x * 1u) + gl_LocalInvocationID.x;
    if (_49 < _46)
    {
        _55 = _39;
        _57 = _49;
        _59 = _42;
        _61 = _49;
        _68 = _55;
        _68[1u] += _57;
        _70 = _68[0u];
        _72 = _68[1u];
        _74 = _10._m0[_72];
        _63 = _74;
        _76 = _59;
        _76[1u] += _61;
        _78 = _76[0u];
        _80 = _76[1u];
        _82 = _13._m0[_80];
        _66 = _82;
        _51 = _44;
        _53 = _49;
        _84 = _51;
        _84[1u] += _53;
        _86 = _84[0u];
        _88 = _84[1u];
        _16._m0[_88] = _63 + _66;
    }
}

