#version 460
layout(local_size_x = 64, local_size_y = 1, local_size_z = 1) in;

struct _8
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) buffer _15_14
{
    uint _m0[];
} _14;

layout(set = 0, binding = 1, std430) readonly buffer _18_17
{
    int _m0[];
} _17;

layout(set = 0, binding = 2, std140) uniform _21_20
{
    _8 _m0;
} _20;

shared uint _23[64];

int _29(float _26, float _27, int _28)
{
    return int(clamp((_26 * _27) + float(_28), -2147483648.0, 2147483520.0));
}

uint _39(uint _41, uint _42)
{
    return _41 % ((_42 == 0u) ? 1u : _42);
}

void main()
{
    uint _151 = 0u;
    uint _145 = 0u;
    uint _139 = 0u;
    int _133 = 0;
    int _127 = 0;
    float _121 = 0.0;
    int _115 = 0;
    uint _108 = 0u;
    int _102 = 0;
    uint _95 = 0u;
    uint _88 = 0u;
    uint _81 = 0u;
    uint _147 = 0u;
    uint _141 = 0u;
    uint _135 = 0u;
    uint _129 = 0u;
    uint _123 = 0u;
    int _117 = 0;
    bool _110 = false;
    uint _104 = 0u;
    float _97 = 0.0;
    uint _90 = 0u;
    uint _84 = 0u;
    uint _149 = 0u;
    uint _143 = 0u;
    uint _137 = 0u;
    uint _131 = 0u;
    uint _125 = 0u;
    uint _119 = 0u;
    uint _113 = 0u;
    float _106 = 0.0;
    uint _100 = 0u;
    int _92 = 0;
    uint _86 = 0u;
    uvec2 _260 = uvec2(4294967295u);
    if (gl_LocalInvocationIndex == 0u)
    {
        _23 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    }
    barrier();
    uint _169 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_169 < _20._m0._m0)
    {
        _81 = _169 * 10u;
        _84 = gl_LocalInvocationID.x;
        _23[_84] = _169 + 10u;
        _86 = _81;
        _129 = _86;
        _14._m0[_129] = _23[_84];
        _90 = _169;
        _131 = _90;
        _133 = _17._m0[_131];
        _127 = _133;
        _88 = _81 + 1u;
        _135 = _88;
        _14._m0[_135] = uint(_29(float(_127), 2.0, 1));
        int _202 = -3;
        _92 = _202;
        _95 = _81 + 2u;
        _137 = _95;
        _14._m0[_137] = uint(_92);
        _97 = 3.75;
        _100 = _81 + 3u;
        _139 = _100;
        _14._m0[_139] = uint(clamp(_97, 0.0, 4294967040.0));
        int _222 = -5;
        _102 = _222;
        _104 = _81 + 4u;
        _141 = _104;
        _14._m0[_141] = uint(_102);
        _106 = 1.25;
        _108 = _81 + 5u;
        _143 = _108;
        _14._m0[_143] = uint(clamp(_106 * 4.0, 0.0, 4294967040.0));
        _110 = _39(_169, 2u) == 0u;
        _113 = _81 + 6u;
        _145 = _113;
        _14._m0[_145] = uint(_110);
        _115 = 0;
        for (;;)
        {
            if (all(equal(uvec2(0u), _260)))
            {
                break;
            }
            _260 -= uvec2(uint(_260.y == 0u), 1u);
            if (!(_115 < 3))
            {
                break;
            }
            _117 = _115;
            _115 = _117 + 1;
            continue;
        }
        _119 = _81 + 7u;
        _147 = _119;
        _14._m0[_147] = uint(_115);
        _121 = 1.5;
        _123 = _81 + 8u;
        _149 = _123;
        _14._m0[_149] = uint(clamp(_121 * 2.0, 0.0, 4294967040.0));
        _125 = _81 + 9u;
        _151 = _125;
        _14._m0[_151] = uint(clamp(float(_20._m0._m0), 0.0, 4294967040.0));
    }
}

