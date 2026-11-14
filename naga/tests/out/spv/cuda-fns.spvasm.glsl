#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0, std430) buffer _12_11
{
    uint _m0[];
} _11;

layout(set = 0, binding = 1, std430) readonly buffer _15_14
{
    uint _m0[];
} _14;

shared uint _17[4];

uint _23(uint _20, uint _21, int _22)
{
    int _33 = 0;
    int _36 = 0;
    uvec2 _62 = uvec2(4294967295u);
    if (_21 > 31u)
    {
        return 4294967295u;
    }
    uint _42 = _21 & 31u;
    if (_22 == 0)
    {
        return (((_20 >> _42) & 1u) != 0u) ? _21 : 4294967295u;
    }
    int _51 = (_22 > 0) ? 1 : (-1);
    _33 = int(_42);
    _36 = _22;
    for (;;)
    {
        if (all(equal(uvec2(0u), _62)))
        {
            break;
        }
        _62 -= uvec2(uint(_62.y == 0u), 1u);
        if ((_33 < 0) || (_33 > 31))
        {
            break;
        }
        uint _79 = uint(_33);
        if (((_20 >> (_79 & 31u)) & 1u) != 0u)
        {
            if (_36 == _51)
            {
                return _79;
            }
            _36 -= _51;
        }
        _33 += _51;
        continue;
    }
    return 4294967295u;
}

void main()
{
    uint _185 = 0u;
    uint _179 = 0u;
    uint _173 = 0u;
    uint _167 = 0u;
    uint _161 = 0u;
    uint _155 = 0u;
    uint _149 = 0u;
    uint _142 = 0u;
    int _136 = 0;
    uint _130 = 0u;
    uint _124 = 0u;
    uint _181 = 0u;
    uint _175 = 0u;
    uint _169 = 0u;
    uint _163 = 0u;
    uint _157 = 0u;
    uint _151 = 0u;
    bool _144 = false;
    uint _138 = 0u;
    uint _132 = 0u;
    uint _126 = 0u;
    uint _120 = 0u;
    uint _183 = 0u;
    uint _177 = 0u;
    uint _171 = 0u;
    uint _165 = 0u;
    uint _159 = 0u;
    uint _153 = 0u;
    bool _147 = false;
    uint _140 = 0u;
    uint _134 = 0u;
    uint _128 = 0u;
    uint _122 = 0u;
    uvec2 _216 = uvec2(4294967295u);
    if (gl_LocalInvocationIndex == 0u)
    {
        _17 = uint[](0u, 0u, 0u, 0u);
    }
    barrier();
    uint _198 = uint(0);
    uint _201 = _14._m0[_198];
    _17[gl_LocalInvocationID.x] = gl_LocalInvocationID.x + 1u;
    if (_23(1u, 0u, 1) == 0u)
    {
        memoryBarrierShared();
        memoryBarrierBuffer();
        barrier();
    }
    uint _117 = gl_LocalInvocationID.x;
    for (;;)
    {
        if (all(equal(uvec2(0u), _216)))
        {
            break;
        }
        _216 -= uvec2(uint(_216.y == 0u), 1u);
        if (!(_117 < _201))
        {
            break;
        }
        _120 = 1u + (_117 * 3u);
        _124 = _120;
        _173 = _124;
        _175 = _14._m0[_173];
        _167 = _175;
        _126 = _120 + 1u;
        _177 = _126;
        _179 = _14._m0[_177];
        _169 = _179;
        _128 = _120 + 2u;
        _181 = _128;
        _183 = _14._m0[_181];
        _171 = _183;
        _122 = 4u + _117;
        _185 = _122;
        _11._m0[_185] = _23(_167, _169, int(_171));
        _117 += 4u;
        continue;
    }
    uint _268 = (4u + _201) + (gl_LocalInvocationID.x * 11u);
    _130 = 1u;
    uint _269 = _130;
    _130 = _269 + uint(1);
    _132 = (_269 * 16909060u) ^ 2164195711u;
    uint _275 = _130;
    _130 = _275 + uint(1);
    _134 = (_275 * 5u) & 31u;
    uint _281 = _130;
    _130 = _281 + uint(1);
    _136 = 2 - int(_281);
    _11._m0[_268] = _23(_132, _134, _136);
    _138 = _268 + 1u;
    _11._m0[_138] = _130;
    if ((gl_LocalInvocationID.x & 1u) == 0u)
    {
        uint _298 = _130;
        _130 = _298 + uint(1);
        _140 = _23(_298, 0u, 1);
    }
    else
    {
        _140 = 0u;
    }
    _142 = _268 + 2u;
    _11._m0[_142] = _130;
    _144 = false;
    if (false)
    {
        uint _308 = _130;
        _130 = _308 + uint(1);
        _144 = _23(_308, 0u, 1) != 0u;
    }
    _147 = true;
    if (!true)
    {
        uint _315 = _130;
        _130 = _315 + uint(1);
        _147 = _23(_315, 0u, 1) != 0u;
    }
    uint _320 = _130;
    _130 = _320 + uint(1);
    _149 = _268 + 3u;
    _11._m0[_149] = _130;
    _151 = 1u;
    uint _328 = _151;
    _151 = _328 + uint(1);
    uint _333 = _151;
    _151 = _333 + uint(1);
    uint _338 = _151;
    _151 = _338 + uint(1);
    _153 = _268 + 4u;
    _11._m0[_153] = _23(_14._m0[_328], _14._m0[_333], int(_14._m0[_338]));
    _155 = _268 + 5u;
    _11._m0[_155] = _151;
    _157 = _268 + 6u;
    _11._m0[_157] = _23(2863311530u, 2u, 0);
    _159 = _268 + 7u;
    _11._m0[_159] = _23(2863311530u, 2u, 1);
    int _360 = -1;
    _161 = _268 + 8u;
    _11._m0[_161] = _23(2863311530u, 2u, _360);
    int _365 = -2147483647;
    _163 = _268 + 9u;
    _11._m0[_163] = _23(4294967295u, 31u, _365 - 1);
    _165 = _268 + 10u;
    _11._m0[_165] = _17[(gl_LocalInvocationID.x + 1u) & 3u];
}

