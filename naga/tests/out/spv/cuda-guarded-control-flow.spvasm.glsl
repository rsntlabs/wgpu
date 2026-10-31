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
    uint _80[2] = uint[](0u, 0u);
    uint _74 = 0u;
    uint _68 = 0u;
    float _62 = 0.0;
    uint _55[2] = uint[](0u, 0u);
    uint _48 = 0u;
    uint _42[2] = uint[](0u, 0u);
    uint _84 = 0u;
    float _78 = 0.0;
    uint _72[2] = uint[](0u, 0u);
    uint _66 = 0u;
    float _59 = 0.0;
    uint _53 = 0u;
    uint _46[2] = uint[](0u, 0u);
    uint _39[2] = uint[](0u, 0u);
    uint _82 = 0u;
    uint _76 = 0u;
    float _70 = 0.0;
    uint _64[2] = uint[](0u, 0u);
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
    uint _99 = (gl_WorkGroupID.x * 1u) + gl_LocalInvocationID.x;
    if (_99 < _19._m0._m0)
    {
        _51 = _39;
        _53 = _99;
        _55 = _42;
        _57 = _99;
        _64 = _51;
        _64[1u] += _53;
        _66 = _64[0u];
        _68 = _64[1u];
        _70 = _10._m0[_68];
        _59 = _70;
        _72 = _55;
        _72[1u] += _57;
        _74 = _72[0u];
        _76 = _72[1u];
        _78 = _13._m0[_76];
        _62 = _78;
        _46 = _44;
        _48 = _99;
        _80 = _46;
        _80[1u] += _48;
        _82 = _80[0u];
        _84 = _80[1u];
        _16._m0[_84] = _59 + _62;
    }
}

