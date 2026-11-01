#version 460
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

shared uint _18[64];

void _21()
{
    uint _64 = 0u;
    uint _59 = 3u;
    int _53 = 0;
    float _48 = 0.0;
    float _43 = 3.0;
    float _39 = 3.0;
    int _34 = 43;
    int _68 = 0;
    uint _62 = 0u;
    int _57 = 0;
    int _52 = 3;
    float _46 = 0.0;
    float _42 = 3.0;
    float _38 = 3.0;
    float _32 = 42.0;
    int _66 = 0;
    uint _60 = 0u;
    int _55 = 0;
    float _50 = 0.0;
    float _44 = 0.0;
    float _40 = 0.0;
    uint _36 = 44u;
    _40 = 1.0 + _32;
    _44 = 1.0 + _32;
    _46 = _32 + 2.0;
    _48 = _32 + 2.0;
    _50 = _32 + _32;
    _53 = 1 + _34;
    _55 = _34 + 2;
    _57 = _34 + _34;
    _60 = 1u + _36;
    _62 = _36 + 2u;
    _64 = _36 + _36;
    _66 = 1 << int(_36);
    _68 = 1 << int(_36);
}

void _101()
{
}

void _106()
{
    int _108 = 1 - 1;
}

void main()
{
    if (gl_LocalInvocationIndex == 0u)
    {
        _18 = uint[](0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u, 0u);
    }
    barrier();
    _21();
    _101();
    _106();
}

