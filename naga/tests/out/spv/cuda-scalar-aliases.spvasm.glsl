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
    float _30 = 0.0;
    float _33 = 0.0;
    int _35 = 0;
    _30 = _25;
    _33 = _26;
    _35 = _27;
    return int(clamp((_30 * _33) + float(_35), -2147483648.0, 2147483520.0));
}

uint _49(uint _51, uint _52)
{
    return _51 % ((_52 == 0u) ? 1u : _52);
}

void main()
{
    uint _201 = 0u;
    uint _189 = 0u;
    uint _177 = 0u;
    int _165 = 0;
    uint _152 = 0u;
    uint _140 = 0u;
    uint _128 = 0u;
    uint _116 = 0u;
    uint _104 = 0u;
    uint _91 = 0u;
    uint _203 = 0u;
    int _191 = 0;
    uint _179 = 0u;
    uint _167 = 0u;
    bool _154 = false;
    uint _142 = 0u;
    float _130 = 0.0;
    uint _118 = 0u;
    uint _106 = 0u;
    uint _94 = 0u;
    uint _205 = 0u;
    uint _193 = 0u;
    uint _181 = 0u;
    uint _169 = 0u;
    uint _157 = 0u;
    uint _144 = 0u;
    uint _132 = 0u;
    uint _120 = 0u;
    uint _108 = 0u;
    uint _96 = 0u;
    uint _207 = 0u;
    uint _195 = 0u;
    uint _183 = 0u;
    uint _171 = 0u;
    uint _159 = 0u;
    float _146 = 0.0;
    uint _134 = 0u;
    int _122 = 0;
    uint _110 = 0u;
    uint _98 = 0u;
    uint _209 = 0u;
    uint _197 = 0u;
    uint _185 = 0u;
    float _173 = 0.0;
    uint _161 = 0u;
    uint _148 = 0u;
    uint _136 = 0u;
    uint _124 = 0u;
    uint _112 = 0u;
    uint _100 = 0u;
    uint _199 = 0u;
    uint _187 = 0u;
    uint _175 = 0u;
    int _163 = 0;
    uint _150 = 0u;
    int _138 = 0;
    uint _126 = 0u;
    uint _114 = 0u;
    uint _102 = 0u;
    uvec2 _355 = uvec2(4294967295u);
    if (gl_LocalInvocationIndex == 0u)
    {
        _22 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    }
    barrier();
    _91 = 0u;
    _94 = 0u;
    _96 = _19._m0._m0;
    _98 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_98 < _96)
    {
        _100 = _98 * 10u;
        _102 = gl_LocalInvocationID.x;
        _22[_102] = _98 + 10u;
        _104 = _91;
        _106 = _104;
        _108 = _100;
        _187 = _106 + _108;
        _13._m0[_187] = _22[_102];
        _116 = _94;
        _118 = _116;
        _120 = _98;
        _189 = _118 + _120;
        _191 = _16._m0[_189];
        _110 = _91;
        _112 = _110;
        _114 = _100 + 1u;
        _193 = _112 + _114;
        _13._m0[_193] = uint(_28(float(_191), 2.0, 1));
        int _276 = -3;
        _122 = _276;
        _124 = _91;
        _126 = _124;
        _128 = _100 + 2u;
        _195 = _126 + _128;
        _13._m0[_195] = uint(_122);
        _130 = 3.75;
        _132 = _91;
        _134 = _132;
        _136 = _100 + 3u;
        _197 = _134 + _136;
        _13._m0[_197] = uint(clamp(_130, 0.0, 4294967040.0));
        int _304 = -5;
        _138 = _304;
        _140 = _91;
        _142 = _140;
        _144 = _100 + 4u;
        _199 = _142 + _144;
        _13._m0[_199] = uint(_138);
        _146 = 1.25;
        _148 = _91;
        _150 = _148;
        _152 = _100 + 5u;
        _201 = _150 + _152;
        _13._m0[_201] = uint(clamp(_146 * 4.0, 0.0, 4294967040.0));
        _154 = _49(_98, 2u) == 0u;
        _157 = _91;
        _159 = _157;
        _161 = _100 + 6u;
        _203 = _159 + _161;
        _13._m0[_203] = uint(_154);
        _163 = 0;
        for (;;)
        {
            if (all(equal(uvec2(0u), _355)))
            {
                break;
            }
            _355 -= uvec2(uint(_355.y == 0u), 1u);
            if (!(_163 < 3))
            {
                break;
            }
            _165 = _163;
            _163 = _165 + 1;
            continue;
        }
        _167 = _91;
        _169 = _167;
        _171 = _100 + 7u;
        _205 = _169 + _171;
        _13._m0[_205] = uint(_163);
        _173 = 1.5;
        _175 = _91;
        _177 = _175;
        _179 = _100 + 8u;
        _207 = _177 + _179;
        _13._m0[_207] = uint(clamp(_173 * 2.0, 0.0, 4294967040.0));
        _181 = _91;
        _183 = _181;
        _185 = _100 + 9u;
        _209 = _183 + _185;
        _13._m0[_209] = uint(clamp(float(_96), 0.0, 4294967040.0));
    }
}

