#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

struct _6
{
    int _m0;
};

layout(set = 0, binding = 0, std430) buffer _9_8
{
    int _m0[];
} _8;

layout(set = 0, binding = 1, std140) uniform _12_11
{
    _6 _m0;
} _11;

void main()
{
    uint _41 = 0u;
    int _34 = 0;
    int _39 = 0;
    uvec2 _62 = uvec2(4294967295u);
    uvec2 _94 = uvec2(4294967295u);
    uvec2 _123 = uvec2(4294967295u);
    _34 = 0;
    int _37 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _62)))
        {
            break;
        }
        _62 -= uvec2(uint(_62.y == 0u), 1u);
        if (!(_37 < _11._m0._m0))
        {
            break;
        }
        if (_37 == 2)
        {
            int _88 = _37;
            _37 = _88 + 1;
            continue;
        }
        if (_37 == 7)
        {
            break;
        }
        _34 += _37;
        int _88 = _37;
        _37 = _88 + 1;
        continue;
    }
    _39 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _94)))
        {
            break;
        }
        _94 -= uvec2(uint(_94.y == 0u), 1u);
        if (!(_39 < 3))
        {
            break;
        }
        _39++;
        if (_39 == 2)
        {
            continue;
        }
        _34 += 10;
        continue;
    }
    do
    {
        if (all(equal(uvec2(0u), _123)))
        {
            break;
        }
        _123 -= uvec2(uint(_123.y == 0u), 1u);
        _34 += 100;
        if (_34 > 200)
        {
            break;
        }
    } while (!(!(_34 < 150)));
    _41 = gl_LocalInvocationID.x;
    _8._m0[_41] = _34;
}

