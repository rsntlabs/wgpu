#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

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
    uint _82[2] = uint[](0u, 0u);
    uint _76 = 0u;
    uint _70 = 0u;
    float _64 = 0.0;
    uint _57[2] = uint[](0u, 0u);
    uint _50 = 0u;
    uint _44[2] = uint[](0u, 0u);
    uint _86 = 0u;
    float _80 = 0.0;
    uint _74[2] = uint[](0u, 0u);
    uint _68 = 0u;
    float _61 = 0.0;
    uint _55 = 0u;
    uint _48[2] = uint[](0u, 0u);
    uint _41[2] = uint[](0u, 0u);
    uint _84 = 0u;
    uint _78 = 0u;
    float _72 = 0.0;
    uint _66[2] = uint[](0u, 0u);
    uint _59 = 0u;
    uint _53[2] = uint[](0u, 0u);
    uint _46[2] = uint[](0u, 0u);
    _41 = uint[](0u, 0u);
    _41[0u] = 0u;
    _41[1u] = 0u;
    _44 = uint[](0u, 0u);
    _44[0u] = 1u;
    _44[1u] = 0u;
    _46 = uint[](0u, 0u);
    _46[0u] = 2u;
    _46[1u] = 0u;
    uint _101 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_101 < _19._m0._m0)
    {
        _53 = _41;
        _55 = _101;
        _57 = _44;
        _59 = _101;
        _66 = _57;
        _66[1u] += _59;
        _68 = _66[0u];
        _70 = _66[1u];
        _72 = _13._m0[_70];
        _61 = _72;
        _74 = _53;
        _74[1u] += _55;
        _76 = _74[0u];
        _78 = _74[1u];
        _80 = _10._m0[_78];
        _64 = _80;
        _48 = _46;
        _50 = _101;
        _82 = _48;
        _82[1u] += _50;
        _84 = _82[0u];
        _86 = _82[1u];
        _16._m0[_86] = _64 + (_61 * 2.0);
    }
}

