#version 460
layout(local_size_x = 4, local_size_y = 1, local_size_z = 1) in;

struct _5
{
    uint _m0;
};

layout(set = 0, binding = 0, std430) readonly buffer _9_8
{
    uint _m0[];
} _8;

layout(set = 0, binding = 1, std430) buffer _12_11
{
    uint _m0[];
} _11;

layout(set = 0, binding = 2, std140) uniform _15_14
{
    _5 _m0;
} _14;

uint _19(uint _18)
{
    return _18;
}

void main()
{
    uint _86 = 0u;
    uint _80 = 0u;
    uint _74 = 0u;
    uint _68 = 0u;
    uint _62 = 0u;
    uint _56 = 0u;
    uint _84 = 0u;
    uint _78 = 0u;
    uint _72 = 0u;
    uint _66 = 0u;
    uint _60 = 0u;
    uint _53 = 0u;
    uint _82 = 0u;
    uint _76 = 0u;
    uint _70 = 0u;
    uint _64 = 0u;
    uint _58 = 0u;
    uint _95 = gl_LocalInvocationID.x + (gl_WorkGroupID.x * 4u);
    if (_95 >= _14._m0._m0)
    {
        return;
    }
    uint _101 = 4u + (_95 * 10u);
    uint _104 = _8._m0[_95];
    _53 = 0u;
    uint _108 = 31u - (31u - uint(findMSB(_104 | 1u)));
    uint _109 = min(_108, 23u);
    _11._m0[_101] = floatBitsToUint(uintBitsToFloat((_104 != 0u) ? (((_108 + 127u) << 23u) | (((_104 << (23u - _109)) >> (_108 - _109)) & 8388607u)) : 0u));
    uint _123 = _19(_104);
    uint _127 = 31u - (31u - uint(findMSB(_123 | 1u)));
    uint _128 = min(_127, 23u);
    _56 = _101 + 1u;
    _11._m0[_56] = floatBitsToUint(uintBitsToFloat((_123 != 0u) ? (((_127 + 127u) << 23u) | (((_123 << (23u - _128)) >> (_127 - _128)) & 8388607u)) : 0u));
    _53++;
    uint _150 = 31u - (31u - uint(findMSB(_104 | 1u)));
    uint _151 = min(_150, 23u);
    _58 = _101 + 2u;
    _11._m0[_58] = floatBitsToUint(uintBitsToFloat((_104 != 0u) ? (((_150 + 127u) << 23u) | (((_104 << (23u - _151)) >> (_150 - _151)) & 8388607u)) : 0u));
    _60 = _101 + 3u;
    _11._m0[_60] = _53;
    if ((_95 & 1u) != 0u)
    {
        _80 = _53;
        _53 = _80 + uint(1);
        _82 = _104;
        _64 = _82;
        uint _185 = 31u - (31u - uint(findMSB(_64 | 1u)));
        uint _186 = min(_185, 23u);
        _68 = floatBitsToUint(uintBitsToFloat((_64 != 0u) ? (((_185 + 127u) << 23u) | (((_64 << (23u - _186)) >> (_185 - _186)) & 8388607u)) : 0u));
    }
    else
    {
        _84 = _53;
        _53 = _84 + uint(1);
        _86 = _104;
        _66 = _86;
        uint _208 = 31u - (31u - uint(findMSB(_66 | 1u)));
        uint _209 = min(_208, 23u);
        _68 = floatBitsToUint(uintBitsToFloat((_66 != 0u) ? (((_208 + 127u) << 23u) | (((_66 << (23u - _209)) >> (_208 - _209)) & 8388607u)) : 0u));
    }
    _62 = _101 + 4u;
    _11._m0[_62] = _68;
    _70 = _101 + 5u;
    _11._m0[_70] = _53;
    int _230 = -1;
    uint _231 = uint(_230);
    uint _235 = 31u - (31u - uint(findMSB(_231 | 1u)));
    uint _236 = min(_235, 23u);
    _72 = _101 + 6u;
    _11._m0[_72] = floatBitsToUint(uintBitsToFloat((_231 != 0u) ? (((_235 + 127u) << 23u) | (((_231 << (23u - _236)) >> (_235 - _236)) & 8388607u)) : 0u));
    float _254 = clamp(3.5, 0.0, 4294967040.0);
    uint _255 = uint(_254);
    uint _259 = 31u - (31u - uint(findMSB(_255 | 1u)));
    uint _260 = min(_259, 23u);
    _74 = _101 + 7u;
    _11._m0[_74] = floatBitsToUint(uintBitsToFloat((_255 != 0u) ? (((_259 + 127u) << 23u) | (((_255 << (23u - _260)) >> (_259 - _260)) & 8388607u)) : 0u));
    uint _279 = 31u - (31u - uint(findMSB(_104 | 1u)));
    uint _280 = min(_279, 23u);
    uint _282 = _279 - _280;
    _76 = _101 + 8u;
    _11._m0[_76] = floatBitsToUint(uintBitsToFloat((_104 != 0u) ? ((((_279 + 127u) << 23u) | (((_104 << (23u - _280)) >> _282) & 8388607u)) + uint((_104 & ((1u << _282) - 1u)) != 0u)) : 0u));
    uint _305 = 31u - (31u - uint(findMSB(_104 | 1u)));
    uint _306 = min(_305, 23u);
    uint _308 = _305 - _306;
    uint _310 = (_104 << (23u - _306)) >> _308;
    uint _315 = 1u << _308;
    _78 = _101 + 9u;
    _11._m0[_78] = floatBitsToUint(uintBitsToFloat((_104 != 0u) ? ((((_305 + 127u) << 23u) | (_310 & 8388607u)) + uint((((_104 & (_315 - 1u)) << 1u) | (_310 & 1u)) > _315)) : 0u));
}

