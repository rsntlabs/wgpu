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
    uint _48 = 0u;
    uint _34 = 0u;
    uint _50 = 0u;
    int _44 = 0;
    int _37 = 0;
    uint _52 = 0u;
    uint _46 = 0u;
    int _40 = 0;
    uvec2 _72 = uvec2(4294967295u);
    uvec2 _105 = uvec2(4294967295u);
    uvec2 _134 = uvec2(4294967295u);
    _34 = 0u;
    _37 = _11._m0._m0;
    _40 = 0;
    int _42 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _72)))
        {
            break;
        }
        _72 -= uvec2(uint(_72.y == 0u), 1u);
        if (!(_42 < _37))
        {
            break;
        }
        if (_42 == 2)
        {
            int _99 = _42;
            _42 = _99 + 1;
            continue;
        }
        if (_42 == 7)
        {
            break;
        }
        _40 += _42;
        int _99 = _42;
        _42 = _99 + 1;
        continue;
    }
    _44 = 0;
    for (;;)
    {
        if (all(equal(uvec2(0u), _105)))
        {
            break;
        }
        _105 -= uvec2(uint(_105.y == 0u), 1u);
        if (!(_44 < 3))
        {
            break;
        }
        _44++;
        if (_44 == 2)
        {
            continue;
        }
        _40 += 10;
        continue;
    }
    do
    {
        if (all(equal(uvec2(0u), _134)))
        {
            break;
        }
        _134 -= uvec2(uint(_134.y == 0u), 1u);
        _40 += 100;
        if (_40 > 200)
        {
            break;
        }
    } while (!(!(_40 < 150)));
    _46 = _34;
    _48 = _46;
    _50 = gl_LocalInvocationID.x;
    _52 = _48 + _50;
    _8._m0[_52] = _40;
}

