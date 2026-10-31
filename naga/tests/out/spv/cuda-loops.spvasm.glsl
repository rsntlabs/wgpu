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
    uint _52[2] = uint[](0u, 0u);
    int _45 = 0;
    uint _37[2] = uint[](0u, 0u);
    uint _54 = 0u;
    uint _47[2] = uint[](0u, 0u);
    int _40 = 0;
    uint _56 = 0u;
    uint _49 = 0u;
    uvec2 _78 = uvec2(4294967295u);
    uvec2 _110 = uvec2(4294967295u);
    uvec2 _139 = uvec2(4294967295u);
    _37 = uint[](0u, 0u);
    _37[0u] = 0u;
    _37[1u] = 0u;
    _40 = 0;
    int _43 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _78)))
        {
            break;
        }
        _78 -= uvec2(uint(_78.y == 0u), 1u);
        if (!(_43 < _13._m0._m0))
        {
            break;
        }
        if (_43 == 2)
        {
            int _104 = _43;
            _43 = _104 + 1;
            continue;
        }
        if (_43 == 7)
        {
            break;
        }
        _40 += _43;
        int _104 = _43;
        _43 = _104 + 1;
        continue;
    }
    _45 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _110)))
        {
            break;
        }
        _110 -= uvec2(uint(_110.y == 0u), 1u);
        if (!(_45 < 3))
        {
            break;
        }
        _45++;
        if (_45 == 2)
        {
            continue;
        }
        _40 += 10;
        continue;
    }
    do
    {
        if (all(equal(uvec2(0u), _139)))
        {
            break;
        }
        _139 -= uvec2(uint(_139.y == 0u), 1u);
        _40 += 100;
        if (_40 > 200)
        {
            break;
        }
    } while (!(!(_40 < 150)));
    _47 = _37;
    _49 = gl_LocalInvocationID.x;
    _52 = _47;
    _52[1u] += _49;
    _54 = _52[0u];
    _56 = _52[1u];
    _10._m0[_56] = _40;
}

