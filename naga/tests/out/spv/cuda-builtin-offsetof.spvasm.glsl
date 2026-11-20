#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _8_7
{
    uint _m0[];
} _7;

void main()
{
    uint _75 = 0u;
    uint _69 = 0u;
    uint _63 = 0u;
    uint _57 = 0u;
    uint _51 = 0u;
    uint _45 = 0u;
    uint _38 = 0u;
    uint _79 = 0u;
    uint _73 = 0u;
    uint _67 = 0u;
    uint _61 = 0u;
    uint _55 = 0u;
    uint _49 = 0u;
    uint _43 = 0u;
    int _35 = 0;
    uint _77 = 0u;
    uint _71 = 0u;
    uint _65 = 0u;
    uint _59 = 0u;
    uint _53 = 0u;
    uint _47 = 0u;
    uint _41 = 0u;
    uint _84 = 4u + (gl_LocalInvocationID.x * 12u);
    _35 = 7;
    _38 = 0u;
    _41 = 4u;
    _43 = 8u;
    _45 = 8u;
    _47 = 16u;
    _49 = 32u;
    _51 = 48u;
    _53 = 4u;
    _55 = 16u;
    _57 = 4u;
    _7._m0[_84] = _38;
    _59 = _84 + 1u;
    _7._m0[_59] = _41;
    _61 = _84 + 2u;
    _7._m0[_61] = _43;
    _63 = _84 + 3u;
    _7._m0[_63] = _45;
    _65 = _84 + 4u;
    _7._m0[_65] = _47;
    _67 = _84 + 5u;
    _7._m0[_67] = _49;
    _69 = _84 + 6u;
    _7._m0[_69] = _51;
    _71 = _84 + 7u;
    _7._m0[_71] = _53;
    _73 = _84 + 8u;
    _7._m0[_73] = _55;
    _75 = _84 + 9u;
    _7._m0[_75] = _57;
    _77 = _84 + 10u;
    _7._m0[_77] = uint(_35);
    _79 = _84 + 11u;
    _7._m0[_79] = gl_LocalInvocationID.x;
}

