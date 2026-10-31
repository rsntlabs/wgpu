#version 460
layout(local_size_x = 2, local_size_y = 1, local_size_z = 1) in;

struct _4
{
    uint _m0;
    uint _m1;
};

layout(set = 0, binding = 0, std430) buffer _10_9
{
    uint _m0[];
} _9;

uint _14(uint _13)
{
    return _13 + 5u;
}

void main()
{
    uint _128 = 0u;
    uint _122 = 0u;
    uint _116 = 0u;
    uint _109[3] = uint[](0u, 0u, 0u);
    uint _103 = 0u;
    uint _97 = 0u;
    uint _91 = 0u;
    uint _85 = 0u;
    _4 _79 = _4(0u, 0u);
    uint _72 = 0u;
    uint _66 = 0u;
    uint _59 = 0u;
    uint _124 = 0u;
    uint _118 = 0u;
    uint _112 = 0u;
    uint _105 = 0u;
    _4 _99 = _4(0u, 0u);
    uint _93 = 0u;
    uint _87 = 0u;
    uint _81 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _62 = 0u;
    uint _126 = 0u;
    uint _120 = 0u;
    uint _114 = 0u;
    uint _107 = 0u;
    uint _101 = 0u;
    uint _95 = 0u;
    uint _89 = 0u;
    uint _83 = 0u;
    _4 _76 = _4(0u, 0u);
    uint _70 = 0u;
    uint _64 = 0u;
    if (gl_LocalInvocationID.x >= 2u)
    {
        return;
    }
    uint _135 = gl_LocalInvocationID.x * 24u;
    _59 = _135 + 0u;
    _9._m0[_59] = 7u;
    _62 = _135 + 1u;
    _9._m0[_62] = 11u;
    _64 = _135 + 2u;
    _9._m0[_64] = 22u;
    uint _146 = 3u * 4u;
    _66 = _135 + 3u;
    _9._m0[_66] = 2u + _146;
    uint _151 = 2u + 3u;
    _68 = _135 + 4u;
    _9._m0[_68] = _151;
    _72 = 2u;
    _70 = _135 + 5u;
    _9._m0[_70] = 3u << _72;
    _74 = _135 + 6u;
    _9._m0[_74] = _14(gl_LocalInvocationID.x);
    _76._m0 = gl_LocalInvocationID.x + 1u;
    _76._m1 = gl_LocalInvocationID.x + 2u;
    _79 = _76;
    _81 = _135 + 7u;
    _9._m0[_81] = _79._m0;
    _83 = _135 + 8u;
    _9._m0[_83] = _79._m1;
    _85 = 17u;
    _87 = 19u;
    _89 = 23u;
    _91 = _135 + 9u;
    _9._m0[_91] = _85;
    _93 = _135 + 10u;
    _9._m0[_93] = _87;
    _95 = _135 + 11u;
    _9._m0[_95] = _89;
    _97 = 0u;
    _97++;
    _99._m0 = _97;
    _97++;
    _99._m1 = _97;
    _101 = _135 + 12u;
    _9._m0[_101] = _99._m0;
    _103 = _135 + 13u;
    _9._m0[_103] = _99._m1;
    _105 = _135 + 14u;
    _9._m0[_105] = _97;
    _107 = _135 + 15u;
    _9._m0[_107] = 31u;
    _109[0u] = 2u;
    _109[1u] = 4u;
    _109[2u] = 6u;
    _112 = _135 + 16u;
    _9._m0[_112] = _109[gl_LocalInvocationID.x];
    _114 = 0u;
    uint _226 = _114;
    _114 = _226 + uint(1);
    _116 = _135 + 17u;
    _9._m0[_116] = _109[_226];
    _118 = _135 + 18u;
    _9._m0[_118] = _114;
    _120 = _135 + 19u;
    _9._m0[_120] = uint(true);
    _122 = _135 + 20u;
    _9._m0[_122] = 61u;
    _124 = _135 + 21u;
    _9._m0[_124] = gl_LocalInvocationID.x;
    float _248 = -0.0;
    _126 = _135 + 22u;
    _9._m0[_126] = floatBitsToUint(_248);
    _128 = _135 + 23u;
    _9._m0[_128] = 4294967295u;
}

