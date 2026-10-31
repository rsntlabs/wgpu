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
    uint _88 = 0u;
    uint _82 = 0u;
    float _76 = 0.0;
    uint _70[2] = uint[](0u, 0u);
    uint _63 = 0u;
    uint _57[2] = uint[](0u, 0u);
    uint _51 = 0u;
    uint _44[2] = uint[](0u, 0u);
    uint _86[2] = uint[](0u, 0u);
    uint _80 = 0u;
    uint _74 = 0u;
    float _68 = 0.0;
    uint _61[2] = uint[](0u, 0u);
    uint _55 = 0u;
    uint _48 = 0u;
    uint _41[2] = uint[](0u, 0u);
    uint _90 = 0u;
    float _84 = 0.0;
    uint _78[2] = uint[](0u, 0u);
    uint _72 = 0u;
    float _65 = 0.0;
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
    _48 = _19._m0._m0;
    _51 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_51 < _48)
    {
        _57 = _41;
        _59 = _51;
        _61 = _44;
        _63 = _51;
        _70 = _61;
        _70[1u] += _63;
        _72 = _70[0u];
        _74 = _70[1u];
        _76 = _13._m0[_74];
        _65 = _76;
        _78 = _57;
        _78[1u] += _59;
        _80 = _78[0u];
        _82 = _78[1u];
        _84 = _10._m0[_82];
        _68 = _84;
        _53 = _46;
        _55 = _51;
        _86 = _53;
        _86[1u] += _55;
        _88 = _86[0u];
        _90 = _86[1u];
        _16._m0[_90] = _68 + (_65 * 2.0);
    }
}

