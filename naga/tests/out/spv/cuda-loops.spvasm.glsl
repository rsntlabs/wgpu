#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    int _m0;
};

layout(set = 0, binding = 0, std430) buffer _11_10
{
    int _m0[];
} _10;

layout(set = 0, binding = 1, std140) uniform _14_13
{
    _6 _m0;
} _13;

void main()
{
    uint _58 = 0u;
    uint _51 = 0u;
    uint _37[2] = uint[](0u, 0u);
    uint _54[2] = uint[](0u, 0u);
    int _47 = 0;
    int _40 = 0;
    uint _56 = 0u;
    uint _49[2] = uint[](0u, 0u);
    int _43 = 0;
    uvec2 _80 = uvec2(4294967295u);
    uvec2 _113 = uvec2(4294967295u);
    uvec2 _142 = uvec2(4294967295u);
    _37 = uint[](0u, 0u);
    _37[0u] = 0u;
    _37[1u] = 0u;
    _40 = _13._m0._m0;
    _43 = 0;
    int _45 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _80)))
        {
            break;
        }
        _80 -= uvec2(uint(_80.y == 0u), 1u);
        if (!(_45 < _40))
        {
            break;
        }
        if (_45 == 2)
        {
            int _107 = _45;
            _45 = _107 + 1;
            continue;
        }
        if (_45 == 7)
        {
            break;
        }
        _43 += _45;
        int _107 = _45;
        _45 = _107 + 1;
        continue;
    }
    _47 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _113)))
        {
            break;
        }
        _113 -= uvec2(uint(_113.y == 0u), 1u);
        if (!(_47 < 3))
        {
            break;
        }
        _47++;
        if (_47 == 2)
        {
            continue;
        }
        _43 += 10;
        continue;
    }
    do
    {
        if (all(equal(uvec2(0u), _142)))
        {
            break;
        }
        _142 -= uvec2(uint(_142.y == 0u), 1u);
        _43 += 100;
        if (_43 > 200)
        {
            break;
        }
    } while (!(!(_43 < 150)));
    _49 = _37;
    _51 = gl_LocalInvocationID.x;
    _54 = _49;
    _54[1u] += _51;
    _56 = _54[0u];
    _58 = _54[1u];
    _10._m0[_58] = _43;
}

