#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _9_8
{
    float _m0[];
} _8;

layout(set = 0, binding = 1, std430) readonly buffer _12_11
{
    float _m0[];
} _11;

layout(set = 0, binding = 2, std430) buffer _15_14
{
    float _m0[];
} _14;

layout(set = 0, binding = 3, std140) uniform _18_17
{
    _6 _m0;
} _17;

void main()
{
    uint _70 = 0u;
    uint _63 = 0u;
    uint _57 = 0u;
    uint _51 = 0u;
    uint _45 = 0u;
    uint _39 = 0u;
    uint _74 = 0u;
    float _67 = 0.0;
    uint _61 = 0u;
    uint _55 = 0u;
    uint _49 = 0u;
    uint _43 = 0u;
    uint _36 = 0u;
    float _72 = 0.0;
    uint _65 = 0u;
    uint _59 = 0u;
    uint _53 = 0u;
    uint _47 = 0u;
    uint _41 = 0u;
    _36 = 0u;
    _39 = 0u;
    _41 = 0u;
    _43 = _17._m0._m0;
    _45 = (gl_WorkGroupID.x * 1u) + gl_LocalInvocationID.x;
    if (_45 < _43)
    {
        _53 = _36;
        _55 = _53;
        _57 = _45;
        _59 = _39;
        _61 = _59;
        _63 = _45;
        _65 = _55 + _57;
        _67 = _8._m0[_65];
        _70 = _61 + _63;
        _72 = _11._m0[_70];
        _47 = _41;
        _49 = _47;
        _51 = _45;
        _74 = _49 + _51;
        _14._m0[_74] = _67 + _72;
    }
}

