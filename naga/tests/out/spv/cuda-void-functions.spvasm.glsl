#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _8
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _11_10
{
    int _m0[];
} _10;

layout(set = 0, binding = 1, std140) uniform _14_13
{
    _8 _m0;
} _13;

void _28(bool _24, int _25, uint _26, float _27)
{
    int _30 = 0;
    _30 = _25;
    _30 = int(uint(_30) + _26);
    if (_24)
    {
        return;
    }
    _30 = int(clamp(float(_30) * _27, -2147483648.0, 2147483520.0));
}

int _18(int _17)
{
    return _17 + 1;
}

uint _57(uint _59, uint _60)
{
    return _59 % ((_60 == 0u) ? 1u : _60);
}

void _50(bool _48, int _49)
{
    _28(_48, _18(_49), 2u, 0.5);
}

void main()
{
    uint _118 = 0u;
    uint _112 = 0u;
    uint _106 = 0u;
    uint _100 = 0u;
    int _94 = 0;
    uint _116 = 0u;
    uint _110 = 0u;
    uint _104 = 0u;
    uint _98 = 0u;
    uint _91 = 0u;
    uint _120 = 0u;
    uint _114 = 0u;
    uint _108 = 0u;
    int _102 = 0;
    uint _96 = 0u;
    uvec2 _182 = uvec2(4294967295u);
    uint _129 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_129 < _13._m0._m0)
    {
        _91 = _129 * 6u;
        _94 = 2;
        int _134 = _94;
        _94 = _134 + 1;
        _28(false, _134, 1u, 1.5);
        _96 = _91;
        _110 = _96;
        _10._m0[_110] = _94;
        int _143 = _94;
        _94 = _143 + 1;
        _28(true, _18(_143), 2u, 0.5);
        _98 = _91 + 1u;
        _112 = _98;
        _10._m0[_112] = _94;
        int _155 = _94;
        _94 = _155 + 1;
        _50(_57(_129, 2u) == 0u, _155);
        _100 = _91 + 2u;
        _114 = _100;
        _10._m0[_114] = _94;
        _102 = 0;
        int _166 = _94;
        _94 = _166 + 1;
        float _170 = float(1u);
        _28(0 != 0, _166, uint(0), _170);
        for (;;)
        {
            if (all(equal(uvec2(0u), _182)))
            {
                break;
            }
            _182 -= uvec2(uint(_182.y == 0u), 1u);
            if (!(_102 < 3))
            {
                break;
            }
            _102++;
            if (_102 == 1)
            {
                int _203 = _94;
                _94 = _203 + 1;
                int _205 = _94;
                _28(false, _205, 0u, 1.0);
                continue;
            }
            int _203 = _94;
            _94 = _203 + 1;
            int _205 = _94;
            _28(false, _205, 0u, 1.0);
            continue;
        }
        _104 = _91 + 3u;
        _116 = _104;
        _10._m0[_116] = _94;
        _106 = _91 + 4u;
        _118 = _106;
        _10._m0[_118] = _102;
        _108 = _91 + 5u;
        _120 = _108;
        _10._m0[_120] = _18(_94);
    }
}

