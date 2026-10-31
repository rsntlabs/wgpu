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

bool _33(int _32)
{
    return _32 >= 0;
}

float _20(float _17, float _18, int _19)
{
    float _22 = 0.0;
    _22 = _17;
    _22 *= _18;
    return _22 + float(_19);
}

int _108(int _107)
{
    if (_33(_107))
    {
        return int(clamp(_20(float(_107), 2.0, 1), -2147483648.0, 2147483520.0));
    }
    return -_107;
}

uint _38(uint _40, uint _41)
{
    return _40 % ((_41 == 0u) ? 1u : _41);
}

uint _51(uint _49, bool _50)
{
    uint _55 = 0u;
    bool _60 = false;
    uvec2 _76 = uvec2(4294967295u);
    _55 = 0u;
    uint _58 = 0u;
    for (;;)
    {
        if (all(equal(uvec2(0u), _76)))
        {
            break;
        }
        _76 -= uvec2(uint(_76.y == 0u), 1u);
        if (!(_58 < _49))
        {
            break;
        }
        _60 = _50;
        if (!_50)
        {
            _60 = _38(_58, 2u) != 0u;
        }
        if (_60)
        {
            _55 += _58;
        }
        _58++;
        continue;
    }
    return _55;
}

int _125(int _123, int _124)
{
    return (_123 * 10) + _124;
}

void main()
{
    uint _203 = 0u;
    uint _197 = 0u;
    uint _191 = 0u;
    uint _185 = 0u;
    uint _179 = 0u;
    uint _173 = 0u;
    uint _167 = 0u;
    int _160 = 0;
    uint _201 = 0u;
    uint _195 = 0u;
    uint _189 = 0u;
    uint _183 = 0u;
    uint _177 = 0u;
    uint _171 = 0u;
    uint _165 = 0u;
    uint _158 = 0u;
    uint _199 = 0u;
    uint _193 = 0u;
    uint _187 = 0u;
    uint _181 = 0u;
    uint _175 = 0u;
    uint _169 = 0u;
    int _163 = 0;
    uint _212 = (gl_WorkGroupID.x * 64u) + gl_LocalInvocationID.x;
    if (_212 < _13._m0._m0)
    {
        _158 = _212 * 10u;
        _160 = int(_212) - 35;
        _163 = 3;
        _165 = _158;
        _185 = _165;
        _10._m0[_185] = _108(_160);
        _167 = _158 + 1u;
        _187 = _167;
        _10._m0[_187] = int(clamp(_20(float(_160), 1.5, 2), -2147483648.0, 2147483520.0));
        _169 = _158 + 2u;
        _189 = _169;
        _10._m0[_189] = int(_51(uint(5), true));
        _171 = _158 + 3u;
        _191 = _171;
        _10._m0[_191] = int(_51(5u, 0 != 0));
        float _254 = float(2u);
        _173 = _158 + 4u;
        _193 = _173;
        _10._m0[_193] = int(clamp(_20(float(_160), _254, int(true)), -2147483648.0, 2147483520.0));
        _175 = _158 + 5u;
        _195 = _175;
        _10._m0[_195] = _160;
        _177 = _158 + 6u;
        _197 = _177;
        _10._m0[_197] = _108(_160) + _108(_160 + 1);
        _179 = _158 + 7u;
        _199 = _179;
        _10._m0[_199] = int(_33(_160));
        int _289 = _163;
        int _290 = _163;
        _163 = _290 + 1;
        _181 = _158 + 8u;
        _201 = _181;
        _10._m0[_201] = _125(_289, _290);
        _183 = _158 + 9u;
        _203 = _183;
        _10._m0[_203] = _163;
    }
}

