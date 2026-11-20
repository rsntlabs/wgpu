#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _8_7
{
    uint _m0[];
} _7;

void main()
{
    uint _85 = 0u;
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
    uint _90 = 4u + (gl_LocalInvocationID.x * 12u);
    _39 = 7;
    _42 = 32u;
    _45 = 40u;
    _47 = 56u;
    _49 = 48u;
    _51 = 20u;
    _53 = 32u;
    _55 = 56u;
    _57 = 8u;
    _59 = 16u;
    _61 = 48u;
    _63 = 76u;
    _7._m0[_90] = _42;
    _65 = _90 + 1u;
    _7._m0[_65] = _45;
    _67 = _90 + 2u;
    _7._m0[_67] = _47;
    _69 = _90 + 3u;
    _7._m0[_69] = _49;
    _71 = _90 + 4u;
    _7._m0[_71] = _51;
    _73 = _90 + 5u;
    _7._m0[_73] = _53;
    _75 = _90 + 6u;
    _7._m0[_75] = _55;
    _77 = _90 + 7u;
    _7._m0[_77] = _57;
    _79 = _90 + 8u;
    _7._m0[_79] = _59;
    _81 = _90 + 9u;
    _7._m0[_81] = _61;
    _83 = _90 + 10u;
    _7._m0[_83] = _63;
    _85 = _90 + 11u;
    _7._m0[_85] = uint(_39) + gl_LocalInvocationID.x;
}

