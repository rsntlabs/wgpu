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
    uint _111 = _108 - _109;
    _11._m0[_101] = floatBitsToUint(uintBitsToFloat((_104 != 0u) ? ((((_108 + 127u) << 23u) | (((_104 << (23u - _109)) >> _111) & 8388607u)) + uint((_104 & ((1u << _111) - 1u)) != 0u)) : 0u));
    uint _129 = _19(_104);
    uint _133 = 31u - (31u - uint(findMSB(_129 | 1u)));
    uint _134 = min(_133, 23u);
    uint _136 = _133 - _134;
    _56 = _101 + 1u;
    _11._m0[_56] = floatBitsToUint(uintBitsToFloat((_129 != 0u) ? ((((_133 + 127u) << 23u) | (((_129 << (23u - _134)) >> _136) & 8388607u)) + uint((_129 & ((1u << _136) - 1u)) != 0u)) : 0u));
    _53++;
    uint _162 = 31u - (31u - uint(findMSB(_104 | 1u)));
    uint _163 = min(_162, 23u);
    uint _165 = _162 - _163;
    _58 = _101 + 2u;
    _11._m0[_58] = floatBitsToUint(uintBitsToFloat((_104 != 0u) ? ((((_162 + 127u) << 23u) | (((_104 << (23u - _163)) >> _165) & 8388607u)) + uint((_104 & ((1u << _165) - 1u)) != 0u)) : 0u));
    _60 = _101 + 3u;
    _11._m0[_60] = _53;
    if ((_95 & 1u) != 0u)
    {
        _80 = _53;
        _53 = _80 + uint(1);
        _82 = _104;
        _64 = _82;
        uint _203 = 31u - (31u - uint(findMSB(_64 | 1u)));
        uint _204 = min(_203, 23u);
        uint _206 = _203 - _204;
        _68 = floatBitsToUint(uintBitsToFloat((_64 != 0u) ? ((((_203 + 127u) << 23u) | (((_64 << (23u - _204)) >> _206) & 8388607u)) + uint((_64 & ((1u << _206) - 1u)) != 0u)) : 0u));
    }
    else
    {
        _84 = _53;
        _53 = _84 + uint(1);
        _86 = _104;
        _66 = _86;
        uint _232 = 31u - (31u - uint(findMSB(_66 | 1u)));
        uint _233 = min(_232, 23u);
        uint _235 = _232 - _233;
        _68 = floatBitsToUint(uintBitsToFloat((_66 != 0u) ? ((((_232 + 127u) << 23u) | (((_66 << (23u - _233)) >> _235) & 8388607u)) + uint((_66 & ((1u << _235) - 1u)) != 0u)) : 0u));
    }
    _62 = _101 + 4u;
    _11._m0[_62] = _68;
    _70 = _101 + 5u;
    _11._m0[_70] = _53;
    int _260 = -1;
    uint _261 = uint(_260);
    uint _265 = 31u - (31u - uint(findMSB(_261 | 1u)));
    uint _266 = min(_265, 23u);
    uint _268 = _265 - _266;
    _72 = _101 + 6u;
    _11._m0[_72] = floatBitsToUint(uintBitsToFloat((_261 != 0u) ? ((((_265 + 127u) << 23u) | (((_261 << (23u - _266)) >> _268) & 8388607u)) + uint((_261 & ((1u << _268) - 1u)) != 0u)) : 0u));
    float _290 = clamp(3.5, 0.0, 4294967040.0);
    uint _291 = uint(_290);
    uint _295 = 31u - (31u - uint(findMSB(_291 | 1u)));
    uint _296 = min(_295, 23u);
    uint _298 = _295 - _296;
    _74 = _101 + 7u;
    _11._m0[_74] = floatBitsToUint(uintBitsToFloat((_291 != 0u) ? ((((_295 + 127u) << 23u) | (((_291 << (23u - _296)) >> _298) & 8388607u)) + uint((_291 & ((1u << _298) - 1u)) != 0u)) : 0u));
    uint _321 = 31u - (31u - uint(findMSB(_104 | 1u)));
    uint _322 = min(_321, 23u);
    _76 = _101 + 8u;
    _11._m0[_76] = floatBitsToUint(uintBitsToFloat((_104 != 0u) ? (((_321 + 127u) << 23u) | (((_104 << (23u - _322)) >> (_321 - _322)) & 8388607u)) : 0u));
    uint _341 = 31u - (31u - uint(findMSB(_104 | 1u)));
    uint _342 = min(_341, 23u);
    uint _344 = _341 - _342;
    uint _346 = (_104 << (23u - _342)) >> _344;
    uint _351 = 1u << _344;
    _78 = _101 + 9u;
    _11._m0[_78] = floatBitsToUint(uintBitsToFloat((_104 != 0u) ? ((((_341 + 127u) << 23u) | (_346 & 8388607u)) + uint((((_104 & (_351 - 1u)) << 1u) | (_346 & 1u)) > _351)) : 0u));
}

