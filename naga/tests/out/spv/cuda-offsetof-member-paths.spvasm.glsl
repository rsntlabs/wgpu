#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _8_7
{
    uint _m0[];
} _7;

void main()
{
    uint _79 = 0u;
    uint _73 = 0u;
    uint _67 = 0u;
    uint _61 = 0u;
    uint _55 = 0u;
    uint _49 = 0u;
    uint _42 = 0u;
    uint _83 = 0u;
    uint _77 = 0u;
    uint _71 = 0u;
    uint _65 = 0u;
    uint _59 = 0u;
    uint _53 = 0u;
    uint _47 = 0u;
    int _39 = 0;
    uint _81 = 0u;
    uint _75 = 0u;
    uint _69 = 0u;
    uint _63 = 0u;
    uint _57 = 0u;
    uint _51 = 0u;
    uint _45 = 0u;
    uint _88 = 4u + (gl_LocalInvocationID.x * 12u);
    _39 = 7;
    _42 = 16u;
    _45 = 32u;
    _47 = 32u;
    _49 = 40u;
    _51 = 48u;
    _53 = 64u;
    _55 = 80u;
    _57 = 56u;
    _59 = 8u;
    _61 = 40u;
    _7._m0[_88] = _42;
    _63 = _88 + 1u;
    _7._m0[_63] = _45;
    _65 = _88 + 2u;
    _7._m0[_65] = _47;
    _67 = _88 + 3u;
    _7._m0[_67] = _49;
    _69 = _88 + 4u;
    _7._m0[_69] = _51;
    _71 = _88 + 5u;
    _7._m0[_71] = _53;
    _73 = _88 + 6u;
    _7._m0[_73] = _55;
    _75 = _88 + 7u;
    _7._m0[_75] = _57;
    _77 = _88 + 8u;
    _7._m0[_77] = _59;
    _79 = _88 + 9u;
    _7._m0[_79] = _61;
    _81 = _88 + 10u;
    _7._m0[_81] = uint(_39);
    _83 = _88 + 11u;
    _7._m0[_83] = gl_LocalInvocationID.x;
}

