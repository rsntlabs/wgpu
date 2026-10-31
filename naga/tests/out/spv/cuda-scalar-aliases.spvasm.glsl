#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _8
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _14_13
{
    uint _m0[];
} _13;

layout(set = 0, binding = 1, std430) readonly buffer _17_16
{
    int _m0[];
} _16;

layout(set = 0, binding = 2, std140) uniform _20_19
{
    _8 _m0;
} _19;

shared uint _22[64];

int _28(float _25, float _26, int _27)
{
    return int(clamp((_25 * _26) + float(_27), -2147483648.0, 2147483520.0));
}

uint _38(uint _40, uint _41)
{
    return _40 % ((_41 == 0u) ? 1u : _41);
}

void main()
{
    uint _150 = 0u;
    uint _144 = 0u;
    uint _138 = 0u;
    int _132 = 0;
    int _126 = 0;
    float _120 = 0.0;
    int _114 = 0;
    uint _107 = 0u;
    int _101 = 0;
    uint _94 = 0u;
    uint _87 = 0u;
    uint _80 = 0u;
    uint _146 = 0u;
    uint _140 = 0u;
    uint _134 = 0u;
    uint _128 = 0u;
    uint _122 = 0u;
    int _116 = 0;
    bool _109 = false;
    uint _103 = 0u;
    float _96 = 0.0;
    uint _89 = 0u;
    uint _83 = 0u;
    uint _148 = 0u;
    uint _142 = 0u;
    uint _136 = 0u;
    uint _130 = 0u;
    uint _124 = 0u;
    uint _118 = 0u;
    uint _112 = 0u;
    float _105 = 0.0;
    uint _99 = 0u;
    int _91 = 0;
    uint _85 = 0u;
    uvec2 _259 = uvec2(4294967295u);
    if (gl_LocalInvocationIndex == 0u)
    {
        _22 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    }
    barrier();
    uint _168 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_168 < _19._m0._m0)
    {
        _80 = _168 * 10u;
        _83 = gl_LocalInvocationID.x;
        _22[_83] = _168 + 10u;
        _85 = _80;
        _128 = _85;
        _13._m0[_128] = _22[_83];
        _89 = _168;
        _130 = _89;
        _132 = _16._m0[_130];
        _126 = _132;
        _87 = _80 + 1u;
        _134 = _87;
        _13._m0[_134] = uint(_28(float(_126), 2.0, 1));
        int _201 = -3;
        _91 = _201;
        _94 = _80 + 2u;
        _136 = _94;
        _13._m0[_136] = uint(_91);
        _96 = 3.75;
        _99 = _80 + 3u;
        _138 = _99;
        _13._m0[_138] = uint(clamp(_96, 0.0, 4294967040.0));
        int _221 = -5;
        _101 = _221;
        _103 = _80 + 4u;
        _140 = _103;
        _13._m0[_140] = uint(_101);
        _105 = 1.25;
        _107 = _80 + 5u;
        _142 = _107;
        _13._m0[_142] = uint(clamp(_105 * 4.0, 0.0, 4294967040.0));
        _109 = _38(_168, 2u) == 0u;
        _112 = _80 + 6u;
        _144 = _112;
        _13._m0[_144] = uint(_109);
        _114 = 0;
        for (;;)
        {
            if (all(equal(uvec2(0u), _259)))
            {
                break;
            }
            _259 -= uvec2(uint(_259.y == 0u), 1u);
            if (!(_114 < 3))
            {
                break;
            }
            _116 = _114;
            _114 = _116 + 1;
            continue;
        }
        _118 = _80 + 7u;
        _146 = _118;
        _13._m0[_146] = uint(_114);
        _120 = 1.5;
        _122 = _80 + 8u;
        _148 = _122;
        _13._m0[_148] = uint(clamp(_120 * 2.0, 0.0, 4294967040.0));
        _124 = _80 + 9u;
        _150 = _124;
        _13._m0[_150] = uint(clamp(float(_19._m0._m0), 0.0, 4294967040.0));
    }
}

